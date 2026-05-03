---
title: "Building a Dream-Job Radar, Part 2: The Build"
subtitle: "The pipeline works. Here's what I actually shipped."
date: 2026-05-02
draft: false
tags: ["data-engineering", "geospatial", "motherduck", "duckdb", "cloudflare-r2", "dlt"]
series: ["dream-job-radar"]
series_order: 2
summary: |
  The follow-up to Part 1. I built the dream-job radar — a small
  dlt pipeline that watches a hand-picked list of outdoor, geospatial,
  and forestry companies for new roles, writes Parquet to Cloudflare R2,
  and surfaces everything in a MotherDuck Dive I check on my phone.
  Here's how it works, what changed from the original plan, and what
  I deliberately left naive.
---

## Code

Open source: [github.com/Doctacon/dream-job-radar](https://github.com/Doctacon/dream-job-radar)

## What changed from the plan

In [Part 1]({{< ref "building-a-dream-job-radar" >}}) I said I'd build a dlt pipeline that hits the Greenhouse API for a curated list of companies, ships results to S3, and surfaces them in a MotherDuck Dive embedded right here on the site. I also flagged that MotherDuck's pricing might be a problem for a solo person tracking job postings.

Here's what actually happened.

**Greenhouse wasn't enough, of course.** The companies I care about don't all use Greenhouse. Some use Ashby. One uses Rippling. A few have hand-rolled WordPress careers pages with no API at all. So the "small dlt pipeline" became six different extractor modules, one per source kind. 

**S3 became Cloudflare R2.** Same interface (S3-compatible), but R2 has no egress fees. That matters because MotherDuck reads the Parquet files from the bucket every time someone opens the Dive. S3 would charge me for that traffic. R2 charges nothing.

**The MotherDuck pricing concern stopped mattering once I dropped the embed requirement.** A standalone Dive runs on the free tier just fine — queries my data, renders in a browser, costs zero dollars. Embedding it on this site is what would've pushed me toward the paid plan, and I decided I didn't actually care whether the Dive lived inside loughondata.com or at its own URL. I check it on my phone once a day, usually on my walk, which is exactly the use case I designed for. The bookmark works.

Everything else from the original plan held up. dlt handles ingestion. GitHub Actions runs the cron. The output is a webpage I can check without thinking. The pipeline caught a role this week I would've missed. That was the whole point.

## Ground rules

Before writing code I wrote down a small constitution. Sounds dramatic for a weekend project but it did more for velocity than any amount of architecture. I use my friend [z3z1ma](https://github.com/z3z1ma)'s `agent-loom` repository as a harness for Claude Code and I gotta say, great work, man!  

**Free and programmatic only.** If a company doesn't expose a public, unauthenticated endpoint or a scrape-friendly careers page, they get dropped. No paid API tiers, no LinkedIn alerts, no fighting anti-bot.

**Open source first.** Already a personal principle. The whole thing runs on dlt, DuckDB, MotherDuck, Cloudflare R2, and GitHub Actions — all either open or with generous free tiers.

**Curated companies, not crawled internet.** Adding a company is one config edit. The radar's value comes from the short list, not from heuristic discovery.

**The radar is public. Applications are private.** You can see what the radar catches. You can't see what I do about it.

## The stack

```
public job board / careers page
        │  (HTTP GET, dlt resource per source)
        ▼
Cloudflare R2 (Parquet, hive-partitioned by date)
        │  (read_parquet glob)
        ▼
MotherDuck view  (current_open_roles)
        │  (useSQLQuery from a Dive)
        ▼
Mobile-friendly Dive page
```

Daily cron pushes new rows in at the top. The Dive at the bottom re-queries MotherDuck every time I refresh the page.

## Six source kinds

You'd think every company would have one of three standard ATS providers. They don't.

**Greenhouse** — clean public REST API. onX, Planet Labs, Floodbase, BlastPoint, Overstory. This is the good stuff and it's what I expected the whole project to look like.

**Ashby** — also a clean public REST API. Mapbox and Pano AI.

**Rippling** — the cleanest source in the whole project. Kalkomey (parent of HuntStand and HuntWise) uses it. Their endpoint returns a flat JSON list of `{uuid, name, department, url, workLocation}`. 

**Polymer** — this is the interesting one. Upstream Tech uses a small ATS called Polymer that doesn't expose a list endpoint, but each per-role page carries a Schema.org `JobPosting` JSON-LD block. So the extractor scrapes the parent careers page to get role IDs, then fetches each role page and pulls the structured data out. Any small-ATS site that ships JSON-LD on per-role pages is one config entry away from being supported.

**Sitemap** — `sitemap.xml` lists role URLs, per-URL page exposes JSON-LD. GoHunt falls into this one.

**Page-monitor** — the messiest category. Hand-maintained HTML, per-site regex parser. Felt, Regrid, Wherobots. Each one has its own DOM structure and its own parser. The cost is all in the fragility: a Webflow re-skin can break the regex silently, returning zero matches even when humans see the page fine. The pipeline logs `[page:<slug>] parsed N role(s)` so I can spot a break, but it's not great. Better detection is a future problem.

## Hive partitioning

I started with a flat layout. It worked. Then I started wanting partition-pruned queries, and also started writing this blog post, and felt a little embarrassed. So I migrated to hive-partitioned paths:

```
raw/<source_kind>/<ats_slug>/year=YYYY/month=MM/day=DD/<load_id>.<file_id>.parquet
```

DuckDB recognizes the `key=value` segments automatically — read the glob with `hive_partitioning=true` and `year`, `month`, `day` show up as queryable columns. WHERE filters on those columns skip files at the read layer.

dlt makes this one config line:

```python
filesystem(
    bucket_url=f"s3://{bucket}/raw",
    layout="{table_name}/year={YYYY}/month={MM}/day={DD}/{load_id}.{file_id}.{ext}",
)
```

One thing I learned the hard way: DuckDB's `hive_partitioning=true` is strict. Mixing flat paths and hive paths under the same glob errors out with "Hive partition mismatch." It won't gracefully NULL out partition columns for files that don't have them. The fix was an in-place backfill of every historical file to the hive layout via `s3.copy_object` + `delete`. Cheap at MB-scale. Would be a real migration at GB-scale. Glad I did it while the dataset was tiny.

## The view

`current_open_roles` is a single SQL view that cleans up the six source kinds into one queryable shape:

```sql
CREATE OR REPLACE VIEW current_open_roles AS
WITH raw AS (
  SELECT
    company, source_kind, ats_slug, role_id, title, url, location,
    TRY_CAST(posted_at AS TIMESTAMP WITH TIME ZONE) AS posted_at,
    fetched_at
  FROM read_parquet(
    'r2://${R2_BUCKET}/raw/*/*/**/*.parquet',
    filename = true,
    union_by_name = true,
    hive_partitioning = true
  )
  WHERE filename NOT LIKE '%/_dlt_%'
    AND source_kind IS NOT NULL
    AND ats_slug IS NOT NULL
    AND role_id IS NOT NULL
    AND make_date(year, CAST(month AS INTEGER), CAST(day AS INTEGER))
        >= current_date - INTERVAL 30 DAY
)
SELECT
  company, source_kind, ats_slug, role_id, title, url, location,
  posted_at, fetched_at,
  MIN(fetched_at) OVER (PARTITION BY source_kind, ats_slug, role_id)
    AS first_seen_at,
  MAX(fetched_at) OVER (PARTITION BY source_kind, ats_slug, role_id)
    AS last_seen_at
FROM raw
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY source_kind, ats_slug, role_id
  ORDER BY fetched_at DESC
) = 1;
```

## The cron

Single GitHub Actions workflow. Each source kind is its own step with `continue-on-error: true` — if one source goes down, the rest keep going. The view-apply step runs with `if: always()` because the DDL is idempotent. A health-check step at the end queries the raw zone and fails the job if any slug's most recent observation is older than 36 hours.

That's the line of defense against silent parser breakage. The parser stops returning matches, Parquet stops being written, the freshness check fires, GitHub emails me. It's not Slack-grade alerting. It's enough.

## The Dive

Small React component, `useSQLQuery` from `@motherduck/react-sql-query`. Four-KPI summary bar (open roles, companies, locations, rows shown) and a roles list with links straight to the apply page.

## What I left naive

**The company list is hardcoded.** Adding one is a config edit. There's no UI, no database.

**The keyword filter is a substring match.** `data | engineer | gis | geospatial`, lowercase, in the title. No embeddings, no LLM scoring. A "Database Administrator" would false-positive on `data`. A "Cartography Lead" would false-negative on everything. Both are loud enough to spot by eye on a one-screen Dive.

**Full-refresh, not incremental.** Every cron firing pulls every role from every source. At my scale — tens of MB, ~500 daily requests — this is irrelevant. At ten times the scale it'd still be irrelevant.

**No Iceberg. No DuckLake.** The view sits on plain Parquet and the window function handles "which observation is current." I have ACID in exactly one place (the `CREATE OR REPLACE VIEW` is atomic) and nowhere else.

Every one of these has a clean upgrade path. None of them need it yet.

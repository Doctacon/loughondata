Status: recorded
Created: 2026-07-14
Updated: 2026-07-14
Relates-To: .10x/tickets/done/2026-07-12-homepage-visual-rhythm.md, .10x/specs/contractor-site-v1.md, .10x/specs/visual-system-v1.md

# Homepage visual-rhythm validation

## What was observed

Hugo `v0.160.1+extended` built 155 pages after the homepage visual-rhythm changes. The tracked `public/` output matched a separately generated temporary build after applying the repository’s documented trailing-whitespace normalization to generated HTML, XML, and JSON.

Rendered `/index.html` assertions confirmed:

- exactly one H1;
- the semantic reliability-flow ordered list in approved source order: Sources, Ingestion, Models, Quality & Operations, Trusted Decisions;
- the four numbered service-card labels: Platform Assessment, Pipeline Buildout, Warehouse & Modeling, and Data Reliability;
- the Databox panel heading, meaningful DAG-image alternative text, `/projects/databox/` link, and compact eBird/NOAA/USGS → shared spatial grain → DuckDB warehouse flow;
- no emitted `/work/` route; and
- no Google Fonts reference in the rendered home page.

`git diff --check` passed, no staged files were present, and `themes/blowfish` had no modifications.

## Procedure

1. Ran `hugo --cleanDestinationDir` to refresh the tracked output.
2. Mechanically stripped trailing whitespace only from generated `public/**/*.html`, `public/**/*.xml`, and `public/**/*.json` files.
3. Built Hugo to temporary output, applied the same generated-text normalization, and compared it recursively with `public/` while excluding `.DS_Store`.
4. Ran Python standard-library assertions against temporary `/index.html` for heading count, map/card/panel content, image alt text, Databox link, route absence, and font dependency.
5. Ran `git diff --check`, `git diff --cached --quiet`, and `git -C themes/blowfish status --short`.

## What this supports

This supports implementation-ticket acceptance criteria 1–6 at the generated-output level: semantic component order, service-card composition, source-supported Databox proof, required canonical route preservation, generated-output synchronization, and dependency/submodule hygiene.

## Limits

No browser executable was available for real-device 320px overflow measurement, visual composition assessment, or keyboard traversal. Source/CSS uses `minmax(0, ...)` grid tracks and static semantic markup, but this evidence does not replace a browser pass. Independent review remains required before ticket closure.

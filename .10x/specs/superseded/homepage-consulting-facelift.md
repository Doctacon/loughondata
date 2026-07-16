Status: superseded
Created: 2026-07-12
Updated: 2026-07-14

# Homepage consulting facelift

> Superseded 2026-07-14 by `.10x/specs/contractor-site-v1.md` after explicit user direction. This draft’s fractional-data-engineer and Harness-credibility contract MUST NOT govern current site behavior.

## Purpose and scope

This draft defines the first-pass homepage direction for repositioning `loughondata.com` from a personal technical blog into the public business home for **Lough on Data**, Connor Lough's contracting practice operated through Quire LLC.

The homepage should persuade data leaders that Connor is a credible fractional data engineer and make it easy to start a conversation by email.

This draft covers homepage message, section order, copy direction, and CTA behavior. It does not yet cover full visual design, page templates, navigation changes, legal/footer wording, or implementation details.

## Ratified positioning inputs

Source: `.10x/knowledge/site-positioning.md`

- Primary audience: data leaders — founders, heads of data, operators, and technical decision-makers who can hire a contractor for data platform work.
- Primary conversion: email contact, not scheduling-first.
- Lead offer: fractional data engineer.
- Harness proof: high-level only, avoiding internal system names, sensitive metrics, Slack app details, or security-sensitive specifics.
- First service cluster: pipelines, warehouses, transformations, orchestration, data quality, and analytical warehouse foundations.
- Tone: personal/operator — reflective, practical, and grounded in lived project experience, not generic agency marketing.
- CTA pattern: direct email links with a short prompt about what to include in the first message.

## Homepage structure

### 1. Hero

Goal: immediately state the consulting offer and who it is for.

Draft copy:

> **Fractional data engineering for teams that need useful data systems now.**
>
> I help data leaders build and repair the pipelines, warehouses, transformations, and lightweight data products that make a company easier to run — without adding full-time headcount before the work is clear.
>
> **Email Connor** → `mailto:connor@loughondata.com`

CTA helper text:

> Tell me what is broken, what decision the data is supposed to support, and what timeline you are working against.

### 2. What I help with

Goal: make the services concrete without turning the page into a generic agency menu.

Draft section intro:

> Most data problems are not solved by buying another platform. They are solved by making the flow of data boring enough to trust.

Draft cards / bullets:

#### Pipelines and warehouses

> Ingestion, modeling, orchestration, and data quality for teams that need reliable source-to-reporting paths. I am comfortable in the messy middle: APIs, incremental loads, schema drift, dbt/SQLMesh-style transformations, DuckDB/MotherDuck, and warehouse-backed analytics.

#### Analytics systems people actually use

> Metrics layers, internal reporting workflows, data dictionaries, and small applications that help teams answer repeat questions without turning every request into a meeting.

#### Pragmatic AI on company data

> Retrieval, warehouse chat, Slack-facing workflows, and agent-assisted tools where the useful part is not the demo — it is getting the right context, controls, and failure modes around the model.

#### Geospatial and public data

> Spatial data pipelines, public datasets, and map-adjacent analysis for problems where location, boundaries, terrain, or environmental context matter.

### 3. When to bring me in

Goal: help visitors self-qualify.

Draft copy:

> I am most useful when the work is important enough to need senior judgment, but not yet shaped enough to justify a permanent hire or a large implementation team.

Draft bullets:

- You have dashboards people do not trust and nobody wants to own the upstream mess.
- You need a pipeline, warehouse, or transformation layer built cleanly enough that your team can maintain it.
- You are evaluating DuckDB, MotherDuck, dlt, SQLMesh, Dagster, or a lighter-weight alternative to a big-platform data stack.
- You have an internal data product or AI workflow that needs to become useful, governed, and boring.
- You need someone who can move between product questions, SQL, Python, orchestration, and operational tradeoffs.

### 4. Proof / credibility

Goal: establish trust without overclaiming or exposing confidential Harness detail.

Draft copy:

> Before contracting, I worked as a data engineer at Harness, where my day-to-day work included maintaining a large set of production data pipelines, building transformations in SQLMesh, collaborating with security and platform teams, and turning warehouse data into internal tools people could use directly.
>
> Outside of work, I build and write about small, practical data systems: DuckDB and MotherDuck projects, dlt pipelines, geospatial experiments, RAG prototypes, and local-first tools that solve real annoyances.

Suggested proof links/cards:

- Databox project page: cross-domain DuckDB/MotherDuck data platform.
- Local Data Stack posts: dlt / S3-compatible storage / MotherDuck direction.
- Getting Agents To Use The Damn Index: applied context/RAG/agent thinking.
- From Map Tiles To Trail Masks: geospatial computer-vision learning in public.

### 5. Featured project: Databox

Goal: give the strongest consulting-style artifact a homepage spotlight.

Draft copy:

> **Databox** is the kind of data system I like building: small enough to understand, complete enough to trust. It ingests public APIs, models them into a shared analytical grain, runs quality checks, and keeps the whole stack portable between local DuckDB and MotherDuck.
>
> It exists to answer a real question — whether bird distributions shift with same-day weather and streamflow anomalies — but the platform around it is the transferable part.

CTA:

> Read the Databox project → `/projects/databox/`

### 6. Writing as evidence

Goal: preserve the blog as proof, not the primary homepage identity.

Draft copy:

> I write to leave receipts: what I tried, what broke, what worked, and what I would do differently next time.

Suggested recent/featured categories:

- Data engineering
- DuckDB / MotherDuck
- Geospatial
- AI / RAG / agents
- Data Vault / modeling

CTA:

> Read the writing → `/posts/`

### 7. Final contact CTA

Goal: provide a low-friction close.

Draft copy:

> If your data stack is becoming important faster than it is becoming reliable, send me a note.
>
> The useful first email is short: what you are trying to make possible, what is currently in the way, what stack you are working with, and whether this is urgent, exploratory, or already funded.
>
> **Email Connor** → `mailto:connor@loughondata.com`

## Acceptance criteria for the eventual homepage implementation

- The homepage MUST identify Lough on Data as Connor Lough's public contracting business.
- The homepage MUST lead with fractional data engineering for data leaders.
- The homepage MUST make email the primary CTA.
- The homepage MUST keep the tone personal/operator rather than generic agency marketing.
- The homepage MUST feature pipelines/warehouses as the first service cluster.
- The homepage MUST use Harness only as high-level credibility and MUST avoid sensitive/internal detail.
- The homepage SHOULD preserve writing and projects as proof, not as the primary identity of the homepage.
- The homepage SHOULD feature Databox as a strong project proof point.
- The homepage SHOULD give visitors a clear prompt for what to include in the first email.

## Open points before implementation

- Whether to add a standalone Services page now or keep the first iteration homepage-only.
- Whether to add a standalone Contact page or rely on homepage/about mailto CTAs.
- Whether and where to mention Quire LLC as the legal entity.
- Whether to keep the current Blowfish profile homepage layout or replace it with a more custom homepage layout.

Status: done
Created: 2026-07-12
Updated: 2026-07-14
Parent: None
Depends-On: .10x/specs/contractor-site-v1.md, .10x/specs/visual-system-v1.md

# Add visual rhythm to the contractor homepage

## Scope

Replace the homepage’s post-hero single-prose presentation with the approved layered visual composition. This ticket owns only the home page and any narrowly reusable project-owned styles/partials required for it.

Implement:

- a semantic, static reliability-flow map: **sources → ingestion → models → quality and operations → trusted decisions**;
- four visibly numbered service cards for Platform Assessment, Pipeline Buildout, Warehouse & Modeling, and Data Reliability;
- a large Databox architecture panel using the existing `content/projects/databox/dagster-databox.png` artifact, concise source-supported callouts, and a Work/Databox link; and
- a compact Databox map: **eBird, NOAA, and USGS → shared spatial grain → DuckDB warehouse**.

The new components must break up the text rhythm while retaining the active forest visual system, dark-first/light-ready behavior, semantic reading order, and the existing email conversion path.

## Explicit exclusions

- New pages, routes, legal/copy-positioning changes, project claims, statistics, metrics, testimonials, animations, interactive diagrams, charts, dashboards, new images, font assets, or external dependencies.
- Changes to the Blowfish submodule, Services/Work/About structure, navigation, or the existing public Work/Databox source content.

## Acceptance criteria

1. The home page contains the approved reliability flow in semantic source order and remains understandable without visual connectors.
2. The four services render as visually distinct cards with visible numeric identifiers and source-supported short descriptions; they do not render as a single prose paragraph.
3. The Databox proof panel displays the existing public DAG image at a useful artifact scale, includes only source-supported architecture callouts, renders the approved compact data flow, and links to `/projects/databox/` or `/projects/`.
4. The page has clear visual rhythm at narrow and wide widths without horizontal scrolling, loss of reading order, inaccessible controls, or essential motion.
5. No remote font, asset, or dependency is introduced; no Blowfish submodule files are changed.
6. Tracked `public/` is synchronized with the changed Hugo source using the documented normalization procedure in `.10x/knowledge/hugo-tracked-public-output.md`.
7. A temporary Hugo build, rendered home-page assertions, diff hygiene check, and independent review are recorded as evidence before closure.

## Evidence expectations

- Record the rendered source order, map/card/panel presence, image alt text, route link, dark/light markup, narrow-layout check, and generated-output comparison.
- Create a review record covering scope, source-claim boundaries, semantics, responsiveness, and regressions.

## References

- `.10x/specs/contractor-site-v1.md`
- `.10x/specs/visual-system-v1.md`
- `.10x/knowledge/hugo-tracked-public-output.md`
- `content/_index.md`
- `content/projects/databox/index.md`
- `content/projects/databox/dagster-databox.png`
- `layouts/partials/home/profile.html`
- `assets/css/custom.css`

## Blockers

None. Component behavior, evidence boundaries, image source, and visual direction are governed by the active specifications.

## Progress and notes

- 2026-07-12: Ticket opened after explicit implementation authorization; not yet executed.
- 2026-07-14: Replaced the post-hero prose-only home structure with semantic reliability flow, numbered service cards, and an existing-Databox-DAG proof panel plus compact data flow. Synced tracked `public/` through the documented normalized-build procedure. Hugo build, source/rendered assertions, generated-output comparison, diff hygiene, staged-file, and Blowfish-submodule checks passed. Evidence: `.10x/evidence/2026-07-14-homepage-visual-rhythm-validation.md`.
- 2026-07-14: Independent correctness review found the map, numbered cards, Databox panel, source boundaries, generated output, and route preservation satisfactory. Initial accessibility review exposed inherited zoom and mobile-navigation interaction defects; those were remediated by the follow-up ticket `.10x/tickets/done/2026-07-12-accessible-navigation-and-images.md`. Browser/device layout verification remains an evidence limit.
- 2026-07-14: Follow-up interaction rereview passed. The final home composition remains semantic, source-supported, responsive by static inspection, and free of image zoom or modal mobile-navigation behavior. Ticket complete.

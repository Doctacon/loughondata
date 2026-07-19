Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Relates-To: .10x/tickets/2026-07-12-write-databox-rufous-technical-case-study.md, .10x/research/2026-07-12-databox-evolution-since-july-6.md

# Databox-to-Rufous case-study validation

## What was observed

- New article: `content/posts/databox-rufous-warehouse/index.md`.
- Hugo rendered it at `public/posts/databox-rufous-warehouse/index.html` with title, description, canonical URL, publication date `2026-07-15`, and seven tags.
- `hugo --cleanDestinationDir` succeeded and built 160 pages.

## Material claim map

| Article claim | Evidence source |
| --- | --- |
| One Quack server owns local DuckDB while `parallel_refresh` dlt clients overlap; SQLMesh waits for required source success. AVONET is a pinned file-snapshot exception outside shared parallel refresh. | `/Users/crlough/Code/personal/databox/.10x/specs/parallel-quack-local-refresh.md`; `/Users/crlough/Code/personal/databox/docs/source-layout.md`; commit `441bb36` |
| Databox’s semantic workflow is schema → taxonomy → ontology → CDM → SQLMesh. | `/Users/crlough/Code/personal/databox/docs/source-layout.md`; skill instructions under `/Users/crlough/Code/personal/databox/.pi/skills/` |
| Raw tables must be modeled or explicitly excluded, then trace into ontology/CDM/SQLMesh business tables. | `/Users/crlough/Code/personal/databox/docs/source-layout.md` |
| Rufous is a reference consumer; its product scope includes catalog, Watch, trip/calendar, and Field Map work. | `/Users/crlough/Code/personal/databox/README.md`; `.10x/tickets/done/2026-07-11-evolve-product-into-rufous.md`; `.10x/tickets/done/2026-07-11-build-rufous-field-map-ui.md` |
| Subsequent seven-registered-source registry/CI hardening culminated in the stated verification counts. | `/Users/crlough/Code/personal/databox/.10x/tickets/done/2026-07-12-unify-dlt-source-contract-and-ci.md` |

## Procedure

1. Read `.10x/research/2026-07-12-databox-evolution-since-july-6.md` and its cited Databox source records/docs.
2. Wrote the article around the approved causal argument, explicitly limiting claims about Rufous to reference-consumer/product-surface evidence.
3. Applied review corrections: publication date moved to 2026-07-15; Quack diagrams qualified to parallel-refresh sources; AVONET's pinned file-snapshot exception added; registry wording changed to registered sources; and Rufous-to-hardening causation softened to subsequent hardening.
4. Ran `hugo --cleanDestinationDir`.
5. Inspected the generated article metadata and rendered title/description in `public/posts/databox-rufous-warehouse/index.html`.

## What this supports

The post renders successfully and its material technical claims have a traceable source map. It does not use private trip, recipient, credential, or location data.

## Limits

A successful static build does not verify prose quality or every external GitHub link at publication time. The article intentionally presents the 871-test verification total as a recorded final verification result rather than as a performance benchmark.

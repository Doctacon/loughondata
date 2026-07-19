Status: done
Created: 2026-07-12
Updated: 2026-07-12

# Databox evolution since 2026-07-06

## Question

What happened in Databox after 2026-07-06, and what evidence supports an article explaining how parallel local ingestion and a semantics-first modeling workflow enabled the Rufous birding application?

## Sources and methods

- Inspected `git log --since=2026-07-06` in `/Users/crlough/Code/personal/databox`.
- Read `/Users/crlough/Code/personal/databox/README.md`.
- Read `/Users/crlough/Code/personal/databox/.10x/specs/parallel-quack-local-refresh.md`.
- Read `/Users/crlough/Code/personal/databox/docs/source-layout.md`.
- Read the operational instructions for `annotate-sources`, `create-ontology`, `generate-cdm`, and `create-transformation` under `/Users/crlough/Code/personal/databox/.pi/skills/`.
- Read Databox parent records for the Rufous evolution and source-contract/CI work:
  - `.10x/tickets/done/2026-07-11-evolve-product-into-rufous.md`
  - `.10x/tickets/done/2026-07-12-unify-dlt-source-contract-and-ci.md`
  - `.10x/tickets/done/2026-07-15-repair-source-contract-enforcement.md`
  - `.10x/tickets/done/2026-07-11-build-rufous-field-map-ui.md`

## Findings

### Parallel local ingestion

Commit `441bb36` (2026-07-06) introduced Quack. By 2026-07-09, the active parallel-refresh specification required one Quack server to own the local DuckDB warehouse while each registered dlt source ran as an isolated concurrent client. SQLMesh runs only after all required source loads succeed. The contract explicitly requires overlapping source work, isolated dlt state, source-scoped raw schemas, cleanup, and failure attribution.

### Semantic modeling workflow

Databox formalized the sequence from raw dlt schema to business model in its repository workflow:

1. `annotate-sources` exports local dlt schema to DBML and maps source tables to confirmed business concepts.
2. `create-ontology` turns confirmed concepts, natural keys, and relationships into a business entity graph.
3. `generate-cdm` turns that graph into a Kimball-style canonical data model with explicit facts, dimensions, grains, and key strategy.
4. `create-transformation` creates SQLMesh models from the reviewed CDM rather than adding dlt transformation scripts.

`docs/source-layout.md` says every registered raw table must be modeled or explicitly excluded, modeled concepts must reach ontology and CDM, modeled tables must produce SQLMesh dependencies into CDM-declared models, and every source must contribute at least one business table.

### Rufous as reference consumer

The 2026-07-10–11 work evolved a local birding catalog into Rufous: Arizona bird profiles with curated media, Watch-only prospective collection, trip-planning calendar invitations, and a field-device identity. The Field Map consumes local data through a zero-third-party-request MapLibre surface with a synchronized accessible list. The README calls Rufous a reference consumer of the warehouse rather than its core purpose.

### Reliability work after product pressure

The 2026-07-12–15 source-contract initiative made the Python source registry canonical for seven sources, derived CI matrix coverage from it, enforced raw-table modeling completeness, and added parity/contract checks. Final verification reported 871 tests at 87.82% coverage, 60 offline source tests, 60 isolated source tests, 145 focused contract tests, and 7/7 live contract/matrix checks, along with static, docs, privacy, integrity, and protected-state gates.

## Conclusion

The article should make a causal—not merely chronological—argument: Quack makes a local multi-source warehouse practical to refresh; the schema → taxonomy → ontology → CDM → SQLMesh workflow ensures the resulting warehouse is about stable domain concepts rather than provider-shaped tables; Rufous becomes possible as a product surface because those concepts and transformations already exist. Source-contract hardening is supporting evidence that the workflow scaled beyond a demo.

## Limits

Do not claim that every Rufous capability is directly generated from the semantic workflow. The records establish Rufous as a reference consumer and establish the modeled warehouse contract; individual UI/product features also have their own application work. The article should distinguish warehouse-enabled product capabilities from the independent frontend/product decisions.

Status: done
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/specs/contractor-site-v1.md

# Refresh Databox as a forkable warehouse scaffold

## Scope

Rewrite `/projects/databox/` to reflect the current Databox repository. Lead with a local-first, forkable data-warehouse scaffold for technical evaluators, not a bird/weather-only platform.

Include sections for architecture, source-to-model workflow (schema → annotation → ontology → Kimball CDM → SQLMesh), reference-source pattern, and Rufous as a reference consumer. Keep the supplied Dagster lineage image and source-supported links.

## Explicit exclusions

No new product behavior, unverified claims, external dependencies, route changes, source-repository changes, or Blowfish edits.

## Acceptance criteria

1. Page accurately reflects current `../databox/README.md` and relevant docs.
2. The scaffold/platform is the lead story; bird/weather/USGS is reference implementation evidence.
3. Source-to-model workflow, reference sources, Rufous role, and lineage image are clear.
4. Hugo build, generated public output, source-claim review, and diff hygiene pass.

## References

- `.10x/specs/contractor-site-v1.md`
- `/Users/crlough/Code/personal/databox/README.md`
- `/Users/crlough/Code/personal/databox/docs/source-layout.md`
- `/Users/crlough/Code/personal/databox/docs/template.md`
- `content/projects/databox/index.md`

## Blockers

None. Positioning and proof hierarchy are user-ratified and source-backed.

## Progress and notes

- 2026-07-12: Ticket opened after explicit implementation authorization; not yet executed.
- 2026-07-12: Rewrote the Databox page from the current repository README, source-layout convention, and template guide. It now leads with the local-first forkable scaffold, retains the lineage image, describes the source-to-model workflow and reference-source pattern, and identifies Rufous as a reference consumer. Hugo build, generated content assertions, output normalization, diff hygiene, and submodule check passed. Evidence: `.10x/evidence/2026-07-12-databox-page-refresh-validation.md`.

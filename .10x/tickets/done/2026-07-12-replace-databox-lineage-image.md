Status: done
Created: 2026-07-12
Updated: 2026-07-15
Parent: None
Depends-On: .10x/specs/contractor-site-v1.md

# Replace the Databox architecture image with asset lineage

## Scope

Replace the current Databox DAG image used on the homepage architecture panel and Databox project page with the supplied local image:

`Screenshot 2026-07-15 at 11.19.25.png`

Move/copy it into the Databox page bundle under a descriptive stable filename, update the relevant Hugo template/content references, and use accurate accessible text describing the Dagster global asset-lineage view: ingestion assets feed derived analytics/environmental-observation assets and then `birding_agent`.

## Explicit exclusions

- Editing the screenshot content, changing Databox claims/copy beyond image caption/alt text, replacing other project images, routes, styles, dependencies, or Blowfish files.

## Acceptance criteria

1. Homepage and `/projects/databox/` use the supplied Dagster asset-lineage screenshot, not the prior Databox image.
2. The screenshot is a local Databox page resource with meaningful descriptive alt text and/or caption.
3. No root-level screenshot copy remains after relocation.
4. Tracked `public/` is synchronized; temporary Hugo build, rendered image-reference checks, diff hygiene, and submodule cleanliness pass.

## References

- `.10x/specs/contractor-site-v1.md`
- `Screenshot 2026-07-15 at 11.19.25.png`
- `content/projects/databox/`
- `layouts/partials/home/profile.html`
- `content/projects/databox/index.md`

## Blockers

None. The user explicitly selected this image.

## Progress and notes

- 2026-07-12: Ticket opened; not yet executed.
- 2026-07-15: Moved the supplied screenshot to `content/projects/databox/dagster-asset-lineage.png`, removed the prior DAG resource, updated homepage and Databox page references plus descriptive alt/caption text, and regenerated tracked output. Temporary-build comparison, rendered-reference assertions, root-file absence, diff hygiene, and submodule check passed. Evidence: `.10x/evidence/2026-07-15-databox-lineage-image-validation.md`.

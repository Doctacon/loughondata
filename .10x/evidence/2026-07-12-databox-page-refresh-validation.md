Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Relates-To: .10x/tickets/2026-07-12-refresh-databox-page.md, .10x/specs/contractor-site-v1.md

# Databox page refresh validation

## What was observed

`content/projects/databox/index.md` now presents Databox as a local-first, forkable warehouse scaffold for technical evaluators. It distinguishes its eBird/NOAA/USGS references from the scaffold itself, describes the documented source-to-model workflow, identifies Rufous as a reference consumer, and retains the supplied Dagster asset-lineage image.

A Hugo build generated `public/projects/databox/index.html`. The rendered page contained the scaffold summary, `From source to model`, `Rufous`, and `dagster-asset-lineage.png`.

## Procedure

1. Read `/Users/crlough/Code/personal/databox/README.md`, `docs/source-layout.md`, and `docs/template.md`.
2. Rewrite only `content/projects/databox/index.md` from those sources.
3. Run `hugo --cleanDestinationDir`.
4. Apply the repository’s documented text-only trailing-whitespace normalization to generated HTML, XML, and JSON.
5. Assert required rendered phrases/image reference, run `git diff --check`, and confirm the Blowfish submodule has no changes.

## What this supports

The page’s new scaffold-first hierarchy, source-to-model workflow, reference-source role, Rufous role, image retention, and generated output are supported by the referenced current Databox repository documentation.

## Limits

This validates rendered content and build output, not interactive browser appearance or external-link availability.

Status: recorded
Created: 2026-07-15
Updated: 2026-07-15
Relates-To: .10x/tickets/done/2026-07-12-replace-databox-lineage-image.md

# Databox asset-lineage image validation

## What was observed

The supplied root screenshot was moved to `content/projects/databox/dagster-asset-lineage.png`. The prior `dagster-databox.png` page resource was removed. Homepage and Databox project-page output now reference the asset-lineage image with the same descriptive alternative text; neither rendered page references the old filename.

## Procedure

1. Ran `hugo --cleanDestinationDir` and normalized generated HTML/XML/JSON trailing whitespace per `.10x/knowledge/hugo-tracked-public-output.md`.
2. Built Hugo to a temporary destination, applied the same text-only normalization, and compared it to tracked `public/` excluding `.DS_Store`.
3. Asserted both rendered pages contain the new asset filename and descriptive alt text, omit the old filename, the root screenshot is absent, the new page resource exists, the old resource is absent, `git diff --check` passes, and the Blowfish submodule is clean.

## What this supports

All image-replacement ticket acceptance criteria at generated-output level.

## Limits

This verifies rendered references and text, not visual interpretation in a browser.

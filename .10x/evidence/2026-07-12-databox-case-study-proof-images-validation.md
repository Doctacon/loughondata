Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Relates-To: .10x/tickets/2026-07-12-add-databox-case-study-proof-images.md

# Databox case-study proof-image validation

## What was observed

- `content/posts/databox-rufous-warehouse/index.md` now contains two semantic figures with captions.
- The Quack section uses `/projects/databox/dagster-asset-lineage.png`, the existing published output of `content/projects/databox/dagster-asset-lineage.png`; the image was not copied into the article bundle.
- Its alternative text identifies the named ingestion assets and their derived analytics, environmental-observation, and birding-analysis outputs. Its caption identifies inspectable lineage from public-source ingestion to derived work.
- The Rufous section uses the article-local `rufous-acorn.png` resource. Its alternative text identifies the Arizona Birds catalog’s selected Acorn Woodpecker, representative photo, modeled traits, observation count, and call; its caption identifies Rufous as a reference consumer without asserting the warehouse generated its UI.
- The figure markup has no `data-zoom-src`, anchor/lightbox wrapper, or interactive controls.

## Procedure

1. Built Hugo into `/tmp/loughondata-proof-images` with `hugo --destination /tmp/loughondata-proof-images`.
2. Confirmed the built article includes both image paths.
3. Captured the desktop article at 1440px with local headless Chrome: `/tmp/databox-proof-images-desktop.png`.
4. Captured the mobile article at 390px with local headless Chrome: `/tmp/databox-proof-images-mobile.png`.
5. Inspected the rendered Dagster and Rufous figures plus the semantic-workflow layout; both figures remain within the runner with no horizontal page overflow.

## What this supports

The article has one inspectable architecture image and one concrete Rufous product image, both with meaningful text alternatives and captions. The Dagster resource remains owned by the Databox project page bundle.

## Limits

The local captures prove rendered containment at representative desktop and mobile widths. This validation does not prove external image-link availability outside the local build.

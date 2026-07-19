Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Relates-To: .10x/tickets/2026-07-12-make-semantic-workflow-diagram-horizontal.md

# Horizontal semantic-workflow diagram validation

## What was observed

- The semantic-workflow Mermaid block in `content/posts/databox-rufous-warehouse/index.md` now begins with `flowchart LR`.
- The Quack/AVONET Mermaid block remains the preceding top-to-bottom diagram and was not modified.
- The semantic diagram retains its original node order and `accTitle` / `accDescr` metadata.
- `hugo --cleanDestinationDir` completed successfully and built 160 pages.
- Local Chrome rendered the article at a 1440px viewport without horizontal page overflow; the article still uses the local Mermaid bundle.
- The retained semantic-diagram crop shows the rendered SVG nodes progressing left-to-right in source order: Observed dlt schema → annotate-sources / reviewed taxonomy → create-ontology / entity graph → generate-cdm / Kimball-style CDM → create-transformation → SQLMesh business models → Rufous reference consumer.
- Retained crop: `.10x/evidence/.storage/2026-07-12-databox-case-study-semantic-mermaid-horizontal-1440.png`.

## Procedure

1. Changed only `flowchart TB` to `flowchart LR` in the semantic workflow block.
2. Stopped the local Hugo preview before the clean build, then ran `hugo --cleanDestinationDir`.
3. Restarted the preview and captured `/posts/databox-rufous-warehouse/` with local headless Chrome at 1440px width after Mermaid initialization.
4. Inspected the generated article and full-page capture, then retained a crop of the semantic Mermaid section at `.10x/evidence/.storage/2026-07-12-databox-case-study-semantic-mermaid-horizontal-1440.png`.
5. Verified the rendered crop’s node positions visually: each successive workflow node appears to the right of its predecessor, with arrows connecting the sequence left-to-right.

## What this supports

The requested semantic workflow now reads left-to-right while the unrelated Quack/AVONET diagram stays vertical. The existing local Mermaid, accessibility, and article-column rendering behavior remains in place.

## Limits

The retained crop covers the 1440px article-column rendering in local Chromium. It does not independently validate every viewport width or browser engine, and the focused change has not had independent review.

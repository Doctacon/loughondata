Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Relates-To: .10x/tickets/2026-07-12-add-mermaid-diagrams-to-databox-case-study.md

# Databox case-study Mermaid validation

## What was observed

- `content/posts/databox-rufous-warehouse/index.md` contains exactly two `mermaid` shortcodes.
- The refresh diagram distinguishes `parallel_refresh` dlt clients feeding one Quack-owned local DuckDB, required-load success/failure routing, and the separate AVONET pinned-file refresh/atomic-publication path.
- The semantic diagram depicts observed dlt schema → annotation/taxonomy → ontology → CDM → transformation → SQLMesh business models → Rufous reference consumer.
- Each Mermaid source includes `accTitle` and `accDescr`. Rendered SVGs contain the corresponding `<title>` and `<desc>` values, giving each diagram a programmatic name and description.
- The generated article contains two Mermaid `<pre>` blocks and one local fingerprinted `mermaid.bundle.*.js` asset; no remote Mermaid URL appears.
- Hugo built 160 pages with `hugo --cleanDestinationDir`.
- Local headless Chrome captures at 1440×3000 rendered both diagrams inside the article’s readable runner without horizontal overflow in dark and light appearance modes.
- Retained captures: `.10x/evidence/.storage/2026-07-12-databox-case-study-mermaid-dark-1440.png` and `.10x/evidence/.storage/2026-07-12-databox-case-study-mermaid-light-1440.png`.
- The first implementation used dense left-to-right graphs. It was simplified to two top-to-bottom flowcharts: one shared parallel-refresh path plus separate AVONET path, and one vertical semantic workflow. The resulting labels are legible at the article-column width in both captures.

## Procedure

1. Inspected `themes/blowfish/layouts/shortcodes/mermaid.html` and `themes/blowfish/layouts/partials/vendor.html` to confirm page-scoped local Mermaid bundle behavior.
2. Added the two approved shortcodes to the article.
3. Ran `hugo --cleanDestinationDir`.
4. Inspected `public/posts/databox-rufous-warehouse/index.html` for Mermaid blocks and the fingerprinted local bundle.
5. Captured `http://127.0.0.1:1313/posts/databox-rufous-warehouse/` with local headless Chrome at 1440×3000 after a four-second virtual-time budget in dark and light appearances. Light appearance was set through the existing `appearance` local-storage preference before reload, and both full-page PNGs were retained under `.10x/evidence/.storage/`.
6. Inspected the rendered SVGs through Chrome DevTools Protocol. Both include Mermaid-generated `<title>`/`<desc>` values sourced from the new `accTitle`/`accDescr` metadata; their horizontal bounds remain within the 1440px viewport.

## What this supports

The case study uses the existing local Mermaid capability to divide its two densest technical sections into source-backed diagrams. The simplified diagrams are page-local and render within the article column in both dark and light appearances.

## Limits

The captures cover the 1440px desktop article column; they do not independently validate every viewport width or browser engine.

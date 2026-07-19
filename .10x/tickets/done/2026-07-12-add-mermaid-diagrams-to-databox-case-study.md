Status: done
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/tickets/done/2026-07-12-write-databox-rufous-technical-case-study.md

# Add Mermaid diagrams to the Databox-to-Rufous case study

## Scope

Add two local Mermaid diagrams to `content/posts/databox-rufous-warehouse/index.md` using the existing Blowfish Mermaid shortcode:

1. **Parallel refresh boundary** after the Quack discussion: parallel-refresh dlt source clients connect to one Quack-owned local DuckDB; SQLMesh follows only successful required loads; AVONET is visibly labeled as an independent pinned-file path, not a parallel-refresh client.
2. **Semantic warehouse path** after the modeling discussion: observed dlt schema → annotation/taxonomy → ontology → Kimball CDM → SQLMesh business models → Rufous reference consumer.

## Exclusions

- No remote Mermaid/CDN dependency, diagram image assets, or new diagramming library.
- No third diagram, feature catalog, or change to article claims.

## Acceptance criteria

1. Both diagrams accurately match the article’s source-backed technical claims and AVONET exception.
2. The article uses the theme’s local Mermaid shortcode, resulting in local Mermaid assets only.
3. Diagrams render in the built article in both dark and light appearance modes without overflowing the reading column.
4. Hugo build succeeds and the rendered article still loads its Mermaid bundle only for this post.

## Evidence expectations

Record source-to-diagram mapping, Hugo output, and dark/light rendered checks.

## Blockers

None. User requested Mermaid diagrams to break up the case study’s prose.

## Progress and notes

- 2026-07-12: Existing Blowfish Mermaid shortcode and local bundle support were inspected; it is activated per-page by the shortcode.
- 2026-07-12: Added exactly two Mermaid shortcodes: the Quack/parallel-refresh diagram with AVONET’s independent path, and the schema-to-Rufous semantic workflow. `hugo --cleanDestinationDir` built 160 pages; generated markup contains two Mermaid blocks and one local fingerprinted bundle. Dark headless-Chrome capture at 1440×3000 renders both inside the article runner. Evidence: `.10x/evidence/2026-07-12-databox-case-study-mermaid-validation.md`.
- 2026-07-12: Replaced dense left-to-right graphs with readable top-to-bottom flows. Captured the simplified diagrams in both dark and light appearance at the article-column width; neither overflows.
- 2026-07-12: Added Mermaid `accTitle`/`accDescr` metadata to both diagrams. Chrome DevTools inspection confirmed corresponding rendered SVG `<title>`/`<desc>` values. Retained dark/light captures at `.10x/evidence/.storage/2026-07-12-databox-case-study-mermaid-{dark,light}-1440.png`; updated evidence: `.10x/evidence/2026-07-12-databox-case-study-mermaid-validation.md`.
- 2026-07-12: Independent re-review passed. Review: `.10x/reviews/2026-07-12-databox-case-study-mermaid.md`.

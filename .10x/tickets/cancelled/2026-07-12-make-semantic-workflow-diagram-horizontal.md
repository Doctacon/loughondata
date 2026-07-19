Status: cancelled
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/tickets/done/2026-07-12-add-mermaid-diagrams-to-databox-case-study.md

# Make the semantic workflow diagram horizontal

## Scope

Change only the schema-to-Rufous Mermaid diagram in `content/posts/databox-rufous-warehouse/index.md` from top-to-bottom to left-to-right. Preserve its reviewed nodes, sequencing, accessible title/description, local Mermaid behavior, and readable article-column rendering.

## Acceptance criteria

1. The semantic workflow reads left-to-right from observed dlt schema through Rufous.
2. The Quack/AVONET diagram remains unchanged.
3. The generated diagram retains Mermaid accessibility metadata and renders without horizontal page overflow.
4. Hugo build and rendered inspection pass.

## Blockers

None. User directly specified the direction from the rendered screenshot.

## Progress and notes

- 2026-07-12: User supplied a screenshot showing the semantic workflow vertically stacked and requested a left-to-right reading order.
- 2026-07-12: Superseded by `.10x/tickets/2026-07-12-give-semantic-workflow-diagram-full-runner-width.md`, which preserved the requested desktop left-to-right flow while adding the required full-runner stage and mobile fallback.
- 2026-07-12: Changed only the semantic Mermaid declaration from `flowchart TB` to `flowchart LR`; the Quack/AVONET diagram and accessibility metadata are unchanged. `hugo --cleanDestinationDir` built 160 pages and local Chrome inspection found no horizontal page overflow. Evidence: `.10x/evidence/2026-07-12-databox-case-study-mermaid-horizontal-validation.md`.

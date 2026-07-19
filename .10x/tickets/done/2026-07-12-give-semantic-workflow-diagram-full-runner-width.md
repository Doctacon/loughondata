Status: done
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/tickets/2026-07-12-make-semantic-workflow-diagram-horizontal.md

# Give the horizontal semantic workflow diagram full runner width

## Scope

Keep the semantic workflow as a left-to-right Mermaid diagram, but render it in a dedicated full-runner-width stage on eligible desktop layouts rather than the narrow article reading measure. Preserve readable node labels and the reviewed semantic sequence. On narrow layouts, use a readable stacked fallback rather than shrinking the horizontal diagram into illegibility.

## Acceptance criteria

1. At desktop article width, the semantic workflow spans the readable glass runner width and remains a legible left-to-right sequence.
2. The article body copy retains its existing narrow reading measure.
3. At narrow/mobile widths, the workflow uses a legible stacked fallback with no horizontal page overflow.
4. Accessibility title/description, local Mermaid behavior, and the unrelated Quack diagram remain intact.
5. Retained desktop and mobile render captures prove legibility and overflow behavior.

## Exclusions

- No change to the diagram’s source-backed nodes or the Quack/AVONET diagram.
- No remote dependency, raster diagram, or broad article-layout redesign.

## Blockers

None. User observed that a left-to-right diagram constrained to the prose measure became too small to read.

## Progress and notes

- 2026-07-12: User requested the semantic diagram span the page left-to-right, then reported the narrow-column LR version was super small.
- 2026-07-12: Verified the dedicated 1152px desktop LR stage in local headless Chrome at 1440px. Its seven nodes progress left-to-right and stay fully within the 1440px document. Verified the 390px mobile-emulated TB fallback has `scrollWidth == clientWidth == 390`; retained definitive crops and evidence at `.10x/evidence/2026-07-12-databox-semantic-workflow-full-runner-validation.md`.

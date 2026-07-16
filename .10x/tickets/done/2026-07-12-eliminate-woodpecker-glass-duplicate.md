Status: done
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/tickets/done/2026-07-12-render-woodpecker-through-glass-runner.md

# Eliminate duplicate woodpecker at the glass boundary

## Scope

Correct the through-glass layering overlap: the crisp root flight and filtered runner flight are simultaneously visible near the runner, making the bird appear doubled.

Mask or clip the crisp root flight out of the runner’s horizontal interval while retaining it in both outer gutters. The filtered runner copy MUST be the only bird visible during the center crossing. The final perched bird remains a single crisp landscape bird.

## Acceptance criteria

1. At every flight point, exactly one visually rendered bird is present: crisp in a gutter or filtered within the runner.
2. The crossing remains continuous with no visible disappearance, jump, or double image.
3. The final perch, responsive scenery anchor, fixed-scroll behavior, reduced motion, and no-horizontal-scroll behavior remain intact.
4. Headless Chrome screenshots/DOM checks cover right gutter, runner, left gutter, perch, and reduced motion; `hugo --cleanDestinationDir` passes.

## Exclusions

- No changes to sprites, scenery positioning, flight path, runner opacity, content, or theme source.

## Evidence expectations

Record viewport geometry and visual state at every phase, including a check that the crisp and filtered flight layers do not paint simultaneously.

## Blockers

None. User directly observed the duplicate during normal flight.

## Progress and notes

- 2026-07-12: User observed two visible flight copies before the single bird lands; the root/gutter and glass layers must be mutually exclusive.
- 2026-07-12: Masked the crisp root layer over the runner interval and corrected the filtered copy to use runner-relative x coordinates. Hugo build and local headless Chrome checks at 2000×1100 and 3440×1440 confirm single-region paint, fixed perch scrolling, static reduced motion, and no horizontal overflow. Evidence: `.10x/evidence/2026-07-12-woodpecker-duplicate-layer-validation.md`.
- 2026-07-12: Independent review passed. Review: `.10x/reviews/2026-07-12-woodpecker-duplicate-layer.md`.

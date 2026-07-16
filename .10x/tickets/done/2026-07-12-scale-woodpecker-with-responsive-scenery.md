Status: done
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/tickets/2026-07-12-show-static-woodpecker-on-interior-pages.md

# Scale the woodpecker with the responsive scenery

## Scope

Correct a zoom/responsive mismatch: the bird’s anchor follows the centered-cover scenery transform, but its CSS size is independently derived from `rem`/viewport sizing. When browser zoom or viewport changes alter the runner scale, this changes the bird’s apparent size and detaches it visually from the trunk.

Set the bird’s dimensions from the same `scenery.png` centered-cover scale that drives its source-coordinate anchor. The source-equivalent size MUST preserve the current intended 2000×1100 bird proportion while keeping the bird’s contact point and visual size proportional to the background at browser zoom and wide-monitor viewports.

## Exclusions

- No sprite, flight path, through-glass, static interior-page, content, or theme-source changes.

## Acceptance criteria

1. At 2000×1100, the bird retains the intended perch size and contact point.
2. At 3440×1440 and a browser-zoom-reproducing viewport, the bird’s visible scale remains proportional to the foreground trunk rather than independently clamped.
3. Homepage flight and interior static perch use the same responsive size.
4. Through-glass continuity, fixed scroll, reduced motion, and no horizontal overflow remain intact.
5. Hugo build and headless-browser captures verify the above.

## Evidence expectations

Record the selected source-equivalent bird size, transform formula, all tested viewport/zoom states, bird/trunk-relative bounds, and build result.

## Blockers

None. User screenshots directly establish the independent sizing mismatch.

## Progress and notes

- 2026-07-12: User reported that browser magnification/minimization changes the bird’s size independently of the scenery and breaks its apparent tree placement.
- 2026-07-12: Replaced independent bird sizing with `114 * coverScale` using the actual 1672×941 scenery. Home and interior routes were verified at 2000×1100, 2260×950, and 3440×1440. Evidence: `.10x/evidence/2026-07-12-woodpecker-responsive-scale-validation.md`.
- 2026-07-12: Independent review passed. Review: `.10x/reviews/2026-07-12-woodpecker-responsive-scale.md`.
- 2026-07-12: Replaced the independent `clamp()` dimensions with a 114-source-pixel size multiplied by the same centered-cover scale as the scenery anchor. Hugo build and headless Chrome checks at 2000×1100, 2260×950 zoom/reflow-equivalent, and 3440×1440 confirm matching homepage/interior sizes, fixed perch behavior, and no horizontal overflow. Evidence: `.10x/evidence/2026-07-12-woodpecker-responsive-scale-validation.md`.

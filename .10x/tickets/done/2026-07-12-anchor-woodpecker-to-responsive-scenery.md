Status: done
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/tickets/done/2026-07-12-render-woodpecker-through-glass-runner.md

# Anchor the woodpecker to responsive scenery coordinates

## Scope

Correct the final woodpecker perch on wide/high-aspect monitor layouts. The current x/y anchor is derived from a percentage of the left gutter, so it no longer follows the foreground trunk when `scenery.png` is re-cropped by `background-size: cover`.

Calculate the perch’s viewport position from the selected trunk anchor in the source `assets/img/scenery.png`, using the same centered cover-scaling geometry as `html`’s fixed landscape background. The final perch and flight endpoint MUST remain on the intended right edge of that tree trunk across eligible desktop aspect ratios.

## Exclusions

- No change to the scene asset, flight direction, through-glass layering, sprite frames, reduced-motion behavior, or runner content.
- No separate breakpoint-specific magic positions unless required by the explicit source-coordinate transform.

## Acceptance criteria

1. At the existing 2000×1100 verification viewport, the perch remains on the intended trunk edge.
2. At a wide monitor viewport reproducing the user screenshot, the perch is on the same trunk edge—not suspended between trunks or limbs.
3. The final flight endpoint uses that same responsive coordinate.
4. Through-glass continuity, fixed-scroll behavior, reduced motion, and no horizontal scroll remain intact.
5. Headless-browser captures and measured positions document both viewports; `hugo --cleanDestinationDir` passes.

## Evidence expectations

Record source image dimensions, chosen source anchor coordinate, transform formula, tested viewports, perch/runner bounds, scroll checks, and build result.

## Blockers

None. The monitor screenshot proves the current gutter-relative anchor is not invariant under the background crop.

## Progress and notes

- 2026-07-12: User supplied `/var/folders/xk/pmxkhd7x635cskr6l4qw0mx00000gn/T/pi-clipboard-13365ed0-6a11-4f9f-bc56-a4b7cb25be6f.png`, showing the bird suspended between two trunks on a monitor layout.
- 2026-07-12: Replaced the gutter-relative perch with the source `(157, 362)` transformed by the centered `cover` calculation for the 1680×945 scenery. The same transformed endpoint drives the flight.
- 2026-07-12: `hugo --cleanDestinationDir`, source/record whitespace checks, and headless Chrome checks passed at 2000×1100, 2560×1440, and 3440×1440. Evidence: `.10x/evidence/2026-07-12-woodpecker-responsive-anchor-validation.md`. Independent review remains required before closure.
- 2026-07-12: Independent review corrected the inspected scenery dimensions from 1680×945 to 1672×941. Updated the runtime transform and reran the three responsive browser measurements; corrected positions are recorded in the evidence.
- 2026-07-12: Re-review passed. Review: `.10x/reviews/2026-07-12-woodpecker-responsive-anchor.md`.

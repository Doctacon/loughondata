Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Target: .10x/tickets/2026-07-12-refine-woodpecker-flight-and-perch.md
Verdict: pass

# Woodpecker refinement review

## Findings

- Both bird instances are hidden by default; the animation state exposes only the active gutter bird after the delayed flight begins.
- The final and reduced-motion perch is positioned at x=188.20–324.20, outside the runner spanning x=360–1640 at the verified 2000×1100 desktop viewport. The screenshots show the bird aligned to the right edge of the foreground trunk.
- The existing fixed search overlay is centered against the viewport to prevent it from producing a horizontal scroll range inside the backdrop-filtered body runner. The change is limited to `#search-wrapper`; theme source is untouched.
- Measured normal, flight, settled, and reduced-motion states all report `scrollWidth === clientWidth === 2000`.

## Verdict

Pass. The user-observed duplicate initial birds, branch perch, and horizontal scrolling are corrected. Evidence: `.10x/evidence/2026-07-12-woodpecker-refinement-validation.md`. Independent reviewer artifact: `.pi-subagents/artifacts/outputs/b0285f2f-a879-4083-a392-f7f82146a93f/woodpecker-refinement-review.md`.

## Residual risk

The normalized sprite may retain faint pale feather-edge halos because its source was flattened. Placement has been verified at 2000×1100; unusually short or extremely wide desktop viewports are not separately captured. These are documented visual limits, not acceptance blockers.

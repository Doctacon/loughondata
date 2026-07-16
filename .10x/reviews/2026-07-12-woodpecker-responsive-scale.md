Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Target: .10x/tickets/2026-07-12-scale-woodpecker-with-responsive-scenery.md
Verdict: pass

# Responsive woodpecker scale review

## Findings

- Every flight and perch copy inherits a size calculated from the actual 1672×941 scenery cover scale: `114 * max(viewportWidth / 1672, viewportHeight / 941)`.
- The formula replaces independent `rem`/viewport clamping and is shared by homepage and interior-page birds.
- Headless checks at 2000×1100, 2260×950, and 3440×1440 show proportional sizes, matching source-anchor placement, fixed scrolling, and no horizontal overflow.

## Verdict

Pass. Evidence: `.10x/evidence/2026-07-12-woodpecker-responsive-scale-validation.md`. Independent review: `.pi-subagents/artifacts/outputs/de1c3fb6-e3cd-48ae-ad11-c60d555de1e8/woodpecker-scale-review.md`.

## Residual risk

Native zoom and device-pixel-ratio combinations are represented by CSS viewport checks rather than exhaustively tested.

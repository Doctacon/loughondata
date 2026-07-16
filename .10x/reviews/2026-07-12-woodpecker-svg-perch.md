Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Target: .10x/tickets/2026-07-12-render-static-perch-in-svg-scene-space.md
Verdict: pass

# SVG scene-space woodpecker perch review

## Findings

- The decorative static perch SVG uses the exact 1672×941 scenery viewBox and centered-slice transform.
- Its 114×114 scene clip crops the existing lower-row fifth sprite frame; no duplicate scenery image is used.
- Interior pages display one fixed, pointer-inert SVG perch. Homepage hides it through the flight and reveals it after landing.
- Evidence records fixed-scroll, route state, representative viewport, and no-overflow validation.

## Verdict

Pass. Evidence: `.10x/evidence/2026-07-12-woodpecker-svg-perch-validation.md`. Independent review: `.pi-subagents/artifacts/outputs/cc2e8cb0-627b-435f-92f7-445099da2903/woodpecker-svg-perch-review.md`.

## Residual risk

The browser check uses Chromium; standard SVG/CSS features make this a bounded cross-browser risk.

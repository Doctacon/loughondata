Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Target: .10x/tickets/2026-07-12-woodpecker-gutter-animation.md
Verdict: pass

# Woodpecker gutter animation review

## Findings

- **Resolved significant issue:** The initial perch was placed inside the body runner because `backdrop-filter` made `body` the containing block for fixed descendants. `layouts/partials/extend-head.html` now positions the left gutter at `-runner.left` and the right gutter at `runner.width`, relative to that runner.
- The post-fix normal-motion and reduced-motion captures place the bird at x=82.88–218.88 while the runner spans x=356–1636 at the 2000×1100 viewport. The bird remains in the left gutter and does not cover readable content.
- The layer is decorative and non-interactive: it is `aria-hidden`, does not accept pointer input, and uses local assets only. The reduced-motion branch presents a static perch and does not start the flight loop.

## Verdict

Pass. The implementation meets the governing specification and ticket acceptance criteria, as supported by `.10x/evidence/2026-07-12-woodpecker-gutter-animation-validation.md` and the independent re-review artifact at `.pi-subagents/artifacts/outputs/3b3d8f8d-2619-4755-a4c7-aa4351f60972/woodpecker-rereview.md`.

## Residual risk

The supplied RGB sheet required fuzz-based checkerboard removal. Minor pale feather-edge halos may remain. This is visually bounded, documented in the evidence, and does not affect interaction, content, or reduced-motion behavior.

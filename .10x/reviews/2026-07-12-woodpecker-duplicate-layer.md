Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Target: .10x/tickets/2026-07-12-eliminate-woodpecker-glass-duplicate.md
Verdict: pass

# Woodpecker duplicate-layer review

## Findings

- The root flight is masked inside the runner interval; the filtered copy is clipped to that same interval. The regions are mutually exclusive.
- The filtered copy uses runner-relative positioning, aligning it with the root path instead of offsetting it by the runner’s left edge.
- Evidence at 2000×1100 and 3440×1440 shows one crisp bird in each gutter and one filtered bird in the runner. Fixed perch, reduced motion, and horizontal-overflow behavior remain intact.

## Verdict

Pass. Evidence: `.10x/evidence/2026-07-12-woodpecker-duplicate-layer-validation.md`. Independent review: `.pi-subagents/artifacts/outputs/ebba9792-d5ab-40d3-b640-7497621a83da/woodpecker-duplicate-review.md`.

## Residual risk

Screenshot coverage is representative, not exhaustive across every desktop aspect ratio.

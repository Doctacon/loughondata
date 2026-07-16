Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Target: .10x/tickets/2026-07-12-show-static-woodpecker-on-interior-pages.md
Verdict: pass

# Woodpecker interior-pages review

## Findings

- The woodpecker layer is included once from the shared base layout.
- `.IsHome` selects the delayed homepage flight; interior routes initialize only the static responsive perch.
- Recorded checks cover home, services, projects, and Databox at 2000×1100 and 3440×1440, including fixed scrolling and no horizontal overflow. An 800×800 interior page remains bird-free.

## Verdict

Pass. Evidence: `.10x/evidence/2026-07-12-woodpecker-interior-pages-validation.md`. The scaling review independently rechecked homepage/interior state selection: `.pi-subagents/artifacts/outputs/de1c3fb6-e3cd-48ae-ad11-c60d555de1e8/woodpecker-scale-review.md`.

## Residual risk

Verification is representative rather than exhaustive across every route and browser.

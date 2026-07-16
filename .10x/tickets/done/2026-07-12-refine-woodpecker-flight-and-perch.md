Status: done
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/tickets/done/2026-07-12-woodpecker-gutter-animation.md

# Refine woodpecker flight initialization and perch anchor

## Scope

Correct two user-observed homepage animation defects:

1. Before the one-time flight starts, both bird elements briefly render in their default gutter positions.
2. The final static bird is visually aligned with a horizontal limb instead of the right edge of the left foreground tree trunk.

The corrected behavior MUST keep both birds hidden until the normal-motion flight begins; reduced-motion visitors MUST see only the final static perch. The final perch MUST be positioned against the trunk’s right edge rather than a limb, while remaining entirely inside the left gutter. The page MUST NOT acquire horizontal scrolling from any woodpecker layer or gutter positioning.

## Exclusions

- No changes to the flight concept, desktop eligibility threshold, background art, content runner, or source sprite art.
- No new animation dependency or theme-source modification.

## Acceptance criteria

1. On a fresh eligible desktop load, no bird appears before the one-time flight begins.
2. During normal motion, only the bird currently representing the visible gutter segment can be seen.
3. The final bird appears against the right side of the foreground left tree trunk, not on an extending limb, and does not overlap the body runner.
4. `prefers-reduced-motion: reduce` shows only that correctly placed static perch.
5. The page has no horizontal scroll range at the verified desktop viewport (`scrollWidth` does not exceed `clientWidth`).
6. Headless browser screenshots demonstrate normal and reduced-motion outcomes.

## Evidence expectations

Record the tested viewport, initial-flight screenshot/check, settled-perch screenshot/check, reduced-motion screenshot/check, and the Hugo build result.

## Blockers

None. The user directly identified the desired visual anchor and initialization behavior from a page screenshot.

## Progress and notes

- 2026-07-12: User reported the duplicated initial birds and branch perch from `/var/folders/xk/pmxkhd7x635cskr6l4qw0mx00000gn/T/pi-clipboard-62923253-ac61-4805-b321-7887f53158f7.png`.
- 2026-07-12: User additionally reported page-level left/right scrolling after the animation was introduced. This ticket owns identifying and eliminating that overflow.
- 2026-07-12: Headless Chrome at 2000×1100 verified both birds hidden before flight, only one bird visible in flight, a trunk-edge perch at x=188.20–324.20 outside the runner x=360–1640, and no horizontal scroll range in normal, flight, settled, or reduced-motion states. Evidence: `.10x/evidence/2026-07-12-woodpecker-refinement-validation.md`.
- 2026-07-12: Independent review passed. Review: `.10x/reviews/2026-07-12-woodpecker-refinement.md`.
- 2026-07-12: Added explicit `idle`, `right`, `left`, and `perched` visibility states so only the active bird is painted. Re-anchored the perch to 52% of the left gutter width and 38% of viewport height, aligning the clinging frame to the foreground trunk’s right edge below its upper limbs.
- 2026-07-12: Measured the original 361px horizontal overflow. Its source was the fixed theme-search wrapper contained by the body backdrop filter; viewport-centering that wrapper and correcting the right gutter’s one-pixel border offset returned `scrollWidth` to `clientWidth` (2000px).
- 2026-07-12: `hugo --cleanDestinationDir` and normal/reduced-motion headless Chrome validation passed. Evidence: `.10x/evidence/2026-07-12-woodpecker-refinement-validation.md`.

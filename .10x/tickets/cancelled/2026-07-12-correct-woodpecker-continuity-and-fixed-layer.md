Status: cancelled
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/tickets/done/2026-07-12-refine-woodpecker-flight-and-perch.md

# Correct woodpecker frame, flight continuity, and fixed background layer

## Scope

Correct three user-observed defects in the homepage woodpecker animation:

1. At least one selected flight-frame crop includes visible pixels from another sprite frame.
2. The two-gutter handoff makes the bird appear to teleport through the glass runner instead of continuing a single right-to-left trajectory behind it.
3. After the bird perches, scrolling moves it with the backdrop-filtered content runner instead of keeping it fixed to the background tree.

The implementation MUST choose only clean flight frames or produce corrected frame assets; no visible frame may contain another frame’s pixels. It MUST model a single global flight path at consistent velocity, while allowing the runner to occlude the bird between the two visible gutters. The final perch MUST remain visually fixed to the background tree while page content scrolls.

## Exclusions

- No changes to landscape art, page content, runner visual treatment, or the woodpecker’s final trunk anchor.
- No remote or new animation dependency.
- No animation on reduced-motion or ineligible small viewport layouts.

## Acceptance criteria

1. Every displayed flight frame is cleanly isolated, with no fragment of a neighboring sprite frame visible.
2. The bird follows one continuous, consistent-speed right-to-left trajectory; it is only occluded—not repositioned—while passing behind the runner.
3. On a settled perch, scrolling changes content position but not the bird’s viewport position relative to the background tree.
4. The initial duplicate-bird fix, trunk-edge perch, and no-horizontal-scroll behavior remain intact.
5. Headless-browser checks and screenshots verify pre-flight, both visible flight phases, post-perch scroll behavior, and reduced motion.
6. `hugo --cleanDestinationDir` passes.

## Evidence expectations

Record selected/corrected flight frames, viewport measurements across flight phases, before/after-scroll perch bounds, reduced-motion result, horizontal scroll measurement, and build output.

## Blockers

None. The user supplied direct visual observations that establish the required behavior.

## Progress and notes

- 2026-07-12: User reported a contaminated flight frame, a visually discontinuous runner crossing, and the perched bird scrolling with content.
- 2026-07-12: Moved the decorative layer to the HTML root so the body backdrop filter cannot make it scroll, and replaced the 50/50 gutter handoff with one viewport-wide linear path whose central segment is explicitly occluded.
- 2026-07-12: Validation found lower-row sprite pixels contaminating the top-row cell crops. Derived `assets/img/acorn-woodpecker-flight.png` from the clean top 350px of the sheet and use it only for five flight frames; the original sprite remains the perch source.
- 2026-07-12: Hugo build, source whitespace check, and local headless-Chrome validation passed for pre-flight, right/occluded/left phases, settled before/after-scroll bounds, reduced motion, and horizontal scroll width. Evidence: `.10x/evidence/2026-07-12-woodpecker-continuity-validation.md`.
- 2026-07-12: Cancelled because the user superseded the central occlusion contract with a visibly through-glass flight. The clean frames, global path, and fixed-layer work remain in the successor `.10x/tickets/done/2026-07-12-render-woodpecker-through-glass-runner.md`.

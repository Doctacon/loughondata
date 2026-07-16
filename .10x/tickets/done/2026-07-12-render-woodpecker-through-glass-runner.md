Status: done
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/tickets/cancelled/2026-07-12-correct-woodpecker-continuity-and-fixed-layer.md

# Render the woodpecker continuously through the glass runner

## Scope

Replace runner occlusion with a continuous behind-glass flight. The bird MUST remain a single unbroken right-to-left animation: crisp against the landscape in both gutters, and visibly dimmed/blurred by the dark translucent runner while it crosses the page. It MUST remain beneath the runner and its readable content, never painting over text or controls.

## Exclusions

- No change to the clean curated flight frames, final trunk perch, desktop threshold, reduced-motion behavior, local-only assets, or no-horizontal-scroll guarantee.
- No change to content or Blowfish theme source.

## Acceptance criteria

1. A normal-motion capture shows the bird in continuous flight before, during, and after the runner crossing with no disappearance or teleport.
2. The runner visibly filters the bird during the crossing; body text and controls remain above it and readable.
3. The bird remains fixed to the background landscape after perching while content scrolls.
4. Reduced motion stays static and no horizontal scroll range is introduced.
5. Headless Chrome screenshots and measured state verify the above, and `hugo --cleanDestinationDir` passes.

## Evidence expectations

Record a gutter capture, through-runner capture, post-runner capture, post-perch scroll comparison, reduced-motion capture, horizontal-scroll measurements, and build result.

## Blockers

None. User explicitly ratified the beneath-glass continuous-flight effect.

## Progress and notes

- 2026-07-12: User clarified that “behind the runner” means visibly traveling through its translucent glass treatment, not being fully occluded.
- 2026-07-12: Replaced the body-level glass with `body::before` and added a runner-clipped filtered flight copy beneath direct body content. Headless Chrome at 2000×1100 verified a visible through-runner crossing, fixed post-perch bounds after a 600px scroll, static reduced motion, no horizontal overflow, and a 159-page Hugo build. Evidence: `.10x/evidence/2026-07-12-woodpecker-through-glass-validation.md`.
- 2026-07-12: Independent review passed. Review: `.10x/reviews/2026-07-12-woodpecker-through-glass.md`.
- 2026-07-12: Moved the body glass treatment to `body::before`; body children now sit above it. A runner-clipped, dimmed/blurred flight copy sits between glass and content, while the root-level copy remains crisp in page gutters. The bird remains fixed after landing.
- 2026-07-12: Local headless-Chrome validation at 2000×1100 captured initial, through-runner, left-gutter, post-scroll, and reduced-motion states. It verified continuous runner presence, fixed perch bounds after scroll, and no horizontal scroll. Evidence: `.10x/evidence/2026-07-12-woodpecker-through-glass-validation.md`. Ticket awaits independent review.

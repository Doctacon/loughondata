Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Relates-To: .10x/tickets/2026-07-12-render-woodpecker-through-glass-runner.md, .10x/specs/woodpecker-gutter-animation.md

# Woodpecker through-glass validation

## What was observed

At a 2000×1100 local headless-Chrome viewport:

- Before the 1.2-second delay, both the gutter and glass-layer birds were hidden.
- The flight layer is a child of `HTML`, not the backdrop-filtered body. At the through-runner sample, its visible DOM bounds were x=1197.61–1333.61 and y=301.50–437.50, inside runner bounds x=360–1640.
- The through-runner capture shows the bird continuously present, visibly dimmed and blurred by the runner-specific glass copy, while the runner's logo, navigation, heading, portrait, and body text remain above it.
- The later left-gutter sample was x=291.21–427.21, with the background copy crisp outside the runner.
- The final perch remained at x=187.20, y=418.00 before and after a 600px page scroll.
- Reduced motion rendered only the static perch. Every sampled state reported `scrollWidth === clientWidth === 2000`.
- `hugo --cleanDestinationDir` built 159 pages successfully.

## Procedure

1. Moved the former body glass background, blur, border, and shadow onto `body::before`.
2. Put direct body children above that pseudo-element, leaving the root-level background flight beneath content.
3. Added a runner-clipped, blurred and dimmed flight copy between the glass pseudo-element and body content. The background copy remains crisp in gutters; the runner copy supplies visible through-glass continuity without covering readable content.
4. Ran `node /tmp/validate-woodpecker-glass.mjs`, which captured initial, through-runner, left-gutter, post-scroll, and reduced-motion states while recording DOM geometry and horizontal scroll width.
5. Ran `hugo --cleanDestinationDir` and `git diff --check -- assets/css/custom.css layouts/partials/extend-head.html layouts/partials/home/woodpecker.html`.

## Artifacts

- `.10x/evidence/.storage/2026-07-12-woodpecker-glass-initial-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-glass-through-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-glass-left-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-glass-scrolled-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-glass-reduced-motion-2000x1100.png`

## What this supports

The bird follows one continuous viewport-fixed path, is visibly present during the runner crossing, and remains below body content. The pseudo-element maintains the runner treatment while allowing the bird to remain crisp in gutters and visually filtered through the runner.

## Limits

The through-glass effect is implemented with a runner-clipped filtered copy above the pseudo-element but below content; it is visually equivalent to a bird behind translucent glass, rather than relying on browser backdrop compositing of the root sprite. Validation covers the 2000×1100 desktop viewport, not every extreme aspect ratio.

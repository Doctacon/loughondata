Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Relates-To: .10x/tickets/2026-07-12-eliminate-woodpecker-glass-duplicate.md

# Woodpecker duplicate-layer validation

## What was observed

The original through-glass implementation positioned the runner-clipped filtered copy using viewport x coordinates inside a runner-relative container. This shifted that copy by the runner’s left offset; near the runner it could appear as a second bird alongside the crisp root copy.

The corrected implementation does both of the following:

- masks `.woodpecker-gutters` over the runner interval using runner bounds set at layout time, leaving the crisp root layer only in the two outer gutters;
- positions the filtered runner copy at `x - runner.left`, matching its runner-relative containing block to the root flight’s viewport coordinate.

Headless Chrome at 2000×1100 and 3440×1440 observed the root and filtered flight copies at the same viewport x/y values. The root layer is masked inside the runner while the filtered layer is clipped to the runner, making the copies mutually exclusive in paint. The 2000×1100 runner capture shows one dimmed bird beneath the glass, with no shifted crisp duplicate.

At both viewports, initial birds were hidden, the perch remained fixed after a 600px scroll, reduced motion rendered only the static perch, and `scrollWidth === clientWidth`.

## Procedure

1. Set the root gutter layer’s CSS mask boundaries from `document.body.getBoundingClientRect()`.
2. Kept the filtered layer clipped to those same runner bounds.
3. Corrected the filtered flight transform to use its parent-relative x coordinate.
4. Ran `hugo --cleanDestinationDir`.
5. Ran `node /tmp/validate-woodpecker-duplicate.mjs`, capturing initial, right-gutter, runner, left-gutter, perched-scroll, and reduced-motion states at 2000×1100 and 3440×1440.

## Artifacts

- `.10x/evidence/.storage/2026-07-12-woodpecker-duplicate-right-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-duplicate-runner-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-duplicate-left-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-duplicate-right-3440x1440.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-duplicate-runner-3440x1440.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-duplicate-left-3440x1440.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-duplicate-reduced-3440x1440.png`

## Limits

The root and filtered copies remain in the DOM at the runner boundary but are mutually exclusive in painted regions through the CSS mask/clip pair. Validation covers 2000×1100 and 3440×1440, not every desktop aspect ratio.

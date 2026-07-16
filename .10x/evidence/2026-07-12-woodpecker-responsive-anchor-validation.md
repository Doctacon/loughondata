Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Relates-To: .10x/tickets/2026-07-12-anchor-woodpecker-to-responsive-scenery.md, .10x/specs/woodpecker-gutter-animation.md

# Responsive woodpecker scenery-anchor validation

## What was observed

`assets/img/scenery.png` is 1672×941. The foreground trunk’s selected right-edge perch coordinate is source `(157, 362)`. It preserves the intended 2000×1100 trunk placement while remaining attached to the same source tree as the centered cover crop changes.

The implementation maps that coordinate with:

```text
scale   = max(viewportWidth / 1672, viewportHeight / 941)
offsetX = (viewportWidth - 1672 * scale) / 2
offsetY = (viewportHeight - 941 * scale) / 2
perchX  = offsetX + 157 * scale
perchY  = offsetY + 362 * scale
```

At each checked viewport the settled perch stayed visible, left of the body runner, and retained identical viewport bounds after a 600px content scroll:

| Viewport | Perch x/y | Runner bounds | Scroll width/client width |
| --- | --- | --- | --- |
| 2000×1100 | 187.80 / 420.20 | 360–1640 | 2000 / 2000 |
| 2560×1440 | 240.38 / 553.88 | 640–1920 | 2560 / 2560 |
| 3440×1440 | 323.01 / 496.77 | 1080–2360 | 3440 / 3440 |

At 2000×1100, 2560×1440, and 3440×1440, the through-glass flight copy remained visible inside the runner with matching runner bounds and no horizontal overflow. At 3440×1440, `prefers-reduced-motion: reduce` showed only the static perch.

## Procedure

1. Inspected `scenery.png` and the monitor screenshot. The gutter-relative percentage placed the bird between the two foreground trunks at wide aspect ratios.
2. Replaced the percentage anchor with the centered-cover transform above in `layouts/partials/extend-head.html`; corrected its dimensions from an assumed 1680×945 to the inspected 1672×941 source image; used the same transformed point as both the final perch and flight endpoint.
3. Ran `hugo --cleanDestinationDir`.
4. Used local headless Chrome to verify settled, scrolled, and reduced-motion states at 2000×1100, 2560×1440, and 3440×1440; verified through-runner flight samples at all three viewports.
5. Ran `git diff --check -- layouts/partials/extend-head.html .10x`.

## Artifacts

- `.10x/evidence/.storage/2026-07-12-woodpecker-responsive-perch-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-responsive-perch-2560x1440.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-responsive-perch-3440x1440.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-responsive-reduced-motion-3440x1440.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-responsive-through-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-responsive-through-2560x1440.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-responsive-through-3440x1440.png`

## What this supports

The perch and flight endpoint are now tied to the scenery rather than a gutter percentage. The intended foreground trunk remains the anchor at the prior laptop viewport and the verified wide monitor sizes; continuous through-glass flight, fixed scrolling, static reduced motion, and no horizontal overflow remain intact.

## Limits

The selected source coordinate is calibrated to the supplied scenery artwork and the three tested desktop viewports. It does not independently prove every possible display size or OS-level zoom setting.

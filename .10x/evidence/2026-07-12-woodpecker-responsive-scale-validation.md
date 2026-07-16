Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Relates-To: .10x/tickets/2026-07-12-scale-woodpecker-with-responsive-scenery.md, .10x/specs/woodpecker-gutter-animation.md

# Responsive woodpecker scale validation

## What was observed

The previous `clamp(5.5rem, 8vw, 8.5rem)` bird size did not share the fixed landscape’s centered-cover scaling. The new source-equivalent bird size is 114 scenery pixels and is calculated with the same scale used for the scenery coordinate transform:

```text
scale    = max(viewportWidth / 1672, viewportHeight / 941)
birdSize = 114 * scale
```

Headless Chrome confirmed matching homepage and `/services/` static-perch dimensions and positions:

| CSS viewport | Bird size | Perch x/y | Scroll width/client width |
| --- | ---: | ---: | --- |
| 2000×1100 | 136.36px | 187.80 / 420.20 | 2000 / 2000 |
| 2260×950 (zoom/reflow-equivalent) | 154.08px | 212.21 / 328.33 | 2260 / 2260 |
| 3440×1440 | 234.53px | 323.01 / 496.77 | 3440 / 3440 |

At each viewport, the homepage settled perch and the interior-page static perch had identical dimensions and source-coordinate placement. The existing homepage flight, runner-filtered crossing, fixed-scroll perch, and reduced-motion branches use the same elements and calculated CSS custom property.

## Procedure

1. Replaced `.woodpecker`’s independent `clamp()` dimensions with `--woodpecker-size`.
2. Set that custom property on the root gutter layer and runner glass layer from the centered-cover scale during layout.
3. Built with `hugo --cleanDestinationDir`.
4. Used local headless Chrome across home and representative interior routes at the two established desktop viewports plus a 2260×950 CSS viewport that reproduces zoom/reflow geometry.
5. Checked settled dimensions, source-coordinate position, fixed post-scroll position, interior static state, homepage flight state, and document horizontal dimensions.
6. Ran `git diff --check -- assets/css/custom.css layouts/partials/extend-head.html .10x`.

## What this supports

The bird now scales in the same coordinate system as the scenery. It retains the intended 2000×1100 size, grows proportionally with the large scenery crop, and stays anchored to the trunk across a zoom/reflow-equivalent viewport.

## Limits

This validates representative CSS viewports rather than every browser’s native zoom implementation or every device-pixel-ratio combination. It does not alter the existing visual limits of the AI-generated sprite artwork.

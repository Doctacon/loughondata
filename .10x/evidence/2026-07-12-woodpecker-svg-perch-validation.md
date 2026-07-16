Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Relates-To: .10x/tickets/2026-07-12-render-static-perch-in-svg-scene-space.md, .10x/specs/woodpecker-gutter-animation.md

# SVG scene-space woodpecker perch validation

## What was observed

The static perch is one decorative, fixed SVG per eligible page. Its root uses `viewBox="0 0 1672 941"` and `preserveAspectRatio="xMidYMid slice"`, matching the fixed scenery coordinate system. It crops the current local `/img/acorn-woodpecker-sprite.png` asset with the following source-space geometry:

- clipped scene rectangle: `x=157`, `y=362`, `width=114`, `height=114`
- sprite transform: `x=-299`, `y=248`, `width=570`, `height=228`

The sprite is 1985×794 (five 397×397 columns and two rows). The transform scales it by `570 / 1985`; the clip therefore selects the fifth frame of the lower row in the 114×114 tree-perch rectangle. No scenery image is duplicated.

The Hugo partial saves the page context before `with resources.Get` as `$page`, so `data-home` is read from `$page.IsHome` while `.RelPermalink` remains read from the sprite resource. Rendered HTML confirmed `data-home="true"` at `/`, `data-home="false"` at `/services/`, and the expected local sprite URL on both routes.

## Procedure

1. Confirmed the supplied `hugo --cleanDestinationDir` run passed and used the restarted local preview at `http://localhost:1313`.
2. Ran a focused Chrome DevTools Protocol check against `/services/` at 2000×1100, 3440×1440, and the 2260×950 zoom/reflow-equivalent viewport.
3. At every services viewport, checked immediate SVG state, count, scene attributes, sprite reference and crop, `position: fixed`, `pointer-events: none`, no flight visibility, horizontal dimensions, and bounds before/after `scrollTo(0, 600)`.
4. Ran the homepage at 2000×1100 through initial load, active flight, and post-landing state.

## Validation output

| Route / CSS viewport | Static SVG state | Fixed after 600px scroll | Horizontal dimensions | Flight state |
| --- | --- | --- | --- | --- |
| `/services/` 2000×1100 | one, `ready=true`, `perched`, `display=block` | root SVG remained `0,0,2000×1100` | 1992 / 1992 | hidden |
| `/services/` 3440×1440 | one, `ready=true`, `perched`, `display=block` | root SVG remained `0,0,3440×1440` | 3432 / 3432 | hidden |
| `/services/` 2260×950 | one, `ready=true`, `perched`, `display=block` | root SVG remained `0,0,2260×950` | 2252 / 2252 | hidden |
| `/` 2000×1100, initial | one SVG, `display=none` | n/a | 1992 / 1992 | hidden before scheduled flight |
| `/` 2000×1100, in flight | SVG remains hidden with `state=idle` | n/a | 1992 / 1992 | flight visible |
| `/` 2000×1100, landed | one, `ready=true`, `perched`, `display=block` | n/a | 1992 / 1992 | hidden |

The client widths are eight pixels narrower than the CSS viewport because Chrome reserves the vertical scrollbar; at every check `scrollWidth === clientWidth`, so the decorative SVG introduced no horizontal overflow.

## What this supports

The static perch no longer depends on JavaScript-calculated source x/y placement. The SVG’s own centered-slice transform re-crops the 1672×941 scene with the same cover behavior as the fixed landscape, and it remains viewport-fixed while scrolling. Eligible interior pages render the SVG immediately; the homepage keeps it hidden during the existing flight and reveals exactly one SVG after landing.

## Limits

Validation uses local headless Chrome and representative desktop/reflow viewports, not all browser engines or native browser zoom device-pixel-ratio combinations. The required independent review remains pending.

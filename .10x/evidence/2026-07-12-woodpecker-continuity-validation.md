Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Relates-To: .10x/tickets/2026-07-12-correct-woodpecker-continuity-and-fixed-layer.md, .10x/specs/woodpecker-gutter-animation.md

# Woodpecker continuity and fixed-layer validation

## What was observed

At a 2000×1100 headless-Chrome viewport:

- Before the 1.2-second flight delay, both birds were hidden, the animation layer parent was `HTML`, and `scrollWidth` equaled `clientWidth` (2000px).
- The right-gutter flight phase showed only the right bird at x=1894.63 with frame position `50% 0px`; the left bird remained hidden.
- The animation entered an `occluded` phase between the runner bounds (x=360–1640) with both birds hidden, then a left-gutter phase with only the left bird visible at x=298.52 and frame position `75% 0px`. The gutter clipping keeps the runner unobscured while the same global position advances through it.
- The settled perch was at x=187.20, y=418.00. After scrolling the page, the perch remained at exactly x=187.20, y=418.00 while content scroll position changed, confirming the layer is viewport-fixed.
- Under `prefers-reduced-motion: reduce`, the left perched bird was visible, the right bird had a zero-size non-rendered box, and no flight phase was set.
- All checked states reported `scrollWidth === clientWidth === 2000`.

## Procedure

1. Corrected the contaminated source-frame issue found during validation by deriving `assets/img/acorn-woodpecker-flight.png` from only the first 350px of the source sheet’s clean top row, retaining five 397px-wide flight cells and extending the remainder transparently. The clean flight cells are shown in the montage below.
2. Loaded the rebuilt homepage with local headless Chrome. A CDP script waited for and captured the `right`, `occluded`, `left`, and `perched` states; it also recorded computed visibility, frame positions, layer parent, runner bounds, and scroll widths.
3. Scrolled after the perch settled and compared its viewport bounds before and after scrolling.
4. Repeated the load with emulated reduced motion.
5. Ran `hugo --cleanDestinationDir` and `git diff --check -- assets/css/custom.css layouts/partials/extend-head.html .10x`.

## Artifacts

- `.10x/evidence/.storage/2026-07-12-woodpecker-clean-flight-frames.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-continuity-initial-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-continuity-right-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-continuity-left-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-continuity-scrolled-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-continuity-reduced-motion-2000x1100.png`

## What this supports

The displayed flight cells contain only curated top-row artwork, the flight uses one linear global trajectory whose middle is occluded rather than repositioned, and the final bird remains fixed to the landscape while content scrolls. The prior hidden-idle, trunk-anchor, reduced-motion, and no-horizontal-scroll behavior remain in place.

## Limits

The validation covers the primary 2000×1100 desktop viewport rather than every desktop aspect ratio. The original flattened sheet may still retain faint feather-edge halos within the actual bird artwork; the clean-flight derivation removes the neighboring-frame fragments.

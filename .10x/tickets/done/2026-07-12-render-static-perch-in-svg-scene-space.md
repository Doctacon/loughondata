Status: done
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/tickets/done/2026-07-12-scale-woodpecker-with-responsive-scenery.md

# Render the static woodpecker perch in SVG scene space

## Scope

Replace the static CSS/JavaScript perch position and size with a fixed SVG overlay that shares the scenery’s `1672×941` scene coordinate system and uses `preserveAspectRatio="xMidYMid slice"`. The SVG MUST reference and crop the existing perched frame from the current sprite asset; it MUST NOT introduce a duplicate scenery PNG.

On interior eligible desktop pages, render the static SVG perch immediately. On the homepage, keep the SVG perch hidden while the existing flight plays, then reveal it after the bird lands. The SVG scene transform MUST keep the perch attached to the tree through browser zoom and viewport re-cropping without source-coordinate JavaScript for the static state.

## Exclusions

- No new scenery PNG, no new remote dependency, and no change to the existing local sprite source.
- No change to flight behavior, runner glass treatment, page content, or theme source.

## Acceptance criteria

1. Static perch alignment remains attached to the tree at 2000×1100, 3440×1440, and a browser-zoom/reflow viewport without JS-calculated static x/y placement.
2. Interior pages show exactly one immediate static SVG perch; homepage reveals exactly one static SVG perch after the existing flight ends.
3. The SVG is decorative, pointer-inert, fixed to the landscape, and hidden on ineligible layouts.
4. The SVG uses the existing sprite asset and does not add a duplicate landscape PNG.
5. Through-glass flight, reduced motion, and no-horizontal-scroll behavior remain intact; Hugo and headless browser checks pass.

## Evidence expectations

Record SVG viewBox/frame-crop details, tested routes/viewports, flight-to-perch state, fixed-scroll checks, zoom/reflow checks, and build result.

## Blockers

None. User explicitly approved the SVG scene-coordinate implementation to avoid a duplicate PNG.

## Progress and notes

- 2026-07-12: User asked for the static perch to be rendered in SVG scene space rather than a new composited PNG.
- 2026-07-12: Corrected Hugo context inside `with resources.Get` by preserving the page as `$page` before the resource scope; `data-home` now reads `$page.IsHome` and the SVG image continues to use the resource `.RelPermalink`.
- 2026-07-12: Focused local headless Chrome checks passed for homepage flight-to-perch reveal and immediate `/services/` SVG state at 2000×1100, 3440×1440, and 2260×950 zoom/reflow-equivalent. The SVG uses the current sprite with a 1672×941 centered-slice scene transform, stays fixed through scroll, and introduces no horizontal overflow. Evidence: `.10x/evidence/2026-07-12-woodpecker-svg-perch-validation.md`.
- 2026-07-12: Implementation and validation are complete; required independent review remains pending before closure.
- 2026-07-12: Independent review passed. Review: `.10x/reviews/2026-07-12-woodpecker-svg-perch.md`.

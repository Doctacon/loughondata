Status: done
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: None

# Add the woodpecker gutter animation

## Scope

Implement the one-time decorative acorn woodpecker flight described in `.10x/specs/woodpecker-gutter-animation.md`. Derive usable local frame assets from `assets/img/acorn-woodpecker-sprite-sheet.png`, add the homepage animation layer, and implement its desktop-only/reduced-motion behavior.

## Exclusions

- No changes to content, navigation, background scenery, or Blowfish source.
- No external animation/image dependencies.
- No motion on small viewports and no repeating flight during a page load.

## Acceptance criteria

1. Every criterion in `.10x/specs/woodpecker-gutter-animation.md` is met.
2. The checkerboard background is not visible around the flying or perched bird.
3. `hugo --cleanDestinationDir` completes successfully.
4. The desktop homepage is visually inspected for gutter-only placement, runner legibility, and no layout shift.

## Evidence expectations

- Record the source frame dimensions and image-processing procedure.
- Record the Hugo build result and manually inspected viewport(s).
- Record the reduced-motion behavior and any limitations from the flattened sprite source.

## Assumption provenance

- **User-ratified:** use the supplied 5×2 sheet at `assets/img/acorn-woodpecker-sprite-sheet.png`; use it despite its flattened checkerboard; fly once on first load, then perch.
- **Record-backed:** the body is the glass runner and the `html` background owns the fixed landscape (`assets/css/custom.css`, `.10x/specs/visual-system-v1.md`).

## Blockers

None. The flattened sheet is a known visual-quality risk, not an execution blocker.

## Progress and notes

- 2026-07-12: User approved a gutter-only, one-time flight and explicitly chose an attempt to remove the flattened checkerboard rather than re-export a transparent image.
- 2026-07-12: Derived `assets/img/acorn-woodpecker-sprite.png` from the 1983×793 flattened source with ImageMagick (`-fuzz 12% -transparent '#f8f8f8'`) and extended the canvas to an exact 5×2 grid of 397px cells.
- 2026-07-12: Added homepage-only fixed gutter containers. The script measures the body runner, clips each half-flight to its matching gutter, plays once after 1.2 seconds on eligible desktops, and uses the static perch for reduced motion.
- 2026-07-12: `hugo --cleanDestinationDir` passed. Static inspection is complete; browser viewport inspection remains required before closure because this runner has no browser automation.
- 2026-07-12: Headless Chrome verification exposed the initial fixed-position containing-block error; runner-relative offsets corrected the perch to x=82.88–218.88, left of the runner at x=356–1636. Normal and reduced-motion captures are recorded in `.10x/evidence/2026-07-12-woodpecker-gutter-animation-validation.md`.
- 2026-07-12: Independent re-review passed. Closure evidence: `.10x/evidence/2026-07-12-woodpecker-gutter-animation-validation.md`; review: `.10x/reviews/2026-07-12-woodpecker-gutter-animation.md`.
- 2026-07-12: Headless Chrome at 2000×1100 exposed a perched bird inside the runner. Cause: `backdrop-filter` makes `body` the containing block for fixed descendants, while gutter offsets were calculated from viewport zero. Updated the offsets to be runner-relative.
- 2026-07-12: Rebuilt and captured normal-motion and `prefers-reduced-motion: reduce` screenshots after six seconds. In each, the bird bounding box is x=82.88–218.88 while the runner begins at x=356; both screenshots are stored in `.10x/evidence/.storage/` and recorded in the validation evidence.

Status: active
Created: 2026-07-12
Updated: 2026-07-12

# Woodpecker gutter animation

## Purpose and scope

Add an optional decorative animation to the homepage: an acorn woodpecker flies from the right page gutter to a perch at the left-side tree in the fixed pixel landscape. It complements the scenery and must not obscure, interrupt, or become a prerequisite for reading site content. On every other eligible desktop page, the same bird appears only as a static perch at that final tree position.

This specification governs the animation behavior and accessibility. It does not change the site’s content, navigation, background landscape, or introduce an interactive game element.

## Assets and rendering constraints

- Source artwork is `assets/img/acorn-woodpecker-sprite-sheet.png`, a 5-column by 2-row sheet with ten frames.
- The bird’s rendered size and final anchor MUST use the same centered `background-size: cover` scale as the scenery. Browser zoom or responsive re-cropping MUST preserve the bird’s proportion and contact point relative to the tree.
- The source sheet is flattened and includes a checkerboard background; it has no alpha channel. The implementation MAY derive a transparent asset from it, but must preserve the bird’s pale face and wing markings as far as practical.
- The bird MUST be decorative (`aria-hidden="true"`) and MUST NOT receive pointer events or keyboard focus.
- The animation MUST use local assets only. No remote image, animation, tracking, or runtime dependency is permitted.

## Behavior

### Eligible viewport

- On viewports where the background gutters are not meaningfully visible, the bird MUST be hidden.
- On eligible desktop-sized viewports, the bird layer MUST be positioned behind the readable body runner and above the fixed landscape.

### Motion

- On the homepage, when motion is allowed, the bird MUST begin one right-to-left flight after the initial page load has settled.
- On non-homepage pages, the bird MUST render only as the static final perch; it MUST NOT run the flight animation.
- The bird MUST travel continuously beneath the translucent body runner. It MUST remain crisp in the outer gutters and remain visibly muted by the runner's glass treatment while crossing the page; it MUST NOT paint above readable body content.
- The flight MUST use the sheet’s flight frames, move continuously from the right gutter through the runner to the left-side tree, and finish at the left-side perch position.
- After landing, the perched frame MUST remain static for the lifetime of the page.
- The animation MUST NOT repeat automatically during that page load.

### Reduced motion and failure mode

- If `prefers-reduced-motion: reduce` is set, no flight animation may occur. A static perched bird MAY be shown if its asset renders cleanly; otherwise the bird layer MUST be hidden.
- If the derived asset or animation fails to load, content and site controls MUST remain fully usable with no layout shift.

## Acceptance criteria

1. At desktop viewport widths, a one-time right-to-left woodpecker flight is visible only in the landscape gutters and ends with a static left-side perch.
2. The bird never intercepts pointer or keyboard interaction and is not announced to assistive technologies.
3. The readable runner remains unobscured throughout the flight.
4. Motion-reduced users do not receive a flight animation.
5. The implementation uses only local static assets and makes no network requests beyond the existing page assets.

## Exclusions

- No sound, user-controlled playback, wildlife data, tracking, or repeat scheduling.
- No animation on mobile/small viewport layouts.
- No modifications to Blowfish theme source.

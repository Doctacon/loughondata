Status: recorded
Created: 2026-07-14
Updated: 2026-07-14
Relates-To: .10x/tickets/2026-07-12-services-cards-and-contours.md, .10x/specs/contractor-site-v1.md, .10x/specs/visual-system-v1.md

# Services contour and focused-anchor fix validation

## What was observed

The existing contour SVG uses amber paths with 8% intrinsic opacity. The prior light/dark CSS foreground overlays compounded that opacity to only 1.28% and 1.92% effective pattern contribution, respectively.

The project CSS now uses a 40% light foreground overlay and 35% dark foreground overlay. That produces 4.8% effective amber pattern contribution in light appearance and 5.2% in dark appearance. The calculated contour-line colors are `#f7f6ed` light and `#1c1e16` dark. Primary text contrast over those line colors remains 15.34:1 light (`#17201e`) and 16.84:1 dark (`#ffffff`).

A project-owned selector now reveals theme-generated heading-anchor spans whenever their H1/H2/H3 contains keyboard focus:

```css
.contractor-page :is(h1, h2, h3):focus-within > span { opacity: 1 !important; }
```

## Procedure

1. Updated only `assets/css/custom.css`: light/dark foreground-overlay opacity and the focused-heading-anchor rule.
2. Ran `hugo --cleanDestinationDir --noBuildLock` to regenerate tracked `public/`.
3. Applied the documented text-only trailing-whitespace normalization to generated HTML, XML, and JSON under `public/`.
4. Built to a temporary destination, applied the same normalization, and compared it with `public/` excluding `.DS_Store`; no differences were reported.
5. Ran static Python assertions for the card contract, one-H1 structure, email CTA, canonical Services route, focused-anchor CSS in the generated bundle, effective contour composition, and AA contrast.
6. Ran `git diff --check`, staged-file check, and Blowfish submodule cleanliness check.

## What this supports

- The contour background is substantially more perceptible than the reviewed 1.28%/1.92% treatment while preserving AA text contrast.
- Keyboard focus on generated heading-anchor links reveals the otherwise hover-hidden anchor affordance.
- Services retains its exact four-card contract, H1, CTA, and route behavior.
- Generated `public/` matches a normalized fresh Hugo build; no staged files or Blowfish-submodule changes exist.

## Limits

No browser or assistive-technology executable was available. Effective opacity and contrast are calculated from CSS/SVG composition; actual visual prominence and keyboard focus painting still require a browser/device pass.

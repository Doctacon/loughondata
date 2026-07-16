Status: recorded
Created: 2026-07-14
Updated: 2026-07-14
Relates-To: .10x/tickets/2026-07-12-services-cards-and-contours.md, .10x/specs/contractor-site-v1.md, .10x/specs/visual-system-v1.md

# Services cards and contour validation

## What was observed

The Services page now renders four semantic numbered offer cards rather than a run of article headings. Each card contains its approved title, `Best for` problem, and `You leave with` artifact in a `<dl>` within a list item. The output retains one H1, the existing email CTA, server-rendered dark default, and appearance-switcher markup.

The global contour background overlay changed from 94% to 84% opacity in light appearance and 76% in dark appearance. The existing `static/img/bg-pattern.svg` remains the only terrain asset; no external asset, font, script, or Blowfish change was introduced.

A normalized temporary Hugo build matched tracked `public/` exactly, excluding `.DS_Store` files.

## Procedure

1. Ran `hugo --cleanDestinationDir --noBuildLock` to refresh tracked `public/`.
2. Normalized trailing whitespace only in generated `public/**/*.html`, `public/**/*.xml`, and `public/**/*.json`.
3. Built Hugo to a temporary destination with a temporary cache, applied the identical normalization, and ran `diff -qr --exclude='.DS_Store' public <temporary-output>`.
4. Ran Python rendered-output assertions against `services/index.html` for one H1, the services offer list, all approved card strings, CTA, dark default, appearance switcher, and absence of Medium Zoom/remote script references.
5. Calculated contrast for the custom text/action pairs: `#17201e/#f7f9f7` 15.73:1, `#ffffff/#101515` 18.42:1, `#1f5d50/#f7f9f7` 7.24:1, and `#14f3d9/#101515` 13.03:1.
6. Ran `git diff --check`, checked for staged files, and checked that `themes/blowfish` was clean.

## What this supports

This supports all implementation acceptance criteria for `.10x/tickets/2026-07-12-services-cards-and-contours.md` at generated-output and static-CSS level: visible-quiet contour treatment, semantic offer-card content/order, responsive two-column-at-768px layout with single-column fallback, retained primary controls, no new dependency, and synchronized tracked output.

## Limits

No browser/device visual pass was available to measure perceived contour intensity or live 320px layout. The contour visibility claim is supported by the deliberate overlay reduction and preserved asset, while responsive behavior is supported by CSS/static markup inspection rather than screenshot or browser measurement.

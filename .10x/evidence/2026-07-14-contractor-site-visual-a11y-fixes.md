Status: recorded
Created: 2026-07-14
Updated: 2026-07-14
Relates-To: .10x/tickets/done/2026-07-12-contractor-site-visual-foundation.md, .10x/specs/contractor-site-v1.md, .10x/specs/visual-system-v1.md

# Visual accessibility-fix validation

## What was observed

The project-owned visual accessibility fixes rendered successfully with Hugo `v0.160.1+extended`.

- The temporary build rendered `/`, `/about/`, `/services/`, `/projects/`, `/projects/databox/`, and `/posts/`.
- Each checked primary contractor route rendered exactly one H1.
- The rendered About carousel has no `data-twe-ride="carousel"` or `data-twe-interval` attribute, so it does not auto-advance. Its six image alternatives are derived from the configured captions: Data Saturday #52 — Oslo; Datamon from Zenlytics at dbt Coalesce 2023; With Bill Inmon at WWDVC 2023; dbt Coalesce 2022 — New Orleans; Suomenlinna — Helsinki Data Vault training; and AI Council 2026.
- The rendered mobile navigation contains a keyboard-focusable `peer sr-only` checkbox with `aria-label="Open navigation"`; its visible label receives a focus-visible outline through `#mobile-menu-toggle:focus-visible + label`.
- Rendered HTML starts with a server-rendered `dark` class on `<html>`, which establishes the dark default without JavaScript. The existing appearance script remains present and its light preference removes that class before the page body; its existing click handlers continue to toggle it.
- The generated CSS contains high-priority focus-visible outlines for interactive elements, including theme utility controls that use `outline-none` / `outline-transparent`.
- The generated stylesheet contains no `@font-face`; no font file or remote font dependency was introduced.
- `git diff --check`, `git diff --cached --quiet`, and `git -C themes/blowfish status --short` passed.

## Procedure

```sh
out=$(mktemp -d)
cache=$(mktemp -d)
hugo --destination "$out" --cacheDir "$cache" --cleanDestinationDir
python3 <static rendered-output assertions>
git diff --check
git diff --cached --quiet
test -z "$(git -C themes/blowfish status --short)"
```

The Python assertions verified required routes, H1 counts, carousel auto-ride/interval absence, caption-derived alternatives, server-rendered dark class, mobile-menu control markup, generated focus rules, and absence of `@font-face`.

## What this supports

This supports the visual-foundation ticket’s keyboard reachability, non-essential motion, visible-focus, accessible-image-text, no-JavaScript dark-default, route-preservation, one-H1, and no-new-font-dependency requirements. It also supports the constraint that the Blowfish submodule remains unmodified.

## Limits

No browser executable was available for an interactive 320px viewport, actual keyboard traversal, localStorage light-preference toggle, or computed-style pass. The relevant behavior is supported by rendered markup, CSS selectors, and the existing theme appearance script, but browser interaction remains for integration review.

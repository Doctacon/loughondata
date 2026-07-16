Status: done
Created: 2026-07-12
Updated: 2026-07-14
Parent: None
Depends-On: .10x/specs/visual-system-v1.md

# Remove image zoom and make mobile navigation a disclosure

## Scope

Remediate the accessibility findings raised during homepage visual-rhythm review using the ratified interaction model.

This ticket owns:

- removing inherited click-to-enlarge/lightbox behavior so images remain readable in place without mouse-only activation or zoom animation; and
- replacing the mobile navigation’s misleading modal pattern with a labelled, keyboard-operable disclosure button that expands and collapses primary navigation.

## Explicit exclusions

- Building an image lightbox, modal dialog, focus trap, Escape/focus-restoration dialog behavior, new imagery, new routes, copy/visual-system changes, or Blowfish submodule edits.
- Changes to desktop navigation, page content, service/work structure, or the public output beyond regeneration required by implementation.

## Acceptance criteria

1. No rendered site page initializes or exposes click-to-enlarge/lightbox image behavior; static images retain useful `alt` text and existing captions.
2. Zoom-related transform/overlay motion is absent, so reduced-motion users do not receive inherited image-zoom animation.
3. On narrow screens, primary navigation has a visible, labelled button with correct `aria-expanded`/`aria-controls` behavior and is fully operable by keyboard.
4. The mobile navigation is ordinary disclosure content: it has no `role="dialog"`, `aria-modal`, fake modal close label, or focus-trap requirement.
5. Existing manual appearance controls remain reachable through the disclosed mobile navigation.
6. No Blowfish submodule files, remote dependencies, or routes are changed.
7. Tracked `public/` is synchronized using `.10x/knowledge/hugo-tracked-public-output.md`; a temporary Hugo build, rendered interaction-markup checks, diff hygiene, and independent review are recorded.

## Evidence expectations

- Record the source and rendered absence of Medium Zoom/lightbox initialization and related selectors.
- Record generated mobile-menu markup, keyboard/control semantics, appearance-control reachability, route checks, and public-output comparison.

## References

- `.10x/specs/visual-system-v1.md`
- `.10x/knowledge/hugo-tracked-public-output.md`
- `.10x/tickets/done/2026-07-12-homepage-visual-rhythm.md`
- `layouts/partials/header/components/mobile-menu.html`
- `layouts/partials/extend-head.html`
- `assets/css/custom.css`
- `themes/blowfish/layouts/partials/footer.html`

## Blockers

None. The user explicitly selected no image zoom and disclosure-based mobile navigation.

## Progress and notes

- 2026-07-12: Ticket opened after review findings and explicit interaction decisions; not yet executed.
- 2026-07-14: Replaced the inherited project output’s Medium Zoom initializer with a project-owned footer override that retains the existing footer behavior but omits image zoom. Replaced the mobile pseudo-modal with a labelled disclosure nav, close button, and Escape/focus-return behavior; nested menu children use native `details` disclosures. Regenerated and normalized tracked `public/`; temporary/output comparison, rendered interaction assertions, route/H1 checks, diff hygiene, and submodule cleanliness passed. Evidence: `.10x/evidence/2026-07-14-accessible-navigation-and-images-validation.md`.
- 2026-07-14: Applied review follow-up: set `disableImageZoom = true` and removed the no-longer-needed footer override; made the mobile menu visible without JavaScript and enhanced/collapsed only after JavaScript initializes; converted its full-screen pseudo-modal into an ordinary disclosure panel with no close/Escape/focus-restoration behavior; moved the mobile appearance switcher inside it; and made project-owned appearance click handling safe when storage writes fail. Regenerated and normalized tracked output. Evidence: `.10x/evidence/2026-07-14-accessible-disclosure-follow-up-validation.md`.
- 2026-07-14: Independent rereview passed: no-JavaScript baseline navigation, disclosure semantics, switcher reachability, image-zoom removal, reduced-motion behavior, and storage-failure handling all satisfy the ticket. Browser/device interaction remains a recorded evidence limit. Ticket complete.

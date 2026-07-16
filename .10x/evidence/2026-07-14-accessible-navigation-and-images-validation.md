Status: recorded
Created: 2026-07-14
Updated: 2026-07-14
Relates-To: .10x/tickets/done/2026-07-12-accessible-navigation-and-images.md, .10x/specs/visual-system-v1.md

# Accessible navigation and image behavior validation

## What was observed

A project-owned footer override removes Blowfish’s inherited `mediumZoom(...)` initializer without modifying the Blowfish submodule. Fresh and tracked rendered pages contain no Medium Zoom initialization, no `medium-zoom` markup, and no image lightbox behavior. Existing image alternatives and the About gallery captions remain rendered.

The project-owned mobile menu override now uses a button with `aria-controls="mobile-navigation"` and `aria-expanded="false"` to disclose an ordinary labelled `<nav>`. It contains no `role="dialog"` or `aria-modal`. A separate close button and Escape handling collapse the disclosure and restore focus to the opener. The mobile appearance switcher remains in the disclosed navigation markup.

`hugo --cleanDestinationDir` generated 155 pages. Generated text output was mechanically normalized for trailing whitespace under `public/**/*.html`, `public/**/*.xml`, and `public/**/*.json`. A separately built and identically normalized temporary output matched tracked `public/` excluding `.DS_Store`.

## Procedure

1. Read the governing ticket, visual specification, generated-output procedure, existing project overrides, and referenced Blowfish footer/menu source.
2. Add project-owned `layouts/partials/footer.html` without the inherited Medium Zoom initializer.
3. Replace the project-owned mobile menu pseudo-modal with disclosure markup and add project-owned disclosure behavior to `layouts/partials/extend-head.html`.
4. Build first to temporary output and assert rendered absence of zoom initialization/modal semantics, mobile button/control semantics, appearance-switcher reachability, required route presence, image text alternatives, and one H1 on checked primary pages.
5. Run `hugo --cleanDestinationDir`, normalize generated tracked text output, build a second temporary output, normalize it identically, and compare output directories.
6. Run source/rendered Medium Zoom initializer checks, `git diff --check`, staged-file check, and Blowfish-submodule status check.

## What this supports

This supports ticket acceptance criteria 1–6 and the generated-output portion of criterion 7. The ticket still requires an independent review before closure.

## Limits

No browser executable was available for real keyboard traversal, screen-reader announcement, mobile viewport layout, or image interaction checks. Rendered markup, source behavior, and Hugo output checks do not substitute for a browser/device pass.

Status: recorded
Created: 2026-07-14
Updated: 2026-07-14
Relates-To: .10x/tickets/done/2026-07-12-accessible-navigation-and-images.md, .10x/specs/visual-system-v1.md

# Accessible disclosure follow-up validation

## What was observed

The project now disables Blowfish image zoom through `disableImageZoom = true`; fresh rendered output contains neither the Medium Zoom script/style nor an initializer. The project footer override used only to omit initialization was removed.

The mobile menu is an ordinary disclosure. Without JavaScript, its primary navigation is present and visible in the rendered document while the otherwise nonfunctional trigger is hidden through `html:not(.js)`. On `DOMContentLoaded`, the project script adds `js`, collapses the menu, and updates a native button’s `aria-expanded` state as it controls the navigation. The appearance switcher is inside the disclosed navigation. There is no dialog/modal markup, close control, Escape handler, or focus-trap behavior.

The appearance-control capture handler replaces Blowfish’s unguarded click handler and catches storage write failures. A Node VM harness confirmed a read-allowed/write-denied `localStorage` configuration toggles appearance without throwing.

Tracked `public/` matches a normalized fresh Hugo output exactly except `.DS_Store` files.

## Procedure

1. Ran `hugo --cleanDestinationDir`, normalized trailing whitespace only in `public/**/*.html`, `public/**/*.xml`, and `public/**/*.json`, then compared `public/` to an independently built and identically normalized temporary destination.
2. Parsed rendered `public/index.html` to verify no Medium Zoom script/style/initializer, no modal strings or close control, visible no-JavaScript navigation baseline, switcher nesting, required route H1 counts, and absent `/work/` route.
3. Executed the rendered project appearance script in a Node `vm` harness with `localStorage.getItem()` allowed and `setItem()`/`removeItem()` throwing `SecurityError`; invoked the captured mobile-switcher click and asserted the dark class toggled without an exception.
4. Ran `git diff --check` and confirmed the Blowfish submodule had no local changes.

## What this supports

This supports every acceptance criterion in `.10x/tickets/done/2026-07-12-accessible-navigation-and-images.md` at the generated-markup and harness level: no image zoom, a no-JavaScript-safe disclosure baseline, ordinary non-modal mobile navigation, reachable mobile appearance control, preserved routes, no new dependency, and synchronized output.

## Limits

No browser or assistive-technology runtime was available. Keyboard traversal, computed layout at 320px, and visual focus rendering remain supported by semantic markup/CSS inspection rather than an interactive browser pass.

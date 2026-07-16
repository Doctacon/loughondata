Status: recorded
Created: 2026-07-14
Updated: 2026-07-14
Relates-To: .10x/tickets/done/2026-07-12-contractor-site-visual-foundation.md, .10x/specs/contractor-site-v1.md, .10x/specs/visual-system-v1.md

# Contractor-site visual foundation validation

## What was observed

The visual-foundation implementation added project-owned Hugo templates and CSS only. A temporary Hugo build rendered the approved contractor routes successfully and each rendered one H1:

- `/` — `Make your data systems dependable.`
- `/services/` — `Reliable data systems, built for the team that runs them.`
- `/about/` — `About Lough on Data`
- `/projects/` — `Work`
- `/projects/databox/` — `Databox`

The generated home page contains the copy-first contractor hero before the portrait in document order. The generated document declares `data-default-appearance="dark"`, and the existing appearance switcher remains rendered. The bundled CSS contains the dark and light color rules, amber CTA rule, explicit `:focus-visible` styles, 768px hero grid breakpoint, 767px narrow layout rules, and a `prefers-reduced-motion` override.

The generated output contains no `@font-face`, Google Fonts, gstatic, WOFF, TTF, or OTF declarations. The implementation uses only the approved system-first font stack.

## Procedure

1. Ran:

   ```sh
   tmp=$(mktemp -d) && hugo --destination "$tmp" --cacheDir "$tmp/cache" --cleanDestinationDir
   ```

   Result: exit 0; Hugo v0.160.1+extended generated 155 pages.

2. Counted `<h1>` elements in rendered `index.html`, `services/index.html`, `about/index.html`, `projects/index.html`, and `projects/databox/index.html`.

   Result: one H1 on each route.

3. Confirmed the required routes exist, `/work/` does not exist, and inspected generated home markup for the hero/portrait order and appearance-switcher marker.

4. Searched generated output for remote/bundled font declarations and generated CSS for `focus-visible`, `prefers-reduced-motion`, and responsive hero selectors.

5. Ran `git diff --check` and `git diff --cached --quiet`.

   Result: exit 0; no whitespace errors and no staged changes.

## What this supports

The evidence supports the visual-foundation ticket’s route, heading hierarchy, appearance-switcher, system-font, responsive-CSS, reduced-motion, and no-submodule-change acceptance criteria. It also supports preserving the existing project URLs while providing the custom Work visual presentation.

## Limits

No browser executable or Playwright/Puppeteer installation was available in this environment, so this record does not include pixel screenshots or an interactive viewport measurement at 320px. The narrow-layout claim is supported by generated CSS inspection and the absence of fixed desktop layout widths in the custom contractor selectors, not browser automation. A final integration review should perform browser rendering if it becomes available.

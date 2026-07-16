Status: recorded
Created: 2026-07-14
Updated: 2026-07-14
Relates-To: .10x/tickets/done/2026-07-12-contractor-site-integration.md, .10x/specs/contractor-site-v1.md, .10x/specs/visual-system-v1.md

# Contractor-site integration validation

## What was observed

The tracked `public/` directory was stale relative to the updated Hugo source. `hugo --cleanDestinationDir` completed successfully with Hugo `v0.160.1+extended` and generated 155 pages. The refreshed output includes the new Services route and contractor-site rendering.

Generated output initially contained trailing whitespace from inherited Blowfish menu rendering; this caused `git diff --check` to fail because the refreshed generated files were newly changed. A mechanical trailing-whitespace normalization was applied only to generated `public/**/*.html`, `public/**/*.xml`, and `public/**/*.json` files. A second temporary Hugo build received the identical normalization and matched `public/` exactly apart from `.DS_Store` files.

The tracked-output refresh removes only stale generated artifacts: five `public/about/gallery/Pasted image *.png` files that have no corresponding source resources, three obsolete fingerprinted CSS bundles replaced by the current bundle, and obsolete paginator pages. The generated diff contains 173 changed files overall; the `public/` portion has 62,056 added and 63,049 deleted text lines because the root layout and fingerprinted assets are shared across generated pages.

A final clean temporary build and rendered-output assertions passed:

- `/`, `/services/`, `/about/`, `/projects/`, `/projects/databox/`, and `/posts/` exist.
- The five contractor surfaces each render exactly one H1, have the required email CTA, and contain no `Harness` text.
- Home contains the approved hero copy, legal disclosure, Services/Work/Journal/About navigation, server-rendered dark class, and appearance-switcher markup.
- `/work/` is absent; `/projects/` and `/projects/databox/` remain canonical output paths.
- Absolute internal route/static links across generated HTML resolve.
- No generated output refers to a remote font/CDN, font-face declaration, or font binary.
- `git diff --check` passes; there are no staged files; `themes/blowfish` is clean.

## Procedure

1. Read the governing ticket, active specs, completed child tickets, and prior evidence.
2. Count tracked public files and compare the pre-build public diff; run `hugo --cleanDestinationDir` to synchronize the tracked output.
3. Inspect generated deletions and asset replacements with `git diff --stat`, `git diff --name-status -- public`, and `git diff --numstat -- public`.
4. Normalize trailing whitespace mechanically in generated text output, then build to temporary output, apply the same normalization, and run `diff -rq --exclude='.DS_Store' public <temporary-output>`.
5. Run Python standard-library assertions for required routes, H1 count, navigation, CTAs, legal disclosure, no stale Harness claim, dark default, switcher presence, and absolute internal links.
6. Check the temporary output for remote font references; run `git diff --check`, staged-file check, and theme-submodule status check.

## What this supports

This supports all integration-ticket acceptance criteria and all active contractor-site specification criteria at the generated-output level. It also supports that the tracked `public/` artifact is synchronized to the current source after documented text normalization.

## Limits

No browser executable was available for interactive 320px layout, keyboard traversal, or appearance-toggle/local-storage behavior. Those behaviors were previously validated through rendered markup, CSS, and a Node storage-denied harness in `.10x/evidence/2026-07-14-appearance-storage-fallback-validation.md`; this record does not replace real-browser testing.

The generated-output normalization is a mechanical repository hygiene step, not Hugo configuration. A future direct Hugo build will reintroduce inherited trailing whitespace unless the same normalization is applied before committing `public/`.

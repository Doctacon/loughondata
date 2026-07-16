Status: recorded
Created: 2026-07-14
Updated: 2026-07-14
Relates-To: .10x/tickets/done/2026-07-12-remove-dormant-buymeacoffee-script.md, .10x/specs/visual-system-v1.md

# Buy Me a Coffee removal validation

## What was observed

The project-owned base layout no longer contains the dormant Buy Me a Coffee widget conditional or its `cdnjs.buymeacoffee.com` script source.

A canonical `hugo --cleanDestinationDir` build completed successfully with Hugo `v0.160.1+extended` and refreshed tracked `public/`. Generated HTML/XML/JSON text was normalized for inherited trailing whitespace according to `.10x/knowledge/hugo-tracked-public-output.md`.

A separate temporary Hugo build received the same normalization and matched `public/` exactly apart from `.DS_Store` files.

Rendered checks passed for `/`, `/services/`, `/about/`, `/projects/`, `/projects/databox/`, and `/posts/`: each checked page contains one H1, starts with the server-rendered dark class, and contains appearance-switcher markup. No generated HTML contained a Buy Me a Coffee reference, remote script source, remote font reference, or `@font-face` declaration.

`git diff --check` passed; no files are staged; the Blowfish submodule is clean.

## Procedure

1. Removed only the dormant widget block from `layouts/_default/baseof.html`.
2. Ran `hugo --cleanDestinationDir` and normalized trailing whitespace only in generated `public/**/*.html`, `public/**/*.xml`, and `public/**/*.json`.
3. Ran a fresh temporary Hugo build, applied the same normalization, and compared it with `public/` using `diff -rq --exclude='.DS_Store'`.
4. Ran Python rendered-output assertions for required routes, one-H1 hierarchy, dark class, appearance-switcher markup, and absence of remote script/font dependencies.
5. Searched source and generated output for Buy Me a Coffee/cdnjs remnants; ran diff, staged-file, and submodule-hygiene checks.

## What this supports

This supports all acceptance criteria in `.10x/tickets/done/2026-07-12-remove-dormant-buymeacoffee-script.md`: the dormant remote integration is removed; the generated artifact is synchronized; required base-layout behavior remains; and no remote script/font dependency is emitted.

## Limits

This is static/build evidence. It does not replace real-browser testing of responsive layout, keyboard traversal, or theme-switch interaction.

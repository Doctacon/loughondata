Status: recorded
Created: 2026-07-14
Updated: 2026-07-14
Relates-To: .10x/tickets/done/2026-07-12-contractor-site-visual-foundation.md

# Appearance switcher storage-denial fallback validation

## What was observed

Blowfish's bundled `appearance.js` reads `localStorage.getItem("appearance")` before registering its desktop and mobile appearance-switcher handlers. In a storage-denied environment, that read throws and prevents the upstream handlers from being registered.

`layouts/partials/extend-head.html` now installs a project-owned `DOMContentLoaded` fallback only when `window.updateMermaidTheme` is absent, which is the signal that Blowfish's appearance script did not initialize. The fallback toggles the existing desktop and mobile switcher controls without reading or writing storage. It preserves the standard Blowfish path when the upstream script initialized successfully.

## Procedure

1. Built the site to a temporary destination with:

   ```sh
   hugo --destination "$(mktemp -d)" --cacheDir "$(mktemp -d)" --cleanDestinationDir
   ```

2. Loaded the rendered inline fallback and rendered appearance bundle into a Node `vm` harness.
3. Configured the harness's `localStorage.getItem`, `setItem`, and `removeItem` to throw `SecurityError`.
4. Confirmed the upstream appearance bundle threw under that condition, then executed the project fallback and fired both rendered switcher controls.
5. Confirmed each control toggled the root `dark` class without throwing.
6. Ran `git diff --check` and `git diff --cached --quiet`.

## Results

- Temporary Hugo build passed.
- The Node harness printed `storage-denied appearance fallback passed`.
- `git diff --check` passed.
- No staged files were present.

## What this supports

The existing manual appearance controls remain operable when browser storage is denied, while normal stored-preference behavior remains owned by Blowfish because the fallback is skipped after successful upstream initialization.

## Limits

The Node harness models the relevant DOM, storage, and event behavior; it is not a browser interaction test. A real browser/device pass remains the best additional evidence for storage-denied behavior and appearance control interaction.

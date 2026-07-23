Status: active
Created: 2026-07-12
Updated: 2026-07-23

# GitHub contribution field log

## Purpose

Add a real, privacy-preserving public-proof block to the homepage before “Reliability is a system.” It presents a 12-month GitHub contribution calendar for `Doctacon` as a restrained field log.

## Behavior

- Build-time local generation queries GitHub GraphQL with a read-only token that is never committed or published.
- The generated static snapshot contains date, contribution count, and intensity only.
- On refresh failure, the existing committed snapshot remains and the site build succeeds.
- A GitHub Actions workflow MUST refresh the snapshot daily and support an on-demand manual run. It MUST commit only changed snapshot data to `main`; deployment remains the responsibility of the existing repository-hosting integration.
- The scheduled workflow MUST use GitHub Actions’ built-in `GITHUB_TOKEN` and therefore represent public activity only. It MUST NOT use or require a personal access token, and it MUST NOT surface private-contribution totals.
- Tiles represent GitHub **contributions**, not commit-only counts.
- Hover and keyboard focus perform a short reduced-motion-safe flip revealing date and contribution count. Zero-contribution days reveal a white `0`.
- The block links to the public GitHub profile and remains meaningful without JavaScript.

## Visual contract

Use the approved field-log motif: field-notebook labels, quiet topographic language, forest intensity gradient, and amber trail-marker hover/focus treatment. It must not imitate a dashboard or make hunting-themed data claims.

## Constraints

- No browser-side GitHub request, tracking, or token exposure.
- The workflow may have only the repository `contents: write` permission needed to persist a changed snapshot; it must have no personal secret or third-party action dependency.
- Accessible semantic calendar/grid, keyboard access, visible focus, and reduced-motion fallback.
- No remote dependencies or Blowfish-submodule modifications.

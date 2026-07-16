Status: done
Created: 2026-07-12
Updated: 2026-07-14
Parent: None
Depends-On: .10x/specs/visual-system-v1.md

# Remove dormant Buy Me a Coffee CDN script

## Scope

Remove the disabled conditional `cdnjs.buymeacoffee.com` script block from the project-owned `layouts/_default/baseof.html` override. Preserve every other required base-layout behavior, including the server-rendered dark default, Hugo structural blocks, and current rendered page behavior.

## Explicit exclusions

- Enabling, replacing, or integrating Buy Me a Coffee or any other third-party widget.
- Modifying the Blowfish submodule, page content, routes, visual styles, navigation, font handling, or appearance behavior.

## Acceptance criteria

1. `layouts/_default/baseof.html` contains no Buy Me a Coffee, `buymeacoffee`, or `cdnjs` integration.
2. Fresh rendered output contains no remote script source or font dependency.
3. The server-rendered dark default, manual appearance controls, required routes, and one-H1 page hierarchy remain intact.
4. `public/` is synchronized with source per `.10x/knowledge/hugo-tracked-public-output.md`; temporary build, rendered checks, and `git diff --check` pass.

## Evidence expectations

Record the source/remnant search, temporary Hugo build, generated-output comparison, and rendered checks.

## References

- `layouts/_default/baseof.html`
- `.10x/specs/visual-system-v1.md`
- `.10x/knowledge/hugo-tracked-public-output.md`

## Blockers

None. The dormant remote integration conflicts with the project’s open-source-first constraint and is not part of approved site behavior.

## Progress and notes

- 2026-07-12: Ticket opened from independent review finding; not yet executed.
- 2026-07-14: Removed only the dormant Buy Me a Coffee/cdnjs block from the project base layout. Rebuilt and normalized tracked `public/`; a normalized temporary build matched it. Required route/H1, dark-default, appearance-switcher, remote-dependency, diff, staged-file, and submodule checks passed. Evidence: `.10x/evidence/2026-07-14-buymeacoffee-removal-validation.md`.

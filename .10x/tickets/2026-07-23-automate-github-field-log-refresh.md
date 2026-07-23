Status: active
Created: 2026-07-23
Updated: 2026-07-23
Parent: None
Depends-On: .10x/specs/github-field-log.md

# Automate GitHub field-log refresh

## Scope

Add a repository-native GitHub Actions workflow that refreshes the committed public contribution snapshot for `Doctacon` daily and on manual dispatch. It must use only the built-in GitHub Actions token and commit a new snapshot only when its content changes.

## Exclusions

- Private-contribution totals and personal access tokens.
- Browser-side GitHub requests.
- Deployment-provider configuration or a separate deployment workflow.
- Changes to field-log rendering, styling, or interaction.

## Acceptance criteria

1. A scheduled workflow runs daily and can be triggered with `workflow_dispatch`.
2. It refreshes `data/github_contributions.json` using the existing repository script and `GITHUB_TOKEN`.
3. It grants only `contents: write` repository permission and uses no personal secret or third-party action.
4. It creates a commit only when the snapshot differs; a failed refresh preserves the existing snapshot and fails the workflow.
5. The resulting snapshot remains public-activity-only and no token is present in committed output.
6. The workflow YAML and a local snapshot-refresh invocation are validated.

## Evidence expectations

Record the workflow configuration, local refresh result, and Hugo build result, with the limitation that scheduled execution cannot be witnessed until GitHub runs it.

## Blockers

None.

## Assumption provenance

- **User-ratified:** public activity only; daily automatic refresh.
- **Record-backed:** the snapshot, script, and no-browser-request contract are governed by `.10x/specs/github-field-log.md`.
- **Mechanical default:** schedule at 06:17 UTC to avoid a top-of-hour herd; manual dispatch remains available.

## Progress and notes

- 2026-07-23: Opened after the user ratified public-only activity. The current site is static because `scripts/refresh-github-contributions.sh` has no workflow caller.
- 2026-07-23: Added `.github/workflows/refresh-github-field-log.yml` with daily 06:17 UTC and manual triggers. It uses the built-in `GITHUB_TOKEN`, clones through `gh` without an action dependency, refreshes the snapshot, and commits only a changed snapshot. Updated the refresh script to expose `GITHUB_TOKEN` to `gh` and fail nonzero if its API request fails.
- 2026-07-23: Validated script syntax, workflow structure (schedule, manual dispatch, and only `contents: write`), and the failure path preserves the snapshot while returning nonzero. An authenticated local refresh returned 369 days from 2025-07-20 through 2026-07-23; the temporary snapshot output was restored so the workflow, rather than this implementation task, performs the first committed refresh. `hugo --renderToMemory` completed successfully. Scheduled execution remains to be observed after merge.

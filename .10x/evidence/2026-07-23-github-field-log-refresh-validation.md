Status: recorded
Created: 2026-07-23
Updated: 2026-07-23
Relates-To: .10x/tickets/2026-07-23-automate-github-field-log-refresh.md, .10x/specs/github-field-log.md

# GitHub field-log refresh validation

## What was observed

The repository-local workflow declares daily execution at 06:17 UTC, manual dispatch, and only `contents: write` permission. It contains no `uses:` action dependency. The refresh script accepts the Actions-provided token through `GH_TOKEN`, fails nonzero on an API error, and leaves the committed snapshot unchanged in that failure case.

## Procedure

Run from the repository root on 2026-07-23:

1. `bash -n scripts/refresh-github-contributions.sh` completed successfully.
2. A Python static-contract check verified `workflow_dispatch`, `17 6 * * *`, `contents: write`, built-in `GITHUB_TOKEN`, snapshot-only diff gating, and the absence of `uses:` in `.github/workflows/refresh-github-field-log.yml`.
3. With `GH_TOKEN`, `GITHUB_TOKEN`, and GitHub CLI configuration removed, `./scripts/refresh-github-contributions.sh` exited nonzero. SHA-256 hashes before and after were equal, proving the failed refresh preserved `data/github_contributions.json`.
4. An authenticated local refresh returned 369 valid day records from `2025-07-20` through `2026-07-23`; its temporary snapshot output was restored rather than committed.
5. `hugo --renderToMemory` completed successfully in 230 ms.
6. `git diff --check` completed successfully.
7. After commit `59bca18` reached `main`, `gh workflow run refresh-github-field-log.yml --repo Doctacon/loughondata` triggered run `30036116398`. The `refresh` job completed successfully in 14 seconds (started `2026-07-23T18:59:47Z`, completed `2026-07-23T19:00:01Z`) and created `6d3e957` (`Refresh GitHub contribution snapshot`). Pulling that commit produced a 369-day snapshot from `2025-07-20` through `2026-07-23`.

## What this supports

The automation satisfies the workflow configuration, failure behavior, static-site compatibility, and public-output safety requirements. The workflow does not use a personal credential or a third-party action.

## Limits

The daily cron has not yet elapsed, so this record proves the manual-dispatch path rather than a scheduled invocation. The scheduled configuration was statically checked.

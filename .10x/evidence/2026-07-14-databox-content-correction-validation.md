Status: recorded
Created: 2026-07-14
Updated: 2026-07-14
Relates-To: .10x/tickets/done/2026-07-12-contractor-site-content.md, .10x/specs/contractor-site-v1.md

# Databox content-correction validation

## What was observed

The Databox content previously described MotherDuck as a current target and listed it as a warehouse option. Current public Databox documentation states that MotherDuck is no longer a supported backend, so the published content was corrected to describe only the local DuckDB path.

The correction removes the `motherduck` tag, changes the architecture wording to a local DuckDB path, and lists DuckDB alone as the warehouse. The two Work/Databox visible email CTA labels now exactly read `Tell me what’s brittle`.

A temporary Hugo build completed successfully (155 pages, 997 ms). Its rendered `/projects/` and `/projects/databox/` pages contain the approved CTA wording. The Databox source and rendered Databox page contain no `motherduck` text. `git diff --check` passed and `git diff --cached --quiet` confirmed no staged files.

## Procedure

1. Read the content ticket, current Databox and Work content, and the prior content-validation evidence.
2. Applied only the review corrections to `content/projects/databox/index.md` and `content/projects/_index.md`.
3. Built into temporary output and cache directories outside the repository:

   ```sh
   hugo --destination "$out_dir" --cacheDir "$cache_dir" --cleanDestinationDir
   ```

4. Asserted the source and rendered Databox page do not include `motherduck`, that both rendered project pages include `Tell me what’s brittle`, and that the expected project routes exist.
5. Ran `git diff --check` and `git diff --cached --quiet`.

## What this supports

This supports the corrected current Databox capability description and exact primary CTA wording on the two reviewed Work pages.

## Limits

- This does not resolve the duplicate-H1 review finding. That template-level heading hierarchy issue is explicitly handed to `.10x/tickets/done/2026-07-12-contractor-site-visual-foundation.md`.
- The build does not prove production deployment, email-client behavior, or GitHub shortcode availability under future API/network conditions.

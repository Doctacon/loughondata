Status: recorded
Created: 2026-07-14
Updated: 2026-07-14
Relates-To: .10x/tickets/done/2026-07-12-contractor-site-content.md, .10x/specs/contractor-site-v1.md

# Contractor-site content validation

## What was observed

The content-ticket changes modify these source/configuration paths:

- `content/_index.md`
- `content/services/index.md`
- `content/projects/_index.md`
- `content/projects/databox/index.md`
- `content/about/index.md`
- `config/_default/menus.en.toml`
- `config/_default/languages.en.toml`
- `config/_default/params.toml`

`../turbo-search/README.md` was inspected as the source for the Buoy Search card. Its public remote is `git@github.com:Doctacon/buoy-search.git`. The README supports the published description that Buoy creates a reviewed, incremental index from public websites, public GitHub repositories, or local documents, and returns citable source chunks.

A Hugo production build completed successfully in 914 ms using Hugo `v0.160.1+extended`. It rendered temporary output outside the repository and confirmed these routes:

- `/`
- `/services/`
- `/about/`
- `/projects/`
- `/projects/databox/`
- `/posts/`

Rendered checks found the approved homepage hero and “Tell me what’s brittle” CTA, the Services platform-assessment offer, Buoy Search on Work, the Quire LLC footer disclosure, and no `Harness` text in About. The current homepage did not render a recent-post card after `homepage.showRecent` was set false.

`git diff --check` passed. `git diff --cached --quiet` exited successfully, confirming no staged files.

## Procedure

1. Read the owning ticket and active contractor-site specification/brand decision.
2. Inspected the public Buoy source at `../turbo-search/README.md` and confirmed its GitHub remote.
3. Ran the following, with both Hugo output and cache directed to temporary directories outside the repository:

   ```sh
   hugo --destination "$out_dir" --cacheDir "$cache_dir" --cleanDestinationDir
   ```

4. Asserted the expected rendered routes exist and searched rendered HTML for required content and stale employer text.
5. Ran:

   ```sh
   git diff --check
   git diff --cached --quiet
   ```

## What this supports

This supports the content ticket’s claims that the approved content/configuration changes parse and render in Hugo, required routes remain present, the public navigation/content routes can be generated, and key approved messages/legal boundaries appear in rendered output.

## Limits

- This is not a browser, mobile-layout, light-theme, keyboard, or visual-design validation; those are owned by `.10x/tickets/done/2026-07-12-contractor-site-visual-foundation.md` and integration work.
- The temporary build proves renderability at this time but does not prove production deployment, email-client behavior, or GitHub API availability under all future build conditions.
- The public-site build uses the existing GitHub shortcode, so live GitHub metadata remains an external build-time dependency.

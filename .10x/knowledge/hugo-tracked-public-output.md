Status: active
Created: 2026-07-14
Updated: 2026-07-14

# Tracked Hugo public output

## Convention

This repository tracks Hugo's generated `public/` output. When source, layouts, assets, or configuration change, the corresponding generated output is part of the release diff and must be refreshed before review or commit.

## Reliable refresh procedure

1. Run `hugo --cleanDestinationDir` from the repository root.
2. Inspect `git diff --name-status -- public` and confirm that removals are stale generated artifacts rather than source-backed content.
3. Hugo/Blowfish can emit inherited trailing whitespace in generated HTML, XML, and JSON. Before committing the tracked output, mechanically normalize trailing whitespace only in generated text files under `public/`.
4. Build to a temporary output directory, apply the same text-only normalization, and compare it with `public/` while excluding `.DS_Store`.
5. Run `git diff --check` and retain generated output only when it matches the normalized fresh build.

## Limits

The whitespace normalization is repository hygiene, not a Hugo setting. A future Hugo refresh repeats it unless the build process is separately hardened.

## Evidence

- `.10x/evidence/2026-07-14-contractor-site-integration-validation.md`

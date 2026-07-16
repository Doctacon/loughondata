Status: done
Created: 2026-07-12
Updated: 2026-07-12
Parent: .10x/tickets/done/2026-07-12-contractor-site-v1.md
Depends-On: .10x/tickets/done/2026-07-12-contractor-site-content.md, .10x/tickets/done/2026-07-12-contractor-site-visual-foundation.md

# Verify contractor-site v1 integration

## Scope

Verify the assembled contractor-site release after the content and visual-foundation tickets are complete. This ticket owns only integration checks, targeted repairs required by those checks, evidence, and review preparation.

## Explicit exclusions

- New scope, new pages, new public claims, navigation/URL redesign, deployment changes, or new functionality beyond the active specifications.
- Closing the parent ticket or accepting unresolved review findings without explicit parent decision and evidence.

## Acceptance criteria

1. `hugo` completes successfully using the repository’s installed Hugo version.
2. The generated site exposes `/`, `/services/`, `/about/`, `/projects/`, `/projects/databox/`, and `/posts/` (the Journal) without broken internal navigation.
3. Rendered output contains the approved contractor identity, CTA, legal disclosure, Work label, and no stale claim of current Harness employment.
4. The required manual appearance switcher remains present and the project introduces no remote font dependency.
5. A targeted review maps all active-spec acceptance criteria to evidence or records a blocker/follow-up.

## Evidence expectations

- Create a dated evidence record with build command/output, route checks, and limits.
- Create a dated review record covering the completed diff and rendered output.

## References

- `.10x/specs/contractor-site-v1.md`
- `.10x/specs/visual-system-v1.md`
- `.10x/tickets/done/2026-07-12-contractor-site-content.md`
- `.10x/tickets/done/2026-07-12-contractor-site-visual-foundation.md`

## Blockers

Depends on completion of both prerequisite child tickets.

## Progress and notes

- 2026-07-12: Ticket opened; awaiting prerequisites.
- 2026-07-14: Verified the assembled contractor site; ran the canonical tracked-output Hugo build and refreshed stale `public/`. Made the project carousel ID deterministic so fresh builds are reproducible, then normalized inherited trailing whitespace in generated text output so `git diff --check` passes. Fresh rendered assertions passed for required routes, single-H1 hierarchy, navigation, CTA/legal/stale-Harness content, dark default, appearance-switcher presence, internal links, and no remote fonts. `public/` matches a normalized fresh temporary build; the Blowfish submodule is clean and no files are staged. Evidence: `.10x/evidence/2026-07-14-contractor-site-integration-validation.md`. Review: `.10x/reviews/2026-07-14-contractor-site-v1-integration.md` (pass). Residual browser/device and generated-whitespace-process risks are recorded there; parent ticket remains open for closure review.

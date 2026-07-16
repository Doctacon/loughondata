Status: done
Created: 2026-07-12
Updated: 2026-07-14
Parent: .10x/tickets/done/2026-07-12-contractor-site-v1.md
Depends-On: .10x/tickets/done/2026-07-12-contractor-site-content.md

# Implement contractor-site visual foundation

## Scope

Implement the approved visual system from `.10x/specs/visual-system-v1.md` against the contractor-site content structure. Use the existing Hugo + Blowfish architecture and targeted project overrides.

This ticket owns:

- the portrait-led, copy-first responsive contractor homepage layout;
- dark-first forest styling, accessible light appearance, and retention of the manual appearance switcher;
- refinement of the existing terrain pattern into a quieter supporting surface;
- system-first humanist-utility typography, without new font files or external font/CDN requests;
- reusable visual treatment for contractor page sections, service cards, work cards, email calls to action, operator section, and legal footer;
- resolving the existing duplicate-H1 output from content headings and Blowfish default templates, while preserving the approved hero message and a single unambiguous H1 per primary contractor route; and
- keyboard focus, responsive, contrast, and reduced-motion behavior required by the active specs.

## Explicit exclusions

- Writing or changing final product claims/copy except where markup requires mechanical wrapping.
- New logo work, custom typeface assets, remote font services, new terrain SVG assets, carousels, parallax, motion-led hero work, charts, or decorative pipeline diagrams.
- Route changes, redirects, deployment changes, or unrelated Blowfish-submodule modification.

## Acceptance criteria

1. The default presentation is dark forest; visitors can manually switch to an intentional, readable light presentation.
2. The main contractor hero is copy-first and portrait-led on wide and narrow viewports, with no competing system-diagram or terrain illustration.
3. Amber is the sole high-attention CTA/detail color, and the current terrain pattern is visibly quieter and limited to non-interactive background areas.
4. Typography uses the approved system-first stack and introduces no font asset or network dependency.
5. Primary CTA, secondary links, cards, navigation, and focus indicators remain visibly distinguishable in both appearances.
6. The layout is usable at 320px without horizontal scrolling; interactive elements are keyboard reachable; non-essential motion honors `prefers-reduced-motion`.
7. Each primary contractor route (`/`, `/services/`, `/about/`, `/projects/`, `/projects/databox/`) renders exactly one H1 that preserves its approved page/hero meaning.
8. Only project-owned Hugo overrides/assets/styles are changed; the Blowfish submodule is not modified.

## Evidence expectations

- Record paths changed and the commands/screenshots or rendered checks used to verify both appearances and narrow layout behavior.
- Record the Hugo asset/network inspection that supports the no-new-font-dependency claim.

## References

- `.10x/specs/contractor-site-v1.md`
- `.10x/specs/visual-system-v1.md`
- `assets/css/custom.css`
- `layouts/partials/home/profile.html`
- `layouts/partials/extend-head.html`
- `themes/blowfish/assets/css/schemes/forest.css`

## Blockers

None. Visual and behavior constraints are defined by the active specifications.

## Progress and notes

- 2026-07-12: Ticket opened; not yet executed.
- 2026-07-14: Added project-owned contractor home, section, and project templates; a system-font, dark-first forest CSS foundation; a quieter existing terrain pattern; CTA/focus/reduced-motion styling; and breakpoint behavior. The home uses a non-visible Markdown delimiter to place its approved copy-first hero beside the existing portrait without changing claims. Custom templates now allow content-owned H1s to be the single H1 on Home, Services, About, Work, and Databox. Temporary Hugo build, route/H1 checks, appearance-switcher markup check, font-declaration check, and `git diff --check` passed. Evidence: `.10x/evidence/2026-07-14-contractor-site-visual-foundation-validation.md`. Browser screenshot/interactive 320px verification was unavailable in this environment and remains a documented limit for integration review.
- 2026-07-14: Addressed the accessibility review findings with project overrides: a focusable mobile-menu checkbox and label focus treatment; a non-auto-advancing About gallery; caption-derived gallery alternatives; high-specificity focus-visible outlines; and a server-rendered dark class with head-time stored-light-preference handling. Corrected the AI Council caption key to match `aicouncil.jpeg`. Temporary Hugo/static assertions and diff/submodule hygiene checks passed. Evidence: `.10x/evidence/2026-07-14-contractor-site-visual-a11y-fixes.md`. Interactive browser verification remains a limit for the integration review.
- 2026-07-14: Added a project-owned fallback for the existing manual appearance switchers when Blowfish fails before binding them because browser storage is denied. The fallback is skipped after normal Blowfish initialization, preserves the server dark default, and avoids storage writes. A temporary Hugo build, a Node storage-denied DOM harness for both controls, `git diff --check`, and staged-file check passed. Evidence: `.10x/evidence/2026-07-14-appearance-storage-fallback-validation.md`.

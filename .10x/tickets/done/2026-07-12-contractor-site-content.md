Status: done
Created: 2026-07-12
Updated: 2026-07-12
Parent: .10x/tickets/done/2026-07-12-contractor-site-v1.md
Depends-On: None

# Write contractor-site content and information architecture

## Scope

Implement the content and navigation portion of `.10x/specs/contractor-site-v1.md` without changing visual templates or styling beyond what is strictly necessary for valid Hugo content.

This ticket owns:

- replacing the home page’s personal-blog-first copy with the approved contractor positioning and email-first conversion content;
- adding the dedicated Services page with the four ratified offers and focused-outcome engagement boundary;
- renaming the public navigation label from Projects to Work while preserving `/projects/` and `/projects/databox/` as canonical URLs;
- revising the existing Projects index and Databox content to function as the Work section and architecture-evidence case study;
- adding the approved Buoy Search project card using only public, supportable information;
- revising About to remove the current Harness employment claim and express the independent operator story without naming prior employers; and
- ensuring the Journal remains in primary navigation but is not promoted as contractor-homepage content.

## Explicit exclusions

- Visual system, CSS, layout-template, font, asset, theme-switcher, build-output, or deployment changes.
- Claims about named clients/employers, results, rates, certifications, testimonials, or engagement outcomes that are not supported by the governing records or inspected public project sources.
- A `/work/` route, project URL migration, or redirects.

## Acceptance criteria

1. The home page conveys the approved hero direction, identifies Lough on Data as an independent data-engineering practice for growing data teams and early-stage startups, and uses the approved email CTA wording: “Tell me what’s brittle.”
2. `/services/` presents Platform Assessment, Pipeline Buildout, Warehouse & Modeling, and Data Reliability, plus the ratified principles-first technical stance.
3. The engagement boundary says: “I take on focused projects and advisory engagements with a clear problem, scope, and next step.” It does not promise staff augmentation.
4. Public navigation labels the existing projects section as Work while `/projects/` and `/projects/databox/` stay canonical.
5. The Work section frames Databox as architecture evidence, includes a concise public Buoy Search card, and makes no unsupported performance or business-impact claims.
6. About leads with the approved useful-problems philosophy, presents an independent data-engineer identity, and contains no claim that Connor currently works at Harness or names Harness.
7. Primary pages link to `connor@loughondata.com` with a prompt for the prospect’s problem and context.
8. Footer/legal copy states: “Lough on Data is a trade name of Quire LLC.”

## Evidence expectations

- Record the changed content/configuration paths and the rendered route checks in an evidence record.
- Cite the inspected public source for Buoy Search copy.

## References

- `.10x/specs/contractor-site-v1.md`
- `.10x/decisions/lough-on-data-public-brand.md`
- `content/_index.md`
- `content/about/index.md`
- `content/projects/_index.md`
- `content/projects/databox/index.md`
- `config/_default/menus.en.toml`

## Blockers

None. All behavior and claim boundaries are governed by the active specification.

## Progress and notes

- 2026-07-12: Ticket opened; not yet executed.
- 2026-07-14: Replaced contractor-site content, added `/services/`, relabeled public navigation, revised Work/Databox/About copy, and configured the legal footer and homepage recent-post setting. Inspected `../turbo-search/README.md` and its `Doctacon/buoy-search` remote before using its public reviewed/incremental source-indexing claims. A Hugo build to temporary output passed; required routes and rendered content checks passed. Evidence: `.10x/evidence/2026-07-14-contractor-site-content-validation.md`.
- 2026-07-14: Corrected the review-identified current MotherDuck claim in Databox to its supported local DuckDB path, removed the stale tag/stack reference, and capitalized the two Work/Databox CTA labels. A temporary Hugo build and source/rendered assertions passed. Evidence: `.10x/evidence/2026-07-14-databox-content-correction-validation.md`. The duplicate-H1 template finding remains explicitly owned by `.10x/tickets/done/2026-07-12-contractor-site-visual-foundation.md`; no template or CSS change was made here.

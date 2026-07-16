Status: active
Created: 2026-07-12
Updated: 2026-07-14
Parent: None
Depends-On: .10x/specs/contractor-site-v1.md, .10x/specs/visual-system-v1.md

# Restore contours and turn Services into distinct offer cards

## Scope

Implement the ratified background and Services-page refinements:

- restore the existing elevation-contour pattern as a clearly visible but low-contrast background texture across broad page surfaces; and
- replace the Services page’s prose/heading presentation with four visually distinct numbered offer cards.

Every service card MUST use the approved contract:

| Offer | Best for | You leave with |
| --- | --- | --- |
| Platform Assessment | Data is unreliable but the team cannot see where the system or ownership is breaking down. | A system map and ranked priorities for the next fixes. |
| Pipeline Buildout | Critical data arrives through manual loads, brittle scripts, or silently failing jobs. | A working source-to-warehouse pipeline and operating runbook. |
| Warehouse & Modeling | Teams debate numbers because definitions, joins, or trusted metrics are unclear. | A trusted model layer with inspectable agreed definitions. |
| Data Reliability | Problems reach downstream people before anyone detects, diagnoses, or owns them. | Quality checks and a response runbook. |

## Explicit exclusions

- New service offerings, pricing, rates, new pages/routes, client claims, metrics, testimonials, external assets/fonts/dependencies, or Blowfish-submodule changes.
- Changes to Home, Work, About, Journal, mobile navigation, image behavior, or appearance controls beyond shared contour CSS required for the background correction.

## Acceptance criteria

1. Contours are visibly perceptible on broad page surfaces in dark and light appearance without compromising readable contrast, focus indicators, or CTA prominence.
2. `/services/` renders four visually distinct numbered cards; they are not one prose container or merely four headings.
3. Each card contains the exact approved offer name, Best for problem, and You leave with artifact, in readable semantic order.
4. Services remains usable at narrow width without horizontal scrolling and preserves a single H1, existing email CTA, manual appearance switching, and no-JavaScript readability.
5. No remote dependencies or new assets are introduced, and the Blowfish submodule remains unchanged.
6. Tracked `public/` is synchronized per `.10x/knowledge/hugo-tracked-public-output.md`; temporary Hugo build, rendered card/contour assertions, contrast/focus checks, diff hygiene, and independent review are recorded.

## Evidence expectations

- Record background CSS/color treatment and rendered Services card structure/order.
- Record responsive/static checks, light/dark markup checks, generated-output comparison, and review result.

## References

- `.10x/specs/contractor-site-v1.md`
- `.10x/specs/visual-system-v1.md`
- `.10x/knowledge/hugo-tracked-public-output.md`
- `content/services/index.md`
- `layouts/services/single.html`
- `layouts/partials/contractor/page.html`
- `assets/css/custom.css`
- `static/img/bg-pattern.svg`

## Blockers

None. Offer taxonomy, card copy, background visibility, and exclusions are user-ratified or governed by active specifications.

## Progress and notes

- 2026-07-12: Ticket opened after explicit implementation authorization; not yet executed.
- 2026-07-14: Replaced Services prose sections with four semantic numbered offer cards containing approved Best for and You leave with content. Reduced light/dark contour background overlays to restore visible quiet terrain texture without new assets. Regenerated and normalized tracked `public/`; temporary-build comparison, rendered content/CTA/H1 checks, contrast assertions, diff hygiene, staged-file check, and Blowfish-submodule check passed. Evidence: `.10x/evidence/2026-07-14-services-cards-and-contours-validation.md`.
- 2026-07-14: Awaiting independent review required by acceptance criterion 6 before closure.
- 2026-07-14: Corrected the review findings without widening scope. Light/dark foreground overlays now yield 4.8%/5.2% effective contour contribution after accounting for the SVG’s intrinsic 8% opacity, while calculated primary-text contrast remains 15.34:1/16.84:1. Added project-owned `:focus-within` visibility for generated heading anchors. Regenerated and normalized `public/`; fresh-build comparison, rendered card/H1/CTA/canonical checks, generated CSS check, diff hygiene, staged-file, and submodule checks passed. Evidence: `.10x/evidence/2026-07-14-services-contours-fix-validation.md`. Awaiting independent re-review before closure.

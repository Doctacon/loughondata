Status: done
Created: 2026-07-12
Updated: 2026-07-14
Parent: None
Depends-On: None

# Deliver contractor-site v1

## Scope

Coordinate the first contractor-focused release of loughondata.com under the active product and visual contracts:

- `.10x/specs/contractor-site-v1.md`
- `.10x/specs/visual-system-v1.md`
- `.10x/decisions/lough-on-data-public-brand.md`

The release converts the personal-blog-first Hugo home page into the public site for Lough on Data. It includes contractor-focused content, work and service presentation, the approved forest visual evolution, and final Hugo verification.

## Child tickets and sequence

1. `.10x/tickets/done/2026-07-12-contractor-site-content.md` — content, information architecture, and public navigation. Execute first.
2. `.10x/tickets/done/2026-07-12-contractor-site-visual-foundation.md` — templates, styling, and responsive/accessibility behavior. Depends on content.
3. `.10x/tickets/done/2026-07-12-contractor-site-integration.md` — Hugo build and acceptance verification. Depends on both prior tickets.

Child tickets are deliberately sequenced because the visual work consumes the finalized content structure and generated output must be verified only after both change sets are present.

## Acceptance criteria

- All child tickets are complete with recorded evidence mapped to their acceptance criteria.
- The active specifications accurately describe the assembled public site.
- The generated Hugo site builds successfully and preserves required legacy URLs.
- A review has no unresolved significant or critical findings, or any residual risk is explicitly recorded and accepted.

## Explicit exclusions

- New logo/brand-mark work, pricing, forms, scheduling, CRM/newsletter integration, analytics, deployment migration, and non-public client material.

## Blockers

None. Scope, public identity, contact address, canonical URLs, proof boundaries, visual direction, and acceptance criteria are governed by the referenced active records.

## Progress and notes

- 2026-07-12: Parent plan opened after explicit authorization to implement. Child tickets are defined but not yet executed.
- 2026-07-14: Content, visual foundation, and integration child tickets completed. Hugo generated 155 pages; canonical project URLs, contractor content, accessibility/static behavior, generated public output, and the no-new-font constraint were verified. Independent final review passed and is captured in `.10x/reviews/2026-07-14-contractor-site-v1-integration.md`.
- 2026-07-14: Closure review was prepared: evidence maps the child acceptance criteria and active contractor-site specs; review verdict is pass at `.10x/reviews/2026-07-14-contractor-site-v1-integration.md`. Residual browser/device verification and generated-output whitespace process risk are explicitly recorded there. Reusable generated-output procedure captured at `.10x/knowledge/hugo-tracked-public-output.md`.
- 2026-07-14: Closure blocked after discovering the legacy homepage draft and preview ticket. They conflicted materially with this release’s active specification and source: they required a fractional-data-engineer homepage and Harness as public credibility, whereas the approved current contract uses independent-data-engineer positioning and forbids naming Harness.
- 2026-07-14: User explicitly superseded the legacy contract. The draft moved to `.10x/specs/superseded/homepage-consulting-facelift.md`; its preview ticket was cancelled at `.10x/tickets/cancelled/2026-07-12-homepage-hugo-preview.md`; `.10x/knowledge/site-positioning.md` now reflects the governing contractor-site contract. Closure review is now complete: all child acceptance criteria map to evidence, the integration review passes, and residual verification limits are recorded. Parent closed.

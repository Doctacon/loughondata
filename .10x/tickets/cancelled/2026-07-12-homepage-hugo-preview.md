Status: cancelled
Created: 2026-07-12
Updated: 2026-07-14
Parent: None
Depends-On: .10x/specs/superseded/homepage-consulting-facelift.md, .10x/knowledge/site-positioning.md

# Homepage Hugo preview

## Scope

Implement a first-pass Hugo preview of the homepage consulting facelift so the draft can be viewed through `hugo server`.

In scope:

- Update the homepage content and/or homepage layout as needed to render the draft direction from `.10x/specs/superseded/homepage-consulting-facelift.md`.
- Keep the implementation homepage-only.
- Preserve existing posts/projects/about content.
- Keep email as the primary CTA via `mailto:connor@loughondata.com`.
- Keep tone personal/operator.
- Make the preview visually clearer than the current profile-and-recent-posts default, without redesigning the entire site.

Out of scope:

- Adding standalone Services or Contact pages.
- Changing legal/footer wording or adding Quire LLC references.
- Reworking global navigation.
- Editing theme submodule files under `themes/blowfish`.
- Publishing/deploying the generated site.

## Acceptance criteria

- The local Hugo homepage identifies Lough on Data as Connor Lough's public contracting business.
- The homepage leads with fractional data engineering for data leaders.
- The homepage makes email the primary CTA.
- The first service area is pipelines/warehouses.
- Harness appears only as high-level credibility and avoids sensitive/internal detail.
- Databox is linked as a project proof point.
- Writing/posts are preserved as proof/evidence.
- `hugo --minify` completes successfully.
- The user can preview the site with `hugo server -D`.

## Progress and notes

- 2026-07-12: Opened for implementing a local Hugo preview from the draft spec.
- 2026-07-14: Cancelled by explicit user direction. Its parent draft was superseded by `.10x/specs/contractor-site-v1.md`; the completed contractor-site release is broader and intentionally does not use fractional positioning or public Harness credibility.

## Blockers

None.

## References

- `.10x/specs/superseded/homepage-consulting-facelift.md`
- `.10x/knowledge/site-positioning.md`
- `content/_index.md`
- `layouts/partials/home/profile.html`

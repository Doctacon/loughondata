Status: done
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/tickets/done/2026-07-12-eliminate-woodpecker-glass-duplicate.md

# Show the static woodpecker perch on interior pages

## Scope

Keep the home page as the one-time arrival animation. Render the existing responsive, scenery-anchored static woodpecker perch on every other eligible desktop page, including services, work, individual project pages, about, and journal pages.

Interior pages MUST NOT load or run the flight sequence. The static perch MUST use the same source-coordinate transform, outer-gutter placement, viewport-fixed behavior, and reduced-motion-safe presentation as the settled homepage bird.

## Exclusions

- No flight replay outside the homepage.
- No changes to sprite art, scenery, runner layering, mobile eligibility, or page content.

## Acceptance criteria

1. A fresh homepage load plays the existing one-time flight and finishes at one static perch with no duplicate layers.
2. Representative interior pages show exactly one static perched bird and never initialize the flight sequence.
3. The interior-page perch remains fixed to the landscape after page scrolling and aligns with the tree at 2000×1100 and 3440×1440.
4. Small/ineligible layouts remain bird-free; no page has horizontal overflow.
5. Hugo build and headless-browser captures verify homepage plus representative list and single interior pages.

## Evidence expectations

Record routes, viewports, flight/non-flight state, perch coordinates, scroll checks, and build result.

## Blockers

None. User explicitly ratified the homepage-arrival and interior-static-perch behavior.

## Progress and notes

- 2026-07-12: User requested that every other page retain the final perched bird while only the homepage shows the flight.
- 2026-07-12: Added shared-layout inclusion with `.IsHome` state selection. Homepage flight and static interior perches were verified across home, services, projects, and Databox at 2000×1100 and 3440×1440; 800×800 remains bird-free. Evidence: `.10x/evidence/2026-07-12-woodpecker-interior-pages-validation.md`.
- 2026-07-12: Independent review passed. Review: `.10x/reviews/2026-07-12-woodpecker-interior-pages.md`.
- 2026-07-12: Moved the decorative partial into `layouts/_default/baseof.html`, removed the homepage-only inclusion, and used `.IsHome` to select flight versus immediate static perch. `hugo --cleanDestinationDir` passed; headless Chrome verified `/`, `/services/`, `/projects/`, and `/projects/databox/` at 2000×1100 and 3440×1440, plus ineligible `/services/` at 800×800. Evidence: `.10x/evidence/2026-07-12-woodpecker-interior-pages-validation.md`.

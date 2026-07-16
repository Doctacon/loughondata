Status: active
Created: 2026-07-12
Updated: 2026-07-12

# Lough on Data visual system v1

## Purpose and scope

This is a proposed visual-system brief for the contractor-site release governed by `.10x/specs/contractor-site-v1.md`. It evolves the existing dark forest identity into a clearer, more deliberate service-site system without requiring a new logo, illustration program, or external design dependency.

This draft is not implementation authority until approved.

## Direction

The visual voice is **quiet terrain**: a dark, grounded field surface with low-contrast contour texture, warm utility typography, and carefully limited amber emphasis. It should feel like a capable independent operator’s working environment—not a SaaS dashboard, generic consultancy, or decorative outdoor brand.

The existing portrait provides the hero’s human element. Terrain texture may support page backgrounds and dividers but must never compete with the hero message, body copy, or calls to action.

## Color proposal

The proposal retains a dark forest default and a functional light appearance. Values below have at least 7:1 contrast for their proposed primary text pairings.

| Role | Dark | Light | Use |
| --- | --- | --- | --- |
| Canvas | `#101515` | `#F7F9F7` | page background |
| Surface | `#212D2B` | `#FFFFFF` | cards, header, callout areas |
| Primary text | `#FFFFFF` | `#17201E` | headings and body text |
| Muted text | `#BCCECB` | `#51645F` | metadata and supporting copy |
| Spruce action | `#14F3D9` | `#1F5D50` | links and secondary emphasis |
| Amber emphasis | `#FBBF24` | `#FBBF24` | primary CTA fill, small highlight, terrain detail |

The existing `#fbbf24` elevation-contour background pattern is retained as a clearly visible but low-contrast supporting detail across broad page surfaces. It MUST provide texture without reducing text contrast or competing with primary actions. Amber must not be used for body text on light surfaces.

## Typography proposal

Use a system-first humanist-utility sans-serif stack in v1. It avoids a network font dependency, respects user/device settings, and provides a simple, durable foundation:

```css
ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif
```

Use weight, scale, line length, and spacing—not a display font—to establish hierarchy:

- Hero: bold but not ultra-heavy; compact line-height; max 2–3 lines on desktop.
- Section headings: semibold/bold, human-sized rather than marketing-scale.
- Body: 16–18px equivalent with generous line-height and a readable measure.
- Labels/metadata: small, uppercase only where it adds scanability; no monospace-first visual language.

A self-hosted open-source font may be evaluated later only if it creates a clear improvement over the native stack.

## Layout and components

- **Hero:** asymmetric two-column layout on wide screens; message and primary CTA occupy the dominant column, portrait the supporting column. It collapses to copy-first vertical flow on narrow screens.
- **Rhythm:** generous, predictable vertical spacing; content stays within a readable text measure even where card grids are wider.
- **Cards:** flat-to-subtle depth, thin low-contrast borders, 12–16px corner radius, no glassmorphism or heavy shadows. The homepage’s four service cards MUST use visible numeric identifiers and distinct composition rather than appearing as one prose block.
- **System maps:** use compact semantic HTML and CSS, not decorative charts. The reliability flow and Databox flow MUST remain legible in reading order without their visual connectors.
- **Databox proof panel:** use the existing public DAG image at a large enough size to read as an artifact, paired with only source-supported annotations and a clear Work/Databox link.
- **Primary CTA:** amber filled control with dark text; it must be visually distinct and retain a visible focus state.
- **Secondary CTA:** text/spruce link with an underline or equivalent persistent affordance.
- **Terrain texture:** use the existing pattern at restrained opacity and only on broad non-interactive background areas.
- **Motion:** no essential motion. Any hover/scroll transition must be short, subtle, and disabled or reduced for `prefers-reduced-motion`. The site MUST NOT use click-to-enlarge/lightbox image behavior; images remain readable in place with descriptive alt text and captions where needed.
- **Mobile navigation:** use a labelled disclosure button that expands/collapses primary navigation. It MUST NOT claim modal semantics or require a focus trap.

## Responsive and accessibility behavior

- The page must be usable at 320px width without horizontal scrolling.
- Navigation, email CTA, theme control, and all cards must be reachable and understandable by keyboard.
- Dark and light color pairs must meet WCAG AA contrast for normal text.
- The visual hierarchy must remain understandable if background texture, JavaScript, or images fail to load.
- The portrait must use meaningful alt text that identifies Connor without duplicating nearby visible wording.

## Explicit exclusions

- No new logo or logo-mark work.
- No remote font/CDN dependency.
- No click-to-enlarge/lightbox image behavior, auto-playing media, parallax, or motion-led hero.
- No data-dashboard styling, charts, or decorative pipeline diagrams in the hero.

## Approved decisions

- Amber remains the sole high-attention color for calls to action and small terrain details.
- The first release uses the system-first typography stack; it adds no font asset or external font dependency.
- The existing terrain pattern is retained and refined through lower intensity and limited placement rather than replaced with a new asset.

## References

- `.10x/specs/contractor-site-v1.md`
- `assets/css/custom.css`
- `static/img/bg-pattern.svg`
- `themes/blowfish/assets/css/schemes/forest.css`

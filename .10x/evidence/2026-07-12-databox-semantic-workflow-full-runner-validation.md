Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Relates-To: .10x/tickets/2026-07-12-give-semantic-workflow-diagram-full-runner-width.md

# Semantic workflow full-runner-width validation

## What was observed

- The semantic workflow has two equivalent Mermaid renderings: desktop uses `flowchart LR`; mobile uses `flowchart TB`.
- On desktop, `.databox-semantic-workflow--desktop` expands from the prose measure to a visible 1152px `min(72rem, calc(100vw - 4rem))` stage. Article prose remains at its 655px theme `max-w-prose` measure.
- At an actual 1440px headless-Chrome viewport, the LR stage runs from x=208 through x=1360 and its seven workflow nodes progress monotonically from x=213 to x=1192. `document.documentElement.scrollWidth == clientWidth == 1440`.
- On a 390px mobile-emulated viewport, the desktop rendering is hidden and the stacked TB rendering is shown. Its nodes progress from y=3888 to y=4584 and `document.documentElement.scrollWidth == clientWidth == body.scrollWidth == 390`; neither rendering changes the Quack/AVONET diagram.
- Both workflow renderings retain Mermaid's `Databox semantic warehouse path` accessible title, description, `graphics-document document` role, and the local fingerprinted Mermaid bundle.
- `hugo --cleanDestinationDir` built 160 pages successfully with the prior local Hugo preview stopped before the output-writing build.

## Procedure

1. Used the existing article-local desktop and mobile Mermaid wrappers, keeping the desktop LR and mobile TB source diagrams semantically identical.
2. Kept the desktop stage at `min(72rem, calc(100vw - 4rem))`, but removed its negative breakout margin after browser inspection showed it clipped the first LR node at 1440px.
3. Stopped the existing local Hugo preview before running `hugo --cleanDestinationDir` (160 pages).
4. Served the generated `public/` output on an isolated local port and used a fresh headless Chrome instance to evaluate rendered layout, Mermaid metadata, and document/client/body scroll widths at 1440px desktop and 390px mobile emulation.
5. Captured the rendered article-local stage at each viewport after Mermaid initialization.

## Artifacts

- `.10x/evidence/.storage/2026-07-12-databox-semantic-workflow-full-runner-desktop-1440.png`
- `.10x/evidence/.storage/2026-07-12-databox-semantic-workflow-mobile-390.png`

## Limits

The desktop workflow is tested at 1440px and the mobile fallback at 390px in local headless Chrome. Other browser engines and intermediate breakpoints were not separately tested.

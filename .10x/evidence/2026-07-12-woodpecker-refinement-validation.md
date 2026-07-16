Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Relates-To: .10x/tickets/2026-07-12-refine-woodpecker-flight-and-perch.md

# Woodpecker refinement validation

## What was observed

At a 2000×1100 desktop viewport:

- Before the 1.2-second delay, both birds are hidden (`visibility: hidden`); no default-position bird is painted.
- During the right-gutter phase, only the right bird is visible. The left bird remains hidden.
- Once settled, the left bird spans x=188.20–324.20 and y=384.94–520.94. The glass runner spans x=360–1640, so the bird stays in the left gutter and is visibly aligned with the foreground trunk’s right edge rather than its upper limb.
- With `prefers-reduced-motion: reduce`, the same static left perch appears and the right bird has a zero-size, non-rendered box.
- In normal, flight, settled, and reduced-motion checks, `document.documentElement.scrollWidth` equaled `clientWidth` (2000px), leaving no horizontal scroll range.
- `hugo --cleanDestinationDir` completed successfully: 159 pages built.

## Procedure

1. Built the site with `hugo --cleanDestinationDir`.
2. Used local headless Chrome at a 2000×1100 viewport to collect DOM state and screenshots at 550ms (before flight), 2350ms (flight), 5150ms (perched), and 700ms under emulated reduced motion.
3. Inspected `.woodpecker` computed visibility, bounding boxes, body runner bounds, and `document.documentElement.scrollWidth`/`clientWidth`.
4. Corrected the overflow source: the body’s backdrop-filter made the existing fixed theme-search wrapper extend beyond the runner. The wrapper is now viewport-centered; the right gutter is offset by the runner’s inline-border pixel.

## Screenshots

- `.10x/evidence/.storage/2026-07-12-woodpecker-initial-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-flight-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-perched-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-reduced-motion-2000x1100.png`

## What this supports

The two initial duplicate birds are not visible, the flight exposes one bird at a time, the final perch is trunk-aligned and gutter-contained, reduced-motion does not animate, and the page has no horizontal scroll range at the tested viewport.

## Limits

The supplied RGB sprite still uses fuzz-based checkerboard removal, so subtle pale feather-edge halos may remain. The placement is tuned to the supplied landscape and verified desktop viewport; unusually short or extremely wide desktop viewports were not separately captured.

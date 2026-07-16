Status: recorded
Created: 2026-07-12
Updated: 2026-07-12
Relates-To: .10x/tickets/2026-07-12-show-static-woodpecker-on-interior-pages.md, .10x/specs/woodpecker-gutter-animation.md

# Woodpecker interior-page validation

## What was observed

Local headless Chrome verified the homepage plus `/services/`, `/projects/`, and `/projects/databox/` at 2000×1100 and 3440×1440.

- Homepage starts idle, enters the `flying` state after the delay, then settles on one visible perch.
- Each interior route starts and remains `perched`; no interior route enters `flying`.
- At 2000×1100, all settled perches were x=187.80/y=420.20 before and after a 600px scroll; `scrollWidth/clientWidth` was 2000/2000.
- At 3440×1440, all settled perches were x=323.01/y=496.77 before and after a 600px scroll; `scrollWidth/clientWidth` was 3440/3440.
- On `/services/` at 800×800, the layer remained idle with the perch hidden and `scrollWidth/clientWidth` was 800/800.
- The animation layers are reparented to `HTML`, so static interior perches remain fixed to the landscape instead of page content.
- `hugo --cleanDestinationDir` built 159 pages successfully.

## Procedure

1. Moved the existing decorative partial from the homepage-specific profile partial to `layouts/_default/baseof.html`.
2. Added the page’s Hugo `.IsHome` value to the layer and used it to choose homepage flight versus immediate perch.
3. Ran `hugo --cleanDestinationDir` and `git diff --check` for the changed authored files.
4. Ran `node /tmp/validate-woodpecker-interior.mjs`, which loaded the four routes at both desktop viewports, recorded state and bounds before/after scrolling, and wrote page screenshots under `.10x/evidence/.storage/`.
5. Repeated the services route at 800×800 to verify the ineligible-layout branch.

## Artifacts

- `.10x/evidence/.storage/2026-07-12-woodpecker-interior-home-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-interior-services-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-interior-projects-2000x1100.png`
- `.10x/evidence/.storage/2026-07-12-woodpecker-interior-projects-databox-2000x1100.png`
- Corresponding 3440×1440 captures, plus the 800×800 services capture.

## What this supports

The homepage alone plays the arrival animation. Interior pages consistently present one static, scenery-anchored, viewport-fixed perch; no horizontal overflow is introduced, and ineligible layouts remain bird-free.

## Limits

The checks cover the named representative routes, two eligible desktop sizes, and one ineligible size. They do not prove every possible route, viewport, or browser engine.

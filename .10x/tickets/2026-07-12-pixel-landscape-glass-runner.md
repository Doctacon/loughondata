Status: done
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/specs/visual-system-v1.md

# Layer the pixel landscape behind a dark-glass content runner

## Scope

Use `butte-granite.png` as the fixed outer-page background. Place all main site content within a centered wide, dark translucent glass runner with soft backdrop blur, so the pixel landscape remains visible in left/right gutters but never competes with readable text.

## Acceptance criteria

1. Pixel landscape is visible around the content column at desktop widths.
2. Main content has one calm, centered, dark-glass reading surface with soft blur and sufficient contrast.
3. Runner remains responsive and does not create horizontal overflow or hide navigation/controls.
4. Existing contours may remain subtle, but must not make the reading surface busy.
5. Hugo output validates without new dependencies or Blowfish modifications.

## Blockers

None. Layer order, runner style, width, and blur are user-ratified.

## Progress and notes

- Implemented the pixel landscape on the root fixed canvas and moved content to a translucent, soft-blurred reading runner. Hugo temporary build passed.

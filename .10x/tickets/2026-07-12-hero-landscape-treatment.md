Status: open
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/specs/visual-system-v1.md

# Limit pixel landscape to a soft hero treatment

## Scope

Use `butte-granite.png` only behind the homepage hero. Render it as a softened, dim distant scene positioned away from headline copy. Restore the contour background after the hero boundary for the field log and remaining homepage sections.

## Acceptance criteria

1. Pixel landscape appears only in the homepage hero.
2. Headline/CTA remain legible and are not obscured by tree trunks.
3. Post-hero sections use the contour background rather than the landscape.
4. Dark/light behavior, responsive layout, and no external dependencies remain intact.
5. Hugo output validates.

## Blockers

None. Placement and visual treatment are user-ratified.

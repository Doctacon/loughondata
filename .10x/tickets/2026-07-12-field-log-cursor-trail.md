Status: open
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/specs/github-field-log.md

# Add fading amber cursor trail to field log

## Scope

Add a cursor trail to the contribution calendar: every tile crossed by pointer movement receives a temporary amber field-marker state, holds briefly, and fades back to its real forest contribution intensity.

## Constraints

- Underlying contribution colors/data remain unchanged after fade.
- Keyboard focus continues to use the existing count reveal without requiring a pointer trail.
- Reduced-motion disables the fading trail.
- No external dependency, route, data-model, or Blowfish change.

## Acceptance criteria

1. Crossing tiles produces a visible fading amber path.
2. Trail tiles return to their actual intensity state automatically.
3. Trail never hides date/count/focus accessibility behavior.
4. Reduced-motion has no trail animation.

## Blockers

None. Trail behavior and amber color are user-ratified.

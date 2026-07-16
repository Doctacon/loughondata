Status: open
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/specs/github-field-log.md

# Add field-instrument contribution counter motion

## Scope

Add the approved tile interaction to the GitHub field log: hover and keyboard focus flip a tile, briefly raise the real contribution count like a restrained field-instrument counter, hold, then return to the normal intensity face. Zero days use a quiet rising white `0`.

## Constraints

- Keyboard focus receives equivalent information.
- `prefers-reduced-motion` uses an immediate static reveal.
- No arcade bounce, remote dependency, data change, route change, or Blowfish modification.

## Acceptance criteria

1. Nonzero tiles flip and raise their actual contribution count with short, restrained motion.
2. Zero tiles reveal a quiet white `0`.
3. Focus behavior equals hover behavior; visible focus remains intact.
4. Reduced-motion behavior has no essential animation.
5. Hugo output and field-log semantics remain valid.

## Blockers

None. Motion sequence and visual tone are user-ratified.

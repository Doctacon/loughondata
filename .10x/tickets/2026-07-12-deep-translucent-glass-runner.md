Status: open
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/tickets/2026-07-12-correct-glass-runner-layering.md

# Restore deep translucent glass to the content runner

## Scope

Keep the outer pixel landscape crisp in page gutters. Give the continuous content runner a deeply dark, heavily blurred version of the same scene beneath its surface, with translucency, soft border/highlight, and readable text.

## Acceptance criteria

1. Runner has perceptible glass depth rather than an opaque black slab.
2. Landscape details inside runner are blurred enough that trunks/scene do not compete with text.
3. Outer gutters retain crisp pixel landscape.
4. Contrast, responsive layout, and Hugo output remain valid.

## Blockers

None. Glass source and opacity are user-ratified.

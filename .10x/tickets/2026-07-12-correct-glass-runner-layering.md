Status: open
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/tickets/2026-07-12-pixel-landscape-glass-runner.md

# Make the glass runner continuous and landscape-free

## Scope

Correct the runner layering: it must form one continuous full-page centered column behind all main content, including post-field-log sections. The pixel landscape remains visible only in outer gutters and must not show through the runner.

## Acceptance criteria

1. Runner extends the full document content length without gaps.
2. Pixel landscape is visible only left/right of the runner, not behind content text/cards.
3. Content runner remains dark, calm, and readable across all homepage sections.
4. No route, component, or dependency changes; Hugo output validates.

## Blockers

None. The corrected layer order is explicitly user-defined.

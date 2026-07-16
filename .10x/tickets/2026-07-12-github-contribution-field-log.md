Status: open
Created: 2026-07-12
Updated: 2026-07-12
Parent: None
Depends-On: .10x/specs/github-field-log.md, .10x/specs/visual-system-v1.md

# Add GitHub contribution field log

## Scope

Implement the approved 12-month `Doctacon` contribution field log on the homepage before “Reliability is a system,” including a locally run build-time snapshot generator and committed static data fallback.

## Acceptance criteria

1. Static snapshot uses GitHub contribution-calendar data with date/count/intensity and no token in repository/output.
2. Homepage block uses the approved field-log/forest-gradient visual contract.
3. Hover and keyboard focus reveal date/count; zero days reveal white `0`; reduced motion remains safe.
4. No-JavaScript calendar remains meaningful and links to GitHub profile.
5. Refresh failure preserves the last snapshot and does not block Hugo build.
6. No remote browser dependency or Blowfish-submodule change.
7. Hugo output, snapshot generation behavior, accessibility, and public output are validated and independently reviewed.

## Blockers

None. Build location is local deployment; a read-only GitHub token is supplied only for snapshot refresh.

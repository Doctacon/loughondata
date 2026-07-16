#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
query='query($login:String!){user(login:$login){contributionsCollection{contributionCalendar{weeks{contributionDays{date contributionCount contributionLevel weekday}}}}}}'
if gh api graphql -f query="$query" -F login=Doctacon > "$tmp"; then
  python3 - "$tmp" "$root/data/github_contributions.json" <<'PY'
import json, sys
source, target = sys.argv[1:]
x=json.load(open(source))
json.dump({'weeks': x['data']['user']['contributionsCollection']['contributionCalendar']['weeks']}, open(target, 'w'), indent=2)
PY
else
  echo 'GitHub refresh failed; preserving existing snapshot.' >&2
fi

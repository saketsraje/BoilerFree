#!/usr/bin/env bash
# BoilerFree milestone 2: verify working of BoilerLink's public event-discovery response API
set -euo pipefail

for tool in curl jq; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    printf 'Error: %s is not installed.\n' "$tool" >&2
    exit 1
  fi
done

API_URL="${BOILERLINK_API_URL:-https://boilerlink.purdue.edu/api/discovery/event/search}"
response="$(mktemp)"
trap 'rm -f "$response"' EXIT

printf 'Checking API: %s\n' "$API_URL"
if ! curl --fail --location --silent --show-error --get \
  --max-time 25 --retry 2 --retry-delay 1 \
  --header 'Accept: application/json' \
  --data-urlencode 'take=10' \
  --data-urlencode 'skip=0' \
  --data-urlencode "endsAfter=$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
  --data-urlencode 'status=Approved' \
  --data-urlencode 'orderByField=endsOn' \
  --data-urlencode 'orderByDirection=ascending' \
  --output "$response" \
  "$API_URL"; then
  printf 'API request failed. Check network/DNS, HTTP status, or try the alternate public host.\n' >&2
  exit 1
fi

if ! jq -e '(.value | type) == "array"' "$response" >/dev/null; then
  printf 'Received a response, but it is not the expected JSON object with a value array.\n' >&2
  printf 'First 300 bytes: ' >&2
  head -c 300 "$response" >&2 || true
  printf '\n' >&2
  exit 1
fi

printf 'Success: valid BoilerLink event-search JSON.\n'
printf 'Events in this page: %s\n' "$(jq '.value | length' "$response")"
printf 'Total matching events (if supplied): %s\n' "$(jq -r '."@odata.count" // "not supplied"' "$response")"
printf '\nFirst event field names:\n'
jq -r 'if (.value | length) > 0 then (.value[0] | keys | join(", ")) else "(no events in this page)" end' "$response"
printf '\nSample events (name | start time | perks):\n'
jq -r '.value[:5][] | [(.name // "Untitled"), (.startsOn // "TBA"), ((.benefitNames // []) | if type == "array" then join(", ") else tostring end)] | @tsv' "$response"
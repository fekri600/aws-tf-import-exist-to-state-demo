#!/usr/bin/env bash
set -euo pipefail

OUTFILE=${1:-inventory.json}
shift || true
REGIONS=("$@")

if [ ${#REGIONS[@]} -eq 0 ]; then
  echo "❌ No regions passed. Usage: list_inventory.sh output.json <region1> <region2> ..."
  exit 1
fi

TMPFILE="$(mktemp)"
> "$TMPFILE"

for REGION in "${REGIONS[@]}"; do
  echo " Fetching resources from $REGION ..."
  TOKEN=""
  while true; do
    if [[ -z "$TOKEN" ]]; then
      RESP=$(aws resource-explorer-2 search --query-string "*" --max-results 100 --region "$REGION" 2>/dev/null || true)
    else
      RESP=$(aws resource-explorer-2 search --query-string "*" --max-results 100 --next-token "$TOKEN" --region "$REGION" 2>/dev/null || true)
    fi

    if [[ -z "$RESP" ]]; then
      echo "⚠️ No index in $REGION, skipping."
      break
    fi

    echo "$RESP" | jq -c '.Resources[]' >> "$TMPFILE"

    TOKEN=$(echo "$RESP" | jq -r '.NextToken // empty')
    [[ -z "$TOKEN" ]] && break
  done
done

jq -s '.' "$TMPFILE" > "$OUTFILE"
rm "$TMPFILE"

COUNT=$(jq 'length' "$OUTFILE")
echo " Wrote $COUNT raw resources -> $OUTFILE"

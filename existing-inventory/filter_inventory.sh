#!/usr/bin/env bash
set -euo pipefail

INPUT=${1:-inventory.json}
OUTPUT=${2:-inventory.filtered.json}

# Filter out any Resource Explorer–related resources (index, view, IAM policy, CloudTrail channel, etc.)
# Also filter out IAM groups, users, MFA devices, OIDC providers, anomaly subscriptions, and state resources
jq '
  map(
    select(
      (type == "object") and
      (has("Arn")) and
      (.Arn | type == "string") and
      (.Arn | test("(?i)explorer") | not) and
      (.Arn | test("(?i):group/") | not) and
      (.Arn | test("(?i):user/") | not) and
      (.Arn | test("(?i):mfa/") | not) and
      (.Arn | test("(?i)oidc-provider") | not) and
      (.Arn | test("(?i)anomalysubscription") | not) and
      (.Arn | test("(?i)state") | not)
    )
  )
' "$INPUT" > "$OUTPUT"

COUNT=$(jq 'length' "$OUTPUT")
echo "✅ Filtered inventory: $COUNT resources -> $OUTPUT"

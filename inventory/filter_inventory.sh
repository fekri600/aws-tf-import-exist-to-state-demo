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
      (.Arn | test("(?i)default") | not) and
      (.ResourceType | test("(?i)explorer") | not) and
      (.Arn | test("(?i)explorer") | not) and
      (.ResourceType | test("(?i):group") | not) and
      (.ResourceType | test("(?i):user") | not) and
      (.ResourceType | test("(?i):mfa") | not) and
      (.ResourceType | test("(?i)oidc-provider") | not) and
      (.ResourceType | test("(?i)anomalysubscription") | not) and
      (.Arn | test("(?i)state") | not) and 
      (.Arn | test("(?i)AWS_OIDC_ROLE_ARN") | not) and
      (.ResourceType | test("(?i)anomalymonitor") | not) and 
      (.ResourceType | test("(?i)parameter") | not) and 
      (.ResourceType | test("(?i)cloudtrail") | not) and 
      (.ResourceType | test("(?i)key-pair") | not) and 
      (.ResourceType  | test("(?i)snapshot") | not)
    )
  )
' "$INPUT" > "$OUTPUT"

COUNT=$(jq 'length' "$OUTPUT")
echo "✓ Filtered inventory: $COUNT resources -> $OUTPUT"

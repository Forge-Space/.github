#!/usr/bin/env bash
set -euo pipefail

ORG="${ORG:-}"
MONTHLY_CAP_MINUTES="${MONTHLY_CAP_MINUTES:-}"
WARN_PCT="${WARN_PCT:-70}"
DEGRADE_PCT="${DEGRADE_PCT:-85}"
GITHUB_TOKEN_INPUT="${GITHUB_TOKEN_INPUT:-}"
MOCK_USAGE_JSON_FILE="${MOCK_USAGE_JSON_FILE:-}"
FORCE_API_FAILURE="${FORCE_API_FAILURE:-false}"
CURRENT_MONTH_UTC="$(date -u +%Y-%m)"

emit_output() {
  local key="$1"
  local value="$2"
  if [ -n "${GITHUB_OUTPUT:-}" ]; then
    echo "${key}=${value}" >> "$GITHUB_OUTPUT"
    return
  fi
  echo "${key}=${value}"
}

emit_result() {
  local usage_pct="$1"
  local warn_mode="$2"
  local degrade_mode="$3"
  local summary="$4"
  emit_output "usage_pct" "$usage_pct"
  emit_output "warn_mode" "$warn_mode"
  emit_output "degrade_mode" "$degrade_mode"
  emit_output "summary" "$summary"
}

is_positive_number() {
  [[ "$1" =~ ^[0-9]+([.][0-9]+)?$ ]]
}

safe_percentage() {
  local used="$1"
  local cap="$2"
  awk -v used="$used" -v cap="$cap" 'BEGIN { if (cap <= 0) { print "0.00" } else { printf "%.2f", (used * 100) / cap } }'
}

is_ge() {
  local left="$1"
  local right="$2"
  awk -v left="$left" -v right="$right" 'BEGIN { if (left + 0 >= right + 0) print "true"; else print "false" }'
}

if [ -z "$ORG" ]; then
  emit_result "0.00" "false" "false" "budget-guard fail-open: missing org input"
  exit 0
fi

if ! is_positive_number "$MONTHLY_CAP_MINUTES"; then
  emit_result "0.00" "false" "false" "budget-guard fail-open: invalid monthly_cap_minutes"
  exit 0
fi

if ! is_positive_number "$WARN_PCT"; then
  WARN_PCT="70"
fi

if ! is_positive_number "$DEGRADE_PCT"; then
  DEGRADE_PCT="85"
fi

if [ "$(is_ge "$WARN_PCT" "$DEGRADE_PCT")" = "true" ]; then
  DEGRADE_PCT="$WARN_PCT"
fi

usage_json=""

if [ -n "$MOCK_USAGE_JSON_FILE" ]; then
  if [ ! -f "$MOCK_USAGE_JSON_FILE" ]; then
    emit_result "0.00" "false" "false" "budget-guard fail-open: missing mock usage file"
    exit 0
  fi
  usage_json="$(cat "$MOCK_USAGE_JSON_FILE")"
elif [ "$FORCE_API_FAILURE" = "true" ]; then
  emit_result "0.00" "false" "false" "budget-guard fail-open: forced API failure"
  exit 0
elif [ -z "$GITHUB_TOKEN_INPUT" ]; then
  emit_result "0.00" "false" "false" "budget-guard fail-open: missing github token"
  exit 0
else
  tmp_file="$(mktemp)"
  http_code="$({
    curl -sS \
      -H "Authorization: Bearer ${GITHUB_TOKEN_INPUT}" \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      -w "%{http_code}" \
      "https://api.github.com/orgs/${ORG}/settings/billing/usage" \
      -o "$tmp_file"
  } || true)"

  if [ "$http_code" != "200" ]; then
    rm -f "$tmp_file"
    emit_result "0.00" "false" "false" "budget-guard fail-open: billing usage API request failed (status=${http_code:-curl_error})"
    exit 0
  fi

  usage_json="$(cat "$tmp_file")"
  rm -f "$tmp_file"
fi

if ! echo "$usage_json" | jq -e . >/dev/null 2>&1; then
  emit_result "0.00" "false" "false" "budget-guard fail-open: invalid billing usage payload"
  exit 0
fi

used_minutes="$(echo "$usage_json" | jq -r --arg month "$CURRENT_MONTH_UTC" '[
  .usageItems[]?
  | select(.product == "actions")
  | select(.unitType == "Minutes")
  | select((.date // "") | startswith($month))
  | (.quantity | tonumber)
] | add // 0')"

if ! is_positive_number "$used_minutes"; then
  emit_result "0.00" "false" "false" "budget-guard fail-open: usage payload does not contain numeric minutes"
  exit 0
fi

usage_pct="$(safe_percentage "$used_minutes" "$MONTHLY_CAP_MINUTES")"
warn_mode="$(is_ge "$usage_pct" "$WARN_PCT")"
degrade_mode="$(is_ge "$usage_pct" "$DEGRADE_PCT")"
summary="budget-guard ok: actions usage ${used_minutes}m/${MONTHLY_CAP_MINUTES}m (${usage_pct}%), warn=${warn_mode}, degrade=${degrade_mode}, month=${CURRENT_MONTH_UTC}"
emit_result "$usage_pct" "$warn_mode" "$degrade_mode" "$summary"

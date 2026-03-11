#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SCRIPT_PATH="$ROOT_DIR/.github/scripts/actions-budget-guard.sh"
FIXTURE_DIR="$ROOT_DIR/.github/scripts/tests/fixtures"

assert_equal() {
  local expected="$1"
  local actual="$2"
  local label="$3"
  if [ "$expected" != "$actual" ]; then
    echo "Assertion failed for ${label}: expected=${expected} actual=${actual}" >&2
    exit 1
  fi
}

assert_contains() {
  local needle="$1"
  local haystack="$2"
  local label="$3"
  if [[ "$haystack" != *"$needle"* ]]; then
    echo "Assertion failed for ${label}: expected summary to contain '${needle}'" >&2
    exit 1
  fi
}

prepare_fixture_for_current_month() {
  local fixture="$1"
  local target="$2"
  local current_month
  current_month="$(date -u +%Y-%m)"
  jq --arg month "$current_month" '.usageItems |= map(.date = ($month + "-01T00:00:00Z"))' "$fixture" > "$target"
}

run_case() {
  local fixture_file="$1"
  local expected_pct="$2"
  local expected_warn="$3"
  local expected_degrade="$4"

  local output_file
  output_file="$(mktemp)"
  local mock_file
  mock_file="$(mktemp)"
  trap 'rm -f "$output_file" "$mock_file"' RETURN

  prepare_fixture_for_current_month "$fixture_file" "$mock_file"

  ORG="Forge-Space" \
  MONTHLY_CAP_MINUTES="1000" \
  WARN_PCT="70" \
  DEGRADE_PCT="85" \
  MOCK_USAGE_JSON_FILE="$mock_file" \
  GITHUB_OUTPUT="$output_file" \
  "$SCRIPT_PATH"

  local usage_pct warn_mode degrade_mode summary
  usage_pct="$(grep '^usage_pct=' "$output_file" | cut -d= -f2-)"
  warn_mode="$(grep '^warn_mode=' "$output_file" | cut -d= -f2-)"
  degrade_mode="$(grep '^degrade_mode=' "$output_file" | cut -d= -f2-)"
  summary="$(grep '^summary=' "$output_file" | cut -d= -f2-)"

  assert_equal "$expected_pct" "$usage_pct" "usage_pct"
  assert_equal "$expected_warn" "$warn_mode" "warn_mode"
  assert_equal "$expected_degrade" "$degrade_mode" "degrade_mode"
  assert_contains "budget-guard ok" "$summary" "summary"

  rm -f "$output_file" "$mock_file"
  trap - RETURN
}

run_failure_case() {
  local output_file
  output_file="$(mktemp)"
  trap 'rm -f "$output_file"' RETURN

  ORG="Forge-Space" \
  MONTHLY_CAP_MINUTES="1000" \
  WARN_PCT="70" \
  DEGRADE_PCT="85" \
  FORCE_API_FAILURE="true" \
  GITHUB_OUTPUT="$output_file" \
  "$SCRIPT_PATH"

  local usage_pct warn_mode degrade_mode summary
  usage_pct="$(grep '^usage_pct=' "$output_file" | cut -d= -f2-)"
  warn_mode="$(grep '^warn_mode=' "$output_file" | cut -d= -f2-)"
  degrade_mode="$(grep '^degrade_mode=' "$output_file" | cut -d= -f2-)"
  summary="$(grep '^summary=' "$output_file" | cut -d= -f2-)"

  assert_equal "0.00" "$usage_pct" "usage_pct (failure mode)"
  assert_equal "false" "$warn_mode" "warn_mode (failure mode)"
  assert_equal "false" "$degrade_mode" "degrade_mode (failure mode)"
  assert_contains "fail-open" "$summary" "summary (failure mode)"

  rm -f "$output_file"
  trap - RETURN
}

run_case "$FIXTURE_DIR/usage-below-warn.json" "10.00" "false" "false"
run_case "$FIXTURE_DIR/usage-warn-only.json" "75.00" "true" "false"
run_case "$FIXTURE_DIR/usage-degrade.json" "90.00" "true" "true"
run_failure_case

echo "actions-budget-guard tests passed"

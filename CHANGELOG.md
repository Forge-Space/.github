# Changelog

All notable changes to this repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `reusable-actions-budget-guard.yml`: new reusable workflow that reads
  organization Actions usage and emits `usage_pct`, `warn_mode`, `degrade_mode`,
  and `summary` outputs for limit-aware CI orchestration.
- `.github/scripts/actions-budget-guard.sh`: fail-open billing guard logic with
  mockable payload support for deterministic test coverage.
- `test-actions-budget-guard.yml`: workflow-level shell test harness validating
  below-warn, warn-only, degrade, and API-failure scenarios.

### Fixed

- `reusable-docker-build.yml`: replaced `secrets.*` usage in Docker Hub login
  `if` guard with env-backed checks to avoid workflow-file evaluation errors.
- `reusable-actions-budget-guard.yml`: removed custom `github_token` workflow
  secret declaration (reserved name) and now reads `secrets.GITHUB_TOKEN`
  directly to prevent workflow-file validation failures on push.

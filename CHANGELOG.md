# Changelog

All notable changes to this repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- **Org-level PR template** (`.github/PULL_REQUEST_TEMPLATE.md`): lean
  What/Why/How format inspired by Next.js and Kubernetes, replacing
  overly verbose repo-specific templates across the ecosystem.
- **Org-level CONTRIBUTING.md**: unified contributing guide covering branch
  naming, conventional commits, PR requirements, review process, and
  development setup for all Forge Space repositories.
- `reusable-pr-governance.yml`: PR size labeler (XS/S/M/L/XL via
  codelytv/pr-size-labeler) + conventional commit title linter (via
  amannn/action-semantic-pull-request). XL PRs get a comment suggesting
  they be split.
- `reusable-stale.yml`: stale issue/PR management (via actions/stale)
  with configurable timeouts (default 30d stale, 14d close). Exempts
  `pinned`, `security`, `good first issue`, and `help wanted` labels.
- `reusable-pr-labeler.yml`: auto-label PRs by files changed (via
  actions/labeler) using per-repo `.github/labeler.yml` config.

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

### Changed

- Updated reusable workflow/action internals to Node24-ready action majors:
  `actions/checkout@v6` and `actions/setup-node@v6` (no `workflow_call`
  contract changes).

# Contributing to Forge Space

Thank you for your interest in contributing to Forge Space! This guide applies to all repositories in the organization.

## Getting Started

1. Fork the repository
2. Clone your fork locally
3. Create a feature branch from `main`
4. Make your changes
5. Open a Pull Request

## Branch Naming

Use conventional prefixes:

```
feature/short-description
fix/short-description
refactor/short-description
chore/short-description
docs/short-description
ci/short-description
test/short-description
release/vX.Y.Z
```

## Commit Messages

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add user authentication flow
fix: resolve null pointer in config parser
refactor: extract validation into shared module
docs: update API endpoint documentation
test: add integration tests for scoring engine
chore: bump dependencies to latest
ci: add security scanning workflow
perf: optimize database query for dashboard
```

**Rules:**
- Use lowercase, imperative mood (`add`, not `added` or `adds`)
- Keep the subject line under 72 characters
- Reference issues in the body when applicable (`Closes #123`)

## Pull Requests

### Before Opening a PR

- Run the project's lint and test suite locally
- Ensure your branch is up to date with `main`
- Review your own changes before requesting review

### PR Requirements

- Fill out the PR template completely
- Link the related issue
- Keep PRs focused — one concern per PR
- Small PRs get reviewed faster (aim for <400 lines changed)

### Review Process

1. All PRs require at least one approving review
2. CI checks must pass before merge
3. Address review feedback with new commits (don't force-push during review)
4. Squash merge into `main`

## Development Setup

Each repository has its own setup instructions in its README. Common patterns:

**TypeScript/Node.js projects** (siza, core, ui-mcp, siza-gen, forge-ai-init):
```bash
npm install
npm run lint
npm test
npm run build
```

**Python projects** (mcp-gateway):
```bash
pip install -e ".[dev]"
ruff check .
ruff format --check .
pytest
```

## Reporting Issues

- Use the repository's issue templates
- Search existing issues before creating a new one
- Include reproduction steps for bugs
- For security vulnerabilities, see [SECURITY.md](SECURITY.md)

## Code of Conduct

Be respectful, constructive, and collaborative. We're building tools to make AI-assisted development better for everyone.

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

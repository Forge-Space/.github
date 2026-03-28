# Governance

## GitHub Work Management

Forge Space uses three GitHub surfaces with different jobs:

- Discussions for intake, RFCs, Q&A, and announcements
- Issues for the canonical actionable backlog
- Projects for roadmap, prioritization, and reporting

Execution-only state does not live in GitHub board columns. Approvals, leases, active runs, and outcomes stay in the orchestration ledger.

## Default Flow

1. Start in Discussions when the work is exploratory, controversial, or not yet actionable.
2. Promote accepted outcomes into Issues when the work has a clear deliverable and acceptance criteria.
3. Add issue-backed work to Projects for roadmap visibility and cross-repo reporting.
4. Keep delivery execution state in the control plane, then sync shipped or blocked outcomes back to GitHub.

## Discussion Categories

Use these categories consistently:

- Ideas
- RFCs
- Q&A
- Announcements

## Issue Expectations

Actionable issues should capture:

- the problem
- the expected outcome
- acceptance criteria
- affected repository or scope
- links to upstream discussion or downstream roadmap item when relevant

Use epics when the work spans multiple deliverables or repositories.

## Project Expectations

Projects should answer:

- what matters this quarter
- what is blocked
- what is in progress
- what shipped recently

Recommended fields:

- Status
- Priority
- Workstream
- Target
- Repo

## Anti-Patterns

Avoid:

- doing active delivery tracking from Discussions only
- treating Project columns as the source of truth for execution
- keeping roadmap state in issue bodies
- opening work as a task without linking it back to the relevant repo or scope

## Local Overrides

Repository-local templates may exist for product-specific needs, but they should preserve this contract and not redefine the ownership split between Discussions, Issues, and Projects.

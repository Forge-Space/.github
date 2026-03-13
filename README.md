# Forge Space

> **The accessible Internal Developer Platform.**
>
> Prompt-to-prod with conscience — AI-powered development with built-in governance, quality gates, and MCP-native extensibility.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MCP](https://img.shields.io/badge/Protocol-MCP-8B5CF6)](https://modelcontextprotocol.io)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.7-blue)](https://www.typescriptlang.org/)
[![Node.js](https://img.shields.io/badge/node-%3E%3D20-brightgreen)](https://nodejs.org/)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED)](https://www.docker.com/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen)](CONTRIBUTING.md)

> Maintenance (2026-03-10): fixed `reusable-docker-build.yml` so Docker Hub
> login guards do not use `secrets.*` directly in `if` expressions.
>
> Infrastructure (2026-03-11): added `reusable-actions-budget-guard.yml` for
> limit-aware GitHub Actions gating on new org/project bootstraps.
>
> CI Runtime (2026-03-13): upgraded reusable internals to `actions/checkout@v6`
> and `actions/setup-node@v6` for Node24 readiness.

---

## Why Forge Space?

Teams adopt AI and ship faster — but guardrails lag behind. Prototypes ship, quality and security debt accumulates invisibly, and nobody owns the governance gap. We call this **AI limbo engineering**.

Forge Space is an open-source IDP that bakes engineering conscience into every AI-assisted workflow:

- **Govern** — a single gateway boundary with JWT auth, RBAC, and audit logging
- **Generate** — AI-powered code generation with post-generation quality checks
- **Enforce** — scorecards, policy packs, and secret scanning in CI
- **Extend** — MCP-native hub-and-spoke architecture for pluggable tooling

We're not replacing enterprise platform teams. We're the **IDP for the rest of us** — platform-grade guardrails without requiring a dedicated platform team.

---

## Repositories

### Platform

#### [Siza](https://github.com/Forge-Space/siza) — AI Workspace + Governance Dashboard

The flagship web application. Describe what you want, get production-ready code — with quality scorecards, policy enforcement, and governance dashboards built in.

**Tech stack:** Next.js 15 · React 19 · Supabase · Cloudflare Workers · Turborepo · shadcn/ui

**Key features:**
- AI-powered component and page generation via BYOK (Bring Your Own Key)
- Quality scorecards with green/yellow/red signals per project
- Policy engine enforcement (security, quality, compliance rules)
- Admin audit dashboard with filterable event logs
- Monaco code editor with live preview and export
- Stripe billing with usage tracking and plan limits
- Email/password + OAuth authentication

```bash
git clone https://github.com/Forge-Space/siza.git
cd siza && npm install && npm run dev
```

#### [Forge Space Web](https://github.com/Forge-Space/forgespace-web) — Marketing + Docs

Platform marketing site and IDP documentation hub with 3D hero, design tokens, and IDP navigation.

**Tech stack:** Next.js 15 · React 19 · Tailwind 4 · Three.js · @forgespace/brand-guide

---

### Governance & Routing

#### [MCP Gateway](https://github.com/Forge-Space/mcp-gateway) — Central Governance Hub

The single governance boundary for all AI tool calls. A hub-and-spoke MCP routing gateway with authentication, authorization, policy enforcement, and audit logging.

**Tech stack:** Python · FastAPI · Docker · jose JWT · SQLite

**Governance features:**
- **JWT Authentication** — jose-based, Edge-compatible, Supabase JWKS integration
- **RBAC** — 4 roles (viewer, developer, admin, super_admin) with 16 granular permissions
- **Audit API** — paginated, filterable event logs with `/audit/events` and `/audit/summary`
- **Context Propagation** — user ID, roles, and permissions forwarded to every spoke
- **Transport Abstraction** — stdio and HTTP transports for MCP spoke communication

**Routing features:**
- Single connection point for all MCP servers
- Web-based Admin UI for managing servers, tools, and virtual servers
- Built-in translate layer: converts stdio-only servers to SSE/HTTP
- 15+ pre-configured local MCP servers (sequential-thinking, Playwright, filesystem, GitHub, and more)
- AI-powered tool routing with feedback loops

```bash
git clone https://github.com/Forge-Space/mcp-gateway.git
cd mcp-gateway && cp .env.example .env
make start && make register
```

#### [Forge Patterns](https://github.com/Forge-Space/core) — Standards + CLI Tools

Shared standards, configurations, and CLI tools for the ecosystem. Includes the policy engine, scorecard system, and a VSCode extension.

**Key features:**
- **`forge-scorecard` CLI** — run quality scorecards in CI with threshold exit codes
- **`forge-policy` CLI** — evaluate governance policies with `--fail-on-block`
- **Policy Engine** — schema-driven evaluator with built-in security, quality, and compliance rules
- **Scorecard Aggregator** — 4 collectors (security, quality, deps, operations) with weighted scoring
- **VSCode Extension** — workspace utilities for the Forge Space ecosystem

```bash
npm install @forgespace/core
npx forge-scorecard --format summary
npx forge-policy --config .policy.json --fail-on-block
```

---

### Generation Engine

#### [siza-gen](https://github.com/Forge-Space/siza-gen) — AI Generation Engine

Multi-framework code generation (React, Vue, Angular, Svelte), 502-snippet component registry, ML-powered quality scoring, vector search, and context assembly for BYOK prompt enrichment.

Available on [npm](https://www.npmjs.com/package/@forgespace/siza-gen).

#### [Siza MCP](https://github.com/Forge-Space/ui-mcp) — MCP Server for UI Generation

21 MCP tools for generating UI from natural language, screenshots, Figma files, and more. Template packs, brand integration, and vector search. Usable from any MCP-compatible IDE or agent.

**Quick start:**
```bash
npx -y @forgespace/ui-mcp@latest
```

---

### Design & Brand

#### [Branding MCP](https://github.com/Forge-Space/branding-mcp) — Brand Identity MCP Tools

9 tools and 10 generators for AI-powered brand identity creation. WCAG-validated color systems, built-in Forge Space template.

#### [Brand Guide](https://github.com/Forge-Space/brand-guide) — Brand Identity as Code

Forge Space brand system hosted at [brand.forgespace.co](https://brand.forgespace.co). Logo variants, color palettes, typography, and an npm library for programmatic access.

```bash
npm install @forgespace/brand-guide
```

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Your IDE / AI Agent                       │
│                 (Cursor, Windsurf, Claude...)                │
└───────────────────────────┬─────────────────────────────────┘
                            │ Single MCP connection
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                      MCP Gateway                            │
│            (Central Governance Boundary)                    │
│                                                             │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐           │
│  │ JWT Auth   │  │ RBAC       │  │ Audit Log  │           │
│  │ (jose)     │  │ (4 roles)  │  │ (events)   │           │
│  └────────────┘  └────────────┘  └────────────┘           │
│                                                             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │ ui-mcp   │  │Playwright│  │ GitHub   │  │ Memory   │  │
│  │ (Siza)   │  │          │  │          │  │          │  │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘  │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │ Tavily   │  │ Postgres │  │filesystem│  │ + more...│  │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘  │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                     Siza Web App                            │
│        Next.js · Supabase · Cloudflare Workers              │
│                                                             │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐           │
│  │ AI Gen     │  │ Scorecards │  │ Policy     │           │
│  │ (BYOK)     │  │ (quality)  │  │ (enforce)  │           │
│  └────────────┘  └────────────┘  └────────────┘           │
│                                                             │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐           │
│  │ Audit UI   │  │ Feature    │  │ Billing    │           │
│  │ (admin)    │  │ Flags      │  │ (Stripe)   │           │
│  └────────────┘  └────────────┘  └────────────┘           │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                    CI / CD Pipeline                          │
│                                                             │
│  forge-scorecard ──► Quality gates (green/yellow/red)       │
│  forge-policy ────► Governance checks (allow/deny)          │
│  Secret scanning ─► Zero secrets enforcement                │
│  npm audit ───────► Dependency hygiene                      │
└─────────────────────────────────────────────────────────────┘
```

---

## Getting Started

### Option A — Full Platform (recommended)

Run the gateway + workspace locally:

```bash
# 1. Start the governance gateway
git clone https://github.com/Forge-Space/mcp-gateway.git
cd mcp-gateway && cp .env.example .env
make start && make register

# 2. Point your IDE at the gateway
# Run: make use-cursor-wrapper   (for Cursor)

# 3. Start the Siza workspace
git clone https://github.com/Forge-Space/siza.git
cd siza && npm install && npm run dev
# → http://localhost:3000
```

### Option B — MCP Server Only

Use Siza MCP standalone with any MCP-compatible IDE:

```bash
npx -y @forgespace/ui-mcp@latest
```

### Option C — Governance CLI Only

Add quality gates and policy checks to any project's CI:

```bash
npm install @forgespace/core

# Run scorecard checks
npx forge-scorecard --format summary --threshold 60

# Run policy enforcement
npx forge-policy --config .policy.json --fail-on-block
```

---

## Governance Features

### Scorecards

Quality scorecards provide green/yellow/red signals for codebases. Four collectors run checks across security, code quality, dependency hygiene, and operations:

| Collector | Weight | Checks |
|-----------|--------|--------|
| Security | 30% | Zero secrets, secret scanning in CI |
| Quality | 30% | Lint/format, unit test coverage |
| Dependencies | 20% | SCA scanning, outdated deps |
| Operations | 20% | Structured logs, runbook presence |

### Policy Packs

The "Forge Defaults" baseline policy pack enforces:

- **Security** — zero committed secrets, dependency scanning in CI
- **Quality** — lint/format enforcement, minimal unit tests for new modules
- **Operations** — structured logs with correlation IDs, runbook presence
- **Feature Flags** — risky features behind Unleash toggles

### Audit Logging

Every authenticated action flows through the gateway's audit system:

- Paginated event log with user, action, and timestamp filtering
- Summary endpoint for dashboards
- Admin UI in the Siza workspace

---

## Roadmap

| Phase | Timeline | Focus |
|-------|----------|-------|
| **Stabilize** | 0-3 months | Harden onboarding, baseline scorecards + policies in CI, docs parity |
| **Grow** | 3-6 months | New spokes (security, infra, data), marketplace/registry, observability UX |
| **Scale** | 6-12 months | Org-level policies + exemptions, cross-repo dashboards, multi-spoke workflows |

---

## Zero-Cost Architecture

Forge Space is designed to run entirely for free:

| Service | Provider | Free Tier |
|---------|----------|-----------|
| Web hosting | Cloudflare Workers | 100K req/day |
| Database | Supabase | 500 MB · 50,000 MAU |
| Storage | Supabase | 1 GB |
| AI (fallback) | Google Gemini | 60 req/min |
| MCP Gateway | Self-hosted | Unlimited |
| Feature Flags | Unleash (self-hosted) | Unlimited |

---

## Contributing

We welcome contributions of all kinds — bug reports, feature requests, documentation, and code.

1. Fork the relevant repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Make your changes and add tests
4. Run the quality checks: `npm run validate` (or `make lint && make test`)
5. Submit a Pull Request with a clear description

Please read the `CONTRIBUTING.md` in each repository for repo-specific guidelines.

**Code standards across all Forge Space projects:**
- TypeScript strict mode
- Conventional Commits (`feat:`, `fix:`, `docs:`, etc.)
- 80%+ test coverage for new features
- Prettier + ESLint enforced on every commit

---

## Security

If you discover a security vulnerability, please report it responsibly by opening a private security advisory on the relevant repository rather than a public issue. See `SECURITY.md` in each repo for details.

---

## License

All Forge Space repositories are released under the [MIT License](https://opensource.org/licenses/MIT). See the `LICENSE` file in each repository.

---

<div align="center">
  <strong>Built in the open by the Forge Space community.</strong><br>
  Platform-grade guardrails without requiring a dedicated platform team.
</div>

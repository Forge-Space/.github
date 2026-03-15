<p align="center">
  <a href="https://forgespace.co">
    <img src="https://brand.forgespace.co/logos/wordmark.svg" alt="Forge Space" width="400" />
  </a>
</p>

<h3 align="center">The Accessible Internal Developer Platform</h3>

<p align="center">
  Prompt-to-prod with conscience — AI-powered development with built-in governance, quality gates, and <a href="https://modelcontextprotocol.io">MCP</a>-native extensibility.
</p>

<p align="center">
  <a href="https://forgespace.co">Website</a> •
  <a href="https://siza.forgespace.co">App</a> •
  <a href="https://github.com/orgs/Forge-Space/repositories?type=public">Repos</a> •
  <a href="https://www.npmjs.com/org/forgespace">npm</a> •
  <a href="https://forgespace.co/startups">Startups</a>
</p>

<p align="center">
  <a href="https://www.npmjs.com/package/@forgespace/siza-gen"><img alt="npm downloads" src="https://img.shields.io/npm/dm/@forgespace/siza-gen?label=siza-gen&color=7C3AED&style=flat" /></a>
  <a href="https://www.npmjs.com/package/@forgespace/ui-mcp"><img alt="npm downloads" src="https://img.shields.io/npm/dm/@forgespace/ui-mcp?label=ui-mcp&color=7C3AED&style=flat" /></a>
  <a href="https://www.npmjs.com/package/@forgespace/core"><img alt="npm downloads" src="https://img.shields.io/npm/dm/@forgespace/core?label=core&color=7C3AED&style=flat" /></a>
  <img alt="License" src="https://img.shields.io/badge/License-MIT-7C3AED?style=flat" />
  <img alt="MCP" src="https://img.shields.io/badge/MCP-native-7C3AED?style=flat" />
</p>

---

### The problem

Teams adopt AI and ship faster — but guardrails lag behind. Inconsistent quality, security gaps, and ungoverned infrastructure accumulate invisibly. We call it **AI limbo engineering**.

### What we build

Forge Space is an open-source IDP that bakes engineering conscience into every AI-assisted workflow: a single governance boundary, standardized golden paths, automatic quality checks, and MCP-native extensibility.

#### Platform

**[Siza](https://github.com/Forge-Space/siza)** — Full-stack AI workspace with BYOK generation, quality scorecards, policy enforcement, and governance dashboards. Next.js + Supabase + Cloudflare Workers.

**[Forge Space Web](https://github.com/Forge-Space/forgespace-web)** — Platform marketing site and IDP documentation hub. Next.js 15 + React 19 + Three.js.

**[Siza Desktop](https://github.com/Forge-Space/siza-desktop)** — Native desktop app with local AI generation via Ollama. macOS, Windows, Linux.

#### Governance & Routing

**[MCP Gateway](https://github.com/Forge-Space/mcp-gateway)** — Hub-and-spoke MCP routing with JWT auth, RBAC, policy engine, audit logging, and an admin UI. The single governance boundary for all AI tool calls.

**[Forge Patterns](https://github.com/Forge-Space/core)** — Shared standards, scorecard CLI, policy engine CLI, and a VSCode extension. The foundation that enforces consistency across the ecosystem.

#### Generation Engine

**[siza-gen](https://github.com/Forge-Space/siza-gen)** — AI generation engine. Multi-framework code generation, 502-snippet registry, ML quality scoring, and context assembly. Available on [npm](https://www.npmjs.com/package/@forgespace/siza-gen).

**[Siza MCP](https://github.com/Forge-Space/ui-mcp)** — MCP server for AI-powered UI generation. 21 tools, template packs, brand integration. Connect to any MCP-compatible client.

#### Design & Brand

**[Branding MCP](https://github.com/Forge-Space/branding-mcp)** — MCP server for AI-powered brand identity generation. 9 tools, 10 generators, WCAG-validated color systems.

**[Brand Guide](https://github.com/Forge-Space/brand-guide)** — Brand identity as code. Hosted at [brand.forgespace.co](https://brand.forgespace.co) with an npm library for programmatic access.

### Tech stack

<p>
  <img alt="TypeScript" src="https://img.shields.io/badge/TypeScript-3178C6?logo=typescript&logoColor=white" />
  <img alt="Python" src="https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=white" />
  <img alt="React" src="https://img.shields.io/badge/React-61DAFB?logo=react&logoColor=black" />
  <img alt="Next.js" src="https://img.shields.io/badge/Next.js-000000?logo=nextdotjs&logoColor=white" />
  <img alt="Supabase" src="https://img.shields.io/badge/Supabase-3FCF8E?logo=supabase&logoColor=white" />
  <img alt="Cloudflare" src="https://img.shields.io/badge/Cloudflare-F38020?logo=cloudflare&logoColor=white" />
  <img alt="Docker" src="https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white" />
  <img alt="Electron" src="https://img.shields.io/badge/Electron-47848F?logo=electron&logoColor=white" />
  <img alt="MCP" src="https://img.shields.io/badge/MCP-Protocol-8B5CF6" />
</p>

### Roadmap

| Phase | Timeline | Focus |
|-------|----------|-------|
| Stabilize | 0-3 months | Onboarding, baseline scorecards + policies in CI, docs |
| Grow | 3-6 months | New spokes (security, infra, data), marketplace, observability UX |
| Scale | 6-12 months | Org-level policies, cross-repo dashboards, multi-spoke workflows |

### Get started

```bash
# Use the AI workspace
# https://siza.forgespace.co

# Or run locally
git clone https://github.com/Forge-Space/siza.git
cd siza && npm install && npm run dev

# Run the governance gateway
git clone https://github.com/Forge-Space/mcp-gateway.git
cd mcp-gateway && cp .env.example .env && make start
```

### Contributing

We welcome contributions across all repos. Each project has its own `CONTRIBUTING.md`. Start with issues labeled [`good first issue`](https://github.com/search?q=org%3AForge-Space+label%3A%22good+first+issue%22&type=issues).

### Partnerships

We're applying to accelerator programs and actively seeking cloud infrastructure partnerships. If you're from Microsoft for Startups, Google for Startups, Cloudflare, Supabase, Vercel, or a dev-tools investor, [reach out](mailto:lucas.diassantana@gmail.com) or visit [forgespace.co/startups](https://forgespace.co/startups).

---

<p align="center">
  <sub>Built in Brazil · MIT Licensed · <a href="mailto:support@forgespace.co">support@forgespace.co</a></sub>
</p>

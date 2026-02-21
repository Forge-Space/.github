# Forge Space

> **The open-source AI-powered development platform.**
>
> Build, generate, and ship production-ready UI at the speed of thought — powered by the Model Context Protocol.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MCP](https://img.shields.io/badge/Protocol-MCP-8B5CF6)](https://modelcontextprotocol.io)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.7-blue)](https://www.typescriptlang.org/)
[![Node.js](https://img.shields.io/badge/node-%3E%3D20-brightgreen)](https://nodejs.org/)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED)](https://www.docker.com/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen)](CONTRIBUTING.md)

---

## What is Forge Space?

Forge Space is an ecosystem of open-source tools that brings AI-powered UI generation directly into your development workflow. By leveraging the [Model Context Protocol (MCP)](https://modelcontextprotocol.io), every component in the Forge Space platform speaks the same language — enabling seamless integration between AI agents, your IDE, and your design tools.

The platform is built around three core pillars:

- **Generate** — describe what you want, get production-ready UI code
- **Integrate** — connect any MCP-compatible AI tool through a single gateway
- **Ship** — deploy on a zero-cost, self-hosted architecture

---

## Repositories

### [UI](https://github.com/Forge-Space/UI) — UIForge Web Application

The flagship web application. A zero-cost AI-powered UI generation platform where you describe a component or page in natural language and receive production-ready code in return.

**Tech stack:** Next.js 15 · React 18 · Supabase · TypeScript · shadcn/ui · Tailwind CSS · Turborepo

**Key features:**
- AI-powered component and page generation via BYOK (Bring Your Own Key)
- Monaco code editor with live preview and export
- Real-time collaboration via Supabase subscriptions
- Email/password + OAuth authentication
- 100% free-tier architecture (scales to 50,000 users)

```bash
git clone https://github.com/Forge-Space/UI.git
cd UI && npm install && npm run dev
```

---

### [ui-mcp](https://github.com/Forge-Space/ui-mcp) — UIForge MCP Server

The AI engine behind Forge Space. A full-featured [Model Context Protocol](https://modelcontextprotocol.io) server that exposes 12 tools for generating UI from natural language, screenshots, Figma files, and more — usable from any MCP-compatible IDE or agent.

**Tech stack:** TypeScript · MCP SDK · Docker · Figma API · satori · resvg

**Tools provided:**

| Tool | Description |
|------|-------------|
| `scaffold_full_application` | Generate full project boilerplate (React, Next.js, Vue, Angular, HTML) |
| `generate_ui_component` | Create or iterate components with style-aware generation |
| `generate_prototype` | Interactive HTML prototypes with navigation |
| `generate_design_image` | SVG/PNG mockups and wireframes |
| `image_to_component` | Convert screenshots to framework-specific code |
| `generate_page_template` | Pre-built page templates (landing, dashboard, auth, CRUD…) |
| `refine_component` | Iterative improvement via natural language feedback |
| `audit_accessibility` | WCAG 2.1 compliance audit with fix suggestions |
| `fetch_design_inspiration` | Extract visual metadata from URLs |
| `analyze_design_references` | Detect patterns from design references |
| `figma_context_parser` | Read Figma files, extract tokens, map to Tailwind |
| `figma_push_variables` | Write design tokens back to Figma as Variables |

**Quick start (NPX):**
```bash
npx -y uiforge-mcp@latest
```

**IDE configuration:**
```json
{
  "mcpServers": {
    "uiforge-mcp": {
      "command": "npx",
      "args": ["-y", "uiforge-mcp@latest"],
      "env": {
        "FIGMA_ACCESS_TOKEN": "your_token_here"
      }
    }
  }
}
```

---

### [mcp-gateway](https://github.com/Forge-Space/mcp-gateway) — Forge MCP Gateway

A self-hosted MCP aggregation gateway built on [IBM Context Forge](https://github.com/IBM/mcp-context-forge). Connect your IDE to the gateway once and manage all your upstream MCP servers — including `ui-mcp` — through a single Admin UI.

**Tech stack:** Docker · IBM Context Forge · Python · FastAPI · SQLite · TypeScript

**Key features:**
- Single connection point for all MCP servers
- Web-based Admin UI for managing servers, tools, and virtual servers
- Built-in translate layer: converts stdio-only servers to SSE/HTTP
- 15+ pre-configured local MCP servers (sequential-thinking, Playwright, filesystem, GitHub, Postgres, memory, and more)
- Intelligent tool-router for dynamic AI-powered tool selection
- JWT authentication with automatic refresh

**Quick start:**
```bash
git clone https://github.com/Forge-Space/mcp-gateway.git
cd mcp-gateway
cp .env.example .env
# Edit .env: set PLATFORM_ADMIN_EMAIL, PLATFORM_ADMIN_PASSWORD, JWT_SECRET_KEY, AUTH_ENCRYPTION_SECRET
make start
make register
```

**Admin UI:** http://localhost:4444/admin

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        Your IDE / AI Agent                   │
│                   (Cursor, Windsurf, Claude…)                │
└───────────────────────────┬─────────────────────────────────┘
                            │ Single MCP connection
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                      mcp-gateway                            │
│              (IBM Context Forge + Tool Router)              │
│                                                             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │ ui-mcp   │  │ Playwright│  │ GitHub   │  │ Memory   │  │
│  │(UIForge) │  │          │  │          │  │          │  │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘  │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │ Tavily   │  │ Postgres │  │filesystem│  │ + more…  │  │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘  │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                   UI (UIForge Web App)                      │
│          Next.js · Supabase · shadcn/ui · Monaco            │
│                                                             │
│   [Describe UI] → [AI generates code] → [Live preview]     │
│                     → [Export / Deploy]                     │
└─────────────────────────────────────────────────────────────┘
```

---

## Getting Started

### Option A — Full stack (recommended)

Run all three services locally:

```bash
# 1. Start the MCP gateway (includes ui-mcp as a translate service)
git clone https://github.com/Forge-Space/mcp-gateway.git
cd mcp-gateway && cp .env.example .env
make start && make register

# 2. Point your IDE at the gateway
# Run: make use-cursor-wrapper   (for Cursor)
# Or copy the printed URL into your IDE's mcp.json

# 3. Start the UIForge web app
git clone https://github.com/Forge-Space/UI.git
cd UI && npm install && npm run dev
# → http://localhost:3000
```

### Option B — MCP server only

Use `ui-mcp` standalone with any MCP-compatible IDE:

```bash
npx -y uiforge-mcp@latest
```

Add the server to your IDE config and start generating UI with natural language prompts.

### Option C — Web app only

Use UIForge with your own AI API keys (BYOK):

```bash
git clone https://github.com/Forge-Space/UI.git
cd UI && npm install
cp apps/web/.env.example apps/web/.env.local
# Set your Supabase credentials and API keys
npm run dev
```

---

## Zero-Cost Architecture

Forge Space is designed to run entirely for free:

| Service | Provider | Free Tier |
|---------|----------|-----------|
| Web hosting | Cloudflare Pages | Unlimited bandwidth |
| Database | Supabase | 500 MB · 50,000 MAU |
| Storage | Supabase | 1 GB |
| AI (fallback) | Google Gemini | 60 req/min |
| MCP Gateway | Self-hosted | Unlimited |
| MCP Server | Self-hosted / NPX | Unlimited |

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
  Making AI-powered development accessible to everyone.
</div>

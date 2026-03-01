# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in any Forge Space project, please report it responsibly.

### Preferred: GitHub Private Security Advisory

Open a [Private Security Advisory](https://docs.github.com/en/code-security/security-advisories/guidance-on-reporting-and-writing-information-about-vulnerabilities/privately-reporting-a-security-vulnerability) on the affected repository. This is the fastest and most secure way to report.

### Alternative: Email

Send details to [security@forgespace.co](mailto:security@forgespace.co).

Include:

- Description of the vulnerability
- Steps to reproduce
- Affected repository and version
- Potential impact assessment

## Response Timeline

| Stage | Target |
|-------|--------|
| Acknowledgment | < 48 hours |
| Triage and severity assessment | < 7 days |
| Fix for critical severity | < 7 days |
| Fix for high severity | < 30 days |
| Fix for medium/low severity | Next release cycle |

## Scope

### In Scope

All repositories under the [Forge-Space](https://github.com/Forge-Space) organization:

- **siza** -- Full-stack AI workspace (auth, billing, API routes, user data)
- **core** (forge-patterns) -- Shared configuration and pattern library
- **ui-mcp** (siza-mcp) -- MCP server for UI generation
- **mcp-gateway** -- MCP aggregation and routing gateway
- **branding-mcp** -- Brand identity MCP tools
- **brand-guide** -- Brand identity library and site
- **siza-gen** -- UI generation engine
- **siza-desktop** -- Electron desktop client

### Out of Scope

- Third-party dependencies (report upstream, notify us if critical)
- Social engineering attacks
- Denial of service attacks
- Issues in development/staging environments
- Previously reported vulnerabilities

## Supported Versions

Only the latest released version of each project is supported with security updates. We do not backport fixes to older versions.

## Safe Harbor

We support safe harbor for security researchers who:

- Make a good-faith effort to avoid privacy violations, data destruction, and service disruption
- Only interact with accounts you own or with explicit permission
- Do not exploit a vulnerability beyond what is necessary to confirm it
- Report vulnerabilities promptly and do not disclose publicly before a fix is available

We will not pursue legal action against researchers who follow these guidelines.

## Recognition

Security researchers who report valid vulnerabilities will be credited in the relevant release notes, unless they prefer to remain anonymous.

## Contact

- **Email**: [security@forgespace.co](mailto:security@forgespace.co)
- **GitHub**: [Private Security Advisory](https://docs.github.com/en/code-security/security-advisories/guidance-on-reporting-and-writing-information-about-vulnerabilities/privately-reporting-a-security-vulnerability) on the affected repository

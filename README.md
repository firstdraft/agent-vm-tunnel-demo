# Agent VM Tunnel Demo

A small, provider-neutral Rails application for validating a live-preview path
from an isolated development environment. The page exercises:

- ordinary proxied HTTP and forwarded host/scheme handling;
- Rails' JSON and framework health checks;
- a CSRF-protected POST that broadcasts a Turbo Stream over Action Cable.

It is intentionally not a chat or sample product. It accepts no user content,
stores no application records, and rate-limits its only mutation.

## Local use

Requires Ruby 4.0 and Bundler. Everything else uses SQLite and process-local
adapters, so there are no service dependencies.

```bash
bin/setup
bin/dev
```

Open <http://localhost:3000>. Open a second tab and click **Send test pulse**;
both tabs should update. `GET /health` returns app JSON and `GET /up` checks that
Rails booted.

Run the same checks as CI with:

```bash
bin/ci
```

## Codex Cloud tunnel integration

The app dogfoods `agent_vm_tunnel` from its public main branch until the gem is
released. The committed connector was generated with `--provider=codex`; Codex
Cloud runs `bash cloud-vm-setup.sh` for setup and
`bin/agent-vm-tunnel ensure` for maintenance. Tunnel credentials remain in the
Cloud environment and are never committed.

The WebSocket smoke test deliberately relies on Rails' exact same-origin check.
Do not add wildcard preview origins.

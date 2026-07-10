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

## Local tunnel-gem integration

The normal `Gemfile` and CI are standalone. `Gemfile.tunnel` is the isolated
integration point for dogfooding a sibling checkout without committing a path
dependency:

```bash
BUNDLE_GEMFILE=Gemfile.tunnel AGENT_VM_TUNNEL_PATH=../agent_vm_tunnel bundle install
BUNDLE_GEMFILE=Gemfile.tunnel AGENT_VM_TUNNEL_PATH=../agent_vm_tunnel bin/dev
```

Its generated `Gemfile.tunnel.lock` is ignored. The demo contains no
provider-specific setup scripts or hooks; connector lifecycle belongs to the
`agent_vm_tunnel` gem.

The WebSocket smoke test deliberately relies on Rails' exact same-origin check.
Do not add wildcard preview origins.

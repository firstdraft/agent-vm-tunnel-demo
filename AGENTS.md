# Working on Agent VM Tunnel Demo

Keep this repository a small provider-neutral smoke target, not an example
product. It should answer three questions quickly: can a browser load Rails over
the preview URL, can an app health request return, and can Action Cable deliver
a live update?

## Guardrails

- Do not add chats, uploads, authentication demos, or other stored user content.
- Do not hand-write provider lifecycle scripts or hooks. Generate supported
  Codex and Claude integration through `agent_vm_tunnel`; never add tunnel
  credentials to the repository.
- Keep Action Cable's exact same-origin protection; never allow wildcard sibling
  origins.
- Keep mutations CSRF-protected, tightly body-limited, and rate-limited.
- Keep the tunnel integration installed through `agent_vm_tunnel`; do not copy
  its runtime logic or add provider hooks by hand.
- Add focused tests for behavior and security invariants with every change.

Run `bin/ci` before committing. It performs setup, style checks, dependency and
static security scans, Rails tests, and a seed smoke test.

<!-- agent-vm-tunnel:codex:start -->
## Live preview in Codex Cloud

Before work that needs the running preview, run `bin/agent-vm-tunnel ensure`.
Use `bin/agent-vm-tunnel status` to diagnose the app or tunnel, and read
`tmp/agent-vm-tunnel/app.log` or `tmp/agent-vm-tunnel/tunnel.log` before
changing configuration. Never commit `AGENT_VM_TUNNEL`; it belongs in the
Codex Cloud environment variables.
<!-- agent-vm-tunnel:codex:end -->

# Working on Agent VM Tunnel Demo

Keep this repository a small provider-neutral smoke target, not an example
product. It should answer three questions quickly: can a browser load Rails over
the preview URL, can an app health request return, and can Action Cable deliver
a live update?

## Guardrails

- Do not add chats, uploads, authentication demos, or other stored user content.
- Do not add provider-branded VM setup scripts, hooks, or tunnel credentials.
- Keep Action Cable's exact same-origin protection; never allow wildcard sibling
  origins.
- Keep mutations CSRF-protected, tightly body-limited, and rate-limited.
- Keep the tunnel integration installed through `agent_vm_tunnel`; do not copy
  its runtime logic or add provider hooks by hand.
- Add focused tests for behavior and security invariants with every change.

Run `bin/ci` before committing. It performs setup, style checks, dependency and
static security scans, Rails tests, and a seed smoke test.

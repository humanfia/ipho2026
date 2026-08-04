# Science Mango Ipho 2026 Run

<!-- archon:readme -->
<!-- Claude fills in the prose sections below. Keep the section headers. -->

## Project

<!-- One paragraph: what is being formalized and why. -->

## References

See [`references/summary.md`](references/summary.md) for a description of each source.

## Structure

- `IPhO2026Run/` — main Lean source
- `blueprint/` — leanblueprint source (build with `leanblueprint pdf` and `leanblueprint web`)
- `references/` — PDFs, papers, and informal notes backing the formalization
- `archon-protected.yaml` — declarations agents must not modify
- `.archon/` — agent state (not committed)

## How to build

```bash
lake exe cache get   # download Mathlib olean cache
lake build           # compile the project
```

## How to run the formalization loop

```bash
archon loop .
```

This launches the plan → prove → review loop and opens a dashboard.

## Token usage

Provider-reported token usage for every theoretical problem is available in
[`TOKEN_USAGE.md`](TOKEN_USAGE.md), with machine-readable data in
[`token_usage_per_problem.csv`](token_usage_per_problem.csv). The report
compares this GPT/Codex v2 run with the Kimi K3 run and marks incomplete
provider telemetry explicitly.

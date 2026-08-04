# Science Mango Ipho 2026 K3 Run

<!-- archon:readme -->

## Project

An isolated Archon run that formalizes all 29 selected IPhO 2026 targets with
Moonshot Kimi K3 through the Anthropic Messages API. The benchmark contains
23 theoretical targets and 6 experimental targets; proof accuracy is reported
on the theoretical targets only.

Current verified theoretical score: **23/23 (100%)**. All six experimental
targets are excluded from this metric. The added T3-C.1 target and the
source-corrected T3-C.2 target both compile with zero `sorry` and passed
independent Kimi K3 review.

## Performance and token comparison

| Metric | GPT/Codex v2 | Kimi K3 |
|---|---:|---:|
| Theoretical proof score | **23/23 (100%)** | **23/23 (100%)** |
| Full lake build | Passed | Passed |
| Active sorry | 0 | 0 |
| Provider-token session coverage | 79/80 (98.75%) | 23/289 (7.96%) |
| Known token total | ≥150,279,368 | ≥64,381,419 |

The token totals are lower bounds, not an efficiency ranking: most Kimi K3
sessions have no provider usage telemetry. See
[MODEL_COMPARISON.md](MODEL_COMPARISON.md) for the conclusions and
methodology.

## References

See [`references/summary.md`](references/summary.md) for a description of each source.

## Structure

- `IPhO2026Problems/` — main Lean source
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
scripts/start_ipho_2026_k3.sh --resume
scripts/status_ipho_2026_k3.sh
```

The launcher validates the pinned K3 Anthropic harness, starts the LeanExplore
endpoint, and runs a queue of 29 targets with up to four concurrent target
lifecycles. Secrets remain in the ignored `.archon/.env` file.

## Token usage

Provider-reported token usage for every theoretical problem is available in
[`TOKEN_USAGE.md`](TOKEN_USAGE.md), with machine-readable data in
[`token_usage_per_problem.csv`](token_usage_per_problem.csv). The report
compares this Kimi K3 run with the GPT/Codex v2 run and marks incomplete
provider telemetry explicitly.

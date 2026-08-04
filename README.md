# Humanfia at IPhO 2026

## Results & Cost

> **Results: GPT/Codex v2 and Kimi K3 both solved all 23/23 theoretical
> targets (100%). Every released theory file passes Lean verification with no
> active sorry.**
>
> **Known provider-reported token cost: GPT/Codex v2 ≥150,279,368 tokens;
> Kimi K3 ≥64,381,419 tokens. These are lower bounds, not directly comparable
> totals.**

| Run | Theoretical result | Lean verification | Token-session coverage | Known token cost |
|---|---:|---:|---:|---:|
| GPT/Codex v2 | **23/23 (100%)** | 23/23 pass; sorry = 0 | 79/80 (98.75%) | **≥150,279,368** |
| Kimi K3 | **23/23 (100%)** | 23/23 pass; sorry = 0 | 23/289 (7.96%) | **≥64,381,419** |

Kimi K3 has 266 direct sessions without provider usage telemetry, while
GPT/Codex v2 has one. Missing usage is not counted as zero, so the current
data cannot support a token-efficiency ranking. A reliable USD cost is also
not reported: the exact GPT model ID was not pinned and Kimi telemetry is
incomplete. See [MODEL_COMPARISON.md](MODEL_COMPARISON.md) for the conclusions
and [TOKEN_USAGE.md](TOKEN_USAGE.md) for every problem.

## Results by theory paper

| Paper | Targets | GPT/Codex v2 | Kimi K3 |
|---|---:|---:|---:|
| T1 | 5 | 5/5 | 5/5 |
| T2 | 8 | 8/8 | 8/8 |
| T3 | 10 | 10/10 | 10/10 |
| **Total** | **23** | **23/23** | **23/23** |

The six experimental targets are excluded from this score. Their snapshots
are kept under [experimental](experimental) for completeness, are not claimed
as solved, and may contain proof placeholders.

## Released contents

- [codex-v2-solution](codex-v2-solution): 23 final GPT/Codex v2 theory files.
- [kimi-k3-solution](kimi-k3-solution): 23 final Kimi K3 theory files.
- [base](base): shared Lean 4.31.0, Mathlib v4.31.0, and pinned PhysLean
  environment.
- [experimental](experimental): the six excluded experimental targets for
  each run.
- [blueprints](blueprints), [references](references), and [reports](reports):
  formalization notes, official source material, and per-run source metadata.
- [scripts](scripts): verification plus the namespaced run harnesses.
- [token_usage_per_problem.csv](token_usage_per_problem.csv): machine-readable
  per-problem token data.

The main branch is the canonical side-by-side release, following the layout of
[humanfia/imo2026](https://github.com/humanfia/imo2026). The original
[codex-v2](https://github.com/humanfia/ipho2026/tree/codex-v2) and
[kimi-k3](https://github.com/humanfia/ipho2026/tree/kimi-k3) branches remain
available as immutable run snapshots.

## Verification

Install the pinned dependencies and check the shared base project:

    cd base
    lake exe cache get
    lake build Physlib
    lake build
    cd ..

Then type-check all 46 released theory files:

    scripts/check-all.sh

The checker compiles every file independently and fails if Lean reports an
active sorry declaration.

## Reproduction notes

The model-run harnesses are preserved under [scripts/codex-v2](scripts/codex-v2)
and [scripts/kimi-k3](scripts/kimi-k3). They were written for the original
pre-provisioned Linux environment and contain environment-specific paths; they
are provenance artifacts, not portable one-command installers.

Token accounting includes only sessions uniquely attributable to one theory
target, including retries, failed attempts, per-target review, and repair.
Shared planning and orchestration are not force-allocated across problems.
Provider-reported cached input, non-cached input, and output are summed once.

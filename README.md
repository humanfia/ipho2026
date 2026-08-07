# Humanfia at IPhO 2026

## Results & Cost

> **Results: GPT/Codex v2 and Kimi K3 both solved all 23/23 theoretical
> targets (100%). Every released theory file passes Lean verification with no
> active sorry.**
>
> **Token cost on the 22 directly comparable targets: GPT/Codex v2 used
> 146,641,757 provider-reported tokens; Kimi K3 used 1,189,135,736 tokens by
> exact usage plus trajectory reconstruction. Kimi K3 used 8.11× as many.**
>
> **Across all 23 Kimi K3 targets, the complete trajectory total is
> 1,220,581,322 tokens. GPT/Codex v2 T3-B1 is omitted from cost comparison
> because one session lacks complete usage.**

| Run | Theoretical result | Lean verification | Provider-exact rows | Complete trajectory rows |
|---|---:|---:|---:|---:|
| GPT/Codex v2 | **23/23 (100%)** | 23/23 pass; sorry = 0 | **22/23** | **22/23** |
| Kimi K3 | **23/23 (100%)** | 23/23 pass; sorry = 0 | **1/23** | **23/23** |

Full token counts for both runs are listed under
[Token usage](#token-usage) below.
See [MODEL_COMPARISON.md](MODEL_COMPARISON.md) for the conclusions,
[TOKEN_USAGE.md](TOKEN_USAGE.md) for provider-exact rows, and
[TOKEN_USAGE_RECONSTRUCTED.md](TOKEN_USAGE_RECONSTRUCTED.md) for Kimi K3's
complete per-problem trajectory reconstruction. USD cost is not reported
because the reconstructed early Kimi K3 calls do not retain cache-billing
categories.

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

## Token usage

The totals below are sums of the published per-problem data in
[token_usage_per_problem.csv](token_usage_per_problem.csv) and
[token_usage_reconstructed_per_problem.csv](token_usage_reconstructed_per_problem.csv).
Total = non-cached input + cached input + output. Reasoning tokens are a
subset of output and are not added again.

### Side by side, on the 22 directly comparable targets

| Run | Input | Output | Total tokens | Relative |
|---|---:|---:|---:|---:|
| GPT/Codex v2 | 145,594,784 | 1,046,973 | **146,641,757** | **1.00×** |
| Kimi K3 | 1,182,905,613 | 6,230,123 | **1,189,135,736** | **8.11×** |

T3-B1 is excluded from this comparison: one GPT/Codex v2 session lacks
complete usage, so no 23-target GPT total is published.

### GPT/Codex v2 — provider-exact, 22 of 23 targets

| Category | Tokens |
|---|---:|
| Non-cached input | 7,715,232 |
| Cached input | 137,879,552 |
| Input subtotal | 145,594,784 |
| Output | 1,046,973 |
| **Total** | **146,641,757** |

Cached input is 94.7% of all input on these 22 targets.

### Kimi K3 — provider-exact plus trajectory reconstruction, 23 of 23 targets

| Source | Input | Output | Total |
|---|---:|---:|---:|
| Provider-exact | 66,499,412 | 1,384,798 | 67,884,210 |
| Trajectory-reconstructed | 1,147,622,258 | 5,074,854 | 1,152,697,112 |
| **All 23 targets** | **1,214,121,670** | **6,459,652** | **1,220,581,322** |
| Common 22 targets | 1,182,905,613 | 6,230,123 | 1,189,135,736 |

Only T3-C1 is fully provider-metered; the remaining targets are wholly or
partly replayed with the pinned official tokenizer, which does not retain a
cached / non-cached split. Input is 99.48% of the common-22 total, which is
where the gap with GPT/Codex v2 comes from: on those 22 targets Kimi K3 ran
302 attributable sessions and 13,273 successful model calls against 76
sessions and 2,825 metered turns for GPT/Codex v2, and each additional call
re-sends the accumulated context.

Per-problem tables are in [TOKEN_USAGE.md](TOKEN_USAGE.md) (provider-exact)
and [TOKEN_USAGE_RECONSTRUCTED.md](TOKEN_USAGE_RECONSTRUCTED.md) (Kimi K3
full trajectory). These are token counts only; no per-token price is recorded
in this repository, so no USD figure is derived from them.

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
- [TOKEN_USAGE.md](TOKEN_USAGE.md) and
  [TOKEN_USAGE_RECONSTRUCTED.md](TOKEN_USAGE_RECONSTRUCTED.md): provider-exact
  and trajectory-reconstructed Token reports.
- [token_usage_per_problem.csv](token_usage_per_problem.csv): machine-readable
  data containing only provider-metered problems.
- [token_usage_reconstructed_per_problem.csv](token_usage_reconstructed_per_problem.csv):
  machine-readable Kimi K3 exact-plus-reconstructed data for all 23 theory
  targets.

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
target, including retries, per-target review, and repair. Shared planning is
not force-allocated across problems. The provider-exact report sums cached
input, non-cached input, and output once and publishes only fully metered
problems. The reconstruction report replays every successful saved Kimi K3
request with the pinned official tokenizer; calls without a successful model
output or reliable usage are counted and disclosed but are not assigned a
Token value.
Raw conversations, request bodies, credentials, and private environment paths
are not included in this release.

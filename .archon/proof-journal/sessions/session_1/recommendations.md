# Recommendations for Iteration 002

## Critical: modeling/source repairs before prover dispatch

1. Redraft `1_C_1` and propagate to `1_C_2`.
   - Replace the C.1 radicand coefficient by the conservation-law result containing the missing factor `2`.
   - Recompute the backward-angle specialization.
   - Update `QuotedPreviousPartC1Result`; then verify the C.2 value near `2.0296693e-11 eV`.
   - Do not assign either target to a physics prover until this semantic gate passes.

2. Clear all five doctor blockers and rerun the doctor:
   - `2_A_1`, `2_C_2`, `2_C_3`: import Physlib/PhysLean. Blocking reason: “physics target does not import Physlib/PhysLean; attempted grounding should use the available formal physics library before introducing local abstractions”.
   - `3_C_3`, `4_A_1`: import Mathlib. Blocking reason: “physics target does not import Mathlib; autoformalization must be checked in a real Lake/Mathlib environment, not as a standalone Lean smoke file”.
   - Reconcile each local abstraction with the already logged LeanExplore candidates; a compile-only smoke check is insufficient.

3. Repair `4_A_1` source grounding.
   - Attach the official Figure 17 page containing the cylinder dimensions.
   - Verify the mass answer: `n = 3.24 mmol` and `N = 1.95e21` agree, while `m = 0.94 g` implies an implausible roughly `0.29 kg/mol`.
   - Extend the target from symbolic formulas to the corrected, source-grounded numerical inventory before re-review.

## Dispatch after mapping

- Add the `\lean{...}` declaration associations listed as `target.theorem` in `milestones.jsonl` for all 28 chapters; marker sync ran in current-objectives scope but could not add markers without mappings.
- Advance the 21 review-passing targets to physics prover mode. Keep the 7 failed targets blocked.
- Closest algebraic targets: `2_B_3`, `3_A_1`, `3_A_2`, `3_A_3`, `3_C_5`, `4_A_5`, `4_B_4`, `4_B_6`, `4_C_6`.
- Calculus/asymptotics targets needing focused plans: `1_B_2`, `2_C_4`, `3_B_1`, `3_B_2`, `3_C_4`, `4_C_7`.

## Proof patterns

- For local optics expansions, retain the successful contracts:
  - first order: residual `=O[𝓝 0] (fun Δθ => Δθ ^ 2)`;
  - caustic intersection/cusp: `Tendsto` through `𝓝[≠] 0`.
- For thermodynamics, derive an invariant/antiderivative from `HasDerivAt` or `deriv` laws before endpoint algebra; never replace the process with its answer.
- For experimental ratio targets, extract positivity/nonzero denominators first, then use `field_simp`/ring normalization and finally close uncertainty bounds numerically.

## Review infrastructure

- Fix attempt preprocessing: 84 `code_change` events were recorded, but normalized file/text fields are empty. Preserve target path and edit payload so future milestones can cite exact actual edits rather than only bounded report evidence.
- No dedicated `physics-reviewer` report exists for iter 001; enable it in a later iteration if an independent physics audit is desired after the seven redrafts.

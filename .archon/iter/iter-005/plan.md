# Iteration 005 bounded proof plan

## Batch policy

- Process exactly the three mandatory proof-Review retries below, in the selected order. Preserve every theorem statement and physical hypothesis.
- Treat a missing physical bridge as an underdetermined contract, not as a tactic problem: do not infer velocity direction from position limits or a radius equation from uninterpreted path predicates. If the bridge is absent, retain the single honest `sorry` and report the required relation precisely.
- Validate each target independently with the Lean LSP or `lake env lean <file>`. The supplied blueprint excerpts accurately state the source questions, so no Plan-stage chapter correction is needed.

## Per-target strategies

1. **`IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`** — Reuse the established eccentricity value and convergence of the normalized displacement component to `1 / eccentricity`. Check the frozen conic-law hypotheses for an explicit outgoing-branch law connecting the nonzero limiting relative velocity `uInfinity` to that asymptotic displacement direction. If present, rewrite the signed-angle definition with that law, substitute `eccentricity = 7/2`, select the outgoing branch, and prove the `-16.60°` nearest-hundredth interval using monotonicity of `Real.cos`/`Real.arccos` plus certified rational bounds. If no such velocity/asymptote bridge is present, stop at the existing derived limits: `Tendsto` of position direction alone cannot determine the limiting velocity angle, so leave the remaining `sorry` with that exact blocker.

2. **`IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`** — Isolate the sole gap in `radiusAtIncidence_from_figure2f`. Use a frozen `Figure2fReadout` or governing-law projection only if it explicitly states that a one-reflection limiting tangent path gives
   `radiusAtIncidence θ = (sin θ - (1/2) sin (2θ)) • mirrorRadius`; then the downstream coefficient theorem follows by evaluating at `π/2` to obtain `α = R` and at `π/4` to obtain `β = -R/2`, using `WithDim.ext`, the standard sine values, and linear arithmetic. The supplied `isPhysicalPath`, `isLimitingPathForRadius`, and `isTangentToContainer` predicates have no stated numerical consequence; if no bridge projection exists, retain the helper’s `sorry` and report that missing geometric implication rather than manufacturing the radius formula.

3. **`IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`** — The supplied proof is already placeholder-free. Revalidate it as the intended proof: specialize the three governing laws to one positive mole, rewrite mass and latent energy, divide by the positive molar mass to derive `L_v = Q_v / M₀`, then substitute `Q_v = 39 kJ/mol` and the recorded water molar mass and close the `2190 ± 110 kJ/kg` band with exact arithmetic. Confirm that the uncertainty-band conjunct is proved from the frozen numerical data without changing its physical units or statement; make no Lean edit if compilation and Review both pass.

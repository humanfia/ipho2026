# Prover result: IPhO 2026 problem 2 C.2

## Status

- Closed all three `sorry` placeholders in
  `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean` (3 → 0).
- Proved `rayB_slope_firstOrder`, `rayB_intercept_firstOrder`, and the final
  conjunction `IPhO_2026_2_C_2`.
- All declaration headers and physical hypotheses were left unchanged.
- No redraft is needed.

## Proof

For each exact angle-dependent readout, the proof uses the imported analytic
power-series remainder theorem
`HasFPowerSeriesAt.isBigO_sub_partialSum_pow` at order two. A local argument
identifies the two-term partial sum with `f θ + f' * Δθ`, yielding the required
`O(Δθ²)` residual.

- For the slope, `Real.cot (2 * θ)` is rewritten as the quotient of cosine and
  sine. The quotient rule and `Real.sin_sq_add_cos_sq` give derivative
  `-2 * (Real.sin (2 * θ))⁻¹ ^ 2`.
- For the intercept, the quotient rule applied to
  `R / (2 * Real.cos θ)` gives derivative
  `(R / (2 * Real.cos θ)) * Real.tan θ`.
- Positivity and acuteness of the setup angle establish the required
  nonvanishing denominators. They also give a neighborhood of `Δθ = 0` on
  which `θ + Δθ` remains physically admissible, so
  `HalfCylindricalReflectionLaw` identifies the modeled ray readouts with the
  exact trigonometric formulas.
- The final theorem pairs the two proved expansion lemmas.

The exact reflection law is stronger than the central-ray equality supplied by
`previousPart`, so that frozen argument is intentionally unused in the first
two lemmas; Lean reports only the corresponding linter warnings.

## Verification

- Lean LSP diagnostics: no errors; only the two expected unused-variable
  warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_2.lean`: passed.
- `lake build`: passed (`Build completed successfully (4 jobs)`).
- `lean_verify` on all three proved theorems found only the standard
  foundational axioms `propext`, `Classical.choice`, and `Quot.sound`, with no
  suspicious source warnings.
- Direct source scan found no `sorry`, `admit`, `axiom`, `sorryAx`, or
  `native_decide`.

## Blueprint readiness

The proof environments for
`IPhO2026_2_C_2.rayB_slope_firstOrder`,
`IPhO2026_2_C_2.rayB_intercept_firstOrder`, and
`IPhO2026_2_C_2.IPhO_2026_2_C_2` are closed and ready for the deterministic
`sync_leanok` phase. Per prover permissions, the blueprint chapter was not
edited directly.

## Redraft needed

None.

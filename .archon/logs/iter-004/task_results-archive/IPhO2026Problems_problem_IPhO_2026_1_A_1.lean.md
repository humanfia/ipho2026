# Prover result: IPhO 2026 problem 1 A.1

## Status

- Closed the sole `sorry` in
  `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`.
- The protected theorem signature was left unchanged.
- No redraft is needed.

## Proof

The limiting torque equation is expanded using the hydrostatic-law and
Figure 1a hypotheses.  After using `(Real.sqrt 2)^2 = 2`, it factors as

`ρ * g * a^3 * (Δh * Real.sqrt 2 - 4 * a) = 0`.

Strict positivity of `ρ`, `g`, and `a` rules out the physical prefactor, so
`a = Δh / (2 * Real.sqrt 2)`.  Extensionality of `WithDim` lifts this scalar
identity to the requested `LengthSI` equality.

For the rounding conclusion, the supplied `Δh = 141/100` is substituted and
the rational bounds

`7/5 ≤ Real.sqrt 2 ≤ 99/70`

are proved by squaring.  These bounds put the resulting side length within
`1/200 m` of `50/100 m`.

## Verification

- Lean LSP diagnostics: clean.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`: passed.
- `lake build`: passed (`Build completed successfully`).
- Axiom/source verification found only Lean's standard
  `propext`, `Classical.choice`, and `Quot.sound`; source scan warnings: none.
- Source scan confirms no `sorry`, `admit`, `axiom`, `sorryAx`, or
  `native_decide` remains in the assigned file.

## Blueprint readiness

`IPhO2026Problems.IPhO2026_1_A_1.sideLength_at_maximumLevelDifference` is
closed and ready for the deterministic `sync_leanok` phase.

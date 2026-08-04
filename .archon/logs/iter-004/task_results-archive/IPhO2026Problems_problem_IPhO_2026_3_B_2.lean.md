# Prover result: IPhO 2026 problem 3 B.2

## Summary

- Sorry count: **1 → 1**.
- The theorem signature was kept unchanged.
- Replaced the bare placeholder with a compiling partial proof that establishes:
  - positivity of both endpoint temperatures;
  - positivity of the initial and final invariant denominators;
  - positivity after substituting the named endpoint values;
  - the interior adiabatic energy balance
    \[
      \frac{n\lambda}{T(\tau)^2}T'(\tau)
        = \mu_0 V H(\tau)M'(\tau).
    \]

The remaining mathematical argument is clear: differentiate
`T * M * V = n * K * H`, eliminate `M'` with the energy balance, and obtain

`(lambda + mu₀ * K * H^2) * T' = mu₀ * K * H * T * H'`.

This makes

`T^2 / (lambda + mu₀ * K * H^2)`

constant on `[0, 1]`. Endpoint positivity then selects the positive square
root and gives the stated formula.

## Specific blocker

The assigned file imports `Mathlib.Analysis.Calculus.Deriv.Basic`, which
defines `deriv` but does **not** expose:

- product and quotient derivative rules (`HasDerivAt.mul`,
  `HasDerivAt.div`);
- the interval mean-value theorem (`exists_deriv_eq_slope`).

The exact Lean errors from checking the current imports were:

- `Unknown constant HasDerivAt.mul`
- `Unknown constant HasDerivAt.div`
- `Unknown identifier exists_deriv_eq_slope`

A generic Lean proof of the conserved-ratio argument was successfully checked
under `import Mathlib`. The minimal module-level remedy is to import the
appropriate derivative algebra and mean-value modules, for example
`Mathlib.Analysis.Calculus.Deriv.Inv` and
`Mathlib.Analysis.Calculus.MeanValue` (using multiplication instead of `pow`
in the differentiated invariant). The prover instructions freeze everything
outside the body after `:= by`, so I did not alter the import list.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`: exit code 0.
- Lean LSP diagnostics: no errors; one expected warning that
  `adiabatic_temperature_change` still uses `sorry`.
- No axiom, `admit`, `native_decide`, or `sorryAx` was introduced.

## Blueprint status

The proof environment for
`IPhO2026Problems.IPhO2026_3_B_2.adiabatic_temperature_change` is **not**
ready for a proof `\leanok` marker because the focused final `sorry` remains.
Per prover permissions, the blueprint was not edited.

## Redraft needed

None. The theorem statement is physically faithful and mathematically
provable as written; the blocker is the frozen module import surface, not a
missing physical hypothesis or an incorrect conclusion.

# IPhO2026Problems/problem_IPhO_2026_4_C_7.lean

## acrylicConductivity_from_radial_fourier (line 197)

### Attempt 1

- **Approach:** Reduce the resistance, orientation, and cylindrical Fourier equations algebraically to
  `radialTemperatureGradientKelvinPerMeter t r = (ΔT / (R * κ * 2 * π * h)) * r⁻¹`
  on `[r₁, r₂]`; derive positivity/nonzero facts from the figure and governing-law records.
- **Result:** PARTIAL — this reduction, the `HasDerivWithinAt` profile statement, interval continuity,
  boundary rewrites, logarithm quotient rewrite, cancellation of `ΔT`, and final field algebra all compile.
- **Remaining gap:** the single focused `sorry` is the endpoint integration identity
  `ΔT = coefficient * (Real.log r₂ - Real.log r₁)`.

### Attempt 2

- **Approach:** Compare the radial profile with
  `profile r₁ + coefficient * (Real.log r - Real.log r₁)` using the logarithm derivative and
  equality of functions with equal right derivatives.
- **Result:** COMPLETE PROOF VALIDATED WITH TWO ADDITIONAL IMPORTS. Prepending
  `Mathlib.Analysis.SpecialFunctions.Log.Deriv` and
  `Mathlib.Analysis.Calculus.MeanValue` makes the complete unchanged proof compile; the check
  finished with only the pre-existing unused-`previousPart` linter warning.
- **Frozen-import blocker:** the assigned signature discipline permits edits only after `:= by`,
  so those imports could not be added. In the actual file environment Lean reports:
  `Unknown constant Real.hasDerivAt_log` and
  `Unknown identifier eq_of_has_deriv_right_eq`.
  Local checks confirmed both names are supplied by the two modules above.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`: success, with the expected
  `declaration uses sorry` warning only.
- `git diff --check`: clean.
- No axioms, `admit`, `native_decide`, or laundering declarations were introduced.
- The requested `archon dag-query` could not run because `/bin/bash` reported
  `archon: command not found`.
- Informal-agent credential check found no configured provider key; no external informal agent was run.

## Import-only blocker (no statement redraft needed)

- Original problem: `IPhO_2026_4`, part C.7.
- Source report: `reports/ipho_2026/problem_IPhO_2026_4_C_7.source.json`.
- The theorem statement is mathematically sufficient and physically faithful. No hypothesis or
  conclusion change is needed. Allowing the two Mathlib imports listed above is sufficient to close
  the remaining proof without changing the protected declaration.

## Summary

- Sorry count: **1 → 1**.
- Closed sorries: none.
- Still open: `acrylicConductivity_from_radial_fourier`, only at its endpoint integration step.
- No adjacent sorries exist in the assigned file.

## Why I stopped

- **Partial progress:** the file now contains a compiling derivation through the radial-gradient ODE
  and a compiling post-integration cancellation argument. The complete middle integration argument
  was also compiled successfully in a read-only streamed test with the required modules prepended.
- Continuing inside the proof body alone would require reproving Mathlib's logarithm derivative and
  mean-value theorem from primitive definitions despite their already-available library
  implementations; loading them through metaprogramming would violate the anti-elaboration-trick rule.

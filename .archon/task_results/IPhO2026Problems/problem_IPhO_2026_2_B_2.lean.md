# Prover result: `problem_IPhO_2026_2_B_2.lean`

## Status

- Closed all three assigned proof obligations:
  `container_radius_factorization`,
  `power_ratio_eq_projected_width_ratio`, and
  `power_ratio_eq_one_div_one_sub_cos`.
- No `sorry`, `admit`, new axioms, `sorryAx`, or redraft request remains.
- The three corresponding blueprint proof environments are ready for the
  deterministic `\leanok` synchronization. The blueprint was not edited
  because prover permissions make it read-only.

## Proof summary

- Rewrote the Part B.1 radius decomposition using its two coefficient
  equalities and `Real.sin_two_mul`, then normalized the resulting polynomial
  identity with `ring`.
- Used positivity of irradiance, axial length, and container radius to show
  that the no-mirror projected width and power are nonzero. Cross multiplication
  then cancels the common irradiance and axial-length factors.
- Used the strict acute-angle geometry to prove
  `0 < sin θ_max`. Positivity of the mirror radius makes the collected-width
  factor `2 R sin θ_max` nonzero, so `mul_div_mul_left` cancels it after the
  two projected-width formulas and the radius factorization are substituted.
- The frozen `hRays` hypothesis is stronger than needed for this final
  algebraic power-ratio calculation; Lean reports only its unused-variable
  linter warning.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`: succeeded
  with no errors and only the expected unused-`hRays` linter warning.
- `lake build`: succeeded.
- Escape-hatch scan of the assigned file: no matches.

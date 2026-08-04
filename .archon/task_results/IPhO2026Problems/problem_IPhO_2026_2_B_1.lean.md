# Prover result: IPhO 2026 problem 2 B.1

## Status

Complete. The reviewed redraft was already closed and required no change to the
assigned Lean file.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_1.lean` succeeded.
- `lake build` succeeded (`Build completed successfully (4 jobs)`).
- The file contains no `sorry`, `admit`, `axiom`, `native_decide`, or
  `sorryAx`.
- `#print axioms
  IPhO2026Problems.IPhO2026_2_B_1.coefficients_from_solar_cooker_geometry`
  reports only `propext`, `Classical.choice`, and `Quot.sound`.

## Faithfulness check

The final theorem uses the required dependency chain:

1. `IsMaximumIncidenceAngle` and `MaximalRayTangencyLaw` supply an attained
   limiting tangent ray.
2. `maximum_ray_containerRadius_eq_limitingRadius` converts tangency into the
   actual container-radius equation.
3. `limitingRadiusMeters_eq_trigFormula` derives
   `a = R * sin θ_max - (R / 2) * sin (2 * θ_max)`.
4. The theorem exhibits dimension-tagged witnesses `alpha = R` and
   `beta = scaledLength (-(1 / 2)) R`.

No answer-bearing coefficient identity is assumed.

## Blueprint marker readiness

`IPhO2026Problems.IPhO2026_2_B_1.coefficients_from_solar_cooker_geometry` and
its supporting proof declarations are closed and ready for deterministic
`\leanok` synchronization.

## Remaining blockers

None.

# IPhO2026Problems/problem_IPhO_2026_3_B_2.lean

## Result

- Closed all three `sorry` placeholders without changing any declaration signature.
- `reduced_adiabatic_temperature_ode`: differentiated the equation of state within
  `processDomain`, combined the heat-capacity, first-law, adiabatic, and magnetic-work
  hypotheses, and canceled only the explicitly positive amount-in-moles factor.
- `magnetothermal_invariant_constant`: proved positivity of the magnetothermal scale,
  differentiated `T² / (λ + μ₀ K H²)`, reduced its derivative to zero with the ODE,
  and applied `constant_of_derivWithin_zero` on `[0,1]`.
- `adiabatic_temperature_change`: evaluated the invariant at both endpoints,
  cross-multiplied the positive scales, and used positive endpoint temperatures to
  select the nonnegative square-root branch.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` succeeds with no
  diagnostics.
- `lake build` succeeds (`Build completed successfully`).
- Source scan finds no `sorry`, `admit`, `sorryAx`, or introduced `axiom`.
- Axiom verification of the final theorem reports only the standard foundational
  axioms `propext`, `Classical.choice`, and `Quot.sound`.

## Blueprint marker readiness

The proof environments for
`IPhO2026Problems.IPhO2026_3_B_2.reduced_adiabatic_temperature_ode`,
`IPhO2026Problems.IPhO2026_3_B_2.magnetothermal_invariant_constant`, and
`IPhO2026Problems.IPhO2026_3_B_2.adiabatic_temperature_change` are ready for
`\leanok`. The prover did not edit the blueprint because the project-local role
instructions reserve marker synchronization for the deterministic sync phase.

## Redraft needed

None.

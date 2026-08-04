# Prover result: IPhO 2026 problem 3 C.2

## Summary

- Sorry count: **1 → 0**.
- Closed
  `IPhO2026Problems.IPhO2026_3_C_2.magnetization_state1_eq_sqrt`.
- The declaration header and all physical hypotheses remain unchanged.

The proof converts the equation of state at each vertex to scalar equalities.
It combines the cold and hot isothermal laws with the reversible Carnot heat
balance to obtain
`T_h² (H₃² - H₂²) + T_c² (H₁² - H₄²) = 0`. Substituting
`H_i = T_i M_i V / (n K)` and cancelling the positive common factor gives
`M₁² = M₂² - M₃² + M₄²`. Magnetization nonnegativity then selects the
nonnegative square root via `Real.sqrt_sq`.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`: passed with
  no output.
- `lake build IPhO2026Run`: completed successfully (4 jobs).
- Lean LSP diagnostics: no errors or warnings.
- `lean_verify`: only the standard foundational axioms `propext`,
  `Classical.choice`, and `Quot.sound`; no suspicious source patterns.
- A direct source scan found no `sorry`, `admit`, `axiom`, `sorryAx`, or
  `native_decide`.

## Blueprint status

The proof environment for
`IPhO2026Problems.IPhO2026_3_C_2.magnetization_state1_eq_sqrt` is ready for
its `\leanok` marker. Per prover write restrictions, the blueprint was not
edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

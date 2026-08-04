# Prover result: IPhO 2026 problem 1 C.1

## Summary

- Sorry count: **1 → 0**.
- Closed
  `IPhO2026Problems.IPhO2026_1_C_1.minimumAngularFrequency_eq`.
- The declaration header and physical model were left unchanged.

The proof lifts explicitly chosen SI vectors into `MomentumQuantity2` and proves
the two-dimensional norm identity implied by momentum conservation. For
`θ ≤ π / 2`, completing the square in the molecular momentum gives the kinetic
lower bound with `A = 2 * sin² θ + 1`; the constructed equality case has
molecular momentum magnitude `2q cos θ / 3`. For `π / 2 ≤ θ`, `cos θ ≤ 0`
makes zero molecular momentum the constrained equality case. In both branches,
the corrected square-root expression is shown to solve the corresponding
energy quadratic, and the minimum-frequency hypothesis supplies the opposite
inequality.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`: passed with
  no diagnostics.
- `lean_verify`: only the standard foundational axioms `propext`,
  `Classical.choice`, and `Quot.sound`.
- Source scan found no `sorry`, `admit`, `axiom`, `sorryAx`, or suspicious
  proof escape.

## Blueprint status

The proof environment for
`IPhO2026Problems.IPhO2026_1_C_1.minimumAngularFrequency_eq` is ready for its
`\leanok` marker. Per prover write restrictions, the blueprint was not edited;
the deterministic marker synchronization should apply it.

## Redraft needed

None.

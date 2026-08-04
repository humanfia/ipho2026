# Prover result: IPhO 2026 problem 1 C.2

## Summary

- Sorry count: **1 → 0**.
- Closed
  `IPhO2026Problems.IPhO2026_1_C_2.problem_IPhO_2026_1_C_2`.
- The declaration header and all physical hypotheses remain unchanged.

The proof applies the corrected forward-angle threshold formula from C.1,
substitutes the C.2 angle, mass, and energy data, and reduces every
dimensionful SI readout to its exact rational value. The remaining square root
is bounded between two 24-decimal rational numbers by proving its exact squared
value and using `nlinarith`. Those bounds imply the requested
`2.03e-11 ± 5e-14` eV rounding interval.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_2.lean`: passed.
  The only diagnostic is the frozen but unused `physics` hypothesis.
- `lake build`: completed successfully (4 jobs).
- Lean LSP diagnostics: no errors; only the same unused-variable warning.
- `lean_verify`: only the standard foundational axioms `propext`,
  `Classical.choice`, and `Quot.sound`; no suspicious source patterns.
- A direct source scan found no `sorry`, `admit`, `axiom`, or `sorryAx`.

## Blueprint status

The proof environment for
`IPhO2026Problems.IPhO2026_1_C_2.problem_IPhO_2026_1_C_2` is ready for its
`\leanok` marker. Per prover write restrictions, the blueprint was not edited;
deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

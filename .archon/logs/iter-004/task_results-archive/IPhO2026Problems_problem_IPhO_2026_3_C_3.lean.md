# Prover result: IPhO 2026 problem 3 C.3

## Summary

- Sorry count: **1 → 0**.
- Closed
  `IPhO2026Problems.IPhO2026_3_C_3.helium_temperature_after_one_cycle`.
- No sorries remain in the assigned file.

The proof first rewrites the licensed cold-isotherm heat formula with the
supplied field values, material constants, and the fact that the cold
reservoir initially has temperature `1 K`. It then rewrites helium
calorimetry to the exact relation
`Q_c = 13 * (1 - T_final)`. Mathlib's bounds
`Real.pi_gt_d4` and `Real.pi_lt_d4`, followed by `nlinarith`, establish all
three requested rounding intervals.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`: exit code 0
  with no output.
- Lean LSP diagnostics: no errors or warnings.
- `lean_verify` reported only standard foundational axioms
  (`propext`, `Classical.choice`, and `Quot.sound`) and no suspicious source
  patterns.
- No `sorry` remains in the assigned file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_3_C_3:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions, the blueprint was
not edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.

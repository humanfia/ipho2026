# Prover result: IPhO 2026 problem 4 A.1

## Summary

- Sorry count: **1 → 0**.
- Closed
  `IPhO2026Problems.IPhO_2026_4_A_1.determineConfinedAirInventory`.
- No sorries remain in the assigned file.

The proof derives the diameter-based cylindrical volume from the primitive
radius formula, then obtains the mass, amount, and molecule formulas from the
density, molar-mass, and Avogadro relations. It substitutes the source
readouts and proves all three uncertainty intervals using exact rational
normalization together with Mathlib's certified bounds
`Real.pi_gt_d6` and `Real.pi_lt_d6`.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`: exit code 0
  with no output.
- `lake build`: completed successfully (4 jobs).
- Lean LSP diagnostics: no errors or warnings.
- `lean_verify` reported only standard foundational axioms
  (`propext`, `Classical.choice`, and `Quot.sound`) and no suspicious source
  patterns.
- A direct scan found no `sorry`, `admit`, `axiom`, `sorryAx`,
  `native_decide`, or `USER:` comments in the assigned file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_4_A_1:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions, the blueprint was
not edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.

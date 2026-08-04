# Prover result: IPhO 2026 problem 3 C.4

## Summary

- Sorry count: **1 → 0**.
- Closed
  `IPhO2026Problems.IPhO2026_3_C_4.IPhO_2026_3_C_4_elapsedTime`.
- No sorries remain in the assigned file.

The proof eliminates the hot and cold heat rates from the power-balance and
Carnot-ratio hypotheses, obtaining
`T' = -P*T / (C*(T_h-T))`. It then applies the mean-value theorem to
`(C/P) * (T_h * log T - T)`, whose derivative is `-1`, and simplifies the
endpoint identity to the requested elapsed-time formula.

The import of `Mathlib.Analysis.SpecialFunctions.Log.Basic` was strengthened
to `Mathlib.Analysis.SpecialFunctions.Log.Deriv`; this supplies the derivative
of `Real.log` and the mean-value theorem used by the proof. No declaration
signature was changed.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`: exit code 0;
  only unused-hypothesis linter warnings were emitted.
- Lean LSP diagnostics: no errors; only unused-hypothesis linter warnings.
- `lake build`: exit code 0.
- `lean_verify` reported only the standard foundational axioms
  (`propext`, `Classical.choice`, and `Quot.sound`) and no suspicious source
  patterns.
- No `sorry`, `admit`, `axiom`, or `sorryAx` remains in the assigned file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_3_C_4:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions, the blueprint was
not edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.

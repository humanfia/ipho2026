# Prover result: IPhO 2026 problem 3 B.1

## Summary

- Sorry count: **1 → 0**.
- Closed
  `IPhO2026Problems.IPhO2026_3_B_1.heatTransferredInto_isothermal`.
- No sorries remain in the assigned file.

The proof solves the equation of state for the isothermal magnetization,
differentiates the resulting linear function of field intensity, and evaluates
the oriented magnetic-work integral with the fundamental theorem of calculus.
The isothermal first law then gives heat as the negative of that work. The
volume factor cancels using `torus.volume_pos`, and `temperature_pos` justifies
division by temperature.

The endpoint nonnegativity hypotheses are intentionally unused: the work law
uses an oriented interval integral, so the formula is valid for arbitrary
endpoints and in either direction.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`: exit code 0.
  It reports only the expected unused-variable warnings for the two endpoint
  nonnegativity hypotheses.
- `lake build`: completed successfully (4 jobs).
- Lean LSP diagnostics: no errors; the same two unused-variable warnings only.
- `lean_verify` reported only standard foundational axioms
  (`propext`, `Classical.choice`, and `Quot.sound`) and no suspicious source
  patterns.
- A direct scan found no `sorry`, `admit`, `axiom`, or `sorryAx` in the file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_3_B_1:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions, the blueprint was not
edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.

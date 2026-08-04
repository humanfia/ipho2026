# Prover result: IPhO 2026 problem 3 C.5

## Summary

- Sorry count: **1 → 0**.
- Closed
  `IPhO2026Problems.IPhO2026_3_C_5.overallCoefficientOfPerformance`.
- No sorries remain in the assigned file.

The proof substitutes the C.4 elapsed-time relation and the total heat and work
balances. Positivity of the heat capacity, input power, hot-reservoir
temperature, and temperature drop justifies the required cancellations. The
resulting quotient is algebraically rewritten as
`(T_h / (T₀ - T) * log (T₀ / T) - 1)⁻¹`.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_5.lean`: exit code 0.
  Its only output was unused-hypothesis linter warnings from the frozen theorem
  contract; there were no errors or `declaration uses sorry` warnings.
- `lake build`: completed successfully (4 jobs).
- `lean_verify` reported only the standard foundational axioms `propext`,
  `Classical.choice`, and `Quot.sound`, with no suspicious source patterns.
- A direct scan found no `sorry`, `admit`, `axiom`, or `sorryAx` in the file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_3_C_5:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions, the blueprint was not
edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.

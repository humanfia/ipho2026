# Prover result: IPhO 2026 problem 4 B.4

## Summary

- Sorry count: **1 → 0**.
- Closed
  `IPhO2026Problems.IPhO2026_4_B_4.vaporPressure_formula`.
- No sorries remain in the assigned file.

The proof first uses zero reference vapor pressure and the reference
total-pressure balance to identify the reference dry-air pressure with
atmospheric pressure. It substitutes both cylinder volume formulas into the
dry-air ideal-gas invariant, clears the two positive temperature denominators,
and cancels the strictly positive common cross-sectional area. Finally, the
measured total-pressure balance expresses measured vapor pressure as the
difference between atmospheric and dry-air pressures; clearing the positive
measured-height/reference-temperature denominator yields the stated formula.

The previous-part numerical readout is intentionally unused: the requested B.4
identity follows from the thermodynamic model for arbitrary positive column
heights.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_4.lean`: exit code 0
  with no output.
- `lake build`: completed successfully (4 jobs).
- Lean LSP diagnostics: no errors or warnings.
- `lean_verify` reported only standard foundational axioms
  (`propext`, `Classical.choice`, and `Quot.sound`) and no suspicious source
  patterns.
- A direct scan found no `sorry`, `admit`, `axiom`, `native_decide`, or
  `sorryAx` in the file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_4_B_4:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions and project marker
policy, the blueprint was not edited; deterministic marker synchronization
should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.

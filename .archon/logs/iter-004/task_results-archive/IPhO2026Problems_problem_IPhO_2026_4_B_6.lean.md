# Prover result: IPhO 2026 problem 4 B.6

## Summary

- Sorry count: **1 → 0**.
- Closed
  `IPhO2026Problems.IPhO2026_4_B_6.latentHeatPerUnitMass_from_molarEstimate`.
- No sorries remain in the assigned file.

The proof applies the mass, molar-energy, and specific-energy governing laws to
one mole. Positivity of the water molar mass permits cancellation and yields
`L_v = Q_v / M₀`. Rewriting with `Q_v = 39 000 J/mol` and
`M₀ = 18/1000 kg/mol` then proves the stated `2190 ± 110 kJ/kg` interval by
exact rational normalization.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`: exit code 0
  with no output.
- `lake build`: completed successfully (4 jobs).
- Lean LSP diagnostics: no errors or warnings.
- `lean_verify` reported only standard foundational axioms
  (`propext`, `Classical.choice`, and `Quot.sound`) and no suspicious source
  patterns.
- A direct scan found no `sorry`, `admit`, `axiom`, or `sorryAx` in the file.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_4_B_6:target` is ready for its
proof `\leanok` marker. Per the prover write restrictions, the blueprint was not
edited; deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

The sole assigned placeholder was soundly closed and the unchanged theorem
statement compiles.

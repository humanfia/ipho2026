# Prover result: IPhO 2026 problem 3 A.1

## Summary

- Sorry count: **1 → 0**.
- Closed
  `IPhO2026Problems.IPhO2026_3_A_1.fieldStrength_eq_turns_current_area_div_volume`.
- No sorries remain in the assigned file, so there were no adjacent open
  declarations to attempt.

The proof chains the three scalar equalities in
`SatisfiesToroidalAmpereCircuitalLaw` to obtain `H * ℓ = N * I`. It then uses
the Figure 3a geometry equality `V = A * ℓ` and the hypothesis `0 < V`; after
rewriting the volume, `eq_div_iff` and commutative-ring normalization prove
`H = N * I * A / V`.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`: exit code 0.
  The only output was unused-hypothesis linter warnings; there were no errors
  and no `declaration uses sorry` warning.
- A direct scan found no `sorry`, `admit`, `axiom`, or `sorryAx` in the file.
- `lake build IPhO2026Problems.problem_IPhO_2026_3_A_1` is not a declared Lake
  target (`unknown target`); the file-level Lean compilation above is the
  applicable check because the package exposes only the `IPhO2026Run` library,
  whose source root does not contain this file.

## Blueprint status

The theorem environment
`thm:physics:IPhO_2026_3_A_1:target` is ready for its proof `\leanok` marker.
Per the prover write restrictions, the blueprint was not edited; deterministic
marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Why I stopped

Real progress: the sole assigned sorry was closed, reducing the file from one
sorry to zero. The unchanged theorem statement now compiles.

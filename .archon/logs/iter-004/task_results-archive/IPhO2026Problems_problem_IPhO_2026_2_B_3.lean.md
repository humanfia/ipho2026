# IPhO2026Problems/problem_IPhO_2026_2_B_3.lean

## Result

Closed all three assigned placeholders without changing any declaration
signature:

- `IPhO2026Problem2B3.cosine_thetaMax_of_fivefold_power`
- `IPhO2026Problem2B3.container_radius_of_fivefold_power`
- `IPhO2026Problem2B3.ipho2026_problem2_B3`

The proof first cancels the positive baseline power in the B.2 power law to
derive `cos θ_max = 4/5`. It then uses the stated interval
`0 ≤ θ_max ≤ π/2` to select the nonnegative sine branch, derives
`sin θ_max = 3/5` from `sin² θ + cos² θ = 1`, evaluates
`sin (2 θ_max) = 24/25`, and substitutes these values into the B.1 cutoff-ray
geometry. The centimetre conclusion follows from the definition
`lengthInCentimetres x = 100 * lengthInMetres x`.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_3.lean`: success.
- Lean LSP diagnostics: none.
- Source scan: no `sorry`, `admit`, `sorryAx`, `native_decide`, or introduced
  `axiom`.
- Axiom check for the final theorem reports only Mathlib's standard
  `propext`, `Classical.choice`, and `Quot.sound`.
- The configured Lake library has no individual target named
  `IPhO2026Problems.problem_IPhO_2026_2_B_3`; direct compilation in the Lake
  environment was therefore used for module verification.

## Blueprint readiness

The proof environments for the two auxiliary theorems and the final target are
ready for `\leanok`. Per `.archon/AGENTS.md`, the prover did not edit the
blueprint; deterministic `sync_leanok` owns these markers.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Remaining blockers

None.

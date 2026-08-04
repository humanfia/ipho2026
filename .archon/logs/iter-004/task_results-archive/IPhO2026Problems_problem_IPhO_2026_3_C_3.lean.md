# IPhO2026Problems/problem_IPhO_2026_3_C_3.lean

## Result

Closed the assigned placeholder without changing the declaration signature:

- `IPhO2026Problems.Problem3C3.IPhO_2026_3_C_3_helium_temperature_after_one_cycle`

The proof specializes the stated cold isothermal heat law to the supplied SI
readouts and obtains
`Q_c = (40207118149 / 976562500000) * π`. Mathlib's certified
`Real.pi_gt_d4` and `Real.pi_lt_d4` bounds prove the requested
`0.129 ± 0.0005 J` envelope. The helium calorimetry law reduces exactly to
`Q_c = 13 * (1 - T_final)`, and linear arithmetic then proves both requested
temperature envelopes.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`: success,
  with only unused-hypothesis linter warnings.
- `lake build`: success.
- Lean LSP diagnostics: no errors; only the same unused-hypothesis warnings.
- Source scan: no `sorry`, `admit`, `sorryAx`, `native_decide`, or introduced
  `axiom`.
- Axiom check reports only Mathlib's standard `propext`,
  `Classical.choice`, and `Quot.sound`.
- The configured Lake library has no individual target named
  `IPhO2026Problems.problem_IPhO_2026_3_C_3`; direct compilation in the Lake
  environment and the successful full project build verify the module.

## Blueprint readiness

The proof environment for the final target is ready for `\leanok`. Per
`.archon/AGENTS.md`, the prover did not edit the blueprint; deterministic
`sync_leanok` owns this marker.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Remaining blockers

None.

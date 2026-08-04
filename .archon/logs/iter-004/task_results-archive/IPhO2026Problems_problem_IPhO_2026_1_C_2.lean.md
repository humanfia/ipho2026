# Prover result: IPhO 2026 problem 1 C.2

## Status

Complete. Replaced the sole `sorry` in
`IPhO2026Problems/problem_IPhO_2026_1_C_2.lean` with a proof of
`IPhO2026_1_C_2.threshold_excess_energy_rounds_to_official_value`.

## Proof summary

- Evaluated the angle branch at `π / 6`, obtaining the exact shape factor `3 / 2`.
- Reduced the atomic-mass-unit, electronvolt, and speed-of-light readouts to
  exact rationals, obtaining the atom rest energy
  `62184086900064638790833951 / 4172334984375000` eV.
- Rewrote the previous-part balance as the exact quadratic
  `x = 11/10 + x² * (1043083746093750 / 62184086900064638790833951)`.
- Used nonnegativity and `lower_root_selection` to exclude the large root, then
  bounded the small-root excess between `2.025e-11` and `2.035e-11` eV.
- Used `threshold_photon_energy` to identify that excess with
  `requestedExcessEnergyInElectronVolts`.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_2.lean` succeeds.
- Lean LSP diagnostics: none.
- Source scan: no `sorry`, `admit`, `sorryAx`, or introduced `axiom`.
- Axiom check reports only standard Lean/Mathlib axioms:
  `propext`, `Classical.choice`, and `Quot.sound`.

## Blueprint readiness

The theorem proof is closed and ready for the deterministic `\leanok` sync.
No redraft is needed.

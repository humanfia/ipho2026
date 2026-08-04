# Blueprint Writer Report: 4-a-5-entries
**Status:** COMPLETE

## Changes (all in blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex, ledger appended after `% source end`; skeleton + both NOTEs verbatim; `thm:physics:IPhO_2026_4_A_5:target` already `\uses{...:main}` — verified)
- Sub1 `Recorded constants and the temperature projection`: defs `ambientAirDensity`, `pgHeight`, `referenceAbsTemperature`, `absTemp`; lems `absTemp_eq_toReal`, `absTemp_nonneg`; def `idealThermalPressureCoefficient`; lem `idealThermalPressureCoefficient_value` (pins: same names under `IPhO2026_4_A_5.`).
- Sub2 `Governing laws: ideal gas and isochore`: defs `IsochoricProcess`, `IsIdealGasLaw` (decalibrated free-R note); lems `IsIdealGasLaw.pressure_pos_of_temp_pos`, `IsIdealGasLaw.pressure_ratio_eq_temp_ratio` (on-disk name confirmed); def `IsIsochoricLinear` (A.3 assumption-side); lem `IsIsochoricLinear.slope_eq_div`; def `IsReferenceState` (folds `referenceTemperature`, `referencePressure`; hP₀ cert); def `IsIsochoricLinear.thermalPressureCoefficient` (Eq. (2) definition only).
- Sub3 `The two-readout dataset (A.2 protocol)`: def `IsochoricReadout` with `hT12 : T₁ ≠ T₂` guard described.
- Sub4 `Official answer (conclusion side only)`: thms `beta0_close_to_ideal` (1/T₀, 0.0037), `beta0_eq_ideal_of_linear` (divide by P₀ΔT≠0), `beta0_uncertainty_bound` (deviation = P₀|ΔT||β₀−1/T₀|, cancel via hP₀+hT12; uses readout+ref+isochore+beta0_eq_ideal_of_linear), `main` (uses all three + IsochoricReadout + idealThermalPressureCoefficient; band 0.0034 ± 0.0007 band-side).

## Verification
- All 23 names pinned (5 projection folds incl.); pins == named Lean decls (grep-verified first-hand); labels unique; every `\uses{}` resolves in-chapter; begin/end balanced.

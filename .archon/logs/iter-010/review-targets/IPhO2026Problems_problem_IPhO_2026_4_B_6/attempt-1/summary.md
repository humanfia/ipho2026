# Review: problem_IPhO_2026_4_B_6 (iter-010) — BLOCKED (needs_redraft)

- Verdict: `blocked` / route `needs_redraft`, redraft_kind `underdetermined_contract`.
- Compile: preflight OK (rc=0), exactly 1 sorry, at `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean:296` in `latent_heat_per_unit_mass_target`.
- Root cause: final conjunct `Lv_reported.withinUncertainty officialSpecificLatentHeatValue` universally quantifies `Lv_reported` with no link to `Qv/M0`; countermodel `central = 10000` falsifies `|c-2190| ≤ 110`. Unprovable as stated; not a tactic issue.
- Faithful elsewhere: `Lv = Qv/M0` lives only in the conclusion via `IsSpecificLatentHeatOf`; catalog values (39 kJ/mol, 18.0e-3 kg/mol, 2190±110 kJ/kg), units, and PhysLean typed `Temperature`/`DimPressure`/`DimLength` match the blueprint.
- Other 4 declarations honestly proved (`formula`, `computed_value_within_official_uncertainty`, `qv_from_clausius_clapeyron_slope`, `reference_temperature_calibration`); no axioms/admits/laundering.
- Blueprint proof sketch itself assumes band membership from `39/(18.0e-3)` — confirms intended-but-unstated link.
- Trace: iter-010 prover reported identical diagnosis and recorded a redraft request; the referenced `.archon/task_results/problem_IPhO_2026_4_B_6.md` is absent from disk (process warning only; primary evidence is the Lean source + trace).
- Repair: add hypothesis `Lv_reported.central_kJ_per_kg = catalogQvValue / catalogMolarMassWaterValue` (or existentially bind `Lv_reported`); then `rw [h]; exact computed_value_within_official_uncertainty` closes the goal.

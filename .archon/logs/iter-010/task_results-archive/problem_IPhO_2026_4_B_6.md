# Task result — prover iter-010 — `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`

## Status: PARTIAL — 4/5 targets fully proved; 1 sorry remains (statement defect, redraft request below)

Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_6.lean` (9 s):
**0 errors**; exactly one `declaration uses sorry` warning (line 296,
`latent_heat_per_unit_mass_target`). Sorry count 5 → 1.

Axiom audit (`#print axioms` on a `/tmp` scratch copy with renamed theorems,
deleted after; never in the repo): the four closed targets depend only on
`[propext, Classical.choice, Quot.sound]` — no `sorryAx`, no new axioms, no
`native_decide`. `latent_heat_per_unit_mass_target` carries `sorryAx`
exactly once (the one honest remaining `sorry`).

## Proofs landed

| Declaration | Proof |
|---|---|
| `latent_heat_per_unit_mass_formula` | `refine ⟨39/18.0e-3, 39, 18.0e-3, rfl, rfl, rfl, ?_⟩`; then `show |(39/18.0e-3:ℝ) − 2190| ≤ 110`, `rw [abs_le]; constructor <;> norm_num` (`39/18.0e-3 = 2166.6̄`, `23.3̄ ≤ 110`). |
| `computed_value_within_official_uncertainty` | `show |(39/18.0e-3:ℝ) − 2190| ≤ 110; rw [abs_le]; constructor <;> norm_num`. |
| `qv_from_clausius_clapeyron_slope` | witness `-input.slope_K * input.R_J_per_mol_K / 1000` with `rfl`; band by `rw [input.slope_K_eq, input.R_J_per_mol_K_eq, input.Qv_kJ_per_mol_eq, input.Qv_uncertainty_kJ_per_mol_eq, abs_le]; constructor <;> norm_num` (`4700·8.31/1000 = 39.057`, `|39.057−39| = 0.057 ≤ 2`). |
| `reference_temperature_calibration` | `exact input.T₀_value_K_eq`. |
| `latent_heat_per_unit_mass_target` | **PARTIAL.** The conversion witness and both catalog-matching conjuncts are filled: `⟨⟨catalogQvValue, catalogMolarMassWaterValue, catalogQvValue/catalogMolarMassWaterValue, rfl, by rw [catalogMolarMassWaterValue]; norm_num⟩, rfl, rfl, ?_⟩`. Remaining `sorry`: the fourth conjunct `Lv_reported.withinUncertainty officialSpecificLatentHeatValue` — unprovable as stated (see below). |

Statements, signatures, hypotheses, and all structure fields are unchanged;
only proof bodies after `:= by` were edited (plus one `--` comment block
documenting the remaining obligation inside the target's proof).

## Redraft needed

- Original problem id / report path: `IPhO_2026_4`, part B.6;
  `reports/ipho_2026_k3/problem_IPhO_2026_4_B_6.source.json`.
- Theorem: `IPhO2026.Problem4.latent_heat_per_unit_mass_target`.
- Why it is not provable as stated: the variable
  `Lv_reported : SpecificLatentHeatValue` (the "measured/reported value") is
  introduced in the scope of the theorem but never mentions it in a
  hypothesis — it is **unconstrained and universally quantified**. The
  concluding conjunct
  `Lv_reported.withinUncertainty officialSpecificLatentHeatValue`, i.e.
  `|Lv_reported.central_kJ_per_kg − 2190| ≤ 110`, therefore has to hold for
  *every* record; taking `Lv_reported.central_kJ_per_kg = 10000` (uncertainty
  field arbitrary) yields a countermodel
  (`|10000 − 2190| = 7810 > 110`). This is exactly the pattern archived in
  Archon memory as "Readout structs need neq-guards else degenerate
  countermodels (4_A_5)". The first three conjuncts (the physics: conversion
  witness + catalog matching at 39 kJ/mol / 18.0e-3 kg/mol) are fully
  proved and sound.
- Smallest faithful fix (two options, signature-level; the statement
  currently has no hypothesis naming `Lv_reported`, so one must be added):
  1. Add one hypothesis to the theorem:
     `(hLv : Lv_reported.central_kJ_per_kg = catalogQvValue / catalogMolarMassWaterValue)`
     — the informal meaning "the reported value IS the computed
     `Lᵥ = Qᵥ/M₀`". With it the goal reduces to
     `|39/18.0e-3 − 2190| = 23.3̄ ≤ 110`, closing by `rw [hLv, abs_le]; constructor <;> norm_num`
     (verified shape in the probe; `uncertainty_kJ_per_kg` need not be constrained).
  2. Or make `Lv_reported` an explicit computed binder:
     `∃ Lv_reported : SpecificLatentHeatValue, Lv_reported.central_kJ_per_kg
      = catalogQvValue / catalogMolarMassWaterValue ∧ ...`, instantiable by
     `⟨catalogQvValue / catalogMolarMassWaterValue, catalogQvUncertainty⟩`
     with the same one-line numeric close.
  Option 1 is the minimal diff (one binder); option 2 better matches the
  intended "the measured value lies within the official band" reading.
  After redraft, closing takes <1 line of new tactic code beyond what is
  already in this lane's file.

## Blueprint markers

The four now-proved declarations are `sorry`-free and compile clean; they are
ready for `\leanok` on their environments (applied by `sync_leanok` / review
agent — I did not touch the chapter):
- `thm:IPhO2026Problems_problem_IPhO_2026_4_B_6:latent_heat_per_unit_mass_formula` ready
- `thm:IPhO2026Problems_problem_IPhO_2026_4_B_6:computed_value_within_official_uncertainty` ready
- `lem:IPhO2026Problems_problem_IPhO_2026_4_B_6:qv_from_clausius_clapeyron_slope` ready
- `lem:IPhO2026Problems_problem_IPhO_2026_4_B_6:reference_temperature_calibration` ready
- `thm:IPhO2026Problems_problem_IPhO_2026_4_B_6:latent_heat_per_unit_mass_target` **NOT** ready (residual `sorry` pending the redraft above).

Note for the review agent: the chapter proofs for `formula` /
`computed_value_within_official_uncertainty` assert `|2166.6̄ − 2190| = 23.3̄ ≤ 110`,
which is arithmetically correct as a band bound; the informal "≈ 2190"
wording in the informal target proof is loose (the actual computed value is
2166.7), but the Lean statements are exactly the checked ones and now proved.

## Tooling notes

- Second-opinion tool unavailable: `archon-informal-agent.py` returns 401
  (`MOONSHOT_API_KEY` is a standard `sk-` key but the kimi endpoint rejects
  it through this proxy; `MOONSHOT_OPENAI_BASE_URL=127.0.0.1:8767` is the
  model's own transport). Proceeded from first principles; the physics
  numbers here are simple arithmetic, no deep reconstruction was needed.
- No new imports, no axioms, no metaprogramming; proof scripts use only
  `refine/rfl/exact/show/rw [abs_le]/constructor/norm_num`.

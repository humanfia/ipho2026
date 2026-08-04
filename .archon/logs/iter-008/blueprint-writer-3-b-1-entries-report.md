# Blueprint Writer Report: 3-b-1-entries
**Status:** COMPLETE

## Changes
- Appended `% --- Archon named-quantities coverage (blueprint-writer 3-b-1-entries) ---` ledger to `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_1.tex` (all prior content verbatim).
- 14 blocks in dependency order, 17 `\lean{}` pins — verified 17/17 exact on-disk (namespace `IPhO2026.Problem3.B1`):
  - quantities/data: `TorusParams`, `TorusState`, `heatCapacityConstM`
  - governing laws: `SatisfiesEOS`, `HasHeatCapacityLaw`, `IsMagneticWorkDensity`, `ObeysFirstLawMagnetic` (+ `IsothermalFieldChange` family-grouped w/ `field_increases`, `h_branch` field pins)
  - bridges: `magnetization_eq_eos_solution`, `leg_mem_tracked_range`, `leg_work_integral_eval`
  - value/readouts: `heatTransferredIntoTorus`, `heat_into_torus_value`, `isothermal_heat_into_torus`, `official_answer_value`
- Umbrella wired: `\uses{thm:...:OfficialAnswerValue}` added inside `thm:physics:IPhO_2026_3_B_1:target`.
- Official value `Q = -(μ₀ n K/(2T))(H_f² − H_i²)` confined to conclusion-side `thm:...:OfficialAnswerValue` (+ pre-existing source paragraphs / target narrative naming the recorded answer).
- Noncomputable defs verified on disk, all pinned: `heatCapacityConstM`, `heat_into_torus_value`, `heatTransferredIntoTorus`.

## Verification
- pins 17/17 grep-matched (decl + structure-field patterns); `\uses{}` resolves 0 unknown in-chapter; begin/end balanced (definition 9, lemma 3, theorem 3, proof 15).
- No `\leanok`/`\mathlibok` markers present or added; only the one chapter file touched.

## Deviations
- `IsothermalFieldChange` folded into the `ObeysFirstLawMagnetic` governing-law block (family-grouping, per sibling convention) incl. Bool fields `field_increases`/`h_branch`.
- Import-policy NOTE mirrored in ledger header (Mathlib baseline, PhysLean exemption).

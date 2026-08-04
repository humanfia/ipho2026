# Blueprint Writer Report: 3-c-4-entries
**Status:** COMPLETE

Chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex` (only file touched).
Lean file `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean` read in full first-hand; statements transcribed as-is.

## Changes
- Skeleton kept verbatim: source paragraphs, `thm:physics:IPhO_2026_3_C_4:target`, iter-002 PhysLean-exemption NOTE. Appended one import-policy NOTE (mirrors `import Mathlib` baseline per directive) and the `% --- Archon named-quantities coverage (blueprint-writer 3-c-4-entries) ---` ledger.
- Umbrella wired: `thm:physics:IPhO_2026_3_C_4:target` gains `\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_C_4:c4_elapsed_time}` (only that edge invented).
- 22 new blocks, dependency order, 4 `\subsection*{}` groups (quantities; governing-law structures; EOS/isothermal-heat consequences; density bridges; value theorems last). Governing-law/figure carriers marked as such (`ParamagnetEOS`, `IsothermalHeatIntoTorus`, `CarnotHeatRatio`, `CycleWorkHeatBalance`, `ConstantPowerDensityLaw`, `BodyCalorimeterDensityLaw`, `InfinitesimalCycleLaw`, `IsCoolingRun`, `Figure3bCorners`, `CycleCorners`, `TorusParams`, `RegimeAssumptions`).
- Family-grouped six opaque scalars into `def:...:globalQuantities` (6 `\lean{}` pins); ctor/projection content folded into parent entries. Proofs: "Definition; no claim." for packaging; 1–3-line algebra/intentionality sketches for bridges/value theorems; no tactic names.

## Pins
- 28/28: `IPhO2026.Problem3.C4.{tempHot, tempInitial, tempFinal, heatCapacityBody, inputPower, elapsedTime, TorusParams, WorkingState, CycleCorners, CoolingRun, RegimeAssumptions, ParamagnetEOS, IsothermalHeatIntoTorus, CarnotHeatRatio, CycleWorkHeatBalance, ConstantPowerDensityLaw, BodyCalorimeterDensityLaw, InfinitesimalCycleLaw, IsCoolingRun, Figure3bCorners, magnetization_of_eos, heat_leaves_torus_on_field_increase, heatDumpedDensity_eq, workDensity_eq, residenceDensity_eq, elapsedTime_eq_integral, cooling_time_integral_eval, c4_elapsed_time}` — each grep-verified against on-disk decl names (`namespace IPhO2026.Problem3.C4` + 28 decls; 0 uncovered decls on disk).

## Verification (scripted)
- `\uses{}`: 21 distinct targets, 0 unknown in-chapter; labels unique (25 total); env nesting balanced (15 def / 5 lem / 4 thm incl. umbrella / 24 proof); one display-math pair.
- Official value `t = (C_c T_h/P)(ln(T_0/T) - (T_0 - T)/T_h)` confined to `thm:...:c4_elapsed_time` (+ verbatim recorded-answer skeleton paragraph); assumption-side blocks carry no answer content.
- `leandag` not on PATH in this worker; edges verified by extraction script instead (sibling writer 1-a-1 reported the same fallback).
- `\leanok`/`\mathlibok`: none added/removed; no other file modified.

## Deviations
- Added one `% NOTE:` import-policy mirror line (directive: "mirror the chapter's existing import-policy NOTE"). No other skeleton edits.

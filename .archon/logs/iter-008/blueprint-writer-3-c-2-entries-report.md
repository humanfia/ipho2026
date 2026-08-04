# Blueprint Writer Report: 3-c-2-entries
**Status:** COMPLETE

## Changes
- Appended `% --- Archon named-quantities coverage (blueprint-writer 3-c-2-entries) ---` ledger to `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_2.tex` (only file touched; prior skeleton + exemption NOTE verbatim).
- 17 blocks: `def` TorusParams, Vertex, ProcessKind, ParamagnetState, CarnotCycle, Figure3bAssignment; `def` EquationOfStateParamagnet, IsothermalHeatIntoTorus, CarnotHeatRatio, CarnotMagnetizationModel; `def` q (parent for M1/M2/M3/M4/q, one `\lean{}` line each); `lem` vertex_T_pos, heat_isothermal_via_q, Qh_eq, Qc_eq, q_relation, q4_eq_adiabatic_41, q3_eq; `thm` m1_sq, m1_eq_sqrt, m1_sq_arg_nonneg.
- Umbrella `thm:physics:IPhO_2026_3_C_2:target` now `\uses` the model parent + `m1_eq_sqrt`.

## Verification
- Pins: 25/25 `\lean{}` grep-match exact disk names in `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`.
- Uses: 0 unknown in-chapter; leandag build: 0 unknown_uses, 0 unmatched_lean, 0 isolated for chapter (21 nodes).
- begin/end balanced 45/45; markers untouched; no other file modified.
- Official value confined to `thm:...:m1_sq` / `thm:...:m1_eq_sqrt` (+ recorded-answer paragraph, verbatim); assumption/figure/governing blocks value-free.

## Deviations
- Added second import-policy NOTE in ledger header (mirrors sibling 3_c_4 convention).
- Lean file untracked in git but untouched by me (0-error, 10-sorry contract intact).

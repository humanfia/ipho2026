# Review: problem_IPhO_2026_1_A_1.lean (T1-A1) — blocked, needs_redraft

- File compiles (preflight rc=0) with 10 honest `by sorry` bodies; no axioms,
  admits, native_decide, or statement weakening. Signatures and physical
  contracts are faithful: answer appears conclusion-side only, parameters are
  opaque, tolerance `|a - 0.50| < 1/200` and `DeltaH = 1.41` are honest.
- Root cause (contract defect, not tactics): the formalized hydrostatic couple
  `(a√2/2)·(a/2)·(a√2/4)` equals `ρ₀·g·Δh·a³/8`, but the official Figure-1a
  readout and lemma `pressure_couple_eq` require `ρ₀·g·Δh·a³/4` (factor 2).
- Consequence: `hbal : restoringMoment = pressureCoupleMagnitude` is satisfiable
  (at `a = Δh/(4√2)` with positive params) while the conclusion
  `a = Δh/(2√2)` fails, so `pressure_couple_eq`, `critical_balance_eq`, and the
  main theorem `hydrostatic_gate_side_length_a_target` are refutable as stated.
- Steps 1–3, 6–7, `numerical_value`, and `torque_balance_contract` are provable
  once the couple readout is repaired (7 of 10 sorries).
- Prover trace (session 019fa6d4, iter-010) independently confirms this exact
  countermodel. No matching task_results artifact exists (empty list) — process
  warning only; trace used as primary evidence.
- Repair: redraft `PressureMomentReadout.pressure_couple`,
  `IsCriticalTorqueBalance`, and `pressureCoupleMagnitude` so the couple
  simplifies to `ρ₀·g·Δh·a³/4` (e.g. couple arm `a√2/2`, counting both faces),
  then discharge the 10 sorries along the documented blueprint chain.

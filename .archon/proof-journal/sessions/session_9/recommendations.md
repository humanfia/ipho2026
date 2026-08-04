# Recommendations

- Advance only `IPhO2026Problems/problem_IPhO_2026_3_C_1.lean` to prover. Do
  not change its declarations, theorem signatures, physical hypotheses,
  conclusions, or typed/SI carriers.
- Prove `identify_isothermal_reservoir_contacts` first: obtain the two finite
  contact witnesses, case-split them, and use endpoint equilibrium with
  `T₂ < T₁` and `T_c < T_h` to eliminate same-reservoir and swapped cases.
- Prove `identify_temperature_labels_and_heat_processes` by reusing that
  contact lemma, specializing endpoint equilibrium and reservoir-indexed heat
  routing, then chaining each adiabatic figure equality through no contact to
  `HeatTransfer.none`.
- After both bodies close, run one target-level direct Lean check, require
  zero `sorry` warnings, perform the usual proof/axiom review, and let
  deterministic marker synchronization decide `\leanok`.
- The dotted Lake target remains unregistered even though the orchestrator's
  direct file check passes. Register `IPhO2026Problems` as a library root only
  if later automation requires that exact dotted command; this is not a
  semantic blocker for the reviewed statement.
- Do not couple this prover route to the doctor's out-of-scope
  `problem_IPhO_2026_4_B_6.lean` `missing-physlib-import` finding. Keep that
  finding reported as user-skipped until the standing pause is lifted.
- No blueprint structural repair is needed for this candidate: the current
  doctor reports no orphan or broken-reference finding, and the fully
  qualified theorem links are already present.

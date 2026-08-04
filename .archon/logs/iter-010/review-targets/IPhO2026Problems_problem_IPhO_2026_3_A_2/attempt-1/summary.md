# Review: IPhO2026Problems/problem_IPhO_2026_3_A_2.lean (attempt 1)

- Status: **solved**; route `solved`; redraft not applicable.
- Target theorem `IPhO2026_3_A_2.work_emf_eq_V_mul_H_mul_dB` compiles with 0 sorries (deterministic preflight, rc 0, 14.59s); grep confirms no sorry/admit/axiom/native_decide.
- Signature, hypotheses, and conclusion unchanged; conclusion is the recorded official answer dW_emf = V*H*dB as a defined `WorkOnSource` readout, not an assumption.
- Derivation is honest: bridge lemma `fieldStrength_eq_N_mul_I_mul_A_div_V` (from ring-volume law V = 2*pi*R*A + Ampere H = N*I/(2*pi*R)) plus Faraday's law emf*dt = N*A*dB close the goal via `linear_combination key*e.dB + e.faraday*op.I`, matching the blueprint's informal proof.
- Physical semantics faithful: sign convention documented, local Faraday/WorkOnSource laws reconciled with the one-import PhysLean policy; constitutive law correctly unused for A.2.
- Blueprint `\leanok` markers present on both proved environments.
- Iter-010 prover trace supports the claim: fresh `lake env lean` 0 errors, `lake build` success, axioms limited to [propext, Classical.choice, Quot.sound].
- Process warning only: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_A_2.md` cited by the prover is absent on disk; per policy the prover trace was used as primary evidence.
- No blockers; no next steps required.

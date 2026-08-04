# Proof Review — IPhO2026Problems/problem_IPhO_2026_3_C_2.lean (iter-013, attempt-1)

- Reviewed target: `IPhO2026.Problem3.C2.CarnotMagnetizationModel.m1_eq_sqrt` — route=solved, status=solved.
- Compile: rc=0, exactly 1 sorry (line 423) confined to the auxiliary bridge lemma `q_relation`; no axiom/admit/native_decide.
- Target chain `q4_eq_adiabatic_41`/`q3_eq` -> `m1_sq` (rw leg41/leg23 + ring) -> `m1_eq_sqrt` (Real.sqrt_sq, 0<=M1) contains no sorry and never cites `q_relation`; `m1_sq_arg_nonneg` clean.
- Signature preserved exactly: `m.M1 = Real.sqrt (m.M2^2 - m.M3^2 + m.M4^2)`, the official C.2 answer; answer appears only conclusion-side.
- Semantics faithful: iter-10 defects fixed (q-form prefactor -mu0 V^2/(2nK); Figure-3b leg temperatures Th/Tc); EOS, adiabatic log law, unsigned Carnot ratio honestly modeled; no units/tolerance in play.
- Prover trace (session 019fa8a9, end 12:43:46Z) and iter-013 archived task result agree with the on-disk file; empty supplied task-result list noted as process warning only.
- Ledger note: the sorried `q_relation` is genuinely underdetermined (model fields yield only M1^2=M4^2, M3^2=M2^2; q_relation reduces to the independent amplitude Th*M4^2=Tc*M2^2) and merits a separate needs_redraft/underdetermined_contract ruling when it is itself the reviewed target — it does not taint m1_eq_sqrt.
- Next steps: none for this target.

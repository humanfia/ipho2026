# Review — IPhO2026Problems/problem_IPhO_2026_3_C_2.lean (iter-010, attempt-1)

Verdict: **blocked / needs_redraft** (redraft_kind: wrong_or_weakened_target).
Main target `CarnotMagnetizationModel.m1_eq_sqrt` states the official C.2 answer `M1 = sqrt(M2^2 - M3^2 + M4^2)` with correct magnitude/nonnegativity framing; signatures preserved, answer kept conclusion-side, units/roles faithful, Governing laws (EOS, signed B.1 heat law, Carnot ratio) honest. Preflight: rc=0, 9 sorry warnings (244,293,334,372,395,413,432,457,471), no axioms/native_decide. But checks 1 (zero sorry) and 3 (faithful semantics) fail:

- Defect A: `heat_12`/`heat_34` attach the B.1 isothermal law to swapped temperatures/heats (1->2 at Tc with +Qc; 3->4 at Th with -Qh), contradicting the model's own `figure3b` (T v1=Th, T v3=Tc) under `Tc < Th` — `Qh_eq`/`Qc_eq` unprovable outside the excluded Th=Tc regime; also disagrees with Figure 3b (verified against T3_page-3.png).
- Defect B: `IsothermalHeatQForm`/`heat_isothermal_via_q` prefactor false — EOS substitution gives `Q = -(mu0 V^2/(2nK))(qf-qi)` (proved in-place as `htrue` via `field_simp`), not `+(mu0 V/2)`; the stated lemma is false in the positive parameter regime.
- Missing field: no adiabatic (T3-B2, T proportional to 1/H) law, so `q3_eq` underivable.

Prover trace (session_end) and newest task result `.archon/task_results/problem_IPhO_2026_3_C_2.lean.md` agree and match this iteration; no \leanok marked. Repair: swap the two heat fields' temperatures/heats, fix prefactor to `-(mu0 V^2/(2nK))`, restate `q_relation` as `Tc*q1 = (Th-Tc)*q2 + Tc*q3 - Th*q4`, add the adiabatic-law model field; then the chain closes by field_simp/linear_combination and Real.sqrt_sq; also fix the blueprint's C.1 reusable-conclusions bullets.

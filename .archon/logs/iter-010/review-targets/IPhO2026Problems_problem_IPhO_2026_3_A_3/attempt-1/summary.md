Target: IPhO2026Problems/problem_IPhO_2026_3_A_3.lean — IPhO2026.T3A3.dW_eq_mu0_V_H_dM
Status: solved
Route: solved

Five-check audit passed:
1. Compiles cleanly with zero active sorry/admit; no axiom laundering reported.
2. Signature and hypotheses preserved; statement not weakened or trivialized.
3. Physical semantics faithful to blueprint thin-torus setup, Ampere law, constitutive relation, work split, and vacuum subtraction.
4. Honest use of hypotheses, units, recorded answer choice; no numerical tolerance issues.
5. Prover trace supports the claimed proof; matching task-result list is empty, so trace is primary evidence (process warning only, not semantic failure).

Key proof steps: rw [dW_eq_VH_dB_sub_mu0_dH, v.dBH]; ring closes the goal.

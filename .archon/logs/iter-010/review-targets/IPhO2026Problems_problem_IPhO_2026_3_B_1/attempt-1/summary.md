# Review: problem_IPhO_2026_3_B_1 — blocked / needs_redraft

- Target `isothermal_heat_into_torus` (+ bridge lemmas `leg_mem_tracked_range`, `leg_work_integral_eval`) all carry active `sorry` (preflight: compiles, 3 warnings); only `official_answer_value` is proved (`rfl`).
- Root cause is semantic, not tactical: countermodel `linProc` (M(H)=-2H, honest first-law heat) satisfies every hypothesis but gives Q=-12 vs closed form -3 — the work density is parametrized as `workDensity(M) = mu0*V*M_of_H(M)`, substituting M_of_H for the true H_of_M and losing the dM/dH Jacobian.
- `leg_mem_tracked_range` separately conflates field range `Icc(min 0 (min H_i H_f))..` with magnetization locus `uIcc 0 (M_of_H H)` (point -1.5 counterexample).
- `leg_work_integral_eval` is underdetermined: `M_of_H` unconstrained off the tracked field range (`weirdProc`: integral = 0 vs required -16).
- All three falseness claims backed by compiling negation witnesses: `.archon/task_results/witness_{target,leg_integral_eval,leg_mem}_IS_FALSE.lean`.
- No answer-as-assumption: `heat_into_torus_value` only names the carrier; hypotheses are honest. Signatures match the frozen iter-009 contract, but that contract is not derivable.
- The blueprint chapter's leg-lemma proof sketches repeat the same false step and also need redrafting.
- Repair: add global-EOS hypothesis or reparametrize work integrals by H with explicit dM/dH; witnesses serve as regression tests for the corrected signatures.
- Prover trace (session 019fa6d4, 133 turns) is the primary evidence; the flattened task-artifact list is empty — process warning only, evidence is trace+persisted witnesses.

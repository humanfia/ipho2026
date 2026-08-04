# Review: IPhO2026Problems/problem_IPhO_2026_1_C_1.lean (iter 13, cycle-1/attempt-1)

Verdict: **partial / retry_proof** — faithful, derivable contract; tactic-level breakage + 2 sorries remain.

- Compile: FAIL (rc=1). `330:4` spurious `ring` after `field_simp` closed the goal (`No goals to be solved`); `337:17` rw-chain partially rewrites the middle conjunct so the show-pattern `?m / S^2` is not found (stuck goal `S*(X^2/S^2) - 6*m*c^2*(X/S) + 6*dU*m*c^2 = 0`).
- Sorries: `minimum_angular_frequency_T1_C1` (line 378) and `minimum_angular_frequency_backward_branch_T1_C1` (line 392) — the two primary contracts.
- Statements: PASS. The iter-10 redraft defect is fixed: `quadratic_characterization_of_threshold` now carries `(hb : 0 < hbar)`; `hbarOmegaMin` appears only conclusion-side; hypotheses carry regime/branch/discriminant exactly per blueprint `thm:physics:IPhO_2026_1_C_1:target`. No axioms/admit/weakening.
- Trace (019fa8a9, 89 turns, ended mid-assembly): derived the exact witness-elimination square identity `Q = -(3*ps - 2*E*sqrt(ps)*c_chi)^2/2 <= 0` and verified aux lemma A2 (E0 <= E from Q(E) <= 0) compiles in scratch (EXIT=0); on-disk file is pre-assembly.
- Task-result artifact: none supplied (empty list) — process warning only; trace is primary and agrees with the file.
- Repair: drop stray `ring`; redo denominator clearing via `field_simp [hSne]`/`eq_div_iff`; assemble main theorem from the verified square identity + A2 + `momentum_q_sq_of_vector_balance`; backward branch via `hbarOmegaMin_pi_sub`.

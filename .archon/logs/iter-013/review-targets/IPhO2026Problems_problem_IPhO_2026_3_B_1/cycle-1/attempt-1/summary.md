# Review: IPhO2026Problems/problem_IPhO_2026_3_B_1.lean (iter 13, attempt 1)

**Route: solved** — all five review checks pass.

- **Compile/hygiene:** preflight rc=0, `sorry_count`=0, no diagnostics; `sorry` survives only in a stale header docstring; no admit/axiom/native_decide. Prover's `#print axioms` reports only `[propext, Classical.choice, Quot.sound]`.
- **Contract:** `isothermal_heat_into_torus` concludes `Q = heat_into_torus_value p proc` from the iter-011 field-parametrized redraft (work density `mu0*V*H*dM/dH`, EOS enforced on every field, per-leg first-law balances); `official_answer_value` confirms the recorded answer by `rfl`. The iter-010 countermodel is excluded by the `deriv`-based work law.
- **Proof:** EOS pins `M(H) = nKH/(TV)`; work density is linear; `leg_work_integral_eval` gives each leg `= mu0 n K H^2/(2T)` via `integral_const_mul` + `integral_id` + `field_simp` (`hV`,`hT`); `q_in_eq_neg_integral` applies the first-law leg `(0,H)` with calibration `Q_in 0 = 0`; target closes by endpoint rewrites + `ring`. No hypothesis presupposes the closed form.
- **Evidence:** iter-013 prover trace (70 turns) proves all 7 sorries with signature discipline (edits strictly after `:= by`); blueprint `\leanok` markers present for all 9 proved environments and match Lean names.
- **Process warning (non-blocking):** no matching iter-013 `task_results` artifact; trace used as primary evidence per review instructions.

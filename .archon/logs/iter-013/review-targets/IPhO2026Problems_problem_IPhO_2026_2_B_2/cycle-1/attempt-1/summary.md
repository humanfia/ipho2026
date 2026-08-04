# Proof Review — IPhO2026Problems/problem_IPhO_2026_2_B_2.lean (iter 13, attempt 1)

- Route: `retry_proof`, status: `partial`. Contract is faithful and derivable; failures are tactic-level.
- Preflight: compiles=false, sorry_count=5, 4 errors, all inside helper lemma `abs_hitOffset_eq`.
- Error 1 (line 279): `nlinarith` cannot close Parseval `(v·e)^2+(v·n)^2 = ‖v‖^2` — hint list misses the cross-term expansion using `hpen`.
- Error 2 (line 295): `rw [sq_le_sq_iff_abs_le_abs, sq_abs, abs_of_pos p.hR] at *` rewrites destructively; `|ue| ≤ p.R` should come from `sq_le_sq.mp` + `hpv` + `sq_nonneg wn`.
- Error 3 (line 299): `field_simp` leaves `p.R^2 - p.R^2*|ue|^2*p.R⁻¹^2 = p.R^2 - |ue|^2`; needs `p.hR.ne'` / `ring_nf`.
- Error 4 (line 309): rewrite ordering — `|wn|^2` pattern consumed before `hsq` applies.
- Sorries: `collectedWidth_eq_two_mul_yOff`, `yOff_eq_R_sin_thetaMax`, `two_r_sin_over_diameter_eq`, `power_ratio_eq_width_ratio`, and target `power_ratio_in_terms_of_theta_max`.
- Contract check: two-sided band model (iter-011 redraft) resolves the iter-010 `underdetermined_contract` countermodel; algebra `P/P₀ = 2·yOff/(2a) = 1/(1−cos θ_max)` via B.1 calibration is sound; B.3 spot check (cos θ=4/5 → 5) passes. No weakened statement, no axiom/admit/native_decide laundering.
- Prover trace: 294 events of genuine tactic iteration on exactly these goals; session aborted on 429 Too Many Requests. No matching task-results artifact (process warning only).
- Next: retry proof with the four concrete tactic repairs and discharge the five sorries per the blueprint proof sketches (`csSup_Ioo`/`csInf_Ioo`, attainment + monotonicity, `sin_two_mul`, cancel `I`).

# Proof Review — problem_IPhO_2026_1_B_2.lean (iter-13, attempt-1)
- Verdict: **blocked / needs_redraft (missing_foundational_bridge)**; preflight rc=1, 4 sorries.
- Contract: faithful post-iter-11 redraft; eps^2=49/4 proved (`eccentricity_sq_eq`), exact signed value
  `-arctan(2/sqrt 45)` ~ -16.6015 deg, honest rounding bands, official value conclusion-side only.
  No axiom/admit/native_decide/laundering; signature preserved; constants opaque.
- Blocker: physical core sorry-bodied — `orbit_eq_conic` L493, `exists_asymptoticRelativeVelocity` L544,
  `signed_deflection_eq_formula` L574, and an inner sorry at L901 (dot/perp parallelogram ratio) inside
  `signed_deflection_angle_T1_B2`: the missing Kepler/Binet-ODE integration layer (no Mathlib API).
- Secondary tactic errors: L884/L886 unsolved norm-sq goals (`|a i|^2` needs `RCLike.norm_sq`/`sq_abs`);
  L901 rewrite failure (`div_pow`/`sq_eq_one_iff` pattern absent) — fixable but cannot close the target.
- Trace: two genuine prover sessions (band squeeze + main assembly), ended at same goals, 429 abort;
  no iter-13 task result exists (process warning only). Blueprint ledger prose stale (67/4 chain) — sync.
- Next: redraft adding the Kepler layer as explicit contract, then discharge bridges and repair hbranch.

# Task result: IPhO2026Problems/problem_IPhO_2026_2_B_2.lean (iter-015 prover)

## Outcome
ALL TARGETS PROVED — file compiles clean: **0 errors, 0 warnings, 0 sorries**.
All 5 proof obligations (1 reviewed-error lemma + 4 sorries) are closed with
honest proofs; the statement signatures are byte-identical. Verified with
`#print axioms` (appended to a temporary copy): every proved declaration
depends only on `[propext, Classical.choice, Quot.sound]` — no `sorryAx`,
no new axioms. Fresh `lake env lean` exit 0.

## What was repaired / proved (proof bodies only, signatures frozen)

1. `abs_hitOffset_eq` (was: 4 tactic errors from the review ledger)
   - `hparseval` (L279 linarith-fail): replaced by a fully-tagged derivation
     — expand the two dot-product squares with `ring`, cross term vanishes
     via the Figure-2f identity `e0 e1 + n0 n1 = 0` (proved by
     `(·)^2 = 0` nlinarith + `sq_eq_zero_iff`, after `n0² = e1²`, `n1² = e0²`
     from squaring `n0 e0 = -n1 e1`), then `e0² + n0² = e1² + n1² = 1`.
   - `habsue` (L295 rw-fail): `|ue| ≤ p.R` via `ue² ≤ R²` (linarith from
     Parseval + `sq_nonneg`) + plain `sq_le_sq : a² ≤ b² ↔ |a| ≤ |b|` +
     `abs_of_pos`.
   - `hsq` (L299 field_simp-fail): `rw [← sq_abs ue, div_pow]` then
     `field_simp [ne_of_gt p.hR]` (no trailing `ring`).
   - `hgoal` (L309 rw-fail): reordered — `conv_lhs => rw [← sq_abs wn]`
     **before** rewriting `hsq` into the sqrt argument; `hunfold`/`hoff`
     applied to the goal instead of `at *`.

2. `collectedWidth_eq_two_mul_yOff` (sorry → proved): the image set of
   transverse readouts is exactly `Ioo (-yOff) yOff` (`readout_eq` ⊆,
   `hit_offsets_fill` ⊇), so `collectedWidth = csSup_Ioo - csInf_Ioo = 2 yOff`.

3. `yOff_eq_R_sin_thetaMax` (sorry → proved, two-sided squeeze):
   - upper: rays in `(R sinθ, yOff)` would be absorbed (`hhit`) but violate
     the θ_max bound `|readout| ≤ R sinθ` (midpoint `t` argument);
   - lower: the attained θ_max ray sits strictly inside the open band, so
     `R sinθ = |readout| < yOff`;
   - the angle-side uses `Real.arccos_zero`, `Real.arccos_le_arccos`,
     `Real.arccos_nonneg`, and `strictMonoOn_sin.le_iff_le` on
     `Icc (-(π/2)) (π/2)`.

4. `two_r_sin_over_diameter_eq` (sorry → proved): B.1 calibration +
   `Real.sin_two_mul` give `2a = 2R sinθ (1 - cosθ)` by
   `linear_combination 2*hcal - p.R*hd`; `cosθ < 1` for `θ ∈ (0, π/2)` via
   `Real.sin_sq_add_cos_sq` + `sq_eq_zero_iff`; then
   `mul_div_mul_right` cancellation and `field_simp`.

5. `power_ratio_eq_width_ratio` (sorry → proved): substitute the two budget
   identities + step 2; intensity cancels by `field_simp` with explicit
   positivity (`linarith [p.ha]`, `mul_pos`).

6. `power_ratio_in_terms_of_theta_max` (Main, sorry → proved): obtain
   `⟨yOff, hyOff, hhit⟩ := r.hitSet_Ioo`, rewrite with (5) and (3), bridge
   with (4) after `2*(R sinθ) = 2*R*sinθ` (`ring`).

## Blueprint markers
Ready for `\leanok` (sync phase / review agent applies):
- `lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:abs_hitOffset_eq`
- `lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:collectedWidth_eq_two_mul_yOff`
- `lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:yOff_eq_R_sin_thetaMax`
- `lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:two_r_sin_over_diameter_eq`
- `lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:power_ratio_eq_width_ratio`
- `thm:IPhO2026Problems_problem_IPhO_2026_2_B_2:power_ratio_in_terms_of_theta_max`
The chapter narration of the yOff proof ("strict monotonicity of the
incidence angle in |offset|") describes the same step realized here via
arccos-range + `strictMonoOn_sin` — faithful, no re-keying needed.

## Notes
- No redraft needed: the iter-011 two-sided contract is exactly provable as
  stated. The `reflected_point_law` field is load-bearing for physical
  faithfulness of the structure but the width/angle bookkeeping closes from
  `readout_eq`, `hitSet_Ioo`, `hit_offsets_fill`, `ThetaMaxSpec` and the B.1
  calibration alone, matching the blueprint proof sketch.
- Only `import Mathlib` used (per the chapter's resolved import policy NOTE:
  PhysLean has no specular-reflection module for this regime).
- Scratch/backup files cleaned up (`/tmp/scratch_2b2.lean`,
  `/tmp/orig_backup_2b2.lean` may remain in /tmp; no scratch files left in
  the repo).

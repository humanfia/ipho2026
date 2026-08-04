# Prover task result — IPhO2026Problems/problem_IPhO_2026_2_B_3.lean

## Status: COMPLETE — all 4 sorries closed, file compiles with 0 errors

## What was done

All four `sorry` bodies were replaced with full proofs; theorem statements,
signatures, structures and hypotheses were left untouched.

1. **`thetaMaxRecorded_mem_Ioo`** — proved via `Real.strictAntiOn_arccos`:
   `arccos (4/5)` lies strictly between `arccos 1 = 0` (`Real.arccos_one`) and
   `arccos 0 = pi/2` (via `Real.arccos_eq_pi_div_two_sub_arcsin`, `Real.arcsin_zero`).

2. **`sin_thetaMaxRecorded`** — `Real.sin_arccos` reduces the goal to
   `sqrt(1 - (4/5)^2) = 3/5`; `norm_num` rewrites the radicand as `(3/5)^2` and
   `Real.sqrt_sq` closes it.

3. **`sin_two_mul_thetaMaxRecorded`** — `Real.sin_two_mul` +
   `sin_thetaMaxRecorded` + `Real.cos_arccos` (bounds by `norm_num`),
   then `norm_num` evaluates `2 * (3/5) * (4/5) = 24/25`.

4. **`container_diameter_for_quintuple_power`** — main target:
   - From `hprev.power_ratio_eq` (B.2) and `P = 5 P0` with `P0 > 0`:
     `5 = 1 / (1 - cos thetaMax)`, the denominator is nonzero (else `5 = 0`),
     so `eq_div_iff` gives `5 * (1 - cos thetaMax) = 1`, and `linarith` yields
     `cos thetaMax = 4/5`.
   - Acuteness (`hprev.theta_range`) puts `thetaMax` in `(0, pi/2)`, a subset of
     `[0, pi]`, so `Real.arccos_cos` inverts: `thetaMax = arccos (cos thetaMax)
     = arccos (4/5) = thetaMaxRecorded`. (The unused
     `HalfCylindricalMirrorPhysics` hypothesis merely confirms the same acuteness
     from the physics side — it stays in the frozen signature as intended.)
   - Substituting into the B.1 relation (`hprev.containerRadius_eq`) at
     `R = 1` with the two trig certificates gives
     `a = 3/5 - (1/2)(24/25) = 3/25 = 0.12 m` (`norm_num`), and
     `a * 100 = 12` follows by `rw [ha_val]; norm_num [metreInCentimetres]`.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_3.lean` (fresh):
  0 errors. Only pre-existing benign `unusedVariables` linter warnings for
  frozen hypotheses `hR`, `ha`, `hphys` (geometry/physics interface fields
  intentionally unused by the value computation).
- `grep -c sorry` -> 0; no `axiom` / `admit` / `native_decide` anywhere.
- `#print axioms` on all four declarations (checked via a scratch copy
  outside the repo): only the standard `[propext, Classical.choice,
  Quot.sound]` — no `sorryAx`, no new axioms.

## Blueprint markers (for review agent / sync)

Ready for `\leanok` (all proofs landed):
- `lem:IPhO2026Problems_problem_IPhO_2026_2_B_3:thetaMaxRecorded_mem_Ioo`
- `lem:IPhO2026Problems_problem_IPhO_2026_2_B_3:sin_thetaMaxRecorded`
- `lem:IPhO2026Problems_problem_IPhO_2026_2_B_3:sin_two_mul_thetaMaxRecorded`
- `thm:IPhO2026Problems_problem_IPhO_2026_2_B_3:container_diameter_for_quintuple_power`

## Redraft needed

None. The statement was faithful (B.1 + B.2 hypotheses and `P = 5 P0`
derive `cos thetaMax = 4/5`, `a = 0.12 m = 12 cm`) and is now fully proved.

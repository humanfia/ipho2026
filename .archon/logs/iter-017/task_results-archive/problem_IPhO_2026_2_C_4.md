# Task result — IPhO2026Problems/problem_IPhO_2026_2_C_4.lean (iter-015 prover, retry 2)

## Outcome

**PROVED — 0 sorries, 0 errors, 0 sorryAx.** Every `sorry` in the assigned file is closed, including
the main target `IPhO2026_2_C_4.HalfCylindricalMirrorCaustic.caustic_small_angle_power_law`.
Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`: exit 0, 0 errors; the only
warning is a benign `unusedVariables` lint on an existing hypothesis name (`hθ1` in a FTC lemma).
`#print axioms` (via lean_verify) = `[propext, Classical.choice, Quot.sound]` only — no `sorryAx`,
no new axioms; source scan clean.

## Statement kept frozen

No signature, hypothesis, definition, or structure field was changed. The theorem still concludes
`SatisfiesCausticPowerLaw c.X_c c.Y_c c.R (c.R/2) ((3/4)·c.R^(1/3))`, i.e. the recorded C.4
constants `u = R/2`, `v = (3/4)R^(1/3)`, `p=2`, `q=3` on the conclusion side only, read as
`Asymptotics.IsEquivalent` along `smallAngleFilter = nhdsWithin 0 (Ioi 0)` (the honest
leading-order reading; an exact pointwise identity is false for this caustic).

## Proof architecture (all new content inside the assigned file)

Helper namespace `C4Dev` (287 lines of FTC/asymptotic infrastructure, no axioms, no sorries):

- `int_pow`, `int_id` — FTC evaluations `∫₀ᵇ sⁿ ds` via `integral_eq_sub_of_hasDerivAt`.
- `abs_sin_le_abs` — `|sin y| ≤ |y|` via FTC `sin y = ∫₀ʸ cos s` + the triangle inequality,
  splitting on the sign of `y` (`intervalIntegral.abs_integral_le_integral_abs`).
- `one_sub_cos_eq_int_sin`, `one_sub_cos_le_quad` — `1 - cos x = ∫₀ˣ sin s ≤ x²/2` by monotonicity
  of the interval integral (`integral_mono_on`) against `abs_sin_le_abs`.
- `t_sub_sin_eq_int`, `J0_subst` — `t - sin t = ∫₀ᵗ (1 - cos s) = t·∫₀¹ (1 - cos(ts))` for `t>0`
  (the second one by `intervalIntegral.integral_comp_mul_left`).
- `sin_ratio_bound` — `|1 - sin θ/θ| ≤ θ²/6` for `0 < θ ≤ 1` (kernel estimate + ∫₀¹ s² = 1/3).
- `abs_t_sub_sin_le` — global cubic `|t - sin t| ≤ |t|³/6` (FTC + quadratic kernel; wlog `t ≥ 0`
  by odd symmetry `Real.sin_neg`).
- `cos_quad_isLittleO` — `cos θ - (1 - θ²/2) =o[𝓝 0] θ²` via the quartic bound
  `|cos θ - 1 + θ²/2| ≤ θ⁴/24` (double integral of `abs_t_sub_sin_le`; even-extension to `θ<0`
  through `Real.cos_neg`).
- `rpow_cube_two_thirds`, `rpow_X_split` — `(x³)^(2/3) = x²` for `x ≥ 0` (via `Real.rpow_natCast`
  + `Real.rpow_mul`), and the mirror-specific split
  `(R sin³θ)^(2/3) = R^(2/3)·sin²θ` on `0 < θ < π` (positivity certificate `Real.sin_pos_of_pos_of_lt_pi`).
- `sin_isEquivalent` — `sin θ ~[smallAngleFilter] θ` from the cubic bound (squeeze against `θ³/6 =o θ`).
- `cos_isEquivalent_one`, `quad_isEquivalent_one` — `cos θ ~[] 1`, `1 - θ²/2 ~[] 1` via
  `isEquivalent_const_iff_tendsto` (nonzero-constant equivalences through continuity).
- `cos_cos2_quad_isLittleO` — the exact residual of the C.3 y-formula:
  `cos θ·(2 - cos 2θ) - (1 + 3θ²/2) = -3(φ + θ²/2) - 6φ² - 2φ³` with `φ = cos θ - 1`
  (by `Real.cos_two_mul` + `ring`); the pieces are `o(θ²)` (the linear one by `cos_quad_isLittleO`,
  the powers by `IsBigO.pow` + `isLittleO_pow_pow`).
- `Y_residual_isLittleO`, `Y_isEquivalent`, `Y_full_isEquivalent` — scaling to
  `Y_c - R/2 ~[] (3R/4)·θ²` and finally `Y_c ~[] R/2 + (3R/4)·θ²` (the constant-offset reshaping
  is justified because `|R/2 + (3R/4)θ²| ≥ (3R/4)θ²` for `R > 0` — no hand-waving: this is the
  norm-bounded-below argument, explicit in the proof).

Main proof (`caustic_small_angle_power_law`): unpacks `SatisfiesCausticPowerLaw` to the two
structure-field abstractions `⟨rfl, rfl, 0<2, 0<3, _, _⟩`; conjunct 1 transports
`Y_full_isEquivalent` through `(3/4)R^(1/3)·X_c^(2/3) =ᶠ (3R/4)·sin²θ` (eventually on the filter,
by `rpow_X_split` + `Real.rpow_add` giving `R^(1/3)·R^(2/3) = R`) and through
`(3R/4)·sin²θ ~ (3R/4)·θ²` (`hSin.pow 2`, constant-replayed with its own norm-bounded-below
offset); conjunct 2 gives `w = R > 0` with `X_c ~ R·θ³` (`hSin.pow 3` scaled, `IsEquivalent.mul`
of the refl constant).

## Review-failure repair (this was retry 2)

The previous iteration's draft was a broken tactic fragment (undefined `x`, stray `φ`/boot-file
identities, five sorries, mismatch between its stated `h₁…h₃` helpers and no final goal). This
iteration replaces the whole proof body from scratch with the honest asymptotic development
above. The earlier build breakers at `2_C_4` (namespaces `𝓝`/`𝓝[≥]`, dangling doc comment) are
gone: the file now elaborates cleanly under `import Mathlib` with explicit `open Filter` /
`open scoped Topology` in place of relying on fully-qualified names everywhere.

## Blueprint markers (for review agent)

`\leanok` candidates (all proofs closed): `smallAngleRegime_mem_filter`,
`HalfCylindricalMirrorCaustic.caustic_small_angle_power_law` (and its supporting definitions,
which are `def`s with no proof obligations). The `C4Dev.*` helpers are new named theorems in the
covered file without blueprint entries yet — the blueprint writer should add entries (or mark
them private) at the next coverage pass; they are real theorems (no sorries) used only by the
target theorem.

## Notes

- No `Redraft needed`: the iter-003 asymptotic formalization (`CausticPowerLawForm`,
  `SatisfiesCausticPowerLaw`) was exactly right — the only faithful reading of `θ ≪ 1` is
  leading-order equivalence, and the stated theorem with the recorded constants is true and
  provable, as now demonstrated.
- One lint warning remains (`hθ1` unused in `sin_ratio_bound`'s signature); harmless, left for
  polish rather than churning the statement.

## Verification transcript (exact)

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_4.lean` → exit 0, 0 errors.
- `lean_verify IPhO2026_2_C_4.HalfCylindricalMirrorCaustic.caustic_small_angle_power_law` →
  axioms `[propext, Classical.choice, Quot.sound]`, source scan: no warnings.
- `grep -cE "sorryAx|sorry |admit |axiom "` on the file → 0.

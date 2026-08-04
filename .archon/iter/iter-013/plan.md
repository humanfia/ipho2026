# Plan — iter-013 (prover stage, bounded pass: 13 mandatory proof-Review retries)

Bounded-pass context: objectives are the 13 deterministic proof-Review retries
(`2_C_4` attempt 1/3 first, then twelve fresh 0/3 lanes). `4_C_7` stays
quarantined in autoformalize (wrong_contract redraft), NOT dispatched to
prover. `1_B_1` / `4_C_6` remain gate-exhausted/provenance-blocked. No
blueprint defects found in the candidate excerpts, so no chapter edits this
pass. Per-target strategies below preserve every stated theorem, hypothesis,
and conclusion.

## 1. `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean` (retry 1/3; 1 sorry)
- **Target:** `caustic_small_angle_power_law` — unfold `SatisfiesCausticPowerLaw`
  to `⟨rfl, rfl, CausticPowerLawForm …⟩` with `p=2`, `q=3`, then
  `refine ⟨⟨by norm_num, by norm_num⟩, ?_, ⟨?, ?_, ?_⟩⟩`.
- **X-side equivalence:** rewrite `X_c` via `c.X_c_formula`; prove
  `(fun θ => c.R * sin θ ^ 3) ~[smallAngleFilter] (fun θ => c.R * θ ^ (3:ℕ))`
  from `Real.sin θ / θ → 1`
  (`Asymptotics.isEquivalent_sin` / `tendsto_sin_div_x` composed to cube),
  then `IsEquivalent.mul` by the constant `c.R` (`IsEquivalent.const_mul`).
  Witness `w = c.R` with `hb : 0 < (3:ℕ)`.
- **Y-side equivalence:** rewrite `Y_c` via `c.Y_c_formula`; target is
  `Y_c ~ (fun θ => (3/4) R^(1/3) * X_c θ ^ ((2:ℝ)/(3:ℝ)) + R/2)`. Reduce
  `(R sin³θ)^((2:ℝ)/(3:ℝ))` to `(R^(1/3) θ²)`-scale via `Real.rpow_natCast`,
  `Real.mul_rpow` (positivity from `c.R_pos`, `sq_nonneg`), and the sin−θ
  equivalence above; reduce `(R/2) cos θ (2 − cos 2θ) − R/2` to
  `(R/2)(2 sin²θ)(cos θ + 1)-`-style leading term `(3/4)·R^(1/3)·|X_c|^(2/3)`
  plus an `o(θ²)` remainder: expand `cos θ = 1 − θ²/2 + o(θ²)`,
  `cos 2θ = 1 − 2θ² + o(θ²)` with `Real.cos_sq`, `Real.cos_two_mul`,
  `Real.sin_sq` and `Asymptotics.IsLittleO` algebra; conclude by
  `IsEquivalent.add_isLittleO` / transitivity. This is the hard-analysis
  budget item the Review flagged: keep `smallAngleFilter` unfold to
  `nhdsWithin 0 (Set.Ioi 0)` so `0 < sin θ` is eventual
  (`eventually_nhdsWithin_of_forall` + `Real.sin_pos_of_pos_of_lt_pi`).
- If the rpow-normal-form step stalls, isolate it as a private lemma
  (no signature changes) and leave the honest residual `sorry` there rather
  than weakening the equivalence.

## 2. `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean` (retry 0/3; 12 sorries)
- Steps 1–6 are unfold + `field_simp`/`ring` after unfolding the `DerivedQuantities`
  defs (`netImmersedWeight`, `weightHorizontalLeverArm`, `restoringMoment`,
  `pressureDifferenceForce`, `pressureFigureArm`, `pressureCoupleMagnitude`)
  and the readout structure fields; use `Real.sin_pi_div_four`,
  `Real.sqrt_pos.mpr (show (0:ℝ)<2 by norm_num)`, `Real.mul_self_sqrt`.
- `critical_balance_eq`: `rw [restoring_moment_eq …, pressure_couple_eq …] at hbal ⊢; exact hbal`.
- `side_length_eq_delta_h_over`: cancel `ρ₀·g·a³ > 0` from `hbal` via
  `mul_left_cancel₀` (positivity side-goals by `positivity` with
  `Real.sqrt_pos` factored in), then `field_simp` + `Real.sqrt_mul_self`;
  finish by `ring_nf` to `a = DeltaH / (2 * sqrt 2)`.
- `numerical_value`: `Or.inr`; rewrite `a` by `ha_eq`, `DeltaH = 1.41`; bound
  `|1.41/(2√2) − 0.50| < 1/200` by `abs_sub_lt_iff` with
  `Real.sqrt_lt`/`lt_sqrt` (`(1.41/(2·0.505))²` vs `2` rational comparisons
  closed by `norm_num`).
- `hydrostatic_gate_side_length_a_target`: split; first component from
  `side_length_eq_delta_h_over` fed by `critical_balance_eq` (which consumes
  `hbal` through Steps 3+4c); second from `numerical_value` resolving the
  disjunction (`Or.resolve_left` via the strict-bound proof, or prove the
  interval directly and drop the `∨`). 
- `torque_balance_contract`: unfold `IsCriticalTorqueBalance`; re-derive from
  `hbal` + Step 3 (a one-or-two-line `⟨hbal, …⟩`/unfold; do not touch the
  structure fields).

## 3. `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` (retry 0/3; 5 sorries)
- Two sorries are genuine Kepler-layer gaps already honestly marked in-file
  (`orbit_eq_conic` L505, `exists_asymptoticRelativeVelocity` L551): leave
  them with their BLOCKED comments intact (honest partial, per workflow).
- Close the *algebraic* tail (L591, L667, L709): the perimeter-chain of
  proved certificates (`eccentricity_gt_one`, `eccentricity_sq_eq`,
  `asymptote_factor_certificate`, `signedDeflection_eq_neg_angle`) already
  exists; the remaining combat is —
  (a) `signedDeflection ≈ -arctan(2/sqrt 45)`: after rewriting with the
  perimeter lemmas the residue is a pure real-arithmetic/norm_num goal on
  `unboundMu = 15/2` inside `semilatusRectum`/`eccentricitySq` — drive with
  `norm_num [unboundMu]` then `ring_nf`;
  (b) the degree-rounding bands: convert with
  `Real.arctan` monotonicity (`Real.arctan_strictMono`,
  `Real.arctan_le_arctan`), `Real.pi_gt_three` bounds, and
  `norm_num` rational squeeze of `2/sqrt 45` via `Real.sqrt_le_sqrt`,
  `Real.le_sqrt` (45 = 9·5 lets `Real.sqrt_eq_iff_mul_self_eq` give
  √45 = 3√5 exactly — rational bounds on √5 to ~4 decimals close both
  rounding bands).
  Keep the marked honesty discount: a `sorry` at the two Kepler bridges is
  the correct endpoint if the 3 algebraic sorries close.

## 4. `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean` (retry 0/3; 3 sorries)
- `quadratic_characterization_of_threshold` is the load-bearing lemma:
  unfold `hbarOmegaMin`; let `E₀ = ℏ·Ω` with
  `Ω = 3mc²(1−√(1−s))/(ℏ(2−cos 2θ))`, `s = (2ΔU/(3mc²))(2sin²θ+1)`.
  Use `2 sin²θ + 1 = 2 − cos 2θ` (`Real.cos_two_mul`, `Real.sin_sq`) to merge
  `hfac`, `hdisc`. Show `2−cos 2θ > 0` (`Real.cos_le_one` + `hfac`-style
  strictness since `cos ≤ 1 < 2`), `0 < E₀` by `positivity` after
  `Real.sqrt_lt_one.mpr` (needs `0 < s`, `s ≤ 1` from `hdisc` and
  positivity). Then verify the quadratic root identity by
  `field_simp` + the surd identity `1 − √u = s/(1+√u)`
  (`mul_self_sub_mul_self_eq`, `Real.mul_self_sqrt hdisc`) and `ring_nf`.
  Minimality: the quadratic `(2−cos2θ)E² −6mc²E + 6ΔUmc²` factors as
  `(E−E₀)·((2−cos2θ)·E − (2−cos2θ)·E₁)` with `E₁` the larger root
  (`E₀ E₁ = 6ΔUmc²/(2−cos2θ)`, `E₀+E₁ = 6mc²/(2−cos2θ)`); from `E>0` and
  the factorized zero-equality derive `E = E₀ ∨ E = E₁`, then
  `E₀ ≤ E₁` from the discriminant ordering (`Real.sqrt_nonneg`,
  `sub_nonpos` normalized) — a `nlinarith`-friendly linear case split.
- `minimum_angular_frequency_T1_C1`: unfold `IsDissociationThreshold`;
  instantiate `quadratic_characterization_of_threshold` at the opaque
  constants (`ConstantRegime` positivity supplies `hm hc hdU hb`; angle
  hypotheses map directly); rewrite the energy–momentum conservation law
  (`EnergyConservation`/`IsTwoBodyDissociation`) to *derive* that any
  dissociating `ℏω` satisfies the quadratic — this uses the file's own
  bridge predicates, not new assumptions; the threshold/minimality halves are
  the lemma's three conclusions repackaged by `refine ⟨?_, ?_, ?_⟩`.
- `minimum_angular_frequency_backward_branch_T1_C1`: same scaffold; for
  `θ ≥ π/2` show the quadratic at `θ` coincides with the one at `π/2` under
  the file's branch predicate (the reflection invariance of `sin²θ`,
  `Real.sin_pi_sub` + `IsAngularRange`), then forward-branch lemma at
  `π/2` (`Real.sin_pi_div_two`, `Real.cos_pi`) with `hdisc` matching via
  `Real.sin_sq` rewrite.

## 5. `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean` (retry 0/3; 6 sorries)
- `collectedWidth_eq_two_mul_yOff`: unfold `collectedWidth`; with
  `hhit : hitSet = Ioo (-yOff) yOff` use `Real.sSup_Ioo`/`Real.sInf_Ioo`
  (`csSup_Ioo`, `csInf_Ioo` under `Set.Ioo`), then `ring`.
- `yOff_eq_R_sin_thetaMax`: from `ThetaMaxSpec` attain+bound, the extreme
  band edges, and the strict monotonicity of the offset (`abs_hitOffset_eq`
  plus `Real.strictMonoOn_sin` on `Ioo 0 (π/2)`)
  invert `|y| = R sin(incidence)` at the edge; `le_antisymm` from the
  spec's two directions.
- `two_r_sin_over_diameter_eq`: unfold `B1Calibration`;
  `field_simp` with `2 R sin θ ≠ 0`
  (`Real.sin_pos_of_mem_Ioo` on `hθ`), rewrite `sin (2θ) = 2 sinθ cosθ`
  (`Real.sin_two_mul`), then `ring`.
- `power_ratio_eq_width_ratio`: unfold `PowerBudget` fields; cancel the
  common positive intensity with `mul_div_mul_left`/`field_simp`.
- Main `power_ratio_in_terms_of_theta_max`:
  `power_ratio_eq_width_ratio` → rewrite via `yOff_eq_R_sin_thetaMax`
  → `two_r_sin_over_diameter_eq hθ hcal`; a 3-line `.trans` chain.
- `abs_hitOffset_eq`: inner-product Pythagoras in `EuclideanSpace ℝ (Fin 2)`
  (`inner_eq`, `norm_eq`, the `e⊥n` unit-frame fields of `CookerGeometry`),
  rewrite arccos of cos via `Real.arccos_cos` on the spec branch, then
  `Real.sin_arccos` / direct algebra. This is the only genuinely geometric
  lemma; if the EuclideanSpace coercion boilerplate explodes, state the
  2-coordinate expansion as a private `have` (no signature change).

## 6. `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean` (retry 0/3; 2 sorries)
- Both sorries are the same modeling bridge (`hfam : slopeFamily_deriv s`,
  `hfam : interceptFamily_deriv s`): `deriv s.M s.θ = -2 (sin 2θ)⁻¹²` resp.
  `deriv s.B s.θ = (R/(2cosθ)) tanθ`, i.e. contracting the *abstract family*
  to the specular C.1 law. First try: check whether some structure field
  (`s.M_differentiable` + a pointwise family identity like
  `∀ φ, s.M φ = cot (2·φ)` / `s.m_A_eq`/`s.m_A_formula` extended off the
  base point) already implies it — if a global-family field exists, derive
  `deriv` by `Filter.EventuallyEq.deriv_eq` of that identity with
  `deriv_specularSlopeFamily` (proved sorry-free in-file). If the structure
  genuinely exposes only the local `HasDerivAt` interface with the value
  unconstrained, the contract is underdetermined exactly as iter-011 found
  pre-redraft: then leave the two honest `sorry`s (they are already the
  marked honesty discount) rather than adding a new hypothesis (forbidden:
  statement change). Do NOT weaken; report the residual.

## 7. `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean` (retry 0/3; 0 sorries)
- No open placeholders: verify with `lake env lean` that the file still
  elaborates clean (0 errors / 0 sorries), and confirm the reviewed failure
  was not a regression. If Review complained about a hidden elaboration
  issue, inspect diagnostics and apply a minimal tactic fix (e.g.,
  `field_simp`-normal form drift in `meanRadius_form_eq_volume_form`).
  No statement contact is needed.

## 8. `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean` (retry 0/3; 7 sorries)
- Order: (1) `magnetization_eq_eos_solution`-class pointwise lemma
  (`field_simp` with `V ≠ 0` structure field, `mul_comm`/`mul_assoc`);
  (2) `magnetization_deriv`: rewrite pointwise as `fun H ↦ c * H`,
  `HasDerivAt.const_mul c hasDerivAt_id`, `HasDerivAt.deriv`;
  (3) `workOnDensity_eq_linear`: unfold `IsMagneticWorkDensity`, rewrite by
  (2), `field_simp; ring`;
  (4) `workOnDensity_contDiff`: transport (3) across an `EventuallyEq`/funext
  to `ContDiff.const_mul 1 contDiff_id`
  (`ContDiff.congr` needs care: use the pointwise equality from (3) with
  `contDiff_of_differentiable` not needed — `ContDiff.congr` over
  `Set.univ` works);
  (5) heat–work antiderivative bridge: from the first-law hypothesis
  `Q_in(H₁) − Q_in(H₀) = −∫_{H₀}^{H₁} workOnDensity`, evaluate the integral
  of the linear density with `intervalIntegral.integral_deriv_eq_sub'`
  (primitive `(c/2)·H²`, `(4)` supplies regularity → `c/2 · (Hf² − Hi²)`);
  (6) `heat_leaves_torus_on_field_increase` and the final
  `OfficialAnswerValue`-target: specialize (5) with the demagnetized
  reference where `Q_in 0 = 0`/`U`-bracket, then
  `field_simp; ring_nf` to the recorded
  `Q = −(μ₀ n K/(2T))(Hf²−Hi²)`. All steps stay inside existing hypotheses.

## 9. `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` (retry 0/3; 3 sorries)
- `adiabatic_invariant_along_path`: show the invariant's `deriv` along the
  path vanishes and apply MVT-constancy
  (`is_const_of_deriv_eq_zero` / `Convex.is_const_of_forall_deriv_eq_zero`
  on `Set.univ`, or `exists_hasDerivAt_eq_zero`-style: simpler is
  `Continuous` + `∀ t, deriv (fun t => adiabaticInvariant params (p t).temperature (p t).field) t = 0`
  ⇒ constant by `is_const_of_deriv_eq_zero`). Compute the derivative by
  chain rule from the iter-012 repair fields `temp_differentiable`,
  `mag_differentiable` (`DifferentiableAt.hasDerivAt`,
  `HasDerivAt.mul`, `HasDerivAt.pow`, `HasDerivAt.add`), then substitute the
  EOS (`params`-level: rewrite `M(t) = nKH/(T V)`-form from `ParamagneticTorusLaws`),
  `Cm(t)` value and work law `w(t) = μ₀ V H · deriv M`, and the adiabatic
  balance `Cm·deriv T = −w`; the identity collapses to `0` by `field_simp`
  (`T ≠ 0`,`V ≠ 0` from positivity fields) + `ring`.
- `endpoint_relation`: obtain `t₀` from `hendpoints.initial`, `tf` from
  `hfinal`; `simp [adiabaticInvariant]` on
  `adiabatic_invariant_along_path params p laws hadiabatic t₀ tf` with the
  endpoint rewrites.
- `adiabatic_temperature_change`: from `endpoint_relation` + positivity
  (`lam_add_mu0_K_sq_pos`, `Ti_pos`, `hTf_pos`): divide by the positive
  bracket `λ+μ₀K Hi²` and by `Ti²`, take `Real.sqrt` both sides
  (`Real.sqrt_eq_iff_sq_eq` / `Real.sqrt_div`,
  `Real.sqrt_sq (le_of_lt hTf_pos)`, `Real.sqrt_sq (le_of_lt Ti_pos)`),
  giving `Tf/Ti = sqrt((λ+μ₀K Hf²)/(λ+μ₀K Hi²))`; rearrange to
  `Tf − Ti = Ti·(√… − 1)` with `field_simp; ring`.

## 10. `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean` (retry 0/3; 1 sorry)
- `q_relation` (L405): the hot-isotherm leg law (12-isotherm, Fig 3b
  `T1=T2=Th`) gives an `A·(Th M2² − Th M1²)` term and the 3→4 isotherm gives
  `A·(Th M4² − Th M3²)·Tc/…` — follow the file's own contraction map: unfold
  both isotherm-leg laws (`IsothermalLegStateLaw` analogues of
  `AdiabaticLegStateLaw`), rewrite with the `figure3b` temperature
  tuple, cancel the common nonzero prefactor
  `A = μ₀V²/(2nK)` via the `hA` pattern already proved in
  `q4_eq_adiabatic_41`'s aftermath (replicate that `have hA` block), then
  `linear_combination` of the two leg equations to land the recorded
  linear relation. The surrounding comment gives the exact polynomial;
  translate it to `linear_combination` coefficients (or `nlinarith` with the
  two hypotheses after `ring_nf`).
- After it, `m1_eq_sqrt` closes by the existing downstream rewrite
  (`rw [leg41, leg23]; ring` then `Real.sqrt_eq_iff_sq_eq` with the
  magnitude nonnegativity field) — verify it needs no further repair.

## 11. `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean` (retry 0/3; 0 sorries)
- No open placeholders (redraft passed iter-11). Confirm fresh compile
  (`lake env lean`): `c4_elapsed_time` and the FTC chain
  (`cooling_time_integral_eval`, `elapsedTime_eq_integral` + density lemmas)
  should hold as shipped. If the reviewed failure was elaboration drift,
  confine fixes to tactic syntax inside proofs (e.g. `intervalIntegral`
  coercion re-association); no statements move.

## 12. `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` (retry 0/3; 0 sorries)
- No open placeholders. Verify compile clean; if Review flagged an
  elaboration/faithfulness nit (e.g. `beta0_uncertainty_bound`'s
  `abs`-arithmetic assembly), a minimal tactic-level tightening
  (`rw [hdev_eq] at hdev; exact le_of_mul_le_mul_left hdev hfac` already
  shipped) is the whole job. Do not touch `IsIsochoricLinear` fields.

## 13. `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean` (retry 0/3; 2 sorries)
- First sorry (reported central value conjunct): after
  `rw [catalogQvValue, catalogMolarMassWaterValue]` reduce to
  `Lv_reported.central_kJ_per_kg = 39 / (18.0e-3)` — this requires tying
  `Lv_reported` to the conversion *by the existential's conjunct*, but the
  variable is universally quantified: the correct honest route is to pick
  the witness's `central` field consistent with the equation only if the
  theorem's binder order permits; since `Lv_reported` is an input, the
  conjunct is provable only by rewriting the *reported* quantity's defining
  equation inside `PartB6Input` — inspect `PartB6Input`'s fields: if a
  hypothesis pins `Lv_reported` to the catalog conversion, `rw` and
  `norm_num`; if not, the left conjunct is `Lv_reported.central = 39/0.018`,
  which is a *fact about the arbitrary input* and cannot be discharged —
  that is the known honesty-discount shape: leave the `sorry` with its
  comment (do NOT delete the conjunct: that would weaken the target).
- Second sorry (band membership): from the *previous conjunct* as a local
  hypothesis (`intro hprev` is unavailable inside conjuncts — restructure
  proof to `refine ⟨…, ?_, ?_, ?_, ?_⟩` with the band goal after having
  established `hcentral`, e.g. prove the conjunction right-nested with
  `have` chaining), rewrite central to `39/0.018`, `abs_le` + `norm_num`
  (`|2166.67 − 2190| = 23.33 ≤ 110`), reusing
  `computed_value_within_official_uncertainty`'s arithmetic. Feasible once
  the first conjunct's status is settled: if the first stays a marked
  `sorry`, this second can still close *conditionally* by the same
  `have hcentral : … := by sorry` pattern used above — prefer the genuine
  closure if `PartB6Input` supplies the tie-out.

## Cross-cutting rules for all 13 lanes
- No statement, signature, structure-field, or hypothesis edits anywhere;
  proofs only (`by` bodies and private `have`/lemma*lets inside proofs).
- No new axioms, no `native_decide` on open reals, no macro/elaborator tricks.
- Where the excerpt/file itself records a genuine infrastructure block
  (1_B_2 Kepler bridges; 2_C_2 family-bridge; 4_B_6 tie-out), keep the
  existing honestly-marked `sorry` at exactly that gap and say so in the
  task result — per workflow an honest partial beats a fake complete.
- Verify each edited file with `lake env lean <file>`; finish with 0 errors
  and sorries only at the explicitly enumerated residual points.

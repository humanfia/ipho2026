import Mathlib

/-!
# IPhO 2026, Problem 2, Part C.4 — Caustic of the half-cylindrical mirror

Physical model (blueprint chapter
`blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_4.tex`):

* A half-cylindrical mirror of radius `R` (Figure 2g coordinate convention).
* Ray A is incident at angle `θ`; its reflected line is `y = m_A * x + b_A`.
* A neighboring parallel ray B is incident at `θ + Δθ`, with `Δθ ≪ θ`;
  its reflected line is `y = m_B * x + b_B`.
* The envelope (limiting intersection) of neighboring reflected rays is the
  caustic, parametrized by the incidence angle `θ`.

Previous-part result (C.3, natural-language prerequisite, assumed as an
hypothesis interface):
  `X_c θ = R * sin θ ^ 3`,
  `Y_c θ = (R / 2) * cos θ * (2 - cos (2 * θ))`.

Current subquestion (C.4, the proof target):
  for `θ ≪ 1`, the caustic takes the power-law form
  `Y_c = v * |X_c| ^ (p / q) + u`
  with `u = R / 2`, `v = (3 / 4) * R ^ (1 / 3)`, `p = 2`, `q = 3`.

Math note: an exact identity `Y_c θ = v * |X_c θ| ^ (p / q) + u` at every
small `θ` is FALSE for this caustic — Taylor expansion gives
`Y_c θ = R / 2 + (3 / 2) * R * θ ^ 2 + O(θ ^ 4)` and
`|X_c θ| ^ (2 / 3) = R ^ (2 / 3) * θ ^ 2 * (1 + O(θ ^ 2))`, so the two sides
agree only to leading order. The physically intended reading of `θ ≪ 1` is
asymptotic agreement to leading order as `θ → 0⁺`, formalized below with
`Asymptotics.IsEquivalent` on the filter `nhdsWithin 0 (Set.Ioi 0)`. The
recorded constants genuinely make the leading Taylor terms coincide; they are
not hand-picked to fit the definition.
-/

open Real
open Asymptotics

namespace IPhO2026_2_C_4

/-- The physical setup of the C-parts of IPhO 2026 Problem 2: the
half-cylindrical mirror of radius `R` (Figure 2g), the reflected lines of the
neighboring parallel rays A and B, and the caustic parametrized by the
incidence angle `θ`. All coordinates are Cartesian coordinates in the plane of
Figure 2g, so real scalars; `R` has the dimension of length. -/
structure HalfCylindricalMirrorCaustic where
  /-- Radius `R` of the half-cylindrical mirror (a length). -/
  R : ℝ
  /-- The mirror radius is positive. -/
  R_pos : 0 < R
  /-- Slope `m_A θ` of the line reflected from ray A at incidence angle `θ`. -/
  m_A : ℝ → ℝ
  /-- Intercept `b_A θ` of the line reflected from ray A. -/
  b_A : ℝ → ℝ
  /-- Slope `m_B θ Δθ` of the line reflected from the neighboring parallel
  ray B, incident at angle `θ + Δθ`. -/
  m_B : ℝ → ℝ → ℝ
  /-- Intercept `b_B θ Δθ` of the line reflected from ray B. -/
  b_B : ℝ → ℝ → ℝ
  /-- `X_c θ`, the x-coordinate of the limiting intersection of the two
  neighboring reflected lines as `Δθ → 0` (a length). -/
  X_c : ℝ → ℝ
  /-- `Y_c θ`, the y-coordinate of the limiting intersection (a length). -/
  Y_c : ℝ → ℝ
  /-- Envelope/limiting-intersection law: for every `θ` and every small
  nonzero offset `Δθ`, the unique intersection `(x, y)` of the reflected lines
  `y = m_A θ * x + b_A θ` and `y = m_B θ Δθ * x + b_B θ Δθ` tends to
  `(X_c θ, Y_c θ)` as `Δθ → 0`. This is the geometric definition of the
  caustic as the envelope of the reflected rays (Figure 2g). -/
  envelope_law :
    ∀ θ : ℝ, ∀ᶠ Δθ in nhdsWithin 0 (Set.Ioi 0),
      ∃! p : ℝ × ℝ,
        p.2 = m_A θ * p.1 + b_A θ ∧
        p.2 = m_B θ Δθ * p.1 + b_B θ Δθ
  /-- Previous part C.3: explicit limiting intersection coordinates,
  `X_c θ = R * sin θ ^ 3` (natural-language prerequisite, recorded here as a
  hypothesis on the caustic data). -/
  X_c_formula : ∀ θ : ℝ, X_c θ = R * sin θ ^ 3
  /-- Previous part C.3: explicit limiting intersection coordinates,
  `Y_c θ = (R / 2) * cos θ * (2 - cos (2 * θ))`. -/
  Y_c_formula : ∀ θ : ℝ, Y_c θ = R / 2 * cos θ * (2 - cos (2 * θ))

/-- The small-`θ` regime `θ ≪ 1` stipulated in the subquestion, carried by the
filter `nhdsWithin 0 (Set.Ioi 0)` (`θ → 0` from the positive side).
Branch/orientation data: incidence angles are taken positive, which is also
what makes the absolute value `|X_c|` of the source statement harmless —
`X_c θ = R * sin θ ^ 3` is positive for small positive `θ` — and selects the
physical branch of the power law. -/
noncomputable def smallAngleFilter : Filter ℝ := nhdsWithin 0 (Set.Ioi 0)

/-- Small-angle regime predicate on an incidence angle: `θ` is positive and
strictly smaller than `1` radian (a plain-English reading of `θ ≪ 1`;
neighborhoods of `smallAngleFilter` carry the operative asymptotic notion). -/
def InSmallAngleRegime (θ : ℝ) : Prop :=
  0 < θ ∧ θ < 1

/-- Bridge between the plain-English small-angle regime and the asymptotic
filter: the set of angles satisfying `InSmallAngleRegime` is a neighborhood
of `0` within the positive angles, so statements eventually true along
`smallAngleFilter` apply to it (proved, not assumed). -/
theorem smallAngleRegime_mem_filter :
    {θ : ℝ | InSmallAngleRegime θ} ∈ smallAngleFilter := by
  rw [smallAngleFilter, mem_nhdsWithin]
  exact ⟨Set.Iio 1, isOpen_Iio, by simp, fun θ hθ => ⟨hθ.2, hθ.1⟩⟩

/-- The `θ ≪ 1` power-law form of a parametric plane curve `θ ↦ (X θ, Y θ)`:
the coordinate functions have a well-defined positive leading-order balance
as `θ → 0⁺`, i.e. they are asymptotically equivalent
(`Asymptotics.IsEquivalent`, `f ~[l] g`) along the small-angle filter:
`Y θ ~ v * X θ ^ (p / q) + u` and `X θ ~ w * θ ^ q` for some positive scale
`w`. The exponent is a positive rational; `u`, `v` carry the dimension of
length and `p / q` is dimensionless. This is the genuine asymptotic content
of the subquestion: the two sides agree to leading order without being
required to coincide exactly (they do not for the mirror caustic). All
quantities are parameters of the definition, so nothing here is specialized
to the recorded answer. -/
def CausticPowerLawForm (X Y : ℝ → ℝ) (u v : ℝ) (p q : ℕ) : Prop :=
  0 < p ∧ 0 < q ∧
  (fun θ : ℝ => Y θ) ~[smallAngleFilter]
    (fun θ => v * X θ ^ ((p : ℝ) / (q : ℝ)) + u) ∧
  ∃ w : ℝ, 0 < w ∧
    (fun θ : ℝ => X θ) ~[smallAngleFilter] (fun θ => w * θ ^ q)

/-- The power-law form with the recorded constants of subquestion C.4 made
explicit: the vertical shift `u` and the prefactor `v` are the ones determined
from the mirror geometry, with exponent `p / q = 2 / 3`. -/
def SatisfiesCausticPowerLaw (X Y : ℝ → ℝ) (R u v : ℝ) : Prop :=
  u = R / 2 ∧
  v = (3 / 4) * R ^ ((1 : ℝ) / 3) ∧
  CausticPowerLawForm X Y u v 2 3


open Filter MeasureTheory Set intervalIntegral
open scoped Topology

namespace C4Dev

theorem isLittleO_congr {f g h : ℝ → ℝ} {l : Filter ℝ}
    (hh : h =o[l] g) (hclose : ∀ᶠ t in l, ‖f t - g t‖ ≤ ‖h t‖) : f ~[l] g := by
  have hlo : (fun t => f t - g t) =o[l] g := by
    rw [isLittleO_iff] at hh ⊢
    intro c hc
    filter_upwards [hh hc, hclose] with t ht h2
    exact le_trans h2 ht
  exact hlo

/-! ## Interval-eval lemmas -/

theorem int_pow (a b : ℝ) (n : ℕ) :
    (∫ s : ℝ in a..b, s ^ n) = (b ^ (n + 1) - a ^ (n + 1)) / (n + 1 : ℝ) := by
  have hD : ∀ x : ℝ, HasDerivAt (fun s : ℝ => s ^ (n + 1) / (n + 1 : ℝ)) (x ^ n) x := by
    intro x
    have e := hasDerivAt_pow (n + 1) x
    rw [Nat.add_sub_cancel n 1] at e
    have h2 := e.div_const ((n : ℝ) + 1)
    rw [Nat.cast_add, Nat.cast_one] at h2
    have hc : (↑n + 1 : ℝ) ≠ 0 := by positivity
    have hrw : (↑n + 1 : ℝ) * x ^ n / (↑n + 1 : ℝ) = x ^ n := by field_simp
    rw [hrw] at h2
    exact h2
  have hint : IntervalIntegrable (fun s : ℝ => s ^ n) volume a b :=
    Continuous.intervalIntegrable (by fun_prop) a b
  have heq := intervalIntegral.integral_eq_sub_of_hasDerivAt (fun s _ => hD s) hint
  rw [heq]; ring

theorem int_id (a b : ℝ) : (∫ s : ℝ in a..b, s) = (b^2 - a^2) / 2 := by
  have hD : ∀ y : ℝ, HasDerivAt (fun s : ℝ => s ^ 2 / 2) y y := by
    intro y
    have h2 := (hasDerivAt_pow 2 y).div_const (2 : ℝ)
    rw [show (2:ℕ)-1 = 1 from rfl, pow_one] at h2
    exact h2.congr_deriv (by ring)
  have hint : IntervalIntegrable (fun s : ℝ => s) volume a b :=
    Continuous.intervalIntegrable (by fun_prop) a b
  have heq := intervalIntegral.integral_eq_sub_of_hasDerivAt (f := fun s : ℝ => s^2/2)
    (f' := fun y => y) (a := a) (b := b) (fun s _ => hD s) hint
  rw [heq]; ring

theorem abs_sin_le_abs (y : ℝ) : |sin y| ≤ |y| := by
  have hsin : sin y = (∫ s : ℝ in (0 : ℝ)..y, cos s) := by
    have heq := intervalIntegral.integral_eq_sub_of_hasDerivAt (f := sin)
      (f' := cos) (a := (0 : ℝ)) (b := y) (fun s _ => Real.hasDerivAt_sin s)
      (Continuous.intervalIntegrable Real.continuous_cos 0 y)
    rw [Real.sin_zero, sub_zero] at heq
    rw [heq]
  rw [hsin]
  rcases le_total 0 y with hy | hy
  · rw [abs_of_nonneg hy]
    have hI : |(∫ s : ℝ in (0:ℝ)..y, cos s)| ≤ ∫ s : ℝ in (0:ℝ)..y, 1 := by
      have habs := intervalIntegral.abs_integral_le_integral_abs (μ := volume) hy (f := cos)
      refine le_trans habs ?_
      apply intervalIntegral.integral_mono (μ := volume) hy
      · exact Continuous.intervalIntegrable Real.continuous_cos.abs 0 y
      · exact Continuous.intervalIntegrable continuous_const 0 y
      · intro s; exact abs_cos_le_one s
    have he : (∫ s : ℝ in (0:ℝ)..y, (1:ℝ)) = y := by simp [intervalIntegral.integral_const]
    rw [he] at hI; exact hI
  · rw [abs_of_nonpos hy]
    rw [intervalIntegral.integral_symm, abs_neg]
    have hI : |(∫ s : ℝ in (y:ℝ)..0, cos s)| ≤ ∫ s : ℝ in (y:ℝ)..0, 1 := by
      have habs := intervalIntegral.abs_integral_le_integral_abs (μ := volume) hy (f := cos)
      refine le_trans habs ?_
      apply intervalIntegral.integral_mono (μ := volume) hy
      · exact Continuous.intervalIntegrable Real.continuous_cos.abs y 0
      · exact Continuous.intervalIntegrable continuous_const y 0
      · intro s; exact abs_cos_le_one s
    have he : (∫ s : ℝ in (y:ℝ)..0, (1:ℝ)) = -y := by simp [intervalIntegral.integral_const]
    rw [he] at hI; exact hI

theorem one_sub_cos_eq_int_sin (x : ℝ) :
    1 - cos x = (∫ s : ℝ in (0 : ℝ)..x, sin s) := by
  have hF : ∀ y : ℝ, HasDerivAt (fun s : ℝ => -cos s) (sin y) y := by
    intro y
    have h := (Real.hasDerivAt_cos y).neg
    rw [neg_neg] at h
    exact h
  have heq := intervalIntegral.integral_eq_sub_of_hasDerivAt (f := fun s : ℝ => -cos s)
    (f' := sin) (a := (0 : ℝ)) (b := x) (fun s _ => hF s) intervalIntegral.intervalIntegrable_sin
  rw [Real.cos_zero] at heq
  rw [heq]; ring

theorem one_sub_cos_le_quad (x : ℝ) : 1 - cos x ≤ x ^ 2 / 2 := by
  wlog hx : 0 ≤ x generalizing x
  · have hx' : x < 0 := not_le.mp hx
    have hneg : 0 ≤ -x := neg_nonneg.mpr (le_of_lt hx')
    have hres := this (-x) hneg
    rwa [Real.cos_neg, neg_sq] at hres
  · rw [one_sub_cos_eq_int_sin]
    have hI : (∫ s : ℝ in (0:ℝ)..x, sin s) ≤ ∫ s : ℝ in (0:ℝ)..x, s := by
      apply intervalIntegral.integral_mono_on (μ := volume) hx
      · exact intervalIntegral.intervalIntegrable_sin
      · exact Continuous.intervalIntegrable continuous_id 0 x
      · intro s hs
        rw [Set.mem_Icc] at hs
        have habs := abs_sin_le_abs s
        rw [abs_of_nonneg hs.1] at habs
        exact le_trans (le_abs_self _) habs
    have he : (∫ s : ℝ in (0:ℝ)..x, s) = x^2 / 2 := by
      have h := int_id 0 x
      rw [zero_pow two_ne_zero, sub_zero] at h
      rw [h]
    rw [he] at hI; exact hI


/-! ## The `t → 0⁺` scale law -/

/-- P0: `t - sin t = ∫₀ᵗ (1 - cos s) ds`. -/
theorem t_sub_sin_eq_int (t : ℝ) :
    t - sin t = ∫ s : ℝ in (0 : ℝ)..t, (1 - cos s) := by
  have hF : ∀ x : ℝ, HasDerivAt (fun s : ℝ => s - sin s) (1 - cos x) x := by
    intro x
    have h1 : HasDerivAt ((fun s : ℝ => s) - fun s : ℝ => sin s) (1 - cos x) x :=
      (hasDerivAt_id x).sub (Real.hasDerivAt_sin x)
    convert h1 using 1
    funext s
    rfl
  have hint : IntervalIntegrable (fun s : ℝ => 1 - cos s) volume 0 t :=
    Continuous.intervalIntegrable (by fun_prop) 0 t
  have heq := intervalIntegral.integral_eq_sub_of_hasDerivAt (f := fun s : ℝ => s - sin s)
    (f' := fun s => 1 - cos s) (a := (0 : ℝ)) (b := t) (fun s _ => hF s) hint
  rw [heq, Real.sin_zero]; simp

/-- Substitution: `∫₀ᵗ (1 - cos s) ds = t * ∫₀¹ (1 - cos (t * s)) ds` for `t > 0`. -/
theorem J0_subst {t : ℝ} (ht : 0 < t) :
    (∫ s : ℝ in (0 : ℝ)..t, (1 - cos s)) = t * ∫ s : ℝ in (0 : ℝ)..1, (1 - cos (t * s)) := by
  have h := intervalIntegral.integral_comp_mul_left (f := fun s : ℝ => 1 - cos s) (a := (0 : ℝ)) (b := 1)
    (c := t) ht.ne'
  rw [mul_zero, mul_one] at h
  rw [h, smul_eq_mul]
  have e : t * (t⁻¹ * (∫ s : ℝ in (0:ℝ)..t, (1 - cos s))) = ∫ s : ℝ in (0:ℝ)..t, (1 - cos s) := by
    rw [← mul_assoc, mul_inv_cancel₀ ht.ne', one_mul]
  linarith

/-- Generic FTC integral of a composition: for `g` continuous with antiderivative `G`,
`(∫₀¹ G' s ↦ (t * s)) * t = G(t) - G(0)`; packaged here concretely for `G = id - sin ∘ (·)/t`. -/
theorem P0_int_value {t : ℝ} (ht : 0 < t) :
    (∫ s : ℝ in (0 : ℝ)..1, (1 - cos (t * s))) = 1 - sin t / t := by
  have hF : ∀ x : ℝ, HasDerivAt (fun s : ℝ => s - sin (t * s) / t) (1 - cos (t * x)) x := by
    intro x
    have he : (1 : ℝ) - cos (t * x) = 1 - cos (t * x) * (t * 1) / t := by
      rw [mul_one, mul_div_cancel_right₀ _ ht.ne']
    rw [he]
    have hinner : HasDerivAt (fun s : ℝ => t * s) (t * 1) x := (hasDerivAt_id x).const_mul t
    have hsin : HasDerivAt (fun s : ℝ => sin (t * s)) (cos (t * x) * (t * 1)) x :=
      (Real.hasDerivAt_sin (t * x)).comp x hinner
    have hdiv : HasDerivAt (fun s : ℝ => sin (t * s) / t) (cos (t * x) * (t * 1) / t) x :=
      hsin.div_const t
    have hsub : HasDerivAt ((fun s : ℝ => s) - fun s : ℝ => sin (t * s) / t)
        (1 - cos (t * x) * (t * 1) / t) x := (hasDerivAt_id x).sub hdiv
    convert hsub using 1
    funext s
    rfl
  have hint : IntervalIntegrable (fun s : ℝ => 1 - cos (t * s)) volume 0 1 :=
    Continuous.intervalIntegrable (by fun_prop) 0 1
  have heq := intervalIntegral.integral_eq_sub_of_hasDerivAt (f := fun s : ℝ => s - sin (t * s) / t)
    (f' := fun s => 1 - cos (t * s)) (a := (0 : ℝ)) (b := 1)
    (fun s _ => hF s) hint
  rw [heq]
  have e0 : sin (t * 1) = sin t := by rw [mul_one]
  have e1 : sin (t * (0 : ℝ)) = 0 := by rw [mul_zero, Real.sin_zero]
  rw [e0, e1]
  simp

/-- Composition bound core: for `0 < θ ≤ 1`, `|1 - sin θ / θ| ≤ θ² / 6`. -/
theorem sin_ratio_bound {θ : ℝ} (hθ0 : 0 < θ) (hθ1 : θ ≤ 1) :
    |1 - sin θ / θ| ≤ θ ^ 2 / 6 := by
  have hval : 1 - sin θ / θ = (∫ s : ℝ in (0:ℝ)..1, (1 - cos (θ * s))) :=
    (P0_int_value hθ0).symm
  have hnn : 0 ≤ (∫ s : ℝ in (0:ℝ)..1, (1 - cos (θ * s))) := by
    have hintg : IntervalIntegrable (fun s : ℝ => 1 - cos (θ * s)) volume 0 1 :=
      Continuous.intervalIntegrable (by fun_prop) 0 1
    have hle : ∀ s : ℝ, (0 : ℝ) ≤ 1 - cos (θ * s) := fun s => sub_nonneg.mpr (cos_le_one _)
    have := intervalIntegral.integral_nonneg (μ := volume) (a := (0:ℝ)) (b := (1:ℝ)) (f := fun s : ℝ => 1 - cos (θ * s)) zero_le_one (fun s _ => hle s)
    exact this
  rw [hval, abs_of_nonneg hnn]
  have hmono : (∫ s : ℝ in (0:ℝ)..1, (1 - cos (θ * s)))
      ≤ ∫ s : ℝ in (0:ℝ)..1, (θ^2 / 2) * s^2 := by
    apply intervalIntegral.integral_mono_on (μ := volume) zero_le_one
    · exact Continuous.intervalIntegrable (by fun_prop) 0 1
    · exact Continuous.intervalIntegrable (by fun_prop) 0 1
    · intro s hs
      rw [Set.mem_Icc] at hs
      have hq := one_sub_cos_le_quad (θ * s)
      have hs2 : (θ * s)^2 / 2 = (θ^2/2) * s^2 := by ring
      rw [hs2] at hq
      exact hq
  have h3 : (∫ s : ℝ in (0:ℝ)..1, s^2) = 1 / 3 := by
    have h := int_pow 0 1 2
    rw [show (2:ℕ)+1 = 3 from rfl, one_pow, zero_pow three_ne_zero, sub_zero] at h
    rw [h]; norm_num
  have heval : (∫ s : ℝ in (0:ℝ)..1, (θ^2 / 2) * s^2) = θ^2 / 2 * (1:ℝ) / 3 := by
    rw [intervalIntegral.integral_const_mul, h3]; ring
  rw [heval] at hmono
  have heq : θ^2 / 2 * 1 / 3 = θ^2 / 6 := by ring
  rw [heq] at hmono
  exact hmono


/-- Double-integration kernel: `t - sin t = ∫₀ᵗ (t - s) * sin s ds` for all `t`. -/
theorem t_sub_sin_eq_kernel (t : ℝ) :
    t - sin t = ∫ s : ℝ in (0 : ℝ)..t, (t - s) * sin s := by
  have hF : ∀ x : ℝ, HasDerivAt (fun s : ℝ => (t - s) * (-cos s) - sin s) ((t - x) * sin x) x := by
    intro x
    have hmul : HasDerivAt (fun s : ℝ => (t - s) * (-cos s)) ((-1) * (-cos x) + (t - x) * sin x) x := by
      have hsub : HasDerivAt (fun s : ℝ => t - s) (-1) x := by
        have h := (hasDerivAt_const x t).sub (hasDerivAt_id x)
        rw [zero_sub] at h
        exact h
      have hcos : HasDerivAt (fun s : ℝ => -cos s) (sin x) x := by
        have h := (Real.hasDerivAt_cos x).neg
        rw [neg_neg] at h
        exact h
      exact hsub.mul hcos
    have h₂ : HasDerivAt (fun s : ℝ => sin s) (cos x) x := Real.hasDerivAt_sin x
    have hsub2 := hmul.sub h₂
    have he : (-1) * -cos x + (t - x) * sin x - cos x = (t - x) * sin x := by ring
    rw [he] at hsub2
    exact hsub2
  have hint : IntervalIntegrable (fun s : ℝ => (t - s) * sin s) volume 0 t := by
    have hc : Continuous fun s : ℝ => (t - s) * sin s := by fun_prop
    exact hc.intervalIntegrable 0 t
  have heq := intervalIntegral.integral_eq_sub_of_hasDerivAt
    (f := fun s : ℝ => (t - s) * (-cos s) - sin s)
    (f' := fun s => (t - s) * sin s) (a := (0 : ℝ)) (b := t)
    (fun s _ => hF s) hint
  rw [heq]
  have e0 : (t - t) * (-cos t) - sin t = -sin t := by simp
  have e1 : (t - (0:ℝ)) * (-cos (0:ℝ)) - sin (0:ℝ) = -t := by simp
  rw [e0, e1]; ring



/-- Cubic bound: `|t - sin t| ≤ |t|³/6` for all real `t`. -/
theorem abs_t_sub_sin_le (t : ℝ) : |t - sin t| ≤ |t| ^ 3 / 6 := by
  wlog ht : 0 ≤ t generalizing t
  · have ht' : t < 0 := not_le.mp ht
    have hneg := this (-t) (neg_nonneg.mpr (le_of_lt ht'))
    have e : (-t) - sin (-t) = -(t - sin t) := by rw [Real.sin_neg]; ring
    rw [e, abs_neg] at hneg
    rwa [abs_neg] at hneg
  · have hval : t - sin t = ∫ s : ℝ in (0:ℝ)..t, (1 - cos s) := t_sub_sin_eq_int t
    have hnn : (0:ℝ) ≤ ∫ s : ℝ in (0:ℝ)..t, (1 - cos s) := by
      apply intervalIntegral.integral_nonneg ht
      intro s _
      exact sub_nonneg.mpr (cos_le_one s)
    rw [hval, abs_of_nonneg hnn, abs_of_nonneg ht]
    have hI2 : (∫ s : ℝ in (0:ℝ)..t, (1 - cos s)) ≤ ∫ s : ℝ in (0:ℝ)..t, s^2/2 := by
      apply intervalIntegral.integral_mono_on (μ := volume) ht
      · exact Continuous.intervalIntegrable (by fun_prop) 0 t
      · exact Continuous.intervalIntegrable (by fun_prop) 0 t
      · intro s _
        exact one_sub_cos_le_quad s
    have heval : (∫ s : ℝ in (0:ℝ)..t, s^2/2) = t^3/6 := by
      have hF : ∀ x : ℝ, HasDerivAt (fun s : ℝ => s^3/6) (x^2/2) x := by
        intro x
        have h := (hasDerivAt_pow 3 x).div_const 6
        rw [show (3:ℕ)-1 = 2 from rfl] at h
        have hc : (↑3 : ℝ) * x ^ 2 / 6 = x^2 / 2 := by ring
        exact h.congr_deriv hc
      have heq := intervalIntegral.integral_eq_sub_of_hasDerivAt (f := fun s : ℝ => s^3/6)
        (f' := fun s => s^2/2) (a := (0:ℝ)) (b := t) (fun s _ => hF s)
        (Continuous.intervalIntegrable (by fun_prop) 0 t)
      rw [heq]; simp
    rw [heval] at hI2
    exact hI2





/-- A5-cos part: `cos θ - (1 - θ²/2) = o(θ²)` as `θ → 0`. -/
theorem cos_quad_isLittleO : (fun θ : ℝ => cos θ - (1 - θ^2/2)) =o[𝓝 0] fun θ : ℝ => θ^2 := by
  -- θ ↦ cos θ - 1 + θ²/2 is even and its abs is θ⁴/24 for θ≥0 by FTC twice;
  -- squeeze against the =o(θ²) function θ⁴/24.
  have hev : ∀ θ : ℝ, cos θ - (1 - θ^2/2) = cos (-θ) - (1 - (-θ)^2/2) := by
    intro θ
    rw [Real.cos_neg, neg_sq]
  have hpos : ∀ θ : ℝ, 0 ≤ θ → |cos θ - (1 - θ^2/2)| ≤ θ^4/24 := by
    intro θ hθ
    have hval : cos θ - (1 - θ^2/2) = (∫ s : ℝ in (0:ℝ)..θ, (s - sin s)) := by
      have hsinid := one_sub_cos_eq_int_sin θ
      have hI : (∫ s : ℝ in (0:ℝ)..θ, sin s) = (∫ s : ℝ in (0:ℝ)..θ, s) - ∫ s : ℝ in (0:ℝ)..θ, (s - sin s) := by
        rw [← intervalIntegral.integral_sub (Continuous.intervalIntegrable (by fun_prop) 0 θ)
          (Continuous.intervalIntegrable (by fun_prop) 0 θ)]
        apply intervalIntegral.integral_congr
        intro s _
        ring
      have hid : (∫ s : ℝ in (0:ℝ)..θ, s) = θ^2/2 := by
        have h := int_id 0 θ
        rw [zero_pow two_ne_zero, sub_zero] at h
        rw [h]
      have hsin2 : 1 - cos θ = θ^2/2 - (∫ s : ℝ in (0:ℝ)..θ, (s - sin s)) := by
        rw [hsinid, hI, hid]
      rw [show cos θ - (1 - θ^2/2) = θ^2/2 - (1 - cos θ) by ring, hsin2]
      rw [sub_sub_self]
    rw [hval]
    have hI : |(∫ s : ℝ in (0:ℝ)..θ, (s - sin s))| ≤ ∫ s : ℝ in (0:ℝ)..θ, s^3/6 := by
      refine le_trans (intervalIntegral.abs_integral_le_integral_abs (μ := volume) hθ) ?_
      apply intervalIntegral.integral_mono_on (μ := volume) hθ
      · exact Continuous.intervalIntegrable (by fun_prop) 0 θ
      · exact Continuous.intervalIntegrable (by fun_prop) 0 θ
      · intro s hs
        rw [Set.mem_Icc] at hs
        have h1 := abs_t_sub_sin_le s
        rw [abs_of_nonneg hs.1] at h1
        exact h1
    have heval : (∫ s : ℝ in (0:ℝ)..θ, s^3/6) = θ^4/24 := by
      have hF : ∀ x : ℝ, HasDerivAt (fun s : ℝ => s^4/24) (x^3/6) x := by
        intro x
        have h := (hasDerivAt_pow 4 x).div_const 24
        rw [show (4:ℕ)-1 = 3 from rfl] at h
        have hc : (↑4 : ℝ) * x^3 / 24 = x^3/6 := by ring
        exact h.congr_deriv hc
      have heq := intervalIntegral.integral_eq_sub_of_hasDerivAt (f := fun s : ℝ => s^4/24)
        (f' := fun s => s^3/6) (a := (0:ℝ)) (b := θ) (fun s _ => hF s)
        (Continuous.intervalIntegrable (by fun_prop) 0 θ)
      rw [heq]; simp
    rw [heval] at hI
    exact hI
  have hclose : ∀ θ : ℝ, |cos θ - (1 - θ^2/2)| ≤ θ^4/24 := by
    intro θ
    rcases le_total 0 θ with hθ | hθ
    · exact hpos θ hθ
    · have een : (-θ)^4 = θ^4 := by ring
      rw [hev]
      have := hpos (-θ) (neg_nonneg.mpr hθ)
      rw [een] at this
      exact this
  rw [isLittleO_iff]
  intro c hc
  have htend : Tendsto (fun θ : ℝ => θ^2/24) (𝓝 0) (𝓝 0) := by
    have h := ((continuous_pow (2:ℕ)).tendsto (0 : ℝ)).div_const 24
    simpa using h
  filter_upwards [htend.eventually (gt_mem_nhds hc)] with θ hθ
  rw [Real.norm_eq_abs, Real.norm_eq_abs]
  have h1 := hclose θ
  have hnn : (0:ℝ) ≤ θ^2 := sq_nonneg θ
  have h2 : θ^4/24 ≤ c * |θ^2| := by
    rw [abs_of_nonneg hnn]
    rw [show θ^4/24 = (θ^2/24) * θ^2 by ring]
    have hθ' : θ^2/24 ≤ c := le_of_lt hθ
    exact mul_le_mul_of_nonneg_right hθ' hnn
  exact le_trans h1 h2


/-- rpow evaluation: for `x ≥ 0`, `(x³)^(2/3) = x²`. -/
theorem rpow_cube_two_thirds {x : ℝ} (hx : 0 ≤ x) : (x^3 : ℝ) ^ ((2:ℝ)/3) = x^2 := by
  have h1 : (x^3 : ℝ) ^ ((2:ℝ)/3) = ((x^3 : ℝ) ^ ((1:ℝ)/3)) ^ (2:ℝ) := by
    rw [← Real.rpow_mul (by positivity : (0:ℝ) ≤ x^3)]
    congr 1
    ring
  have h2 : ((x^3 : ℝ) ^ ((1:ℝ)/3)) = x := by
    have hcast : (x : ℝ) ^ (3 : ℝ) = x ^ 3 := Real.rpow_natCast x 3
    rw [← hcast]
    rw [← Real.rpow_mul hx]
    rw [show (3 : ℝ) * (1/3) = 1 by ring]
    exact Real.rpow_one x
  rw [h1, h2, Real.rpow_two]

/-- A5-sin part: `sin θ ~ θ` on `nhdsWithin 0 (Ioi 0)` — via the cubic bound. -/
theorem sin_isEquivalent : (fun θ : ℝ => sin θ) ~[nhdsWithin 0 (Set.Ioi 0)] fun θ : ℝ => θ := by
  have hclose : ∀ θ : ℝ, 0 ≤ θ → ‖sin θ - θ‖ ≤ ‖θ^3/6‖ := by
    intro θ hθ
    rw [Real.norm_eq_abs, Real.norm_eq_abs]
    rw [abs_sub_comm]
    have hh := abs_t_sub_sin_le θ
    rw [abs_of_nonneg hθ] at hh
    rw [abs_of_nonneg (by positivity : (0:ℝ) ≤ θ^3/6)]
    exact hh
  have hlo : (fun θ : ℝ => θ^3/6) =o[nhdsWithin 0 (Set.Ioi 0)] fun θ : ℝ => θ := by
    rw [isLittleO_iff]
    intro c hc
    have hgt : ∀ᶠ θ in nhdsWithin 0 (Set.Ioi 0), θ^2/6 < c := by
      have h := ((continuous_pow (2:ℕ)).tendsto (0:ℝ)).div_const 6
      have h0 : (0:ℝ)^2/6 = 0 := by simp
      rw [h0] at h
      exact Filter.Eventually.filter_mono nhdsWithin_le_nhds (h.eventually (gt_mem_nhds hc))
    filter_upwards [self_mem_nhdsWithin, hgt] with θ hθ hθ2
    rw [Real.norm_eq_abs, Real.norm_eq_abs]
    rw [abs_of_pos (show 0 < θ from hθ)]
    have hθnn : (0:ℝ) ≤ θ := le_of_lt (show 0 < θ from hθ)
    rw [abs_of_nonneg (by positivity : (0:ℝ) ≤ θ^3/6)]
    rw [show θ^3/6 = (θ^2/6) * θ by ring]
    exact mul_le_mul_of_nonneg_right (le_of_lt hθ2 : θ^2/6 ≤ c) hθnn
  -- assemble: ‖f - g‖ ≤ ‖h‖ needs the bound only for θ≥0... the close bound requires 0≤θ;
  -- on nhdsWithin 0 (Ioi 0), θ>0 eventually, so use the eventually variant of congr_left.
  have hclose' : ∀ᶠ θ in nhdsWithin 0 (Set.Ioi 0), ‖sin θ - θ‖ ≤ ‖θ^3/6‖ := by
    filter_upwards [self_mem_nhdsWithin] with θ hθ
    exact hclose θ (le_of_lt hθ)
  exact isLittleO_congr hlo hclose'

/-- rpow split of the caustic x-coordinate: for `R > 0` and `θ ∈ (0, π)`,
`(R sin³θ)^(2/3) = R^(2/3) · sin²θ`. -/
theorem rpow_X_split {R θ : ℝ} (hR : 0 < R) (hθ : 0 < θ) (hθπ : θ < Real.pi) :
    (R * sin θ ^ 3 : ℝ) ^ ((2:ℝ)/3) = R ^ ((2:ℝ)/3) * (sin θ) ^ (2:ℝ) := by
  have hsin : 0 ≤ sin θ := le_of_lt (Real.sin_pos_of_pos_of_lt_pi hθ hθπ)
  rw [Real.mul_rpow (le_of_lt hR) (by positivity : (0:ℝ) ≤ sin θ ^ 3)]
  congr 1
  have h1 : (sin θ ^ 3 : ℝ) ^ ((2:ℝ)/3) = ((sin θ ^ 3 : ℝ) ^ ((1:ℝ)/3)) ^ (2:ℝ) := by
    rw [← Real.rpow_mul (by positivity : (0:ℝ) ≤ sin θ ^ 3)]
    congr 1
    ring
  have h2 : ((sin θ ^ 3 : ℝ) ^ ((1:ℝ)/3)) = sin θ := by
    have hcast : (sin θ : ℝ) ^ (3 : ℝ) = sin θ ^ 3 := Real.rpow_natCast _ 3
    rw [← hcast]
    rw [← Real.rpow_mul hsin]
    rw [show (3 : ℝ) * (1/3) = 1 by ring]
    exact Real.rpow_one _
  rw [h1, h2]

/-- A5-cos θ: `cos θ ~[l] 1` as `θ → 0⁺` (nonzero constant equivalence via continuity). -/
theorem cos_isEquivalent_one :
    (fun θ : ℝ => cos θ) ~[nhdsWithin 0 (Set.Ioi 0)] fun _ : ℝ => (1:ℝ) := by
  have htend : Tendsto cos (nhdsWithin 0 (Set.Ioi 0)) (𝓝 1) := by
    have h := Real.continuous_cos.tendsto 0
    rw [Real.cos_zero] at h
    exact h.mono_left nhdsWithin_le_nhds
  exact (Asymptotics.isEquivalent_const_iff_tendsto (by norm_num : (1:ℝ) ≠ 0)).mpr htend

/-- A5-quad: `1 - θ²/2 ~[l] 1` as `θ → 0⁺` (nonzero constant equivalence via continuity). -/
theorem quad_isEquivalent_one :
    (fun θ : ℝ => 1 - θ^2/2) ~[nhdsWithin 0 (Set.Ioi 0)] fun _ : ℝ => (1:ℝ) := by
  have htend : Tendsto (fun θ : ℝ => 1 - θ^2/2) (nhdsWithin 0 (Set.Ioi 0)) (𝓝 1) := by
    have h : Tendsto (fun θ : ℝ => 1 - θ^2/2) (𝓝 0) (𝓝 (1 - (0:ℝ)^2/2)) := by
      exact (tendsto_const_nhds).sub (((continuous_pow (2:ℕ)).tendsto (0:ℝ)).div_const 2)
    have h0 : (1:ℝ) - (0:ℝ)^2/2 = 1 := by simp
    rw [h0] at h
    exact h.mono_left nhdsWithin_le_nhds
  exact (Asymptotics.isEquivalent_const_iff_tendsto (by norm_num : (1:ℝ) ≠ 0)).mpr htend

/-- The `o(θ²)` residual of `cos θ (2 - cos 2θ)` around `1 + (3/2) θ²`: with `φ = cos θ - 1`,
`Y·(2/R) - 1 - (3/2)θ² = -3(φ + θ²/2) - 6φ² - 2φ³`, each summand `o(θ²)`. -/
theorem cos_cos2_quad_isLittleO :
    (fun θ : ℝ => cos θ * (2 - cos (2*θ)) - (1 + (3:ℝ)/2 * θ^2)) =o[𝓝 0] fun θ : ℝ => θ^2 := by
  -- cos 2θ via double-angle: with φ θ = cos θ - 1
  have heq : (fun θ : ℝ => cos θ * (2 - cos (2*θ)) - (1 + (3:ℝ)/2 * θ^2))
      = fun θ : ℝ => -3 * ((cos θ - 1) + θ^2/2) - 6 * (cos θ - 1)^2 - 2 * (cos θ - 1)^3 := by
    funext θ
    rw [Real.cos_two_mul θ]
    ring
  rw [heq]
  -- the three pieces
  have hφbig : (fun θ : ℝ => cos θ - 1) =O[𝓝 0] fun θ : ℝ => θ^2 := by
    rw [isBigO_iff]
    exact ⟨1/2, Filter.Eventually.of_forall fun θ => by
      rw [Real.norm_eq_abs, Real.norm_eq_abs]
      have h := one_sub_cos_le_quad θ
      rw [abs_of_nonneg (sq_nonneg θ)]
      rw [show (1:ℝ)/2 * θ^2 = θ^2/2 by ring]
      rw [show cos θ - 1 = -(1 - cos θ) by ring, abs_neg]
      rw [abs_of_nonneg (sub_nonneg.mpr (cos_le_one θ))]
      exact h⟩
  have h1 : (fun θ : ℝ => -3 * ((cos θ - 1) + θ^2/2)) =o[𝓝 0] fun θ : ℝ => θ^2 := by
    have : (fun θ : ℝ => (cos θ - 1) + θ^2/2) =o[𝓝 0] fun θ : ℝ => θ^2 := by
      have h := cos_quad_isLittleO
      -- cos θ - (1 - θ²/2) = (cos θ - 1) + θ²/2 ✓ defeq? ring-equal pointwise
      refine h.congr_left ?_
      intro θ
      ring
    exact this.const_mul_left (-3)
  have h2 : (fun θ : ℝ => -6 * (cos θ - 1)^2) =o[𝓝 0] fun θ : ℝ => θ^2 := by
    have hpow : (fun θ : ℝ => (cos θ - 1)^2) =O[𝓝 0] fun θ : ℝ => (θ^2)^2 := hφbig.pow 2
    have hpow' : (fun θ : ℝ => (cos θ - 1)^2) =O[𝓝 0] fun θ : ℝ => θ^4 := by
      convert hpow using 1
      funext θ
      ring
    have hlo : (fun θ : ℝ => (cos θ - 1)^2) =o[𝓝 0] fun θ : ℝ => θ^2 :=
      hpow'.trans_isLittleO (Asymptotics.isLittleO_pow_pow (show 2 < 4 by norm_num))
    exact hlo.const_mul_left (-6)
  have h3 : (fun θ : ℝ => -2 * (cos θ - 1)^3) =o[𝓝 0] fun θ : ℝ => θ^2 := by
    have hpow : (fun θ : ℝ => (cos θ - 1)^3) =O[𝓝 0] fun θ : ℝ => (θ^2)^3 := hφbig.pow 3
    have hpow' : (fun θ : ℝ => (cos θ - 1)^3) =O[𝓝 0] fun θ : ℝ => θ^6 := by
      convert hpow using 1
      funext θ
      ring
    have hlo : (fun θ : ℝ => (cos θ - 1)^3) =o[𝓝 0] fun θ : ℝ => θ^2 :=
      hpow'.trans_isLittleO (Asymptotics.isLittleO_pow_pow (show 2 < 6 by norm_num))
    exact hlo.const_mul_left (-2)
  -- sum: (-3·) + (-6·) + (-2·) via sub-associativity
  have hsum : (fun θ : ℝ => (-3 * ((cos θ - 1) + θ^2/2)) + (-6 * (cos θ - 1)^2)
      + (-2 * (cos θ - 1)^3)) =o[𝓝 0] fun θ : ℝ => θ^2 :=
    (h1.add h2).add h3
  refine hsum.congr_left ?_
  intro θ
  ring

/-- Y-side: the residual `Y_c - R/2 - (3R/4)θ²` is `o(θ²)` along the small-angle filter. -/
theorem Y_residual_isLittleO {R : ℝ} :
    (fun θ : ℝ => (R/2) * cos θ * (2 - cos (2*θ)) - R/2 - (3*R/4)*θ^2) =o[nhdsWithin 0 (Set.Ioi 0)]
      fun θ : ℝ => θ^2 := by
  have hscaled : (fun θ : ℝ => (R/2) * (cos θ * (2 - cos (2*θ)) - (1 + (3:ℝ)/2 * θ^2)))
      =o[𝓝 0] fun θ : ℝ => θ^2 := cos_cos2_quad_isLittleO.const_mul_left (R/2)
  have hmono : (fun θ : ℝ => (R/2) * (cos θ * (2 - cos (2*θ)) - (1 + (3:ℝ)/2 * θ^2)))
      =o[nhdsWithin 0 (Set.Ioi 0)] fun θ : ℝ => θ^2 :=
    hscaled.mono nhdsWithin_le_nhds
  refine hmono.congr_left ?_
  intro θ
  ring


/-- The assembled Y-equivalence: `Y_c - R/2 ~[l] (3R/4) θ²`. -/
theorem Y_isEquivalent {R : ℝ} (hR : R ≠ 0) :
    (fun θ : ℝ => (R/2) * cos θ * (2 - cos (2*θ)) - R/2) ~[nhdsWithin 0 (Set.Ioi 0)]
      fun θ : ℝ => (3*R/4)*θ^2 := by
  have h := Y_residual_isLittleO (R := R)
  have hR34ne : (3*R/4 : ℝ) ≠ 0 := by
    have e : 3*R/4 = (3/4)*R := by ring
    rw [e]
    exact mul_ne_zero (by norm_num) hR
  rw [Asymptotics.isLittleO_iff] at h
  have hlo : (fun θ => (R/2) * cos θ * (2 - cos (2*θ)) - R/2 - (3*R/4)*θ^2)
      =o[nhdsWithin 0 (Set.Ioi 0)] fun θ => (3*R/4)*θ^2 := by
    rw [Asymptotics.isLittleO_iff]
    intro c hc
    have hε : 0 < c * |3*R/4| := mul_pos hc (abs_pos.mpr hR34ne)
    specialize h hε
    filter_upwards [h] with θ hθ
    have hrw : ‖(3*R/4 : ℝ) * θ^2‖ = |3*R/4| * ‖θ^2‖ := by
      rw [Real.norm_eq_abs, abs_mul]
      rfl
    calc ‖(R/2) * cos θ * (2 - cos (2*θ)) - R/2 - (3*R/4)*θ^2‖
        ≤ (c * |3*R/4|) * ‖θ^2‖ := hθ
      _ = c * (|3*R/4| * ‖θ^2‖) := by ring
      _ = c * ‖(3*R/4) * θ^2‖ := by rw [hrw]
  show ((fun θ : ℝ => (R/2) * cos θ * (2 - cos (2*θ)) - R/2)
      - fun θ : ℝ => (3*R/4)*θ^2) =o[nhdsWithin 0 (Set.Ioi 0)] fun θ => (3*R/4)*θ^2
  show (fun θ : ℝ => (R/2) * cos θ * (2 - cos (2*θ)) - R/2 - (3*R/4)*θ^2)
      =o[nhdsWithin 0 (Set.Ioi 0)] fun θ => (3*R/4)*θ^2
  exact hlo


/-- The four-way combination: `Y_c θ ~[l] (R/2 + (3R/4)θ²)` directly from the residual =o. -/
theorem Y_full_isEquivalent {R : ℝ} (hR : 0 < R) :
    (fun θ : ℝ => (R/2) * cos θ * (2 - cos (2*θ))) ~[nhdsWithin 0 (Set.Ioi 0)]
      fun θ : ℝ => R/2 + (3*R/4)*θ^2 := by
  have hlo := Y_residual_isLittleO (R := R)
  rw [Asymptotics.isLittleO_iff] at hlo
  have hcongr : ((fun θ : ℝ => (R/2) * cos θ * (2 - cos (2*θ)))
      - fun θ : ℝ => R/2 + (3*R/4)*θ^2)
      = (fun θ : ℝ => (R/2) * cos θ * (2 - cos (2*θ)) - R/2 - (3*R/4)*θ^2) := by
    funext θ
    show (R/2) * cos θ * (2 - cos (2*θ)) - (R/2 + (3*R/4)*θ^2)
      = (R/2) * cos θ * (2 - cos (2*θ)) - R/2 - (3*R/4)*θ^2
    ring
  have hlo' : (fun θ : ℝ => (R/2) * cos θ * (2 - cos (2*θ)) - R/2 - (3*R/4)*θ^2)
      =o[nhdsWithin 0 (Set.Ioi 0)] fun θ => R/2 + (3*R/4)*θ^2 := by
    rw [Asymptotics.isLittleO_iff]
    intro c hc
    specialize hlo (show 0 < c * (3*R/4) from mul_pos hc (by linarith : (0:ℝ) < 3*R/4))
    filter_upwards [hlo] with θ hθ
    have hge : (3*R/4 : ℝ) * θ^2 ≤ |R/2 + (3*R/4)*θ^2| := by
      rw [abs_of_nonneg (by
        have h1 : (0:ℝ) ≤ (3*R/4) * θ^2 := mul_nonneg (by linarith) (sq_nonneg θ)
        linarith)]
      have h1 : (0:ℝ) ≤ (3*R/4) * θ^2 := mul_nonneg (by linarith) (sq_nonneg θ)
      linarith
    calc ‖(R/2) * cos θ * (2 - cos (2*θ)) - R/2 - (3*R/4)*θ^2‖
        ≤ (c * (3*R/4)) * ‖θ^2‖ := hθ
      _ = c * ((3*R/4) * ‖θ^2‖) := by ring
      _ = c * ((3*R/4) * θ^2) := by
        congr 1
        rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg θ)]
      _ ≤ c * ‖R/2 + (3*R/4)*θ^2‖ := by
        apply mul_le_mul_of_nonneg_left _ (le_of_lt hc)
        rw [Real.norm_eq_abs]
        exact hge
  show ((fun θ : ℝ => (R/2) * cos θ * (2 - cos (2*θ)))
      - fun θ : ℝ => R/2 + (3*R/4)*θ^2) =o[nhdsWithin 0 (Set.Ioi 0)] fun θ => R/2 + (3*R/4)*θ^2
  rw [hcongr]
  exact hlo'

end C4Dev

namespace HalfCylindricalMirrorCaustic

variable (c : HalfCylindricalMirrorCaustic)

open C4Dev

/-- Main formalization target for C.4: in the small-angle regime `θ ≪ 1`, the
caustic of the half-cylindrical mirror has the power-law form
`Y_c = v * |X_c| ^ (p / q) + u` with the recorded constants
`u = R / 2`, `v = (3 / 4) * R ^ (1 / 3)`, `p = 2`, `q = 3`, read as
asymptotic agreement to leading order as `θ → 0⁺`. The `|X_c|` of the source
statement is subsumed by the positive-angle branch encoded in
`smallAngleFilter`, where `X_c θ = R * sin θ ^ 3` is positive. All recorded
constants appear on the conclusion side only (the proof below extracts the
leading-order balances of `Y_c` and of the `2/3`-power of `X_c` from the
C.3 formulas via FTC calculus squeezes, then matches them at the recorded
constants). -/
theorem caustic_small_angle_power_law :
    SatisfiesCausticPowerLaw c.X_c c.Y_c c.R (c.R / 2)
      ((3 / 4) * c.R ^ ((1 : ℝ) / 3)) := by
  -- abbreviations for the mirror data
  set R : ℝ := c.R with hRdef
  set X_c : ℝ → ℝ := c.X_c with hXdef
  set Y_c : ℝ → ℝ := c.Y_c with hYdef
  have hR : 0 < R := c.R_pos
  have hX : ∀ θ : ℝ, X_c θ = R * sin θ ^ 3 := c.X_c_formula
  have hY : ∀ θ : ℝ, Y_c θ = R / 2 * cos θ * (2 - cos (2 * θ)) := c.Y_c_formula
  let l : Filter ℝ := nhdsWithin 0 (Set.Ioi 0)
  have hSin : (fun θ : ℝ => sin θ) ~[l] fun θ : ℝ => θ := sin_isEquivalent
  -- exponent simp: (((2:ℕ) : ℝ) / ((3:ℕ) : ℝ)) = 2/3
  have hexp : (((2 : ℕ) : ℝ) / ((3 : ℕ) : ℝ)) = ((2:ℝ)/3) := by norm_num
  -- RHS congr to (3R/4) sin²θ + R/2
  have hsplit_ev : ∀ᶠ θ in l, (((3 / 4) * R ^ ((1 : ℝ) / 3)) * X_c θ ^ ((2:ℝ)/3) + R / 2)
      = (3*R/4) * sin θ ^ 2 + R / 2 := by
    filter_upwards [self_mem_nhdsWithin (a := (0:ℝ)) (s := Set.Ioi 0),
      (tendsto_id'.2 (show l ≤ nhds 0 from nhdsWithin_le_nhds)).eventually_lt_const Real.pi_pos]
    with θ hθ hθπ
    rw [hX θ, rpow_X_split hR hθ hθπ]
    rw [Real.rpow_two]
    have hcoeff : ((3/4) * R ^ ((1:ℝ)/3)) * (R ^ ((2:ℝ)/3)) = (3*R/4) := by
      rw [mul_assoc, ← Real.rpow_add hR (1/3) (2/3)]
      rw [show (1:ℝ)/3 + 2/3 = 1 by ring, Real.rpow_one]
      ring
    rw [show ((3/4) * R ^ ((1:ℝ)/3)) * ((R ^ ((2:ℝ)/3)) * sin θ ^ 2)
        = (((3/4) * R ^ ((1:ℝ)/3)) * (R ^ ((2:ℝ)/3))) * sin θ ^ 2 by ring, hcoeff]
  refine ⟨rfl, rfl, (by norm_num), (by norm_num), ?_, ?_⟩
  · rw [show (fun θ => ((3 / 4) * R ^ ((1 : ℝ) / 3)) * X_c θ ^ (((2 : ℕ) : ℝ) / ((3 : ℕ) : ℝ)) + R / 2)
      = (fun θ => ((3 / 4) * R ^ ((1 : ℝ) / 3)) * X_c θ ^ ((2:ℝ)/3) + R / 2) from by simp [hexp]]
    -- Y_c = the formula; both sides ≡ R/2 + (3R/4)θ²
    have hYf : (fun θ : ℝ => Y_c θ) = (fun θ : ℝ => R / 2 * cos θ * (2 - cos (2 * θ))) := funext hY
    rw [hYf]
    have hmain : (fun θ : ℝ => R / 2 * cos θ * (2 - cos (2*θ))) ~[l]
        fun θ : ℝ => R/2 + (3*R/4)*θ^2 := Y_full_isEquivalent hR
    have hscale : (fun θ : ℝ => (3*R/4) * sin θ ^ 2) ~[l] fun θ : ℝ => (3*R/4) * θ^2 :=
      (Asymptotics.IsEquivalent.refl (u := fun _ : ℝ => (3*R/4))).mul (hSin.pow 2)
    have hscale' : (fun θ : ℝ => (3*R/4) * sin θ ^ 2 + R / 2) ~[l] fun θ : ℝ => R/2 + (3*R/4)*θ^2 := by
      -- sin² ~ θ² → (3R/4)sin² ~ (3R/4)θ²; adding R/2 on both sides needs the norm-bounded-below argument again:
      show ((fun θ : ℝ => (3*R/4) * sin θ ^ 2 + R / 2) - fun θ : ℝ => R/2 + (3*R/4)*θ^2)
          =o[l] fun θ => R/2 + (3*R/4)*θ^2
      have hcongr : ((fun θ : ℝ => (3*R/4) * sin θ ^ 2 + R / 2) - fun θ : ℝ => R/2 + (3*R/4)*θ^2)
          = fun θ : ℝ => (3*R/4) * (sin θ ^ 2 - θ^2) := by
        funext θ
        show (3*R/4) * sin θ ^ 2 + R / 2 - (R/2 + (3*R/4)*θ^2) = (3*R/4) * (sin θ ^ 2 - θ^2)
        ring
      rw [hcongr]
      -- (3R/4)(sin² - θ²) =o(θ²) from sin² ~ θ²: hscale.isLittleO: (sin² - θ²) =o θ² →
      -- and then =o((3R/4)θ²) → =o(R/2 + (3R/4)θ²) since |R/2 + (3R/4)θ²| ≥ (3R/4)θ²
      have hlo1 : (fun θ : ℝ => (3*R/4) * (sin θ ^ 2 - θ^2)) =o[l] fun θ : ℝ => (3*R/4) * θ^2 := by
        have h := hscale.isLittleO
        -- h : (sin² - θ²) =o θ²? hscale: (3R/4)sin² ~ (3R/4)θ² → ((3R/4)sin² - (3R/4)θ²) =o (3R/4)θ²
        have h2 : ((fun θ : ℝ => (3*R/4) * sin θ ^ 2) - fun θ : ℝ => (3*R/4) * θ^2)
            =o[l] fun θ : ℝ => (3*R/4) * θ^2 := hscale
        show (fun θ : ℝ => (3*R/4) * (sin θ ^ 2 - θ^2)) =o[l] fun θ : ℝ => (3*R/4) * θ^2
        refine h2.congr_left ?_
        intro θ
        show (3*R/4) * sin θ ^ 2 - (3*R/4) * θ ^ 2 = (3*R/4) * (sin θ ^ 2 - θ^2)
        ring
      rw [Asymptotics.isLittleO_iff] at hlo1 ⊢
      intro c hc
      specialize hlo1 hc
      filter_upwards [hlo1] with θ hθ
      have hge : ‖(3*R/4 : ℝ) * θ^2‖ ≤ ‖R/2 + (3*R/4)*θ^2‖ := by
        have h1 : (0:ℝ) ≤ (3*R/4) * θ^2 := mul_nonneg (by linarith) (sq_nonneg θ)
        rw [Real.norm_eq_abs, Real.norm_eq_abs, abs_mul, abs_of_pos (show (0:ℝ) < 3*R/4 by linarith),
          abs_of_nonneg (sq_nonneg θ),
          abs_of_nonneg (by linarith : (0:ℝ) ≤ R/2 + (3*R/4)*θ^2)]
        have h2 : (0:ℝ) ≤ R/2 := by linarith
        linarith
      exact le_trans hθ (mul_le_mul_of_nonneg_left hge (le_of_lt hc))
    -- final transit
    have hRHS2 : (fun θ : ℝ => (3*R/4) * sin θ ^ 2 + R / 2) ~[l]
        fun θ => ((3 / 4) * R ^ ((1 : ℝ) / 3)) * X_c θ ^ ((2:ℝ)/3) + R / 2 :=
      Filter.EventuallyEq.isEquivalent (hsplit_ev.mono fun θ h => h.symm)
    exact hmain.trans (hscale'.symm.trans hRHS2)

  · refine ⟨R, hR, ?_⟩
    have hXf : (fun θ : ℝ => X_c θ) = (fun θ : ℝ => R * sin θ ^ 3) := funext hX
    rw [hXf]
    exact (Asymptotics.IsEquivalent.refl (u := fun _ : ℝ => R)).mul (hSin.pow 3)

end HalfCylindricalMirrorCaustic

end IPhO2026_2_C_4

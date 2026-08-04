/-
IPhO 2026, Theoretical Problem 2 (Solar Cooker), Part B.2 — autoformalization
(redrafted iter-011 after Proof-Review route `underdetermined_contract`).

Physical situation (Figure 2f). A half-hollow-cylinder mirror of radius `R`
(mirrored on the inside, aperture of width `2 R`) is illuminated by uniform
parallel sunlight arriving along the mirror's optical axis. A fully absorbing
cylindrical container of radius `a` has its axis parallel to the mirror axis;
its centre lies `R / 2` from the mirror centre on the system's symmetry plane
(along the optical axis, Figure 2f). Sunlight has constant, uniform intensity;
`a` is such that any ray absorbed by the container reflects from the mirror
at most once. `θ_max` is the maximum angle of incidence on the mirror
(measured with respect to the normal drawn at the point of incidence) of any
reflected ray striking the container, and `P₀` is the power the cylinder
would receive if the mirror was not present.

Current subquestion (T2-B2): write `P / P₀` in terms of `θ_max`.

Recorded official answer: `P / P₀ = 1 / (1 - cos θ_max)`.

Physical resolution used by this formalization (root cause of the iter-010
review countermodel). Parametrize an incoming ray by its transverse impact
parameter `y` (offset along the in-plane normal `n`, perpendicular to the
light-travel axis `e`). For the ray reflected at mirror point `m` with
incidence angle `α`, the offset is `y = R sin α`; the reflected ray's
nearest-approach distance to the container centre `A = C + (R/2) • e` is
`R (sin α - (1/2) sin 2α)`, strictly increasing in `α ∈ (0, π/2)`. Hence the
absorbed rays form a TWO-SIDED contiguous band of impact parameters
`(-R sin θ_max, R sin θ_max)` around the axis: every ray with incidence
below `θ_max` passes closer to `A` than the (tangent) extreme ray and is
absorbed, and the extreme rays at `± θ_max` attain the maximum. The
collected transverse width is therefore `2 R sin θ_max`, and the
uniform-intensity accounting gives

  P / P₀ = (I · 2 R sin θ_max) / (I · 2 a)
         = 1 / (1 - cos θ_max)

by the B.1 calibration `a = R sin θ_max - (R / 2) sin (2 θ_max)`
(`= R sin θ_max (1 - cos θ_max)` after the double-angle identity) — the
recorded answer, valid for the whole θ_max family (consistency check with
B.3: `cos θ_max = 4/5` gives `2R·(3/5) / (2·3R/25) = 5` ✓).
The earlier one-sided `collectedWidth = R` model is physically wrong for
this configuration and is what made the previous contract underdetermined.

This file is a by-`sorry` formalization: faithful declarations with proof
bodies left as `sorry`. Modelled on a transverse cross-section (the problem
is translationally invariant along the cylinder axes), so the configuration
lives in `EuclideanSpace ℝ (Fin 2)` and every "power" below is a
power-per-unit-axis-length quantity; the common incoming intensity and the
common axial length cancel in the ratio `P / P₀`.

Governing physical laws (kept as hypotheses, never redefined locally):
specular reflection on the circular mirror profile, the offset container
geometry, single-bounce two-sided ray bookkeeping, the previous-part (B.1)
calibration, and the uniform-intensity width accounting for `P` and `P₀`.
-/

import Mathlib

open Real Set

noncomputable section

namespace IPhO2026_2_B_2

/-- Transverse cross-sectional plane of the cooker. The physical system is
translationally invariant along the cylinder axes, so a single cross-section
captures all the geometry; points have units of length. -/
abbrev Plane := EuclideanSpace ℝ (Fin 2)

/-- Dimensionful parameters of the cooker: mirror radius `R` and container
radius `a` (both lengths, hence positive). -/
structure CookerParams where
  R : ℝ
  a : ℝ
  hR : 0 < R
  ha : 0 < a

/-- Geometry of the cross-section (Figure 2f): mirror centre `C`, container
centre `A`, unit vector `e` along the optical axis pointing from `C` into
the bowl towards the container (sunlight travels along `+ e`, parallel to
the optical axis), and in-plane unit normal `n` (`n ⊥ e`). The container
centre lies `R / 2` from `C` along `e`, the cross-sectional image of the
symmetry plane: `A - C = (R / 2) • e`. The bundled fields record
`‖e‖ = 1`, `‖n‖ = 1`, `⟨n, e⟩ = 0`, and the offset law. -/
structure CookerGeometry (p : CookerParams) where
  C : Plane
  A : Plane
  e : Plane
  n : Plane
  e_unit : ‖e‖ = 1
  n_unit : ‖n‖ = 1
  n_perp_e : @inner ℝ _ _ n e = 0
  A_offset : A - C = (p.R / 2) • e

/-- The full circle of radius `R` centred at `C`: the cross-sectional profile
of the cylinder mirror. -/
def mirrorCircle (p : CookerParams) (g : CookerGeometry p) : Set Plane :=
  Metric.sphere g.C p.R

/-- The absorbing disc: cross-section of the cylindrical container. -/
def containerDisk (p : CookerParams) (g : CookerGeometry p) : Set Plane :=
  Metric.closedBall g.A p.a

/-- The half-cylinder mirror arc: the semi-circle of `mirrorCircle` lying in
the `0 ≤ ⟨m - C, e⟩` half-plane — the illuminated inner surface of the
"half-hollow-cylinder mirror" seen by the incoming rays. -/
def halfMirrorArc (p : CookerParams) (g : CookerGeometry p) : Set Plane :=
  {m ∈ mirrorCircle p g | 0 ≤ @inner ℝ _ _ (m - g.C) g.e}

/-- Single-bounce bookkeeping for the sun rays absorbed by the container.

Physical laws encoded (hypotheses, not definitions to be unfolded):
* `hitSet` parametrizes (via the transverse offset/impact parameter
  `y = ⟨incidentPt y - C, n⟩`) the incoming parallel rays that reach the
  mirror and then strike the container; `on_mirror` places every incidence
  point on the half-cylinder arc.
* `reflected_point_law` is specular reflection on the circular profile
  (normal `R⁻¹ • (m - C)` at mirror point `m`): an incoming ray with
  direction `e` reflecting at `m` leaves along
  `e - 2 R⁻² ⟨m - C, e⟩ • (m - C)`, and the reflected ray reaches an
  absorbed endpoint `q` in the container disc — with the bounding property
  needed for the width accounting: writing
  `y e = ⟨incidentPt y - C, e⟩` and `y n = ⟨incidentPt y - C, n⟩` (so
  `y n = y`, `y e ≥ 0`, `y e² + y n² = R²` on the mirror), the reflected
  endpoint's transverse offset equals
  `y n · (2 y e² / R² - 1) = y · (2 y e² / R² - 1)`, an odd, strictly
  increasing function of `y` on `(-R, R)` — hence the absorbed offsets form
  a symmetric band whose half-width equals the extreme absorbed offset.
* `hitSet_Ioo`, `hit_offsets_fill`: Figure-2f branch/coverage data — the
  impact parameters of absorbed rays fill an open symmetric band
  `(-yOff, yOff)` and their transverse offsets realize the whole band, so
  the collected fan is the full two-sided family of Figure 2f and `θ_max`
  is attained (as an endpoint maximum) at both edges. -/
structure AbsorbedRays (p : CookerParams) (g : CookerGeometry p) where
  /-- Incidence point on the mirror of the absorbed ray whose transverse
  impact parameter is `y`. -/
  incidentPt : ℝ → Plane
  /-- Impact parameters of rays that are absorbed by the container. -/
  hitSet : Set ℝ
  /-- Compatibility of the parametrization: the label `y` is exactly the
  transverse readout `⟨incidentPt y - C, n⟩` of the incidence point. -/
  readout_eq : ∀ y ∈ hitSet, @inner ℝ _ _ (incidentPt y - g.C) g.n = y
  /-- Every absorbed ray strikes the half-cylinder arc of the mirror. -/
  on_mirror : Set.MapsTo incidentPt hitSet (halfMirrorArc p g)
  /-- Reflection law on the circle (outward unit normal `R⁻¹ • (m - C)` at
  `m = incidentPt y`): specular reflection sends the incoming direction
  `e` to `e - 2 R⁻² ⟨m - C, e⟩ • (m - C)`, and the reflected ray reaches
  an absorbed endpoint `q` of the container disc after some positive
  travel distance `t`. -/
  reflected_point_law : ∀ y ∈ hitSet, ∃ q : Plane, ∃ t : ℝ, 0 < t ∧
    q ∈ containerDisk p g ∧
    q - incidentPt y =
      t • (g.e - (2 * @inner ℝ _ _ (incidentPt y - g.C) g.e / p.R ^ 2) •
        (incidentPt y - g.C))
  /-- The impact parameters of the absorbed rays form an open symmetric
  band `(-yOff, yOff)` for some `yOff > 0` (the half-width of the
  collected fan: larger offsets miss the container after reflection). -/
  hitSet_Ioo : ∃ yOff : ℝ, 0 < yOff ∧ hitSet = Set.Ioo (-yOff) yOff
  /-- Coverage (Figure 2f): every transverse readout strictly inside the
  collected band is realized by an absorbed ray, and the extreme absorbed
  rays are tangent to the container (sides of the band match the container
  silhouette, Figure 2f and part B.3). -/
  hit_offsets_fill : ∀ {yOff : ℝ}, hitSet = Set.Ioo (-yOff) yOff →
    ∀ z ∈ Set.Ioo (-yOff) yOff,
      ∃ x ∈ hitSet, @inner ℝ _ _ (incidentPt x - g.C) g.n = z

/-- Transverse width (impact-parameter support) of the rays that the mirror
concentrates onto the container: `sup - inf` of the transverse incidence
readouts over the hit set. With uniform parallel sunlight this width is
proportional to the received power `P` (per unit axial length). -/
def collectedWidth (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) : ℝ :=
  sSup ((fun y ↦ @inner ℝ _ _ (r.incidentPt y - g.C) g.n) '' r.hitSet) -
    sInf ((fun y ↦ @inner ℝ _ _ (r.incidentPt y - g.C) g.n) '' r.hitSet)

/-- Uniform parallel sunlight: incoming intensity `I` (power per unit area,
positive) is constant across the aperture. -/
structure UniformIntensity where
  I : ℝ
  hI : 0 < I

/-- Power budget for the configuration: `P` is the power actually received by
the absorbing container from the mirror, `P₀` the power it would receive
without the mirror. The two hypotheses state the physical accounting: with
uniform intensity `I` both quantities are proportional to their transverse
collected widths (per unit axial length), namely `collectedWidth` and the
container diameter `2 * a`. -/
structure PowerBudget (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) where
  P : ℝ
  P₀ : ℝ
  intensity : UniformIntensity
  received_power_eq : P = intensity.I * collectedWidth p g r
  unmirrored_power_eq : P₀ = intensity.I * (2 * p.a)

/-- Previous-part (B.1, `alpha = R`, `beta = -R / 2`) result, kept as a
calibration hypothesis for the geometry: the container radius relates to the
maximum incidence angle by `a = R sin θ_max - (R / 2) sin (2 θ_max)`. -/
def B1Calibration (p : CookerParams) (θ : ℝ) : Prop :=
  p.a = p.R * Real.sin θ - (p.R / 2) * Real.sin (2 * θ)

/-- The transverse offset (`n`-readout) of the incidence point of the
absorbed ray labelled `y`. Equals `y` on `hitSet` by `readout_eq`. -/
def hitOffset (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) (y : ℝ) : ℝ :=
  @inner ℝ _ _ (r.incidentPt y - g.C) g.n

/-- Incidence angle at mirror point `m` on the circular profile of radius
`R`, measured against the normal at `m`: `arccos (|⟨m - C, e⟩| / R)` — the
angle between the incoming direction `e` and the radius to `m`. -/
def incidenceAngle (p : CookerParams) (g : CookerGeometry p) (m : Plane) : ℝ :=
  Real.arccos (|@inner ℝ _ _ (m - g.C) g.e| / p.R)

/-- Specification of `θ_max`: the largest angle of incidence on the mirror
(measured against the normal at the point of incidence) among all reflected
rays striking the container, lying in `(0, π / 2)` — the branch of
nontrivial, non-grazing rays seen in Figure 2f. Concretely: `θ` is attained
at some absorbed impact parameter and bounds the incidence angle of every
absorbed ray. -/
def ThetaMaxSpec (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) (θ : ℝ) : Prop :=
  (θ ∈ Set.Ioo 0 (Real.pi / 2)) ∧
  (∃ y ∈ r.hitSet, incidenceAngle p g (r.incidentPt y) = θ) ∧
  (∀ y ∈ r.hitSet, incidenceAngle p g (r.incidentPt y) ≤ θ)

/-- Trigonometric link between the incidence angle and the transverse
offset of an absorbed ray: for `m` on the mirror circle,
`|⟨m - C, n⟩| = R sin (incidenceAngle m)`. (From `e ⊥ n`, both unit,
`spanning the plane: ⟨·,e⟩² + ⟨·,n⟩² = ‖·‖²` on mirror points.) -/
lemma abs_hitOffset_eq (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) {y : ℝ} (hy : y ∈ r.hitSet) :
    |hitOffset p g r y| = p.R * Real.sin (incidenceAngle p g (r.incidentPt y)) := by
  classical
  -- Component bookkeeping for the orthonormal pair `{e, n}` (Fin 2 plane):
  -- `‖e‖²` and `‖n‖²` as coordinate sums, and `⟨n, e⟩ = 0` as a dot product.
  have h0e : g.e 0 ^ 2 + g.e 1 ^ 2 = 1 := by
    have h1 : ‖g.e‖ ^ 2 = 1 := by rw [g.e_unit]; norm_num
    rw [EuclideanSpace.norm_eq] at h1
    have hnn : (0 : ℝ) ≤ ∑ k : Fin 2, ‖g.e k‖ ^ 2 :=
      Finset.sum_nonneg fun k _ => by positivity
    rw [Real.sq_sqrt hnn] at h1
    simpa [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, sq_abs] using h1
  have h0n : g.n 0 ^ 2 + g.n 1 ^ 2 = 1 := by
    have h1 : ‖g.n‖ ^ 2 = 1 := by rw [g.n_unit]; norm_num
    rw [EuclideanSpace.norm_eq] at h1
    have hnn : (0 : ℝ) ≤ ∑ k : Fin 2, ‖g.n k‖ ^ 2 :=
      Finset.sum_nonneg fun k _ => by positivity
    rw [Real.sq_sqrt hnn] at h1
    simpa [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, sq_abs] using h1
  have hpen : g.n 0 * g.e 0 + g.n 1 * g.e 1 = 0 := by
    have h := g.n_perp_e
    rw [PiLp.inner_apply] at h
    simpa [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, RCLike.inner_apply,
      mul_comm] using h
  -- For any `v`, the two readouts against `e` and `n` as coordinate
  -- dot products, and Parseval's identity `⟨v,e⟩² + ⟨v,n⟩² = ‖v‖²` in the
  -- plane spanned by the orthonormal pair `{e, n}`.
  have hdote : ∀ v : Plane, @inner ℝ _ _ v g.e = v 0 * g.e 0 + v 1 * g.e 1 := by
    intro v
    rw [PiLp.inner_apply]
    simp [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, RCLike.inner_apply,
      mul_comm]
  have hdotn : ∀ v : Plane, @inner ℝ _ _ v g.n = v 0 * g.n 0 + v 1 * g.n 1 := by
    intro v
    rw [PiLp.inner_apply]
    simp [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, RCLike.inner_apply,
      mul_comm]
  have hnormsq : ∀ v : Plane, ‖v‖ ^ 2 = v 0 ^ 2 + v 1 ^ 2 := by
    intro v
    rw [EuclideanSpace.norm_eq]
    have hnn : (0 : ℝ) ≤ ∑ k : Fin 2, ‖v k‖ ^ 2 :=
      Finset.sum_nonneg fun k _ => by positivity
    rw [Real.sq_sqrt hnn]
    simp [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, sq_abs]
  have hparseval : ∀ v : Plane,
      (@inner ℝ _ _ v g.e) ^ 2 + (@inner ℝ _ _ v g.n) ^ 2 = ‖v‖ ^ 2 := by
    intro v
    rw [hdote v, hdotn v, hnormsq v]
    -- Goal: `(v0 e0 + v1 e1)^2 + (v0 n0 + v1 n1)^2 = v0^2 + v1^2` from the
    -- orthonormality data of `{e, n}`; proved by the Figure-2f sign-split
    -- `n0 = ± e1` chain.
    have he1 : 1 - g.e 0 ^ 2 = g.e 1 ^ 2 := by linarith [h0e]
    have hn0e0 : g.n 0 * g.e 0 = -g.n 1 * g.e 1 := by linarith [hpen]
    have hstep1 : g.n 0 ^ 2 = g.e 1 ^ 2 := by
      have h1 : g.n 0 ^ 2 * g.e 0 ^ 2 = g.n 1 ^ 2 * g.e 1 ^ 2 := by
        have h := congr_arg (fun x ↦ x ^ 2) hn0e0
        nlinarith [h]
      nlinarith [h1, hpen, h0e, h0n, sq_nonneg (g.n 0), sq_nonneg (g.n 1),
        sq_nonneg (g.e 0), sq_nonneg (g.e 1)]
    have hstep2 : g.n 1 ^ 2 = g.e 0 ^ 2 := by nlinarith [hstep1, h0e, h0n]
    have hcross : g.e 0 * g.e 1 + g.n 0 * g.n 1 = 0 := by
      have hsq0 : (g.e 0 * g.e 1 + g.n 0 * g.n 1) ^ 2 = 0 := by
        nlinarith [hpen, hstep1, hstep2, sq_nonneg (g.e 0 * g.e 1),
          sq_nonneg (g.n 0 * g.n 1)]
      exact sq_eq_zero_iff.mp hsq0
    have hexpand : (v 0 * g.e 0 + v 1 * g.e 1) ^ 2 + (v 0 * g.n 0 + v 1 * g.n 1) ^ 2 =
        v 0 ^ 2 * (g.e 0 ^ 2 + g.n 0 ^ 2) + v 1 ^ 2 * (g.e 1 ^ 2 + g.n 1 ^ 2) +
          2 * v 0 * v 1 * (g.e 0 * g.e 1 + g.n 0 * g.n 1) := by ring
    rw [hexpand, hcross]
    have hA : g.e 0 ^ 2 + g.n 0 ^ 2 = 1 := by nlinarith [hstep1, h0e]
    have hB : g.e 1 ^ 2 + g.n 1 ^ 2 = 1 := by nlinarith [hstep2, h0n]
    rw [hA, hB]
    ring
  -- Set `v = incidentPt y - C`: on the mirror circle `‖v‖ = R`.
  have hon : r.incidentPt y ∈ halfMirrorArc p g := r.on_mirror hy
  have hmem : r.incidentPt y ∈ mirrorCircle p g := hon.1
  have hnorm : ‖r.incidentPt y - g.C‖ = p.R := by
    have h := hmem
    unfold mirrorCircle at h
    rwa [Metric.mem_sphere] at h
  -- Parseval at the incidence point: the readouts square-sum to `R^2`.
  have hpv := hparseval (r.incidentPt y - g.C)
  rw [hnorm] at hpv
  set ue : ℝ := @inner ℝ _ _ (r.incidentPt y - g.C) g.e with hue
  set wn : ℝ := @inner ℝ _ _ (r.incidentPt y - g.C) g.n with hwn
  have habsue : |ue| ≤ p.R := by
    have hwnn : 0 ≤ wn ^ 2 := sq_nonneg wn
    have hstep : ue ^ 2 ≤ p.R ^ 2 := by linarith [hpv, hwnn]
    have hiff : ue ^ 2 ≤ p.R ^ 2 ↔ |ue| ≤ |p.R| := sq_le_sq
    have habs : |ue| ≤ |p.R| := hiff.mp hstep
    rwa [abs_of_pos p.hR] at habs
  have hsq : |wn| ^ 2 = p.R ^ 2 * (1 - (|ue| / p.R) ^ 2) := by
    have h1 : |wn| ^ 2 = wn ^ 2 := sq_abs wn
    have hR2ne : p.R ^ 2 ≠ 0 := ne_of_gt (sq_pos_of_pos p.hR)
    have h2 : p.R ^ 2 * (1 - (|ue| / p.R) ^ 2) = p.R ^ 2 - ue ^ 2 := by
      rw [← sq_abs ue, div_pow]
      field_simp [ne_of_gt p.hR]
    nlinarith [hpv, h1, h2]
  have hsin : Real.sin (Real.arccos (|ue| / p.R))
      = Real.sqrt (1 - (|ue| / p.R) ^ 2) := Real.sin_arccos _
  have hgoal : |wn| = p.R * Real.sin (Real.arccos (|ue| / p.R)) := by
    rw [hsin, ← Real.sqrt_sq_eq_abs]
    conv_lhs => rw [← sq_abs wn]
    rw [hsq, Real.sqrt_mul (sq_nonneg p.R), Real.sqrt_sq (le_of_lt p.hR)]
  have hunfold : incidenceAngle p g (r.incidentPt y)
      = Real.arccos (|ue| / p.R) := rfl
  have hoff : hitOffset p g r y = wn := rfl
  rw [hunfold, hoff]
  exact hgoal

/-- The transverse width collected by the mirror equals twice the collected
half-width `yOff`: the transverse readouts of the absorbed impact
parameters `(-yOff, yOff)` (`readout_eq`, `hit_offsets_fill`) fill exactly
that band, whose `sSup - sInf` is `2 * yOff`. -/
lemma collectedWidth_eq_two_mul_yOff (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) {yOff : ℝ}
    (hyOff : 0 < yOff) (hhit : r.hitSet = Set.Ioo (-yOff) yOff) :
    collectedWidth p g r = 2 * yOff := by
  -- The transverse readouts of the hit band are exactly the band: by
  -- `readout_eq` every readout of an absorbed ray is its own impact
  -- parameter, and by `hit_offsets_fill` every point of the band is
  -- realized. Hence the image set is `Ioo (-yOff) yOff`, whose width is
  -- `2 * yOff` (`csSup_Ioo`, `csInf_Ioo`).
  have himage : (fun y ↦ @inner ℝ _ _ (r.incidentPt y - g.C) g.n) '' r.hitSet =
      Set.Ioo (-yOff) yOff := by
    apply Set.Subset.antisymm
    · rintro z ⟨y, hy, rfl⟩
      change @inner ℝ _ _ (r.incidentPt y - g.C) g.n ∈ Set.Ioo (-yOff) yOff
      rw [r.readout_eq y hy]
      rwa [hhit] at hy
    · intro z hz
      obtain ⟨x, hx, hz'⟩ := r.hit_offsets_fill hhit z hz
      exact ⟨x, hx, hz'⟩
  unfold collectedWidth
  rw [himage, csSup_Ioo (by linarith : -yOff < yOff),
      csInf_Ioo (by linarith : -yOff < yOff)]
  ring

/-- The collected half-width equals `R sin θ_max`: the extreme absorbed
rays at the band edges `|y| = yOff` carry the maximal incidence angle
(`ThetaMaxSpec` attainment), and the incidence angle varies strictly with
`|y|` (`abs_hitOffset_eq`, `incidenceAngle_le_of_offset_le`). -/
lemma yOff_eq_R_sin_thetaMax (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) {θ : ℝ} (hθ : ThetaMaxSpec p g r θ)
    {yOff : ℝ} (hyOff : 0 < yOff) (hhit : r.hitSet = Set.Ioo (-yOff) yOff) :
    yOff = p.R * Real.sin θ := by
  -- Physical argument: `abs_hitOffset_eq` turns `ThetaMaxSpec`
  -- (θ attained, θ bounding every absorbed incidence angle) into
  -- `|readout| ≤ R sin θ` on the band plus one ray whose readout has
  -- absolute value exactly `R sin θ`; since the band is open with
  -- half-width `yOff`, the two inequalities meet at `yOff = R sin θ`.
  have hsin_pos : 0 < Real.sin θ :=
    Real.sin_pos_of_pos_of_lt_pi hθ.1.1 (by linarith [Real.pi_gt_three, hθ.1.2])
  have hRsin_pos : 0 < p.R * Real.sin θ := mul_pos p.hR hsin_pos
  have hband_aux : -yOff < yOff := by linarith [hyOff]
  have hFbound : ∀ y ∈ r.hitSet,
      |hitOffset p g r y| ≤ p.R * Real.sin θ := by
    intro y hy
    rw [abs_hitOffset_eq p g r hy]
    set α := incidenceAngle p g (r.incidentPt y) with hαdef
    have hαspec : α = Real.arccos (|@inner ℝ _ _ (r.incidentPt y - g.C) g.e| / p.R) := rfl
    have hαnn : 0 ≤ α := by rw [hαspec]; exact Real.arccos_nonneg _
    have hαle : α ≤ Real.pi / 2 := by
      rw [hαspec]
      have hle : Real.arccos (|@inner ℝ _ _ (r.incidentPt y - g.C) g.e| / p.R) ≤
          Real.arccos 0 :=
        Real.arccos_le_arccos (div_nonneg (abs_nonneg _) (le_of_lt p.hR))
      rwa [Real.arccos_zero] at hle
    have hle : α ≤ θ := hθ.2.2 y hy
    have hθle : θ ≤ Real.pi / 2 := le_of_lt hθ.1.2
    have hsinα : Real.sin α ≤ Real.sin θ := by
      -- sin is monotone on `Icc (-(π/2)) (π/2)`, which contains both α and θ.
      have h1 : α ∈ Set.Icc (-(Real.pi / 2)) (Real.pi / 2) :=
        ⟨by linarith [hαnn], hαle⟩
      have h2 : θ ∈ Set.Icc (-(Real.pi / 2)) (Real.pi / 2) :=
        ⟨by linarith [hθ.1.1], hθle⟩
      exact (strictMonoOn_sin.le_iff_le h1 h2).mpr hle
    exact mul_le_mul_of_nonneg_left hsinα (le_of_lt p.hR)
  have hattain : ∃ y ∈ r.hitSet,
      |hitOffset p g r y| = p.R * Real.sin θ := by
    obtain ⟨y, hy, hangle⟩ := hθ.2.1
    refine ⟨y, hy, ?_⟩
    rw [abs_hitOffset_eq p g r hy, hangle]
  have hupper_bound : yOff ≤ p.R * Real.sin θ := by
    -- Rays with impact parameter strictly between `R sin θ` and `yOff`
    -- are absorbed (`hhit`) yet would violate the θ_max bound.
    by_contra hcontra
    push Not at hcontra
    set t : ℝ := (p.R * Real.sin θ + yOff) / 2 with ht
    have htb : t ∈ Set.Ioo (-yOff) yOff := by
      constructor
      · linarith [hcontra, hRsin_pos, hband_aux]
      · linarith [hcontra, hband_aux]
    have hmem : t ∈ r.hitSet := by rw [hhit]; exact htb
    have hread : hitOffset p g r t = t := r.readout_eq t hmem
    have hfb := hFbound t hmem
    rw [hread] at hfb
    rcases le_total 0 t with ht0 | ht0
    · rw [abs_of_nonneg ht0] at hfb
      linarith [hcontra, hfb]
    · have hneg := (abs_le.mp hfb).1
      linarith [hcontra, hneg, hRsin_pos]
  have hlower_bound : p.R * Real.sin θ ≤ yOff := by
    obtain ⟨y, hy, hyabs⟩ := hattain
    rw [hhit] at hy
    have hlt : |y| < yOff := abs_lt.mpr ⟨hy.1, hy.2⟩
    have hread : hitOffset p g r y = y := r.readout_eq y (by rw [hhit]; exact hy)
    have hFy : |hitOffset p g r y| < yOff := by rw [hread]; exact hlt
    have hres : p.R * Real.sin θ < yOff := by rw [← hyabs]; exact hFy
    exact le_of_lt hres
  exact le_antisymm hupper_bound hlower_bound

/-- Radius–sine-over-diameter trigonometric bridge: for `θ ∈ (0, π / 2)`
satisfying the B.1 calibration,
`2 R sin θ / (2 a) = 1 / (1 - cos θ)` (B.1 gives
`2 a = 2 R sin θ (1 - cos θ)` by the double-angle identity; cancel the
positive factor `2 R sin θ`). -/
lemma two_r_sin_over_diameter_eq (p : CookerParams) {θ : ℝ}
    (hθ : θ ∈ Set.Ioo 0 (Real.pi / 2)) (hcal : B1Calibration p θ) :
    2 * p.R * Real.sin θ / (2 * p.a) = 1 / (1 - Real.cos θ) := by
  -- From the B.1 calibration and the double-angle identity,
  -- `2 a = 2 R sin θ (1 - cos θ)`; cancel the positive factor
  -- `2 R sin θ` (`θ ∈ (0, π/2)`, `0 < R`).
  have hsin_pos : 0 < Real.sin θ :=
    Real.sin_pos_of_pos_of_lt_pi hθ.1 (by linarith [Real.pi_gt_three, hθ.2])
  have hcos_lt : Real.cos θ < 1 := by
    rcases eq_or_lt_of_le (Real.cos_le_one θ) with h | h
    · exfalso
      have hsin2 : Real.sin θ ^ 2 + Real.cos θ ^ 2 = 1 := Real.sin_sq_add_cos_sq θ
      rw [h] at hsin2
      have hs2 : Real.sin θ ^ 2 = 0 := by linarith [hsin2]
      have hsin0 : Real.sin θ = 0 := sq_eq_zero_iff.mp hs2
      linarith [hsin_pos]
    · exact h
  have h1cos_pos : 0 < 1 - Real.cos θ := by linarith [hcos_lt]
  have h2a : 2 * p.a = 2 * p.R * Real.sin θ * (1 - Real.cos θ) := by
    have hd := Real.sin_two_mul θ
    unfold B1Calibration at hcal
    linear_combination 2 * hcal - p.R * hd
  have h2a_ne : (2:ℝ) * p.a ≠ 0 := by
    have ha' : 0 < 2 * p.a := by linarith [p.ha]
    exact ne_of_gt ha'
  have h1cos_ne : (1:ℝ) - Real.cos θ ≠ 0 := ne_of_gt h1cos_pos
  have hcancel : 2 * p.R * Real.sin θ / (2 * p.a) =
      (2 * p.R * Real.sin θ * (1 - Real.cos θ)) / ((2 * p.a) * (1 - Real.cos θ)) :=
    (mul_div_mul_right _ _ h1cos_ne).symm
  have hnum : 2 * p.R * Real.sin θ * (1 - Real.cos θ) = 2 * p.a := h2a.symm
  rw [hcancel, hnum]
  have ha_ne : p.a ≠ 0 := ne_of_gt p.ha
  field_simp [ha_ne, h1cos_ne]

/-- Power ratio from the width accounting only:
`P / P₀ = (2 * yOff) / (2 * a)`, where `yOff` is the collected half-width
of `hitSet_Ioo`; the common positive intensity cancels. Chained with
`yOff_eq_R_sin_thetaMax` and `two_r_sin_over_diameter_eq` this becomes the
target trigonometric form. -/
lemma power_ratio_eq_width_ratio (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) (budget : PowerBudget p g r)
    {yOff : ℝ} (hyOff : 0 < yOff) (hhit : r.hitSet = Set.Ioo (-yOff) yOff) :
    budget.P / budget.P₀ = (2 * yOff) / (2 * p.a) := by
  -- Substitute the two budget identities; the common positive intensity
  -- cancels in the ratio, leaving the width ratio.
  have hw : collectedWidth p g r = 2 * yOff :=
    collectedWidth_eq_two_mul_yOff p g r hyOff hhit
  have hI : 0 < budget.intensity.I := budget.intensity.hI
  rw [budget.received_power_eq, budget.unmirrored_power_eq, hw]
  have ha2 : 0 < 2 * p.a := by linarith [p.ha]
  have hP0ne : budget.intensity.I * (2 * p.a) ≠ 0 := ne_of_gt (mul_pos hI ha2)
  have hane : (2:ℝ) * p.a ≠ 0 := ne_of_gt ha2
  field_simp [hP0ne, hane]

/-- **Target (T2-B2).** For the cooker of Figure 2f with absorbed-ray
bookkeeping `r`, power budget `budget`, and maximum incidence angle
specification `θ`, the ratio of the received power `P` to the unmirrored
power `P₀` is `P / P₀ = 1 / (1 - cos θ_max)` — the recorded official
answer of part B.2.

Blueprint: `thm:physics:IPhO_2026_2_B_2:target`. -/
theorem power_ratio_in_terms_of_theta_max
    (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) (budget : PowerBudget p g r)
    {θ : ℝ} (hθ : ThetaMaxSpec p g r θ) (hcal : B1Calibration p θ) :
    budget.P / budget.P₀ = 1 / (1 - Real.cos θ) := by
  -- Chain `power_ratio_eq_width_ratio` (`P/P₀ = 2·yOff/(2a)`) with
  -- `yOff_eq_R_sin_thetaMax` (`yOff = R sin θ`) and the B.1-calibration
  -- bridge `two_r_sin_over_diameter_eq` (`2R sin θ/(2a) = 1/(1-cos θ)`).
  obtain ⟨yOff, hyOff, hhit⟩ := r.hitSet_Ioo
  rw [power_ratio_eq_width_ratio p g r budget hyOff hhit,
    yOff_eq_R_sin_thetaMax p g r hθ hyOff hhit]
  have hbridge := two_r_sin_over_diameter_eq p hθ.1 hcal
  have hmul : (2:ℝ) * (p.R * Real.sin θ) = 2 * p.R * Real.sin θ := by ring
  rw [hmul]
  exact hbridge

end IPhO2026_2_B_2


end

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
  hit_offsets_fill : ∀ z ∈ Set.Ioo (-yOff) yOff,
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
  -- Coordinate extraction in the orthonormal pair `{e, n}` (Fin 2 plane).
  have hrw : ∀ {v : Plane}, ∀ {uu ww : ℝ},
      uu = @inner ℝ _ _ v g.e → ww = @inner ℝ _ _ v g.n →
      v = !₂[uu, ww] := by
    intro v uu ww hu hw
    ext i
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
    have hu' : uu = v 0 * g.e 0 + v 1 * g.e 1 := by
      rw [hu, PiLp.inner_apply]
      simp [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, RCLike.inner_apply,
        mul_comm]
    have hw' : ww = v 0 * g.n 0 + v 1 * g.n 1 := by
      rw [hw, PiLp.inner_apply]
      simp [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, RCLike.inner_apply,
        mul_comm]
    have hdet_aux : g.e 0 * g.n 1 = g.e 1 * g.n 0 + (g.n 0 * g.e 0 + g.n 1 * g.e 1) := by ring
    have hdet_pos : 0 < (g.e 0 * g.n 1 - g.e 1 * g.n 0) ^ 2 := by
      have hs : (g.e 0 * g.n 1 - g.e 1 * g.n 0) ^ 2 = 1 := by nlinarith
      rw [hs]; exact one_pos
    fin_cases i
    · simp only [Fin.zero_eta, Matrix.cons_val_zero]
      have h1 : uu * g.n 1 - ww * g.n 0 = v 0 * (g.e 0 * g.n 1 - g.e 1 * g.n 0) := by
        nlinarith [hu', hw']
      have h2 : v 0 = (uu * g.n 1 - ww * g.n 0) / (g.e 0 * g.n 1 - g.e 1 * g.n 0) :=
        (eq_div_iff (ne_of_gt (sq_pos_iff.mp (by rwa [sq] at hdet_pos)))).2 (by linear_combination h1)
      have hdet_ne : g.e 0 * g.n 1 - g.e 1 * g.n 0 ≠ 0 := by
        intro hbad; rw [hbad, sq] at hdet_pos; exact lt_irrefl _ hdet_pos
      rw [h2]
      have h3 : uu = v 0 * g.e 0 + v 1 * g.e 1 := hu'
      have h4 : ww = v 0 * g.n 0 + v 1 * g.n 1 := hw'
      have hb1 : g.e 0 * (g.e 0 * g.n 1 - g.e 1 * g.n 0) = g.n 1 - g.n 0 * 0 := by nlinarith
      -- direct: solve uu = (X/D)*e0 + Y*e1 → X = (uu*n1 - ww*n0), i.e. rw h2 and field
      rw [eq_div_iff hdet_ne] at h2
      rw [h2]
      field_simp
      nlinarith [h0e, h0n, hpen]
    · simp only [Fin.mk_one, Matrix.cons_val_one]
      have h1 : ww * g.e 0 - uu * g.n 0 = v 1 * (g.e 0 * g.n 1 - g.e 1 * g.n 0) := by
        nlinarith [hu', hw']
      have hdet_ne : g.e 0 * g.n 1 - g.e 1 * g.n 0 ≠ 0 := by
        intro hbad
        have hs : (g.e 0 * g.n 1 - g.e 1 * g.n 0) ^ 2 = 1 := by nlinarith
        rw [hbad] at hs; norm_num at hs
      rw [eq_div_iff hdet_ne] at *
      have h2 : v 1 * (g.e 0 * g.n 1 - g.e 1 * g.n 0) = ww * g.e 0 - uu * g.n 0 := h1
      rw [← h2]
      field_simp
      nlinarith [h0e, h0n, hpen]
  -- End of the coordinate-extraction subroutine.
  sorry

/-- The transverse width collected by the mirror equals twice the collected
half-width `yOff`: the transverse readouts of the absorbed impact
parameters `(-yOff, yOff)` (`readout_eq`, `hit_offsets_fill`) fill exactly
that band, whose `sSup - sInf` is `2 * yOff`. -/
lemma collectedWidth_eq_two_mul_yOff (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) {yOff : ℝ}
    (hyOff : 0 < yOff) (hhit : r.hitSet = Set.Ioo (-yOff) yOff) :
    collectedWidth p g r = 2 * yOff := by
  sorry

/-- The collected half-width equals `R sin θ_max`: the extreme absorbed
rays at the band edges `|y| = yOff` carry the maximal incidence angle
(`ThetaMaxSpec` attainment), and the incidence angle varies strictly with
`|y|` (`abs_hitOffset_eq`, `incidenceAngle_le_of_offset_le`). -/
lemma yOff_eq_R_sin_thetaMax (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) {θ : ℝ} (hθ : ThetaMaxSpec p g r θ)
    {yOff : ℝ} (hyOff : 0 < yOff) (hhit : r.hitSet = Set.Ioo (-yOff) yOff) :
    yOff = p.R * Real.sin θ := by
  sorry

/-- Radius–sine-over-diameter trigonometric bridge: for `θ ∈ (0, π / 2)`
satisfying the B.1 calibration,
`2 R sin θ / (2 a) = 1 / (1 - cos θ)` (B.1 gives
`2 a = 2 R sin θ (1 - cos θ)` by the double-angle identity; cancel the
positive factor `2 R sin θ`). -/
lemma two_r_sin_over_diameter_eq (p : CookerParams) {θ : ℝ}
    (hθ : θ ∈ Set.Ioo 0 (Real.pi / 2)) (hcal : B1Calibration p θ) :
    2 * p.R * Real.sin θ / (2 * p.a) = 1 / (1 - Real.cos θ) := by
  sorry

/-- Power ratio from the width accounting only:
`P / P₀ = (2 * yOff) / (2 * a)`, where `yOff` is the collected half-width
of `hitSet_Ioo`; the common positive intensity cancels. Chained with
`yOff_eq_R_sin_thetaMax` and `two_r_sin_over_diameter_eq` this becomes the
target trigonometric form. -/
lemma power_ratio_eq_width_ratio (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) (budget : PowerBudget p g r)
    {yOff : ℝ} (hyOff : 0 < yOff) (hhit : r.hitSet = Set.Ioo (-yOff) yOff) :
    budget.P / budget.P₀ = (2 * yOff) / (2 * p.a) := by
  sorry

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
  sorry

end IPhO2026_2_B_2

end

/-
IPhO 2026, Theoretical Problem 2 (Solar Cooker), Part B.2 — autoformalization.

Physical situation (Figure 2f). A half-hollow-cylinder mirror of radius `R`
(mirrored on the inside, aperture of width `2R`) is illuminated by uniform
parallel sunlight arriving along the mirror's optical axis. A fully absorbing
cylindrical container of radius `a` has its axis parallel to the mirror axis;
its centre lies `R / 2` from the mirror centre on the system symmetry plane.
Every absorbed ray reflects at most once. `θ_max` is the maximum angle of
incidence on the mirror (measured against the normal at the point of
incidence) among all reflected rays that strike the container, and `P₀` is
the power the container would receive if the mirror were not present.

Current subquestion (T2-B2): express the ratio `P / P₀` in terms of `θ_max`.

Recorded official answer: `P / P₀ = 1 / (1 - Real.cos θ_max)`.

This file is a by-`sorry` formalization: faithful declarations with proof
bodies left as `sorry`. Modelled on a transverse cross-section (the problem
is translationally invariant along the cylinder axes), so the configuration
lives in `EuclideanSpace ℝ (Fin 2)` and every "power" below is a
power-per-unit-axis-length proxy; the common incoming intensity and the
common axial length cancel in the ratio `P / P₀`, which is a ratio of
collected transverse widths (concentrated power from width `collectedWidth`)
over the unmirrored geometric width `2 * a`.

Governing physical laws (kept as hypotheses, never redefined locally):
specular reflection on the circular mirror profile, the offset container
geometry, single-bounce ray bookkeeping, the previous-part (B.1) calibration
`a = R sin θ_max - (R / 2) sin (2 θ_max)`, and the uniform-intensity
width accounting for `P` and `P₀`.
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
centre `A`, unit vector `e` along the optical axis pointing from `C` towards
the open half of the half-cylinder mirror, and in-plane normal `n` (chosen
on the container's side) with the container centre lying `R / 2` from `C`
along `n` on the symmetry axis (the cross-sectional image of the symmetry
plane). Sunlight arrives in the direction `- e`. -/
structure CookerGeometry (p : CookerParams) where
  C : Plane
  A : Plane
  e : Plane
  n : Plane
  e_unit : ‖e‖ = 1
  n_unit : ‖n‖ = 1
  n_perp_e : inner ℝ n e = 0
  A_offset : A - C = (p.R / 2) • n

/-- The full circle of radius `R` centred at `C`: the cross-sectional profile
of the cylinder mirror. -/
def mirrorCircle (p : CookerParams) (g : CookerGeometry p) : Set Plane :=
  Metric.sphere g.C p.R

/-- The absorbing disc: cross-section of the cylindrical container. -/
def containerDisk (p : CookerParams) (g : CookerGeometry p) : Set Plane :=
  Metric.closedBall g.A p.a

/-- The half-cylinder mirror arc: the semi-circle of `mirrorCircle` lying in
the `0 ≤ inner (m - C) e` half-plane (the "half-hollow-cylinder mirror"). -/
def halfMirrorArc (p : CookerParams) (g : CookerGeometry p) : Set Plane :=
  {m ∈ mirrorCircle p g | 0 ≤ inner ℝ (m - g.C) g.e}

/-- Single-bounce bookkeeping for the sun rays absorbed by the container.

Physical laws encoded (hypotheses, not definitions to be unfolded):
* `hitSet` parametrizes (via the axial direction `e`) the incoming parallel
  rays that reach the mirror and then strike the container; `on_mirror`
  places every incidence point on the half-cylinder arc.
* `reflected_point_law` is specular reflection on the circular profile:
  an incoming ray with direction `- e` reflecting at mirror point `m`
  leaves along `2 ⟨m - C, n⟩•n - R•e`; combined with the absorbed-ray
  condition this gives the reflected endpoint `q` in the container disc.
* `central_ray_absorbed`, `no_gap`, `full_side_coverage` record the branch
  information read from Figure 2f: the axial ray is absorbed, hits form a
  contiguous family, and every impact parameter in `(0, a)` is realized —
  so that `θ_max` is attained as a maximum over a connected family and the
  collected fan fills one side from the axis to the tangent ray. -/
structure AbsorbedRays (p : CookerParams) (g : CookerGeometry p) where
  /-- Incidence point on the mirror of the absorbed ray with axial impact
  parameter `y = ⟨incidentPt y - C, e⟩`. -/
  incidentPt : ℝ → Plane
  /-- Impact parameters of rays that are absorbed by the container. -/
  hitSet : Set ℝ
  /-- Every absorbed ray strikes the half-cylinder arc of the mirror. -/
  on_mirror : Set.MapsTo incidentPt hitSet (halfMirrorArc p g)
  /-- Reflection law on the circle (unit inward normal `-(m - C)/R`): the
  reflected direction `2 ⟨m - C, n⟩ n - R e` originating at `m = incidentPt y`
  has second intersection with the container disc at `q`; the `q` there is
  absorbed (fully absorbing container). -/
  reflected_point_law : ∀ y ∈ hitSet, ∃ q : Plane,
    q ∈ containerDisk p g ∧
    q - incidentPt y = (2 * inner ℝ (incidentPt y - g.C) g.n - p.R) • g.n
  /-- The axial (central) ray hits the container after reflection. -/
  central_ray_absorbed : 0 ∈ hitSet
  /-- The absorbed family is gap-free right of the axis (contiguity of the
  single-bounce fan; topology of `hitSet` along `e`). -/
  no_gap : ∀ y₁ y₂ : ℝ, y₁ ∈ hitSet → 0 ≤ y₂ → y₂ ≤ y₁ → y₂ ∈ hitSet
  /-- Every impact parameter in `(0, a)` is realized: the collected fan
  reaches out to the container's silhouette radius `a`. -/
  full_side_coverage : ∀ y ∈ Set.Ioo (0 : ℝ) p.a,
    ∃ x ∈ hitSet, inner ℝ (incidentPt x - g.C) g.e = y

/-- Transverse width (impact-parameter support) of the rays that the mirror
concentrates onto the container. With uniform parallel sunlight this width
is proportional to the received power `P` (per unit axial length). -/
def collectedWidth (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) : ℝ :=
  sSup ((fun y ↦ inner ℝ (r.incidentPt y - g.C) g.e) '' r.hitSet)

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

/-- Incidence angle at mirror point `m` on the circular profile of radius
`R`, measured against the normal at `m`: `arccos (|⟨m - C, e⟩| / R)` — the
angle between the incoming direction `e` and the radius to `m`. -/
def incidenceAngle (p : CookerParams) (g : CookerGeometry p) (m : Plane) : ℝ :=
  Real.arccos (|inner ℝ (m - g.C) g.e| / p.R)

/-- Specification of `θ_max`: the largest angle of incidence on the mirror
(measured against the normal at the point of incidence) among all reflected
rays striking the container, lying in `(0, π / 2)` — the branch of
nontrivial, non-grazing rays seen in Figure 2f. -/
def ThetaMaxSpec (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) (θ : ℝ) : Prop :=
  (θ ∈ Set.Ioo 0 (Real.pi / 2)) ∧
  (∃ y ∈ r.hitSet, incidenceAngle p g (r.incidentPt y) = θ) ∧
  (∀ y ∈ r.hitSet, incidenceAngle p g (r.incidentPt y) ≤ θ)

/-- Geometric bridge (proof side): all mirror-collected impact parameters are
bounded by the aperture radius `R` — the trivial bound from `mirrorCircle`
and `‖e‖ = 1`. -/
lemma impactParam_le_aperture (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) :
    ∀ y ∈ r.hitSet, |inner ℝ (r.incidentPt y - g.C) g.e| ≤ p.R := by
  sorry

/-- Width accounting bridge: the transverse width collected by the
half-cylinder mirror on the container's side equals `R` (one full half of
the aperture `2 R`, realized by the contiguous fan of `full_side_coverage`
and `no_gap`, bounded by `impactParam_le_aperture`). -/
lemma collectedWidth_eq_radius (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) :
    collectedWidth p g r = p.R := by
  sorry

/-- Power ratio from the width accounting only: `P / P₀ = R / (2 a)`. With
the B.1 calibration this becomes the target trigonometric form. -/
lemma power_ratio_eq_width_ratio (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) (budget : PowerBudget p g r) :
    budget.P / budget.P₀ = p.R / (2 * p.a) := by
  sorry

/-- Trigonometric bridge (B.1 calibration, elementary):
`R / (2 a) = 1 / (1 - cos θ)` for `θ ∈ (0, π / 2)` satisfying
`a = R sin θ - (R / 2) sin (2 θ)`. -/
lemma radius_over_diameter_eq (p : CookerParams) {θ : ℝ}
    (hθ : θ ∈ Set.Ioo 0 (Real.pi / 2)) (hcal : B1Calibration p θ) :
    p.R / (2 * p.a) = 1 / (1 - Real.cos θ) := by
  sorry

/-- **Target (T2-B2).** For the cooker of Figure 2f with absorbed-ray
bookkeeping `r`, power budget `budget`, and maximum incidence angle
specification `θ`, the ratio of the received power `P` to the unmirrored
power `P₀` is `P / P₀ = 1 / (1 - cos θ_max)`.

Blueprint: `thm:physics:IPhO_2026_2_B_2:target`. -/
theorem power_ratio_in_terms_of_theta_max
    (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) (budget : PowerBudget p g r)
    {θ : ℝ} (hθ : ThetaMaxSpec p g r θ) (hcal : B1Calibration p θ) :
    budget.P / budget.P₀ = 1 / (1 - Real.cos θ) := by
  sorry

end IPhO2026_2_B_2

end

import Mathlib

namespace IPhO2026Problem2A1

/-- The three source panels used for the multiple-reflection model:
Figure 2c is the physical half-cylinder, Figure 2d is its planar
cross-section, and Figure 2e is the reflection-count plot. -/
inductive SourceFigure
  | mirrorAssembly2c
  | crossSection2d
  | reflectionCountPlot2e
  deriving DecidableEq

/-- The orientation of a ray parallel to the optical axis in the coordinate
frame of Figure 2d. -/
inductive AxialDirection
  | towardPositiveY
  | towardNegativeY
  deriving DecidableEq

/-- A half-cylindrical mirror, represented by its positive radius. All length
quantities below are scalar readouts in the same fixed (but unspecified)
length unit. -/
structure HalfCylindricalMirror where
  radius : ℝ
  radius_pos : 0 < radius

/-- The diameter marked `2R` in Figure 2c. -/
def HalfCylindricalMirror.diameter (mirror : HalfCylindricalMirror) : ℝ :=
  2 * mirror.radius

/-- The reflecting upper semicircle in the coordinate frame of Figure 2d.
The optical axis is the `y`-axis and the origin is the circle center. -/
def OnReflectingSemicircle (mirror : HalfCylindricalMirror) (point : ℝ × ℝ) : Prop :=
  point.1 ^ 2 + point.2 ^ 2 = mirror.radius ^ 2 ∧ 0 ≤ point.2

universe u

/-- Scalar readouts and ray data for the experiment in Figures 2d--2e.

`Ray` remains an abstract physical primitive. Its transverse-coordinate and
angle maps are measured scalar components, while `reflectionCount` records
the discrete number of impacts on the reflecting semicircle. -/
structure MultipleReflectionExperiment (mirror : HalfCylindricalMirror) where
  Ray : Type u
  transverseCoordinate : Ray → ℝ
  reflectionCount : Ray → ℕ
  isParallelIncident : Ray → Prop
  incomingDirection : AxialDirection
  incoming_direction_from_figure : incomingDirection = .towardPositiveY
  incidenceAngleAt : Ray → ℕ → ℝ
  reflectionAngleAt : Ray → ℕ → ℝ
  incident_coordinate_in_aperture :
    ∀ ray, isParallelIncident ray → |transverseCoordinate ray| < mirror.radius
  incident_ray_at_coordinate :
    ∀ x : ℝ, |x| < mirror.radius →
      ∃ ray, isParallelIncident ray ∧ transverseCoordinate ray = x
  reflection_count_positive :
    ∀ ray, isParallelIncident ray → 0 < reflectionCount ray
  reflection_count_symmetric :
    ∀ ray₁ ray₂,
      isParallelIncident ray₁ →
      isParallelIncident ray₂ →
      transverseCoordinate ray₂ = -transverseCoordinate ray₁ →
      reflectionCount ray₂ = reflectionCount ray₁

/-- The equal-angle law of specular reflection, stated at every actual impact.
Angles are dimensionless real readouts in radians. -/
def ObeysSpecularReflection {mirror : HalfCylindricalMirror}
    (experiment : MultipleReflectionExperiment mirror) : Prop :=
  ∀ ray impact,
    experiment.isParallelIncident ray →
    impact < experiment.reflectionCount ray →
    experiment.reflectionAngleAt ray impact =
      experiment.incidenceAngleAt ray impact

/-- `xN` is the positive maximum transverse distance among incident rays that
undergo at most `N` reflections. This is the threshold notion depicted in
Figure 2e; it is not a closed-form definition of the requested answer. -/
def IsPositiveReflectionThreshold {mirror : HalfCylindricalMirror}
    (experiment : MultipleReflectionExperiment mirror) (N : ℕ) (xN : ℝ) : Prop :=
  0 < xN ∧
    xN < mirror.radius ∧
    (∃ ray,
      experiment.isParallelIncident ray ∧
      experiment.transverseCoordinate ray = xN ∧
      experiment.reflectionCount ray ≤ N) ∧
    ∀ ray,
      experiment.isParallelIncident ray →
      experiment.reflectionCount ray ≤ N →
      |experiment.transverseCoordinate ray| ≤ xN

/-- A limiting ray on the positive-`x` branch, together with the acute polar
angle of its first impact point, measured from the positive `x`-axis. This is
distinct from the optical incidence angle relative to the surface normal. -/
structure LimitingRayWitness {mirror : HalfCylindricalMirror}
    (experiment : MultipleReflectionExperiment mirror) (N : ℕ) (xN : ℝ) where
  ray : experiment.Ray
  is_parallel_incident : experiment.isParallelIncident ray
  on_positive_branch : experiment.transverseCoordinate ray = xN
  reflection_count_eq : experiment.reflectionCount ray = N
  firstImpactPolarAngle : ℝ
  first_impact_angle_pos : 0 < firstImpactPolarAngle
  first_impact_angle_acute : firstImpactPolarAngle < Real.pi / 2

/-- The projection read from the right triangle in the circular cross-section:
the positive transverse coordinate is `R cos θ`. -/
structure HalfCircleProjectionGeometry {mirror : HalfCylindricalMirror}
    (experiment : MultipleReflectionExperiment mirror) (N : ℕ) (xN : ℝ)
    (limiting : LimitingRayWitness experiment N xN) : Prop where
  coordinate_eq_radius_mul_cos :
    xN = mirror.radius * Real.cos limiting.firstImpactPolarAngle

/-- The angular closure obtained by applying equal-angle reflection repeatedly
to the limiting ray in a semicircle. The `2N + 1` factor retains the endpoint
and orientation information of the positive limiting branch. -/
structure RepeatedReflectionClosure {mirror : HalfCylindricalMirror}
    (experiment : MultipleReflectionExperiment mirror) (N : ℕ) (xN : ℝ)
    (limiting : LimitingRayWitness experiment N xN) : Prop where
  angle_closure :
    (2 * (N : ℝ) + 1) * limiting.firstImpactPolarAngle = Real.pi

/-- The governing-law interface needed from geometric optics. Besides the
local equal-angle law, it exposes the limiting-ray projection and angular
closure that follow from applying that law to the circular mirror. -/
structure HalfCylinderReflectionLaws {mirror : HalfCylindricalMirror}
    (experiment : MultipleReflectionExperiment mirror) : Prop where
  obeys_specular_reflection : ObeysSpecularReflection experiment
  limiting_ray_geometry :
    ∀ (N : ℕ) (xN : ℝ),
      0 < N →
      IsPositiveReflectionThreshold experiment N xN →
      ∃ limiting : LimitingRayWitness experiment N xN,
        HalfCircleProjectionGeometry experiment N xN limiting ∧
          RepeatedReflectionClosure experiment N xN limiting

/-- Algebraic bridge from the repeated-reflection closure to the unique
limiting angle. -/
lemma limiting_first_impact_angle {mirror : HalfCylindricalMirror}
    {experiment : MultipleReflectionExperiment mirror} {N : ℕ} {xN : ℝ}
    (hN : 0 < N) (limiting : LimitingRayWitness experiment N xN)
    (closure : RepeatedReflectionClosure experiment N xN limiting) :
    limiting.firstImpactPolarAngle =
      Real.pi / (2 * (N : ℝ) + 1) := by
  sorry

/-- The two angles occurring in the official sine and cosine answer forms are
complementary. -/
lemma official_answer_angles_complementary (N : ℕ) (hN : 0 < N) :
    Real.pi / 2 - Real.pi / (2 * (N : ℝ) + 1) =
      (2 * (N : ℝ) - 1) * Real.pi / (4 * (N : ℝ) + 2) := by
  sorry

/-- Trigonometric bridge between the two official closed forms. The Mathlib
carrier for the complementary-angle step is `Real.sin_pi_div_two_sub`. -/
lemma official_sine_cosine_forms_agree (N : ℕ) (hN : 0 < N) :
    Real.sin ((2 * (N : ℝ) - 1) * Real.pi / (4 * (N : ℝ) + 2)) =
      Real.cos (Real.pi / (2 * (N : ℝ) + 1)) := by
  sorry

/-- IPhO 2026 Problem 2 A.1: the positive threshold for at most `N`
reflections in the half-cylindrical mirror has the two equivalent official
closed forms. -/
theorem positive_reflection_threshold_formula
    {mirror : HalfCylindricalMirror}
    (experiment : MultipleReflectionExperiment mirror)
    (laws : HalfCylinderReflectionLaws experiment)
    (N : ℕ) (hN : 0 < N) (xN : ℝ)
    (hThreshold : IsPositiveReflectionThreshold experiment N xN) :
    xN =
        mirror.radius *
          Real.sin ((2 * (N : ℝ) - 1) * Real.pi / (4 * (N : ℝ) + 2)) ∧
      xN =
        mirror.radius *
          Real.cos (Real.pi / (2 * (N : ℝ) + 1)) := by
  sorry

end IPhO2026Problem2A1

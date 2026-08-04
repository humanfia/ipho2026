import Mathlib

open Filter
open scoped Topology

namespace IPhO2026Problems.IPhO2026_2_C_2

/-- A point in the two-dimensional cross-section used in Figure 2g.
Both coordinates are scalar readouts in the same chosen unit of length. -/
structure Point2D where
  x : ℝ
  y : ℝ

/-- A directed vector in the Figure 2g coordinate frame.  Its components are
used only to retain the incoming/outgoing orientation of an optical ray. -/
structure Direction2D where
  dx : ℝ
  dy : ℝ

/-- The upward vertical direction of the parallel incident rays in Figure 2g. -/
def verticalIncomingDirection : Direction2D where
  dx := 0
  dy := 1

/-- A scalar-coordinate description of a reflected straight line.
The slope is dimensionless, while `yIntercept` is a length readout. -/
structure AffineLineReadout where
  slope : ℝ
  yIntercept : ℝ

/-- Incidence-point labels from Figure 2g. -/
inductive Figure2gRayLabel
  | A
  | B

/-- The data retained for an incident ray and its reflected branch.  Angles
are real numbers measured in radians in the convention of Figure 2g. -/
structure OpticalRay2D where
  label : Figure2gRayLabel
  incidenceAngle : ℝ
  incidencePoint : Point2D
  incomingDirection : Direction2D
  outgoingDirection : Direction2D
  reflectedLine : AffineLineReadout

/-- The half-cylindrical mirror, represented by its circular cross-section
radius.  `radius` is a positive scalar readout in the coordinate length unit. -/
structure HalfCylindricalMirror where
  radius : ℝ
  radius_pos : 0 < radius

/-- A point lies on the upper semicircular cross-section of the mirror. -/
def OnUpperSemicircle (mirror : HalfCylindricalMirror) (point : Point2D) : Prop :=
  point.x ^ 2 + point.y ^ 2 = mirror.radius ^ 2 ∧ 0 ≤ point.y

/-- A point lies on a reflected line in the signed coordinate convention of
Figure 2g. -/
def AffineLineReadout.Contains (line : AffineLineReadout) (point : Point2D) : Prop :=
  point.y = line.slope * point.x + line.yIntercept

/-- The geometry and orientation read directly from Figure 2g for a ray whose
incidence angle is `φ`.  In particular, the incoming ray is vertical and the
reflected ray is taken on the left-going branch. -/
def HasFigure2gGeometry
    (mirror : HalfCylindricalMirror) (label : Figure2gRayLabel)
    (φ : ℝ) (ray : OpticalRay2D) : Prop :=
  ray.label = label ∧
    ray.incidenceAngle = φ ∧
    ray.incidencePoint.x = mirror.radius * Real.sin φ ∧
    ray.incidencePoint.y = mirror.radius * Real.cos φ ∧
    OnUpperSemicircle mirror ray.incidencePoint ∧
    ray.incomingDirection = verticalIncomingDirection ∧
    ray.reflectedLine.Contains ray.incidencePoint ∧
    ray.outgoingDirection.dx < 0 ∧
    ray.outgoingDirection.dy =
      ray.reflectedLine.slope * ray.outgoingDirection.dx

/-- The two incident rays are parallel with the same directed incoming
orientation, as specified in C.2. -/
def HaveParallelIncomingDirections (rayA rayB : OpticalRay2D) : Prop :=
  rayA.incomingDirection = rayB.incomingDirection

/-- The reusable result of C.1 for the ray labelled `A`.  This is previous-part
input, rather than either of the first-order conclusions requested in C.2. -/
def SatisfiesPreviousPartC1
    (mirror : HalfCylindricalMirror) (θ : ℝ) (rayA : OpticalRay2D) : Prop :=
  rayA.reflectedLine.slope = Real.cot (2 * θ) ∧
    rayA.reflectedLine.yIntercept =
      mirror.radius / (2 * Real.cos θ)

/-- The exact coefficient consequence of specular reflection from the circular
mirror at an arbitrary incidence angle.  C.2 applies this governing law at
`θ + Δθ` and then takes its first-order expansion. -/
def SatisfiesHalfCylindricalSpecularLaw
    (mirror : HalfCylindricalMirror) (ray : OpticalRay2D) : Prop :=
  ray.reflectedLine.slope =
      Real.cot (2 * ray.incidenceAngle) ∧
    ray.reflectedLine.yIntercept =
      mirror.radius / (2 * Real.cos ray.incidenceAngle)

/-- The exact slope equation exposed by the circular-mirror reflection law. -/
theorem slope_eq_of_specular_law
    {mirror : HalfCylindricalMirror} {ray : OpticalRay2D}
    (h : SatisfiesHalfCylindricalSpecularLaw mirror ray) :
    ray.reflectedLine.slope = Real.cot (2 * ray.incidenceAngle) :=
  h.1

/-- The exact intercept equation exposed by the circular-mirror reflection law. -/
theorem intercept_eq_of_specular_law
    {mirror : HalfCylindricalMirror} {ray : OpticalRay2D}
    (h : SatisfiesHalfCylindricalSpecularLaw mirror ray) :
    ray.reflectedLine.yIntercept =
      mirror.radius / (2 * Real.cos ray.incidenceAngle) :=
  h.2

/-- IPhO 2026 Problem 2 C.2: the reflected line of the neighboring ray `B`
has the stated first-order slope and intercept expansions as `Δθ → 0`.

The two `IsBigO` conclusions say that the displayed remainders are bounded by
a constant multiple of `Δθ²` near zero.  Thus the approximation order in the
source is part of the theorem contract rather than being silently discarded. -/
theorem rayB_firstOrderExpansion
    (mirror : HalfCylindricalMirror) (θ : ℝ)
    (rayA : OpticalRay2D) (rayB : ℝ → OpticalRay2D)
    (hθ_pos : 0 < θ) (hθ_lt : θ < Real.pi / 2)
    (hsin : Real.sin (2 * θ) ≠ 0) (hcos : Real.cos θ ≠ 0)
    (hA_geometry : HasFigure2gGeometry mirror Figure2gRayLabel.A θ rayA)
    (hB_geometry :
      ∀ᶠ Δθ in 𝓝 (0 : ℝ),
        HasFigure2gGeometry mirror Figure2gRayLabel.B (θ + Δθ) (rayB Δθ))
    (h_parallel :
      ∀ᶠ Δθ in 𝓝 (0 : ℝ), HaveParallelIncomingDirections rayA (rayB Δθ))
    (hC1 : SatisfiesPreviousPartC1 mirror θ rayA)
    (h_reflection :
      ∀ᶠ Δθ in 𝓝 (0 : ℝ),
        SatisfiesHalfCylindricalSpecularLaw mirror (rayB Δθ)) :
    ((fun Δθ : ℝ =>
        (rayB Δθ).reflectedLine.slope -
          (Real.cot (2 * θ) -
            2 * (Real.sin (2 * θ))⁻¹ ^ 2 * Δθ))
        =O[𝓝 (0 : ℝ)] (fun Δθ : ℝ => Δθ ^ 2)) ∧
      ((fun Δθ : ℝ =>
        (rayB Δθ).reflectedLine.yIntercept -
          (mirror.radius / (2 * Real.cos θ) *
            (1 + Real.tan θ * Δθ)))
        =O[𝓝 (0 : ℝ)] (fun Δθ : ℝ => Δθ ^ 2)) := by
  sorry

end IPhO2026Problems.IPhO2026_2_C_2

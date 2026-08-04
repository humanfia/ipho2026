import Mathlib

open Filter Topology Asymptotics

namespace IPhO2026Problems.IPhO2026_2_C_3

/-- The half-cylindrical mirror in the coordinate system of Figure 2g.

`radiusLengthReadout` is the numerical value of the physical radius in the
fixed length unit used for every coordinate and intercept below. -/
structure Figure2gMirror where
  radiusLengthReadout : ℝ
  radiusLengthReadout_pos : 0 < radiusLengthReadout

/-- A point represented by its two Figure 2g coordinate readouts.
Both components use the same fixed length unit as the mirror radius. -/
structure Figure2gPoint where
  xLengthReadout : ℝ
  yLengthReadout : ℝ

/-- The reflecting upper semicircle shown in Figure 2g. -/
def Figure2gMirror.OnReflectingSurface
    (mirror : Figure2gMirror) (point : Figure2gPoint) : Prop :=
  point.xLengthReadout ^ 2 + point.yLengthReadout ^ 2 =
      mirror.radiusLengthReadout ^ 2 ∧
    0 ≤ point.yLengthReadout

/-- The supporting affine line of a reflected optical ray in Figure 2g.

The slope is a dimensionless ratio, while `yInterceptLengthReadout` has the
same length unit as the coordinates. -/
structure ReflectedRayLine where
  slopeRatio : ℝ
  yInterceptLengthReadout : ℝ

/-- A Figure 2g point lies on the supporting line of a reflected ray. -/
def ReflectedRayLine.Contains
    (ray : ReflectedRayLine) (point : Figure2gPoint) : Prop :=
  point.yLengthReadout =
    ray.slopeRatio * point.xLengthReadout + ray.yInterceptLengthReadout

/-- A point is the intersection of the reflected ray at incidence angle `θ`
(ray A) and the reflected ray at the neighboring angle `θ + Δθ` (ray B). -/
def IsNeighboringReflectedIntersection
    (reflectedRayAtIncidenceAngle : ℝ → ReflectedRayLine)
    (θ Δθ : ℝ) (point : Figure2gPoint) : Prop :=
  (reflectedRayAtIncidenceAngle θ).Contains point ∧
    (reflectedRayAtIncidenceAngle (θ + Δθ)).Contains point

/-- For the half-cylindrical mirror of Figure 2g, the intersections of ray A
with neighboring reflected rays tend to the stated point of the caustic.

The two Big-O hypotheses are precisely the first-order ray-B data from part
C.2, expressed without choosing a particular nonzero `Δθ`. The two equalities
for ray A are the reusable conclusions of part C.1. -/
theorem limitingIntersectionCoordinates
    (mirror : Figure2gMirror)
    (θ : ℝ)
    (reflectedRayAtIncidenceAngle : ℝ → ReflectedRayLine)
    (neighboringIntersection : ℝ → Figure2gPoint)
    (hθ_pos : 0 < θ)
    (hθ_acute : θ < Real.pi / 2)
    (hRayA_slope :
      (reflectedRayAtIncidenceAngle θ).slopeRatio =
        Real.cot (2 * θ))
    (hRayA_intercept :
      (reflectedRayAtIncidenceAngle θ).yInterceptLengthReadout =
        mirror.radiusLengthReadout / (2 * Real.cos θ))
    (hRayB_slope_firstOrder :
      (fun Δθ : ℝ ↦
          (reflectedRayAtIncidenceAngle (θ + Δθ)).slopeRatio -
            (Real.cot (2 * θ) -
              2 * (Real.sin (2 * θ))⁻¹ ^ 2 * Δθ))
        =O[𝓝 0] (fun Δθ : ℝ ↦ Δθ ^ 2))
    (hRayB_intercept_firstOrder :
      (fun Δθ : ℝ ↦
          (reflectedRayAtIncidenceAngle
              (θ + Δθ)).yInterceptLengthReadout -
            ((mirror.radiusLengthReadout / (2 * Real.cos θ)) *
              (1 + Real.tan θ * Δθ)))
        =O[𝓝 0] (fun Δθ : ℝ ↦ Δθ ^ 2))
    (hNeighboringIntersection :
      ∀ᶠ Δθ in 𝓝[≠] (0 : ℝ),
        IsNeighboringReflectedIntersection
          reflectedRayAtIncidenceAngle θ Δθ (neighboringIntersection Δθ)) :
    Tendsto
        (fun Δθ ↦ (neighboringIntersection Δθ).xLengthReadout)
        (𝓝[≠] (0 : ℝ))
        (𝓝 (mirror.radiusLengthReadout * (Real.sin θ) ^ 3)) ∧
      Tendsto
        (fun Δθ ↦ (neighboringIntersection Δθ).yLengthReadout)
        (𝓝[≠] (0 : ℝ))
        (𝓝
          ((mirror.radiusLengthReadout / 2) * Real.cos θ *
            (2 - Real.cos (2 * θ)))) := by
  sorry

end IPhO2026Problems.IPhO2026_2_C_3

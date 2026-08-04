import Mathlib
import Physlib.Units.WithDim.Basic

open Filter Topology Asymptotics

namespace IPhO2026Problems.IPhO2026_2_C_3

/-!
# IPhO 2026, theoretical problem 2, part C.3

The types below distinguish physical lengths from their numerical coordinates.
All equations and limits are expressed through one named projection to the
common length unit of Figure 2g.
-/

/-- A physical length whose values in different unit systems obey Physlib's
dimensional scaling law. -/
abbrev PhysicalLength :=
  Dimensionful (WithDim Dimension.L𝓭 ℝ)

/-- The chosen length-unit projection for the common coordinate frame of
Figure 2g. -/
structure Figure2gLengthProjection where
  unitChoice : UnitChoices

/-- The real coordinate readout of a physical length in the fixed Figure 2g
length unit. -/
def Figure2gLengthProjection.readout
    (projection : Figure2gLengthProjection) (length : PhysicalLength) : ℝ :=
  (length projection.unitChoice).val

/-- The half-cylindrical mirror in the coordinate system of Figure 2g.

The radius is a physical length, rather than a bare scalar readout. -/
structure Figure2gMirror where
  radius : PhysicalLength
  radius_pos : ∀ unitChoice : UnitChoices, 0 < (radius unitChoice).val

/-- A point represented by two physical length coordinates in Figure 2g. -/
structure Figure2gPoint where
  xCoordinate : PhysicalLength
  yCoordinate : PhysicalLength

/-- The reflecting upper semicircle shown in Figure 2g. -/
def Figure2gMirror.OnReflectingSurface
    (projection : Figure2gLengthProjection)
    (mirror : Figure2gMirror) (point : Figure2gPoint) : Prop :=
  projection.readout point.xCoordinate ^ 2 +
        projection.readout point.yCoordinate ^ 2 =
      projection.readout mirror.radius ^ 2 ∧
    0 ≤ projection.readout point.yCoordinate

/-- The supporting affine line of a reflected optical ray in Figure 2g.

The slope is dimensionless, while the intercept is a physical length. -/
structure ReflectedRayLine where
  slopeRatio : ℝ
  yIntercept : PhysicalLength

/-- A Figure 2g point lies on the supporting line of a reflected ray. -/
def ReflectedRayLine.Contains
    (projection : Figure2gLengthProjection)
    (ray : ReflectedRayLine) (point : Figure2gPoint) : Prop :=
  projection.readout point.yCoordinate =
    ray.slopeRatio * projection.readout point.xCoordinate +
      projection.readout ray.yIntercept

/-- A point is the intersection of the reflected ray at incidence angle `θ`
(ray A) and the reflected ray at the neighboring angle `θ + Δθ` (ray B). -/
def IsNeighboringReflectedIntersection
    (projection : Figure2gLengthProjection)
    (reflectedRayAtIncidenceAngle : ℝ → ReflectedRayLine)
    (θ Δθ : ℝ) (point : Figure2gPoint) : Prop :=
  (reflectedRayAtIncidenceAngle θ).Contains projection point ∧
    (reflectedRayAtIncidenceAngle (θ + Δθ)).Contains projection point

/-- For the half-cylindrical mirror of Figure 2g, the intersections of ray A
with neighboring reflected rays tend to the stated point of the caustic.

The two Big-O hypotheses are precisely the first-order ray-B data from part
C.2, expressed without choosing a particular nonzero `Δθ`. The two equalities
for ray A are the reusable conclusions of part C.1. Every length occurring in
these assumptions and in the conclusion is read through the same
`lengthProjection`. -/
theorem limitingIntersectionCoordinates
    (lengthProjection : Figure2gLengthProjection)
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
      lengthProjection.readout
          (reflectedRayAtIncidenceAngle θ).yIntercept =
        lengthProjection.readout mirror.radius / (2 * Real.cos θ))
    (hRayB_slope_firstOrder :
      (fun Δθ : ℝ ↦
          (reflectedRayAtIncidenceAngle (θ + Δθ)).slopeRatio -
            (Real.cot (2 * θ) -
              2 * (Real.sin (2 * θ))⁻¹ ^ 2 * Δθ))
        =O[𝓝 0] (fun Δθ : ℝ ↦ Δθ ^ 2))
    (hRayB_intercept_firstOrder :
      (fun Δθ : ℝ ↦
          lengthProjection.readout
              (reflectedRayAtIncidenceAngle (θ + Δθ)).yIntercept -
            ((lengthProjection.readout mirror.radius /
                (2 * Real.cos θ)) *
              (1 + Real.tan θ * Δθ)))
        =O[𝓝 0] (fun Δθ : ℝ ↦ Δθ ^ 2))
    (hNeighboringIntersection :
      ∀ᶠ Δθ in 𝓝[≠] (0 : ℝ),
        IsNeighboringReflectedIntersection
          lengthProjection reflectedRayAtIncidenceAngle
          θ Δθ (neighboringIntersection Δθ)) :
    Tendsto
        (fun Δθ ↦
          lengthProjection.readout
            (neighboringIntersection Δθ).xCoordinate)
        (𝓝[≠] (0 : ℝ))
        (𝓝
          (lengthProjection.readout mirror.radius *
            (Real.sin θ) ^ 3)) ∧
      Tendsto
        (fun Δθ ↦
          lengthProjection.readout
            (neighboringIntersection Δθ).yCoordinate)
        (𝓝[≠] (0 : ℝ))
        (𝓝
          ((lengthProjection.readout mirror.radius / 2) * Real.cos θ *
            (2 - Real.cos (2 * θ)))) := by
  sorry

end IPhO2026Problems.IPhO2026_2_C_3

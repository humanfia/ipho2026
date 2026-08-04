import Mathlib
import Physlib.Units.WithDim.Basic

open Filter Topology Asymptotics

namespace IPhO2026Problems.IPhO2026_2_C_3

/-!
# IPhO 2026, theoretical problem 2, part C.3 (Figure 2g)

The types below distinguish physical lengths from their numerical
coordinate readouts.  All equations and limits are expressed through one
named projection to the common length unit of Figure 2g, so that the
formalization never identifies a physical length with a bare real number.
-/

/-- A physical length: values in different unit systems obey Physlib's
dimensional scaling law for the length dimension `L𝓭`. -/
abbrev PhysicalLength :=
  Dimensionful (WithDim Dimension.L𝓭 ℝ)

/-- The chosen length-unit projection for the common coordinate frame of
Figure 2g.  All coordinate readouts below are taken with respect to this
single fixed unit choice. -/
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

/-- The reflecting upper semicircle shown in Figure 2g: the upper half of
the circle of radius `R` centred at the origin. -/
def Figure2gMirror.OnReflectingSurface
    (projection : Figure2gLengthProjection)
    (mirror : Figure2gMirror) (point : Figure2gPoint) : Prop :=
  projection.readout point.xCoordinate ^ 2 +
        projection.readout point.yCoordinate ^ 2 =
      projection.readout mirror.radius ^ 2 ∧
    0 ≤ projection.readout point.yCoordinate

/-- The supporting affine line `y = m x + b` of a reflected optical ray in
Figure 2g.  The slope `m` is dimensionless, while the intercept `b` is a
physical length. -/
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
(ray A) and the reflected ray at the neighboring incidence angle `θ + Δθ`
(ray B): both line equations hold simultaneously. -/
def IsNeighboringReflectedIntersection
    (projection : Figure2gLengthProjection)
    (reflectedRayAtIncidenceAngle : ℝ → ReflectedRayLine)
    (θ Δθ : ℝ) (point : Figure2gPoint) : Prop :=
  (reflectedRayAtIncidenceAngle θ).Contains projection point ∧
    (reflectedRayAtIncidenceAngle (θ + Δθ)).Contains projection point

/-- For the half-cylindrical mirror of radius `R` of Figure 2g, the
intersection of the reflected ray A with the reflected neighboring ray B
tends, as `Δθ → 0`, to the caustic point
`X_c = R sin³θ`, `Y_c = (R/2) cos θ (2 - cos 2θ)`.

Assumption/target split:
* `hRayA_slope`, `hRayA_intercept` — the part C.1 results
  `m_A = cot 2θ`, `b_A = R/(2 cos θ)`, reusable previous-part conclusions;
* `hRayB_slope_firstOrder`, `hRayB_intercept_firstOrder` — the part C.2
  first-order expansions of `m_B` and `b_B` in `Δθ`, stated as genuine
  `O(Δθ²)` asymptotic hypotheses on the ray family rather than as the
  values of the limit;
* `hNeighboringIntersection` — for all sufficiently small nonzero `Δθ`
  the two reflected lines meet at `neighboringIntersection Δθ`;
* the conclusion — the limit statement, which is the current target and
  does not occur among the hypotheses. -/
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
            Real.sin θ ^ 3)) ∧
      Tendsto
        (fun Δθ ↦
          lengthProjection.readout
            (neighboringIntersection Δθ).yCoordinate)
        (𝓝[≠] (0 : ℝ))
        (𝓝
          ((lengthProjection.readout mirror.radius / 2) * Real.cos θ *
            (2 - Real.cos (2 * θ)))) := by
  constructor <;> sorry

end IPhO2026Problems.IPhO2026_2_C_3

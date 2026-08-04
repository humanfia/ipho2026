import Mathlib.Analysis.Complex.Trigonometric
import Physlib.Units.WithDim.Basic

namespace IPhO2026Problems
namespace IPhO2026_2_C_1

/-- A point in the Cartesian coordinate convention of Figure 2g.
Both coordinates carry the physical dimension of length. -/
structure PlanePoint where
  x : WithDim Dimension.L𝓭 ℝ
  y : WithDim Dimension.L𝓭 ℝ

/-- The half-cylindrical mirror in Figure 2g, represented by the radius of its
upper semicircular cross-section. The center is the coordinate origin. -/
structure HalfCylindricalMirror where
  radius : WithDim Dimension.L𝓭 ℝ
  radius_pos : 0 < radius

/-- A reflected ray represented in Figure 2g by `y = slope * x + intercept`.
Its direction angle is measured counterclockwise from the positive `x`-axis. -/
structure SlopeInterceptRay where
  slope : ℝ
  intercept : WithDim Dimension.L𝓭 ℝ
  directionAngle : ℝ

/-- A point lies on the upper semicircular mirror centered at the origin. -/
def OnUpperHalfMirror (mirror : HalfCylindricalMirror) (point : PlanePoint) : Prop :=
  point.x.val ^ 2 + point.y.val ^ 2 = mirror.radius.val ^ 2 ∧
    0 ≤ point.y.val

/-- Incidence of a point on the slope-intercept line supporting a ray. -/
def LiesOnRayLine (ray : SlopeInterceptRay) (point : PlanePoint) : Prop :=
  point.y.val = ray.slope * point.x.val + ray.intercept.val

/-- The equal-angle law of specular reflection, written in terms of oriented
direction angles and the tangent line at the impact point. -/
def ObeysSpecularReflection
    (incidentDirection tangentDirection reflectedDirection : ℝ) : Prop :=
  reflectedDirection = 2 * tangentDirection - incidentDirection

/-- For ray `A` in Figure 2g, specular reflection from the centered
half-cylindrical mirror gives the requested slope and length-valued intercept.

The hypotheses separate the physical law from the requested result:
* Figure 2g supplies the impact coordinates, vertical incident direction, and
  tangent direction.
* Specular reflection determines the outgoing direction.
* The slope is the tangent of that direction and the reflected line passes
  through the impact point.
-/
theorem rayA_slope_and_intercept
    (mirror : HalfCylindricalMirror)
    (θ incidentDirection tangentDirection : ℝ)
    (strike : PlanePoint)
    (rayA : SlopeInterceptRay)
    (hθ_pos : 0 < θ)
    (hθ_acute : θ < Real.pi / 2)
    (h_strike_on_mirror : OnUpperHalfMirror mirror strike)
    (h_strike_x :
      strike.x =
        (⟨mirror.radius.val * Real.sin θ⟩ : WithDim Dimension.L𝓭 ℝ))
    (h_strike_y :
      strike.y =
        (⟨mirror.radius.val * Real.cos θ⟩ : WithDim Dimension.L𝓭 ℝ))
    (h_incident_vertical : incidentDirection = Real.pi / 2)
    (h_tangent_direction : tangentDirection = Real.pi - θ)
    (h_reflection :
      ObeysSpecularReflection incidentDirection tangentDirection rayA.directionAngle)
    (h_slope_from_direction : rayA.slope = Real.tan rayA.directionAngle)
    (h_ray_through_strike : LiesOnRayLine rayA strike) :
    rayA.slope = Real.cot (2 * θ) ∧
      rayA.intercept =
        (⟨mirror.radius.val / (2 * Real.cos θ)⟩ :
          WithDim Dimension.L𝓭 ℝ) := by
  sorry

end IPhO2026_2_C_1
end IPhO2026Problems

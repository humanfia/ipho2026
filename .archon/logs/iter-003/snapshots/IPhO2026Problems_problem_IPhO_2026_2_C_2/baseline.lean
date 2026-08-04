import Mathlib.Analysis.Asymptotics.Defs
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Physlib.Units.WithDim.Basic

open Filter Asymptotics
open scoped Topology

namespace IPhO2026_2_C_2

open Dimension

/-- A physical length, independent of the unit used for its scalar readout. -/
abbrev PhysicalLength := Dimensionful (WithDim L𝓭 ℝ)

/-- The scalar projection of a physical length into the common coordinate unit
chosen for Figure 2g. -/
noncomputable def figure2gLengthReadout
    (coordinateUnits : UnitChoices) (length : PhysicalLength) : ℝ :=
  (length coordinateUnits).val

/-- The data of a reflected ray in the coordinate convention of Figure 2g.

The slope is dimensionless, while the intercept is a physical length. -/
structure ReflectedRayReadout where
  slope : ℝ
  intercept : PhysicalLength

/-- The equation `y = m * x + b` used for the reflected rays in Figure 2g. -/
noncomputable def ReflectedRayReadout.yCoordinateLengthReadout
    (coordinateUnits : UnitChoices)
    (ray : ReflectedRayReadout) (x : PhysicalLength) : ℝ :=
  ray.slope * figure2gLengthReadout coordinateUnits x +
    figure2gLengthReadout coordinateUnits ray.intercept

/-- Physical and figure data for the half-cylindrical mirror.

Angles are dimensionless radian readouts. The function `reflectedRayReadoutAt`
describes the reflected members of the one parallel incident beam shown in
Figure 2g, indexed by their angle at the circular mirror. -/
structure Figure2gSetup where
  coordinateUnits : UnitChoices
  radius : PhysicalLength
  incidenceAngleRad : ℝ
  reflectedRayReadoutAt : ℝ → ReflectedRayReadout
  radiusLengthReadout_pos :
    0 < figure2gLengthReadout coordinateUnits radius
  incidenceAngleRad_pos : 0 < incidenceAngleRad
  incidenceAngleRad_lt_pi_div_two : incidenceAngleRad < Real.pi / 2

/-- Ray `A` is the reflected ray at the central incidence angle `θ`. -/
def rayA (setup : Figure2gSetup) : ReflectedRayReadout :=
  setup.reflectedRayReadoutAt setup.incidenceAngleRad

/-- Ray `B` is the neighboring reflected ray at angle `θ + Δθ`. -/
def rayB (setup : Figure2gSetup) (angularIncrementRad : ℝ) : ReflectedRayReadout :=
  setup.reflectedRayReadoutAt (setup.incidenceAngleRad + angularIncrementRad)

/-- The specular-reflection geometry law for the half-cylindrical mirror.

This is a governing law, stated for every physically admissible angle. It is
the exact relation to be Taylor-expanded; it does not assert either requested
first-order expansion. -/
def HalfCylindricalReflectionLaw (setup : Figure2gSetup) : Prop :=
  ∀ angleRad : ℝ, 0 < angleRad → angleRad < Real.pi / 2 →
    (setup.reflectedRayReadoutAt angleRad).slope = Real.cot (2 * angleRad) ∧
    figure2gLengthReadout setup.coordinateUnits
        (setup.reflectedRayReadoutAt angleRad).intercept =
      figure2gLengthReadout setup.coordinateUnits setup.radius /
        (2 * Real.cos angleRad)

/-- The reusable result of part C.1 for the line of ray `A`. -/
def PreviousPartC1Result (setup : Figure2gSetup) : Prop :=
  (rayA setup).slope = Real.cot (2 * setup.incidenceAngleRad) ∧
  figure2gLengthReadout setup.coordinateUnits (rayA setup).intercept =
    figure2gLengthReadout setup.coordinateUnits setup.radius /
      (2 * Real.cos setup.incidenceAngleRad)

/-- The first-order slope formula for neighboring ray `B`, with a remainder
bounded by a constant times `(Δθ)²` as `Δθ → 0`. -/
theorem rayB_slope_firstOrder
    (setup : Figure2gSetup)
    (reflectionLaw : HalfCylindricalReflectionLaw setup)
    (previousPart : PreviousPartC1Result setup) :
    (fun angularIncrementRad : ℝ =>
        (rayB setup angularIncrementRad).slope -
          (Real.cot (2 * setup.incidenceAngleRad) -
            2 * (Real.sin (2 * setup.incidenceAngleRad))⁻¹ ^ 2 *
              angularIncrementRad))
      =O[𝓝 0] (fun angularIncrementRad : ℝ => angularIncrementRad ^ 2) := by
  sorry

/-- The first-order intercept formula for neighboring ray `B`, with a
remainder bounded by a constant times `(Δθ)²` as `Δθ → 0`. -/
theorem rayB_intercept_firstOrder
    (setup : Figure2gSetup)
    (reflectionLaw : HalfCylindricalReflectionLaw setup)
    (previousPart : PreviousPartC1Result setup) :
    (fun angularIncrementRad : ℝ =>
        figure2gLengthReadout setup.coordinateUnits
            (rayB setup angularIncrementRad).intercept -
          (figure2gLengthReadout setup.coordinateUnits setup.radius /
              (2 * Real.cos setup.incidenceAngleRad) *
            (1 + Real.tan setup.incidenceAngleRad * angularIncrementRad)))
      =O[𝓝 0] (fun angularIncrementRad : ℝ => angularIncrementRad ^ 2) := by
  sorry

/-- IPhO 2026 Problem 2 C.2: both requested first-order expansions of ray `B`.

The two conclusions say precisely that the displayed residuals are
`O((Δθ)²)` in the neighboring-ray limit `Δθ → 0`. -/
theorem IPhO_2026_2_C_2
    (setup : Figure2gSetup)
    (reflectionLaw : HalfCylindricalReflectionLaw setup)
    (previousPart : PreviousPartC1Result setup) :
    ((fun angularIncrementRad : ℝ =>
          (rayB setup angularIncrementRad).slope -
            (Real.cot (2 * setup.incidenceAngleRad) -
              2 * (Real.sin (2 * setup.incidenceAngleRad))⁻¹ ^ 2 *
                angularIncrementRad))
        =O[𝓝 0] (fun angularIncrementRad : ℝ => angularIncrementRad ^ 2)) ∧
      ((fun angularIncrementRad : ℝ =>
          figure2gLengthReadout setup.coordinateUnits
              (rayB setup angularIncrementRad).intercept -
            (figure2gLengthReadout setup.coordinateUnits setup.radius /
                (2 * Real.cos setup.incidenceAngleRad) *
              (1 + Real.tan setup.incidenceAngleRad * angularIncrementRad)))
        =O[𝓝 0] (fun angularIncrementRad : ℝ => angularIncrementRad ^ 2)) := by
  sorry

end IPhO2026_2_C_2

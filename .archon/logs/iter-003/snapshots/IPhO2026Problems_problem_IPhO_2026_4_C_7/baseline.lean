import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Physlib.Units.WithDim.Basic

/-!
# IPhO 2026, experimental problem 1, part C.7

This file models radial heat conduction through the acrylic wall separating
the inner cylinder (IC) and outer cylinder (OC). Physical quantities use
Physlib's dimension-tagged, unit-dependent representation. Equations are
stated using their SI scalar readouts.
-/

namespace IPhO2026Problems.IPhO2026_4_C_7

open Dimension

/-- The physical dimension of energy per unit time. -/
def powerDimension : Dimension :=
  M𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹ * T𝓭⁻¹

/-- The physical dimension kelvin per watt. -/
def thermalResistanceDimension : Dimension :=
  Θ𝓭 * powerDimension⁻¹

/-- The physical dimension watt per metre-kelvin. -/
def thermalConductivityDimension : Dimension :=
  powerDimension * L𝓭⁻¹ * Θ𝓭⁻¹

/-- The physical dimension joule per kilogram-kelvin. -/
def specificHeatCapacityDimension : Dimension :=
  L𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹ * Θ𝓭⁻¹

/-- A unit-independent length quantity. -/
abbrev DimLength : Type :=
  Dimensionful (WithDim L𝓭 ℝ)

/-- A unit-independent mass quantity. -/
abbrev DimMass : Type :=
  Dimensionful (WithDim M𝓭 ℝ)

/-- A unit-independent temperature quantity. -/
abbrev DimTemperature : Type :=
  Dimensionful (WithDim Θ𝓭 ℝ)

/-- A unit-independent signed heat-flow rate (power). -/
abbrev DimPower : Type :=
  Dimensionful (WithDim powerDimension ℝ)

/-- A unit-independent thermal resistance. -/
abbrev DimThermalResistance : Type :=
  Dimensionful (WithDim thermalResistanceDimension ℝ)

/-- A unit-independent thermal conductivity. -/
abbrev DimThermalConductivity : Type :=
  Dimensionful (WithDim thermalConductivityDimension ℝ)

/-- A unit-independent specific heat capacity. -/
abbrev DimSpecificHeatCapacity : Type :=
  Dimensionful (WithDim specificHeatCapacityDimension ℝ)

/-- A unit-independent inverse-time quantity, used for the C.5 graph slope. -/
abbrev DimInverseTime : Type :=
  Dimensionful (WithDim T𝓭⁻¹ ℝ)

/-- The numerical value of a dimension-tagged real quantity in SI units. -/
noncomputable def siValue {d : Dimension}
    (quantity : Dimensionful (WithDim d ℝ)) : ℝ :=
  (quantity UnitChoices.SI).val

/--
The Figure 17 and procedure geometry.

`innerRadius` and `outerRadius` are the radii labelled `r₁` and `r₂`.
The two water levels are the C-part procedure settings, and
`activeWallHeight` is the height `h` over which radial conduction occurs.
-/
structure ApparatusGeometry where
  innerRadius : DimLength
  outerRadius : DimLength
  innerWaterHeight : DimLength
  outerWaterHeight : DimLength
  activeWallHeight : DimLength

/--
The geometric and procedural readouts used in C.7.

The official procedure sets the IC water level to 10 cm and the OC water
level to 15 cm. Only the common wetted height of the separating wall
contributes to the cylindrical conduction area.
-/
structure Figure17AndProcedureReadout (geometry : ApparatusGeometry) : Prop where
  innerRadius_positive : 0 < siValue geometry.innerRadius
  outerRadius_greater :
    siValue geometry.innerRadius < siValue geometry.outerRadius
  innerWaterHeight_meters :
    siValue geometry.innerWaterHeight = 0.10
  outerWaterHeight_meters :
    siValue geometry.outerWaterHeight = 0.15
  activeWallHeight_is_innerWaterHeight :
    geometry.activeWallHeight = geometry.innerWaterHeight

/--
Data reused from the preceding subquestion C.6. The graph slope has units
of inverse seconds, so `c₀ * m * slope` has units watt per kelvin.
-/
structure PreviousPartC6Data where
  waterSpecificHeatCapacity : DimSpecificHeatCapacity
  innerWaterMass : DimMass
  graphSlope : DimInverseTime
  effectiveWallThermalResistance : DimThermalResistance

/--
The reusable C.6 result, stated independently rather than importing a Lean
declaration from the previous part.
-/
structure PreviousPartC6Result (data : PreviousPartC6Data) : Prop where
  specificHeatCapacity_positive :
    0 < siValue data.waterSpecificHeatCapacity
  innerWaterMass_positive :
    0 < siValue data.innerWaterMass
  graphSlope_positive :
    0 < siValue data.graphSlope
  resistance_from_graph :
    siValue data.effectiveWallThermalResistance =
      1 / (siValue data.waterSpecificHeatCapacity *
        siValue data.innerWaterMass * siValue data.graphSlope)
  official_sample_compatible :
    |siValue data.effectiveWallThermalResistance - 1.17| ≤ 0.03

/--
Quantities recorded or modeled in the C-part thermal experiment.

Time arguments are SI readouts in seconds, and radius arguments are SI
readouts in metres. `radialTemperatureKelvin` and
`radialTemperatureGradientKelvinPerMeter` are the corresponding measured
scalar components of the dimensionful temperature field.
-/
structure ThermalConductionExperiment where
  geometry : ApparatusGeometry
  previousPartC6 : PreviousPartC6Data
  innerTemperature : ℝ → DimTemperature
  outerTemperature : ℝ → DimTemperature
  radialTemperatureKelvin : ℝ → ℝ → ℝ
  radialTemperatureGradientKelvinPerMeter : ℝ → ℝ → ℝ
  heatReceivedByInnerCylinder : ℝ → DimPower
  signedOutwardRadialHeatFlow : ℝ → DimPower
  acrylicConductivity : DimThermalConductivity

/-- Lateral area `2 π r h` of the active cylindrical wall, in square metres. -/
noncomputable def cylindricalWallAreaMetersSquared
    (geometry : ApparatusGeometry) (radiusMeters : ℝ) : ℝ :=
  2 * Real.pi * radiusMeters * siValue geometry.activeWallHeight

/--
The governing physical laws for the experiment.

Equation (4) describes positive heat received by IC. Equation (6) uses
outward radial orientation, so the signed Fourier heat flow is the negative
of the inward heat-reception rate.
-/
structure CylindricalConductionLaws
    (experiment : ThermalConductionExperiment) : Prop where
  thermalResistance_positive :
    0 < siValue experiment.previousPartC6.effectiveWallThermalResistance
  conductivity_positive :
    0 < siValue experiment.acrylicConductivity
  inner_boundary_temperature :
    ∀ timeSeconds : ℝ,
      experiment.radialTemperatureKelvin timeSeconds
          (siValue experiment.geometry.innerRadius) =
        siValue (experiment.innerTemperature timeSeconds)
  outer_boundary_temperature :
    ∀ timeSeconds : ℝ,
      experiment.radialTemperatureKelvin timeSeconds
          (siValue experiment.geometry.outerRadius) =
        siValue (experiment.outerTemperature timeSeconds)
  radial_temperature_has_gradient :
    ∀ (timeSeconds radiusMeters : ℝ),
      radiusMeters ∈ Set.Icc
        (siValue experiment.geometry.innerRadius)
        (siValue experiment.geometry.outerRadius) →
      HasDerivAt
        (experiment.radialTemperatureKelvin timeSeconds)
        (experiment.radialTemperatureGradientKelvinPerMeter
          timeSeconds radiusMeters)
        radiusMeters
  heat_flow_relation :
    ∀ timeSeconds : ℝ,
      siValue (experiment.heatReceivedByInnerCylinder timeSeconds) =
        (siValue (experiment.outerTemperature timeSeconds) -
          siValue (experiment.innerTemperature timeSeconds)) /
        siValue experiment.previousPartC6.effectiveWallThermalResistance
  radial_orientation :
    ∀ timeSeconds : ℝ,
      siValue (experiment.signedOutwardRadialHeatFlow timeSeconds) =
        -siValue (experiment.heatReceivedByInnerCylinder timeSeconds)
  radial_fourier_law :
    ∀ (timeSeconds radiusMeters : ℝ),
      radiusMeters ∈ Set.Icc
        (siValue experiment.geometry.innerRadius)
        (siValue experiment.geometry.outerRadius) →
      siValue (experiment.signedOutwardRadialHeatFlow timeSeconds) =
        -siValue experiment.acrylicConductivity *
          cylindricalWallAreaMetersSquared experiment.geometry radiusMeters *
          experiment.radialTemperatureGradientKelvinPerMeter
            timeSeconds radiusMeters

/--
Combining the measured wall resistance with radial Fourier conduction gives
the acrylic thermal conductivity

`λ = log (r₂ / r₁) / (2 π h R_Th)`.
-/
theorem acrylicConductivity_from_radial_fourier
    (experiment : ThermalConductionExperiment)
    (figureReadout : Figure17AndProcedureReadout experiment.geometry)
    (previousPart : PreviousPartC6Result experiment.previousPartC6)
    (laws : CylindricalConductionLaws experiment)
    (observationTimeSeconds : ℝ)
    (temperatureDifference_nonzero :
      siValue (experiment.outerTemperature observationTimeSeconds) -
          siValue (experiment.innerTemperature observationTimeSeconds) ≠ 0) :
    siValue experiment.acrylicConductivity =
      Real.log
          (siValue experiment.geometry.outerRadius /
            siValue experiment.geometry.innerRadius) /
        (2 * Real.pi * siValue experiment.geometry.activeWallHeight *
          siValue experiment.previousPartC6.effectiveWallThermalResistance) := by
  sorry

end IPhO2026Problems.IPhO2026_4_C_7

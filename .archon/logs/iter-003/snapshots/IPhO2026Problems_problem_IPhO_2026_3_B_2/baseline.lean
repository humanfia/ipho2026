import Mathlib
import Physlib.Units.WithDim.Basic

/-!
# IPhO 2026 Problem 3, part B.2

An adiabatic change of the magnetic-field-strength magnitude of a paramagnetic
torus changes its temperature.  The physical quantities below are tagged with
their dimensions using `Physlib.WithDim`.  Calculus is performed on their
coherent-SI scalar readouts, exposed by `WithDim.val`.
-/

namespace IPhO2026Problems.IPhO2026_3_B_2

open Dimension
open Set

/-! ## Dimensions and physical quantities -/

/-- The dimension of volume. -/
def volumeDimension : Dimension := L𝓭 ^ 3

/-- The dimension of energy. -/
def energyDimension : Dimension := M𝓭 * L𝓭 ^ 2 * T𝓭⁻¹ ^ 2

/-- The dimension of both magnetic field strength `H` and magnetization `M`. -/
def magneticFieldStrengthDimension : Dimension := C𝓭 * T𝓭⁻¹ * L𝓭⁻¹

/-- The dimension of heat capacity. -/
def heatCapacityDimension : Dimension := energyDimension * Θ𝓭⁻¹

/--
The dimension assigned to the Curie-law constant `K`.

`Physlib.Dimension` does not include amount of substance among its base
dimensions, so the mole readout `n` is kept separately and `K` carries the
remaining temperature-times-volume dimension.
-/
def curieConstantDimension : Dimension := Θ𝓭 * volumeDimension

/-- The dimension of the heat-capacity parameter `λ`. -/
def heatCapacityParameterDimension : Dimension := energyDimension * Θ𝓭

/-- The SI dimension of vacuum permeability `μ₀`. -/
def vacuumPermeabilityDimension : Dimension := M𝓭 * L𝓭 * C𝓭⁻¹ ^ 2

abbrev TemperatureQuantity := WithDim Θ𝓭 ℝ
abbrev VolumeQuantity := WithDim volumeDimension ℝ
abbrev EnergyQuantity := WithDim energyDimension ℝ
abbrev MagneticFieldStrengthQuantity := WithDim magneticFieldStrengthDimension ℝ
abbrev MagnetizationQuantity := WithDim magneticFieldStrengthDimension ℝ
abbrev HeatCapacityQuantity := WithDim heatCapacityDimension ℝ
abbrev CurieConstantQuantity := WithDim curieConstantDimension ℝ
abbrev HeatCapacityParameterQuantity := WithDim heatCapacityParameterDimension ℝ
abbrev VacuumPermeabilityQuantity := WithDim vacuumPermeabilityDimension ℝ

/-! ## Torus data and process readouts -/

/--
Fixed data of the paramagnetic torus.  The real components are coherent-SI
readouts.  Positivity records physical admissibility, not the requested
temperature-change formula.
-/
structure ParamagneticTorusModel where
  /-- Amount of paramagnetic material, measured in moles. -/
  amountInMoles : ℝ
  /-- The fixed volume `V` of the torus. -/
  volumeSI : VolumeQuantity
  /-- The constant `K` in `T M V = n K H`. -/
  curieConstantSI : CurieConstantQuantity
  /-- The constant `λ` in `C_M = n λ / T²`. -/
  heatCapacityParameterSI : HeatCapacityParameterQuantity
  /-- Vacuum permeability `μ₀`. -/
  vacuumPermeabilitySI : VacuumPermeabilityQuantity
  amountInMoles_pos : 0 < amountInMoles
  volume_pos : 0 < volumeSI.val
  curieConstant_pos : 0 < curieConstantSI.val
  heatCapacityParameter_pos : 0 < heatCapacityParameterSI.val
  vacuumPermeability_pos : 0 < vacuumPermeabilitySI.val

/--
Measured quantities along a dimensionless process parameter `s`.

The interval endpoints `s = 0` and `s = 1` represent the incoming and outgoing
states.  Since `s` is dimensionless, the heat and work input rates below have
the dimension of energy.
-/
structure AdiabaticPathReadout where
  temperatureSI : ℝ → TemperatureQuantity
  fieldStrengthMagnitudeSI : ℝ → MagneticFieldStrengthQuantity
  magnetizationMagnitudeSI : ℝ → MagnetizationQuantity
  internalEnergySI : ℝ → EnergyQuantity
  heatCapacityAtConstantMagnetizationSI : ℝ → HeatCapacityQuantity
  heatInputRateSI : ℝ → EnergyQuantity
  workInputRateSI : ℝ → EnergyQuantity

/-- The closed parameter interval occupied by the change. -/
def processDomain : Set ℝ := Set.Icc 0 1

/--
The governing laws and endpoint readouts for a quasistatic adiabatic change.

The sign convention is exposed by `first_law`: positive `heatInputRateSI` and
positive `workInputRateSI` both increase the internal energy.  The field
`magnetic_work` is the reusable conclusion of part A.3.
-/
structure IsAdiabaticQuasistaticChange
    (model : ParamagneticTorusModel)
    (path : AdiabaticPathReadout)
    (initialTemperature finalTemperature : TemperatureQuantity)
    (initialFieldStrength finalFieldStrength : MagneticFieldStrengthQuantity) : Prop where
  temperature_differentiable :
    DifferentiableOn ℝ (fun s => (path.temperatureSI s).val) processDomain
  fieldStrength_differentiable :
    DifferentiableOn ℝ (fun s => (path.fieldStrengthMagnitudeSI s).val) processDomain
  magnetization_differentiable :
    DifferentiableOn ℝ (fun s => (path.magnetizationMagnitudeSI s).val) processDomain
  internalEnergy_differentiable :
    DifferentiableOn ℝ (fun s => (path.internalEnergySI s).val) processDomain
  initial_temperature : path.temperatureSI 0 = initialTemperature
  final_temperature : path.temperatureSI 1 = finalTemperature
  initial_field_strength : path.fieldStrengthMagnitudeSI 0 = initialFieldStrength
  final_field_strength : path.fieldStrengthMagnitudeSI 1 = finalFieldStrength
  temperature_positive :
    ∀ s ∈ processDomain, 0 < (path.temperatureSI s).val
  fieldStrengthMagnitude_nonnegative :
    ∀ s ∈ processDomain, 0 ≤ (path.fieldStrengthMagnitudeSI s).val
  magnetizationMagnitude_nonnegative :
    ∀ s ∈ processDomain, 0 ≤ (path.magnetizationMagnitudeSI s).val
  equation_of_state :
    ∀ s ∈ processDomain,
      (path.temperatureSI s).val
          * (path.magnetizationMagnitudeSI s).val
          * model.volumeSI.val =
        model.amountInMoles * model.curieConstantSI.val
          * (path.fieldStrengthMagnitudeSI s).val
  heat_capacity :
    ∀ s ∈ processDomain,
      (path.heatCapacityAtConstantMagnetizationSI s).val =
        model.amountInMoles * model.heatCapacityParameterSI.val
          / (path.temperatureSI s).val ^ 2
  internal_energy_change :
    ∀ s ∈ processDomain,
      derivWithin (fun u => (path.internalEnergySI u).val) processDomain s =
        (path.heatCapacityAtConstantMagnetizationSI s).val
          * derivWithin (fun u => (path.temperatureSI u).val) processDomain s
  adiabatic :
    ∀ s ∈ processDomain, (path.heatInputRateSI s).val = 0
  first_law :
    ∀ s ∈ processDomain,
      derivWithin (fun u => (path.internalEnergySI u).val) processDomain s =
        (path.heatInputRateSI s).val + (path.workInputRateSI s).val
  magnetic_work :
    ∀ s ∈ processDomain,
      (path.workInputRateSI s).val =
        model.vacuumPermeabilitySI.val * model.volumeSI.val
          * (path.fieldStrengthMagnitudeSI s).val
          * derivWithin (fun u => (path.magnetizationMagnitudeSI u).val)
              processDomain s

/-! ## Derivability bridges -/

/--
The differential laws reduce to the separable magnetocaloric ODE.  This is the
algebra-and-product-rule bridge from the physical assumptions to the invariant
used in the endpoint calculation.
-/
theorem reduced_adiabatic_temperature_ode
    (model : ParamagneticTorusModel)
    (path : AdiabaticPathReadout)
    (initialTemperature finalTemperature : TemperatureQuantity)
    (initialFieldStrength finalFieldStrength : MagneticFieldStrengthQuantity)
    (hphysics : IsAdiabaticQuasistaticChange model path
      initialTemperature finalTemperature initialFieldStrength finalFieldStrength)
    (s : ℝ) (hs : s ∈ processDomain) :
    (model.heatCapacityParameterSI.val
          + model.vacuumPermeabilitySI.val * model.curieConstantSI.val
            * (path.fieldStrengthMagnitudeSI s).val ^ 2)
        * derivWithin (fun u => (path.temperatureSI u).val) processDomain s =
      model.vacuumPermeabilitySI.val * model.curieConstantSI.val
        * (path.fieldStrengthMagnitudeSI s).val
        * (path.temperatureSI s).val
        * derivWithin (fun u => (path.fieldStrengthMagnitudeSI u).val)
            processDomain s := by
  sorry

/-- The positive energy-times-temperature scale occurring in the ODE. -/
def magnetothermalScaleSI
    (model : ParamagneticTorusModel) (path : AdiabaticPathReadout) (s : ℝ) : ℝ :=
  model.heatCapacityParameterSI.val
    + model.vacuumPermeabilitySI.val * model.curieConstantSI.val
      * (path.fieldStrengthMagnitudeSI s).val ^ 2

/-- The path invariant obtained by separating the reduced ODE. -/
noncomputable def magnetothermalInvariantSI
    (model : ParamagneticTorusModel) (path : AdiabaticPathReadout) (s : ℝ) : ℝ :=
  (path.temperatureSI s).val ^ 2 / magnetothermalScaleSI model path s

/--
Along any admissible adiabatic path, `T² / (λ + μ₀ K H²)` is constant.
Mathlib's derivative-zero-on-an-interval theorem can carry the final
calculus step once the reduced ODE has been established.
-/
theorem magnetothermal_invariant_constant
    (model : ParamagneticTorusModel)
    (path : AdiabaticPathReadout)
    (initialTemperature finalTemperature : TemperatureQuantity)
    (initialFieldStrength finalFieldStrength : MagneticFieldStrengthQuantity)
    (hphysics : IsAdiabaticQuasistaticChange model path
      initialTemperature finalTemperature initialFieldStrength finalFieldStrength) :
    ∀ s ∈ processDomain,
      magnetothermalInvariantSI model path s =
        magnetothermalInvariantSI model path 0 := by
  sorry

/-! ## Current subquestion -/

/--
For an adiabatic change from `Hᵢ` to `H_f`, the requested temperature change
`ΔT = T_f - Tᵢ`.

The positivity assumptions in the physical model and along the path select the
positive square-root branch.
-/
theorem adiabatic_temperature_change
    (model : ParamagneticTorusModel)
    (path : AdiabaticPathReadout)
    (initialTemperature finalTemperature : TemperatureQuantity)
    (initialFieldStrength finalFieldStrength : MagneticFieldStrengthQuantity)
    (hphysics : IsAdiabaticQuasistaticChange model path
      initialTemperature finalTemperature initialFieldStrength finalFieldStrength) :
    finalTemperature.val - initialTemperature.val =
      initialTemperature.val *
        (Real.sqrt
            ((model.heatCapacityParameterSI.val
                + model.vacuumPermeabilitySI.val * model.curieConstantSI.val
                  * finalFieldStrength.val ^ 2) /
              (model.heatCapacityParameterSI.val
                + model.vacuumPermeabilitySI.val * model.curieConstantSI.val
                  * initialFieldStrength.val ^ 2)) - 1) := by
  sorry

end IPhO2026Problems.IPhO2026_3_B_2

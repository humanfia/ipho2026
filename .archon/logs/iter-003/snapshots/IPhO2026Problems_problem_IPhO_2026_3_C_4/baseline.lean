import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Physlib.Units.WithDim.Basic

namespace IPhO2026Problems
namespace IPhO2026_3_C_4

open Dimension

/-!
The types below use `WithDim` to keep the dimensional role of every physical
quantity visible. Their real-valued projections are readouts in one fixed
coherent unit convention.
-/

/-- The mechanical-energy dimension `M L² T⁻²`. -/
abbrev EnergyDimension : Dimension :=
  M𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹

/-- An absolute-temperature quantity. -/
abbrev TemperatureQuantity : Type := WithDim Θ𝓭 ℝ

/-- An elapsed-time quantity. -/
abbrev TimeQuantity : Type := WithDim T𝓭 ℝ

/-- A volume quantity. -/
abbrev VolumeQuantity : Type := WithDim (L𝓭 * L𝓭 * L𝓭) ℝ

/-- An `A/m` magnetic-field-strength or magnetization quantity. -/
abbrev MagneticFieldStrengthQuantity : Type :=
  WithDim (C𝓭 * T𝓭⁻¹ * L𝓭⁻¹) ℝ

/-- A constant-volume heat capacity, with dimension energy/temperature. -/
abbrev HeatCapacityQuantity : Type :=
  WithDim (EnergyDimension * Θ𝓭⁻¹) ℝ

/-- A power or heat-transfer-rate quantity, with dimension energy/time. -/
abbrev PowerQuantity : Type :=
  WithDim (EnergyDimension * T𝓭⁻¹) ℝ

/-- The four labelled states in the `H`-versus-`T` Carnot-cycle figure. -/
inductive CarnotCycleState
  | state1
  | state2
  | state3
  | state4
  deriving DecidableEq

namespace CarnotCycleState

/-- The oriented cycle read from Figure 3b: `1 → 2 → 3 → 4 → 1`. -/
def next : CarnotCycleState → CarnotCycleState
  | state1 => state2
  | state2 => state3
  | state3 => state4
  | state4 => state1

end CarnotCycleState

/--
The paramagnetic-torus context inherited by part C. The amount of substance
and Curie constant are explicitly SI scalar readouts because Physlib's
foundational `Dimension` currently has no amount-of-substance component.
-/
structure ParamagneticTorusContext where
  volume : VolumeQuantity
  amountOfSubstanceMoles : ℝ
  curieConstantSI : ℝ
  temperature : CarnotCycleState → TemperatureQuantity
  magnetization : CarnotCycleState → MagneticFieldStrengthQuantity
  magneticField : CarnotCycleState → MagneticFieldStrengthQuantity
  volume_pos : 0 < volume.val
  amountOfSubstanceMoles_pos : 0 < amountOfSubstanceMoles
  curieConstantSI_pos : 0 < curieConstantSI
  temperature_pos : ∀ state, 0 < (temperature state).val
  equationOfState : ∀ state,
    (temperature state).val * (magnetization state).val * volume.val =
      amountOfSubstanceMoles * curieConstantSI * (magneticField state).val

/--
The fixed data of the cooling experiment. Constancy of `heatCapacity`,
`inputPower`, and `hotReservoirTemperature` is represented by their being
single experiment parameters rather than time-dependent functions.
-/
structure CarnotCoolingExperiment where
  torus : ParamagneticTorusContext
  heatCapacity : HeatCapacityQuantity
  inputPower : PowerQuantity
  hotReservoirTemperature : TemperatureQuantity
  initialTemperature : TemperatureQuantity
  finalTemperature : TemperatureQuantity
  elapsedTime : TimeQuantity
  heatCapacity_pos : 0 < heatCapacity.val
  inputPower_pos : 0 < inputPower.val
  finalTemperature_pos : 0 < finalTemperature.val
  finalTemperature_lt_initial : finalTemperature.val < initialTemperature.val
  initialTemperature_lt_hot :
    initialTemperature.val < hotReservoirTemperature.val
  elapsedTime_nonneg : 0 ≤ elapsedTime.val

/--
Time-dependent readouts for the body temperature and the magnitudes of the
cold- and hot-side heat-transfer rates.
-/
structure CarnotCoolingProcess where
  temperatureTrajectory : ℝ → TemperatureQuantity
  coldHeatAbsorptionRate : ℝ → PowerQuantity
  hotHeatDeliveryRate : ℝ → PowerQuantity

/--
The governing laws for the continuously repeated Carnot cycles. The three
last fields encode, respectively, `dQ_c / dQ_h = T_c / T_h`,
`dQ_c = -C_c dT_c`, and `P = dQ_h/dt - dQ_c/dt`.
-/
structure SatisfiesCarnotCoolingLaw
    (experiment : CarnotCoolingExperiment)
    (process : CarnotCoolingProcess) : Prop where
  temperatureReadout_differentiable :
    Differentiable ℝ (fun τ => (process.temperatureTrajectory τ).val)
  initial_condition :
    (process.temperatureTrajectory 0).val =
      experiment.initialTemperature.val
  final_condition :
    (process.temperatureTrajectory experiment.elapsedTime.val).val =
      experiment.finalTemperature.val
  temperature_pos_on_run : ∀ τ ∈ Set.Icc 0 experiment.elapsedTime.val,
    0 < (process.temperatureTrajectory τ).val
  temperature_lt_hot_on_run : ∀ τ ∈ Set.Icc 0 experiment.elapsedTime.val,
    (process.temperatureTrajectory τ).val <
      experiment.hotReservoirTemperature.val
  coldHeatAbsorptionRate_pos : ∀ τ ∈ Set.Icc 0 experiment.elapsedTime.val,
    0 < (process.coldHeatAbsorptionRate τ).val
  hotHeatDeliveryRate_pos : ∀ τ ∈ Set.Icc 0 experiment.elapsedTime.val,
    0 < (process.hotHeatDeliveryRate τ).val
  carnot_heat_ratio : ∀ τ ∈ Set.Icc 0 experiment.elapsedTime.val,
    (process.coldHeatAbsorptionRate τ).val /
        (process.hotHeatDeliveryRate τ).val =
      (process.temperatureTrajectory τ).val /
        experiment.hotReservoirTemperature.val
  body_heat_balance : ∀ τ ∈ Set.Icc 0 experiment.elapsedTime.val,
    (process.coldHeatAbsorptionRate τ).val =
      -experiment.heatCapacity.val *
        deriv (fun s => (process.temperatureTrajectory s).val) τ
  refrigerator_power_balance : ∀ τ ∈ Set.Icc 0 experiment.elapsedTime.val,
    (process.hotHeatDeliveryRate τ).val -
        (process.coldHeatAbsorptionRate τ).val =
      experiment.inputPower.val

/--
Eliminating the cold- and hot-side heat rates gives the instantaneous cooling
equation that will be integrated in `elapsed_time_formula`.
-/
theorem instantaneous_cooling_power_equation
    (experiment : CarnotCoolingExperiment)
    (process : CarnotCoolingProcess)
    (law : SatisfiesCarnotCoolingLaw experiment process)
    (τ : ℝ) (hτ : τ ∈ Set.Icc 0 experiment.elapsedTime.val) :
    experiment.inputPower.val =
      experiment.heatCapacity.val *
        (experiment.hotReservoirTemperature.val /
          (process.temperatureTrajectory τ).val - 1) *
        (-deriv (fun s => (process.temperatureTrajectory s).val) τ) := by
  sorry

/--
The required running time for cooling the body from `T₀` to `T` with constant
heat capacity, constant refrigerator input power, and constant hot-reservoir
temperature.
-/
theorem elapsed_time_formula
    (experiment : CarnotCoolingExperiment)
    (process : CarnotCoolingProcess)
    (law : SatisfiesCarnotCoolingLaw experiment process) :
    experiment.elapsedTime.val =
      (experiment.heatCapacity.val *
          experiment.hotReservoirTemperature.val /
        experiment.inputPower.val) *
      (Real.log (experiment.initialTemperature.val /
          experiment.finalTemperature.val) -
        (experiment.initialTemperature.val -
            experiment.finalTemperature.val) /
          experiment.hotReservoirTemperature.val) := by
  sorry

end IPhO2026_3_C_4
end IPhO2026Problems

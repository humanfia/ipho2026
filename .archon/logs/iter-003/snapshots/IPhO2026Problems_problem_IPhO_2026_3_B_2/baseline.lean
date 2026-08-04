import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Real.Sqrt
import Physlib.Units.WithDim.Energy

/-!
# IPhO 2026, problem 3, part B.2

This file models the adiabatic change of the applied magnetic-field magnitude
for the fixed-volume paramagnetic torus (Pm-T).  Physical quantities supported
by Physlib are dimension-tagged and independent of a choice of units.  The
thermodynamic laws are stated using their SI readouts along a dimensionless
process parameter `τ ∈ [0, 1]`.

The amount of substance is recorded by its numerical value in moles because
Physlib's foundational `Dimension` currently has no amount-of-substance
component.
-/

namespace IPhO2026Problems.IPhO2026_3_B_2

open Dimension UnitChoices
open NNReal

/-- Absolute thermodynamic temperature, with physical dimension temperature. -/
abbrev ThermodynamicTemperature :=
  Dimensionful (WithDim Θ𝓭 ℝ≥0)

/-- The fixed physical volume of the paramagnetic torus. -/
abbrev PhysicalVolume :=
  Dimensionful (WithDim (L𝓭 * L𝓭 * L𝓭) ℝ≥0)

/--
Magnitude of the applied magnetic-field strength `H`.

In SI its unit is ampere per metre, represented dimensionally as
charge per time per length.
-/
abbrev AppliedFieldStrengthMagnitude :=
  Dimensionful (WithDim (C𝓭 * T𝓭⁻¹ * L𝓭⁻¹) ℝ≥0)

/-- Magnitude of the torus magnetization `M`, also measured in ampere per metre. -/
abbrev MagnetizationMagnitude :=
  Dimensionful (WithDim (C𝓭 * T𝓭⁻¹ * L𝓭⁻¹) ℝ≥0)

/--
Vacuum permeability `μ₀`.

Its SI dimension is mass times length divided by charge squared.
-/
abbrev VacuumPermeability :=
  Dimensionful (WithDim (M𝓭 * L𝓭 * C𝓭⁻¹ * C𝓭⁻¹) ℝ)

/--
The equation-of-state constant `K`, per mole.

Since amount of substance is represented by its scalar molar readout, the
dimension recorded here is temperature times volume.
-/
abbrev CurieConstantPerMole :=
  Dimensionful (WithDim (Θ𝓭 * L𝓭 * L𝓭 * L𝓭) ℝ)

/--
The material constant `λ`, per mole, with the dimension energy times
temperature.
-/
abbrev LambdaPerMole :=
  Dimensionful
    (WithDim
      (M𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹ * Θ𝓭)
      ℝ)

/-- Heat capacity at constant magnetization, with dimension energy/temperature. -/
abbrev HeatCapacityAtConstantMagnetization :=
  Dimensionful
    (WithDim
      (M𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹ * Θ𝓭⁻¹)
      ℝ)

/-- Numerical readout of a temperature in kelvin. -/
noncomputable def temperatureInKelvin
    (temperature : ThermodynamicTemperature) : ℝ :=
  (temperature SI).val

/-- Numerical readout of a volume in cubic metres. -/
noncomputable def volumeInCubicMeters (volume : PhysicalVolume) : ℝ :=
  (volume SI).val

/-- Numerical SI readout of an applied field-strength magnitude. -/
noncomputable def fieldStrengthInSI
    (field : AppliedFieldStrengthMagnitude) : ℝ :=
  (field SI).val

/-- Numerical SI readout of a magnetization magnitude. -/
noncomputable def magnetizationInSI
    (magnetization : MagnetizationMagnitude) : ℝ :=
  (magnetization SI).val

/-- Numerical SI readout of vacuum permeability. -/
noncomputable def vacuumPermeabilityInSI
    (permeability : VacuumPermeability) : ℝ :=
  (permeability SI).val

/-- Numerical SI readout of the equation-of-state constant per mole. -/
noncomputable def curieConstantInSI
    (constant : CurieConstantPerMole) : ℝ :=
  (constant SI).val

/-- Numerical SI readout of `λ` per mole. -/
noncomputable def lambdaInSI (lambda : LambdaPerMole) : ℝ :=
  (lambda SI).val

/-- Numerical SI readout of heat capacity at constant magnetization. -/
noncomputable def heatCapacityInSI
    (heatCapacity : HeatCapacityAtConstantMagnetization) : ℝ :=
  (heatCapacity SI).val

/-- Numerical readout of an energy in joules. -/
noncomputable def energyInJoules (energy : DimEnergy) : ℝ :=
  (energy SI).val

/--
The fixed material and geometric parameters of the paramagnetic torus.

`amountInMoles` is the scalar molar readout `n`; all other fields are physical
dimensionful quantities.
-/
structure ParamagneticTorus where
  volume : PhysicalVolume
  amountInMoles : ℝ
  curieConstant : CurieConstantPerMole
  lambda : LambdaPerMole
  vacuumPermeability : VacuumPermeability

/-- A quasistatic state of the paramagnetic torus. -/
structure ParamagneticTorusState where
  temperature : ThermodynamicTemperature
  appliedFieldStrength : AppliedFieldStrengthMagnitude
  magnetization : MagnetizationMagnitude

/--
A process of the torus, parameterized by dimensionless `τ`.

Heat and work are signed energies.  Their sign convention is fixed below by
the first-law hypothesis: transfer into the material is positive.
-/
structure ParamagneticTorusProcess where
  state : ℝ → ParamagneticTorusState
  heatCapacityAtConstantMagnetization :
    ℝ → HeatCapacityAtConstantMagnetization
  internalEnergy : ℝ → DimEnergy
  workIntoMaterial : ℝ → DimEnergy
  heatIntoMaterial : ℝ → DimEnergy

/-- Temperature readout along a torus process. -/
noncomputable def temperatureAlongProcessInKelvin
    (process : ParamagneticTorusProcess) (τ : ℝ) : ℝ :=
  temperatureInKelvin (process.state τ).temperature

/-- Applied-field-strength readout along a torus process. -/
noncomputable def fieldStrengthAlongProcessInSI
    (process : ParamagneticTorusProcess) (τ : ℝ) : ℝ :=
  fieldStrengthInSI (process.state τ).appliedFieldStrength

/-- Magnetization readout along a torus process. -/
noncomputable def magnetizationAlongProcessInSI
    (process : ParamagneticTorusProcess) (τ : ℝ) : ℝ :=
  magnetizationInSI (process.state τ).magnetization

/--
The equation of state, constitutive heat-capacity relation, energy law,
magnetic-work law from part A.3, first law, and adiabatic condition.

No endpoint temperature relation is included here.
-/
structure SatisfiesParamagneticTorusLaws
    (torus : ParamagneticTorus)
    (process : ParamagneticTorusProcess) : Prop where
  amount_positive :
    0 < torus.amountInMoles
  volume_positive :
    0 < volumeInCubicMeters torus.volume
  curieConstant_positive :
    0 < curieConstantInSI torus.curieConstant
  lambda_positive :
    0 < lambdaInSI torus.lambda
  vacuumPermeability_positive :
    0 < vacuumPermeabilityInSI torus.vacuumPermeability
  temperature_positive :
    ∀ τ ∈ Set.Icc (0 : ℝ) 1,
      0 < temperatureAlongProcessInKelvin process τ
  fieldStrength_isMagnitude :
    ∀ τ ∈ Set.Icc (0 : ℝ) 1,
      0 ≤ fieldStrengthAlongProcessInSI process τ
  magnetization_isMagnitude :
    ∀ τ ∈ Set.Icc (0 : ℝ) 1,
      0 ≤ magnetizationAlongProcessInSI process τ
  temperature_differentiable :
    DifferentiableOn ℝ
      (temperatureAlongProcessInKelvin process)
      (Set.Icc (0 : ℝ) 1)
  fieldStrength_differentiable :
    DifferentiableOn ℝ
      (fieldStrengthAlongProcessInSI process)
      (Set.Icc (0 : ℝ) 1)
  magnetization_differentiable :
    DifferentiableOn ℝ
      (magnetizationAlongProcessInSI process)
      (Set.Icc (0 : ℝ) 1)
  internalEnergy_differentiable :
    DifferentiableOn ℝ
      (fun τ => energyInJoules (process.internalEnergy τ))
      (Set.Icc (0 : ℝ) 1)
  work_differentiable :
    DifferentiableOn ℝ
      (fun τ => energyInJoules (process.workIntoMaterial τ))
      (Set.Icc (0 : ℝ) 1)
  heat_differentiable :
    DifferentiableOn ℝ
      (fun τ => energyInJoules (process.heatIntoMaterial τ))
      (Set.Icc (0 : ℝ) 1)
  equationOfState :
    ∀ τ ∈ Set.Icc (0 : ℝ) 1,
      temperatureAlongProcessInKelvin process τ *
            magnetizationAlongProcessInSI process τ *
          volumeInCubicMeters torus.volume =
        torus.amountInMoles *
            curieConstantInSI torus.curieConstant *
          fieldStrengthAlongProcessInSI process τ
  heatCapacityEquation :
    ∀ τ ∈ Set.Icc (0 : ℝ) 1,
      heatCapacityInSI
          (process.heatCapacityAtConstantMagnetization τ) =
        torus.amountInMoles * lambdaInSI torus.lambda /
          (temperatureAlongProcessInKelvin process τ) ^ 2
  internalEnergyDifferential :
    ∀ τ ∈ Set.Ioo (0 : ℝ) 1,
      deriv (fun s => energyInJoules (process.internalEnergy s)) τ =
        heatCapacityInSI
            (process.heatCapacityAtConstantMagnetization τ) *
          deriv (temperatureAlongProcessInKelvin process) τ
  magneticWorkDifferential_previousA3 :
    ∀ τ ∈ Set.Ioo (0 : ℝ) 1,
      deriv (fun s => energyInJoules (process.workIntoMaterial s)) τ =
        vacuumPermeabilityInSI torus.vacuumPermeability *
              volumeInCubicMeters torus.volume *
            fieldStrengthAlongProcessInSI process τ *
          deriv (magnetizationAlongProcessInSI process) τ
  firstLaw_enteringPositive :
    ∀ τ ∈ Set.Ioo (0 : ℝ) 1,
      deriv (fun s => energyInJoules (process.internalEnergy s)) τ =
        deriv (fun s => energyInJoules (process.heatIntoMaterial s)) τ +
          deriv (fun s => energyInJoules (process.workIntoMaterial s)) τ
  adiabatic_noHeat :
    ∀ τ ∈ Set.Ioo (0 : ℝ) 1,
      deriv (fun s => energyInJoules (process.heatIntoMaterial s)) τ = 0

/--
For an adiabatic change of applied-field magnitude from `H_initial_SI` to
`H_final_SI`, beginning at `T_initial_K`, the final-minus-initial temperature
has the value stated in IPhO 2026 problem 3, part B.2.
-/
theorem adiabatic_temperature_change
    (torus : ParamagneticTorus)
    (process : ParamagneticTorusProcess)
    (laws : SatisfiesParamagneticTorusLaws torus process)
    (H_initial_SI H_final_SI T_initial_K : ℝ)
    (h_initial_field :
      fieldStrengthAlongProcessInSI process 0 = H_initial_SI)
    (h_final_field :
      fieldStrengthAlongProcessInSI process 1 = H_final_SI)
    (h_initial_temperature :
      temperatureAlongProcessInKelvin process 0 = T_initial_K) :
    temperatureAlongProcessInKelvin process 1 - T_initial_K =
      T_initial_K *
        (Real.sqrt
            ((lambdaInSI torus.lambda +
                vacuumPermeabilityInSI torus.vacuumPermeability *
                  curieConstantInSI torus.curieConstant *
                  H_final_SI ^ 2) /
              (lambdaInSI torus.lambda +
                vacuumPermeabilityInSI torus.vacuumPermeability *
                  curieConstantInSI torus.curieConstant *
                  H_initial_SI ^ 2)) -
          1) := by
  sorry

end IPhO2026Problems.IPhO2026_3_B_2

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Physlib.Units.WithDim.Energy

namespace IPhO2026Problems
namespace IPhO2026_3_B_1

noncomputable section

/-- The numerical value, in joules, of a dimensionful energy. -/
def energyInJoules (energy : DimEnergy) : ℝ :=
  (energy UnitChoices.SI).val

/--
The fixed parameters of the paramagnetic torus.

Every real-valued field is explicitly an SI scalar readout.  In particular,
`materialConstantKSI` has the derived units which make
`T * M * V = n * K * H` dimensionally consistent, and
`materialConstantLambdaSI` has the derived units which make
`C_M = n * lambda / T^2` dimensionally consistent.
-/
structure ParamagneticTorus where
  /-- The fixed torus volume `V`, measured in cubic metres. -/
  volumeSI : ℝ
  /-- The amount of paramagnetic material `n`, measured in moles. -/
  amountMoles : ℝ
  /-- The material constant `K`, represented by its SI numerical value. -/
  materialConstantKSI : ℝ
  /-- The material constant `lambda`, represented by its SI numerical value. -/
  materialConstantLambdaSI : ℝ
  /-- The vacuum permeability `mu_0`, represented by its SI numerical value. -/
  vacuumPermeabilitySI : ℝ
  volume_pos : 0 < volumeSI
  amountMoles_nonneg : 0 ≤ amountMoles
  materialConstantK_nonneg : 0 ≤ materialConstantKSI
  materialConstantLambda_nonneg : 0 ≤ materialConstantLambdaSI
  vacuumPermeability_pos : 0 < vacuumPermeabilitySI

/--
The governing constitutive and thermodynamic laws used for the torus.

The arguments called `temperatureSI` are kelvin readouts.  The arguments called
`fieldIntensitySI` are SI readouts of the magnitude `H` of the magnetic-field
intensity, and `magnetizationMagnitudeSI` returns the corresponding SI readout
of the magnitude `M`.  Positive heat and work values mean energy entering the
torus.
-/
structure ParamagneticTorusLaws (torus : ParamagneticTorus) where
  magnetizationMagnitudeSI :
    (temperatureSI fieldIntensitySI : ℝ) → ℝ
  heatCapacityAtConstantMagnetizationSI :
    (temperatureSI : ℝ) → ℝ
  internalEnergy :
    (temperatureSI : ℝ) → DimEnergy
  isothermalMagneticWorkInto :
    (temperatureSI initialFieldIntensitySI finalFieldIntensitySI : ℝ) → DimEnergy
  isothermalHeatInto :
    (temperatureSI initialFieldIntensitySI finalFieldIntensitySI : ℝ) → DimEnergy
  /-- The equation of state `T * M * V = n * K * H`. -/
  equationOfState :
    ∀ (temperatureSI fieldIntensitySI : ℝ),
      temperatureSI *
          magnetizationMagnitudeSI temperatureSI fieldIntensitySI *
          torus.volumeSI =
        torus.amountMoles * torus.materialConstantKSI * fieldIntensitySI
  /-- The supplied law `C_M = n * lambda / T^2`. -/
  heatCapacityLaw :
    ∀ (temperatureSI : ℝ), temperatureSI ≠ 0 →
      heatCapacityAtConstantMagnetizationSI temperatureSI =
        torus.amountMoles * torus.materialConstantLambdaSI / temperatureSI ^ 2
  /-- The supplied differential law `dU = C_M dT`. -/
  internalEnergyLaw :
    ∀ (temperatureSI : ℝ),
      HasDerivAt
        (fun temperatureReadoutSI =>
          energyInJoules (internalEnergy temperatureReadoutSI))
        (heatCapacityAtConstantMagnetizationSI temperatureSI)
        temperatureSI
  magnetizationDifferentiable :
    ∀ (temperatureSI : ℝ),
      Differentiable ℝ (magnetizationMagnitudeSI temperatureSI)
  /--
  The previous-part magnetic-work law `dW = mu_0 * V * H dM`,
  integrated along an isothermal change from `H_i` to `H_f`.
  -/
  magneticWorkLaw :
    ∀ (temperatureSI initialFieldIntensitySI finalFieldIntensitySI : ℝ),
      energyInJoules
          (isothermalMagneticWorkInto temperatureSI
            initialFieldIntensitySI finalFieldIntensitySI) =
        ∫ fieldIntensitySI in initialFieldIntensitySI..finalFieldIntensitySI,
          torus.vacuumPermeabilitySI * torus.volumeSI * fieldIntensitySI *
            deriv (magnetizationMagnitudeSI temperatureSI) fieldIntensitySI
  /--
  The first law for an isothermal field change, with heat and work entering
  the torus taken as positive.
  -/
  isothermalFirstLaw :
    ∀ (temperatureSI initialFieldIntensitySI finalFieldIntensitySI : ℝ),
      energyInJoules (internalEnergy temperatureSI) -
          energyInJoules (internalEnergy temperatureSI) =
        energyInJoules
            (isothermalHeatInto temperatureSI
              initialFieldIntensitySI finalFieldIntensitySI) +
          energyInJoules
            (isothermalMagneticWorkInto temperatureSI
              initialFieldIntensitySI finalFieldIntensitySI)

/--
For the fixed-volume paramagnetic torus, the heat transferred into the torus
while the magnitude of `H` changes isothermally from `H_i` to `H_f` is

`Q = -(mu_0 * n * K / (2 * T)) * (H_f^2 - H_i^2)`.

The hypotheses that `H_i` and `H_f` are nonnegative record that they are
magnitudes.  No ordering is imposed: the oriented integral in the work law
also covers a decreasing field.
-/
theorem heatTransferredInto_isothermal
    (torus : ParamagneticTorus)
    (laws : ParamagneticTorusLaws torus)
    (temperatureSI initialFieldIntensitySI finalFieldIntensitySI : ℝ)
    (temperature_pos : 0 < temperatureSI)
    (initialFieldIntensity_nonneg : 0 ≤ initialFieldIntensitySI)
    (finalFieldIntensity_nonneg : 0 ≤ finalFieldIntensitySI) :
    energyInJoules
        (laws.isothermalHeatInto temperatureSI
          initialFieldIntensitySI finalFieldIntensitySI) =
      -(torus.vacuumPermeabilitySI * torus.amountMoles *
          torus.materialConstantKSI / (2 * temperatureSI)) *
        (finalFieldIntensitySI ^ 2 - initialFieldIntensitySI ^ 2) := by
  sorry

end

end IPhO2026_3_B_1
end IPhO2026Problems

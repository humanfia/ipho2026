import Mathlib.Analysis.Real.Sqrt
import Physlib.Units.Basic

/-!
# IPhO 2026, Problem 3, Part C.2

The paramagnetic torus follows the Carnot refrigeration cycle
`1 → 2 → 3 → 4 → 1` in the `H`-versus-`T` plane.  This file separates
physical quantities from their scalar SI readouts and states the equation of
state, the isothermal heat law from part B.1, and the reversible Carnot heat
balance as assumptions.
-/

namespace IPhO2026Problems
namespace IPhO2026_3_C_2

/-- Abstract physical roles used in the paramagnetic-torus model.

These are kept as separate types so that temperature, magnetic field strength,
magnetization, volume, and heat cannot be confused merely because their
measured values are represented by real numbers. -/
structure PhysicalQuantityTypes where
  torus : Type
  temperature : Type
  magneticFieldStrengthMagnitude : Type
  magnetizationMagnitude : Type
  volume : Type
  heatMagnitude : Type

/-- Scalar readouts of the physical quantities in SI units.

The two magnetic magnitudes are measured in amperes per metre, volume in cubic
metres, heat in joules, and thermodynamic temperature in kelvin. -/
structure SIReadout (q : PhysicalQuantityTypes) where
  unitChoices : UnitChoices
  usesSI : unitChoices = UnitChoices.SI
  temperatureKelvin : q.temperature → ℝ
  magneticFieldAmperePerMeter : q.magneticFieldStrengthMagnitude → ℝ
  magnetizationAmperePerMeter : q.magnetizationMagnitude → ℝ
  volumeCubicMeter : q.volume → ℝ
  heatJoule : q.heatMagnitude → ℝ
  temperature_pos : ∀ T, 0 < temperatureKelvin T
  magneticField_nonneg : ∀ H, 0 ≤ magneticFieldAmperePerMeter H
  magnetization_nonneg : ∀ M, 0 ≤ magnetizationAmperePerMeter M
  volume_pos : ∀ V, 0 < volumeCubicMeter V
  heat_nonneg : ∀ Q, 0 ≤ heatJoule Q

/-- A thermodynamic state at a vertex of Figure 3b. -/
structure TorusState (q : PhysicalQuantityTypes) where
  temperature : q.temperature
  magneticFieldMagnitude : q.magneticFieldStrengthMagnitude
  magnetizationMagnitude : q.magnetizationMagnitude

/-- The four oriented legs in the order shown in Figure 3b. -/
inductive CycleLeg where
  | oneToTwo
  | twoToThree
  | threeToFour
  | fourToOne
  deriving DecidableEq

/-- The process label attached to a leg of the Carnot cycle. -/
inductive ProcessKind (q : PhysicalQuantityTypes) where
  | adiabatic
  | isothermalAt (temperature : q.temperature)

/-- Data of the paramagnetic-torus Carnot refrigerator.

`amountMoles` is `n`, `curieConstantKelvinCubicMeterPerMole` is `K`, and
`vacuumPermeabilitySI` is `μ₀`.  The latter is recorded because it occurs in
the isothermal heat relation reused from part B.1. -/
structure CarnotCycle (q : PhysicalQuantityTypes) where
  torus : q.torus
  torusVolume : q.volume
  state1 : TorusState q
  state2 : TorusState q
  state3 : TorusState q
  state4 : TorusState q
  hotReservoirTemperature : q.temperature
  coldReservoirTemperature : q.temperature
  heatDeliveredToHot : q.heatMagnitude
  heatAbsorbedFromCold : q.heatMagnitude
  processKind : CycleLeg → ProcessKind q
  heatDeliveredLeg : CycleLeg
  heatAbsorbedLeg : CycleLeg
  amountMoles : ℝ
  curieConstantKelvinCubicMeterPerMole : ℝ
  vacuumPermeabilitySI : ℝ
  amountMoles_pos : 0 < amountMoles
  curieConstant_pos : 0 < curieConstantKelvinCubicMeterPerMole
  vacuumPermeability_pos : 0 < vacuumPermeabilitySI

/-- Figure 3b and the result of part C.1: states `1,4` are at `Tₕ`, states
`2,3` are at `T꜀`, the other two legs are adiabatic, `Q꜀` is absorbed on
`2 → 3`, and `Qₕ` is delivered on `4 → 1`. -/
structure Figure3bReadout {q : PhysicalQuantityTypes} (cycle : CarnotCycle q) :
    Prop where
  state1_at_hot :
    cycle.state1.temperature = cycle.hotReservoirTemperature
  state2_at_cold :
    cycle.state2.temperature = cycle.coldReservoirTemperature
  state3_at_cold :
    cycle.state3.temperature = cycle.coldReservoirTemperature
  state4_at_hot :
    cycle.state4.temperature = cycle.hotReservoirTemperature
  leg_oneToTwo_adiabatic :
    cycle.processKind .oneToTwo = .adiabatic
  leg_twoToThree_cold_isothermal :
    cycle.processKind .twoToThree =
      .isothermalAt cycle.coldReservoirTemperature
  leg_threeToFour_adiabatic :
    cycle.processKind .threeToFour = .adiabatic
  leg_fourToOne_hot_isothermal :
    cycle.processKind .fourToOne =
      .isothermalAt cycle.hotReservoirTemperature
  cold_heat_on_twoToThree :
    cycle.heatAbsorbedLeg = .twoToThree
  hot_heat_on_fourToOne :
    cycle.heatDeliveredLeg = .fourToOne

/-- The paramagnetic equation of state `T M V = n K H`, expressed using SI
scalar readouts at one state. -/
def SatisfiesParamagneticEquationOfState {q : PhysicalQuantityTypes}
    (readout : SIReadout q) (cycle : CarnotCycle q) (state : TorusState q) :
    Prop :=
  readout.temperatureKelvin state.temperature *
        readout.magnetizationAmperePerMeter state.magnetizationMagnitude *
      readout.volumeCubicMeter cycle.torusVolume =
    cycle.amountMoles * cycle.curieConstantKelvinCubicMeterPerMole *
      readout.magneticFieldAmperePerMeter state.magneticFieldMagnitude

/-- The part-B.1 isothermal law for signed heat transferred into the torus:

`Q = -(μ₀ n K / (2 T)) (H_f² - H_i²)`.

For the cold isotherm the signed heat is `+Q꜀`; for the hot isotherm it is
`-Qₕ`, because `Qₕ` denotes the nonnegative magnitude delivered to the hot
reservoir. -/
def SatisfiesIsothermalHeatLaw {q : PhysicalQuantityTypes}
    (readout : SIReadout q) (cycle : CarnotCycle q)
    (temperature : q.temperature) (initialState finalState : TorusState q)
    (signedHeatIntoTorusJoule : ℝ) : Prop :=
  signedHeatIntoTorusJoule =
    -(cycle.vacuumPermeabilitySI * cycle.amountMoles *
          cycle.curieConstantKelvinCubicMeterPerMole /
        (2 * readout.temperatureKelvin temperature)) *
      (readout.magneticFieldAmperePerMeter finalState.magneticFieldMagnitude ^ 2 -
        readout.magneticFieldAmperePerMeter initialState.magneticFieldMagnitude ^ 2)

/-- Entropy balance of a reversible Carnot refrigerator:
`Q꜀ / T꜀ = Qₕ / Tₕ`, where both heats are nonnegative magnitudes. -/
def SatisfiesReversibleCarnotHeatBalance {q : PhysicalQuantityTypes}
    (readout : SIReadout q) (cycle : CarnotCycle q) : Prop :=
  readout.heatJoule cycle.heatAbsorbedFromCold /
      readout.temperatureKelvin cycle.coldReservoirTemperature =
    readout.heatJoule cycle.heatDeliveredToHot /
      readout.temperatureKelvin cycle.hotReservoirTemperature

/-- All four vertices obey the same paramagnetic equation of state. -/
structure EquationOfStateAtVertices {q : PhysicalQuantityTypes}
    (readout : SIReadout q) (cycle : CarnotCycle q) : Prop where
  at_state1 :
    SatisfiesParamagneticEquationOfState readout cycle cycle.state1
  at_state2 :
    SatisfiesParamagneticEquationOfState readout cycle cycle.state2
  at_state3 :
    SatisfiesParamagneticEquationOfState readout cycle cycle.state3
  at_state4 :
    SatisfiesParamagneticEquationOfState readout cycle cycle.state4

/-- In the Carnot refrigeration cycle of Figure 3b, the magnitude at state `1`
is determined by the other three vertex magnitudes:

`M₁ = √(M₂² - M₃² + M₄²)`.

The assumptions contain the physical laws and figure readouts, but not this
magnetization identity. -/
theorem magnetization_state1_eq_sqrt {q : PhysicalQuantityTypes}
    (readout : SIReadout q) (cycle : CarnotCycle q)
    (hFigure : Figure3bReadout cycle)
    (hEquationOfState : EquationOfStateAtVertices readout cycle)
    (hColdIsotherm :
      SatisfiesIsothermalHeatLaw readout cycle
        cycle.coldReservoirTemperature cycle.state2 cycle.state3
        (readout.heatJoule cycle.heatAbsorbedFromCold))
    (hHotIsotherm :
      SatisfiesIsothermalHeatLaw readout cycle
        cycle.hotReservoirTemperature cycle.state4 cycle.state1
        (-readout.heatJoule cycle.heatDeliveredToHot))
    (hCarnotBalance : SatisfiesReversibleCarnotHeatBalance readout cycle) :
    readout.magnetizationAmperePerMeter cycle.state1.magnetizationMagnitude =
      Real.sqrt
        (readout.magnetizationAmperePerMeter cycle.state2.magnetizationMagnitude ^ 2 -
          readout.magnetizationAmperePerMeter cycle.state3.magnetizationMagnitude ^ 2 +
          readout.magnetizationAmperePerMeter cycle.state4.magnetizationMagnitude ^ 2) := by
  sorry

end IPhO2026_3_C_2
end IPhO2026Problems

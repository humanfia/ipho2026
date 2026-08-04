import Mathlib
import Physlib.Thermodynamics.Temperature.Basic
import Physlib.Units.WithDim.Energy

/-!
# IPhO 2026 Problem 3, part C.1

The paramagnetic torus follows the directed Carnot refrigeration cycle
`1 → 2 → 3 → 4 → 1` shown in Figure 3b.  This file separates the raw
`H`-versus-`T` figure readout from the general thermodynamic laws used to
identify the two reservoir isotherms and the directions of heat transfer.

Temperatures use Physlib's absolute-temperature type and heats use its
dimensionful energy type.  The equation of state and the reusable isothermal
heat relation from part B are retained as physical context even though the
qualitative labeling argument does not require their numerical content.
-/

namespace IPhO2026Problems
namespace ProblemIPhO2026_3_C_1

open Dimension

noncomputable section

/-! ## Dimensionful physical quantities -/

/-- Volume, with physical dimension `L³`. -/
abbrev DimVolume : Type :=
  Dimensionful (WithDim (L𝓭 * L𝓭 * L𝓭) ℝ)

/-- Magnetic-field strength and magnetization, both with SI dimension `A/m`. -/
abbrev DimMagneticIntensity : Type :=
  Dimensionful (WithDim (C𝓭 * T𝓭⁻¹ * L𝓭⁻¹) ℝ)

/-- Vacuum permeability, with SI dimension `kg m / C²`. -/
abbrev DimVacuumPermeability : Type :=
  Dimensionful (WithDim (M𝓭 * L𝓭 * C𝓭⁻¹ * C𝓭⁻¹) ℝ)

/-- The real coordinate of a dimensionful quantity in Physlib's SI units. -/
def siValue {d : Dimension} (quantity : Dimensionful (WithDim d ℝ)) : ℝ :=
  (quantity UnitChoices.SI).val

/-- The real absolute-temperature readout used in scalar physical laws. -/
def temperatureValue (temperature : Temperature) : ℝ :=
  Temperature.toReal temperature

/-- The SI joule coordinate of a heat or energy. -/
def heatInJoules (heat : DimEnergy) : ℝ :=
  (heat UnitChoices.SI).val

/-! ## Figure 3b labels and oriented processes -/

/-- The four labeled thermodynamic states in Figure 3b. -/
inductive CyclePoint
  | one
  | two
  | three
  | four
  deriving DecidableEq, Repr

/-- The four oriented processes in the displayed cycle order. -/
inductive CycleLeg
  | oneToTwo
  | twoToThree
  | threeToFour
  | fourToOne
  deriving DecidableEq, Repr

/-- Initial state of an oriented process. -/
def CycleLeg.initial : CycleLeg → CyclePoint
  | .oneToTwo => .one
  | .twoToThree => .two
  | .threeToFour => .three
  | .fourToOne => .four

/-- Final state of an oriented process. -/
def CycleLeg.final : CycleLeg → CyclePoint
  | .oneToTwo => .two
  | .twoToThree => .three
  | .threeToFour => .four
  | .fourToOne => .one

/-- Thermodynamic type of a process, before its reservoir is identified. -/
inductive ProcessKind
  | adiabatic
  | isothermal
  deriving DecidableEq, Repr

/-- The two reservoirs of the refrigerator. -/
inductive Reservoir
  | cold
  | hot
  deriving DecidableEq, Repr

/--
Qualitative direction and reservoir role of heat transfer on an oriented leg.
The carried energy is a nonnegative magnitude; its sign relative to the torus
is supplied separately by the governing laws.
-/
inductive HeatTransfer
  | none
  | absorbedFromCold (magnitude : DimEnergy)
  | deliveredToHot (magnitude : DimEnergy)

/-! ## Paramagnetic torus and cycle data -/

/-- A uniform scalar magnetic state of the paramagnetic torus. -/
structure TorusState where
  temperature : Temperature
  magneticFieldStrength : DimMagneticIntensity
  magnetization : DimMagneticIntensity

/--
Fixed material and geometric data.

Physlib has no amount-of-substance base dimension, so the amount and Curie
constant are explicitly named coherent-SI scalar readouts: moles and
kelvin-cubic-metres per mole, respectively.
-/
structure ParamagneticTorus where
  volume : DimVolume
  amountInMoles : ℝ
  curieConstantKelvinCubicMetresPerMole : ℝ
  vacuumPermeability : DimVacuumPermeability

/-- All physical data attached to the directed Figure 3b cycle. -/
structure Figure3bCarnotCycle where
  torus : ParamagneticTorus
  state : CyclePoint → TorusState
  hotReservoirTemperature : Temperature
  coldReservoirTemperature : Temperature
  /-- `Q_h`, the magnitude delivered to the hot reservoir. -/
  heatDeliveredToHot : DimEnergy
  /-- `Q_c`, the magnitude absorbed from the cold reservoir. -/
  heatAbsorbedFromCold : DimEnergy
  processKind : CycleLeg → ProcessKind
  /-- `some r` means that this leg is in thermal contact with reservoir `r`. -/
  reservoirContact : CycleLeg → Option Reservoir
  heatTransfer : CycleLeg → HeatTransfer
  /-- Signed heat entering the torus; positive means energy enters the torus. -/
  signedHeatEntering : CycleLeg → DimEnergy

/-- Temperature of either reservoir. -/
def Figure3bCarnotCycle.reservoirTemperature
    (cycle : Figure3bCarnotCycle) : Reservoir → Temperature
  | .cold => cycle.coldReservoirTemperature
  | .hot => cycle.hotReservoirTemperature

/-! ## Source assumptions -/

/--
Direct geometric readouts from Figure 3b.

The equal-temperature labels requested in C.1 do not occur here.  The diagram
only supplies which drawn legs are vertical isotherms in the `H`-versus-`T`
plane, which are adiabatic, and that state `2` lies at a lower temperature
coordinate than state `1`.
-/
structure Figure3bGeometry (cycle : Figure3bCarnotCycle) : Prop where
  one_to_two_adiabatic :
    cycle.processKind .oneToTwo = .adiabatic
  two_to_three_isothermal :
    cycle.processKind .twoToThree = .isothermal
  three_to_four_adiabatic :
    cycle.processKind .threeToFour = .adiabatic
  four_to_one_isothermal :
    cycle.processKind .fourToOne = .isothermal
  state_two_colder_than_state_one :
    temperatureValue (cycle.state .two).temperature <
      temperatureValue (cycle.state .one).temperature

/-- The paramagnetic equation of state `T M V = n K H` at every cycle state. -/
structure SatisfiesParamagneticEquationOfState
    (cycle : Figure3bCarnotCycle) : Prop where
  volume_positive : 0 < siValue cycle.torus.volume
  amount_positive : 0 < cycle.torus.amountInMoles
  curie_constant_positive :
    0 < cycle.torus.curieConstantKelvinCubicMetresPerMole
  equation : ∀ point : CyclePoint,
    temperatureValue (cycle.state point).temperature *
          siValue (cycle.state point).magnetization *
          siValue cycle.torus.volume =
      cycle.torus.amountInMoles *
          cycle.torus.curieConstantKelvinCubicMetresPerMole *
          siValue (cycle.state point).magneticFieldStrength

/--
The reusable part-B isothermal heat relation.  Heat entering the torus is
positive, so a hot-reservoir rejection has a negative signed readout.
-/
structure SatisfiesIsothermalHeatRelation
    (cycle : Figure3bCarnotCycle) : Prop where
  vacuum_permeability_positive :
    0 < siValue cycle.torus.vacuumPermeability
  equation : ∀ leg : CycleLeg,
    cycle.processKind leg = .isothermal →
      heatInJoules (cycle.signedHeatEntering leg) =
        -(siValue cycle.torus.vacuumPermeability *
            cycle.torus.amountInMoles *
            cycle.torus.curieConstantKelvinCubicMetresPerMole /
            (2 * temperatureValue
              (cycle.state leg.initial).temperature)) *
          (siValue (cycle.state leg.final).magneticFieldStrength ^ 2 -
            siValue (cycle.state leg.initial).magneticFieldStrength ^ 2)

/--
General thermodynamic laws of the Carnot refrigerator.

These laws do not specify which named leg contacts which reservoir.  That
identification is derived from the isothermal-leg geometry and the strict
temperature ordering.
-/
structure SatisfiesCarnotRefrigeratorLaws
    (cycle : Figure3bCarnotCycle) : Prop where
  hot_temperature_positive :
    0 < temperatureValue cycle.hotReservoirTemperature
  cold_temperature_positive :
    0 < temperatureValue cycle.coldReservoirTemperature
  cold_below_hot :
    temperatureValue cycle.coldReservoirTemperature <
      temperatureValue cycle.hotReservoirTemperature
  cold_heat_is_magnitude :
    0 ≤ heatInJoules cycle.heatAbsorbedFromCold
  hot_heat_is_magnitude :
    0 ≤ heatInJoules cycle.heatDeliveredToHot
  /-- Every isothermal leg is in contact with one of the two reservoirs. -/
  isothermal_has_reservoir_contact : ∀ leg : CycleLeg,
    cycle.processKind leg = .isothermal →
      ∃ reservoir : Reservoir,
        cycle.reservoirContact leg = some reservoir
  /-- Thermal contact occurs only on an isothermal leg. -/
  reservoir_contact_is_isothermal : ∀ (leg : CycleLeg) (reservoir : Reservoir),
    cycle.reservoirContact leg = some reservoir →
      cycle.processKind leg = .isothermal
  /-- An adiabatic leg is thermally isolated. -/
  adiabatic_has_no_reservoir_contact : ∀ leg : CycleLeg,
    cycle.processKind leg = .adiabatic →
      cycle.reservoirContact leg = none
  /-- A thermally isolated leg carries no heat transfer. -/
  no_reservoir_contact_has_no_heat_transfer : ∀ leg : CycleLeg,
    cycle.reservoirContact leg = none →
      cycle.heatTransfer leg = .none
  /-- Both endpoints equilibrate with the contacted reservoir. -/
  endpoint_temperatures_at_reservoir :
    ∀ (leg : CycleLeg) (reservoir : Reservoir),
      cycle.reservoirContact leg = some reservoir →
        (cycle.state leg.initial).temperature =
            cycle.reservoirTemperature reservoir ∧
          (cycle.state leg.final).temperature =
            cycle.reservoirTemperature reservoir
  /-- Refrigerator operation fixes the heat direction at either reservoir. -/
  heat_transfer_at_reservoir :
    ∀ (leg : CycleLeg) (reservoir : Reservoir),
      cycle.reservoirContact leg = some reservoir →
        cycle.heatTransfer leg =
          match reservoir with
          | .cold => .absorbedFromCold cycle.heatAbsorbedFromCold
          | .hot => .deliveredToHot cycle.heatDeliveredToHot
  /-- The qualitative transfer record agrees with signed heat into the torus. -/
  signed_heat_agrees_with_transfer : ∀ leg : CycleLeg,
    match cycle.heatTransfer leg with
    | .none => heatInJoules (cycle.signedHeatEntering leg) = 0
    | .absorbedFromCold magnitude =>
        heatInJoules (cycle.signedHeatEntering leg) =
          heatInJoules magnitude
    | .deliveredToHot magnitude =>
        heatInJoules (cycle.signedHeatEntering leg) =
          -heatInJoules magnitude

/-! ## Derived identification requested in C.1 -/

/--
The lower-temperature isothermal leg must contact the cold reservoir, while
the higher-temperature isothermal leg must contact the hot reservoir.
-/
theorem identify_isothermal_reservoir_contacts
    (cycle : Figure3bCarnotCycle)
    (figure : Figure3bGeometry cycle)
    (laws : SatisfiesCarnotRefrigeratorLaws cycle) :
    cycle.reservoirContact .twoToThree = some .cold ∧
      cycle.reservoirContact .fourToOne = some .hot := by
  sorry

/--
**IPhO 2026 Problem 3 C.1.**

States `1` and `4` are at `T_h`, states `2` and `3` are at `T_c`,
`Q_c` is absorbed on `2 → 3`, and `Q_h` is delivered on `4 → 1`.
-/
theorem identify_temperature_labels_and_heat_processes
    (cycle : Figure3bCarnotCycle)
    (figure : Figure3bGeometry cycle)
    (laws : SatisfiesCarnotRefrigeratorLaws cycle)
    (_equationOfState : SatisfiesParamagneticEquationOfState cycle)
    (_isothermalHeatRelation : SatisfiesIsothermalHeatRelation cycle) :
    ((cycle.state .one).temperature = cycle.hotReservoirTemperature ∧
      (cycle.state .four).temperature = cycle.hotReservoirTemperature) ∧
    ((cycle.state .two).temperature = cycle.coldReservoirTemperature ∧
      (cycle.state .three).temperature = cycle.coldReservoirTemperature) ∧
    (cycle.heatTransfer .twoToThree =
      .absorbedFromCold cycle.heatAbsorbedFromCold) ∧
    (cycle.heatTransfer .fourToOne =
      .deliveredToHot cycle.heatDeliveredToHot) ∧
    cycle.heatTransfer .oneToTwo = .none ∧
    cycle.heatTransfer .threeToFour = .none := by
  sorry

end

end ProblemIPhO2026_3_C_1
end IPhO2026Problems

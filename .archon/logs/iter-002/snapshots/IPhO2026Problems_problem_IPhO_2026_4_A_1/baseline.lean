import Physlib.Units.WithDim.Pressure

/-!
# IPhO 2026 experimental problem 4, part A.1

This file models the inventory of the confined air column `CA` in the inner
cylinder `IC`.  Physlib's dimension-tagged quantities are used whenever its
dimension system supports the physical role.  Amount of substance is kept
abstract because that system has no amount-of-substance base dimension.
-/

namespace IPhO2026Problems.IPhO2026_4_A_1

open Dimension

/-- A physical length, represented independently of the choice of units. -/
abbrev Length := Dimensionful (WithDim L𝓭 ℝ)

/-- A physical volume, with dimension `L³`. -/
abbrev Volume := Dimensionful (WithDim (L𝓭 * L𝓭 * L𝓭) ℝ)

/-- A physical mass. -/
abbrev Mass := Dimensionful (WithDim M𝓭 ℝ)

/-- A mass density, with dimension `M L⁻³`. -/
abbrev MassDensity :=
  Dimensionful (WithDim (M𝓭 * L𝓭⁻¹ * L𝓭⁻¹ * L𝓭⁻¹) ℝ)

/-- An absolute temperature. -/
abbrev AbsoluteTemperature := Dimensionful (WithDim Θ𝓭 ℝ)

/-- A thermodynamic pressure, using Physlib's pressure quantity. -/
abbrev Pressure := DimPressure

/-- The real-valued readout of a Physlib dimensional quantity in SI units. -/
noncomputable def siValue {d : Dimension}
    (quantity : Dimensionful (WithDim d ℝ)) : ℝ :=
  (quantity UnitChoices.SI).val

/--
The missing amount-of-substance interface in Physlib.

The physical amount and the molecular population remain abstract types; only
their experimentally reported scalar readouts are exposed.
-/
structure SubstanceCountingModel where
  AmountOfSubstance : Type
  MolecularPopulation : Type
  amountInMoles : AmountOfSubstance → ℝ
  moleculeCount : MolecularPopulation → ℝ

/-- Thermodynamic state and inventory of the confined air column `CA`. -/
structure ConfinedAirState (model : SubstanceCountingModel) where
  mass : Mass
  amount : model.AmountOfSubstance
  molecules : model.MolecularPopulation
  pressure : Pressure
  absoluteTemperature : AbsoluteTemperature

/--
The dimensioned quantities read from the cylinder geometry in Figure 17.

The outer-cylinder fields retain the `OC` geometry even though only the
inner-cylinder geometry enters part A.1.
-/
structure Figure17Geometry where
  innerCylinderRadius : Length
  innerCylinderUsableHeight : Length
  outerCylinderInnerRadius : Length
  outerCylinderUsableHeight : Length
  propyleneGlycolHeight : Length
  confinedAirVolume : Volume

/--
The apparatus and constants relevant to part A.1.

The propositions record the labelled apparatus state without asserting that
the experimental instructions have already been carried out.
-/
structure IsochoricAirSetup (model : SubstanceCountingModel) where
  geometry : Figure17Geometry
  confinedAirCA : ConfinedAirState model
  ambientAirDensity : MassDensity
  universalGasConstantJPerMoleKelvin : ℝ
  avogadroConstantPerMole : ℝ
  propyleneGlycolIntroducedIntoIC : Prop
  valveDClosed : Prop
  valveEClosed : Prop
  confinedAirColumnSealed : Prop
  confinedAirVolumeFixed : Prop
  outerCylinderWaterBathHeated : Prop

/--
The cylindrical volume of `CA` in cubic metres, as calculated from Figure 17.
-/
noncomputable def cylindricalAirVolumeSI (geometry : Figure17Geometry) : ℝ :=
  Real.pi * (siValue geometry.innerCylinderRadius) ^ 2 *
    (siValue geometry.innerCylinderUsableHeight -
      siValue geometry.propyleneGlycolHeight)

/--
Governing physical laws for the confined air.

These are the cylinder-volume relation, `m = ρ V`, the ideal-gas equation
`P V = n R T`, and the conversion from amount of substance to molecular
population.  None is an assertion of the requested solved formulas.
-/
structure GoverningLaws (model : SubstanceCountingModel)
    (setup : IsochoricAirSetup model) : Prop where
  cylinder_geometry :
    siValue setup.geometry.confinedAirVolume =
      cylindricalAirVolumeSI setup.geometry
  mass_density :
    siValue setup.confinedAirCA.mass =
      siValue setup.ambientAirDensity *
        siValue setup.geometry.confinedAirVolume
  ideal_gas :
    siValue setup.confinedAirCA.pressure *
        siValue setup.geometry.confinedAirVolume =
      model.amountInMoles setup.confinedAirCA.amount *
        setup.universalGasConstantJPerMoleKelvin *
          siValue setup.confinedAirCA.absoluteTemperature
  molecule_amount :
    model.moleculeCount setup.confinedAirCA.molecules =
      model.amountInMoles setup.confinedAirCA.amount *
        setup.avogadroConstantPerMole

/-- Numerical source readouts stated on the official problem page. -/
structure SourceReadouts (model : SubstanceCountingModel)
    (setup : IsochoricAirSetup model) : Prop where
  glycol_height :
    siValue setup.geometry.propyleneGlycolHeight = 0.045
  ambient_density :
    siValue setup.ambientAirDensity = 1.12

/-- The apparatus conditions prescribed immediately before part A.1. -/
structure ExperimentalConditions (model : SubstanceCountingModel)
    (setup : IsochoricAirSetup model) : Prop where
  glycol_introduced : setup.propyleneGlycolIntroducedIntoIC
  valve_D_closed : setup.valveDClosed
  valve_E_closed : setup.valveEClosed
  air_column_sealed : setup.confinedAirColumnSealed
  volume_fixed : setup.confinedAirVolumeFixed
  water_bath_heated : setup.outerCylinderWaterBathHeated

/-- Positivity conditions required of the physical apparatus and constants. -/
structure PhysicalAdmissibility (model : SubstanceCountingModel)
    (setup : IsochoricAirSetup model) : Prop where
  inner_radius_positive :
    0 < siValue setup.geometry.innerCylinderRadius
  air_height_positive :
    siValue setup.geometry.propyleneGlycolHeight <
      siValue setup.geometry.innerCylinderUsableHeight
  density_positive :
    0 < siValue setup.ambientAirDensity
  pressure_positive :
    0 < siValue setup.confinedAirCA.pressure
  temperature_positive :
    0 < siValue setup.confinedAirCA.absoluteTemperature
  gas_constant_positive :
    0 < setup.universalGasConstantJPerMoleKelvin
  avogadro_constant_positive :
    0 < setup.avogadroConstantPerMole

/-- A scalar experimental estimate, consisting of a centre and uncertainty. -/
structure ScalarEstimate where
  centralValue : ℝ
  uncertainty : ℝ

/-- The reported `0.94 ± 0.02 g`, expressed in kilograms. -/
def officialMassEstimateKilograms : ScalarEstimate :=
  ⟨0.00094, 0.00002⟩

/-- The reported `3.24 mmol` with `0.7 mmol` uncertainty, expressed in moles. -/
def officialAmountEstimateMoles : ScalarEstimate :=
  ⟨0.00324, 0.0007⟩

/-- The reported `(1.95 ± 0.05) · 10²¹` molecules. -/
def officialMoleculeCountEstimate : ScalarEstimate :=
  ⟨1.95 * 10 ^ 21, 0.05 * 10 ^ 21⟩

/-- Whether a scalar readout lies within a stated experimental uncertainty. -/
def WithinEstimate (readout : ℝ) (estimate : ScalarEstimate) : Prop :=
  |readout - estimate.centralValue| ≤ estimate.uncertainty

/-- The proposition represented by the official numerical answer. -/
def MatchesOfficialSample (model : SubstanceCountingModel)
    (setup : IsochoricAirSetup model) : Prop :=
  WithinEstimate (siValue setup.confinedAirCA.mass)
      officialMassEstimateKilograms ∧
    WithinEstimate (model.amountInMoles setup.confinedAirCA.amount)
      officialAmountEstimateMoles ∧
    WithinEstimate (model.moleculeCount setup.confinedAirCA.molecules)
      officialMoleculeCountEstimate

/--
Part A.1: determine the mass, amount of substance, and molecular population of
the confined air column.

The three conclusions solve the governing relations in sequence: first for
`m` from density and Figure 17, then for `n` from the ideal-gas law, and finally
for `N` using the Avogadro conversion.
-/
theorem determineConfinedAirInventory
    (model : SubstanceCountingModel)
    (setup : IsochoricAirSetup model)
    (_readouts : SourceReadouts model setup)
    (_conditions : ExperimentalConditions model setup)
    (_admissible : PhysicalAdmissibility model setup)
    (_laws : GoverningLaws model setup) :
    siValue setup.confinedAirCA.mass =
        siValue setup.ambientAirDensity *
          cylindricalAirVolumeSI setup.geometry ∧
      model.amountInMoles setup.confinedAirCA.amount =
        siValue setup.confinedAirCA.pressure *
            cylindricalAirVolumeSI setup.geometry /
          (setup.universalGasConstantJPerMoleKelvin *
            siValue setup.confinedAirCA.absoluteTemperature) ∧
      model.moleculeCount setup.confinedAirCA.molecules =
        setup.avogadroConstantPerMole *
          (siValue setup.confinedAirCA.pressure *
              cylindricalAirVolumeSI setup.geometry /
            (setup.universalGasConstantJPerMoleKelvin *
              siValue setup.confinedAirCA.absoluteTemperature)) := by
  sorry

end IPhO2026Problems.IPhO2026_4_A_1

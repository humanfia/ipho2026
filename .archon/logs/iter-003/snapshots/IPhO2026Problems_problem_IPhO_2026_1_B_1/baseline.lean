import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Analysis.Real.Sqrt
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Physlib.Units.WithDim.Basic

/-!
# IPhO 2026, problem 1, part B.1

This file models the electron-positron pair in Figure 1b.  Physical scalar and
vector quantities use PhysLean's unit-independent `Dimensionful` quantities;
all equations between numerical readouts are explicitly stated in SI units.
The Coulomb conic laws printed as hints on the source page are exposed as
governing laws rather than being replaced by the requested numerical answer.
-/

namespace IPhO2026Problems.IPhO2026_1_B_1

open Dimension UnitChoices

/-- Three-dimensional Euclidean space used for the Figure 1b geometry. -/
abbrev Space := EuclideanSpace ℝ (Fin 3)

/-- A unit-independent scalar physical quantity of dimension `d`. -/
abbrev ScalarQuantity (d : Dimension) := Dimensionful (WithDim d ℝ)

/-- A unit-independent spatial vector physical quantity of dimension `d`. -/
abbrev VectorQuantity (d : Dimension) := Dimensionful (WithDim d Space)

/-- The dimension of velocity. -/
def velocityDimension : Dimension := L𝓭 * T𝓭⁻¹

/-- The dimension of angular momentum, including the reduced Planck constant. -/
def angularMomentumDimension : Dimension := M𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹

/-- The dimension of energy. -/
def energyDimension : Dimension := M𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹

/-- The dimension of Coulomb's constant. -/
def coulombConstantDimension : Dimension :=
  M𝓭 * L𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹ * C𝓭⁻¹ * C𝓭⁻¹

/-- The dimension of vacuum permittivity. -/
def permittivityDimension : Dimension :=
  C𝓭 * C𝓭 * T𝓭 * T𝓭 * M𝓭⁻¹ * L𝓭⁻¹ * L𝓭⁻¹ * L𝓭⁻¹

abbrev PhysicalLength := ScalarQuantity L𝓭
abbrev PhysicalMass := ScalarQuantity M𝓭
abbrev PhysicalCharge := ScalarQuantity C𝓭
abbrev PhysicalSpeed := ScalarQuantity velocityDimension
abbrev PhysicalAngularMomentum := ScalarQuantity angularMomentumDimension
abbrev PhysicalEnergy := ScalarQuantity energyDimension
abbrev PhysicalCoulombConstant := ScalarQuantity coulombConstantDimension
abbrev PhysicalPermittivity := ScalarQuantity permittivityDimension
abbrev PositionVector := VectorQuantity L𝓭
abbrev VelocityVector := VectorQuantity velocityDimension

/-- The numerical SI readout of a scalar dimensionful quantity. -/
noncomputable def scalarInSI {d : Dimension} (quantity : ScalarQuantity d) : ℝ :=
  (quantity SI).val

/-- The numerical SI coordinate vector of a dimensionful spatial vector. -/
noncomputable def vectorInSI {d : Dimension} (quantity : VectorQuantity d) : Space :=
  (quantity SI).val

/--
Physical constants and common particle data for the electron-positron pair.
The single mass field records that both particles have mass `m`, while
`elementaryChargeMagnitude` is the positive magnitude `e` of their charges.
-/
structure PhysicalConstants where
  mass : PhysicalMass
  elementaryChargeMagnitude : PhysicalCharge
  reducedPlanckConstant : PhysicalAngularMomentum
  vacuumPermittivity : PhysicalPermittivity
  coulombConstant : PhysicalCoulombConstant
  bohrRadius : PhysicalLength
  speedOfLight : PhysicalSpeed
  mass_pos : 0 < scalarInSI mass
  elementaryChargeMagnitude_pos : 0 < scalarInSI elementaryChargeMagnitude
  reducedPlanckConstant_pos : 0 < scalarInSI reducedPlanckConstant
  vacuumPermittivity_pos : 0 < scalarInSI vacuumPermittivity
  bohrRadius_pos : 0 < scalarInSI bohrRadius
  speedOfLight_pos : 0 < scalarInSI speedOfLight
  coulomb_constant_law :
    scalarInSI coulombConstant =
      1 / (4 * Real.pi * scalarInSI vacuumPermittivity)
  bohr_radius_law :
    scalarInSI bohrRadius =
      4 * Real.pi * scalarInSI vacuumPermittivity *
          scalarInSI reducedPlanckConstant ^ 2 /
        (scalarInSI mass * scalarInSI elementaryChargeMagnitude ^ 2)

/--
The instantaneous data shown in Figure 1b.  Positions are measured from the
center of mass.  The dimensionless factor `mu` is specialized to `4` for B.1.
-/
structure Figure1bInitialState (constants : PhysicalConstants) where
  mu : ℝ
  positronCharge : PhysicalCharge
  electronCharge : PhysicalCharge
  positronPosition : PositionVector
  electronPosition : PositionVector
  relativeSeparationVector : PositionVector
  positronVelocity : VelocityVector
  electronVelocity : VelocityVector
  initialSeparation : PhysicalLength
  positronAngularMomentumMagnitude : PhysicalAngularMomentum
  electronAngularMomentumMagnitude : PhysicalAngularMomentum
  mu_eq_four : mu = 4
  positron_charge_law :
    scalarInSI positronCharge =
      scalarInSI constants.elementaryChargeMagnitude
  electron_charge_law :
    scalarInSI electronCharge =
      -scalarInSI constants.elementaryChargeMagnitude
  center_of_mass_origin :
    vectorInSI positronPosition + vectorInSI electronPosition = 0
  relative_separation_law :
    vectorInSI relativeSeparationVector =
      vectorInSI positronPosition - vectorInSI electronPosition
  separation_is_distance :
    ‖vectorInSI relativeSeparationVector‖ = scalarInSI initialSeparation
  initial_separation_readout :
    scalarInSI initialSeparation = 100 * scalarInSI constants.bohrRadius
  initial_separation_pos : 0 < scalarInSI initialSeparation
  velocities_antiparallel :
    ∃ ratio : ℝ, 0 < ratio ∧
      vectorInSI positronVelocity =
        (-ratio) • vectorInSI electronVelocity
  positron_velocity_transverse :
    inner ℝ (vectorInSI relativeSeparationVector)
      (vectorInSI positronVelocity) = 0
  electron_velocity_transverse :
    inner ℝ (vectorInSI relativeSeparationVector)
      (vectorInSI electronVelocity) = 0
  positron_angular_momentum_definition :
    scalarInSI positronAngularMomentumMagnitude =
      scalarInSI constants.mass * ‖vectorInSI positronPosition‖ *
        ‖vectorInSI positronVelocity‖
  electron_angular_momentum_definition :
    scalarInSI electronAngularMomentumMagnitude =
      scalarInSI constants.mass * ‖vectorInSI electronPosition‖ *
        ‖vectorInSI electronVelocity‖
  positron_angular_momentum_readout :
    scalarInSI positronAngularMomentumMagnitude =
      mu * scalarInSI constants.reducedPlanckConstant
  electron_angular_momentum_readout :
    scalarInSI electronAngularMomentumMagnitude =
      mu * scalarInSI constants.reducedPlanckConstant

/--
A classical trajectory of the pair.  Its real argument is explicitly the SI
time coordinate in seconds.  `conicParameter` is the numerator called `a` in
the polar conic equation printed in Hint 2.
-/
structure ElectronPositronOrbit where
  initialTimeSI : ℝ
  positronPositionAt : ℝ → PositionVector
  electronPositionAt : ℝ → PositionVector
  positronVelocityAt : ℝ → VelocityVector
  electronVelocityAt : ℝ → VelocityVector
  separationAt : ℝ → PhysicalLength
  kineticEnergyAt : ℝ → PhysicalEnergy
  electrostaticPotentialEnergyAt : ℝ → PhysicalEnergy
  totalAngularMomentumMagnitudeAt : ℝ → PhysicalAngularMomentum
  totalEnergy : PhysicalEnergy
  totalAngularMomentumMagnitude : PhysicalAngularMomentum
  eccentricity : ℝ
  conicParameter : PhysicalLength
  polarAngleAt : ℝ → ℝ
  maximumSeparation : PhysicalLength

/-- The relative position coordinate of the positron with respect to the electron. -/
noncomputable def relativePositionInSI
    (orbit : ElectronPositronOrbit) (timeSI : ℝ) : Space :=
  vectorInSI (orbit.positronPositionAt timeSI) -
    vectorInSI (orbit.electronPositionAt timeSI)

/-- The relative velocity coordinate of the positron with respect to the electron. -/
noncomputable def relativeVelocityInSI
    (orbit : ElectronPositronOrbit) (timeSI : ℝ) : Space :=
  vectorInSI (orbit.positronVelocityAt timeSI) -
    vectorInSI (orbit.electronVelocityAt timeSI)

/--
The system is bound in the sense stated in B.1: its relative position is
periodic, hence the particles follow a closed orbit about their center of mass.
The remaining fields give the defining order properties of the maximum
separation and the two apsidal directions of a complete ellipse.
-/
structure IsBoundClosedOrbit (orbit : ElectronPositronOrbit) : Prop where
  closed_orbit :
    ∃ periodSI : ℝ, 0 < periodSI ∧
      ∀ timeSI,
        relativePositionInSI orbit (timeSI + periodSI) =
          relativePositionInSI orbit timeSI
  eccentricity_range : 0 ≤ orbit.eccentricity ∧ orbit.eccentricity < 1
  separation_positive :
    ∀ timeSI, 0 < scalarInSI (orbit.separationAt timeSI)
  maximum_is_upper_bound :
    ∀ timeSI,
      scalarInSI (orbit.separationAt timeSI) ≤
        scalarInSI orbit.maximumSeparation
  maximum_is_attained :
    ∃ timeSI,
      orbit.separationAt timeSI = orbit.maximumSeparation
  apocentre_direction_is_attained :
    ∃ timeSI, Real.cos (orbit.polarAngleAt timeSI) = 1
  pericentre_direction_is_attained :
    ∃ timeSI, Real.cos (orbit.polarAngleAt timeSI) = -1

/--
The governing classical, isolated, non-relativistic electrostatic model.

The energy equations express that the only interaction potential is Coulomb's
potential and that total mechanical energy is conserved.  Angular momentum is
likewise conserved.  The last three fields are precisely the standard Coulomb
conic relations, including the two hints printed on the official source page.
-/
structure SatisfiesClassicalCoulombConicLaws
    (constants : PhysicalConstants)
    (initial : Figure1bInitialState constants)
    (orbit : ElectronPositronOrbit) : Prop where
  initial_positron_position :
    orbit.positronPositionAt orbit.initialTimeSI = initial.positronPosition
  initial_electron_position :
    orbit.electronPositionAt orbit.initialTimeSI = initial.electronPosition
  initial_positron_velocity :
    orbit.positronVelocityAt orbit.initialTimeSI = initial.positronVelocity
  initial_electron_velocity :
    orbit.electronVelocityAt orbit.initialTimeSI = initial.electronVelocity
  initial_separation :
    orbit.separationAt orbit.initialTimeSI = initial.initialSeparation
  center_of_mass_frame :
    ∀ timeSI,
      vectorInSI (orbit.positronPositionAt timeSI) +
        vectorInSI (orbit.electronPositionAt timeSI) = 0
  separation_is_relative_distance :
    ∀ timeSI,
      scalarInSI (orbit.separationAt timeSI) =
        ‖relativePositionInSI orbit timeSI‖
  positron_nonrelativistic :
    ∀ timeSI,
      ‖vectorInSI (orbit.positronVelocityAt timeSI)‖ <
        scalarInSI constants.speedOfLight
  electron_nonrelativistic :
    ∀ timeSI,
      ‖vectorInSI (orbit.electronVelocityAt timeSI)‖ <
        scalarInSI constants.speedOfLight
  classical_kinetic_energy :
    ∀ timeSI,
      scalarInSI (orbit.kineticEnergyAt timeSI) =
        scalarInSI constants.mass / 2 *
          (‖vectorInSI (orbit.positronVelocityAt timeSI)‖ ^ 2 +
            ‖vectorInSI (orbit.electronVelocityAt timeSI)‖ ^ 2)
  electrostatic_potential_energy :
    ∀ timeSI,
      scalarInSI (orbit.electrostaticPotentialEnergyAt timeSI) =
        -(scalarInSI constants.coulombConstant *
            scalarInSI constants.elementaryChargeMagnitude ^ 2 /
          scalarInSI (orbit.separationAt timeSI))
  isolated_energy_conservation :
    ∀ timeSI,
      scalarInSI orbit.totalEnergy =
        scalarInSI (orbit.kineticEnergyAt timeSI) +
          scalarInSI (orbit.electrostaticPotentialEnergyAt timeSI)
  isolated_angular_momentum_conservation :
    ∀ timeSI,
      scalarInSI (orbit.totalAngularMomentumMagnitudeAt timeSI) =
        scalarInSI orbit.totalAngularMomentumMagnitude
  initial_total_angular_momentum :
    scalarInSI orbit.totalAngularMomentumMagnitude =
      scalarInSI initial.positronAngularMomentumMagnitude +
        scalarInSI initial.electronAngularMomentumMagnitude
  eccentricity_law :
    orbit.eccentricity =
      Real.sqrt
        (1 +
          4 * scalarInSI orbit.totalAngularMomentumMagnitude ^ 2 *
              scalarInSI orbit.totalEnergy /
            (scalarInSI constants.coulombConstant ^ 2 *
              scalarInSI constants.elementaryChargeMagnitude ^ 4 *
              scalarInSI constants.mass))
  conic_parameter_law :
    scalarInSI orbit.conicParameter =
      2 * scalarInSI orbit.totalAngularMomentumMagnitude ^ 2 /
        (scalarInSI constants.mass *
          scalarInSI constants.coulombConstant *
          scalarInSI constants.elementaryChargeMagnitude ^ 2)
  polar_conic_law :
    ∀ timeSI,
      scalarInSI (orbit.separationAt timeSI) =
        scalarInSI orbit.conicParameter /
          (1 - orbit.eccentricity * Real.cos (orbit.polarAngleAt timeSI))

/-- For `mu = 4`, the two equal, co-oriented particle angular momenta total `8 ℏ`. -/
theorem total_angular_momentum_for_mu_four
    (constants : PhysicalConstants)
    (initial : Figure1bInitialState constants)
    (orbit : ElectronPositronOrbit)
    (laws : SatisfiesClassicalCoulombConicLaws constants initial orbit) :
    scalarInSI orbit.totalAngularMomentumMagnitude =
      8 * scalarInSI constants.reducedPlanckConstant := by
  sorry

/-- The conserved mechanical energy obtained from the Figure 1b initial state. -/
theorem total_energy_for_mu_four
    (constants : PhysicalConstants)
    (initial : Figure1bInitialState constants)
    (orbit : ElectronPositronOrbit)
    (laws : SatisfiesClassicalCoulombConicLaws constants initial orbit) :
    scalarInSI orbit.totalEnergy =
      -((9 : ℝ) / 2500) *
        (scalarInSI constants.coulombConstant *
            scalarInSI constants.elementaryChargeMagnitude ^ 2 /
          scalarInSI constants.bohrRadius) := by
  sorry

/-- The eccentricity of the bound Coulomb ellipse for `mu = 4`. -/
theorem eccentricity_for_mu_four
    (constants : PhysicalConstants)
    (initial : Figure1bInitialState constants)
    (orbit : ElectronPositronOrbit)
    (laws : SatisfiesClassicalCoulombConicLaws constants initial orbit) :
    orbit.eccentricity = (7 : ℝ) / 25 := by
  sorry

/-- The semi-latus rectum (the numerator in Hint 2) for `mu = 4`. -/
theorem conic_parameter_for_mu_four
    (constants : PhysicalConstants)
    (initial : Figure1bInitialState constants)
    (orbit : ElectronPositronOrbit)
    (laws : SatisfiesClassicalCoulombConicLaws constants initial orbit) :
    scalarInSI orbit.conicParameter =
      128 * scalarInSI constants.bohrRadius := by
  sorry

/--
For the bound `mu = 4` electron-positron pair, the maximum separation is
`1600 / 9` Bohr radii.

Blueprint: `thm:physics:IPhO_2026_1_B_1:target`.
-/
theorem maximum_separation_for_mu_four
    (constants : PhysicalConstants)
    (initial : Figure1bInitialState constants)
    (orbit : ElectronPositronOrbit)
    (laws : SatisfiesClassicalCoulombConicLaws constants initial orbit)
    (bound : IsBoundClosedOrbit orbit) :
    scalarInSI orbit.maximumSeparation =
      ((1600 : ℝ) / 9) * scalarInSI constants.bohrRadius := by
  sorry

end IPhO2026Problems.IPhO2026_1_B_1

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Geometry.Euclidean.Angle.Oriented.Basic
import Mathlib.Order.Filter.AtTopBot.Tendsto
import Physlib.Units.WithDim.Energy

/-!
# IPhO 2026, problem 1, part B.2

This file models the classical electron--positron Coulomb-scattering problem
shown in Figure 1b. Physical quantities are represented by Physlib
`Dimensionful (WithDim ...)` types; real numbers occur only as explicit SI
readouts, dimensionless parameters, time-in-seconds coordinates, or angles.

The supplied eccentricity and polar-conic formulas are recorded as governing
laws. The requested signed asymptotic deflection is only a theorem conclusion.
-/

noncomputable section

open Dimension Filter
open scoped RealInnerProductSpace Topology

namespace IPhO2026Problems.IPhO2026_1_B_2

/-! ## Dimension-carrying quantities -/

/-- The oriented two-dimensional plane containing the trajectories in Figure 1b. -/
abbrev Plane : Type :=
  EuclideanSpace ℝ (Fin 2)

/-- The standard plane has real dimension two, as required by the oriented-angle API. -/
local instance planeFinrankTwo : Fact (Module.finrank ℝ Plane = 2) :=
  ⟨by simp [Plane]⟩

/-- Velocity dimension `L T⁻¹`. -/
def velocityDimension : Dimension :=
  L𝓭 * T𝓭⁻¹

/-- Angular-momentum/action dimension `M L² T⁻¹`. -/
def angularMomentumDimension : Dimension :=
  M𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹

/-- Vacuum-permittivity dimension `C² T² M⁻¹ L⁻³`. -/
def permittivityDimension : Dimension :=
  C𝓭 * C𝓭 * T𝓭 * T𝓭 * M𝓭⁻¹ * L𝓭⁻¹ * L𝓭⁻¹ * L𝓭⁻¹

/-- Coulomb-constant dimension `M L³ T⁻² C⁻²`. -/
def coulombConstantDimension : Dimension :=
  M𝓭 * L𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹ * C𝓭⁻¹ * C𝓭⁻¹

abbrev DimLength : Type :=
  Dimensionful (WithDim L𝓭 ℝ)

abbrev DimMass : Type :=
  Dimensionful (WithDim M𝓭 ℝ)

abbrev DimCharge : Type :=
  Dimensionful (WithDim C𝓭 ℝ)

abbrev DimPosition : Type :=
  Dimensionful (WithDim L𝓭 Plane)

abbrev DimVelocityVector : Type :=
  Dimensionful (WithDim velocityDimension Plane)

abbrev DimSpeed : Type :=
  Dimensionful (WithDim velocityDimension ℝ)

abbrev DimAngularMomentum : Type :=
  Dimensionful (WithDim angularMomentumDimension ℝ)

abbrev DimPermittivity : Type :=
  Dimensionful (WithDim permittivityDimension ℝ)

abbrev DimCoulombConstant : Type :=
  Dimensionful (WithDim coulombConstantDimension ℝ)

/-- The scalar SI readout of a dimensionful scalar quantity. -/
def scalarSI {d : Dimension}
    (quantity : Dimensionful (WithDim d ℝ)) : ℝ :=
  (quantity.1 UnitChoices.SI).val

/-- The component vector in the standard SI units for its dimension. -/
def vectorSI {d : Dimension}
    (quantity : Dimensionful (WithDim d Plane)) : Plane :=
  (quantity.1 UnitChoices.SI).val

/-! ## Particles, constants, and Figure 1b -/

/-- The two labeled particles in Figure 1b. -/
inductive ParticleLabel where
  | positron
  | electron
deriving DecidableEq

/--
The universal constants and common particle mass used in the problem.
`elementaryChargeMagnitude` is positive; the signs of the two particles are
specified separately in `Figure1bInitialConditions`.
-/
structure PhysicalConstants where
  particleMass_m : DimMass
  elementaryChargeMagnitude_e : DimCharge
  reducedPlanckConstant_hbar : DimAngularMomentum
  vacuumPermittivity_epsilon0 : DimPermittivity
  bohrRadius_a0 : DimLength
  coulombConstant_k : DimCoulombConstant
  speedOfLight_c : DimSpeed
  particleMass_positive : 0 < scalarSI particleMass_m
  elementaryCharge_positive : 0 < scalarSI elementaryChargeMagnitude_e
  hbar_positive : 0 < scalarSI reducedPlanckConstant_hbar
  vacuumPermittivity_positive : 0 < scalarSI vacuumPermittivity_epsilon0
  bohrRadius_positive : 0 < scalarSI bohrRadius_a0
  coulombConstant_positive : 0 < scalarSI coulombConstant_k
  speedOfLight_positive : 0 < scalarSI speedOfLight_c

/--
The two constant identities printed on the source page:
`a₀ = 4 π ε₀ ℏ² / (m e²)` and `k = 1 / (4 π ε₀)`.
-/
structure ConstantRelations (constants : PhysicalConstants) : Prop where
  bohrRadius_formula :
    scalarSI constants.bohrRadius_a0 =
      4 * Real.pi * scalarSI constants.vacuumPermittivity_epsilon0 *
          scalarSI constants.reducedPlanckConstant_hbar ^ 2 /
        (scalarSI constants.particleMass_m *
          scalarSI constants.elementaryChargeMagnitude_e ^ 2)
  coulombConstant_formula :
    scalarSI constants.coulombConstant_k =
      1 / (4 * Real.pi * scalarSI constants.vacuumPermittivity_epsilon0)

/--
The dimensionful positions and velocities of both particles. The real
argument is the time readout in seconds, with the pictured instant at `0`.
-/
structure PairMotion where
  mass : ParticleLabel → DimMass
  charge : ParticleLabel → DimCharge
  position : ParticleLabel → ℝ → DimPosition
  velocity : ParticleLabel → ℝ → DimVelocityVector

/-- SI position vector of a labeled particle at the specified time in seconds. -/
def positionSI
    (motion : PairMotion) (particle : ParticleLabel) (seconds : ℝ) : Plane :=
  vectorSI (motion.position particle seconds)

/-- SI velocity vector of a labeled particle at the specified time in seconds. -/
def velocitySI
    (motion : PairMotion) (particle : ParticleLabel) (seconds : ℝ) : Plane :=
  vectorSI (motion.velocity particle seconds)

/-- SI mass readout of a labeled particle. -/
def particleMassSI (motion : PairMotion) (particle : ParticleLabel) : ℝ :=
  scalarSI (motion.mass particle)

/-- SI charge readout of a labeled particle. -/
def particleChargeSI (motion : PairMotion) (particle : ParticleLabel) : ℝ :=
  scalarSI (motion.charge particle)

/-- Relative displacement from the electron to the positron, in metres. -/
def relativeDisplacementSI (motion : PairMotion) (seconds : ℝ) : Plane :=
  positionSI motion .positron seconds - positionSI motion .electron seconds

/-- Positron velocity relative to the electron, in metres per second. -/
def relativeVelocitySI (motion : PairMotion) (seconds : ℝ) : Plane :=
  velocitySI motion .positron seconds - velocitySI motion .electron seconds

/-- Electron--positron separation in metres. -/
def separationSI (motion : PairMotion) (seconds : ℝ) : ℝ :=
  ‖relativeDisplacementSI motion seconds‖

/--
The oriented axes read from Figure 1b. `initialPositronDirection` points right,
and `electronToPositronDirection` points upward from `e⁻` to `e⁺`.
-/
structure Figure1bFrame where
  orientation : Orientation ℝ Plane (Fin 2)
  initialPositronDirection : Plane
  electronToPositronDirection : Plane
  initialDirection_unit : ‖initialPositronDirection‖ = 1
  separationDirection_unit : ‖electronToPositronDirection‖ = 1
  positiveQuarterTurn :
    orientation.oangle initialPositronDirection electronToPositronDirection =
      ((Real.pi / 2 : ℝ) : Real.Angle)

/-- Signed angular momentum of one particle about a chosen center, in SI units. -/
def signedAngularMomentumSI
    (motion : PairMotion) (frame : Figure1bFrame)
    (centerOfMass : DimPosition) (particle : ParticleLabel) : ℝ :=
  particleMassSI motion particle *
    frame.orientation.areaForm
      (positionSI motion particle 0 - vectorSI centerOfMass)
      (velocitySI motion particle 0)

/-- Magnitude of the pair's total angular momentum about the center of mass. -/
def totalAngularMomentumMagnitudeSI
    (motion : PairMotion) (frame : Figure1bFrame)
    (centerOfMass : DimPosition) : ℝ :=
  |signedAngularMomentumSI motion frame centerOfMass .positron +
    signedAngularMomentumSI motion frame centerOfMass .electron|

/--
All numerical and geometric data at the pictured instant. These fields encode
equal masses, opposite elementary charges, vertical separation `100 a₀`,
antiparallel transverse velocities, and individual angular-momentum magnitude
`μ ℏ` with `μ = 15/2`.
-/
structure Figure1bInitialConditions
    (constants : PhysicalConstants) (motion : PairMotion)
    (frame : Figure1bFrame) where
  centerOfMass : DimPosition
  initialParticleSpeed : DimSpeed
  mu : ℝ
  initialParticleSpeed_positive : 0 < scalarSI initialParticleSpeed
  mu_value : mu = (15 : ℝ) / 2
  positronMass :
    particleMassSI motion .positron = scalarSI constants.particleMass_m
  electronMass :
    particleMassSI motion .electron = scalarSI constants.particleMass_m
  positronCharge :
    particleChargeSI motion .positron =
      scalarSI constants.elementaryChargeMagnitude_e
  electronCharge :
    particleChargeSI motion .electron =
      -scalarSI constants.elementaryChargeMagnitude_e
  centerOfMass_midpoint :
    positionSI motion .positron 0 + positionSI motion .electron 0 =
      (2 : ℝ) • vectorSI centerOfMass
  initialSeparation :
    relativeDisplacementSI motion 0 =
      (100 * scalarSI constants.bohrRadius_a0) •
        frame.electronToPositronDirection
  positronInitialVelocity :
    velocitySI motion .positron 0 =
      scalarSI initialParticleSpeed • frame.initialPositronDirection
  electronInitialVelocity :
    velocitySI motion .electron 0 =
      (-scalarSI initialParticleSpeed) • frame.initialPositronDirection
  positronAngularMomentumMagnitude :
    |signedAngularMomentumSI motion frame centerOfMass .positron| =
      mu * scalarSI constants.reducedPlanckConstant_hbar
  electronAngularMomentumMagnitude :
    |signedAngularMomentumSI motion frame centerOfMass .electron| =
      mu * scalarSI constants.reducedPlanckConstant_hbar

/-! ## Classical isolated Coulomb dynamics -/

/-- Coulomb force on the positron, evaluated in SI components. -/
def coulombForceOnPositronSI
    (constants : PhysicalConstants) (motion : PairMotion)
    (seconds : ℝ) : Plane :=
  ((scalarSI constants.coulombConstant_k *
        particleChargeSI motion .positron *
        particleChargeSI motion .electron) /
      ‖relativeDisplacementSI motion seconds‖ ^ 3) •
    relativeDisplacementSI motion seconds

/--
The classical non-relativistic, isolated two-body model.

The kinematic derivative identifies the velocity fields. The two acceleration
equations are Newton's second law with equal-and-opposite Coulomb forces, so no
external force or non-electrostatic interaction is present. The final field
states the non-relativistic speed regime.
-/
structure CoulombDynamics
    (constants : PhysicalConstants) (motion : PairMotion) : Prop where
  noCollision :
    ∀ seconds : ℝ, relativeDisplacementSI motion seconds ≠ 0
  positionDerivative :
    ∀ (particle : ParticleLabel) (seconds : ℝ),
      HasDerivAt
        (fun time => positionSI motion particle time)
        (velocitySI motion particle seconds)
        seconds
  newtonCoulomb :
    ∀ seconds : ℝ, ∃ positronAcceleration electronAcceleration : Plane,
      HasDerivAt
          (fun time => velocitySI motion .positron time)
          positronAcceleration seconds ∧
        HasDerivAt
          (fun time => velocitySI motion .electron time)
          electronAcceleration seconds ∧
        particleMassSI motion .positron • positronAcceleration =
          coulombForceOnPositronSI constants motion seconds ∧
        particleMassSI motion .electron • electronAcceleration =
          -coulombForceOnPositronSI constants motion seconds
  nonrelativistic :
    ∀ (particle : ParticleLabel) (seconds : ℝ),
      ‖velocitySI motion particle seconds‖ <
        scalarSI constants.speedOfLight_c

/-- Total mechanical energy computed at the pictured instant, in joules. -/
def initialTotalEnergySI
    (constants : PhysicalConstants) (motion : PairMotion) : ℝ :=
  (1 / 2 : ℝ) * particleMassSI motion .positron *
      ‖velocitySI motion .positron 0‖ ^ 2 +
    (1 / 2 : ℝ) * particleMassSI motion .electron *
      ‖velocitySI motion .electron 0‖ ^ 2 +
    scalarSI constants.coulombConstant_k *
      particleChargeSI motion .positron *
      particleChargeSI motion .electron /
        separationSI motion 0

/--
Data used by the two conic-orbit hints on the official source page.
`semiLatusRectum_a` is the length denoted `a` in the printed polar equation.
-/
structure ConicOrbitData where
  totalEnergy_E : DimEnergy
  totalAngularMomentumMagnitude_L : DimAngularMomentum
  eccentricity : ℝ
  semiLatusRectum_a : DimLength
  periapsisAxis : Plane
  polarAngleRad : ℝ → ℝ

/--
The supplied Kepler/Coulomb eccentricity law and polar conic equation.
Neither field contains the requested asymptotic deflection.
-/
structure ConicOrbitLaws
    (constants : PhysicalConstants) (motion : PairMotion)
    (frame : Figure1bFrame)
    (initial : Figure1bInitialConditions constants motion frame)
    (orbit : ConicOrbitData) : Prop where
  energyMatchesInitialState :
    scalarSI orbit.totalEnergy_E = initialTotalEnergySI constants motion
  angularMomentumMatchesInitialState :
    scalarSI orbit.totalAngularMomentumMagnitude_L =
      totalAngularMomentumMagnitudeSI motion frame initial.centerOfMass
  eccentricityFormula :
    orbit.eccentricity =
      Real.sqrt
        (1 +
          4 * scalarSI orbit.totalAngularMomentumMagnitude_L ^ 2 *
              scalarSI orbit.totalEnergy_E /
            (scalarSI constants.coulombConstant_k ^ 2 *
              scalarSI constants.elementaryChargeMagnitude_e ^ 4 *
              scalarSI constants.particleMass_m))
  hyperbolicEccentricity : 1 < orbit.eccentricity
  semiLatusRectum_positive : 0 < scalarSI orbit.semiLatusRectum_a
  periapsisAxis_unit : ‖orbit.periapsisAxis‖ = 1
  polarAngleDefinition :
    ∀ seconds : ℝ,
      frame.orientation.oangle
          orbit.periapsisAxis (relativeDisplacementSI motion seconds) =
        ((orbit.polarAngleRad seconds : ℝ) : Real.Angle)
  polarConicEquation :
    ∀ seconds : ℝ,
      separationSI motion seconds =
        scalarSI orbit.semiLatusRectum_a /
          (1 - orbit.eccentricity * Real.cos (orbit.polarAngleRad seconds))

/-- The stated unbound condition: the separation tends to infinity in the future. -/
def IsUnbound (motion : PairMotion) : Prop :=
  Tendsto (separationSI motion) atTop atTop

/-! ## Current B.2 target -/

/--
The signed counterclockwise angle from the initial positron velocity to the
asymptotic positron-relative-to-electron velocity, reported in degrees.
-/
def signedDeflectionDegrees
    (motion : PairMotion) (frame : Figure1bFrame)
    (uInfinity : Plane) : ℝ :=
  (frame.orientation.oangle
      (velocitySI motion .positron 0) uInfinity).toReal *
    180 / Real.pi

/--
`actual` rounds to `reported` at two digits after the decimal point. The
half-unit tolerance is `0.005`.
-/
def RoundsToNearestHundredth (actual reported : ℝ) : Prop :=
  |actual - reported| ≤ (1 : ℝ) / 200

/--
IPhO 2026 Problem 1 B.2: the outgoing relative velocity is directed
`16.60°` below the initial positron line of motion.

The hypotheses assigning `uInfinity` its limiting-velocity role contain no
information about its direction. The negative sign and the numerical
deflection occur only in this conclusion.
-/
theorem IPhO_2026_1_B_2
    (constants : PhysicalConstants)
    (constantRelations : ConstantRelations constants)
    (motion : PairMotion)
    (frame : Figure1bFrame)
    (initial : Figure1bInitialConditions constants motion frame)
    (dynamics : CoulombDynamics constants motion)
    (orbit : ConicOrbitData)
    (orbitLaws : ConicOrbitLaws constants motion frame initial orbit)
    (uInfinity : Plane)
    (unbound : IsUnbound motion)
    (uInfinity_nonzero : uInfinity ≠ 0)
    (uInfinity_isAsymptoticRelativeVelocity :
      Tendsto (relativeVelocitySI motion) atTop (𝓝 uInfinity)) :
    signedDeflectionDegrees motion frame uInfinity < 0 ∧
      RoundsToNearestHundredth
        (signedDeflectionDegrees motion frame uInfinity)
        (-(83 : ℝ) / 5) := by
  have mu_positive : 0 < initial.mu := by
    rw [initial.mu_value]
    norm_num
  have eccentricity_positive : 0 < orbit.eccentricity :=
    lt_trans (by norm_num) orbitLaws.hyperbolicEccentricity
  have separation_tends_to_infinity :
      Tendsto (separationSI motion) atTop atTop := by
    simpa [IsUnbound] using unbound
  have relative_velocity_tends_to_uInfinity :
      Tendsto (relativeVelocitySI motion) atTop (𝓝 uInfinity) :=
    uInfinity_isAsymptoticRelativeVelocity
  have separation_positive (seconds : ℝ) :
      0 < separationSI motion seconds := by
    exact norm_pos_iff.mpr (dynamics.noCollision seconds)
  have frame_directions_inner_zero :
      ⟪frame.initialPositronDirection,
        frame.electronToPositronDirection⟫ = 0 := by
    rw [frame.orientation.inner_eq_norm_mul_norm_mul_cos_oangle,
      frame.initialDirection_unit, frame.separationDirection_unit,
      frame.positiveQuarterTurn, Real.Angle.cos_coe]
    simp
  have frame_directions_area_abs :
      |frame.orientation.areaForm frame.initialPositronDirection
        frame.electronToPositronDirection| = 1 := by
    have hnorm :=
      frame.orientation.norm_kahler
        frame.initialPositronDirection frame.electronToPositronDirection
    rw [frame.initialDirection_unit, frame.separationDirection_unit,
      mul_one] at hnorm
    rw [frame.orientation.kahler_apply_apply,
      frame_directions_inner_zero] at hnorm
    simpa using hnorm
  have reversed_frame_directions_area_abs :
      |frame.orientation.areaForm frame.electronToPositronDirection
        frame.initialPositronDirection| = 1 := by
    rw [frame.orientation.areaForm_swap, abs_neg,
      frame_directions_area_abs]
  have positron_offset_eq_half_relative :
      positionSI motion .positron 0 - vectorSI initial.centerOfMass =
        (1 / 2 : ℝ) • relativeDisplacementSI motion 0 := by
    have hmid := initial.centerOfMass_midpoint
    rw [relativeDisplacementSI]
    calc
      positionSI motion .positron 0 - vectorSI initial.centerOfMass =
          positionSI motion .positron 0 -
            (1 / 2 : ℝ) •
              ((2 : ℝ) • vectorSI initial.centerOfMass) := by module
      _ = positionSI motion .positron 0 -
            (1 / 2 : ℝ) •
              (positionSI motion .positron 0 +
                positionSI motion .electron 0) := by rw [hmid]
      _ = (1 / 2 : ℝ) •
            (positionSI motion .positron 0 -
              positionSI motion .electron 0) := by module
  have electron_offset_eq_neg_half_relative :
      positionSI motion .electron 0 - vectorSI initial.centerOfMass =
        (-1 / 2 : ℝ) • relativeDisplacementSI motion 0 := by
    have hmid := initial.centerOfMass_midpoint
    rw [relativeDisplacementSI]
    calc
      positionSI motion .electron 0 - vectorSI initial.centerOfMass =
          positionSI motion .electron 0 -
            (1 / 2 : ℝ) •
              ((2 : ℝ) • vectorSI initial.centerOfMass) := by module
      _ = positionSI motion .electron 0 -
            (1 / 2 : ℝ) •
              (positionSI motion .positron 0 +
                positionSI motion .electron 0) := by rw [hmid]
      _ = (-1 / 2 : ℝ) •
            (positionSI motion .positron 0 -
              positionSI motion .electron 0) := by module
  have signed_angular_momenta_equal :
      signedAngularMomentumSI motion frame initial.centerOfMass .positron =
        signedAngularMomentumSI motion frame initial.centerOfMass .electron := by
    rw [signedAngularMomentumSI, signedAngularMomentumSI,
      initial.positronMass, initial.electronMass,
      positron_offset_eq_half_relative,
      electron_offset_eq_neg_half_relative,
      initial.positronInitialVelocity, initial.electronInitialVelocity]
    simp
    ring
  have positron_angular_momentum_abs_formula :
      |signedAngularMomentumSI
          motion frame initial.centerOfMass .positron| =
        50 * scalarSI constants.particleMass_m *
          scalarSI constants.bohrRadius_a0 *
          scalarSI initial.initialParticleSpeed := by
    rw [signedAngularMomentumSI, initial.positronMass,
      positron_offset_eq_half_relative, initial.initialSeparation,
      initial.positronInitialVelocity]
    simp only [map_smul, LinearMap.smul_apply, smul_eq_mul]
    rw [abs_mul, abs_mul, abs_mul, abs_mul,
      abs_of_nonneg (by norm_num : (0 : ℝ) ≤ 1 / 2),
      abs_of_pos constants.particleMass_positive,
      abs_of_pos
        (mul_pos (by norm_num : (0 : ℝ) < 100)
          constants.bohrRadius_positive),
      abs_of_pos initial.initialParticleSpeed_positive,
      reversed_frame_directions_area_abs]
    ring
  have total_angular_momentum_value :
      totalAngularMomentumMagnitudeSI
          motion frame initial.centerOfMass =
        2 * initial.mu *
          scalarSI constants.reducedPlanckConstant_hbar := by
    rw [totalAngularMomentumMagnitudeSI, signed_angular_momenta_equal,
      ← two_mul, abs_mul, abs_of_nonneg (by norm_num),
      initial.electronAngularMomentumMagnitude]
    ring
  have orbit_angular_momentum_value :
      scalarSI orbit.totalAngularMomentumMagnitude_L =
        2 * initial.mu *
          scalarSI constants.reducedPlanckConstant_hbar := by
    rw [orbitLaws.angularMomentumMatchesInitialState,
      total_angular_momentum_value]
  have speed_angular_momentum_relation :
      50 * scalarSI constants.particleMass_m *
          scalarSI constants.bohrRadius_a0 *
          scalarSI initial.initialParticleSpeed =
        initial.mu *
          scalarSI constants.reducedPlanckConstant_hbar := by
    rw [← positron_angular_momentum_abs_formula,
      initial.positronAngularMomentumMagnitude]
  have initial_speed_value :
      scalarSI initial.initialParticleSpeed =
        initial.mu *
            scalarSI constants.reducedPlanckConstant_hbar /
          (50 * scalarSI constants.particleMass_m *
            scalarSI constants.bohrRadius_a0) := by
    apply (eq_div_iff ?_).2
    · nlinarith [speed_angular_momentum_relation]
    · exact mul_ne_zero
        (mul_ne_zero (by norm_num)
          (ne_of_gt constants.particleMass_positive))
        (ne_of_gt constants.bohrRadius_positive)
  have bohr_coulomb_identity :
      scalarSI constants.particleMass_m *
          scalarSI constants.coulombConstant_k *
          scalarSI constants.elementaryChargeMagnitude_e ^ 2 *
          scalarSI constants.bohrRadius_a0 =
        scalarSI constants.reducedPlanckConstant_hbar ^ 2 := by
    rw [constantRelations.coulombConstant_formula,
      constantRelations.bohrRadius_formula]
    field_simp [ne_of_gt constants.particleMass_positive,
      ne_of_gt constants.elementaryCharge_positive,
      ne_of_gt constants.vacuumPermittivity_positive,
      Real.pi_ne_zero]
  have initial_separation_value :
      separationSI motion 0 =
        100 * scalarSI constants.bohrRadius_a0 := by
    rw [separationSI, initial.initialSeparation, norm_smul,
      frame.separationDirection_unit, mul_one, Real.norm_eq_abs,
      abs_of_pos
        (mul_pos (by norm_num : (0 : ℝ) < 100)
          constants.bohrRadius_positive)]
  have initial_positron_speed_norm :
      ‖velocitySI motion .positron 0‖ =
        scalarSI initial.initialParticleSpeed := by
    rw [initial.positronInitialVelocity, norm_smul,
      frame.initialDirection_unit, mul_one, Real.norm_eq_abs,
      abs_of_pos initial.initialParticleSpeed_positive]
  have initial_electron_speed_norm :
      ‖velocitySI motion .electron 0‖ =
        scalarSI initial.initialParticleSpeed := by
    rw [initial.electronInitialVelocity, norm_smul,
      frame.initialDirection_unit, mul_one, Real.norm_eq_abs,
      abs_neg, abs_of_pos initial.initialParticleSpeed_positive]
  have initial_energy_formula :
      initialTotalEnergySI constants motion =
        scalarSI constants.particleMass_m *
            scalarSI initial.initialParticleSpeed ^ 2 -
          scalarSI constants.coulombConstant_k *
              scalarSI constants.elementaryChargeMagnitude_e ^ 2 /
            (100 * scalarSI constants.bohrRadius_a0) := by
    rw [initialTotalEnergySI, initial.positronMass,
      initial.electronMass, initial_positron_speed_norm,
      initial_electron_speed_norm, initial.positronCharge,
      initial.electronCharge, initial_separation_value]
    ring
  have initial_energy_value :
      initialTotalEnergySI constants motion =
        scalarSI constants.coulombConstant_k *
            scalarSI constants.elementaryChargeMagnitude_e ^ 2 /
          (80 * scalarSI constants.bohrRadius_a0) := by
    rw [initial_energy_formula, initial_speed_value, initial.mu_value]
    have hm := ne_of_gt constants.particleMass_positive
    have ha := ne_of_gt constants.bohrRadius_positive
    field_simp [hm, ha]
    nlinarith [bohr_coulomb_identity]
  have orbit_energy_value :
      scalarSI orbit.totalEnergy_E =
        scalarSI constants.coulombConstant_k *
            scalarSI constants.elementaryChargeMagnitude_e ^ 2 /
          (80 * scalarSI constants.bohrRadius_a0) := by
    rw [orbitLaws.energyMatchesInitialState, initial_energy_value]
  have eccentricity_value :
      orbit.eccentricity = (7 : ℝ) / 2 := by
    rw [orbitLaws.eccentricityFormula,
      orbit_angular_momentum_value, orbit_energy_value,
      initial.mu_value]
    have hinside :
        1 +
            4 *
                (2 * ((15 : ℝ) / 2) *
                    scalarSI constants.reducedPlanckConstant_hbar) ^ 2 *
                (scalarSI constants.coulombConstant_k *
                    scalarSI constants.elementaryChargeMagnitude_e ^ 2 /
                  (80 * scalarSI constants.bohrRadius_a0)) /
              (scalarSI constants.coulombConstant_k ^ 2 *
                scalarSI constants.elementaryChargeMagnitude_e ^ 4 *
                scalarSI constants.particleMass_m) =
          (49 : ℝ) / 4 := by
      field_simp [ne_of_gt constants.particleMass_positive,
        ne_of_gt constants.elementaryCharge_positive,
        ne_of_gt constants.bohrRadius_positive,
        ne_of_gt constants.coulombConstant_positive]
      nlinarith [bohr_coulomb_identity]
    rw [hinside]
    rw [show (49 : ℝ) / 4 = ((7 : ℝ) / 2) ^ 2 by norm_num,
      Real.sqrt_sq (by norm_num)]
  have polar_angle_geometry := orbitLaws.polarAngleDefinition
  have polar_conic := orbitLaws.polarConicEquation
  have conic_denominator_positive (seconds : ℝ) :
      0 <
        1 - orbit.eccentricity *
          Real.cos (orbit.polarAngleRad seconds) := by
    have hsep := separation_positive seconds
    rw [polar_conic seconds] at hsep
    rcases (div_pos_iff.mp hsep) with hpos | hneg
    · exact hpos.2
    · exfalso
      linarith [orbitLaws.semiLatusRectum_positive]
  have periapsisAxis_ne_zero : orbit.periapsisAxis ≠ 0 := by
    intro hzero
    have hunit := orbitLaws.periapsisAxis_unit
    rw [hzero, norm_zero] at hunit
    norm_num at hunit
  have polar_cosine_geometry (seconds : ℝ) :
      Real.cos (orbit.polarAngleRad seconds) =
        ⟪orbit.periapsisAxis, relativeDisplacementSI motion seconds⟫ /
          separationSI motion seconds := by
    have hangle :=
      congrArg Real.Angle.cos (polar_angle_geometry seconds)
    rw [Real.Angle.cos_coe] at hangle
    rw [← hangle,
      frame.orientation.cos_oangle_eq_inner_div_norm_mul_norm
        periapsisAxis_ne_zero (dynamics.noCollision seconds)]
    simp [orbitLaws.periapsisAxis_unit, separationSI]
  have conic_denominator_eq (seconds : ℝ) :
      1 - orbit.eccentricity *
          Real.cos (orbit.polarAngleRad seconds) =
        scalarSI orbit.semiLatusRectum_a /
          separationSI motion seconds := by
    have hconic := polar_conic seconds
    have hsep_ne := ne_of_gt (separation_positive seconds)
    have hden_ne := ne_of_gt (conic_denominator_positive seconds)
    field_simp [hsep_ne, hden_ne] at hconic ⊢
    linarith
  have cartesian_conic_equation (seconds : ℝ) :
      separationSI motion seconds -
          orbit.eccentricity *
            ⟪orbit.periapsisAxis,
              relativeDisplacementSI motion seconds⟫ =
        scalarSI orbit.semiLatusRectum_a := by
    have hsep_ne := ne_of_gt (separation_positive seconds)
    have hden := conic_denominator_eq seconds
    rw [polar_cosine_geometry seconds] at hden
    field_simp [hsep_ne] at hden
    linarith
  have conic_denominator_tends_to_zero :
      Tendsto
        (fun seconds =>
          1 - orbit.eccentricity *
            Real.cos (orbit.polarAngleRad seconds))
        atTop (𝓝 0) := by
    exact
      (tendsto_const_nhds.div_atTop separation_tends_to_infinity).congr'
        (Filter.Eventually.of_forall fun seconds =>
          (conic_denominator_eq seconds).symm)
  have polar_cosine_tends_to_inverse_eccentricity :
      Tendsto
        (fun seconds => Real.cos (orbit.polarAngleRad seconds))
        atTop (𝓝 (1 / orbit.eccentricity)) := by
    have hone :
        Tendsto (fun _ : ℝ => (1 : ℝ)) atTop (𝓝 1) :=
      tendsto_const_nhds
    have h :=
      (hone.sub conic_denominator_tends_to_zero).div_const
        orbit.eccentricity
    convert h using 1
    · ext seconds
      field_simp [ne_of_gt eccentricity_positive]
      ring
    · norm_num
  have polar_cosine_tends_to_two_sevenths :
      Tendsto
        (fun seconds => Real.cos (orbit.polarAngleRad seconds))
        atTop (𝓝 ((2 : ℝ) / 7)) := by
    simpa [eccentricity_value] using
      polar_cosine_tends_to_inverse_eccentricity
  have normalized_displacement_axis_component_tends :
      Tendsto
        (fun seconds =>
          ⟪orbit.periapsisAxis,
            relativeDisplacementSI motion seconds⟫ /
            separationSI motion seconds)
        atTop (𝓝 (1 / orbit.eccentricity)) := by
    exact polar_cosine_tends_to_inverse_eccentricity.congr'
      (Filter.Eventually.of_forall fun seconds =>
        polar_cosine_geometry seconds)
  -- The available conic laws control the asymptotic position angle, while
  -- the target concerns the limiting velocity angle.  The contract has no
  -- stated theorem identifying its nonzero limiting velocity with the
  -- outgoing branch of the conic asymptote.  Such a branch law is required
  -- before the signed numerical angle can be deduced.
  sorry

end IPhO2026Problems.IPhO2026_1_B_2

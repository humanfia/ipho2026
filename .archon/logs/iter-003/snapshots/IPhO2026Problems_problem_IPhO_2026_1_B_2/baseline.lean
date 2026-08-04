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
  sorry

end IPhO2026Problems.IPhO2026_1_B_2

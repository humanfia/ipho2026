import Mathlib
import Physlib.Units.Basic

/-!
# IPhO 2026, problem 1, part B.2

An electron and a positron undergo classical, non-relativistic Coulomb
scattering in the plane.  This file records the physical input, the two conic
relations supplied as hints, the orientation visible in Fig. 1b, and the
requested signed angle of the outgoing relative velocity.

Physical quantities themselves live in abstract carrier types indexed by their
Physlib dimensions.  Every real number used in a physical equation is explicitly
a scalar readout in one fixed coherent unit system.  Coordinates, dimensionless
ratios, and angles are real-valued.
-/

namespace IPhO2026_1_B_2

open Filter
open scoped RealInnerProductSpace

abbrev Plane := EuclideanSpace ℝ (Fin 2)

local instance planeFinrank : Fact (Module.finrank ℝ Plane = 2) :=
  ⟨by simp [Plane]⟩

/-- The rightward direction of the initial positron velocity in Fig. 1b. -/
def rightward : Plane := !₂[1, 0]

/-- The upward direction from the electron to the positron in Fig. 1b. -/
def upward : Plane := !₂[0, 1]

/-- The dimension of action and angular momentum, `M L² T⁻¹`. -/
def actionDimension : Dimension :=
  Dimension.M𝓭 * Dimension.L𝓭 * Dimension.L𝓭 * Dimension.T𝓭⁻¹

/-- The dimension of energy, `M L² T⁻²`. -/
def energyDimension : Dimension :=
  Dimension.M𝓭 * Dimension.L𝓭 * Dimension.L𝓭 *
    Dimension.T𝓭⁻¹ * Dimension.T𝓭⁻¹

/-- The dimension of Coulomb's constant, `M L³ T⁻² C⁻²`. -/
def coulombConstantDimension : Dimension :=
  Dimension.M𝓭 * Dimension.L𝓭 * Dimension.L𝓭 * Dimension.L𝓭 *
    Dimension.T𝓭⁻¹ * Dimension.T𝓭⁻¹ *
    Dimension.C𝓭⁻¹ * Dimension.C𝓭⁻¹

/-- The dimension of vacuum permittivity, inverse to Coulomb's constant. -/
def permittivityDimension : Dimension := coulombConstantDimension⁻¹

/--
An abstract physical quantity kind with dimension `d`, together with its
numerical readout in the one coherent system of units used in the equations.
-/
structure QuantityKind (d : Dimension) where
  Carrier : Type
  readout : Carrier → ℝ

/-- The dimensioned primitive quantity types needed by the scattering model. -/
structure QuantityModel where
  mass : QuantityKind Dimension.M𝓭
  charge : QuantityKind Dimension.C𝓭
  length : QuantityKind Dimension.L𝓭
  action : QuantityKind actionDimension
  energy : QuantityKind energyDimension
  coulombConstant : QuantityKind coulombConstantDimension
  permittivity : QuantityKind permittivityDimension

/--
The physical objects, trajectories, conic data, and asymptotic readouts in
part B.2.  The initial instant is represented by `t = 0`, and `t → +∞`
describes the outgoing unbound branch.
-/
structure ScatteringScenario (Q : QuantityModel) where
  particleMass : Q.mass.Carrier
  chargeMagnitude : Q.charge.Carrier
  positronCharge : Q.charge.Carrier
  electronCharge : Q.charge.Carrier
  hbar : Q.action.Carrier
  vacuumPermittivity : Q.permittivity.Carrier
  coulombConstant : Q.coulombConstant.Carrier
  bohrRadius : Q.length.Carrier
  initialSeparation : Q.length.Carrier
  totalAngularMomentum : Q.action.Carrier
  totalEnergy : Q.energy.Carrier
  polarConicParameter : Q.length.Carrier
  mu : ℝ
  initialParticleSpeed : ℝ
  eccentricity : ℝ
  positronPosition : ℝ → Plane
  electronPosition : ℝ → Plane
  positronVelocity : ℝ → Plane
  electronVelocity : ℝ → Plane
  conicAngle : ℝ → ℝ
  outgoingPolarAngle : ℝ
  asymptoticRelativeVelocity : Plane
  screenOrientation : Orientation ℝ Plane (Fin 2)

variable {Q : QuantityModel}

/-- Scalar mass readout in the chosen coherent unit system. -/
def particleMassReadout (S : ScatteringScenario Q) : ℝ :=
  Q.mass.readout S.particleMass

/-- Positive elementary-charge magnitude readout in the chosen unit system. -/
def chargeMagnitudeReadout (S : ScatteringScenario Q) : ℝ :=
  Q.charge.readout S.chargeMagnitude

/-- Reduced Planck constant readout. -/
def hbarReadout (S : ScatteringScenario Q) : ℝ :=
  Q.action.readout S.hbar

/-- Vacuum-permittivity readout. -/
def vacuumPermittivityReadout (S : ScatteringScenario Q) : ℝ :=
  Q.permittivity.readout S.vacuumPermittivity

/-- Coulomb-constant readout. -/
def coulombConstantReadout (S : ScatteringScenario Q) : ℝ :=
  Q.coulombConstant.readout S.coulombConstant

/-- Bohr-radius readout. -/
def bohrRadiusReadout (S : ScatteringScenario Q) : ℝ :=
  Q.length.readout S.bohrRadius

/-- Initial electron--positron separation readout. -/
def initialSeparationReadout (S : ScatteringScenario Q) : ℝ :=
  Q.length.readout S.initialSeparation

/-- Conserved total angular-momentum magnitude readout. -/
def totalAngularMomentumReadout (S : ScatteringScenario Q) : ℝ :=
  Q.action.readout S.totalAngularMomentum

/-- Conserved total-energy readout. -/
def totalEnergyReadout (S : ScatteringScenario Q) : ℝ :=
  Q.energy.readout S.totalEnergy

/-- The length readout denoted by `a` in the supplied polar-conic hint. -/
def polarConicParameterReadout (S : ScatteringScenario Q) : ℝ :=
  Q.length.readout S.polarConicParameter

/-- Separation vector directed from the electron to the positron. -/
def separationVector (S : ScatteringScenario Q) (t : ℝ) : Plane :=
  S.positronPosition t - S.electronPosition t

/-- Positron velocity relative to the electron. -/
def relativeVelocity (S : ScatteringScenario Q) (t : ℝ) : Plane :=
  S.positronVelocity t - S.electronVelocity t

/-- Electron--positron separation distance. -/
noncomputable def separationRadius (S : ScatteringScenario Q) (t : ℝ) : ℝ :=
  ‖separationVector S t‖

/-- The signed, counterclockwise-positive deflection from the initial positron line. -/
noncomputable def signedDeflectionRadians (S : ScatteringScenario Q) : ℝ :=
  (S.screenOrientation.oangle
    (S.positronVelocity 0) S.asymptoticRelativeVelocity).toReal

/-- Conversion of a dimensionless angle readout from radians to degrees. -/
noncomputable def radiansToDegrees (θ : ℝ) : ℝ := θ * 180 / Real.pi

/--
The governing physical laws and source/figure readouts.

These fields state Newton--Coulomb dynamics, the initial data, conserved-energy
and angular-momentum relations, the two supplied conic hints, and genuine limit
relations on the outgoing branch.  They do not contain the requested deflection
angle.
-/
structure CoulombScatteringLaws (S : ScatteringScenario Q) : Prop where
  particleMass_pos : 0 < particleMassReadout S
  chargeMagnitude_pos : 0 < chargeMagnitudeReadout S
  hbar_pos : 0 < hbarReadout S
  vacuumPermittivity_pos : 0 < vacuumPermittivityReadout S
  bohrRadius_pos : 0 < bohrRadiusReadout S
  coulombConstant_pos : 0 < coulombConstantReadout S
  initialParticleSpeed_pos : 0 < S.initialParticleSpeed
  positron_charge_readout :
    Q.charge.readout S.positronCharge = chargeMagnitudeReadout S
  electron_charge_readout :
    Q.charge.readout S.electronCharge = -chargeMagnitudeReadout S
  coulomb_constant_definition :
    coulombConstantReadout S =
      1 / (4 * Real.pi * vacuumPermittivityReadout S)
  bohr_radius_definition :
    bohrRadiusReadout S =
      4 * Real.pi * vacuumPermittivityReadout S * hbarReadout S ^ 2 /
        (particleMassReadout S * chargeMagnitudeReadout S ^ 2)
  mu_value : S.mu = 15 / 2
  initial_separation_value :
    initialSeparationReadout S = 100 * bohrRadiusReadout S
  fig1b_positron_position :
    S.positronPosition 0 =
      (initialSeparationReadout S / 2) • upward
  fig1b_electron_position :
    S.electronPosition 0 =
      -(initialSeparationReadout S / 2) • upward
  fig1b_positron_velocity :
    S.positronVelocity 0 = S.initialParticleSpeed • rightward
  fig1b_electron_velocity :
    S.electronVelocity 0 = -S.initialParticleSpeed • rightward
  initial_velocities_antiparallel :
    S.positronVelocity 0 = -S.electronVelocity 0
  initial_velocity_perpendicular_to_separation :
    inner ℝ (separationVector S 0) (S.positronVelocity 0) = 0
  fig1b_counterclockwise_orientation :
    (S.screenOrientation.oangle rightward upward).toReal = Real.pi / 2
  positron_velocity_is_derivative :
    ∀ t, HasDerivAt S.positronPosition (S.positronVelocity t) t
  electron_velocity_is_derivative :
    ∀ t, HasDerivAt S.electronPosition (S.electronVelocity t) t
  no_collision : ∀ t, separationVector S t ≠ 0
  positron_newton_coulomb :
    ∀ t, HasDerivAt S.positronVelocity
      ((-(coulombConstantReadout S * chargeMagnitudeReadout S ^ 2 /
        (particleMassReadout S * separationRadius S t ^ 3))) •
        separationVector S t) t
  electron_newton_coulomb :
    ∀ t, HasDerivAt S.electronVelocity
      ((coulombConstantReadout S * chargeMagnitudeReadout S ^ 2 /
        (particleMassReadout S * separationRadius S t ^ 3)) •
        separationVector S t) t
  each_particle_angular_momentum :
    particleMassReadout S * (initialSeparationReadout S / 2) *
        S.initialParticleSpeed =
      S.mu * hbarReadout S
  total_angular_momentum :
    totalAngularMomentumReadout S = 2 * S.mu * hbarReadout S
  total_energy_from_initial_data :
    totalEnergyReadout S =
      particleMassReadout S * S.initialParticleSpeed ^ 2 -
        coulombConstantReadout S * chargeMagnitudeReadout S ^ 2 /
          initialSeparationReadout S
  unbound_positive_energy : 0 < totalEnergyReadout S
  eccentricity_hint :
    S.eccentricity =
      Real.sqrt
        (1 + 4 * totalAngularMomentumReadout S ^ 2 * totalEnergyReadout S /
          (coulombConstantReadout S ^ 2 * chargeMagnitudeReadout S ^ 4 *
            particleMassReadout S))
  polar_conic_parameter_pos : 0 < polarConicParameterReadout S
  polar_conic_parameter_definition :
    polarConicParameterReadout S =
      totalAngularMomentumReadout S ^ 2 /
        ((particleMassReadout S / 2) * coulombConstantReadout S *
          chargeMagnitudeReadout S ^ 2)
  polar_conic_hint :
    ∀ t, separationRadius S t =
      polarConicParameterReadout S /
        (1 - S.eccentricity * Real.cos (S.conicAngle t))
  initial_conic_angle : S.conicAngle 0 = Real.pi
  conic_angle_matches_position :
    ∀ t, (S.screenOrientation.oangle (-upward) (separationVector S t)).toReal =
      S.conicAngle t
  outgoing_angle_range :
    0 < S.outgoingPolarAngle ∧ S.outgoingPolarAngle < Real.pi
  outgoing_conic_angle_limit :
    Tendsto S.conicAngle atTop (nhds S.outgoingPolarAngle)
  unbound_separation_limit :
    Tendsto (separationRadius S) atTop atTop
  asymptotic_relative_velocity_limit :
    Tendsto (relativeVelocity S) atTop (nhds S.asymptoticRelativeVelocity)
  asymptotic_relative_velocity_ne_zero :
    S.asymptoticRelativeVelocity ≠ 0
  outgoing_velocity_is_radial :
    Tendsto
      (fun t => (separationRadius S t)⁻¹ • separationVector S t)
      atTop
      (nhds (‖S.asymptoticRelativeVelocity‖⁻¹ •
        S.asymptoticRelativeVelocity))

/--
The conic equation on an unbounded branch forces the limiting polar angle to
be `arccos (1 / eccentricity)`.  The range hypothesis selects the outgoing
branch rather than the other root of the cosine equation.
-/
theorem outgoing_polar_angle_of_hyperbolic_conic
    (eccentricity conicParameter : ℝ)
    (radius polarAngle : ℝ → ℝ)
    (outgoingPolarAngle : ℝ)
    (hEccentricity : 1 < eccentricity)
    (hConicParameter : 0 < conicParameter)
    (hRadiusPositive : ∀ t, 0 < radius t)
    (hConic :
      ∀ t, radius t =
        conicParameter / (1 - eccentricity * Real.cos (polarAngle t)))
    (hRadiusLimit : Tendsto radius atTop atTop)
    (hAngleLimit : Tendsto polarAngle atTop (nhds outgoingPolarAngle))
    (hOutgoingBranch : 0 ≤ outgoingPolarAngle ∧ outgoingPolarAngle ≤ Real.pi) :
    outgoingPolarAngle = Real.arccos (1 / eccentricity) := by
  sorry

/--
The source constants, initial angular momentum, energy relation, and supplied
eccentricity formula give eccentricity `7/2` when `μ = 15/2`.
-/
theorem eccentricity_at_mu_fifteen_halves
    (S : ScatteringScenario Q) (h : CoulombScatteringLaws S) :
    S.eccentricity = 7 / 2 := by
  sorry

/-- The outgoing branch therefore has polar angle `arccos (2/7)`. -/
theorem outgoing_polar_angle_at_mu_fifteen_halves
    (S : ScatteringScenario Q) (h : CoulombScatteringLaws S) :
    S.outgoingPolarAngle = Real.arccos (2 / 7) := by
  sorry

/--
Fig. 1b puts the initial positron velocity along the positive horizontal axis,
while the conic's polar zero-axis points downward.  The radial outgoing limit
therefore converts polar angle `θ∞` into signed deflection `θ∞ - π/2`.
-/
theorem fig1b_signed_deflection_from_polar_angle
    (S : ScatteringScenario Q) (h : CoulombScatteringLaws S) :
    signedDeflectionRadians S = S.outgoingPolarAngle - Real.pi / 2 := by
  sorry

/--
For `μ = 15/2`, the outgoing relative velocity is deflected clockwise, below
the initial positron line.  The last conjunct is a rounding certificate:
the signed angle in degrees rounds to `-16.60°` to two decimal places.
-/
theorem asymptotic_relative_velocity_angle
    (S : ScatteringScenario Q) (h : CoulombScatteringLaws S) :
    signedDeflectionRadians S =
        Real.arccos (2 / 7) - Real.pi / 2 ∧
      signedDeflectionRadians S < 0 ∧
      |radiansToDegrees (signedDeflectionRadians S) + 83 / 5| < 1 / 200 := by
  sorry

end IPhO2026_1_B_2

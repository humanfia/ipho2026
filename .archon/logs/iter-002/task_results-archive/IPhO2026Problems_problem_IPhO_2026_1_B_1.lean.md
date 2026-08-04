# Autoformalization result

## Assumption/target split

### Governing laws

- `PhysicalConstants.coulomb_constant_law` states
  \(k=1/(4\pi\epsilon_0)\), and `bohr_radius_law` states
  \(a_0=4\pi\epsilon_0\hbar^2/(me^2)\).
- `SatisfiesClassicalCoulombConicLaws.classical_kinetic_energy`,
  `electrostatic_potential_energy`, and `isolated_energy_conservation` state
  the classical two-particle kinetic energy, the attractive Coulomb potential
  \(-ke^2/r\), and conservation of total energy.
- `isolated_angular_momentum_conservation` and
  `initial_total_angular_momentum` state conservation of total angular
  momentum and its initial decomposition into the two co-oriented particle
  angular momenta.
- `eccentricity_law` is the source-page Hint 1 relation
  \(\varepsilon=\sqrt{1+4L^2E/(k^2e^4m)}\).
- `conic_parameter_law` states the standard Coulomb semi-latus-rectum relation
  \(a=2L^2/(mke^2)\), with reduced mass \(m/2\).
- `polar_conic_law` is the source-page Hint 2 relation
  \(r=a/(1-\varepsilon\cos\theta)\).
- `positron_nonrelativistic` and `electron_nonrelativistic` bound each
  particle's speed by the speed of light.  The trajectory and energy laws
  encode the classical model and the electrostatic-only interaction.
- `IsBoundClosedOrbit` records a positive period, a closed relative orbit,
  \(0\leq\varepsilon<1\), positivity of separation, the order-theoretic
  definition and attainment of the maximum, and attainment of both apsidal
  directions.

### Previous-part results

- None.  The source report lists no previous parts for B.1, and the
  formalization imports no other IPhO problem output.

### Figure/data readouts and current-condition data

- `Figure1bInitialState` distinguishes the positron and electron charges
  \(+e\) and \(-e\), their positions relative to the center of mass, their
  velocities, the relative-separation vector, and their individual angular
  momentum magnitudes.
- `center_of_mass_origin`, `relative_separation_law`, and
  `separation_is_distance` formalize the geometry of Figure 1b.
- `initial_separation_readout` states the displayed separation
  \(r_0=100a_0\).
- `velocities_antiparallel`,
  `positron_velocity_transverse`, and
  `electron_velocity_transverse` formalize the displayed antiparallel
  velocities perpendicular to the separation.
- `mu_eq_four` is the B.1 condition \(\mu=4\).  The two angular-momentum
  readouts state \(L_+=L_-=\mu\hbar\), and their definition fields relate
  these magnitudes to \(mrv\).
- `IsBoundClosedOrbit` is the question's stated condition that the pair is
  bound and moves in a closed orbit; it does not assign a numerical value to
  the maximum separation.

### Current target conclusions

- `total_angular_momentum_for_mu_four` concludes \(L=8\hbar\).
- `total_energy_for_mu_four` concludes
  \(E=-(9/2500)\,ke^2/a_0\).
- `eccentricity_for_mu_four` concludes \(\varepsilon=7/25\).
- `conic_parameter_for_mu_four` concludes \(a=128a_0\).
- `maximum_separation_for_mu_four` concludes
  \(r_{\max}=(1600/9)a_0\), the requested B.1 answer.

## Goal-faithfulness audit

The requested coefficient `1600 / 9` occurs only in the documentation and
conclusion of `maximum_separation_for_mu_four`.  It does not occur in
`PhysicalConstants`, `Figure1bInitialState`, `ElectronPositronOrbit`,
`IsBoundClosedOrbit`, `SatisfiesClassicalCoulombConicLaws`, or any helper
definition.  The `maximumSeparation` field supplies the unknown physical
quantity, while `maximum_is_upper_bound` and `maximum_is_attained` merely
define its role as a maximum.

Likewise, the intermediate numerical values `8`, `-9/2500`, `7/25`, and
`128` occur only as conclusions of separate `by sorry` theorems, not as
hypotheses or law fields.  The transparent helpers `scalarInSI`,
`vectorInSI`, `relativePositionInSI`, and `relativeVelocityInSI` are only
unit/readout or kinematic projections and do not encode any target relation.

## Declarations created and blueprint correspondence

- Dimensional infrastructure: `ScalarQuantity`, `VectorQuantity`,
  `velocityDimension`, `angularMomentumDimension`, `energyDimension`,
  `coulombConstantDimension`, `permittivityDimension`, and the corresponding
  physical-quantity abbreviations.
- Readouts: `scalarInSI` and `vectorInSI`.
- Physical model: `PhysicalConstants`, `Figure1bInitialState`,
  `ElectronPositronOrbit`, `IsBoundClosedOrbit`, and
  `SatisfiesClassicalCoulombConicLaws`.
- Derived declarations:
  `total_angular_momentum_for_mu_four`,
  `total_energy_for_mu_four`,
  `eccentricity_for_mu_four`, and
  `conic_parameter_for_mu_four`.
- `IPhO2026Problems.IPhO2026_1_B_1.maximum_separation_for_mu_four`
  corresponds to `thm:physics:IPhO_2026_1_B_1:target`.

The target statement is formalized and compiles with a `by sorry` body.  It is
ready for the blueprint statement marker once the plan/review layer supplies
the missing `\lean{...}` association; the prover did not edit the blueprint
because that file is read-only in this stage.

## LeanExplore queries/candidates actually used

- Query `dimensionful physical quantity with units length mass electric
  charge` found `Dimension`, `UnitChoices`, `Dimensionful`,
  `Dimension.L𝓭`, `Dimension.M𝓭`, and `Dimension.C𝓭`.
- Query `Dimensionful Dimension.L𝓭 Dimension.M𝓭 Dimension.C𝓭` confirmed the
  PhysLean dimensional API.
- Query `WithDim length dimensional physical quantity real value units` found
  `WithDim`, `WithDim.scaleUnit_val`, and `Dimension.L𝓭`.
- Queries `EuclideanSpace real finite vectors inner product zero
  perpendicular norm` and `EuclideanSpace` grounded the spatial-vector model.
- Query `Real.sqrt square root nonnegative real and Real.cos cosine` grounded
  the eccentricity and conic expressions.
- Query `ChargeUnit.elementaryCharge` confirmed that this declaration is a
  *unit choice*, not the dimensionful charge magnitude of a particle.
- Queries `classical Coulomb two body orbit eccentricity conic point particle
  electrostatic potential energy` and `CoulombPotential KeplerOrbit
  PointParticle eccentricity polar conic` found stationary point-particle
  electromagnetic potentials and
  `Electromagnetism.EMSystem.coulombConstant`, but no matching dynamical
  two-body Coulomb/Kepler orbit API.

Source/module details were fetched for `Dimensionful` (`Physlib.Units.Basic`),
`WithDim` (`Physlib.Units.WithDim.Basic`), `Dimension.L𝓭`
(`Physlib.Units.Dimension`), `EuclideanSpace`
(`Mathlib.Analysis.InnerProductSpace.PiL2`), `Real.sqrt`
(`Mathlib.Analysis.Real.Sqrt`), `ChargeUnit.elementaryCharge`
(`Physlib.Electromagnetism.Charge.ChargeUnit`), and
`Electromagnetism.EMSystem.coulombConstant`
(`Physlib.Electromagnetism.Basic`).

## PhysLean/Mathlib names grounded

- PhysLean/Physlib: `Dimensionful`, `WithDim`, `Dimension`, `Dimension.L𝓭`,
  `Dimension.T𝓭`, `Dimension.M𝓭`, `Dimension.C𝓭`, `UnitChoices`, and
  `UnitChoices.SI`.
- Mathlib: `EuclideanSpace`, `inner`, the norm notation, `Real.sqrt`,
  `Real.cos`, and `Real.pi`.
- Imports actually used:
  `Physlib.Units.WithDim.Basic`,
  `Mathlib.Analysis.InnerProductSpace.PiL2`,
  `Mathlib.Analysis.Real.Sqrt`, and
  `Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic`.

## Local abstractions introduced

- PhysLean dimensions are assembled into the missing physical dimensions for
  speed, angular momentum, energy, Coulomb's constant, and permittivity.
  Every scalar/vector physical primitive is a genuine unit-independent
  `Dimensionful (WithDim d ...)` value, not a transparent real-number alias.
- `Figure1bInitialState` is the smallest typed interface preserving the
  electron/positron identities, opposite charges, center-of-mass geometry,
  transverse antiparallel velocities, and angular-momentum readouts.
- `ElectronPositronOrbit`, `IsBoundClosedOrbit`, and
  `SatisfiesClassicalCoulombConicLaws` are local because the searches found no
  library object for a classical, isolated, non-relativistic two-body
  attractive Coulomb conic.  Their fields expose the physical conservation,
  Coulomb-potential, eccentricity, conic-parameter, and polar-orbit laws
  directly.

## Grounding gaps

- PhysLean's stationary point-particle electromagnetic-potential declarations
  do not provide two-body trajectories, conserved mechanical quantities, or
  Coulomb conics.
- `Electromagnetism.EMSystem.coulombConstant` is an untyped scalar attached to
  the older `EMSystem` API.  It does not preserve the dimensionful role needed
  here, so the model uses a dimensionful constant with the same defining law.
- `ChargeUnit.elementaryCharge` represents a choice of charge unit rather than
  the physical charge carried by either particle, so it is not substituted
  for `PhysicalCharge`.
- The blueprint target currently lacks a `\lean{...}` declaration name.  The
  plan/review layer should attach
  `\lean{IPhO2026Problems.IPhO2026_1_B_1.maximum_separation_for_mu_four}`.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors; exactly five
  expected `declaration uses sorry` warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`: exit code 0,
  with exactly the same five expected warnings.
- `git diff --check` reported no whitespace errors.

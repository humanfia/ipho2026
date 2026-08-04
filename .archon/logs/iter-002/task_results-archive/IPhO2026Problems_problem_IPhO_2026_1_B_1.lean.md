# Autoformalization result: IPhO 2026 Problem 1 B.1

## Status

- Created `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_1.lean` exits
  successfully.
- Lean LSP reports only the expected `declaration uses sorry` warning on
  `maximum_separation_for_mu_four`.
- The assigned file did not previously exist, so it contained no
  `/- USER: ... -/` comment.
- The chapter contains `% archon:physics`; the physics-formalize discipline was
  used.

## Assumption/target split

### Governing laws

- `coulomb_constant_definition` states
  `k = 1 / (4 π ε₀)`.
- `bohr_radius_definition` states
  `a₀ = 4 π ε₀ ℏ² / (m e²)`.
- `turningPointEnergyReadout` is the classical effective energy
  `4 ℓ² / (m r²) - k e² / r` at a radial turning point.  The first term is the
  total kinetic energy of the two equal-mass particles when each has angular
  momentum magnitude `ℓ` about the center of mass; the second is the attractive
  Coulomb potential.
- `isolated_energy_at_initial_turning_point` and
  `isolated_energy_at_outer_turning_point` equate the same conserved total
  energy to that effective energy at the two turning points.
- `bound_orbit_energy` records the source's bound-orbit condition as negative
  total energy.
- Positivity assumptions make every physical denominator nonzero and retain
  the magnitude roles of mass, charge, `ε₀`, `ℏ`, `a₀`, and both separations.

### Previous-part results

- None.  The source report has `previous_parts: []`, and the file imports no
  sibling problem output.

### Figure/data readouts

- `ParticleState` and `CoulombPairSystem` distinguish the positron `e⁺` and
  electron `e⁻` shown in Fig. 1b.
- `equal_masses`, `positron_charge`, and `electron_charge` encode equal masses
  and equal-magnitude opposite charges.
- `figure_center_of_mass` places the two position vectors oppositely about the
  center of mass.
- `figure_antiparallel_velocities` and the two `inner ℝ ... = 0` fields encode
  the directed antiparallel and transverse velocity readouts.
- `figure_initial_separation` links the Euclidean separation norm to the
  dimensioned scalar readout, and
  `initial_separation_is_one_hundred_bohr_radii` states `r₀ = 100 a₀`.
- `figure_positron_angular_momentum_magnitude` and
  `figure_electron_angular_momentum_magnitude` link each displayed transverse
  velocity to the corresponding angular momentum through
  `ℓ = m (r₀/2) ‖v‖`.
- `positron_angular_momentum` and `electron_angular_momentum` state that each
  magnitude is `μ ℏ`; `mu_eq_four` specializes the current subquestion.
- `outer_turning_point_branch` records that the requested maximum is the
  distinct outer turning point rather than the displayed `100 a₀` turning
  point.

### Current target conclusions

- The sole current target is
  `maximumSeparation.val = (1600 / 9) * bohrRadius.val`.

## Goal-faithfulness audit

The value `1600 / 9` occurs only in the conclusion of
`maximum_separation_for_mu_four`.  It does not occur in
`CoulombPairSystem`, `CoulombPairLaws`, or
`turningPointEnergyReadout`.

The branch hypothesis states only that the displayed initial turning point is
strictly inside the requested outer turning point.  This is needed to reject
the other algebraic root `r = 100 a₀`; it does not prescribe the requested
root.  The effective-energy helper is a generic classical Coulomb law at an
arbitrary separation and cannot make the final numerical equality true merely
by unfolding.

## Derivability and bridge obligations

1. **Source claim:** the types retain the roles and dimensions of length, mass,
   charge, velocity, action/angular momentum, energy, Coulomb's constant, and
   vacuum permittivity.
   **Lean carrier:** Physlib's `WithDim`, with `Dimension.L𝓭`, `M𝓭`, `T𝓭`,
   and `C𝓭`, in the quantity abbreviations.
   **Evidence:** these are dimension-indexed types, not transparent aliases to
   `ℝ`; only their fixed-unit scalar readouts use `.val`.
   **Status:** covered (Physlib-grounded).

2. **Source claim:** Fig. 1b has opposite center-of-mass positions,
   antiparallel velocities, transverse motion, and separation `100 a₀`.
   **Lean carrier:** `figure_center_of_mass`,
   `figure_antiparallel_velocities`,
   `figure_positron_velocity_perpendicular`,
   `figure_electron_velocity_perpendicular`,
   `figure_initial_separation`, and
   `initial_separation_is_one_hundred_bohr_radii`, together with the two
   `figure_*_angular_momentum_magnitude` equations.
   **Evidence:** these expose vector equalities, real inner-product equations,
   Euclidean norm equations, the exact scalar separation equation, and
   `ℓ = m (r₀/2) ‖v‖` for both particles.
   **Status:** covered (encoded locally from Fig. 1b).

3. **Source claim:** each particle has angular momentum magnitude `μ ℏ`, with
   `μ = 4`.
   **Lean carrier:** `positron_angular_momentum`,
   `electron_angular_momentum`, and `mu_eq_four`.
   **Evidence:** all three are explicit scalar-readout equations on
   action-dimensioned quantities.
   **Status:** covered (encoded locally).  Physlib's located
   `RigidBody.angularMomentum` is for a continuum rigid body and is not a
   compatible point-particle carrier.

4. **Source claim:** classical transverse motion gives total kinetic energy
   `4 ℓ² / (m r²)`.
   **Lean carrier:** the first term of `turningPointEnergyReadout`.
   **Evidence:** for each particle, distance to the center of mass is `r/2`
   and `ℓ = m(r/2)v`; summing the two values of `m v² / 2` gives the encoded
   term.
   **Status:** covered (faithful local governing-law reduction).

5. **Source claim:** opposite charges interacting only electrostatically have
   potential energy `-k e² / r`.
   **Lean carrier:** the second term of `turningPointEnergyReadout`, together
   with `positron_charge`, `electron_charge`, and
   `coulomb_constant_definition`.
   **Evidence:** the negative sign and charge-magnitude square are explicit.
   **Status:** covered (faithful local governing-law reduction).

6. **Source claim:** isolation conserves total energy between the initial and
   maximum-separation instants.
   **Lean carrier:** the two `isolated_energy_at_*_turning_point` equations
   sharing `CoulombPairSystem.totalEnergy`.
   **Evidence:** rewriting both fields yields equality of the two exact
   effective-energy readouts.
   **Status:** covered (encoded locally).

7. **Source claim:** the Bohr-radius and Coulomb-constant definitions reduce
   the coupling to `k e² = ℏ² / (m a₀)`.
   **Lean carrier:** `coulomb_constant_definition`,
   `bohr_radius_definition`, and the positivity fields.
   **Evidence:** the two source definitions are stated verbatim as real
   readout equations; positivity discharges the denominator side conditions.
   **Status:** covered (direct algebraic bridge).

8. **Source claim:** the requested separation is the outer radial turning
   point.
   **Lean carrier:** `isolated_energy_at_outer_turning_point` and
   `outer_turning_point_branch`.
   **Evidence:** after substituting `r₀ = 100 a₀` and `μ = 4`, equality of
   effective energies has roots `r/a₀ = 100` and `1600/9`; the strict branch
   inequality excludes the first.
   **Status:** covered (branch encoded locally).

9. **Source claim:** `r_max = (1600/9) a₀`.
   **Lean carrier:** the contract of
   `maximum_separation_for_mu_four`.
   **Evidence:** bridges 3--8 reduce its conclusion to the factorization
   `(r_max/a₀ - 100) * (9 * r_max/a₀ - 1600) = 0`, with the first factor
   excluded by the outer branch.
   **Status:** covered at statement level; proof body intentionally remains
   `sorry` for the later physics prover stage.

## Abstraction sufficiency and countermodel audit

- `CoulombPairLaws` is the only local `Prop`-valued interface.  It exposes:
  positivity inequalities; mass, charge, constant, figure, and
  angular-momentum equations (including the velocity-to-angular-momentum
  bridge); two exact conserved-energy equations; negative energy; and a strict
  turning-point branch inequality.
- `turningPointEnergyReadout` is not an opaque relation.  It is the explicit
  real equation `4 ℓ²/(m r²) - k e²/r`, usable by simplification and field
  algebra.
- A model cannot interpret the physical interface arbitrarily while choosing a
  false maximum separation: the two energy equations force the two-root
  polynomial, and the strict branch excludes the initial root.  The positivity
  fields exclude zero-denominator countermodels.
- The vector geometry fields are separately constraining and are tied to the
  scalar angular-momentum data by
  `figure_positron_angular_momentum_magnitude` and
  `figure_electron_angular_momentum_magnitude`, even though the final scalar
  calculation uses the already-reduced turning-energy consequences.

## Uncertainty and branch coverage

- **Uncertainty:** genuinely not applicable.  The source gives exact constants
  and no `value ± uncertainty` measurement.
- **Signed charge branch:** covered by positive charge magnitude and the
  explicit positron/electron sign equations.
- **Velocity orientation:** covered by antiparallel vector equality and both
  transverse inner-product equations.
- **Radial turning-point branch:** covered by
  `outer_turning_point_branch`, which prevents selecting the displayed
  `100 a₀` root as the maximum.

## Declarations created and blueprint correspondence

All declarations are in namespace `IPhO2026Problem1B1`.

- Dimensioned quantities: `LengthQuantity`, `MassQuantity`,
  `ChargeQuantity`, `PositionQuantity`, `VelocityQuantity`,
  `ActionQuantity`, `EnergyQuantity`, `CoulombConstantQuantity`, and
  `VacuumPermittivityQuantity`.
- Physical data: `ParticleState` and `CoulombPairSystem`.
- Governing-law reduction: `turningPointEnergyReadout`.
- Constraining interface: `CoulombPairLaws`.
- Main target:
  `IPhO2026Problem1B1.maximum_separation_for_mu_four`, corresponding to
  `thm:physics:IPhO_2026_1_B_1:target`.

The chapter has no `\lean{...}` declaration annotation.  Under the local
prover-role rules the prover did not edit the blueprint; deterministic marker
sync/review should attach the main declaration name and manage `\leanok`.

## LeanExplore queries/candidates actually used

All searches used package filters `["Mathlib", "Physlib"]`.

- Query: `classical two body Coulomb potential energy angular momentum central
  force orbital turning point maximum radius`
  - Inspected `RigidBody.angularMomentum`; rejected because it models a
    continuum rigid body rather than either point particle.
  - Inspected `ClassicalMechanics.VisViva` candidates; rejected because the
    available interface is gravitational and does not state this
    equal-mass Coulomb turning-point law.
- Query: `Euclidean space inner product norm orthogonal vectors real cross
  product angular momentum`
  - Grounded the Euclidean inner-product/norm approach.
- Query: `potential energy Coulomb electrostatic point charges k q1 q2 divided
  by distance`
  - Inspected `Electromagnetism.EMSystem.coulombConstant`; its source confirms
    `1 / (4 * π * ε₀)`, but it is an untagged `ℝ` associated with the older
    `EMSystem` API, so the same source law was encoded on a dimension-tagged
    local constant.
- Query: `PhysLean dimensionful quantity length mass charge action energy
  units SI` and `DimLength DimMass DimCharge DimEnergy Dimensionful physical
  dimensions aliases`
  - Grounded Physlib's dimensional framework (`Dimensionful`, `WithDim`,
    `Dimension`, `Dimension.L𝓭`, and `DimEnergy`).
- Query: `EuclideanSpace`
  - Used Mathlib's `EuclideanSpace ℝ (Fin 3)`.
- Query: `WithDim`
  - Used Physlib's `WithDim`.

## PhysLean/Mathlib names grounded

- Physlib: `WithDim`, `Dimension`, `Dimension.L𝓭`, `Dimension.M𝓭`,
  `Dimension.T𝓭`, `Dimension.C𝓭`.
- Mathlib: `EuclideanSpace`, `inner`, the norm notation `‖·‖`, `Real.pi`.
- Inspected near misses: `Dimensionful`, `DimEnergy`,
  `Electromagnetism.EMSystem.coulombConstant`,
  `RigidBody.angularMomentum`, and `ClassicalMechanics.VisViva`.

## Local abstractions introduced

- The quantity abbreviations specialize Physlib's dimension-tagged `WithDim`;
  unlike scalar aliases, their types retain physical dimensions.
- `ParticleState` separates mass, signed charge, position, velocity, and
  angular-momentum magnitude for each labeled particle.
- `CoulombPairSystem` retains the shared constants, initial and maximum
  separations, conserved energy, and dimensionless `μ`.
- `turningPointEnergyReadout` is the smallest local classical point-particle
  reduction needed because no matching Physlib two-body Coulomb orbit API was
  located.
- `CoulombPairLaws` packages explicit usable equations and inequalities rather
  than opaque regime flags.

Real numbers occur only as fixed-unit readouts of dimension-tagged quantities,
dimensionless `μ`, and the requested dimensionless numerical coefficient.

## Grounding gaps

- No matching Mathlib/Physlib declaration was found for the classical
  equal-mass, oppositely charged point-particle Coulomb effective energy or its
  outer-turning-point theorem.
- `RigidBody.angularMomentum` is not reusable for point particles.
- `Electromagnetism.EMSystem.coulombConstant` has the right scalar formula but
  does not preserve the dimensional role required here.
- Blueprint redraft request: attach
  `\lean{IPhO2026Problem1B1.maximum_separation_for_mu_four}` to the target
  theorem environment.  No source-physics redraft is otherwise needed.

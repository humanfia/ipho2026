# Autoformalization result: IPhO 2026 Problem 1 B.2

## Status

- Created `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` exits
  successfully with exactly five expected `declaration uses sorry` warnings.
- The file did not previously exist, so it contained no
  `/- USER: ... -/` comments.
- The chapter contains `% archon:physics`; the physics-formalize discipline was
  used.
- The official source-page image was inspected.  It supplied Fig. 1b's
  orientation and the two stated hints that were absent from the short
  blueprint summary.

## Assumption/target split

### Governing laws

- `coulomb_constant_definition` and `bohr_radius_definition` state
  `k = 1/(4 π ε₀)` and
  `a₀ = 4 π ε₀ ℏ²/(m e²)` on dimension-indexed scalar readouts.
- `positron_velocity_is_derivative`,
  `electron_velocity_is_derivative`, `no_collision`,
  `positron_newton_coulomb`, and `electron_newton_coulomb` state the
  classical Newton equations for the attractive electrostatic force, with no
  other interaction.
- `each_particle_angular_momentum` and `total_angular_momentum` give
  `m(r₀/2)v = μℏ` for each particle and `L = 2μℏ` for the total magnitude.
- `total_energy_from_initial_data` gives the isolated conserved value
  `E = m v² - k e²/r₀`; `unbound_positive_energy` and
  `unbound_separation_limit` state the positive-energy outgoing regime.
- `eccentricity_hint` states the supplied relation
  `ε = sqrt (1 + 4 L² E/(k² e⁴ m))`.
- `polar_conic_parameter_definition` identifies the polar parameter with
  `L²/((m/2) k e²)`, and `polar_conic_hint` states the supplied conic equation
  `r = a/(1 - ε cos θ)`.
- The conic-angle and relative-velocity `Tendsto` fields, together with
  `outgoing_velocity_is_radial`, state genuine asymptotic relations rather
  than naming the requested answer.

### Previous-part results

- None.  The source report has `previous_parts: []`, and this file imports no
  sibling problem output.

### Figure/data readouts

- `initial_separation_value` states `r₀ = 100 a₀`.
- `fig1b_positron_position` and `fig1b_electron_position` place the positron
  above and the electron below their center of mass.
- `fig1b_positron_velocity` and `fig1b_electron_velocity` put the positron
  rightward and the electron leftward with the same speed.
  `initial_velocities_antiparallel` and
  `initial_velocity_perpendicular_to_separation` record the corresponding
  vector relations explicitly.
- `positron_charge_readout` and `electron_charge_readout` encode charges
  `+e` and `-e`.
- `fig1b_counterclockwise_orientation` chooses screen counterclockwise as the
  positive signed-angle direction.
- `initial_conic_angle`, `conic_angle_matches_position`,
  `outgoing_angle_range`, and `outgoing_velocity_is_radial` select the
  clockwise outgoing branch visible from Fig. 1b.
- `mu_value` states the current subquestion's input `μ = 15/2`.

### Current target conclusions

- `eccentricity_at_mu_fifteen_halves` derives `ε = 7/2`.
- `outgoing_polar_angle_at_mu_fifteen_halves` derives
  `θ∞ = arccos (2/7)`.
- `fig1b_signed_deflection_from_polar_angle` derives the geometric relation
  `δ = θ∞ - π/2`.
- The main target `asymptotic_relative_velocity_angle` concludes
  `δ = arccos (2/7) - π/2`, `δ < 0`, and a rounding certificate showing that
  its signed degree value rounds to `-16.60°`.

## Goal-faithfulness audit

The requested numeric deflection, the expression
`arccos (2/7) - π/2`, the sign `δ < 0`, and the `-16.60°` rounding
certificate occur only in theorem conclusions.  They do not occur in
`ScatteringScenario` or `CoulombScatteringLaws`.

`signedDeflectionRadians` merely names Mathlib's actual oriented angle from
the initial positron velocity vector to the limiting relative-velocity vector;
unfolding it does not prove any value.  Likewise, `radiansToDegrees` is only
unit conversion.  The laws contain the generic eccentricity and polar-conic
relations printed in the official hints, not their specialized answers.

The outgoing/radial hypotheses select an asymptotic branch but do not state its
angle.  The screen-orientation equation fixes the sign convention but does not
state that the final angle is negative.  Thus no current conclusion was
smuggled into a hypothesis, premise structure, or helper definition.

## Derivability and bridge obligations

1. **Source claim:** mass, charge, length, action/angular momentum, energy,
   permittivity, and Coulomb's constant retain distinct dimensional roles.
   **Lean carrier:** `QuantityKind d` and `QuantityModel`, indexed by Physlib
   `Dimension.M𝓭`, `C𝓭`, `L𝓭`, and the locally composed action, energy,
   permittivity, and Coulomb-constant dimensions.
   **Evidence:** each physical object inhabits an abstract carrier at its
   dimension; only `readout` maps it to a real in one named coherent unit
   system.
   **Status:** covered (Physlib-grounded).

2. **Source claim:** the particles have equal mass, opposite charges, initial
   separation `100a₀`, and the directed geometry of Fig. 1b.
   **Lean carrier:** the single `particleMass`, the two charge-readout
   equations, `initial_separation_value`, the four `fig1b_*` position/velocity
   equations, the antiparallel equality, and the inner-product equation.
   **Evidence:** these are explicit physical-object, vector, scalar, and
   orthogonality equations.
   **Status:** covered (encoded from the official figure).

3. **Source claim:** isolated classical electrostatic dynamics has conserved
   angular momentum and total energy.
   **Lean carrier:** the position-derivative and Newton--Coulomb fields,
   `each_particle_angular_momentum`, `total_angular_momentum`, and
   `total_energy_from_initial_data`.
   **Evidence:** the acceleration equations expose the attractive
   inverse-square central force as
   `∓(k e²/(m ‖r‖³)) r`; the scalar conservation equations expose the exact
   quantities later algebra uses.
   **Status:** covered (faithful local governing-law interface).

4. **Source claim:** for `μ = 15/2`, the initial data and Bohr-radius relation
   give positive energy and eccentricity `7/2`.
   **Lean carrier:** `mu_value`, the two constant definitions,
   `initial_separation_value`, the angular-momentum and energy equations,
   `eccentricity_hint`, and the theorem contract
   `eccentricity_at_mu_fifteen_halves`.
   **Evidence:** substitution yields `L = 15ℏ`,
   `E = ℏ²/(80 m a₀²)`, and
   `ε² = 1 + 45/4 = 49/4`; positivity chooses `ε = 7/2`.
   **Status:** covered; proof body intentionally deferred by `sorry`.

5. **Source claim:** an unbounded conic
   `r = a/(1 - ε cos θ)` has outgoing polar angle
   `arccos (1/ε)`.
   **Lean carrier:** `outgoing_polar_angle_of_hyperbolic_conic`, using the
   explicit conic equation, positive `a`, `r → +∞`, `θ → θ∞`, and the
   branch interval `[0, π]`.
   **Evidence:** the radius limit forces
   `1 - ε cos θ∞ = 0`; the interval selects Mathlib's `Real.arccos` branch.
   **Status:** covered by a reusable elimination-theorem contract; proof body
   intentionally deferred by `sorry`.

6. **Source claim:** `ε = 7/2` gives `θ∞ = arccos (2/7)`.
   **Lean carrier:** the theorem contract
   `outgoing_polar_angle_at_mu_fifteen_halves`.
   **Evidence:** it specializes bridge 5 with bridge 4 and the laws'
   positivity/no-collision fields.
   **Status:** covered; proof body intentionally deferred by `sorry`.

7. **Source claim:** the outgoing velocity direction is the outgoing radial
   direction, and Fig. 1b converts polar angle to signed deflection by
   `δ = θ∞ - π/2`.
   **Lean carrier:** `conic_angle_matches_position`,
   `outgoing_conic_angle_limit`,
   `asymptotic_relative_velocity_limit`,
   `outgoing_velocity_is_radial`,
   `fig1b_counterclockwise_orientation`, and the theorem
   `fig1b_signed_deflection_from_polar_angle`.
   **Evidence:** the normalized separation vector and normalized nonzero
   asymptotic velocity have the same limit; Mathlib's
   `Orientation.oangle` then carries the signed geometry.
   **Status:** covered; proof body intentionally deferred by `sorry`.

8. **Source claim:** the result is `16.60°` below the initial line.
   **Lean carrier:** `asymptotic_relative_velocity_angle`.
   **Evidence:** bridges 6--7 give the exact analytic angle; the theorem also
   requires it to be negative and places its degree readout within `0.005°`
   of `-83/5 = -16.60`, which is a rounding statement rather than a fabricated
   exact equality.
   **Status:** covered at theorem-contract level; proof body intentionally
   deferred by `sorry`.

## Abstraction sufficiency and countermodel audit

- `CoulombScatteringLaws` is the only locally introduced `Prop`-valued
  interface.  It exposes positivity inequalities; charge, constant, initial
  geometry, angular-momentum, energy, eccentricity, and conic equations;
  derivative/Newton equations; non-collision; angle ranges; and explicit
  topological limits.
- The interface is not an opaque regime flag.  `no_collision` and positivity
  remove zero-denominator models.  The angular-momentum/energy equations plus
  the constant definitions constrain the eccentricity.  The conic equation
  plus `r → +∞` constrains the limiting polar angle.
- The asymptotic velocity cannot be assigned an arbitrary direction while all
  assumptions remain true: its nonzero normalized direction is equated by a
  `Tendsto` statement to the normalized outgoing separation direction, which
  is tied to `conicAngle` by `Orientation.oangle`.
- The orientation cannot be freely reversed: the rightward-to-upward angle is
  fixed to `+π/2`.  The incoming/outgoing ambiguity cannot be freely reversed:
  time tends to `+∞`, separation tends to `+∞`, the outgoing angle lies in
  `(0,π)`, and the velocity is positively radially aligned.
- Therefore an arbitrary interpretation satisfying every law cannot change
  the specialized eccentricity, polar asymptote, or signed deflection while
  falsifying the final conclusion.  The remaining work is proof of the
  exposed equations and limits, not repair of an underdetermined contract.

## Uncertainty and branch coverage

- **Uncertainty:** genuinely not applicable.  The source provides no
  `value ± uncertainty`.  The `1/200` degree bound is explicitly a
  two-decimal rounding certificate for a transcendental value, not measurement
  uncertainty.
- **Charge branch:** covered by a positive magnitude and explicit `+e`/`-e`
  readout equations.
- **Screen orientation:** covered by the counterclockwise-positive
  `Orientation.oangle` equation.
- **Clockwise/below-line branch:** covered by the initial rightward/upward
  figure equations, initial conic angle `π`, outgoing range `(0,π)`, and
  radial outgoing limit.  Negativity remains a theorem conclusion.
- **Incoming/outgoing asymptotic branch:** covered by all limits being taken at
  `Filter.atTop`, with separation tending to `atTop` and nonzero relative
  velocity aligned with the outgoing radius.

## Declarations created and blueprint correspondence

All declarations are in namespace `IPhO2026_1_B_2`.

- Geometry and dimensions: `Plane`, `rightward`, `upward`,
  `actionDimension`, `energyDimension`, `coulombConstantDimension`, and
  `permittivityDimension`.
- Physical carriers and setup: `QuantityKind`, `QuantityModel`, and
  `ScatteringScenario`.
- Scalar/vector readout helpers: `particleMassReadout`,
  `chargeMagnitudeReadout`, `hbarReadout`,
  `vacuumPermittivityReadout`, `coulombConstantReadout`,
  `bohrRadiusReadout`, `initialSeparationReadout`,
  `totalAngularMomentumReadout`, `totalEnergyReadout`,
  `polarConicParameterReadout`, `separationVector`, `relativeVelocity`,
  `separationRadius`, `signedDeflectionRadians`, and `radiansToDegrees`.
- Constraining physics interface: `CoulombScatteringLaws`.
- Bridge theorems:
  `outgoing_polar_angle_of_hyperbolic_conic`,
  `eccentricity_at_mu_fifteen_halves`,
  `outgoing_polar_angle_at_mu_fifteen_halves`, and
  `fig1b_signed_deflection_from_polar_angle`.
- Main target:
  `IPhO2026_1_B_2.asymptotic_relative_velocity_angle`, corresponding to
  blueprint label `thm:physics:IPhO_2026_1_B_2:target`.

The chapter has no `\lean{...}` declaration annotation.  Under the local
prover rules the blueprint was not edited.  Marker sync/review should attach
`\lean{IPhO2026_1_B_2.asymptotic_relative_velocity_angle}` and manage
`\leanok`.

## LeanExplore queries/candidates actually used

All searches passed package filters `["Mathlib", "Physlib"]`.

- `EuclideanSpace real two-dimensional vectors angle orientation`,
  `Orientation.finTwo`, and `Orientation.oangle`
  - Used `EuclideanSpace`, `Orientation`, `Orientation.oangle`, and
    `Real.Angle.toReal`.
  - Inspected
    `Orientation.angle_eq_abs_oangle_toReal` as confirmation that the signed
    and ordinary angle APIs are compatible for nonzero vectors.
- `dimensionful SI unit mass charge length time energy angular momentum`
  - Used `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`,
    `Dimension.M𝓭`, and `Dimension.C𝓭`.
  - Inspected `Dimensionful` and `UnitChoices.SI`; the local carrier/readout
    interface was smaller for this fixed coherent-unit calculation while
    retaining explicit dimension indices.
- `Filter.Tendsto velocity tends to asymptotic velocity at infinity` and
  `Filter.Tendsto atTop`
  - Used `Filter.Tendsto`, `Filter.atTop`, and neighborhood limits.
- `Coulomb force two particles electrostatic potential` and
  `classical particle angular momentum central force Coulomb potential`
  - Inspected `Electromagnetism.EMSystem.coulombConstant`,
    `RigidBody.angularMomentum`,
    `ClassicalMechanics.FreeParticle`, and the hydrogen-potential candidate.
    None supplies this equal-mass classical two-point-charge orbit.
- `hyperbolic Kepler orbit eccentricity polar conic asymptotic velocity`
  - Inspected Mathlib's `polarCoord`; it is a coordinate chart, not a conic
    orbit or scattering theorem.

Source/module/docstring data were fetched for the candidates actually assessed:
`Orientation`, `Orientation.oangle`,
`Orientation.angle_eq_abs_oangle_toReal`, `EuclideanSpace`, `Dimension`,
`Dimensionful`, `Electromagnetism.EMSystem.coulombConstant`,
`Filter.atTop`, `Filter.tendsto_atTop`, and `polarCoord`.

## PhysLean/Mathlib names grounded

- Physlib: `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`,
  `Dimension.M𝓭`, and `Dimension.C𝓭`.
- Mathlib: `EuclideanSpace`, `Orientation`, `Orientation.oangle`,
  `Real.Angle.toReal`, `inner`, the norm notation, `HasDerivAt`,
  `Filter.Tendsto`, `Filter.atTop`, `nhds`, `Real.sqrt`, `Real.cos`,
  `Real.arccos`, and `Real.pi`.
- Near misses inspected but not used:
  `Dimensionful`, `UnitChoices.SI`,
  `Electromagnetism.EMSystem.coulombConstant`,
  `RigidBody.angularMomentum`, `ClassicalMechanics.FreeParticle`, and
  `polarCoord`.

## Local abstractions introduced

- `QuantityKind d` gives each primitive quantity an abstract physical carrier
  at a Physlib dimension plus an explicit scalar readout.  This avoids
  identifying charge, mass, length, action, or energy with `ℝ`.
- `QuantityModel` gathers precisely the seven kinds used by the source.
- `ScatteringScenario` retains the labeled particle charges, shared mass,
  constants, trajectories, conic quantities, screen orientation, and
  asymptotic relative velocity.
- `CoulombScatteringLaws` is the smallest local replacement for the missing
  two-body Coulomb-scattering API.  It uses reusable equations, inequalities,
  derivatives, and limits rather than opaque predicates.
- `outgoing_polar_angle_of_hyperbolic_conic` isolates the reusable analytic
  elimination step supplied by the polar-conic hint.

## Grounding gaps

- No matching Mathlib/Physlib API was found for an equal-mass,
  oppositely-charged classical two-body Coulomb hyperbola, its eccentricity
  law, or its outgoing asymptote theorem.
- Physlib's `RigidBody.angularMomentum` concerns continuum rigid bodies, not
  either point particle here.
- `Electromagnetism.EMSystem.coulombConstant` has the correct scalar formula
  but does not by itself preserve all dimensional roles of this model.
- Mathlib's `polarCoord` supplies a coordinate chart only; it does not state
  the physical conic equation or branch limit.
- Blueprint redraft request: attach
  `\lean{IPhO2026_1_B_2.asymptotic_relative_velocity_angle}` to
  `thm:physics:IPhO_2026_1_B_2:target`.  No physics-statement redraft is
  otherwise needed.

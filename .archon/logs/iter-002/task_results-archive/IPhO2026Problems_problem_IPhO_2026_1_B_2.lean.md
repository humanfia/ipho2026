# Autoformalization result: IPhO 2026 Problem 1 B.2

## Assumption/target split

### Governing laws

- `ConstantRelations` records the two printed constant identities
  `a₀ = 4 π ε₀ ℏ² / (m e²)` and `k = 1 / (4 π ε₀)`.
- `CoulombDynamics.positionDerivative` identifies each dimensionful velocity
  field as the derivative of its position field.
- `CoulombDynamics.newtonCoulomb` states Newton's second law for both particles
  with the equal-and-opposite Coulomb force. This simultaneously encodes the
  classical model, the electrostatic-only interaction, and isolation from
  external force.
- `CoulombDynamics.nonrelativistic` bounds both particle speeds by the
  dimensionful speed of light.
- `ConicOrbitLaws.eccentricityFormula` is the official hint
  `ε = sqrt (1 + 4 L² E / (k² e⁴ m))`.
- `ConicOrbitLaws.polarAngleDefinition` gives the polar angle its oriented
  geometric meaning, and `polarConicEquation` is the supplied
  `r = a / (1 - ε cos θ)` law.
- `IsUnbound motion` formalizes the stated unbound regime as separation tending
  to infinity at late times.
- `uInfinity_isAsymptoticRelativeVelocity` gives the parameter `uInfinity` its
  source-defined role as the limit of the positron velocity relative to the
  electron. It does not constrain the limit's direction.

### Previous-part results

- The source report lists no previous parts, and the blueprint provides none.
  No previous Lean output is imported or assumed.

### Figure/data readouts

- `ParticleLabel` retains the labels `e⁺` (positron) and `e⁻` (electron).
- `PhysicalConstants` contains the common mass `m`, elementary charge
  magnitude `e`, `ℏ`, `ε₀`, `a₀`, `k`, and the speed of light, all as
  dimensionful Physlib quantities with positive SI readouts.
- `Figure1bFrame` records the rightward initial positron direction, the upward
  electron-to-positron separation direction, and their positive oriented
  quarter-turn.
- `Figure1bInitialConditions` records equal masses, charges `+e` and `-e`, the
  center-of-mass midpoint, vertical separation `100 a₀`, equal and opposite
  transverse velocities, individual angular-momentum magnitudes `μ ℏ`, and
  the current datum `μ = 15/2`.
- `ConicOrbitData` retains the total energy `E`, total angular-momentum
  magnitude `L`, eccentricity, the printed conic length `a`, periapsis axis,
  and polar-angle function. Its laws tie `E` and `L` to the initial state.

### Current target conclusions

- The signed oriented angle from the initial positron velocity to `uInfinity`
  is negative, so the outgoing relative velocity lies below the initial line.
- That signed angle in degrees rounds to `-83/5 = -16.60` at the nearest
  hundredth; `RoundsToNearestHundredth` uses the correct half-unit tolerance
  `0.005°`.

## Goal-faithfulness audit

The value `-83/5`, the negative-direction assertion, and the rounding claim
occur only in the conclusion of
`IPhO2026Problems.IPhO2026_1_B_2.IPhO_2026_1_B_2`. They do not occur in
`PhysicalConstants`, `Figure1bInitialConditions`, `CoulombDynamics`,
`ConicOrbitData`, `ConicOrbitLaws`, `IsUnbound`, or the hypothesis defining
`uInfinity`.

`signedDeflectionDegrees` only converts Mathlib's oriented angle to a degree
readout, and `RoundsToNearestHundredth` is a generic rounding predicate; neither
contains the requested answer. The eccentricity and polar-conic formulas are
the general laws printed as hints, not a rearranged version of the final
deflection. Thus unfolding a helper or projecting a premise cannot prove the
current numerical target.

The statement uses `0.005°` tolerance rather than false exact equality to a
rounded decimal. It nevertheless explicitly concludes the official report
`-16.60°` and its “below the initial line” sign convention.

## Declarations created and blueprint correspondence

- Dimensional foundations:
  `Plane`, `velocityDimension`, `angularMomentumDimension`,
  `permittivityDimension`, `coulombConstantDimension`, `DimLength`, `DimMass`,
  `DimCharge`, `DimPosition`, `DimVelocityVector`, `DimSpeed`,
  `DimAngularMomentum`, `DimPermittivity`, `DimCoulombConstant`, `scalarSI`,
  and `vectorSI`.
- Particle and figure model:
  `ParticleLabel`, `PhysicalConstants`, `ConstantRelations`, `PairMotion`,
  `positionSI`, `velocitySI`, `particleMassSI`, `particleChargeSI`,
  `relativeDisplacementSI`, `relativeVelocitySI`, `separationSI`,
  `Figure1bFrame`, `signedAngularMomentumSI`,
  `totalAngularMomentumMagnitudeSI`, and `Figure1bInitialConditions`.
- Physics and conic model:
  `coulombForceOnPositronSI`, `CoulombDynamics`, `initialTotalEnergySI`,
  `ConicOrbitData`, `ConicOrbitLaws`, and `IsUnbound`.
- Target helpers:
  `signedDeflectionDegrees` and `RoundsToNearestHundredth`.
- `IPhO2026Problems.IPhO2026_1_B_2.IPhO_2026_1_B_2` corresponds to blueprint
  label `thm:physics:IPhO_2026_1_B_2:target`.

The target theorem is formalized with the required `by sorry` body and is ready
for deterministic statement `\leanok` synchronization. The blueprint was not
edited because prover permissions make it read-only.

## LeanExplore queries/candidates actually used

All searches passed `packages: ["Mathlib", "Physlib"]`.

- `Euclidean angle between two vectors in real inner product space` found
  `InnerProductGeometry.angle`; its source/module/docstring were fetched. It
  was assessed as an unsigned near miss for a signed “below” answer.
- `Orientation.oangle` and
  `oriented angle between vectors Orientation.oangle` found
  `Orientation.oangle`; source/module/docstring were fetched and the
  declaration is used for the signed angle.
- `Real.Angle degrees` and `Real.Angle coe real radians` found `Real.Angle`,
  `Real.Angle.coe`, and `Real.Angle.toReal`; their details were fetched and
  used to obtain the canonical signed radian representative before converting
  to degrees.
- `EuclideanSpace real two-dimensional vectors` and
  `norm EuclideanSpace vector` found `EuclideanSpace` and its norm/finrank
  infrastructure. `EuclideanSpace` source/module/docstring were fetched and
  the two-dimensional specialization is used as `Plane`.
- `physical dimensions SI units mass length velocity energy electric charge
  angular momentum`, `WithDim`, and
  `quantity with physical dimension length mass speed velocity energy` found
  `Dimension`, `Dimension.L𝓭`, `Dimension.C𝓭`, `UnitChoices.SI`,
  `WithDim`, `Dimensionful`, and `DimEnergy`. Source/module/docstring data were
  fetched for those candidates and they ground every primitive physical type.
- `Coulomb electrostatic force two particles classical mechanics scattering
  conic orbit` found `Electromagnetism.EMSystem.coulombConstant`,
  `ChargeUnit.coulombs`, and `ChargeUnit.elementaryCharge`. Their details were
  fetched; they are unit/scalar APIs rather than a dimensionful two-body
  dynamics API, so the compatible dimensional framework is used locally.
- `HasDerivAt vector-valued function real variable` found `HasDerivAt`;
  source/module/docstring were fetched and it is used for position and velocity
  derivatives.
- `Filter.Tendsto atTop nhds limit` found `Filter.tendsto_atTop`; details were
  fetched and `Tendsto`, `atTop`, and `𝓝` are used for unbound motion and
  `uInfinity`.
- `Orientation.areaForm` found `Orientation.areaForm`; source/module/docstring
  were fetched and it is used to define the two-dimensional angular momentum.

## PhysLean/Mathlib names grounded

- Physlib: `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`, `Dimension.M𝓭`,
  `Dimension.C𝓭`, `Dimensionful`, `WithDim`, `UnitChoices.SI`, and
  `DimEnergy`.
- Mathlib: `EuclideanSpace`, `Orientation`, `Orientation.areaForm`,
  `Orientation.oangle`, `Real.Angle`, `Real.Angle.toReal`, `HasDerivAt`,
  `Filter.Tendsto`, `Filter.atTop`, `Filter.nhds`, `Real.sqrt`, `Real.cos`,
  and `Real.pi`.
- A local instance of `Fact (Module.finrank ℝ Plane = 2)` is proved by
  `simp [Plane]`; this is the standard dimension fact required by Mathlib's
  oriented-angle API.

## Local abstractions introduced

- Physlib dimensions are combined into the missing velocity,
  angular-momentum, permittivity, and Coulomb-constant dimensions. The
  resulting quantities remain unit-independent
  `Dimensionful (WithDim ... ...)` objects, not scalar aliases.
- `PairMotion` is the smallest trajectory object retaining particle labels,
  dimensionful masses/charges, positions, and velocities.
- `CoulombDynamics` supplies the missing two-body API as explicit derivative
  and Newton-force laws. It preserves the exact attraction, isolation,
  classical dynamics, and non-relativistic regime rather than replacing them
  by an opaque flag.
- `Figure1bFrame` and `Figure1bInitialConditions` preserve the source-page
  orientation and labels needed to interpret “below” as a signed angle.
- `ConicOrbitData`/`ConicOrbitLaws` preserve both official hints and connect
  their `E` and `L` to the initial state without assuming an asymptotic angle.
- `RoundsToNearestHundredth` makes the numerical-reporting semantics explicit;
  it is generic and does not encode `-16.60`.

## Grounding gaps and redraft requests

- No Mathlib/Physlib declaration matching an attractive two-point-charge
  scattering trajectory or its hyperbolic conic law was found.
  `Electromagnetism.EMSystem.coulombConstant` is a bare scalar attached to an
  older electromagnetic-system API, while this statement needs a
  unit-independent dimensionful constant and Newtonian particle trajectories.
- Physlib supplies `DimEnergy` and the general unit framework, but no complete
  packaged dimensionful planar position/velocity or angular-momentum type for
  this problem; those types are assembled from genuine Physlib dimensions.
- Mathlib has an oriented angle in radians modulo `2π`, but no retrieved
  physical degree-quantity API. The degree value is therefore an explicitly
  labeled scalar readout derived from `Real.Angle.toReal`.
- The read-only DAG command was unavailable in this environment
  (`archon: command not found`), so no ancestor declarations could be queried.
  The source report independently states that there are no previous parts.
- The blueprint theorem environment currently has no `\lean{...}` declaration
  name. The plan/review layer should attach
  `\lean{IPhO2026Problems.IPhO2026_1_B_2.IPhO_2026_1_B_2}` so deterministic
  synchronization can associate the target.

## Verification

- `mcp__archon_lean_lsp__lean_diagnostic_messages`: success, no errors, and
  exactly one expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`: exit code
  `0`, with exactly the same expected `sorry` warning.
- The assigned Lean file did not exist at lane start, so there was no
  file-specific `/- USER: ... -/` comment to preserve.

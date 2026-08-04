# Autoformalization result

## Assumption/target split

### Governing laws

- `HydrostaticGateLaws.hydrostaticPressureDifference` states the hydrostatic
  pressure jump `Δp = ρ₀ g Δh`.
- `pressureResultant` states that the horizontal resultant equals the pressure
  jump times the rectangular slot area.
- `effectiveWeight` states the fully submerged cube's gravity-minus-buoyancy
  force `(ρcube - ρ₀) g a³`.
- `pressureMomentAboutO` and `effectiveWeightMomentAboutO` form the two torques
  from their respective forces and Figure 1a lever arms.
- `limitingMomentBalance` states equality of those torques at incipient
  rotation about the frictionless hinge `O`.

### Previous-part results

- None. The source report lists no previous parts for A.1.

### Figure/data readouts

- `GateConfiguration` retains wall endpoints `M` and `N`, hinge label `O`,
  vertical wall orientation, water in both reservoirs, a fully submerged
  block, a frictionless hinge, an axis perpendicular to the figure, and the
  left reservoir's water source.
- `Figure1aGeometry` retains the cube side, slot vertical size,
  hinge-to-slot-edge distance, slot area, cube volume, pressure lever arm, and
  effective-weight lever arm, all as dimension-tagged SI readouts.
- `MatchesFigure1a` records `slot height = a √2 / 2`, the shown edge distance
  `a/2`, slot area `a × slot height`, cube volume `a³`, the slot-centre
  pressure arm, and the cube-centre effective-weight arm `a/(2√2)`.
- `MatchesProblemSetup` records positive `a`, `ρ₀`, and `g`, cube density
  `3ρ₀`, and the supplied maximum level difference `Δh = 141/100 m`.
- `HydrostaticGateState` retains density, gravity, level difference, pressure,
  force, effective weight, and both torque readouts with their dimensions.

### Current target conclusions

- The cube side is the dimensionally typed SI length
  `Δh / (2 * Real.sqrt 2)`.
- For the supplied `1.41 m` readout, that length rounds to `50 cm`, i.e.
  `0.50 m`, under the generic nearest-centimetre predicate.

## Goal-faithfulness audit

The exact side-length formula and the `0.50 m` rounding conclusion occur only
in `sideLength_at_maximumLevelDifference`. They do not occur in
`GateConfiguration`, `Figure1aGeometry`, `HydrostaticGateState`,
`MatchesProblemSetup`, `MatchesFigure1a`, or `HydrostaticGateLaws`.

The figure predicate contains only independently read geometry, while the laws
predicate contains hydrostatics, buoyancy-reduced weight, force moments, and
the physical threshold condition. `RoundsToNearestCentimeterSI` is generic in
both the length and the requested integer centimetre count, so unfolding it
does not make the theorem true. No target equality was smuggled into a premise
field, law field, or local definition.

## Declarations created and blueprint correspondence

- `LengthSI`, `AreaSI`, `VolumeSI`, `MassDensitySI`, `AccelerationSI`,
  `PressureSI`, `ForceSI`, and `TorqueSI`: Physlib dimension-tagged SI
  readouts.
- `FigurePointLabel`, `WallOrientation`, `SubmersionStatus`, `HingeFriction`,
  `AxisOrientation`, and `ReservoirFluid`: qualitative source/figure labels.
- `GateConfiguration`, `Figure1aGeometry`, and `HydrostaticGateState`:
  apparatus, geometry, and physical-state data.
- `MatchesProblemSetup`, `MatchesFigure1a`, and `HydrostaticGateLaws`:
  supplied data, figure geometry, and governing laws, respectively.
- `RoundsToNearestCentimeterSI`: answer-independent decimal rounding.
- `IPhO2026Problems.IPhO2026_1_A_1.sideLength_at_maximumLevelDifference`
  corresponds to
  `thm:physics:IPhO_2026_1_A_1:target`.

The theorem has the required `by sorry` body and is ready for statement-level
`\leanok` once marker sync can associate the declaration.

## LeanExplore queries/candidates actually used

Every query used package filters `["Mathlib", "Physlib"]`.

- `physical dimension quantity length SI units density pressure force torque`
  found `UnitChoices.SI`, `Dimension`, `HasDimension`,
  `Dimension.L𝓭`, and `DimPressure`.
- `Physlib hydrostatic pressure water fluid density gravitational
  acceleration` found `FluidDynamics.MassDensity`,
  `FluidDynamics.FluidState`, and `DimPressure`.
- `Physlib torque moment of force rigid body rotation hinge equilibrium`
  found the `RigidBody` rotational interfaces but no hydrostatic hinge-moment
  model matching this problem.
- `DimLength meter dimensional length quantity`,
  `DimMassDensity dimensional mass density kilogram per cubic meter`,
  `DimForce newton dimensional force quantity`, and
  `DimTorque moment of force dimensional torque` checked likely packaged
  names. No matching fixed-SI generic aliases were found.
- `WithDim` found `WithDim` and `WithDim.ext`. Source, module, and docstring
  were fetched for `WithDim`.
- Source/module/docstring data were also fetched for `Dimension`,
  `HasDimension`, `UnitChoices.SI`, `UnitChoices.SI_length`,
  `FluidDynamics.MassDensity`, `FluidDynamics.FluidState`, and `DimPressure`.
- Source/module data for `Dimensionful`,
  `UnitExamples.NewtonsSecondWithDim`,
  `UnitExamples.NewtonsSecondWithDim'`, `DimEnergy`, and `Dimension.L𝓭`
  grounded how Physlib combines scalar values with physical dimensions.

## PhysLean/Mathlib names grounded

- PhysLean/Physlib: `WithDim`, `Dimension`, `Dimension.L𝓭`,
  `Dimension.M𝓭`, `Dimension.T𝓭`, `Dimensionful`, `HasDimension`,
  `UnitChoices.SI`, `DimPressure`, `DimEnergy`,
  `FluidDynamics.MassDensity`, and `FluidDynamics.FluidState`.
- Mathlib: `ℝ`, `Real.sqrt`, integer-to-real coercion, absolute value, and
  ordinary real arithmetic.
- LSP syntax verification explicitly checked `WithDim`, `L𝓭`, `M𝓭`, `T𝓭`,
  `Real.sqrt`, `WithDim.val`, and every dimensional alias used in the file.

## Local abstractions introduced

- The eight `...SI` aliases use Physlib's `WithDim` and genuine dimensions,
  rather than transparent aliases to `ℝ`. Their names and docstrings state the
  corresponding SI units.
- Uniform water and cube densities are fixed SI scalar readouts rather than
  `FluidDynamics.MassDensity` fields because the problem uses constant
  densities, not spatially varying fluid fields.
- The qualitative enums preserve the source's apparatus claims without
  pretending that Mathlib/Physlib has a geometry API for this exact diagram.
- `MatchesFigure1a` is a narrow local abstraction for the official figure's
  metric data. `HydrostaticGateLaws` is a narrow local abstraction for the
  missing hydrostatic pressure/resultant/hinge-torque interface.

## Grounding gaps and redraft requests

- No packaged Physlib hydrostatic pressure-at-depth/resultant-force model or
  frictionless hinged-gate torque model matching Figure 1a was found.
- `FluidDynamics.MassDensity` is a spatial scalar field and thus a near miss
  for the problem's constant density readout. `DimPressure` is a
  unit-independent `Dimensionful` quantity and was not mixed with the
  problem's uniformly fixed-SI `WithDim` readouts.
- No packaged `DimLength`, constant dimensional mass-density, `DimForce`, or
  `DimTorque` alias matching this fixed-SI model was found.
- The chapter has no `\lean{...}` name. The plan/review layer should attach
  `\lean{IPhO2026Problems.IPhO2026_1_A_1.sideLength_at_maximumLevelDifference}`
  so deterministic marker sync can associate the theorem.
- The advertised `archon` DAG command was unavailable on `PATH`
  (`archon: command not found`).
- The root `lean_lib` is named/prefixed `IPhO2026Run`, so Lake does not
  recognize the prescribed `IPhO2026Problems...` module as a build target.
  This configuration is outside this prover's write permissions.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`: exit code 0
  with exactly the expected `sorry` warning.
- `lake build IPhO2026Problems.problem_IPhO_2026_1_A_1` and the explicit
  source-path/module variants fail before invoking Lean because the module is
  not registered under the root `IPhO2026Run` library target.

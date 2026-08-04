# Autoformalization result: IPhO 2026 problem 1 A.1

The assigned file was created and checked with both the Archon Lean LSP and
`lake env lean IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`. It compiles
with exactly six expected `declaration uses sorry` warnings and no errors.
The chapter contains `% archon:physics`, so the physics-formalize discipline
was used. The assigned file did not previously exist, so it contained no
`/- USER: ... -/` comment.

## Assumption/target split

### Governing laws

- `MatchesFigure1a` records the cube volume, slot width and vertical size,
  opening area, and the pressure/effective-weight lever arms about hinge `O`.
- `ObeysHydrostaticLaws` records the level-difference relation, positive water
  density and gravitational acceleration, full submersion, hydrostatic
  pressure difference `Δp = ρ₀ g Δh`, resultant force `ΔF = Δp A`, weight,
  buoyancy, effective weight, and all relevant moment-arm equations.
- `AtMaximumPermissibleDifference` records the critical lower-contact force
  vanishing, the frictionless hinge's zero torque, the opposing torque
  orientations, and static torque balance.

### Previous-part results

- None. This is part A.1 and has no previous-part prerequisites. No sibling
  Lean module is imported.

### Figure/data readouts

- `FigurePoint` retains labels `M`, `N`, and `O`; `wallMN` and `hingePoint`
  identify the vertical wall and hinge axis from Figure 1a.
- `Figure1aGeometry` retains side length, cube volume, slot dimensions,
  effective opening area, and all lever arms as dimension-tagged quantities.
- `HydrostaticGate` retains the two reservoir levels, water-level difference,
  water and block densities, gravity, submerged volume, pressure difference,
  forces, torques, hinge reaction, contact force, and torque senses.
- `MatchesProblemData.blockDensity_eq` records the given `ρ = 3ρ₀`.
- `MatchesProblemData.maximumLevelDifference_eq` records the given
  `Δh = 1.41 m`.

### Current target conclusions

- The exact critical side-length readout
  `a = Δh / (2 * Real.sqrt 2)`.
- For `Δh = 1.41 m`, the exact value is within `0.005 m` of `0.50 m`, which
  faithfully expresses the source's two-decimal numerical report without
  asserting the false exact equality `1.41 / (2√2) = 0.50`.

Both conclusions occur only on theorem/lemma conclusion sides.

## Goal-faithfulness audit

- Neither the requested side-length formula nor the reported numerical value
  is a field of `MatchesFigure1a`, `ObeysHydrostaticLaws`,
  `AtMaximumPermissibleDifference`, `MatchesProblemData`, or any data
  structure.
- The given facts `ρ = 3ρ₀` and `Δh = 1.41 m` are source data, not the answer.
- The figure predicate contains only independent geometric facts. Its equal
  lever-arm equations do not state a force balance or a value of `a`.
- The hydrostatic predicate contains governing laws only. Its pressure,
  buoyancy, weight, and torque equations do not contain the target solved
  formula.
- The critical predicate supplies zero contact/hinge torques and equilibrium,
  not a pre-solved side length.
- `side_length_from_hydrostatic_balance`,
  `side_length_for_triple_density`,
  `stated_value_rounds_to_half_meter`, and the main theorem are genuine
  proof obligations with `by sorry` bodies. The target appearing as an
  intermediate lemma conclusion is permitted and is not usable without
  proving that lemma.
- No helper definition unfolds to the requested answer. Definitions only name
  dimensions, figure labels, and physical data.
- Countermodel sanity check: if the force or torque laws are dropped, `a` can
  vary freely. With all premises, positivity permits cancellation of `g`,
  `ρ₀`, the common nonzero lever arm, and the positive powers of `a`.
  Hydrostatic pressure versus effective weight then forces
  `a = ρ₀ Δh / (√2 (ρ - ρ₀))`; `ρ = 3ρ₀` forces the requested formula.
  Thus the full contract is not underdetermined.

## Derivability and bridge obligations

1. **Physical dimensions — covered (grounded).**
   Source claim: lengths, areas, volumes, densities, acceleration, pressure,
   force, and torque have distinct dimensional roles. Carrier: Physlib
   `Dimension`, `Dimension.L𝓭`, `Dimension.M𝓭`, `Dimension.T𝓭`, and
   `WithDim`, plus local compositions `areaDimension`, `volumeDimension`,
   `massDensityDimension`, `accelerationDimension`, `pressureDimension`,
   `forceDimension`, and `torqueDimension`. Evidence: the definitions and
   signatures were inspected through LeanExplore and the installed Physlib
   source.

2. **Figure labels and hinge axis — covered (encoded locally).**
   Source claim: wall `MN` is vertical and the frictionless axis passes
   through `O`, perpendicular to the figure. Carrier: `FigurePoint`,
   `wallMN`, `hingePoint`, the zero-hinge-torque field of
   `AtMaximumPermissibleDifference`, and the scalar moment arms read normal to
   the planar axis. The official Figure 1a image was inspected directly.

3. **Slot and opening geometry — covered (encoded locally).**
   Source claim: the slot width is `a`, its vertical size is `a√2/2`, and its
   effective area is their product. Carrier:
   `MatchesFigure1a.slotWidth_eq`, `slotVerticalSize_eq`, and
   `openingArea_eq`. The derived simplification to `a²/√2` is the conclusion
   of `opening_area_readout`, not an assumption.

4. **Full-submersion buoyancy — covered (encoded locally).**
   Source claim: the displaced volume equals the entire cube volume and the
   buoyant force is `ρ₀ g a³`. Carrier:
   `ObeysHydrostaticLaws.fullSubmersion`, `buoyancyForce_eq`, and
   `MatchesFigure1a.cubeVolume_eq`.

5. **Weight and effective weight — covered (encoded locally).**
   Source claim: weight is `ρ g a³`, while the net downward load relevant for
   torque is weight minus buoyancy. Carrier:
   `ObeysHydrostaticLaws.weightForce_eq` and
   `effectiveWeightForce_eq`.

6. **Hydrostatic pressure resultant — covered (encoded locally).**
   Source claim: `Δp = ρ₀ g Δh` and the horizontal resultant is
   `ΔF = Δp A`. Carrier:
   `ObeysHydrostaticLaws.pressureDifference_eq` and `pressureForce_eq`.
   This separation matches the official marking-scheme steps.

7. **Figure lever arms and torque laws — covered (encoded locally).**
   Source claim: both relevant lever arms about `O` are `a/(2√2)`, and torque
   magnitude is force times perpendicular arm. Carrier:
   `MatchesFigure1a.pressureLeverArm_eq`,
   `effectiveWeightLeverArm_eq`, and the three torque equations in
   `ObeysHydrostaticLaws`.

8. **Critical branch and torque reduction — covered (encoded locally).**
   Source claim: at maximum permissible `Δh`, the lower edge contact force
   vanishes; hinge torque is zero; pressure and effective-weight torques
   oppose and balance. Carrier: all fields of
   `AtMaximumPermissibleDifference`, with the reusable elimination conclusion
   `critical_torque_balance`.

9. **Solving the general balance for `a` — covered (local bridge theorem).**
   Carrier: `side_length_from_hydrostatic_balance`. The positivity fields in
   `MatchesFigure1a` and `ObeysHydrostaticLaws` supply all nonzero conditions
   needed for cancellation. Its body is intentionally `sorry` at this stage.

10. **Substitution of `ρ = 3ρ₀` — covered (local bridge theorem).**
    Carrier: `side_length_for_triple_density`, which consumes only the
    independent figure, physical-law, criticality, and density premises and
    concludes `a = Δh/(2√2)`.

11. **Two-decimal numerical report — covered (local mathematical bridge).**
    Carrier: `stated_value_rounds_to_half_meter`, which proves the strict
    half-unit-in-the-last-place bound
    `|1.41/(2√2) - 0.50| < 0.005`. Mathlib's `Real.sqrt` is the grounded
    square-root carrier.

12. **Complete source-to-contract mapping — covered.**
    Carrier: `IPhO2026Problems.problem_IPhO_2026_1_A_1`, whose assumptions
    are exactly the figure geometry, governing laws, critical configuration,
    and printed data, and whose conclusion contains the exact and rounded
    requested answers.

No substantive source-to-Lean bridge remains absent from the statement layer.

## Abstraction sufficiency and countermodel audit

- `MatchesFigure1a` is a local `Prop`-valued interface. It exposes positivity
  and explicit equations for volume, slot dimensions, area, and both
  physically relevant lever arms. It has no opaque witness-only field.
- `ObeysHydrostaticLaws` is a local `Prop`-valued interface. It exposes the
  signed reservoir-level equation, positivity/order assumptions, the
  full-submersion equality, pressure equations, weight/buoyancy equations,
  effective-weight subtraction, and force-times-arm torque equations.
- `AtMaximumPermissibleDifference` is a local `Prop`-valued interface. It
  exposes exact clockwise/counterclockwise orientation equalities, zero-force
  and zero-torque equations, and the torque-balance equation.
- `MatchesProblemData` is a local `Prop`-valued interface consisting only of
  the two explicit source-data equations.
- `Figure1aGeometry` and `HydrostaticGate` are data-valued structures, not
  `Prop`-valued abstractions.
- Countermodel test by interface: arbitrary slot geometry is excluded by
  `MatchesFigure1a`; arbitrary forces are excluded by
  `ObeysHydrostaticLaws`; arbitrary limiting configurations are excluded by
  the zero-contact and balance equations; arbitrary density/level data are
  excluded by `MatchesProblemData`. Dropping any one of the pressure law,
  effective-weight law, lever-arm laws, or critical balance allows a false
  target model, but all are present. With all fields satisfied, the target is
  algebraically forced.

## Uncertainty and branch coverage

- **Experimental uncertainty: genuinely not applicable.** The source reports
  no `value ± uncertainty`, confidence interval, or measured error to
  propagate.
- **Decimal reporting/rounding: covered.** The source writes `1.41 m` and
  `0.50 m`; because the exact radicals are not equal to `0.50`, the contract
  retains the exact formula and separately proves the correct `0.005 m`
  two-decimal rounding bound. This bound is not treated as physical
  uncertainty.
- **Reservoir orientation: covered.**
  `ObeysHydrostaticLaws.leftLevel_higher` and `levelDifference_eq` fix the
  positive left-minus-right pressure difference shown in Figure 1a.
- **Torque orientation: covered.** Pressure torque is explicitly
  counterclockwise and effective-weight torque clockwise.
- **Critical contact branch: covered.** The lower edge of the opening is the
  contact whose force vanishes; this prevents silently choosing a different
  threshold branch only in the conclusion.
- **Hinge branch: covered.** The frictionless axis through `O` is represented
  by zero hinge torque about `O`; the reaction force remains present as a
  dimensioned planar vector.

## Declarations created and blueprint labels

All supporting declarations are under
`IPhO2026Problems.HydrostaticGateA1`.

- Dimension and label declarations:
  `areaDimension`, `volumeDimension`, `massDensityDimension`,
  `accelerationDimension`, `pressureDimension`, `forceDimension`,
  `torqueDimension`, `FigurePoint`, `wallMN`, `hingePoint`, and
  `TorqueSense`.
- Physical data and constraining interfaces:
  `Figure1aGeometry`, `MatchesFigure1a`, `HydrostaticGate`,
  `ObeysHydrostaticLaws`, `AtMaximumPermissibleDifference`, and
  `MatchesProblemData`.
- Bridge declarations:
  `opening_area_readout`, `critical_torque_balance`,
  `side_length_from_hydrostatic_balance`,
  `side_length_for_triple_density`, and
  `stated_value_rounds_to_half_meter`.
- Blueprint label `thm:physics:IPhO_2026_1_A_1:target` maps to the main
  declaration `IPhO2026Problems.problem_IPhO_2026_1_A_1`.
- The target environment is ready for a statement-level `\leanok`. Per local
  prover permissions, the blueprint was not edited; deterministic sync/review
  should attach
  `\lean{IPhO2026Problems.problem_IPhO_2026_1_A_1}` and manage the marker.

## LeanExplore queries/candidates actually used

- Query `physical dimensions quantities units length mass density force torque
  pressure hydrostatic fluid mechanics`:
  inspected candidates `Dimension`, `DimPressure`,
  `FluidDynamics.FluidState`, and
  `FluidDynamics.NavierStokes.MomentumEquation`.
- Query `Dimensionful Quantity physical quantity with units SI length density
  force pressure torque`:
  used `Dimensionful`, `WithDim`, `UnitChoices.SI`, and
  `Dimension.L𝓭` to choose the unit/dimension representation.
- Query `DimLength DimMass DimTime DimForce DimDensity DimTorque dimensional
  quantities` and likely-name query `DimLength meter dimensional length type`:
  confirmed `Dimension.L𝓭` and `WithDim`; no complete family of ready-made
  named scalar types for this model was returned.
- Query `WithDim dimension-tagged physical quantities definition SI value
  length meter density force moment torque`:
  used `WithDim` and inspected its actual source/module.
- Query `Real.sqrt square root nonnegative square two`:
  used `Real.sqrt` from `Mathlib.Analysis.Real.Sqrt`; inspected
  `Real.sqrt_nonneg` as a later proof carrier.
- Query `FluidDynamics hydrostatic pressure force buoyancy Archimedes torque
  equilibrium`:
  inspected `DimPressure`, `FluidDynamics.MassDensity`,
  `FluidDynamics.BodyForce`, and `RigidBody.euler_equations`.
  `FluidDynamics.MassDensity` is a spatial scalar field rather than this
  problem's homogeneous dimensioned reservoir readout.

All LeanExplore calls used package filters `["Mathlib", "Physlib"]`.

## PhysLean/Mathlib names grounded

- Physlib: `Dimension`, `Dimension.L𝓭`, `Dimension.M𝓭`,
  `Dimension.T𝓭`, `WithDim`, `Dimensionful`, `UnitChoices.SI`,
  `DimPressure`, `FluidDynamics.MassDensity`, and
  `FluidDynamics.BodyForce`.
- Mathlib: `Real.sqrt` and `Real.sqrt_nonneg`.
- Names used directly in the file are `Dimension`, its three base dimensions,
  `WithDim`, and `Real.sqrt`. `DimPressure` was inspected but not selected:
  it is a unit-covariant `Dimensionful` quantity, while every apparatus
  equation here consistently uses a fixed coherent SI `WithDim` readout. Its
  exact underlying dimension is retained by `pressureDimension`.

## Local abstractions introduced

- The seven local dimension definitions compose Physlib base dimensions; they
  are not scalar aliases. They retain the standard dimensional roles needed
  for the apparatus quantities.
- `FigurePoint` and `TorqueSense` retain labelled geometry and signed
  orientation information that a bare real number would lose.
- `Figure1aGeometry` is the smallest dimensioned data object retaining all
  figure-derived quantities used in the official solution.
- `HydrostaticGate` retains separate reservoirs, densities, gravity,
  submersion, pressure, all marked forces, hinge reaction, contact force, and
  torques.
- The four proposition-valued interfaces expose only concrete equations,
  inequalities, and orientation equalities. They replace absent
  hydrostatic-gate APIs without weakening the physical model.

## Grounding gaps

- No Mathlib/Physlib declaration was found for a hinged hydrostatic gate,
  Archimedean buoyancy plus hydrostatic resultant force on this slot, or the
  critical vanishing-contact torque condition. The local law interfaces expose
  all equations needed by a later proof.
- Physlib's fluid-dynamics APIs describe continuum fields and Navier–Stokes
  momentum balance, not this rigid, homogeneous, static gate calculation.
- The `archon dag-query` executable was unavailable on this lane's `PATH`.
  This target has no previous-part dependencies, so no sibling declaration was
  imported or re-derived through the dependency graph.

## Redraft requests

- Add
  `\lean{IPhO2026Problems.problem_IPhO_2026_1_A_1}` to the blueprint target
  environment so deterministic marker synchronization can associate the
  compiling declaration with
  `thm:physics:IPhO_2026_1_A_1:target`.
- No physics-contract redraft is otherwise needed.

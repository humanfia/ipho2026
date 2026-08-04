# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:1250c692863aea6b56a6ed152e077d339c8e861da0d2244e97eb61ceb0577c74
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Declaration ApparatusLabel`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `HahnSeries.leadingCoeff` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | A leading coefficient of a Hahn series is the coefficient of a lowest-order nonzero term, or zero if the series vanishes.
- `MonadCont.Label` | module `Mathlib.Control.Monad.Cont` | package Mathlib | **Continuation Label.** A continuation label is a structure that encapsulates a function mapping values of type $\alpha$ to computations in a monad $m$ that produce values of type $\beta$.

### Query: `Declaration Figure17Geometry`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `EuclideanGeometry.Sphere.two_zsmul_oangle_eq` | module `Mathlib.Geometry.Euclidean.Angle.Sphere` | package Mathlib | Oriented angle version of "angles in same segment are equal" and "opposite angles of a cyclic quadrilateral add to π", for oriented angles mod π (for which those are the same result), represented here as equality of t...
- `EuclideanGeometry.Sphere.angle_eq_pi_div_two_iff_mem_sphere_ofDiameter` | module `Mathlib.Geometry.Euclidean.Angle.Sphere` | package Mathlib | **Thales' theorem**: For three distinct points, the angle at the second point is a right angle if and only if the second point lies on the sphere having the first and third points as diameter endpoints.

### Query: `Declaration IsochoricApparatus`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `Mathlib.Tactic.Coherence.coherence_loop` | module `Mathlib.Tactic.CategoryTheory.Coherence` | package Mathlib | **Alias** of `Mathlib.Tactic.Coherence.coherenceLoop`. --- The main part of `coherence` tactic.
- `Lean.Name.hasPos` | module `Physlib.Meta.Basic` | package PhysLean | Determines if a name has a location.

### Query: `Declaration IsPreparedIsochoricApparatus`
- `Lean.toPreDefinition` | module `Mathlib.Tactic.Core` | package Mathlib | Make a PreDefinition taking some metadata from declaration `nm`. You can provide a new type, value and (optional) docstring, but the remaining information is taken from `nm`. Currently only implemented for definitions...
- `IsAntichain` | module `Mathlib.Order.Antichain` | package Mathlib | An antichain is a set such that no two distinct elements are related.
- `Mathlib.Tactic.Coherence.coherence_loop` | module `Mathlib.Tactic.CategoryTheory.Coherence` | package Mathlib | **Alias** of `Mathlib.Tactic.Coherence.coherenceLoop`. --- The main part of `coherence` tactic.

### Query: `Declaration pressureInPascals`
- `DimPressure.pascal` | module `Physlib.Units.WithDim.Pressure` | package PhysLean | The dimensional pressure corresponding to 1 pascal, Pa.
- `JoinedIn` | module `Mathlib.Topology.Connected.PathConnected` | package Mathlib | The relation "being joined by a path in `F`". Not quite an equivalence relation since it's not reflexive for points that do not belong to `F`.
- `NVEHamiltonian.pressure` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.ThermoQuantities` | package PhysLean | Pressure, as a function of T. Defined as the conjugate variable to volume.

### Query: `Declaration temperatureInKelvin`
- `TemperatureUnit.kelvin` | module `Physlib.Thermodynamics.Temperature.TemperatureUnits` | package PhysLean | The definition of a temperature unit of kelvin.
- `JoinedIn` | module `Mathlib.Topology.Connected.PathConnected` | package Mathlib | The relation "being joined by a path in `F`". Not quite an equivalence relation since it's not reflexive for points that do not belong to `F`.
- `UnitChoices.SI_temperature` | module `Physlib.Units.Basic` | package PhysLean | **SI Temperature Unit.** In the International System of Units (SI), the designated unit for temperature is the kelvin.

### Query: `Declaration IsochoricHeatingRun`
- `Mathlib.Tactic.Coherence.coherence_loop` | module `Mathlib.Tactic.CategoryTheory.Coherence` | package Mathlib | **Alias** of `Mathlib.Tactic.Coherence.coherenceLoop`. --- The main part of `coherence` tactic.
- `Lean.Name.hasPos` | module `Physlib.Meta.Basic` | package PhysLean | Determines if a name has a location.
- `WriterT.run` | module `Mathlib.Control.Monad.Writer` | package Mathlib | **Writer Transformer Execution.** The execution of a writer monad transformer action, which transforms a computation of type `WriterT ω M α` into an action in the underlying monad `M` that returns a pair consisting of...

### Query: `Declaration UsesStandardReferenceState`
- `Mathlib.Tactic.ClickSuggestions.SectionKind` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | Whether the section corresponds to local hypotheses, declarations from the current file, or imported declarations.
- `StandardModel.GaugeGroupI` | module `Physlib.Particles.StandardModel.Basic` | package PhysLean | The global gauge group of the Standard Model with no discrete quotients. The `I` in the Name is an indication of the statement that this has no discrete quotients.
- `Mathlib.Tactic.ClickSuggestions.SectionKind.currFile` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | **Current File Section.** Within the classification of declaration sources, this represents the case where a declaration originates from the current file.

### Query: `Declaration IsHeatingBranch`
- `Mathlib.Tactic.Linarith.Branch` | module `Mathlib.Tactic.Linarith.Datatypes` | package Mathlib | Some preprocessors perform branching case splits. A `Branch` is used to track one of these case splits. The first component, an `MVarId`, is the goal corresponding to this branch of the split, given as a metavariable....
- `Turing.TM2.Stmt.branch` | module `Mathlib.Computability.TuringMachine.StackTuringMachine` | package Mathlib | **Conditional Branching Statement.** The `branch` constructor defines a control flow instruction that takes a predicate on the internal state and two statements; it executes the first statement if the predicate evalua...
- `Mathlib.Tactic.ClickSuggestions.SectionKind` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | Whether the section corresponds to local hypotheses, declarations from the current file, or imported declarations.

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `HahnSeries.leadingCoeff` (Mathlib)
- `MonadCont.Label` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `EuclideanGeometry.Sphere.two_zsmul_oangle_eq` (Mathlib)
- `EuclideanGeometry.Sphere.angle_eq_pi_div_two_iff_mem_sphere_ofDiameter` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `Mathlib.Tactic.Coherence.coherence_loop` (Mathlib)
- `Lean.Name.hasPos` (PhysLean)
- `Lean.toPreDefinition` (Mathlib)
- `IsAntichain` (Mathlib)
- `Mathlib.Tactic.Coherence.coherence_loop` (Mathlib)
- `DimPressure.pascal` (PhysLean)
- `JoinedIn` (Mathlib)
- `NVEHamiltonian.pressure` (PhysLean)
- `TemperatureUnit.kelvin` (PhysLean)
- `JoinedIn` (Mathlib)
- `UnitChoices.SI_temperature` (PhysLean)
- `Mathlib.Tactic.Coherence.coherence_loop` (Mathlib)
- `Lean.Name.hasPos` (PhysLean)
- `WriterT.run` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind` (Mathlib)
- `StandardModel.GaugeGroupI` (PhysLean)
- `Mathlib.Tactic.ClickSuggestions.SectionKind.currFile` (Mathlib)
- `Mathlib.Tactic.Linarith.Branch` (Mathlib)
- `Turing.TM2.Stmt.branch` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problems.Problem4A5.ApparatusLabel`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A5.Estimate`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A5.Estimate.Contains`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A5.Figure17Geometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A5.HasIsochoricPressureLinearity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A5.IPhO2026_4_A_5_thermalPressureCoefficient`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A5.IsHeatingBranch`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A5.IsPreparedIsochoricApparatus`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A5.IsochoricApparatus`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A5.IsochoricHeatingRun`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A5.ObeysIsochoricIdealGasLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A5.UsesStandardReferenceState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

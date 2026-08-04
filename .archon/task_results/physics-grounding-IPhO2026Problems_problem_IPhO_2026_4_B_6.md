# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_6.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:25c23b3cbb34c4c7c8f61cbd699217bd410e7aefc43884d41f7434301d3ed44f
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Declaration DisplayUnit`
- `IsUnit` | module `Mathlib.Algebra.Group.Units.Defs` | package Mathlib | An element `a : M` of a `Monoid` is a unit if it has a two-sided inverse. The actual definition says that `a` is equal to some `u : Mˣ`, where `Mˣ` is a bundled version of `IsUnit`.
- `Unitization.delabMk` | module `Mathlib.Algebra.Algebra.Unitization` | package Mathlib | This prevents `mk x` being printed as `{ toProd := x }` by `delabStructureInstance`.
- `LengthUnit` | module `Physlib.SpaceAndTime.Space.LengthUnit` | package PhysLean | The choices of translationally-invariant metrics on the space-manifold. Such a choice corresponds to a choice of units for length.

### Query: `Declaration Measurement`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `Mathlib.Tactic.ClickSuggestions.SectionKind` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | Whether the section corresponds to local hypotheses, declarations from the current file, or imported declarations.
- `HahnSeries.order` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The order of a nonzero Hahn series `x` is a minimal element of `Γ` where `x` has a nonzero coefficient, the order of 0 is 0.

### Query: `Declaration CylinderLabel`
- `MeasureTheory.cylinder` | module `Mathlib.MeasureTheory.Constructions.Cylinders` | package Mathlib | Given a finite set `s` of indices, a cylinder is the preimage of a set `S` of `∀ i : s, α i` by the projection from `∀ i, α i` to `∀ i : s, α i`.
- `MonadCont.Label` | module `Mathlib.Control.Monad.Cont` | package Mathlib | **Continuation Label.** A continuation label is a structure that encapsulates a function mapping values of type $\alpha$ to computations in a monad $m$ that produce values of type $\beta$.
- `PiNat.cylinder` | module `Mathlib.Topology.MetricSpace.PiNat` | package Mathlib | In a product space `Π n, E n`, the cylinder set of length `n` around `x`, denoted `cylinder x n`, is the set of sequences `y` that coincide with `x` on the first `n` symbols, i.e., such that `y i = x i` for all `i < n`.

### Query: `Declaration GraphAxisQuantity`
- `RigidBody.intermediate_axis_instability` | module `Physlib.ClassicalMechanics.RigidBody.Basic` | package PhysLean | Rotations about the largest and smallest principal axes are stable under small perturbations; rotation about the intermediate axis is unstable (tennis-racket effect).
- `SimpleGraph` | module `Mathlib.Combinatorics.SimpleGraph.Basic` | package Mathlib | A simple graph is an irreflexive symmetric relation `Adj` on a vertex type `V`. The relation describes which pairs of vertices are adjacent. There is exactly one edge for every pair of adjacent vertices; see `SimpleGr...
- `RigidBody.parallel_axis_theorem` | module `Physlib.ClassicalMechanics.RigidBody.Basic` | package PhysLean | If I_O is the inertia tensor about a point O, then the inertia tensor about a parallel point O' displaced by a is I_{O'} = I_O + M(|a|² 1 − a ⊗ a). This is the parallel-axis theorem.

### Query: `Declaration ClausiusClapeyronPlot`
- `Diffeology.IsPlot` | module `Mathlib.Geometry.Diffeology.Basic` | package Mathlib | A map `p : EuclideanSpace ℝ (Fin n) → X` is called a plot iff it is part of the diffeology on `X`. This is equivalent to `p` being smooth with respect to the standard diffeology on `EuclideanSpace ℝ (Fin n)`.
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `Mathlib.Meta.FunProp.FunPropDecls` | module `Mathlib.Tactic.FunProp.Decl` | package Mathlib | Discrimination tree for function properties.

### Query: `Declaration WaterVaporExperiment`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `HahnSeries.order` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The order of a nonzero Hahn series `x` is a minimal element of `Γ` where `x` has a nonzero coefficient, the order of 0 is 0.
- `HahnSeries.single` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | `single a r` is the Hahn series which has coefficient `r` at `a` and zero otherwise.

### Query: `Declaration VaporPressureLaws`
- `NVEHamiltonian.pressure` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.ThermoQuantities` | package PhysLean | Pressure, as a function of T. Defined as the conjugate variable to volume.
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `IdealGas.ideal_gas_law` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The ideal gas law: PV = nRT. In our unitsless system, R = 1.

### Query: `Declaration PreviousPartB5Result`
- `Part` | module `Mathlib.Data.Part` | package Mathlib | `Part α` is the type of "partial values" of type `α`. It is similar to `Option α` except the domain condition can be an arbitrary proposition, not necessarily decidable.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `elabLemmaWanted` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | The elaborator for semiformal results.

### Query: `Declaration WaterMolarMassData`
- `Finset.centerMass` | module `Mathlib.Analysis.Convex.Combination` | package Mathlib | Center of mass of a finite collection of points with prescribed weights. Note that we require neither `0 ≤ w i` nor `∑ w = 1`.
- `MassUnit` | module `Physlib.ClassicalMechanics.Mass.MassUnit` | package PhysLean | The choices of translationally-invariant metrics on the mass-manifold. Such a choice corresponds to a choice of units for mass.
- `PseudoInfo` | module `Physlib.Meta.Linters.Sorry` | package PhysLean | The information for stored for a declaration marked with `pseudo`.

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `IsUnit` (Mathlib)
- `Unitization.delabMk` (Mathlib)
- `LengthUnit` (PhysLean)
- `HahnSeries.orderTop` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind` (Mathlib)
- `HahnSeries.order` (Mathlib)
- `MeasureTheory.cylinder` (Mathlib)
- `MonadCont.Label` (Mathlib)
- `PiNat.cylinder` (Mathlib)
- `RigidBody.intermediate_axis_instability` (PhysLean)
- `SimpleGraph` (Mathlib)
- `RigidBody.parallel_axis_theorem` (PhysLean)
- `Diffeology.IsPlot` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `Mathlib.Meta.FunProp.FunPropDecls` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `HahnSeries.order` (Mathlib)
- `HahnSeries.single` (Mathlib)
- `NVEHamiltonian.pressure` (PhysLean)
- `HahnSeries.orderTop` (Mathlib)
- `IdealGas.ideal_gas_law` (PhysLean)
- `Part` (Mathlib)
- `semiformal_result` (PhysLean)
- `elabLemmaWanted` (PhysLean)
- `Finset.centerMass` (Mathlib)
- `MassUnit` (PhysLean)
- `PseudoInfo` (PhysLean)

## Local abstractions introduced

- `IPhO2026Problems.IPhO2026_4_B_6.ClausiusClapeyronPlot`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.CompatibleReportedMeasurement`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.CylinderLabel`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.DisplayUnit`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.GraphAxisQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.Measurement`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.PreviousPartB5Result`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.VaporPressureLaws`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.VaporizationBatch`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.VaporizationExtensivity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.WaterMolarMassData`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_4_B_6.WaterVaporExperiment`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

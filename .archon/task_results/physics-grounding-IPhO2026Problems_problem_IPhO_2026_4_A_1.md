# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_1.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:7a23f7dcf2c00ce41c57a49f600cfe09a6a9d940d223fc27da650d3c7e5bb585
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Measured quantities with absolute uncertainty`
- `MeasureTheory.MeasuredSets.lipschitzWith_measureReal` | module `Mathlib.MeasureTheory.Measure.MeasuredSets` | package Mathlib | **Lipschitz Continuity of the Real-Valued Measure.** For a finite measure $\mu$, the function that assigns to each measurable set its real-valued measure is Lipschitz continuous with Lipschitz constant 1.
- `MeasureTheory.Measure.AbsolutelyContinuous` | module `Mathlib.MeasureTheory.Measure.AbsolutelyContinuous` | package Mathlib | We say that `μ` is absolutely continuous with respect to `ν`, or that `μ` is dominated by `ν`, if `ν(A) = 0` implies that `μ(A) = 0`.
- `Measurable.abs` | module `Mathlib.MeasureTheory.Order.Group.Lattice` | package Mathlib | **Measurability of the Absolute Value.** If a function $f$ is measurable, then the function mapping $x$ to the absolute value $|f(x)|$ (defined as the supremum of $f(x)$ and $-f(x)$) is also measurable.

### Query: `The confined-air-column configuration`
- `Matrix.det_succ_column` | module `Mathlib.LinearAlgebra.Matrix.Determinant.Basic` | package Mathlib | Laplacian expansion of the determinant of an `n+1 × n+1` matrix along column `j`.
- `CategoryTheory.Limits.IsColimit` | module `Mathlib.CategoryTheory.Limits.IsLimit` | package Mathlib | A cocone `t` on `F` is a colimit cocone if each cocone on `F` admits a unique cocone morphism from `t`.
- `Matrix.det_mul_column` | module `Mathlib.LinearAlgebra.Matrix.Determinant.Basic` | package Mathlib | Multiplying each column by a fixed `v j` multiplies the determinant by the product of the `v`s.

### Query: `Official A.1 readouts`
- `WithTop.untopA` | module `Mathlib.Order.WithBot` | package Mathlib | Function that sends an element of `WithTop α` to `α`, with an arbitrary default value for `⊤`.
- `«term_≃A[_]_»` | module `Mathlib.Topology.Algebra.Algebra.Equiv` | package Mathlib | `ContinuousAlgEquiv R A B`, with notation `A ≃A[R] B`, is the type of bijections between the topological `R`-algebras `A` and `B` which are both homeomorphisms and `R`-algebra isomorphisms.
- `WithBot.unbotA` | module `Mathlib.Order.WithBot` | package Mathlib | Function that sends an element of `WithBot α` to `α`, with an arbitrary default value for `⊥`.

### Query: `Compatibility of a configuration with the readouts`
- `WithTop.untopA` | module `Mathlib.Order.WithBot` | package Mathlib | Function that sends an element of `WithTop α` to `α`, with an arbitrary default value for `⊤`.
- `WithBot.unbotA` | module `Mathlib.Order.WithBot` | package Mathlib | Function that sends an element of `WithBot α` to `α`, with an arbitrary default value for `⊥`.
- `Configuration.pointCount` | module `Mathlib.Combinatorics.Configuration` | package Mathlib | Number of lines through a given point.

### Query: `Closed form of the CA volume`
- `EuclideanSpace.volume_closedBall` | module `Mathlib.MeasureTheory.Measure.Lebesgue.VolumeOfBalls` | package Mathlib | **Volume of a Closed Ball in Euclidean Space.** In a Euclidean space $\mathbb{R}^n$ indexed by a finite set $\iota$ of cardinality $n$, the volume of a closed ball of radius $r$ centered at a point $x$ is given by $$V...
- `ModularForm` | module `Mathlib.NumberTheory.ModularForms.Basic` | package Mathlib | These are `SlashInvariantForm`'s that are holomorphic and bounded at infinity.
- `Orientation.volumeForm` | module `Mathlib.Analysis.InnerProductSpace.Orientation` | package Mathlib | The volume form on an oriented real inner product space, a nonvanishing top-dimensional alternating form uniquely defined by compatibility with the orientation and inner product structure.

### Query: `Ideal-gas route to the amount of substance`
- `IdealGas.ideal_gas_law` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The ideal gas law: PV = nRT. In our unitsless system, R = 1.
- `Ideal.span` | module `Mathlib.RingTheory.Ideal.Span` | package Mathlib | The ideal generated by a subset of a ring
- `IdealGas` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The Hamiltonian for an ideal gas: particles live in a cube of volume V^(1/3), and each contributes an energy p^2/2. The per-particle mass is normalized to 1.

### Query: `Positivity of the mass`
- `Mathlib.Meta.Positivity.PositivityExt` | module `Mathlib.Tactic.Positivity.Core` | package Mathlib | An extension for `positivity`.
- `positivity` | module `Mathlib.Tactic.Positivity.Core` | package Mathlib | A definition of type `PositivityExt` tagged `@[positivity t]` extends the `positivity` tactic. The term (with underscores) `t` indicates which expressions this extension accepts. An extension will be given an expressi...
- `QuantumMechanics.SpaceDQuantumSystem.m_pos` | module `Physlib.QuantumMechanics.SpaceDQuantumSystem` | package PhysLean | **Positivity of Mass.** In a $d$-dimensional quantum system, the mass parameter $m$ is strictly positive.

### Query: `Positivity of the molecule count`
- `Mathlib.Meta.Positivity.PositivityExt` | module `Mathlib.Tactic.Positivity.Core` | package Mathlib | An extension for `positivity`.
- `positivity` | module `Mathlib.Tactic.Positivity.Core` | package Mathlib | A definition of type `PositivityExt` tagged `@[positivity t]` extends the `positivity` tactic. The term (with underscores) `t` indicates which expressions this extension accepts. An extension will be given an expressi...
- `Mathlib.Meta.Positivity.positivityExt` | module `Mathlib.Tactic.Positivity.Core` | package Mathlib | Environment extensions for `positivity` declarations

### Query: `A.1 mass, density route`
- `FluidDynamics.MassDensity` | module `Physlib.FluidDynamics.FluidState` | package PhysLean | A mass density field on `d`-dimensional space.
- `MeasureTheory.Measure.withDensity` | module `Mathlib.MeasureTheory.Measure.WithDensity` | package Mathlib | Given a measure `μ : Measure α` and a function `f : α → ℝ≥0∞`, `μ.withDensity f` is the measure such that for a measurable set `s` we have `μ.withDensity f s = ∫⁻ a in s, f a ∂μ`.
- `CartanMatrix.A_one` | module `Mathlib.LinearAlgebra.Matrix.Cartan` | package Mathlib | **Cartan Matrix of Type $A_1$.** The Cartan matrix of type $A_1$ is the $1 \times 1$ matrix whose single entry is $2$.

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `MeasureTheory.MeasuredSets.lipschitzWith_measureReal` (Mathlib)
- `MeasureTheory.Measure.AbsolutelyContinuous` (Mathlib)
- `Measurable.abs` (Mathlib)
- `Matrix.det_succ_column` (Mathlib)
- `CategoryTheory.Limits.IsColimit` (Mathlib)
- `Matrix.det_mul_column` (Mathlib)
- `WithTop.untopA` (Mathlib)
- `«term_≃A[_]_»` (Mathlib)
- `WithBot.unbotA` (Mathlib)
- `WithTop.untopA` (Mathlib)
- `WithBot.unbotA` (Mathlib)
- `Configuration.pointCount` (Mathlib)
- `EuclideanSpace.volume_closedBall` (Mathlib)
- `ModularForm` (Mathlib)
- `Orientation.volumeForm` (Mathlib)
- `IdealGas.ideal_gas_law` (PhysLean)
- `Ideal.span` (Mathlib)
- `IdealGas` (PhysLean)
- `Mathlib.Meta.Positivity.PositivityExt` (Mathlib)
- `positivity` (Mathlib)
- `QuantumMechanics.SpaceDQuantumSystem.m_pos` (PhysLean)
- `Mathlib.Meta.Positivity.PositivityExt` (Mathlib)
- `positivity` (Mathlib)
- `Mathlib.Meta.Positivity.positivityExt` (Mathlib)
- `FluidDynamics.MassDensity` (PhysLean)
- `MeasureTheory.Measure.withDensity` (Mathlib)
- `CartanMatrix.A_one` (Mathlib)

## Local abstractions introduced

- `IPhO2026_4_A_1.ConfinedAirColumn`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_1.ConfinedAirColumn.CompatibleWithReadouts`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_1.ConfinedAirColumn.OfficialReadouts`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_1.MeasuredQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_1.MeasuredQuantity.PropagatesTo`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

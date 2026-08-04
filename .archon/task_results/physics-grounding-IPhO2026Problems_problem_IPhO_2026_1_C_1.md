# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_1.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:77310f71d7803df83f75a7dd912d0f99d2d76244ef646f292de26d683eae3cb4
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Real.sqrt square root`
- `Real.sqrt` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | The square root of a real number. This returns 0 for negative inputs. This has notation `√x`. Note that `√x⁻¹` is parsed as `√(x⁻¹)`.
- `Real.coe_sqrt` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | **Square Root of Nonnegative Reals.** For any nonnegative real number $x$, the real-valued square root of $x$ is equal to the square root of $x$ computed in the nonnegative real numbers and then cast to a real number.
- `Real.sqrt_lt'` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | **Strict Monotonicity of the Square Root.** For any real number $x$ and any positive real number $y$, the square root of $x$ is strictly less than $y$ if and only if $x$ is strictly less than $y^2$.

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Declaration MomentumPlane`
- `Momentum` | module `Physlib.Units.WithDim.Momentum` | package PhysLean | Momentum in `d`-dimensional space in an arbitrary, but given, set of units. In `(3+1)d` space time this corresponds to `3`-momentum not `4`-momentum.
- `QuantumMechanics.momentumCLM` | module `Physlib.QuantumMechanics.Operators.Momentum` | package PhysLean | Component `i` of the momentum operator is the continuous linear map from `𝓢(Space d, ℂ)` to itself which maps `ψ` to `-iℏ ∂ᵢψ`.
- `QuantumMechanics.OneDimension.planeWaveFunctional_generalized_eigenvector_momentumOperatorUnbounded` | module `Physlib.QuantumMechanics.Operators.OneDimension.Momentum` | package PhysLean | **Generalized Eigenvector of the Momentum Operator.** For any real number $k$, the plane wave functional associated with $k$ is a generalized eigenvector of the unbounded momentum operator with corresponding eigenvalu...

### Query: `Declaration figure1cIncidentDirection`
- `AffineSubspace.direction` | module `Mathlib.LinearAlgebra.AffineSpace.AffineSubspace.Defs` | package Mathlib | The direction of an affine subspace is the submodule spanned by the pairwise differences of points. (Except in the case of an empty affine subspace, where the direction is the zero submodule, every vector in the direc...
- `Mathlib.Tactic.ClickSuggestions.SectionKind.currFile` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | **Current File Section.** Within the classification of declaration sources, this represents the case where a declaration originates from the current file.
- `SimpleGraph.edge_other_incident_set` | module `Mathlib.Combinatorics.SimpleGraph.Basic` | package Mathlib | **Incidence of an Edge at its Opposite Vertex.** If an edge $e$ is incident to a vertex $v$ in a simple graph $G$, then $e$ is also incident to the other vertex of $e$ relative to $v$.

### Query: `Declaration Parameters`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `HahnSeries.leadingCoeff` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | A leading coefficient of a Hahn series is the coefficient of a lowest-order nonzero term, or zero if the series vanishes.
- `HahnSeries.map` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The map of Hahn series induced by applying a zero-preserving map to each coefficient.

### Query: `Declaration Parameters.energyGap`
- `Finset.mulEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The multiplicative energy `Eₘ[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ * b₁ = a₂ * b₂`. The notation `Eₘ[s, t]` is available in scope `C...
- `Finset.addEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The additive energy `E[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ + b₁ = a₂ + b₂`. The notation `E[s, t]` is available in scope `Combinato...
- `DimEnergy` | module `Physlib.Units.WithDim.Energy` | package PhysLean | Energy as a dimensional quantity with dimension `MLT⁻2`..

### Query: `Declaration Parameters.Valid`
- `Ordnode.Valid'` | module `Mathlib.Data.Ordmap.Ordset` | package Mathlib | The validity predicate for an `Ordnode` subtree. This asserts that the `size` fields are correct, the tree is balanced, and the elements of the tree are organized according to the ordering. This version of `Valid` als...
- `Ordnode.Valid` | module `Mathlib.Data.Ordmap.Ordset` | package Mathlib | The validity predicate for an `Ordnode` subtree. This asserts that the `size` fields are correct, the tree is balanced, and the elements of the tree are organized according to the ordering.
- `Mathlib.Tactic.Translate.warnParametricAttr` | module `Mathlib.Tactic.Translate.Core` | package Mathlib | Warn the user when the declaration has a parametric attribute.

### Query: `Declaration photonEnergy`
- `Finset.addEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The additive energy `E[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ + b₁ = a₂ + b₂`. The notation `E[s, t]` is available in scope `Combinato...
- `Finset.mulEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The multiplicative energy `Eₘ[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ * b₁ = a₂ * b₂`. The notation `Eₘ[s, t]` is available in scope `C...
- `Finpartition.coe_energy` | module `Mathlib.Combinatorics.SimpleGraph.Regularity.Energy` | package Mathlib | **Energy of a Partition.** For a simple graph $G$ and a finite partition $\mathcal{P}$ of its vertex set, the energy of $\mathcal{P}$ (viewed as an element of a strictly ordered field) is equal to the sum of the squar...

### Query: `Declaration photonMomentumMagnitude`
- `Momentum` | module `Physlib.Units.WithDim.Momentum` | package PhysLean | Momentum in `d`-dimensional space in an arbitrary, but given, set of units. In `(3+1)d` space time this corresponds to `3`-momentum not `4`-momentum.
- `QuantumMechanics.momentumCLM` | module `Physlib.QuantumMechanics.Operators.Momentum` | package PhysLean | Component `i` of the momentum operator is the continuous linear map from `𝓢(Space d, ℂ)` to itself which maps `ψ` to `-iℏ ∂ᵢψ`.
- `Electromagnetism.ElectromagneticPotential.canonicalMomentum_eq_electricField` | module `Physlib.Electromagnetism.Dynamics.Hamiltonian` | package PhysLean | **Canonical Momentum in Terms of the Electric Field.** For an electromagnetic potential $A$ of class $C^2$ in free space with magnetic permeability $\mu_0$ and speed of light $c$, the canonical momentum associated wit...

### Query: `Declaration fragmentKineticEnergy`
- `RigidBody.kinetic_energy_decomposition` | module `Physlib.ClassicalMechanics.RigidBody.Basic` | package PhysLean | The kinetic energy decomposes into translational and rotational parts: T = (1/2) M |V|² + (1/2) ω ⋅ I_CM ω. Here V is the velocity of the centre of mass and I_CM is the inertia tensor about that point.
- `Finset.addEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The additive energy `E[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ + b₁ = a₂ + b₂`. The notation `E[s, t]` is available in scope `Combinato...
- `Finset.mulEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The multiplicative energy `Eₘ[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ * b₁ = a₂ * b₂`. The notation `Eₘ[s, t]` is available in scope `C...

## Grounded Mathlib/PhysLean names

- `Real.sqrt` (Mathlib)
- `Real.coe_sqrt` (Mathlib)
- `Real.sqrt_lt'` (Mathlib)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `Momentum` (PhysLean)
- `QuantumMechanics.momentumCLM` (PhysLean)
- `QuantumMechanics.OneDimension.planeWaveFunctional_generalized_eigenvector_momentumOperatorUnbounded` (PhysLean)
- `AffineSubspace.direction` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind.currFile` (Mathlib)
- `SimpleGraph.edge_other_incident_set` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `HahnSeries.leadingCoeff` (Mathlib)
- `HahnSeries.map` (Mathlib)
- `Finset.mulEnergy` (Mathlib)
- `Finset.addEnergy` (Mathlib)
- `DimEnergy` (PhysLean)
- `Ordnode.Valid'` (Mathlib)
- `Ordnode.Valid` (Mathlib)
- `Mathlib.Tactic.Translate.warnParametricAttr` (Mathlib)
- `Finset.addEnergy` (Mathlib)
- `Finset.mulEnergy` (Mathlib)
- `Finpartition.coe_energy` (Mathlib)
- `Momentum` (PhysLean)
- `QuantumMechanics.momentumCLM` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.canonicalMomentum_eq_electricField` (PhysLean)
- `RigidBody.kinetic_energy_decomposition` (PhysLean)
- `Finset.addEnergy` (Mathlib)
- `Finset.mulEnergy` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problem1C1.DissociationEvent`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem1C1.HasEnoughPhotonEnergy`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem1C1.IsDissociationThreshold`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem1C1.KinematicallyAllowed`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem1C1.MomentumPlane`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem1C1.Parameters`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem1C1.Parameters.Valid`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

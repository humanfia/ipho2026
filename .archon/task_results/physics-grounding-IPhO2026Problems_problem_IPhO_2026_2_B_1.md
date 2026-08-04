# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_1.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:afa62b2a083831dd292ca31077f59f6c25e68cb98c2a4e8ee008376bc6f849e3
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Real.sqrt square root`
- `Real.sqrt` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | The square root of a real number. This returns 0 for negative inputs. This has notation `√x`. Note that `√x⁻¹` is parsed as `√(x⁻¹)`.
- `Real.coe_sqrt` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | **Square Root of Nonnegative Reals.** For any nonnegative real number $x$, the real-valued square root of $x$ is equal to the square root of $x$ computed in the nonnegative real numbers and then cast to a real number.
- `Real.sqrt_lt'` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | **Strict Monotonicity of the Square Root.** For any real number $x$ and any positive real number $y$, the square root of $x$ is strictly less than $y$ if and only if $x$ is strictly less than $y^2$.

### Query: `EuclideanSpace vector components`
- `EuclideanSpace` | module `Mathlib.Analysis.InnerProductSpace.PiL2` | package Mathlib | The standard real/complex Euclidean space, functions on a finite type. For an `n`-dimensional space use `EuclideanSpace 𝕜 (Fin n)`. For the case when `n = Fin _`, there is `!₂[x, y, ...]` notation for building element...
- `Space.fderiv_space_components` | module `Physlib.SpaceAndTime.Space.Module` | package PhysLean | **Components of the Fréchet Derivative of a Vector-Valued Function.** For a differentiable function $f$ mapping from a normed space $M$ to the space of $d$-dimensional vectors $\mathbb{R}^d$, the $\mu$-th component of...
- `Lorentz.ContrMod.toSpace` | module `Physlib.Relativity.Tensors.RealTensor.Vector.Pre.Modules` | package PhysLean | The underlying space part of a `ContrMod` formed by removing the first element. A better name for this might be `tail`.

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Cross-sectional vector`
- `cross_cross` | module `Mathlib.LinearAlgebra.CrossProduct` | package Mathlib | **Vector Triple Product Identity.** For any three vectors $u, v, w \in R^3$ over a commutative ring $R$, the iterated cross product satisfies the identity $u \times (v \times w) = u \times (v \times w) - v \times (u \...
- `leibniz_cross` | module `Mathlib.LinearAlgebra.CrossProduct` | package Mathlib | The cross product satisfies the Leibniz lie property.
- `Projectivization.cross` | module `Mathlib.LinearAlgebra.Projectivization.Constructions` | package Mathlib | Cross product on the projective plane.

### Query: `Euclidean norm of a cross-sectional vector`
- `crossProduct` | module `Mathlib.LinearAlgebra.CrossProduct` | package Mathlib | The cross product of two vectors in $R^3$ for $R$ a commutative ring.
- `InnerProductGeometry.norm_ofLp_crossProduct` | module `Mathlib.Geometry.Euclidean.Angle.Unoriented.CrossProduct` | package Mathlib | The L2 norm of the cross product of two real vectors (of type `EuclideanSpace ℝ (Fin 3)`) equals the product of their individual norms times the sine of the angle between them.
- `EuclideanDomain.gcdA` | module `Mathlib.Algebra.EuclideanDomain.Defs` | package Mathlib | The extended GCD `a` value in the equation `gcd x y = x * a + y * b`.

### Query: `Non-vertical line in the cross-section`
- `Combinatorics.Line.vertical` | module `Mathlib.Combinatorics.HalesJewett` | package Mathlib | A point in `ι → α` and a line in `ι' → α` determine a line in `ι ⊕ ι' → α`.
- `crossProduct` | module `Mathlib.LinearAlgebra.CrossProduct` | package Mathlib | The cross product of two vectors in $R^3$ for $R$ a commutative ring.
- `Configuration.HasLines` | module `Mathlib.Combinatorics.Configuration` | package Mathlib | A nondegenerate configuration in which every pair of points has a line through them.

### Query: `Signed point-to-line distance`
- `signedDist_left_lineMap` | module `Mathlib.Geometry.Euclidean.SignedDist` | package Mathlib | **Signed Distance to a Point on a Line.** For any vector $v$, points $p$ and $q$, and scalar $c \in \mathbb{R}$, the signed distance from $p$ to the point $c$ along the line through $p$ and $q$ is equal to $c$ times t...
- `AffineMap.lineMap` | module `Mathlib.LinearAlgebra.AffineSpace.AffineMap` | package Mathlib | The affine map from `k` to `P1` sending `0` to `p₀` and `1` to `p₁`.
- `signedDist_lineMap_lineMap` | module `Mathlib.Geometry.Euclidean.SignedDist` | package Mathlib | **Signed Distance Between Points on an Affine Line.** For any two points $p$ and $q$ in an affine space and any two scalars $c_1, c_2 \in \mathbb{R}$, the signed distance with respect to a reference vector $v$ between...

### Query: `Cooker dimensionful parameters`
- `Dimensionful` | module `Physlib.Units.Basic` | package PhysLean | The subtype of functions `UnitChoices → M`, for which `M` carries a dimension, which `HasDimension`.
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `UnitChoices.dimScale_apply` | module `Physlib.Units.Basic` | package PhysLean | **Dimensional Scaling Factor Formula.** For any two systems of units $u_1$ and $u_2$ and a physical dimension $d$, the scaling factor $\text{dimScale}(u_1, u_2, d)$ is defined as the product of the ratios of the funda...

### Query: `Cooker specular bookkeeping`
- `εNFA.εClosure` | module `Mathlib.Computability.EpsilonNFA` | package Mathlib | The `εClosure` of a set is the set of states which can be reached by taking a finite string of ε-transitions from an element of the set.
- `εNFA.IsPath` | module `Mathlib.Computability.EpsilonNFA` | package Mathlib | `M.IsPath` represents a traversal in `M` from a start state to an end state by following a list of transitions in order.
- `CategoryTheory.Abelian.SpectralObject.cokernelSequenceE_exact` | module `Mathlib.Algebra.Homology.SpectralObject.Page` | package Mathlib | **Exactness of the Cokernel Sequence.** In an abelian category, for a spectral object $X$ and a sequence of indices $n_0, n_1, n_2$ such that $n_1 = n_0 + 1$ and $n_2 = n_1 + 1$, the short complex associated with the...

### Query: `Incidence angle of a column`
- `Matrix.det_succ_column` | module `Mathlib.LinearAlgebra.Matrix.Determinant.Basic` | package Mathlib | Laplacian expansion of the determinant of an `n+1 × n+1` matrix along column `j`.
- `Orientation.oangle` | module `Mathlib.Geometry.Euclidean.Angle.Oriented.Basic` | package Mathlib | The oriented angle from `x` to `y`, modulo `2 * π`. If either vector is 0, this is 0. See `InnerProductGeometry.angle` for the corresponding unoriented angle definition.
- `SimpleGraph.incMatrix_apply_eq_one_iff` | module `Mathlib.Combinatorics.SimpleGraph.IncMatrix` | package Mathlib | **Incidence Matrix Entry and Incidence Set.** For a simple graph $G$ and a semiring $R$, the entry of the incidence matrix $M$ at row $a$ and column $e$ is equal to $1$ if and only if the edge $e$ is incident to the v...

## Grounded Mathlib/PhysLean names

- `Real.sqrt` (Mathlib)
- `Real.coe_sqrt` (Mathlib)
- `Real.sqrt_lt'` (Mathlib)
- `EuclideanSpace` (Mathlib)
- `Space.fderiv_space_components` (PhysLean)
- `Lorentz.ContrMod.toSpace` (PhysLean)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `cross_cross` (Mathlib)
- `leibniz_cross` (Mathlib)
- `Projectivization.cross` (Mathlib)
- `crossProduct` (Mathlib)
- `InnerProductGeometry.norm_ofLp_crossProduct` (Mathlib)
- `EuclideanDomain.gcdA` (Mathlib)
- `Combinatorics.Line.vertical` (Mathlib)
- `crossProduct` (Mathlib)
- `Configuration.HasLines` (Mathlib)
- `signedDist_left_lineMap` (Mathlib)
- `AffineMap.lineMap` (Mathlib)
- `signedDist_lineMap_lineMap` (Mathlib)
- `Dimensionful` (PhysLean)
- `HahnSeries.orderTop` (Mathlib)
- `UnitChoices.dimScale_apply` (PhysLean)
- `εNFA.εClosure` (Mathlib)
- `εNFA.IsPath` (Mathlib)
- `CategoryTheory.Abelian.SpectralObject.cokernelSequenceE_exact` (Mathlib)
- `Matrix.det_succ_column` (Mathlib)
- `Orientation.oangle` (Mathlib)
- `SimpleGraph.incMatrix_apply_eq_one_iff` (Mathlib)

## Local abstractions introduced

- `IPhO2026_2_B_1.CoeffSpec`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_1.CookerB1`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_1.CookerParams`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_1.ExtremalRaySpec`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_1.IsThetaMax`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_1.Line2D`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_1.SecondExtremalConfig`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_1.Vec`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

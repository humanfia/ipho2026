# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_2_C_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_1.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:9214cb1684039a5e2ef749c844ad71cf53e6127eb6f80e9f7ff359f9e89f36bb
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `EuclideanSpace vector components`
- `EuclideanSpace` | module `Mathlib.Analysis.InnerProductSpace.PiL2` | package Mathlib | The standard real/complex Euclidean space, functions on a finite type. For an `n`-dimensional space use `EuclideanSpace 𝕜 (Fin n)`. For the case when `n = Fin _`, there is `!₂[x, y, ...]` notation for building element...
- `Space.fderiv_space_components` | module `Physlib.SpaceAndTime.Space.Module` | package PhysLean | **Components of the Fréchet Derivative of a Vector-Valued Function.** For a differentiable function $f$ mapping from a normed space $M$ to the space of $d$-dimensional vectors $\mathbb{R}^d$, the $\mu$-th component of...
- `Lorentz.ContrMod.toSpace` | module `Physlib.Relativity.Tensors.RealTensor.Vector.Pre.Modules` | package PhysLean | The underlying space part of a `ContrMod` formed by removing the first element. A better name for this might be `tail`.

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Declaration PlanePoint`
- `OnePoint` | module `Mathlib.Topology.Compactification.OnePoint.Basic` | package Mathlib | The one-point extension of an arbitrary topological space `X`
- `Configuration.ProjectivePlane.pointCount_eq_pointCount` | module `Mathlib.Combinatorics.Configuration` | package Mathlib | **Equality of Point Counts on Lines.** In a finite projective plane, every pair of lines is incident to the same number of points.
- `Affine.Simplex.mongePoint_mem_mongePlane` | module `Mathlib.Geometry.Euclidean.MongePoint` | package Mathlib | The Monge point lies in the Monge planes.

### Query: `Declaration PlaneDirection`
- `AffineSubspace.direction` | module `Mathlib.LinearAlgebra.AffineSpace.AffineSubspace.Defs` | package Mathlib | The direction of an affine subspace is the submodule spanned by the pairwise differences of points. (Except in the case of an empty affine subspace, where the direction is the zero submodule, every vector in the direc...
- `Affine.Simplex.direction_mongePlane` | module `Mathlib.Geometry.Euclidean.MongePoint` | package Mathlib | The direction of a Monge plane.
- `Space.Direction` | module `Physlib.SpaceAndTime.Space.Module` | package PhysLean | Notion of direction where `unit` returns a unit vector in the direction specified.

### Query: `Declaration dot`
- `dotProduct` | module `Mathlib.Data.Matrix.Mul` | package Mathlib | `dotProduct v w` is the sum of the entrywise products `v i * w i`. See also `dotProductEquiv`.
- `cross_dot_cross` | module `Mathlib.LinearAlgebra.CrossProduct` | package Mathlib | The scalar quadruple product identity, related to the Binet-Cauchy identity.
- `MSSMACC.dot` | module `Physlib.Particles.SuperSymmetry.MSSMNu.AnomalyCancellation.Basic` | package PhysLean | The dot product on the vector space of charges.

### Query: `Declaration IsNonzero`
- `Mathlib.Meta.Positivity.compareHypNonzero` | module `Mathlib.Tactic.Positivity.Core` | package Mathlib | A variation on `assumption` when the hypothesis is `e ≠ 0` or `0 ≠ e`.
- `Mathlib.Meta.Positivity.Strictness.toNonzero` | module `Mathlib.Tactic.Positivity.Core` | package Mathlib | Extract a proof that `e` is nonzero, if possible, from `Strictness` information about `e`.
- `IsSumNonzeroSq` | module `Mathlib.Algebra.Ring.IsFormallyReal` | package Mathlib | The property of being a sum of squares of nonzero elements (S) is defined inductively by: `a * a : R` is (S) for all nonzero `a`, and if `s : R` is (S), and `a ≠ 0`, then `a * a + s` is (S).

### Query: `Declaration IsUnit`
- `IsUnit` | module `Mathlib.Algebra.Group.Units.Defs` | package Mathlib | An element `a : M` of a `Monoid` is a unit if it has a two-sided inverse. The actual definition says that `a` is equal to some `u : Mˣ`, where `Mˣ` is a bundled version of `IsUnit`.
- `UnitDependent` | module `Physlib.Units.UnitDependent` | package PhysLean | A type carries the instance `UnitDependent M` if it depends on a choice of units. This dependence is manifested in `scaleUnit u1 u2` which describes how elements of `M` change under a scaling of units which would take...
- `PUnit.norm_unit_eq` | module `Mathlib.Algebra.GCDMonoid.PUnit` | package Mathlib | **Normalization Unit of PUnit.** For any element $x$ of the unit type `PUnit`, the normalization unit of $x$ is equal to $1$.

### Query: `Declaration reflectedByNormal`
- `Subgroup.Normal` | module `Mathlib.Algebra.Group.Subgroup.Defs` | package Mathlib | A subgroup `H` is normal if whenever `n ∈ H`, then `g * n * g⁻¹ ∈ H` for every `g : G` [Wikidata Q743179](https://www.wikidata.org/wiki/Q743179)
- `Mathlib.Tactic.Determinant.Cert.norm` | module `Mathlib.Tactic.Determinant.Bird.Cert` | package Mathlib | The ring tactic normal form of `c.subject`
- `norm_det` | module `Mathlib.Tactic.Determinant.Bird` | package Mathlib | Normalize a literal `birdDet` call using the certificate-chain evaluator.

### Query: `Declaration IsSpecularReflection`
- `RootPairing.reflection` | module `Mathlib.LinearAlgebra.RootSystem.Defs` | package Mathlib | The reflection associated to a root.
- `Equiv.pointReflection` | module `Mathlib.Algebra.Torsor.Defs` | package Mathlib | Point reflection in `x` as a permutation.
- `Module.reflection` | module `Mathlib.LinearAlgebra.Reflection` | package Mathlib | Given an element `x` in a module `M` and a linear form `f` on `M` for which `f x = 2`, we define the endomorphism of `M` for which `y ↦ y - (f y) • x`. It is an involutive endomorphism of `M` fixing the kernel of `f`...

### Query: `Declaration HalfCylindricalMirror`
- `Polynomial.mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | mirror of a polynomial: reverses the coefficients while preserving `Polynomial.natDegree`
- `Polynomial.mirror_mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | **Involution of the Mirror Polynomial.** For any polynomial $p$, applying the mirror operation twice results in the original polynomial $p$.
- `Polynomial.mirror_zero` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | **Mirror of the Zero Polynomial.** The mirror of the zero polynomial is equal to the zero polynomial.

## Grounded Mathlib/PhysLean names

- `EuclideanSpace` (Mathlib)
- `Space.fderiv_space_components` (PhysLean)
- `Lorentz.ContrMod.toSpace` (PhysLean)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `OnePoint` (Mathlib)
- `Configuration.ProjectivePlane.pointCount_eq_pointCount` (Mathlib)
- `Affine.Simplex.mongePoint_mem_mongePlane` (Mathlib)
- `AffineSubspace.direction` (Mathlib)
- `Affine.Simplex.direction_mongePlane` (Mathlib)
- `Space.Direction` (PhysLean)
- `dotProduct` (Mathlib)
- `cross_dot_cross` (Mathlib)
- `MSSMACC.dot` (PhysLean)
- `Mathlib.Meta.Positivity.compareHypNonzero` (Mathlib)
- `Mathlib.Meta.Positivity.Strictness.toNonzero` (Mathlib)
- `IsSumNonzeroSq` (Mathlib)
- `IsUnit` (Mathlib)
- `UnitDependent` (PhysLean)
- `PUnit.norm_unit_eq` (Mathlib)
- `Subgroup.Normal` (Mathlib)
- `Mathlib.Tactic.Determinant.Cert.norm` (Mathlib)
- `norm_det` (Mathlib)
- `RootPairing.reflection` (Mathlib)
- `Equiv.pointReflection` (Mathlib)
- `Module.reflection` (Mathlib)
- `Polynomial.mirror` (Mathlib)
- `Polynomial.mirror_mirror` (Mathlib)
- `Polynomial.mirror_zero` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problems.IPhO2026_2_C_1.Figure2gCausticSetup`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.Figure2gRayInteraction`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.HalfCylindricalMirror`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.HalfCylindricalMirror.OnReflectingSurface`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.OpticalRayAtPoint`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.PlaneDirection`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.PlaneDirection.IsNonzero`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.PlaneDirection.IsSpecularReflection`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.PlaneDirection.IsUnit`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.PlanePoint`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.SlopeInterceptLine`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.SlopeInterceptLine.Contains`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_1.SlopeInterceptLine.HasDirection`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

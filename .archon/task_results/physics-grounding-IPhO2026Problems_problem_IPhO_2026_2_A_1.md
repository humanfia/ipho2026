# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_A_1.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:3cf5d09a7e320397d32b899e3d59c2cf0d8f83088458b93e2248a8fdc0b9d24f
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Declaration SourceFigure`
- `Mathlib.Tactic.ClickSuggestions.SectionKind.currFile` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | **Current File Section.** Within the classification of declaration sources, this represents the case where a declaration originates from the current file.
- `Mathlib.Tactic.ClickSuggestions.SectionKind.imported` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | **Classification of Declaration Sources.** The source of a declaration is categorized into one of three kinds: a local hypothesis, a declaration within the current file, or a declaration from an imported module.
- `Mathlib.Tactic.ClickSuggestions.SectionKind` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | Whether the section corresponds to local hypotheses, declarations from the current file, or imported declarations.

### Query: `Declaration AxialDirection`
- `AffineSubspace.direction` | module `Mathlib.LinearAlgebra.AffineSpace.AffineSubspace.Defs` | package Mathlib | The direction of an affine subspace is the submodule spanned by the pairwise differences of points. (Except in the case of an empty affine subspace, where the direction is the zero submodule, every vector in the direc...
- `Space.Direction` | module `Physlib.SpaceAndTime.Space.Module` | package PhysLean | Notion of direction where `unit` returns a unit vector in the direction specified.
- `Space.toDirection` | module `Physlib.SpaceAndTime.Space.Module` | package PhysLean | Direction of a `Space` value with respect to the origin.

### Query: `Declaration HalfCylindricalMirror`
- `Polynomial.mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | mirror of a polynomial: reverses the coefficients while preserving `Polynomial.natDegree`
- `Polynomial.mirror_mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | **Involution of the Mirror Polynomial.** For any polynomial $p$, applying the mirror operation twice results in the original polynomial $p$.
- `Polynomial.mirror_zero` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | **Mirror of the Zero Polynomial.** The mirror of the zero polynomial is equal to the zero polynomial.

### Query: `Declaration HalfCylindricalMirror.diameter`
- `EuclideanGeometry.Sphere.isDiameter_iff_left_mem_and_pointReflection_center_left` | module `Mathlib.Geometry.Euclidean.Sphere.Basic` | package Mathlib | **Characterization of a Sphere's Diameter via Point Reflection.** Two points $p_1$ and $p_2$ form a diameter of a sphere $s$ if and only if $p_1$ lies on the sphere and $p_2$ is the image of $p_1$ under a point reflec...
- `UpperHalfPlane.im` | module `Mathlib.Analysis.Complex.UpperHalfPlane.Basic` | package Mathlib | Imaginary part
- `Polynomial.mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | mirror of a polynomial: reverses the coefficients while preserving `Polynomial.natDegree`

### Query: `Declaration OnReflectingSemicircle`
- `DifferentiableOn` | module `Mathlib.Analysis.Calculus.FDeriv.Defs` | package Mathlib | `DifferentiableOn 𝕜 f s` means that `f` is differentiable within `s` at any point of `s`.
- `EuclideanGeometry.Sphere.isDiameter_iff_left_mem_and_pointReflection_center_left` | module `Mathlib.Geometry.Euclidean.Sphere.Basic` | package Mathlib | **Characterization of a Sphere's Diameter via Point Reflection.** Two points $p_1$ and $p_2$ form a diameter of a sphere $s$ if and only if $p_1$ lies on the sphere and $p_2$ is the image of $p_1$ under a point reflec...
- `ContinuousOn` | module `Mathlib.Topology.Defs.Filter` | package Mathlib | A function between topological spaces is continuous on a subset `s` when it's continuous at every point of `s` within `s`.

### Query: `Declaration MultipleReflectionExperiment`
- `RootPairing.reflection` | module `Mathlib.LinearAlgebra.RootSystem.Defs` | package Mathlib | The reflection associated to a root.
- `IsLocalization.integerMultiple` | module `Mathlib.RingTheory.Localization.Integer` | package Mathlib | The numerator of a fraction after clearing the denominators of a `Finset`-indexed family of fractions.
- `Module.reflection` | module `Mathlib.LinearAlgebra.Reflection` | package Mathlib | Given an element `x` in a module `M` and a linear form `f` on `M` for which `f x = 2`, we define the endomorphism of `M` for which `y ↦ y - (f y) • x`. It is an involutive endomorphism of `M` fixing the kernel of `f`...

### Query: `Declaration ObeysSpecularReflection`
- `RootPairing.reflection` | module `Mathlib.LinearAlgebra.RootSystem.Defs` | package Mathlib | The reflection associated to a root.
- `LinearMap.IsReflective.reflective_reflection` | module `Mathlib.LinearAlgebra.RootSystem.OfBilinear` | package Mathlib | **Reflectivity of Reflected Vectors.** Let $B$ be a symmetric bilinear form on a module $M$. If $x$ and $y$ are reflective vectors with respect to $B$, then the reflection of $y$ across the hyperplane orthogonal to $x...
- `Equiv.pointReflection` | module `Mathlib.Algebra.Torsor.Defs` | package Mathlib | Point reflection in `x` as a permutation.

### Query: `Declaration IsPositiveReflectionThreshold`
- `IsStrictlyPositive` | module `Mathlib.Algebra.Algebra.StrictPositivity` | package Mathlib | An element of an ordered algebra is *strictly positive* if it is nonnegative and invertible. NOTE: This definition will be generalized to the non-unital case in the future; do not unfold the definition and use the API...
- `RootPairing.Base.IsPos.induction_on_reflect` | module `Mathlib.LinearAlgebra.RootSystem.Base` | package Mathlib | **Induction on Positive Roots via Reflections.** Let $i$ be an index such that the corresponding root is positive with respect to a base with support $S$. Let $p$ be a property of indices. If $p$ holds for all indices...
- `RootPairing.RootPositiveForm.rootLength_reflectionPerm_self` | module `Mathlib.LinearAlgebra.RootSystem.RootPositive` | package Mathlib | **Invariance of Root Length under Reflection.** For any index $i$ in a root pairing, the length of the $i$-th root is invariant under the action of its own associated reflection permutation; that is, the root length o...

### Query: `Declaration LimitingRayWitness`
- `SameRay` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | Two vectors are in the same ray if either one of them is zero or some positive multiples of them are equal (in the typical case over a field, this means one of them is a nonnegative multiple of the other).
- `Equidecomp.witness` | module `Mathlib.Algebra.Group.Action.Equidecomp` | package Mathlib | A finite set of group elements witnessing that `f` is an equidecomposition.
- `instFaithfulWitness` | module `Mathlib.CategoryTheory.UnivLE` | package Mathlib | **Faithfulness of the Universe Embedding Functor.** If the universe level $u$ is less than or equal to the universe level $v$, then the canonical embedding functor from the category of types in universe $u$ to the cat...

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind.currFile` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind.imported` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind` (Mathlib)
- `AffineSubspace.direction` (Mathlib)
- `Space.Direction` (PhysLean)
- `Space.toDirection` (PhysLean)
- `Polynomial.mirror` (Mathlib)
- `Polynomial.mirror_mirror` (Mathlib)
- `Polynomial.mirror_zero` (Mathlib)
- `EuclideanGeometry.Sphere.isDiameter_iff_left_mem_and_pointReflection_center_left` (Mathlib)
- `UpperHalfPlane.im` (Mathlib)
- `Polynomial.mirror` (Mathlib)
- `DifferentiableOn` (Mathlib)
- `EuclideanGeometry.Sphere.isDiameter_iff_left_mem_and_pointReflection_center_left` (Mathlib)
- `ContinuousOn` (Mathlib)
- `RootPairing.reflection` (Mathlib)
- `IsLocalization.integerMultiple` (Mathlib)
- `Module.reflection` (Mathlib)
- `RootPairing.reflection` (Mathlib)
- `LinearMap.IsReflective.reflective_reflection` (Mathlib)
- `Equiv.pointReflection` (Mathlib)
- `IsStrictlyPositive` (Mathlib)
- `RootPairing.Base.IsPos.induction_on_reflect` (Mathlib)
- `RootPairing.RootPositiveForm.rootLength_reflectionPerm_self` (Mathlib)
- `SameRay` (Mathlib)
- `Equidecomp.witness` (Mathlib)
- `instFaithfulWitness` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problem2A1.AxialDirection`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem2A1.HalfCircleProjectionGeometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem2A1.HalfCylinderReflectionLaws`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem2A1.HalfCylindricalMirror`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem2A1.IsPositiveReflectionThreshold`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem2A1.LimitingRayWitness`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem2A1.MultipleReflectionExperiment`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem2A1.ObeysSpecularReflection`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem2A1.OnReflectingSemicircle`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem2A1.RepeatedReflectionClosure`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem2A1.SourceFigure`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

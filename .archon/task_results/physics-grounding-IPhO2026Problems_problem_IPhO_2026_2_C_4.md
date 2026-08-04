# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_4.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:2c7a9f8373071e52073eb05a6663d7d75976051ebe9547fda64060523fa71a5b
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Declaration Figure2gFrame`
- `Bundle.Trivialization.localFrame_coeff` | module `Mathlib.Geometry.Manifold.VectorBundle.LocalFrame` | package Mathlib | Coefficients of a section `s` of `V` w.r.t. the local frame `b.localFrame e i`. If x is outside of `e.baseSet`, this returns the junk value 0.
- `FrameHom` | module `Mathlib.Order.Hom.CompleteLattice` | package Mathlib | The type of frame homomorphisms from `α` to `β`. They preserve finite meets and arbitrary joins.
- `HahnSeries.leadingCoeff` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | A leading coefficient of a Hahn series is the coefficient of a lowest-order nonzero term, or zero if the series vanishes.

### Query: `Declaration ReflectedRayReadout`
- `SameRay` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | Two vectors are in the same ray if either one of them is zero or some positive multiples of them are equal (in the typical case over a field, this means one of them is a nonnegative multiple of the other).
- `Module.Ray` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | A ray (equivalence class of nonzero vectors with common positive multiples) in a module.
- `RayVector` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | Nonzero vectors, as used to define rays. This type depends on an unused argument `R` so that `RayVector.Setoid` can be an instance.

### Query: `Declaration reflectedLineYReadout`
- `AffineMap.lineMap` | module `Mathlib.LinearAlgebra.AffineSpace.AffineMap` | package Mathlib | The affine map from `k` to `P1` sending `0` to `p₀` and `1` to `p₁`.
- `Lean.Name.lineNumber` | module `Physlib.Meta.Basic` | package PhysLean | Given a name, returns the line number.
- `Physlib.HTMLNote.ofFormal` | module `Physlib.Meta.Notes.HTMLNote` | package PhysLean | An formal definition or lemma to html for a note.

### Query: `Declaration mirrorPointXReadout`
- `Polynomial.mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | mirror of a polynomial: reverses the coefficients while preserving `Polynomial.natDegree`
- `Equiv.pointReflection` | module `Mathlib.Algebra.Torsor.Defs` | package Mathlib | Point reflection in `x` as a permutation.
- `Polynomial.mirror_mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | **Involution of the Mirror Polynomial.** For any polynomial $p$, applying the mirror operation twice results in the original polynomial $p$.

### Query: `Declaration mirrorPointYReadout`
- `Polynomial.mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | mirror of a polynomial: reverses the coefficients while preserving `Polynomial.natDegree`
- `Equiv.pointReflection` | module `Mathlib.Algebra.Torsor.Defs` | package Mathlib | Point reflection in `x` as a permutation.
- `Polynomial.mirror_mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | **Involution of the Mirror Polynomial.** For any polynomial $p$, applying the mirror operation twice results in the original polynomial $p$.

### Query: `Declaration SatisfiesFigure2gReflectionLaw`
- `Module.invOn_reflection_of_mapsTo` | module `Mathlib.LinearAlgebra.Reflection` | package Mathlib | **Reflection as a Self-Inverse on a Set.** Given a module $M$ and a reflection map defined by an element $x$ and a linear form $f$ satisfying $f(x) = 2$, the reflection is its own inverse on any subset $\Phi$ of $M$.
- `Module.reflection_reflection_iterate` | module `Mathlib.LinearAlgebra.Reflection` | package Mathlib | Composite of reflections in "parallel" hyperplanes is a shear (special case).
- `Module.reflection` | module `Mathlib.LinearAlgebra.Reflection` | package Mathlib | Given an element `x` in a module `M` and a linear form `f` on `M` for which `f x = 2`, we define the endomorphism of `M` for which `y ↦ y - (f y) • x`. It is an involutive endomorphism of `M` fixing the kernel of `f`...

### Query: `Declaration FormsNeighboringRayCaustic`
- `SameRay` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | Two vectors are in the same ray if either one of them is zero or some positive multiples of them are equal (in the typical case over a field, this means one of them is a nonnegative multiple of the other).
- `Ioi_mem_nhdsSet_Ici_iff` | module `Mathlib.Topology.Order.NhdsSet` | package Mathlib | **Neighborhood of a Closed Ray.** In a linear order with an order-closed topology, the open ray $(a, \infty)$ is a neighborhood of the closed ray $[b, \infty)$ if and only if $a < b$.
- `Ici_mem_nhdsSet_Ici` | module `Mathlib.Topology.Order.NhdsSet` | package Mathlib | **Neighborhood of a Closed Ray.** In a linearly ordered topological space, if $a < b$, then the closed ray $[a, \infty)$ is a neighborhood of the closed ray $[b, \infty)$.

### Query: `Declaration HasPreviousPartC3Coordinates`
- `Part` | module `Mathlib.Data.Part` | package Mathlib | `Part α` is the type of "partial values" of type `α`. It is similar to `Option α` except the domain condition can be an arbitrary proposition, not necessarily decidable.
- `Part.hasFix` | module `Mathlib.Control.Fix` | package Mathlib | **Fixed-Point Operator for Partial Values.** The type of partial values of type $\alpha$ admits a fixed-point operator, where the fixed point of a function $f$ is defined by applying the underlying partial fixed-point...
- `TensorSpecies.Tensor.ComponentIdx.DropPairSection.mem_iff_apply_succSuccAbove_eq` | module `Physlib.Relativity.Tensors.ComponentIdx.Contraction` | package PhysLean | **Membership in the Drop-Pair Section.** For a sequence of types $c$ of length $n+2$ and two distinct indices $i, j$, let $b$ be a coordinate parameter for the sequence $c$ with the $i$-th and $j$-th entries removed....

### Query: `Declaration Figure2gCausticModel`
- `modelWithCornersSelf` | module `Mathlib.Geometry.Manifold.IsManifold.Basic` | package Mathlib | A vector space is a model with corners, denoted as `𝓘(𝕜, E)` within the `Manifold` namespace.
- `Manifold.Elab.findModels` | module `Mathlib.Geometry.Manifold.Notation` | package Mathlib | If the type of `e` is a non-dependent function between spaces `src` and `tgt`, try to find a model with corners on both `src` and `tgt`. If successful, return both models. We pass `e` instead of just its type for bett...
- `Mathlib.Tactic.ClickSuggestions.SectionKind.currFile` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | **Current File Section.** Within the classification of declaration sources, this represents the case where a declaration originates from the current file.

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `Bundle.Trivialization.localFrame_coeff` (Mathlib)
- `FrameHom` (Mathlib)
- `HahnSeries.leadingCoeff` (Mathlib)
- `SameRay` (Mathlib)
- `Module.Ray` (Mathlib)
- `RayVector` (Mathlib)
- `AffineMap.lineMap` (Mathlib)
- `Lean.Name.lineNumber` (PhysLean)
- `Physlib.HTMLNote.ofFormal` (PhysLean)
- `Polynomial.mirror` (Mathlib)
- `Equiv.pointReflection` (Mathlib)
- `Polynomial.mirror_mirror` (Mathlib)
- `Polynomial.mirror` (Mathlib)
- `Equiv.pointReflection` (Mathlib)
- `Polynomial.mirror_mirror` (Mathlib)
- `Module.invOn_reflection_of_mapsTo` (Mathlib)
- `Module.reflection_reflection_iterate` (Mathlib)
- `Module.reflection` (Mathlib)
- `SameRay` (Mathlib)
- `Ioi_mem_nhdsSet_Ici_iff` (Mathlib)
- `Ici_mem_nhdsSet_Ici` (Mathlib)
- `Part` (Mathlib)
- `Part.hasFix` (Mathlib)
- `TensorSpecies.Tensor.ComponentIdx.DropPairSection.mem_iff_apply_succSuccAbove_eq` (PhysLean)
- `modelWithCornersSelf` (Mathlib)
- `Manifold.Elab.findModels` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind.currFile` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problems.IPhO2026_2_C_4.CausticPowerLawParameters`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_4.Figure2gCausticModel`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_4.Figure2gFrame`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_4.FormsNeighboringRayCaustic`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_4.HasPreviousPartC3Coordinates`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_4.HasSmallAnglePowerLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_4.ReflectedRayReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_4.SatisfiesFigure2gReflectionLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

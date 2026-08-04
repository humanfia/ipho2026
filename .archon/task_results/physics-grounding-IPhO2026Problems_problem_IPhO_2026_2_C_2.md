# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_2.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:4e1f2a89ae586f6e0deb0c34b96c7b0dcd75598bc2a200b3165cdd4070c67bed
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `derivative at a point`
- `Polynomial.derivative` | module `Mathlib.Algebra.Polynomial.Derivative` | package Mathlib | `derivative p` is the formal derivative of the polynomial `p`
- `bernsteinPolynomial.iterate_derivative_at_1` | module `Mathlib.RingTheory.Polynomial.Bernstein` | package Mathlib | **The $(n-\nu)$-th Derivative of a Bernstein Polynomial at 1.** For a commutative ring $R$ and natural numbers $\nu \leq n$, the $(n-\nu)$-th iterative derivative of the Bernstein polynomial $B_{\nu, n}(X)$ evaluated...
- `derivWithin_zero_of_not_accPt` | module `Mathlib.Analysis.Calculus.Deriv.Basic` | package Mathlib | **Derivative at an Isolated Point.** If a point $x$ is not an accumulation point of a set $s$, then the derivative of any function $f$ within $s$ at $x$ is zero.

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Declaration Point2D`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `HahnSeries.order` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The order of a nonzero Hahn series `x` is a minimal element of `Γ` where `x` has a nonzero coefficient, the order of 0 is 0.
- `HahnSeries.single` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | `single a r` is the Hahn series which has coefficient `r` at `a` and zero otherwise.

### Query: `Declaration Direction2D`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `Space.Direction` | module `Physlib.SpaceAndTime.Space.Module` | package PhysLean | Notion of direction where `unit` returns a unit vector in the direction specified.
- `AffineSubspace.direction` | module `Mathlib.LinearAlgebra.AffineSpace.AffineSubspace.Defs` | package Mathlib | The direction of an affine subspace is the submodule spanned by the pairwise differences of points. (Except in the case of an empty affine subspace, where the direction is the zero submodule, every vector in the direc...

### Query: `Declaration verticalIncomingDirection`
- `AffineSubspace.direction` | module `Mathlib.LinearAlgebra.AffineSpace.AffineSubspace.Defs` | package Mathlib | The direction of an affine subspace is the submodule spanned by the pairwise differences of points. (Except in the case of an empty affine subspace, where the direction is the zero submodule, every vector in the direc...
- `Space.Direction` | module `Physlib.SpaceAndTime.Space.Module` | package PhysLean | Notion of direction where `unit` returns a unit vector in the direction specified.
- `Combinatorics.Line.vertical` | module `Mathlib.Combinatorics.HalesJewett` | package Mathlib | A point in `ι → α` and a line in `ι' → α` determine a line in `ι ⊕ ι' → α`.

### Query: `Declaration AffineLineReadout`
- `AffineMap.lineMap` | module `Mathlib.LinearAlgebra.AffineSpace.AffineMap` | package Mathlib | The affine map from `k` to `P1` sending `0` to `p₀` and `1` to `p₁`.
- `AffineMap.lineMap_apply_module'` | module `Mathlib.LinearAlgebra.AffineSpace.AffineMap` | package Mathlib | **Affine Line Map Formula.** For any two points $p_0$ and $p_1$ in a module over a ring $k$, the affine line map evaluated at a scalar $c$ is given by $c \cdot (p_1 - p_0) + p_0$.
- `AffineMap.lineMap_apply` | module `Mathlib.LinearAlgebra.AffineSpace.AffineMap` | package Mathlib | **Evaluation of the Affine Line Map.** For any two points $p_0$ and $p_1$ in an affine space and a scalar $c$ from the underlying ring, the value of the line map at $c$ is given by $c \cdot (p_1 - p_0) + p_0$.

### Query: `Declaration Figure2gRayLabel`
- `SameRay` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | Two vectors are in the same ray if either one of them is zero or some positive multiples of them are equal (in the typical case over a field, this means one of them is a nonnegative multiple of the other).
- `Module.Ray` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | A ray (equivalence class of nonzero vectors with common positive multiples) in a module.
- `RayVector` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | Nonzero vectors, as used to define rays. This type depends on an unused argument `R` so that `RayVector.Setoid` can be an instance.

### Query: `Declaration OpticalRay2D`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `Orientation.nonneg_inner_and_areaForm_eq_zero_iff_sameRay` | module `Mathlib.Analysis.InnerProductSpace.TwoDim` | package Mathlib | **Same Ray Condition in Two Dimensions.** For any two vectors $x$ and $y$ in an oriented two-dimensional inner product space, $x$ and $y$ lie on the same ray if and only if their inner product is non-negative and the...
- `Orientation.oangle_eq_zero_iff_sameRay` | module `Mathlib.Geometry.Euclidean.Angle.Oriented.Basic` | package Mathlib | The oriented angle between two vectors is zero if and only if they are on the same ray.

### Query: `Declaration HalfCylindricalMirror`
- `Polynomial.mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | mirror of a polynomial: reverses the coefficients while preserving `Polynomial.natDegree`
- `Polynomial.mirror_mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | **Involution of the Mirror Polynomial.** For any polynomial $p$, applying the mirror operation twice results in the original polynomial $p$.
- `Polynomial.mirror_zero` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | **Mirror of the Zero Polynomial.** The mirror of the zero polynomial is equal to the zero polynomial.

### Query: `Declaration OnUpperSemicircle`
- `UpperSemicontinuousOn` | module `Mathlib.Topology.Semicontinuity.Defs` | package Mathlib | A real function `f` is upper semicontinuous on a set `s` if, for any `ε > 0`, for any `x ∈ s`, for all `x'` close enough to `x` in `s`, then `f x'` is at most `f x + ε`. We formulate this in a general preordered space...
- `Mathlib.Linter.linter.upstreamableDecl` | module `Mathlib.Tactic.Linter.UpstreamableDecl` | package Mathlib | The `upstreamableDecl` linter detects declarations that could be moved to a file higher up in the import hierarchy. If this is the case, it emits a warning. By default, this linter will not fire on definitions, nor pr...
- `upperClosure` | module `Mathlib.Order.UpperLower.Closure` | package Mathlib | The greatest upper set containing a given set.

## Grounded Mathlib/PhysLean names

- `Polynomial.derivative` (Mathlib)
- `bernsteinPolynomial.iterate_derivative_at_1` (Mathlib)
- `derivWithin_zero_of_not_accPt` (Mathlib)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `HahnSeries.order` (Mathlib)
- `HahnSeries.single` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `Space.Direction` (PhysLean)
- `AffineSubspace.direction` (Mathlib)
- `AffineSubspace.direction` (Mathlib)
- `Space.Direction` (PhysLean)
- `Combinatorics.Line.vertical` (Mathlib)
- `AffineMap.lineMap` (Mathlib)
- `AffineMap.lineMap_apply_module'` (Mathlib)
- `AffineMap.lineMap_apply` (Mathlib)
- `SameRay` (Mathlib)
- `Module.Ray` (Mathlib)
- `RayVector` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `Orientation.nonneg_inner_and_areaForm_eq_zero_iff_sameRay` (Mathlib)
- `Orientation.oangle_eq_zero_iff_sameRay` (Mathlib)
- `Polynomial.mirror` (Mathlib)
- `Polynomial.mirror_mirror` (Mathlib)
- `Polynomial.mirror_zero` (Mathlib)
- `UpperSemicontinuousOn` (Mathlib)
- `Mathlib.Linter.linter.upstreamableDecl` (Mathlib)
- `upperClosure` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problems.IPhO2026_2_C_2.AffineLineReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_2.AffineLineReadout.Contains`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_2.Direction2D`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_2.Figure2gRayLabel`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_2.HalfCylindricalMirror`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_2.HasFigure2gGeometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_2.HaveParallelIncomingDirections`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_2.OnUpperSemicircle`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_2.OpticalRay2D`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_2.Point2D`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_2.SatisfiesHalfCylindricalSpecularLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_2.SatisfiesPreviousPartC1`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

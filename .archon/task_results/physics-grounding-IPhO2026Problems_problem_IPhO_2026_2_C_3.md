# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_2_C_3.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_3.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:0fb15e3a28da5ce5b8b0bbe288e9f99d85abed2b470bc429ebe564815ed26db5
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

### Query: `Declaration PlanarPoint`
- `OnePoint` | module `Mathlib.Topology.Compactification.OnePoint.Basic` | package Mathlib | The one-point extension of an arbitrary topological space `X`
- `Equiv.pointReflection` | module `Mathlib.Algebra.Torsor.Defs` | package Mathlib | Point reflection in `x` as a permutation.
- `coplanar_singleton` | module `Mathlib.LinearAlgebra.AffineSpace.FiniteDimensional` | package Mathlib | A single point is coplanar.

### Query: `Declaration xCoord`
- `Bundle.Trivialization.coordChangeL` | module `Mathlib.Topology.VectorBundle.Basic` | package Mathlib | A coordinate change function between two trivializations, as a continuous linear equivalence. Defined to be the identity when `b` does not lie in the base set of both trivializations.
- `polarCoord` | module `Mathlib.Analysis.SpecialFunctions.PolarCoord` | package Mathlib | The polar coordinates are an open partial homeomorphism in `ℝ^2`, mapping `(r cos θ, r sin θ)` to `(r, θ)`. It is a homeomorphism between `ℝ^2 - (-∞, 0]` and `(0, +∞) × (-π, π)`.
- `Polynomial.X` | module `Mathlib.Algebra.Polynomial.Basic` | package Mathlib | `X` is the polynomial variable (aka indeterminate).

### Query: `Declaration yCoord`
- `WeierstrassCurve.Projective.negY` | module `Mathlib.AlgebraicGeometry.EllipticCurve.Projective.Formula` | package Mathlib | The `Y`-coordinate of a representative of `-P` for a projective point representative `P` on a Weierstrass curve.
- `WeierstrassCurve.Jacobian.negY` | module `Mathlib.AlgebraicGeometry.EllipticCurve.Jacobian.Formula` | package Mathlib | The `Y`-coordinate of a representative of `-P` for a Jacobian point representative `P` on a Weierstrass curve.
- `WeierstrassCurve.Projective.negY_eq` | module `Mathlib.AlgebraicGeometry.EllipticCurve.Projective.Formula` | package Mathlib | **Negation of the Y-coordinate.** For a projective point represented by the coordinates $(X, Y, Z)$ on a Weierstrass curve with coefficients $a_1$ and $a_3$, the $Y$-coordinate of its negation is given by $-Y - a_1 X...

### Query: `Declaration xCoord planarPoint`
- `WeierstrassCurve.Affine.Point.xRep_zero` | module `Mathlib.AlgebraicGeometry.EllipticCurve.Affine.Point` | package Mathlib | **Projective Representative of the Zero Point's x-coordinate.** The projective representative of the $x$-coordinate for the zero point on an affine Weierstrass curve is given by the vector $[1, 0]$.
- `Bundle.Trivialization.coordChangeL` | module `Mathlib.Topology.VectorBundle.Basic` | package Mathlib | A coordinate change function between two trivializations, as a continuous linear equivalence. Defined to be the identity when `b` does not lie in the base set of both trivializations.
- `Bundle.Trivialization.coordChange` | module `Mathlib.Topology.FiberBundle.Trivialization` | package Mathlib | Coordinate transformation in the fiber induced by a pair of bundle trivializations. See also `Bundle.Trivialization.coordChangeHomeomorph` for a version bundled as `F ≃ₜ F`.

### Query: `Declaration yCoord planarPoint`
- `WeierstrassCurve.Projective.negY` | module `Mathlib.AlgebraicGeometry.EllipticCurve.Projective.Formula` | package Mathlib | The `Y`-coordinate of a representative of `-P` for a projective point representative `P` on a Weierstrass curve.
- `WeierstrassCurve.Projective.negY_eq` | module `Mathlib.AlgebraicGeometry.EllipticCurve.Projective.Formula` | package Mathlib | **Negation of the Y-coordinate.** For a projective point represented by the coordinates $(X, Y, Z)$ on a Weierstrass curve with coefficients $a_1$ and $a_3$, the $Y$-coordinate of its negation is given by $-Y - a_1 X...
- `WeierstrassCurve.Projective.negDblY` | module `Mathlib.AlgebraicGeometry.EllipticCurve.Projective.Formula` | package Mathlib | The `Y`-coordinate of a representative of `-(2 • P)` for a projective point representative `P` on a Weierstrass curve.

### Query: `Declaration OrientedRay2D`
- `Module.Oriented` | module `Mathlib.LinearAlgebra.Orientation` | package Mathlib | A type class fixing an orientation of a module.
- `Orientation.oangle` | module `Mathlib.Geometry.Euclidean.Angle.Oriented.Basic` | package Mathlib | The oriented angle from `x` to `y`, modulo `2 * π`. If either vector is 0, this is 0. See `InnerProductGeometry.angle` for the corresponding unoriented angle definition.
- `Orientation.oangle_eq_zero_iff_sameRay` | module `Mathlib.Geometry.Euclidean.Angle.Oriented.Basic` | package Mathlib | The oriented angle between two vectors is zero if and only if they are on the same ray.

### Query: `Declaration OrientedRay2D.Contains`
- `Orientation.nonneg_inner_and_areaForm_eq_zero_iff_sameRay` | module `Mathlib.Analysis.InnerProductSpace.TwoDim` | package Mathlib | **Same Ray Condition in Two Dimensions.** For any two vectors $x$ and $y$ in an oriented two-dimensional inner product space, $x$ and $y$ lie on the same ray if and only if their inner product is non-negative and the...
- `Module.Oriented` | module `Mathlib.LinearAlgebra.Orientation` | package Mathlib | A type class fixing an orientation of a module.
- `IsEmpty.oriented` | module `Mathlib.LinearAlgebra.Orientation` | package Mathlib | A module is canonically oriented with respect to an empty index type.

### Query: `Declaration IsAdmissibleAngle`
- `Real.Angle.induction_on` | module `Mathlib.Analysis.SpecialFunctions.Trigonometric.Angle` | package Mathlib | An induction principle to deduce results for `Angle` from those for `ℝ`, used with `induction θ using Real.Angle.induction_on`.
- `EuclideanGeometry.angle` | module `Mathlib.Geometry.Euclidean.Angle.Unoriented.Affine` | package Mathlib | The undirected angle at `p₂` between the line segments to `p₁` and `p₃`. If either of those points equals `p₂`, this is π/2. Use `open scoped EuclideanGeometry` to access the `∠ p₁ p₂ p₃` notation.
- `AbsoluteValue.IsAdmissible` | module `Mathlib.NumberTheory.ClassNumber.AdmissibleAbsoluteValue` | package Mathlib | An absolute value `R → ℤ` is admissible if it respects the Euclidean domain structure and a large enough set of elements in `R^n` will contain a pair of elements whose remainders are pointwise close together.

## Grounded Mathlib/PhysLean names

- `EuclideanSpace` (Mathlib)
- `Space.fderiv_space_components` (PhysLean)
- `Lorentz.ContrMod.toSpace` (PhysLean)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `OnePoint` (Mathlib)
- `Equiv.pointReflection` (Mathlib)
- `coplanar_singleton` (Mathlib)
- `Bundle.Trivialization.coordChangeL` (Mathlib)
- `polarCoord` (Mathlib)
- `Polynomial.X` (Mathlib)
- `WeierstrassCurve.Projective.negY` (Mathlib)
- `WeierstrassCurve.Jacobian.negY` (Mathlib)
- `WeierstrassCurve.Projective.negY_eq` (Mathlib)
- `WeierstrassCurve.Affine.Point.xRep_zero` (Mathlib)
- `Bundle.Trivialization.coordChangeL` (Mathlib)
- `Bundle.Trivialization.coordChange` (Mathlib)
- `WeierstrassCurve.Projective.negY` (Mathlib)
- `WeierstrassCurve.Projective.negY_eq` (Mathlib)
- `WeierstrassCurve.Projective.negDblY` (Mathlib)
- `Module.Oriented` (Mathlib)
- `Orientation.oangle` (Mathlib)
- `Orientation.oangle_eq_zero_iff_sameRay` (Mathlib)
- `Orientation.nonneg_inner_and_areaForm_eq_zero_iff_sameRay` (Mathlib)
- `Module.Oriented` (Mathlib)
- `IsEmpty.oriented` (Mathlib)
- `Real.Angle.induction_on` (Mathlib)
- `EuclideanGeometry.angle` (Mathlib)
- `AbsoluteValue.IsAdmissible` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problems.IPhO2026_2_C_3.Figure2gOptics`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.HasFigure2gFirstOrderExpansions`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.IsAdmissibleAngle`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.IsNeighboringReflectedIntersection`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.LiesOnReflectedSupport`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.OnUpperSemicircularMirror`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.OrientedRay2D`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.OrientedRay2D.Contains`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.PlanarPoint`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

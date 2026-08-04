# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_2_C_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_1.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:b0589c03baced0c2493cbdfe1c5749b74669f807510f9de1181eb4b9fdbd5507
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Half-cylindrical mirror reflection`
- `EuclideanGeometry.Sphere.IsDiameter.pointReflection_center_right` | module `Mathlib.Geometry.Euclidean.Sphere.Basic` | package Mathlib | **Point Reflection of a Diameter Endpoint.** If two points $p_1$ and $p_2$ form a diameter of a sphere $s$, then the reflection of $p_2$ across the center of $s$ is equal to $p_1$.
- `Equiv.pointReflection` | module `Mathlib.Algebra.Torsor.Defs` | package Mathlib | Point reflection in `x` as a permutation.
- `Polynomial.mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | mirror of a polynomial: reverses the coefficients while preserving `Polynomial.natDegree`

### Query: `The reflected intercept is a length`
- `AffineIsometryEquiv.dist_pointReflection_self_real` | module `Mathlib.Analysis.Normed.Affine.Isometry` | package Mathlib | **Distance to a Point Reflection.** In a normed affine space over the real numbers, the distance between the reflection of a point $y$ across a center $x$ and the point $y$ itself is equal to twice the distance betwee...
- `AffineIsometryEquiv.dist_pointReflection_self` | module `Mathlib.Analysis.Normed.Affine.Isometry` | package Mathlib | **Distance from a Point to its Reflection.** In a normed affine space over a normed field $\mathbb{k}$, the distance between the reflection of a point $y$ across a center $x$ and the point $y$ itself is equal to the n...
- `CoxeterSystem.IsReflection.odd_length` | module `Mathlib.GroupTheory.Coxeter.Inversion` | package Mathlib | **Parity of Reflection Length.** In a Coxeter system, the length of any reflection is an odd number.

### Query: `Slope of the reflected ray A`
- `slope` | module `Mathlib.LinearAlgebra.AffineSpace.Slope` | package Mathlib | `slope f a b = (b - a)⁻¹ • (f b -ᵥ f a)` is the slope of a function `f` on the interval `[a, b]`. Note that `slope f a a = 0`, not the derivative of `f` at `a`.
- `EuclideanGeometry.oangle_pointReflection_right` | module `Mathlib.Geometry.Euclidean.Angle.Oriented.Affine` | package Mathlib | **Oriented Angle under Point Reflection of the Second Ray.** For any three points $p_1, p_2, p_3$ in a Euclidean geometry such that $p_1 \neq p_2$ and $p_3 \neq p_2$, the oriented angle $\measuredangle p_1 p_2 p_3'$ f...
- `pos_of_slope_pos` | module `Mathlib.LinearAlgebra.AffineSpace.Ordered` | package Mathlib | **Positivity from Positive Slope.** Let $k$ be a linearly ordered field. For a function $f: k \to k$ and points $x_0, b \in k$ such that $x_0 < b$, if the slope of $f$ between $x_0$ and $b$ is positive and $f(x_0) = 0...

### Query: `Intercept of the reflected ray A`
- `SameRay` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | Two vectors are in the same ray if either one of them is zero or some positive multiples of them are equal (in the typical case over a field, this means one of them is a nonnegative multiple of the other).
- `rayOfNeZero` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | The ray given by a nonzero vector.
- `EuclideanGeometry.angle_pointReflection_right` | module `Mathlib.Geometry.Euclidean.Angle.Unoriented.Affine` | package Mathlib | **Angle with a Point Reflected across the Vertex.** For any three points $p_1, p_2$, and $p_3$ in a Euclidean space, the angle $\angle p_1 p_2 p_3'$ formed by $p_1$, $p_2$, and the reflection $p_3'$ of $p_3$ across $p...

### Query: `Slope and intercept of the reflected ray A`
- `slope` | module `Mathlib.LinearAlgebra.AffineSpace.Slope` | package Mathlib | `slope f a b = (b - a)⁻¹ • (f b -ᵥ f a)` is the slope of a function `f` on the interval `[a, b]`. Note that `slope f a a = 0`, not the derivative of `f` at `a`.
- `ContinuousAffineEquiv.pointReflection_apply` | module `Mathlib.Topology.Algebra.ContinuousAffineEquiv` | package Mathlib | **Point Reflection Formula.** For any points $x$ and $y$ in an affine space over a topological ring $k$, the reflection of $y$ across the center $x$ is given by the point $(x - y) + x$.
- `pos_of_slope_pos` | module `Mathlib.LinearAlgebra.AffineSpace.Ordered` | package Mathlib | **Positivity from Positive Slope.** Let $k$ be a linearly ordered field. For a function $f: k \to k$ and points $x_0, b \in k$ such that $x_0 < b$, if the slope of $f$ between $x_0$ and $b$ is positive and $f(x_0) = 0...

### Query: `Half Cylindrical Mirror Reflection`
- `EuclideanGeometry.Sphere.IsDiameter.pointReflection_center_right` | module `Mathlib.Geometry.Euclidean.Sphere.Basic` | package Mathlib | **Point Reflection of a Diameter Endpoint.** If two points $p_1$ and $p_2$ form a diameter of a sphere $s$, then the reflection of $p_2$ across the center of $s$ is equal to $p_1$.
- `Equiv.pointReflection` | module `Mathlib.Algebra.Torsor.Defs` | package Mathlib | Point reflection in `x` as a permutation.
- `Polynomial.mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | mirror of a polynomial: reverses the coefficients while preserving `Polynomial.natDegree`

### Query: `intercept is length`
- `Interval.length` | module `Mathlib.Algebra.Order.Interval.Basic` | package Mathlib | The length of an interval is its first component minus its second component. This measures the accuracy of the approximation by an interval.
- `IsFiniteLength` | module `Mathlib.RingTheory.FiniteLength` | package Mathlib | A module of finite length is either trivial or a simple extension of a module known to be of finite length.
- `NonemptyInterval.length` | module `Mathlib.Algebra.Order.Interval.Basic` | package Mathlib | The length of an interval is its first component minus its second component. This measures the accuracy of the approximation by an interval.

### Query: `reflected ray A slope`
- `slope` | module `Mathlib.LinearAlgebra.AffineSpace.Slope` | package Mathlib | `slope f a b = (b - a)⁻¹ • (f b -ᵥ f a)` is the slope of a function `f` on the interval `[a, b]`. Note that `slope f a a = 0`, not the derivative of `f` at `a`.
- `LinearMap.IsReflective.reflective_reflection` | module `Mathlib.LinearAlgebra.RootSystem.OfBilinear` | package Mathlib | **Reflectivity of Reflected Vectors.** Let $B$ be a symmetric bilinear form on a module $M$. If $x$ and $y$ are reflective vectors with respect to $B$, then the reflection of $y$ across the hyperplane orthogonal to $x...
- `slope_comm` | module `Mathlib.LinearAlgebra.AffineSpace.Slope` | package Mathlib | **Symmetry of the Slope.** For a function $f$ from a field to an affine space, the slope between any two points $a$ and $b$ is symmetric; that is, the slope of $f$ at $a$ and $b$ is equal to the slope of $f$ at $b$ an...

### Query: `reflected ray A intercept`
- `SameRay` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | Two vectors are in the same ray if either one of them is zero or some positive multiples of them are equal (in the typical case over a field, this means one of them is a nonnegative multiple of the other).
- `RayVector` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | Nonzero vectors, as used to define rays. This type depends on an unused argument `R` so that `RayVector.Setoid` can be an instance.
- `EuclideanGeometry.angle_pointReflection_right` | module `Mathlib.Geometry.Euclidean.Angle.Unoriented.Affine` | package Mathlib | **Angle with a Point Reflected across the Vertex.** For any three points $p_1, p_2$, and $p_3$ in a Euclidean space, the angle $\angle p_1 p_2 p_3'$ formed by $p_1$, $p_2$, and the reflection $p_3'$ of $p_3$ across $p...

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `EuclideanGeometry.Sphere.IsDiameter.pointReflection_center_right` (Mathlib)
- `Equiv.pointReflection` (Mathlib)
- `Polynomial.mirror` (Mathlib)
- `AffineIsometryEquiv.dist_pointReflection_self_real` (Mathlib)
- `AffineIsometryEquiv.dist_pointReflection_self` (Mathlib)
- `CoxeterSystem.IsReflection.odd_length` (Mathlib)
- `slope` (Mathlib)
- `EuclideanGeometry.oangle_pointReflection_right` (Mathlib)
- `pos_of_slope_pos` (Mathlib)
- `SameRay` (Mathlib)
- `rayOfNeZero` (Mathlib)
- `EuclideanGeometry.angle_pointReflection_right` (Mathlib)
- `slope` (Mathlib)
- `ContinuousAffineEquiv.pointReflection_apply` (Mathlib)
- `pos_of_slope_pos` (Mathlib)
- `EuclideanGeometry.Sphere.IsDiameter.pointReflection_center_right` (Mathlib)
- `Equiv.pointReflection` (Mathlib)
- `Polynomial.mirror` (Mathlib)
- `Interval.length` (Mathlib)
- `IsFiniteLength` (Mathlib)
- `NonemptyInterval.length` (Mathlib)
- `slope` (Mathlib)
- `LinearMap.IsReflective.reflective_reflection` (Mathlib)
- `slope_comm` (Mathlib)
- `SameRay` (Mathlib)
- `RayVector` (Mathlib)
- `EuclideanGeometry.angle_pointReflection_right` (Mathlib)

## Local abstractions introduced

- `IPhO2026_2_C_1.HalfCylindricalMirrorReflection`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

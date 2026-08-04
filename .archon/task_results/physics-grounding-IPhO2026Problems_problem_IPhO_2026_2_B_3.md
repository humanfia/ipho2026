# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_2_B_3.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_3.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:d9285f91bb5a5d72767810f157acef81ef17a4e57b6803ddba04015b4ec4f663
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

### Query: `Recorded incidence angle`
- `Real.Angle.toReal_le_pi` | module `Mathlib.Analysis.SpecialFunctions.Trigonometric.Angle` | package Mathlib | **Upper Bound of the Real Representative of an Angle.** For any angle $\theta$, its representative in the interval $(-\pi, \pi]$ is always less than or equal to $\pi$.
- `EuclideanGeometry.angle` | module `Mathlib.Geometry.Euclidean.Angle.Unoriented.Affine` | package Mathlib | The undirected angle at `p₂` between the line segments to `p₁` and `p₃`. If either of those points equals `p₂`, this is π/2. Use `open scoped EuclideanGeometry` to access the `∠ p₁ p₂ p₃` notation.
- `IncidenceAlgebra` | module `Mathlib.Combinatorics.Enumerative.IncidenceAlgebra` | package Mathlib | The `𝕜`-incidence algebra over `α`.

### Query: `Metre in centimetres`
- `RecursiveIn` | module `Mathlib.Computability.RecursiveIn` | package Mathlib | A partial function `f : α →. σ` between `Primcodable` types is recursive in a set of oracles `O` if its encoding as a function `ℕ →. ℕ` is `Nat.RecursiveIn O`.
- `JoinedIn` | module `Mathlib.Topology.Connected.PathConnected` | package Mathlib | The relation "being joined by a path in `F`". Not quite an equivalence relation since it's not reflexive for points that do not belong to `F`.
- `LengthUnit.centimeters` | module `Physlib.SpaceAndTime.Space.LengthUnit` | package PhysLean | The length unit of centimeters (10⁻² of a meter).

### Query: `Cross-sectional plane`
- `crossProduct` | module `Mathlib.LinearAlgebra.CrossProduct` | package Mathlib | The cross product of two vectors in $R^3$ for $R$ a commutative ring.
- `ClassicalMechanics.crossProduct_time_differentiable_of_right_eq_planewave` | module `Physlib.ClassicalMechanics.WaveEquation.Basic` | package PhysLean | **Differentiability of the Cross Product with a Plane Wave.** Let $s$ be a unit direction vector and $f_0: \mathbb{R} \to \mathbb{R}^3$ be a differentiable function. If $f(t, x)$ is a plane wave defined by the initial...
- `cross_cross` | module `Mathlib.LinearAlgebra.CrossProduct` | package Mathlib | **Vector Triple Product Identity.** For any three vectors $u, v, w \in R^3$ over a commutative ring $R$, the iterated cross product satisfies the identity $u \times (v \times w) = u \times (v \times w) - v \times (u \...

### Query: `Solar cooker geometry`
- `MassUnit.nominalSolarMasses` | module `Physlib.ClassicalMechanics.Mass.MassUnit` | package PhysLean | The mass unit of nominal solar masses (1.988416 × 10 ^ 30 kilograms). See: https://iopscience.iop.org/article/10.3847/0004-6256/152/2/41
- `EuclideanGeometry.oangle` | module `Mathlib.Geometry.Euclidean.Angle.Oriented.Affine` | package Mathlib | The oriented angle at `p₂` between the line segments to `p₁` and `p₃`, modulo `2 * π`. If either of those points equals `p₂`, this is 0. See `EuclideanGeometry.angle` for the corresponding unoriented angle definition.
- `Cosmology.SpatialGeometry` | module `Physlib.Cosmology.FLRW.Basic` | package PhysLean | The inductive type with three constructors: - `Spherical (k : ℝ)` - `Flat` - `Saddle (k : ℝ)`

### Query: `Half-cylindrical mirror physics`
- `Polynomial.mirror_eq_iff` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | **Mirror Symmetry of Polynomials.** For any two polynomials $p$ and $q$, the mirror of $p$ is equal to $q$ if and only if $p$ is equal to the mirror of $q$.
- `UpperHalfPlane` | module `Mathlib.Analysis.Complex.UpperHalfPlane.Basic` | package Mathlib | The open upper half plane, denoted as `ℍ` within the `UpperHalfPlane` namespace
- `Polynomial.mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | mirror of a polynomial: reverses the coefficients while preserving `Polynomial.natDegree`

### Query: `Previous-part results (B.1 and B.2 interfaces)`
- `Part.inter_def` | module `Mathlib.Data.Part` | package Mathlib | **Intersection of Partial Values.** The intersection of two partial values $a$ and $b$ is defined as the result of binding $a$ to a function that maps the intersection operation with the value of $a$ over $b$. Specifi...
- `CategoryTheory.PreOneHypercover.interSnd` | module `Mathlib.CategoryTheory.Sites.Hypercover.One` | package Mathlib | Second projection from the intersection of two pre-`1`-hypercovers.
- `Int.gcdB` | module `Mathlib.Data.Int.GCD` | package Mathlib | The extended GCD `b` value in the equation `gcd x y = x * a + y * b`.

### Query: `The recorded angle is acute`
- `EuclideanGeometry.angle` | module `Mathlib.Geometry.Euclidean.Angle.Unoriented.Affine` | package Mathlib | The undirected angle at `p₂` between the line segments to `p₁` and `p₃`. If either of those points equals `p₂`, this is π/2. Use `open scoped EuclideanGeometry` to access the `∠ p₁ p₂ p₃` notation.
- `Affine.Triangle.acuteAngled_iff_angle_lt` | module `Mathlib.Geometry.Euclidean.Simplex` | package Mathlib | **Acute Triangle Condition.** A triangle is acute-angled if and only if all three of its interior angles are strictly less than $\pi/2$. Specifically, for a triangle with vertices $p_0, p_1,$ and $p_2$, this condition...
- `Affine.Simplex.AcuteAngled` | module `Mathlib.Geometry.Euclidean.Simplex` | package Mathlib | The property of all angles of a simplex being acute.

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
- `Real.Angle.toReal_le_pi` (Mathlib)
- `EuclideanGeometry.angle` (Mathlib)
- `IncidenceAlgebra` (Mathlib)
- `RecursiveIn` (Mathlib)
- `JoinedIn` (Mathlib)
- `LengthUnit.centimeters` (PhysLean)
- `crossProduct` (Mathlib)
- `ClassicalMechanics.crossProduct_time_differentiable_of_right_eq_planewave` (PhysLean)
- `cross_cross` (Mathlib)
- `MassUnit.nominalSolarMasses` (PhysLean)
- `EuclideanGeometry.oangle` (Mathlib)
- `Cosmology.SpatialGeometry` (PhysLean)
- `Polynomial.mirror_eq_iff` (Mathlib)
- `UpperHalfPlane` (Mathlib)
- `Polynomial.mirror` (Mathlib)
- `Part.inter_def` (Mathlib)
- `CategoryTheory.PreOneHypercover.interSnd` (Mathlib)
- `Int.gcdB` (Mathlib)
- `EuclideanGeometry.angle` (Mathlib)
- `Affine.Triangle.acuteAngled_iff_angle_lt` (Mathlib)
- `Affine.Simplex.AcuteAngled` (Mathlib)

## Local abstractions introduced

- `CrossSectionPlane`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `HalfCylindricalMirrorPhysics`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `PreviousPartResults`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `SolarCookerGeometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

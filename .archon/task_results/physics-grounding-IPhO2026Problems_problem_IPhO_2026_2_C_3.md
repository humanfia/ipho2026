# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_2_C_3.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_3.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:a283ce490ac6871ab1a59f98c3ab7389931bbbafc445a4f5550fc991930dae92
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Physical length`
- `CanonicalEnsemble.physicalProbability` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Basic` | package PhysLean | The dimensionless physical probability density. This is is the probability density w.r.t. the measure, obtained by dividing the phase space measure by the fundamental unit `h^dof`, making the probability density `ρ_ph...
- `Dimension` | module `Physlib.Units.Dimension` | package PhysLean | The foundational dimensions. Defined in the order ⟨length, time, mass, charge, temperature⟩
- `Dimension.L𝓭_length` | module `Physlib.Units.Dimension` | package PhysLean | **Length Dimension Component.** The length component of the fundamental physical dimension for length is equal to 1.

### Query: `Figure-2g length projection`
- `Submodule.projection` | module `Mathlib.LinearAlgebra.Projection` | package Mathlib | The linear projection onto a subspace along its complement as a map from the full space to itself, as opposed to `Submodule.projectionOnto`, which maps into the subtype. This version is important as it satisfies `IsId...
- `CategoryTheory.Functor.PullbackObjObj.ofHasPullback_snd` | module `Mathlib.CategoryTheory.Limits.Shapes.Pullback.PullbackObjObj` | package Mathlib | **Second Projection of a Pullback Object.** Given a bifunctor $G : \mathcal{C}_1^{\text{op}} \times \mathcal{C}_3 \to \mathcal{C}_2$ and morphisms $f_1 : X_1 \to Y_1$ and $f_3 : X_3 \to Y_3$, this definition provides...
- `Simps.ProjectionRule` | module `Mathlib.Tactic.Simps.Basic` | package Mathlib | The type of rules that specify how metadata for projections in changes. See `initialize_simps_projections`.

### Query: `Half-cylindrical mirror of Figure 2g`
- `Polynomial.mirror_mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | **Involution of the Mirror Polynomial.** For any polynomial $p$, applying the mirror operation twice results in the original polynomial $p$.
- `UpperHalfPlane` | module `Mathlib.Analysis.Complex.UpperHalfPlane.Basic` | package Mathlib | The open upper half plane, denoted as `ℍ` within the `UpperHalfPlane` namespace
- `EuclideanGeometry.Sphere.IsDiameter.pointReflection_center_right` | module `Mathlib.Geometry.Euclidean.Sphere.Basic` | package Mathlib | **Point Reflection of a Diameter Endpoint.** If two points $p_1$ and $p_2$ form a diameter of a sphere $s$, then the reflection of $p_2$ across the center of $s$ is equal to $p_1$.

### Query: `Point of Figure 2g`
- `OnePoint` | module `Mathlib.Topology.Compactification.OnePoint.Basic` | package Mathlib | The one-point extension of an arbitrary topological space `X`
- `Locale.localePointOfSpacePoint` | module `Mathlib.Topology.Order.Category.FrameAdjunction` | package Mathlib | The unit of the adjunction between locales and topological spaces, which associates with a point `x` of the space `X` a point of the locale of opens of `X`.
- `TwoPointing.pi_snd` | module `Mathlib.Data.TwoPointing` | package Mathlib | **Second component of a product two-pointing.** The second distinguished element of the two-pointing on the function space $\alpha \to \beta$ (induced by a two-pointing $q$ on $\beta$) is the constant function that ma...

### Query: `Supporting line of a reflected ray`
- `SameRay` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | Two vectors are in the same ray if either one of them is zero or some positive multiples of them are equal (in the typical case over a field, this means one of them is a nonnegative multiple of the other).
- `rayOfNeZero` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | The ray given by a nonzero vector.
- `Polynomial.reflect_support` | module `Mathlib.Algebra.Polynomial.Reverse` | package Mathlib | **Support of a Reflected Polynomial.** For any polynomial $f$ and natural number $N$, the support of the reflection of $f$ at $N$ is the image of the support of $f$ under the reversal map $i \mapsto N - i$.

### Query: `Intersection of neighboring reflected rays`
- `ofColex` | module `Mathlib.Order.Lex` | package Mathlib | `ofColex` is the identity function from the `Colex` of a type.
- `RootPairing.isOrthogonal_comm` | module `Mathlib.LinearAlgebra.RootSystem.Defs` | package Mathlib | **Commutativity of Orthogonal Reflections.** In a root pairing, if two roots are orthogonal, then their associated reflections commute.
- `Set.Iio_inter_Ioi` | module `Mathlib.Order.Interval.Set.Basic` | package Mathlib | **Intersection of Open Rays.** The intersection of the open upper ray $(a, \infty)$ and the open lower ray $(-\infty, b)$ is equal to the open interval $(a, b)$.

### Query: `Limiting intersection of neighboring reflected rays`
- `CategoryTheory.Limits.ReflectsLimitsOfShape` | module `Mathlib.CategoryTheory.Limits.Preserves.Basic` | package Mathlib | A functor `F : C ⥤ D` reflects limits of shape `J` if whenever the image of a cone over some `K : J ⥤ C` under `F` is a limit cone in `D`, the cone was already a limit cone in `C`. Note that we do not assume a priori...
- `CategoryTheory.Limits.ReflectsLimit` | module `Mathlib.CategoryTheory.Limits.Preserves.Basic` | package Mathlib | A functor `F : C ⥤ D` reflects limits for `K : J ⥤ C` if whenever the image of a cone over `K` under `F` is a limit cone in `D`, the cone was already a limit cone in `C`. Note that we do not assume a priori that `D` a...
- `Set.Iio_inter_Ioi` | module `Mathlib.Order.Interval.Set.Basic` | package Mathlib | **Intersection of Open Rays.** The intersection of the open upper ray $(a, \infty)$ and the open lower ray $(-\infty, b)$ is equal to the open interval $(a, b)$.

### Query: `Figure2g Length Projection`
- `Submodule.projection` | module `Mathlib.LinearAlgebra.Projection` | package Mathlib | The linear projection onto a subspace along its complement as a map from the full space to itself, as opposed to `Submodule.projectionOnto`, which maps into the subtype. This version is important as it satisfies `IsId...
- `Function.Pullback.snd` | module `Mathlib.Data.Set.Prod` | package Mathlib | The projection from the fiber product to the second factor.
- `Simps.ProjectionRule` | module `Mathlib.Tactic.Simps.Basic` | package Mathlib | The type of rules that specify how metadata for projections in changes. See `initialize_simps_projections`.

### Query: `readout`
- `Turing.TM1to1.supportsStmt_read` | module `Mathlib.Computability.TuringMachine.PostTuringMachine` | package Mathlib | **Support of the Read Statement.** A finite set of labels $S$ supports a `read` statement if, for every possible symbol $a$ that can be read from the tape, the set $S$ supports the statement $f(a)$ that is executed af...
- `ωCPO.omegaCompletePartialOrderEqualizer` | module `Mathlib.Order.Category.OmegaCompletePartialOrder` | package Mathlib | **$\omega$-Complete Partial Order on Equalizers.** Given two $\omega$-complete partial orders $\alpha$ and $\beta$ and two continuous functions $f, g: \alpha \to \beta$, the equalizer $\{ a \in \alpha \mid f(a) = g(a)...
- `ωCPO.instLargeCategory` | module `Mathlib.Order.Category.OmegaCompletePartialOrder` | package Mathlib | **The Category of $\omega$-Complete Partial Orders.** The collection of $\omega$-complete partial orders forms a large category where the morphisms between two objects are the continuous functions between them, the id...

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `CanonicalEnsemble.physicalProbability` (PhysLean)
- `Dimension` (PhysLean)
- `Dimension.L𝓭_length` (PhysLean)
- `Submodule.projection` (Mathlib)
- `CategoryTheory.Functor.PullbackObjObj.ofHasPullback_snd` (Mathlib)
- `Simps.ProjectionRule` (Mathlib)
- `Polynomial.mirror_mirror` (Mathlib)
- `UpperHalfPlane` (Mathlib)
- `EuclideanGeometry.Sphere.IsDiameter.pointReflection_center_right` (Mathlib)
- `OnePoint` (Mathlib)
- `Locale.localePointOfSpacePoint` (Mathlib)
- `TwoPointing.pi_snd` (Mathlib)
- `SameRay` (Mathlib)
- `rayOfNeZero` (Mathlib)
- `Polynomial.reflect_support` (Mathlib)
- `ofColex` (Mathlib)
- `RootPairing.isOrthogonal_comm` (Mathlib)
- `Set.Iio_inter_Ioi` (Mathlib)
- `CategoryTheory.Limits.ReflectsLimitsOfShape` (Mathlib)
- `CategoryTheory.Limits.ReflectsLimit` (Mathlib)
- `Set.Iio_inter_Ioi` (Mathlib)
- `Submodule.projection` (Mathlib)
- `Function.Pullback.snd` (Mathlib)
- `Simps.ProjectionRule` (Mathlib)
- `Turing.TM1to1.supportsStmt_read` (Mathlib)
- `ωCPO.omegaCompletePartialOrderEqualizer` (Mathlib)
- `ωCPO.instLargeCategory` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problems.IPhO2026_2_C_3.Figure2gLengthProjection`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.Figure2gMirror`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.Figure2gMirror.OnReflectingSurface`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.Figure2gPoint`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.IsNeighboringReflectedIntersection`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.PhysicalLength`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.ReflectedRayLine`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_2_C_3.ReflectedRayLine.Contains`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_A_1.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:6f4b572339bc505891ab3575a1e1d0331b870ed088b7911c626a55f1655597a2
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Half-cylindrical mirror and threshold bookkeeping`
- `Polynomial.mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | mirror of a polynomial: reverses the coefficients while preserving `Polynomial.natDegree`
- `Turing.Tape.mk'` | module `Mathlib.Computability.TuringMachine.Tape` | package Mathlib | Construct a tape from a left side and an inclusive right side.
- `Polynomial.mirror_mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | **Involution of the Mirror Polynomial.** For any polynomial $p$, applying the mirror operation twice results in the original polynomial $p$.

### Query: `The limiting ray undergoes exactly N + 1 reflections`
- `SameRay` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | Two vectors are in the same ray if either one of them is zero or some positive multiples of them are equal (in the typical case over a field, this means one of them is a nonnegative multiple of the other).
- `CategoryTheory.Limits.ReflectsLimits` | module `Mathlib.CategoryTheory.Limits.Preserves.Basic` | package Mathlib | A functor `F : C ⥤ D` reflects (small) limits if whenever the image of a cone over some `K : J ⥤ C` under `F` is a limit cone in `D`, the cone was already a limit cone in `C`. Note that we do not assume a priori that...
- `Lean.Elab.Tactic.iterateExactly'` | module `Mathlib.Tactic.Core` | package Mathlib | `iterateExactly' n t` executes `t` `n` times. If any iteration fails, the whole tactic fails.

### Query: `The two recorded forms agree`
- `PFunctor.Approx.Agree` | module `Mathlib.Data.PFunctor.Univariate.M` | package Mathlib | Relation between two approximations of the cofix of a pfunctor that state they both contain the same data until one of them is truncated
- `LinearMap.BilinForm.ext_iff_basis` | module `Mathlib.LinearAlgebra.Basis.Bilinear` | package Mathlib | **Equality of Bilinear Forms via Basis.** Two bilinear forms $B$ and $B'$ on a module $M$ are equal if and only if they agree on all pairs of elements from a given basis $\{b_i\}_{i \in I}$ of $M$; that is, $B = B'$ i...
- `PFunctor.M.Agree'` | module `Mathlib.Data.PFunctor.Univariate.M` | package Mathlib | `Agree' n` relates two trees of type `M F` that are the same up to depth `n`

### Query: `A.1 answer, cosine form`
- `Real.cos` | module `Mathlib.Analysis.Complex.Trigonometric` | package Mathlib | The real cosine function, defined as the real part of the complex cosine
- `PowerSeries.cos` | module `Mathlib.RingTheory.PowerSeries.WellKnown` | package Mathlib | Power series for the cosine function at zero.
- `Real.cos_three_mul` | module `Mathlib.Analysis.Complex.Trigonometric` | package Mathlib | **Triple-Angle Formula for Cosine.** For any real number $x$, the cosine of $3x$ is given by $\cos(3x) = 4\cos^3(x) - 3\cos(x)$.

### Query: `A.1 answer, sine form`
- `Real.sin` | module `Mathlib.Analysis.Complex.Trigonometric` | package Mathlib | The real sine function, defined as the real part of the complex sine
- `Real.abs_sin_half` | module `Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic` | package Mathlib | **Half-Angle Formula for Sine.** For any real number $x$, the absolute value of the sine of $x/2$ is equal to the square root of $(1 - \cos x) / 2$.
- `sineTerm` | module `Mathlib.Analysis.SpecialFunctions.Trigonometric.Cotangent` | package Mathlib | The main term in the infinite product for sine.

### Query: `A.1 answer, combined`
- `WithTop.untopA` | module `Mathlib.Order.WithBot` | package Mathlib | Function that sends an element of `WithTop α` to `α`, with an arbitrary default value for `⊤`.
- `WithBot.unbotA` | module `Mathlib.Order.WithBot` | package Mathlib | Function that sends an element of `WithBot α` to `α`, with an arbitrary default value for `⊥`.
- `QuaternionGroup.a` | module `Mathlib.GroupTheory.SpecificGroups.Quaternion` | package Mathlib | **Generator of the Quaternion Group.** For a natural number $n$, the element $a$ is a constructor for the generalized quaternion group of order $4n$ that maps an integer $i$ modulo $2n$ to the group element $a^i$.

### Query: `Half Cylindrical Mirror`
- `Polynomial.mirror` | module `Mathlib.Algebra.Polynomial.Mirror` | package Mathlib | mirror of a polynomial: reverses the coefficients while preserving `Polynomial.natDegree`
- `UpperHalfPlane` | module `Mathlib.Analysis.Complex.UpperHalfPlane.Basic` | package Mathlib | The open upper half plane, denoted as `ℍ` within the `UpperHalfPlane` namespace
- `HomotopicalAlgebra.Precylinder.symm` | module `Mathlib.AlgebraicTopology.ModelCategory.Cylinder` | package Mathlib | The precylinder object obtained by switching the two inclusions.

### Query: `limiting ray reflection count`
- `SameRay` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | Two vectors are in the same ray if either one of them is zero or some positive multiples of them are equal (in the typical case over a field, this means one of them is a nonnegative multiple of the other).
- `RayVector` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | Nonzero vectors, as used to define rays. This type depends on an unused argument `R` so that `RayVector.Setoid` can be an instance.
- `CategoryTheory.Limits.instReflectsFiniteLimitsOfReflectsLimits` | module `Mathlib.CategoryTheory.Limits.Preserves.Finite` | package Mathlib | **Reflection of Finite Limits from Reflection of All Limits.** If a functor $F: \mathcal{C} \to \mathcal{D}$ reflects all limits, then it also reflects finite limits.

### Query: `threshold forms agree`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `Asymptotics.IsTheta` | module `Mathlib.Analysis.Asymptotics.Defs` | package Mathlib | We say that `f` is `Θ(g)` along a filter `l` (notation: `f =Θ[l] g`) if `f =O[l] g` and `g =O[l] f`.
- `PFunctor.M.Agree'` | module `Mathlib.Data.PFunctor.Univariate.M` | package Mathlib | `Agree' n` relates two trees of type `M F` that are the same up to depth `n`

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `Polynomial.mirror` (Mathlib)
- `Turing.Tape.mk'` (Mathlib)
- `Polynomial.mirror_mirror` (Mathlib)
- `SameRay` (Mathlib)
- `CategoryTheory.Limits.ReflectsLimits` (Mathlib)
- `Lean.Elab.Tactic.iterateExactly'` (Mathlib)
- `PFunctor.Approx.Agree` (Mathlib)
- `LinearMap.BilinForm.ext_iff_basis` (Mathlib)
- `PFunctor.M.Agree'` (Mathlib)
- `Real.cos` (Mathlib)
- `PowerSeries.cos` (Mathlib)
- `Real.cos_three_mul` (Mathlib)
- `Real.sin` (Mathlib)
- `Real.abs_sin_half` (Mathlib)
- `sineTerm` (Mathlib)
- `WithTop.untopA` (Mathlib)
- `WithBot.unbotA` (Mathlib)
- `QuaternionGroup.a` (Mathlib)
- `Polynomial.mirror` (Mathlib)
- `UpperHalfPlane` (Mathlib)
- `HomotopicalAlgebra.Precylinder.symm` (Mathlib)
- `SameRay` (Mathlib)
- `RayVector` (Mathlib)
- `CategoryTheory.Limits.instReflectsFiniteLimitsOfReflectsLimits` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `Asymptotics.IsTheta` (Mathlib)
- `PFunctor.M.Agree'` (Mathlib)

## Local abstractions introduced

- `IPhO2026_2_A_1.HalfCylindricalMirror`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

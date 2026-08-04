# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_1_C_2.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_2.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:4741ba9541a2e0b84090e77f07512c8d9d2ad3684fc90d8572e33cedfb05eaf9
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Real.sqrt square root`
- `Real.sqrt` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | The square root of a real number. This returns 0 for negative inputs. This has notation `√x`. Note that `√x⁻¹` is parsed as `√(x⁻¹)`.
- `Real.coe_sqrt` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | **Square Root of Nonnegative Reals.** For any nonnegative real number $x$, the real-valued square root of $x$ is equal to the square root of $x$ computed in the nonnegative real numbers and then cast to a real number.
- `Real.sqrt_lt'` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | **Strict Monotonicity of the Square Root.** For any real number $x$ and any positive real number $y$, the square root of $x$ is strictly less than $y$ if and only if $x$ is strictly less than $y^2$.

### Query: `derivative at a point`
- `Polynomial.derivative` | module `Mathlib.Algebra.Polynomial.Derivative` | package Mathlib | `derivative p` is the formal derivative of the polynomial `p`
- `bernsteinPolynomial.iterate_derivative_at_1` | module `Mathlib.RingTheory.Polynomial.Bernstein` | package Mathlib | **The $(n-\nu)$-th Derivative of a Bernstein Polynomial at 1.** For a commutative ring $R$ and natural numbers $\nu \leq n$, the $(n-\nu)$-th iterative derivative of the Bernstein polynomial $B_{\nu, n}(X)$ evaluated...
- `derivWithin_zero_of_not_accPt` | module `Mathlib.Analysis.Calculus.Deriv.Basic` | package Mathlib | **Derivative at an Isolated Point.** If a point $x$ is not an accumulation point of a set $s$, then the derivative of any function $f$ within $s$ at $x$ is zero.

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Photodissociation constants bundle`
- `Constants.ℏ` | module `Physlib.QuantumMechanics.PlanckConstant` | package PhysLean | The value of the reduced Planck's constant in units of J.s.
- `FirstOrder.Language.withConstants` | module `Mathlib.ModelTheory.LanguageMap` | package Mathlib | Extends a language with a constant for each element of a parameter set in `M`.
- `Physlib.allDocStrings` | module `Physlib.Meta.Basic` | package PhysLean | All docstrings present in Physlib.

### Query: `Dissociation kinematic state`
- `CongrState` | module `Mathlib.Tactic.CongrExclamation` | package Mathlib | **Congruence Tactic State.** A structure representing the state of a congruence-based decomposition process, consisting of a collection of unresolved goals (metavariables) that the procedure could not automatically di...
- `not_mulDissociated_iff_exists_disjoint` | module `Mathlib.Combinatorics.Additive.Dissociation` | package Mathlib | **Characterization of Non-Multiplicative Dissociation.** A subset $s$ of a multiplicative group is not multiplicatively dissociated if and only if there exist two distinct, disjoint finite subsets $t$ and $u$ of $s$ s...
- `not_addDissociated_iff_exists_disjoint` | module `Mathlib.Combinatorics.Additive.Dissociation` | package Mathlib | **Characterization of Non-Dissociated Sets.** A subset $s$ of an additive commutative group is not dissociated if and only if there exist two distinct, disjoint finite subsets $t$ and $u$ of $s$ such that the sum of t...

### Query: `Ozone-photodissociation reaction predicate`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `cfcₙHom_predicate` | module `Mathlib.Analysis.CStarAlgebra.ContinuousFunctionalCalculus.NonUnital` | package Mathlib | **Predicate for the Non-unital Continuous Functional Calculus.** For any element $a$ satisfying the predicate $p$, the image of a continuous function $f$ (vanishing at zero) under the non-unital continuous functional...
- `cfc_predicate` | module `Mathlib.Analysis.CStarAlgebra.ContinuousFunctionalCalculus.Unital` | package Mathlib | **Predicate Preservation under Continuous Functional Calculus.** For any function $f: R \to R$ and any element $a$ in a star-algebra $A$, the element $f(a)$ obtained via the continuous functional calculus satisfies th...

### Query: `Positivity of the photon energy`
- `Mathlib.Meta.Positivity.PositivityExt` | module `Mathlib.Tactic.Positivity.Core` | package Mathlib | An extension for `positivity`.
- `positivity` | module `Mathlib.Tactic.Positivity.Core` | package Mathlib | A definition of type `PositivityExt` tagged `@[positivity t]` extends the `positivity` tactic. The term (with underscores) `t` indicates which expressions this extension accepts. An extension will be given an expressi...
- `SpeedOfLight.val_pos` | module `Physlib.Relativity.SpeedOfLight` | package PhysLean | **Positivity of the Speed of Light.** The real-valued magnitude of the speed of light is strictly positive.

### Query: `Released kinetic energy is nonnegative`
- `RigidBodyMotion.kineticEnergy` | module `Physlib.ClassicalMechanics.RigidBody.KineticEnergy` | package PhysLean | The total kinetic energy of a rigid body in motion at time `t`: half the mass integral of the squared speed of the body points, `T = ½ ∫ ⟪v, v⟫ dm`, with the point velocity taken in the closed form `velocityClosedForm`.
- `Finset.addEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The additive energy `E[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ + b₁ = a₂ + b₂`. The notation `E[s, t]` is available in scope `Combinato...
- `Finset.mulEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The multiplicative energy `Eₘ[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ * b₁ = a₂ * b₂`. The notation `Eₘ[s, t]` is available in scope `C...

### Query: `C.2 calibrated input data`
- `Polynomial.C` | module `Mathlib.Algebra.Polynomial.Basic` | package Mathlib | `C a` is the constant polynomial `a`. `C` is provided as a ring homomorphism.
- `CalcPanel` | module `Mathlib.Tactic.Widget.Calc` | package Mathlib | The calc widget.
- `catalan_two` | module `Mathlib.Combinatorics.Enumerative.Catalan.Basic` | package Mathlib | **Second Catalan Number.** The second Catalan number is equal to 2.

### Query: `C.1 threshold photon energy ( )`
- `Polynomial.C` | module `Mathlib.Algebra.Polynomial.Basic` | package Mathlib | `C a` is the constant polynomial `a`. `C` is provided as a ring homomorphism.
- `Polynomial.C_1` | module `Mathlib.Algebra.Polynomial.Basic` | package Mathlib | **Constant Polynomial of Unity.** The constant polynomial map $C$ sends the multiplicative identity $1$ of a semiring to the multiplicative identity $1$ of the corresponding polynomial ring.
- `SkewPolynomial.C_1` | module `Mathlib.Algebra.SkewPolynomial.Basic` | package Mathlib | **Constant Map of Unity.** In a skew polynomial ring, the constant map $C$ sends the multiplicative identity $1$ of the base ring to the multiplicative identity $1$ of the skew polynomial ring.

## Grounded Mathlib/PhysLean names

- `Real.sqrt` (Mathlib)
- `Real.coe_sqrt` (Mathlib)
- `Real.sqrt_lt'` (Mathlib)
- `Polynomial.derivative` (Mathlib)
- `bernsteinPolynomial.iterate_derivative_at_1` (Mathlib)
- `derivWithin_zero_of_not_accPt` (Mathlib)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `Constants.ℏ` (PhysLean)
- `FirstOrder.Language.withConstants` (Mathlib)
- `Physlib.allDocStrings` (PhysLean)
- `CongrState` (Mathlib)
- `not_mulDissociated_iff_exists_disjoint` (Mathlib)
- `not_addDissociated_iff_exists_disjoint` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `cfcₙHom_predicate` (Mathlib)
- `cfc_predicate` (Mathlib)
- `Mathlib.Meta.Positivity.PositivityExt` (Mathlib)
- `positivity` (Mathlib)
- `SpeedOfLight.val_pos` (PhysLean)
- `RigidBodyMotion.kineticEnergy` (PhysLean)
- `Finset.addEnergy` (Mathlib)
- `Finset.mulEnergy` (Mathlib)
- `Polynomial.C` (Mathlib)
- `CalcPanel` (Mathlib)
- `catalan_two` (Mathlib)
- `Polynomial.C` (Mathlib)
- `Polynomial.C_1` (Mathlib)
- `SkewPolynomial.C_1` (Mathlib)

## Local abstractions introduced

- `IPhO2026_1_C_2.C2CalibratedData`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_C_2.DissociationState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_C_2.DissociationState.ΔU`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_C_2.IsOzonePhotodissociation`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_C_2.PhotoDissociationConstants`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_C_2.ThresholdRealizable`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

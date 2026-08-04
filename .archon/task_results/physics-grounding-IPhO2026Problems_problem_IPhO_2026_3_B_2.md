# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_2.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:2b760203862717f2a63148a487d5342dafe00360e8374196eaf2dfb1c2773daf
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

### Query: `Fixed torus parameters`
- `FixedPoints.subfield` | module `Mathlib.FieldTheory.Fixed` | package Mathlib | The subfield of fixed points by a monoid action.
- `Function.fixedPoints` | module `Mathlib.Dynamics.FixedPoints.Defs` | package Mathlib | The set of fixed points of a map `f : α → α`.
- `torusIntegral` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | The integral over a generalized torus with center `c ∈ ℂⁿ` and radius `R ∈ ℝⁿ`, defined as the `•`-product of the derivative of `torusMap` and `f (torusMap c R θ)`

### Query: `Paramagnetic torus state`
- `torusIntegral` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | The integral over a generalized torus with center `c ∈ ℂⁿ` and radius `R ∈ ℝⁿ`, defined as the `•`-product of the derivative of `torusMap` and `f (torusMap c R θ)`
- `Turing.TM2to1.Λ'.ret` | module `Mathlib.Computability.TuringMachine.StackTuringMachine` | package Mathlib | **Return State of the TM2 Emulator.** The return state is a state in the Turing machine emulating a multi-stack machine, parameterized by a specific statement from the original machine's program. It signifies the phas...
- `TorusIntegrable` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | A function `f : ℂⁿ → E` is integrable on the generalized torus if the function `f ∘ torusMap c R θ` is integrable on `Icc (0 : ℝⁿ) (fun _ ↦ 2 * π)`.

### Query: `Quasistatic state path`
- `Path` | module `Mathlib.Topology.Path` | package Mathlib | Continuous path connecting two points `x` and `y` in a topological space
- `Quiver.PathStar` | module `Mathlib.Combinatorics.Quiver.Covering` | package Mathlib | The path star at a vertex `u` is the type of all paths starting at `u`. The type `Quiver.PathStar u` is defined to be `Σ v : U, Path u v`.
- `CongrState` | module `Mathlib.Tactic.CongrExclamation` | package Mathlib | **Congruence Tactic State.** A structure representing the state of a congruence-based decomposition process, consisting of a collection of unresolved goals (metavariables) that the procedure could not automatically di...

### Query: `Adiabatic ramp initial data`
- `adiabatic_relation_log` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in logarithmic form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then c * log (Ua/Ub) + log (Va/Vb) = 0.
- `CategoryTheory.Functor.Initial` | module `Mathlib.CategoryTheory.Limits.Final` | package Mathlib | A functor `F : C ⥤ D` is initial if for every `d : D`, the comma category of morphisms `F.obj c ⟶ d` is connected.
- `adiabatic_relation_UaUbVaVb` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in product form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then (Ua/Ub)^c * (Va/Vb) = 1.

### Query: `Adiabatic invariant`
- `adiabatic_relation_log` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in logarithmic form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then c * log (Ua/Ub) + log (Va/Vb) = 0.
- `SlashInvariantForm` | module `Mathlib.NumberTheory.ModularForms.SlashInvariantForms` | package Mathlib | Functions `ℍ → ℂ` that are invariant under the `SlashAction`.
- `adiabatic_relation_UaUbVaVb` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in product form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then (Ua/Ub)^c * (Va/Vb) = 1.

### Query: `Paramagnetic torus laws along a path`
- `Circle.path_apply` | module `Mathlib.Analysis.SpecialFunctions.Complex.Circle` | package Mathlib | **Evaluation of the Anticlockwise Path on the Circle.** For any two points $x$ and $y$ on the unit circle, the value of the anticlockwise path from $x$ to $y$ at a parameter $a \in [0, 1]$ is given by the exponential...
- `Path` | module `Mathlib.Topology.Path` | package Mathlib | Continuous path connecting two points `x` and `y` in a topological space
- `torusIntegral` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | The integral over a generalized torus with center `c ∈ ℂⁿ` and radius `R ∈ ℝⁿ`, defined as the `•`-product of the derivative of `torusMap` and `f (torusMap c R θ)`

### Query: `Adiabatic process law`
- `adiabatic_relation_log` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in logarithmic form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then c * log (Ua/Ub) + log (Va/Vb) = 0.
- `MeasureTheory.stoppedProcess` | module `Mathlib.Probability.Process.Stopping` | package Mathlib | Given a map `u : ι → Ω → E`, the stopped process with respect to `τ` is `u i ω` if `i ≤ τ ω`, and `u (τ ω) ω` otherwise. Intuitively, the stopped process stops evolving once the stopping time has occurred.
- `adiabatic_relation_UaUbVaVb` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in product form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then (Ua/Ub)^c * (Va/Vb) = 1.

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
- `FixedPoints.subfield` (Mathlib)
- `Function.fixedPoints` (Mathlib)
- `torusIntegral` (Mathlib)
- `torusIntegral` (Mathlib)
- `Turing.TM2to1.Λ'.ret` (Mathlib)
- `TorusIntegrable` (Mathlib)
- `Path` (Mathlib)
- `Quiver.PathStar` (Mathlib)
- `CongrState` (Mathlib)
- `adiabatic_relation_log` (PhysLean)
- `CategoryTheory.Functor.Initial` (Mathlib)
- `adiabatic_relation_UaUbVaVb` (PhysLean)
- `adiabatic_relation_log` (PhysLean)
- `SlashInvariantForm` (Mathlib)
- `adiabatic_relation_UaUbVaVb` (PhysLean)
- `Circle.path_apply` (Mathlib)
- `Path` (Mathlib)
- `torusIntegral` (Mathlib)
- `adiabatic_relation_log` (PhysLean)
- `MeasureTheory.stoppedProcess` (Mathlib)
- `adiabatic_relation_UaUbVaVb` (PhysLean)

## Local abstractions introduced

- `IPhO2026_3_B_2.AdiabaticEndpoints`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_3_B_2.IsAdiabaticPath`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_3_B_2.ParamagneticTorusLaws`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_3_B_2.ParamagneticTorusState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_3_B_2.StatePath`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_3_B_2.TorusParameters`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

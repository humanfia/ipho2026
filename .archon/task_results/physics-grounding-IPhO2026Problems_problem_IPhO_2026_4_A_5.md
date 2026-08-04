# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:4dca56e1d1440d82c30bc66ec8ed38ddb982d9e87d56288a584c84560639dc9a
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Time-averaged ambient air density (Bucaramanga)`
- `Electromagnetism.LorentzCurrentDensity.currentDensity_differentiable_time` | module `Physlib.Electromagnetism.Dynamics.CurrentDensity` | package PhysLean | **Differentiability of Current Density with Respect to Time.** If a Lorentz current density $J$ is differentiable on $(d+1)$-dimensional spacetime, then for any fixed position $x$ in $d$-dimensional Euclidean space an...
- `MeasureTheory.Measure.withDensity` | module `Mathlib.MeasureTheory.Measure.WithDensity` | package Mathlib | Given a measure `μ : Measure α` and a function `f : α → ℝ≥0∞`, `μ.withDensity f` is the measure such that for a measurable set `s` we have `μ.withDensity f s = ∫⁻ a in s, f a ∂μ`.
- `DimPressure.standardAtmosphere` | module `Physlib.Units.WithDim.Pressure` | package PhysLean | The dimensional pressure corresponding to 1 standard atmosphere (101,325 pascals).

### Query: `Propylene-glycol seal height`
- `Order.height` | module `Mathlib.Order.KrullDimension` | package Mathlib | The **height** of an element `a` in a preorder `α` is the supremum of the rightmost index of all relation series of `α` ordered by `<` and ending below or at `a`. In other words, it is the largest `n` such that there'...
- `Ideal.height` | module `Mathlib.RingTheory.Ideal.Height` | package Mathlib | The height of an ideal is defined as the infimum of the heights of its minimal prime ideals.
- `AlgebraicGeometry.Scheme.height_of_isClosed` | module `Mathlib.AlgebraicGeometry.Scheme` | package Mathlib | **Height of a Closed Point.** In a scheme $X$, if a point $x \in X$ is a closed point (i.e., the singleton set $\{x\}$ is closed), then the height of $x$ is $0$.

### Query: `Reference absolute temperature`
- `TemperatureUnit.absoluteFahrenheit` | module `Physlib.Thermodynamics.Temperature.TemperatureUnits` | package PhysLean | The temperature unit of degrees fahrenheit ((5/9) of a kelvin). Note, this is fahrenheit starting at `0` absolute temperature.
- `abs` | module `Mathlib.Algebra.Order.Group.Unbundled.Abs` | package Mathlib | `abs a`, denoted `|a|`, is the absolute value of `a`
- `Temperature` | module `Physlib.Thermodynamics.Temperature.Basic` | package PhysLean | The type `Temperature` represents the temperature in a given (but arbitrary) set of units (preserving zero). It currently wraps `ℝ≥0`, i.e., absolute temperature in nonnegative reals.

### Query: `Real-valued absolute-temperature projection`
- `TemperatureUnit.absoluteFahrenheit` | module `Physlib.Thermodynamics.Temperature.TemperatureUnits` | package PhysLean | The temperature unit of degrees fahrenheit ((5/9) of a kelvin). Note, this is fahrenheit starting at `0` absolute temperature.
- `AbsoluteValue` | module `Mathlib.Algebra.Order.AbsoluteValue.Basic` | package Mathlib | `AbsoluteValue R S` is the type of absolute values on `R` mapping to `S`: the maps that preserve `*`, are nonnegative, positive definite and satisfy the triangle inequality.
- `Mathlib.Meta.Positivity.evalERealToReal` | module `Mathlib.Data.EReal.Basic` | package Mathlib | Extension for the `positivity` tactic: projection from `EReal` to `ℝ`. We prove that `EReal.toReal x` is nonnegative whenever `x` is nonnegative. Since `EReal.toReal ⊤ = 0`, we cannot prove a stronger statement, at le...

### Query: `absTemp agrees with the real coercion`
- `abs` | module `Mathlib.Algebra.Order.Group.Unbundled.Abs` | package Mathlib | `abs a`, denoted `|a|`, is the absolute value of `a`
- `Temperature.instCoeReal` | module `Physlib.Thermodynamics.Temperature.Basic` | package PhysLean | Coercion to `ℝ`.
- `Hyperreal.coe_abs` | module `Mathlib.Analysis.Real.Hyperreal` | package Mathlib | **Absolute Value of Coerced Reals.** For any real number $x$, the hyperreal coercion of the absolute value of $x$ is equal to the absolute value of the hyperreal coercion of $x$.

### Query: `Absolute temperatures are nonnegative`
- `Mathlib.Meta.Positivity.Strictness.nonnegative` | module `Mathlib.Tactic.Positivity.Core` | package Mathlib | **Non-negative Strictness.** In the context of the positivity tactic, if an expression $e$ in a partially ordered type is proven to be greater than or equal to zero ($0 \le e$), then its strictness is classified as no...
- `Temperature` | module `Physlib.Thermodynamics.Temperature.Basic` | package PhysLean | The type `Temperature` represents the temperature in a given (but arbitrary) set of units (preserving zero). It currently wraps `ℝ≥0`, i.e., absolute temperature in nonnegative reals.
- `TemperatureUnit.absoluteFahrenheit` | module `Physlib.Thermodynamics.Temperature.TemperatureUnits` | package PhysLean | The temperature unit of degrees fahrenheit ((5/9) of a kelvin). Note, this is fahrenheit starting at `0` absolute temperature.

### Query: `Ideal-gas reference coefficient`
- `IdealGas.ideal_gas_law` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The ideal gas law: PV = nRT. In our unitsless system, R = 1.
- `Ideal` | module `Mathlib.RingTheory.Ideal.Defs` | package Mathlib | A (left) ideal in a semiring `R` is an additive submonoid `s` such that `a * b ∈ s` whenever `b ∈ s`. If `R` is a ring, then `s` is an additive subgroup.
- `IdealGas` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The Hamiltonian for an ideal gas: particles live in a cube of volume V^(1/3), and each contributes an energy p^2/2. The per-particle mass is normalized to 1.

### Query: `Numerical value of the ideal coefficient`
- `ordinaryHypergeometricCoefficient` | module `Mathlib.Analysis.SpecialFunctions.OrdinaryHypergeometric` | package Mathlib | The coefficients in the ordinary hypergeometric sum.
- `Ideal` | module `Mathlib.RingTheory.Ideal.Defs` | package Mathlib | A (left) ideal in a semiring `R` is an additive submonoid `s` such that `a * b ∈ s` whenever `b ∈ s`. If `R` is a ring, then `s` is an additive subgroup.
- `Polynomial.coeff_mem_contentIdeal` | module `Mathlib.RingTheory.Polynomial.ContentIdeal` | package Mathlib | **Coefficients in the Content Ideal.** For any polynomial $p$ and any natural number $n$, the $n$-th coefficient of $p$ is an element of the content ideal of $p$.

### Query: `Isochoric process record`
- `MeasureTheory.stoppedProcess` | module `Mathlib.Probability.Process.Stopping` | package Mathlib | Given a map `u : ι → Ω → E`, the stopped process with respect to `τ` is `u i ω` if `i ≤ τ ω`, and `u (τ ω) ω` otherwise. Intuitively, the stopped process stops evolving once the stopping time has occurred.
- `MeasureTheory.IsProgressive.inv` | module `Mathlib.Probability.Process.Adapted` | package Mathlib | **Inversion of Progressive Processes.** If a stochastic process $u$ is progressive with respect to a filtration, then its pointwise inverse process $u^{-1}$, defined in a group with a measurable inversion operation, i...
- `WittVector.isocrystal_classification` | module `Mathlib.RingTheory.WittVector.Isocrystal` | package Mathlib | A one-dimensional isocrystal over an algebraically closed field admits an isomorphism to one of the standard (indexed by `m : ℤ`) one-dimensional isocrystals.

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `Electromagnetism.LorentzCurrentDensity.currentDensity_differentiable_time` (PhysLean)
- `MeasureTheory.Measure.withDensity` (Mathlib)
- `DimPressure.standardAtmosphere` (PhysLean)
- `Order.height` (Mathlib)
- `Ideal.height` (Mathlib)
- `AlgebraicGeometry.Scheme.height_of_isClosed` (Mathlib)
- `TemperatureUnit.absoluteFahrenheit` (PhysLean)
- `abs` (Mathlib)
- `Temperature` (PhysLean)
- `TemperatureUnit.absoluteFahrenheit` (PhysLean)
- `AbsoluteValue` (Mathlib)
- `Mathlib.Meta.Positivity.evalERealToReal` (Mathlib)
- `abs` (Mathlib)
- `Temperature.instCoeReal` (PhysLean)
- `Hyperreal.coe_abs` (Mathlib)
- `Mathlib.Meta.Positivity.Strictness.nonnegative` (Mathlib)
- `Temperature` (PhysLean)
- `TemperatureUnit.absoluteFahrenheit` (PhysLean)
- `IdealGas.ideal_gas_law` (PhysLean)
- `Ideal` (Mathlib)
- `IdealGas` (PhysLean)
- `ordinaryHypergeometricCoefficient` (Mathlib)
- `Ideal` (Mathlib)
- `Polynomial.coeff_mem_contentIdeal` (Mathlib)
- `MeasureTheory.stoppedProcess` (Mathlib)
- `MeasureTheory.IsProgressive.inv` (Mathlib)
- `WittVector.isocrystal_classification` (Mathlib)

## Local abstractions introduced

- `IPhO2026_4_A_5.IsIdealGasLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_5.IsIsochoricLinear`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_5.IsReferenceState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_5.IsochoricProcess`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_5.IsochoricReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

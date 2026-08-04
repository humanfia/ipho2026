# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_1.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:985872f3c1e4a1a7c26b74d95f5eb39819e3beb4433a49215d7b5e9f1ed92ec4
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

### Query: `Torus parameters`
- `torusMap` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | The n-dimensional exponential map $θ_i ↦ c + R e^{θ_i*I}, θ ∈ ℝⁿ$ representing a torus in `ℂⁿ` with center `c ∈ ℂⁿ` and generalized radius `R ∈ ℝⁿ`, so we can adjust it to every n axis.
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `TorusIntegrable` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | A function `f : ℂⁿ → E` is integrable on the generalized torus if the function `f ∘ torusMap c R θ` is integrable on `Icc (0 : ℝⁿ) (fun _ ↦ 2 * π)`.

### Query: `Torus state`
- `torusIntegral` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | The integral over a generalized torus with center `c ∈ ℂⁿ` and radius `R ∈ ℝⁿ`, defined as the `•`-product of the derivative of `torusMap` and `f (torusMap c R θ)`
- `Turing.TM2to1.Λ'.ret` | module `Mathlib.Computability.TuringMachine.StackTuringMachine` | package Mathlib | **Return State of the TM2 Emulator.** The return state is a state in the Turing machine emulating a multi-stack machine, parameterized by a specific statement from the original machine's program. It signifies the phas...
- `TorusIntegrable` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | A function `f : ℂⁿ → E` is integrable on the generalized torus if the function `f ∘ torusMap c R θ` is integrable on `Icc (0 : ℝⁿ) (fun _ ↦ 2 * π)`.

### Query: `Heat capacity at constant magnetization`
- `LocallyConstant` | module `Mathlib.Topology.LocallyConstant.Basic` | package Mathlib | A (bundled) locally constant function from a topological space `X` to a type `Y`.
- `CanonicalEnsemble.heatCapacity` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | The heat capacity (at constant volume) C_V = ∂U/∂T (as a derivWithin on T > 0).
- `CanonicalEnsemble.heatCapacity_eq_deriv_meanEnergyBeta` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | Relates C_V = dU/dT to dU/dβ. C_V = dU/dβ * (-1/(kB T²)).

### Query: `Equation of state of the paramagnet`
- `WeierstrassCurve.Affine.Equation` | module `Mathlib.AlgebraicGeometry.EllipticCurve.Affine.Basic` | package Mathlib | The proposition that an affine point `(x, y)` lies in a Weierstrass curve `W`. In other words, it satisfies the Weierstrass equation `W(X, Y) = 0`.
- `adiabatic_relation_UaUbVaVb` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in product form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then (Ua/Ub)^c * (Va/Vb) = 1.
- `adiabatic_relation_log` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in logarithmic form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then c * log (Ua/Ub) + log (Va/Vb) = 0.

### Query: `Heat-capacity law for the internal energy`
- `CanonicalEnsemble.heatCapacity_eq_deriv_meanEnergyBeta` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | Relates C_V = dU/dT to dU/dβ. C_V = dU/dβ * (-1/(kB T²)).
- `CanonicalEnsemble.heatCapacity` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | The heat capacity (at constant volume) C_V = ∂U/∂T (as a derivWithin on T > 0).
- `MicroHamiltonian.internalU` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.ThermoQuantities` | package PhysLean | The Internal Energy, U or E, defined as -∂(ln Z)/∂β. Parameterized here with β.

### Query: `Magnetic work-on density`
- `MeasureTheory.Measure.withDensity` | module `Mathlib.MeasureTheory.Measure.WithDensity` | package Mathlib | Given a measure `μ : Measure α` and a function `f : α → ℝ≥0∞`, `μ.withDensity f` is the measure such that for a measurable set `s` we have `μ.withDensity f s = ∫⁻ a in s, f a ∂μ`.
- `Electromagnetism.MagneticField` | module `Physlib.Electromagnetism.Basic` | package PhysLean | The magnetic field is a map from `d+1` dimensional spacetime to the vector space `ℝ^d`.
- `Electromagnetism.ElectromagneticPotential.time_deriv_time_deriv_magneticFieldMatrix_of_isExtrema` | module `Physlib.Electromagnetism.Dynamics.IsExtrema` | package PhysLean | **Wave Equation for the Magnetic Field Matrix.** For an electromagnetic potential $A$ and a Lorentz current density $J$ that are both infinitely smooth, if $A$ is an extremum of the action in free space (thereby satis...

### Query: `First law with magnetic work, isothermal form`
- `parallelogram_law_with_nnnorm` | module `Mathlib.Analysis.InnerProductSpace.Basic` | package Mathlib | **Parallelogram Law for Nonnegative Norms.** For any two elements $x$ and $y$ in a normed space, the sum of the squares of the nonnegative norms of their sum and their difference is equal to twice the sum of the squar...
- `Electromagnetism.ElectromagneticPotential.magneticFieldMatrix` | module `Physlib.Electromagnetism.Kinematics.MagneticField` | package PhysLean | The matrix corresponding to the magnetic field in general dimensions. In `3` space-dimensions this reduces to a vector.
- `CanonicalEnsemble.helmholtzFreeEnergy_eq_meanEnergy_sub_temp_mul_thermodynamicEntropy` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | The Helmholtz free energy `F` is related to the mean energy `U` and the absolute thermodynamic entropy `S` by the identity `F = U - TS`. This theorem shows that the statistically-defined quantities in this framework c...

### Query: `Magnetization fixed by the equation of state`
- `MulAction.fixedBy` | module `Mathlib.GroupTheory.GroupAction.Defs` | package Mathlib | `fixedBy m` is the set of elements fixed by `m`.
- `fixedByFinite` | module `Mathlib.FieldTheory.KrullTopology` | package Mathlib | Given a field extension `L/K`, `fixedByFinite K L` is the set of subsets `Gal(L/E)` of `Gal(L/K)`, where `E/K` is finite.
- `adiabatic_relation_UaUbVaVb` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in product form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then (Ua/Ub)^c * (Va/Vb) = 1.

## Grounded Mathlib/PhysLean names

- `Polynomial.derivative` (Mathlib)
- `bernsteinPolynomial.iterate_derivative_at_1` (Mathlib)
- `derivWithin_zero_of_not_accPt` (Mathlib)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `torusMap` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `TorusIntegrable` (Mathlib)
- `torusIntegral` (Mathlib)
- `Turing.TM2to1.Λ'.ret` (Mathlib)
- `TorusIntegrable` (Mathlib)
- `LocallyConstant` (Mathlib)
- `CanonicalEnsemble.heatCapacity` (PhysLean)
- `CanonicalEnsemble.heatCapacity_eq_deriv_meanEnergyBeta` (PhysLean)
- `WeierstrassCurve.Affine.Equation` (Mathlib)
- `adiabatic_relation_UaUbVaVb` (PhysLean)
- `adiabatic_relation_log` (PhysLean)
- `CanonicalEnsemble.heatCapacity_eq_deriv_meanEnergyBeta` (PhysLean)
- `CanonicalEnsemble.heatCapacity` (PhysLean)
- `MicroHamiltonian.internalU` (PhysLean)
- `MeasureTheory.Measure.withDensity` (Mathlib)
- `Electromagnetism.MagneticField` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.time_deriv_time_deriv_magneticFieldMatrix_of_isExtrema` (PhysLean)
- `parallelogram_law_with_nnnorm` (Mathlib)
- `Electromagnetism.ElectromagneticPotential.magneticFieldMatrix` (PhysLean)
- `CanonicalEnsemble.helmholtzFreeEnergy_eq_meanEnergy_sub_temp_mul_thermodynamicEntropy` (PhysLean)
- `MulAction.fixedBy` (Mathlib)
- `fixedByFinite` (Mathlib)
- `adiabatic_relation_UaUbVaVb` (PhysLean)

## Local abstractions introduced

- `IPhO2026.Problem3.B1.HasHeatCapacityLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.B1.IsMagneticWorkDensity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.B1.IsothermalFieldChange`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.B1.ObeysFirstLawMagnetic`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.B1.SatisfiesEOS`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.B1.TorusParams`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.B1.TorusState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

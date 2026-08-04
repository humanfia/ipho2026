# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_3_C_5.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_5.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:ea1292667ffc389d5c2474b2b7b8286413a01f5cfc8e76baf36fd5ef0fa64a84
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Carnot-cycle corner fields`
- `Subsemigroup.corner` | module `Mathlib.RingTheory.Idempotents` | package Mathlib | The corner associated to an element `e` in a semigroup is the subsemigroup of all elements of the form `e * r * e`.
- `Cycle.nil` | module `Mathlib.Data.List.Cycle` | package Mathlib | The unique empty cycle.
- `Cycle` | module `Mathlib.Data.List.Cycle` | package Mathlib | `Cycle α` is the quotient of `List α` by cyclic permutation. Duplicates are allowed.

### Query: `Regime assumptions`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `Mathlib.Tactic.ITauto.Proof.hyp` | module `Mathlib.Tactic.ITauto` | package Mathlib | `(n: A) ⊢ A`
- `HahnSeries.single` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | `single a r` is the Hahn series which has coefficient `r` at `a` and zero otherwise.

### Query: `Coefficient of performance as a ratio`
- `Polynomial.coeff` | module `Mathlib.Algebra.Polynomial.Basic` | package Mathlib | `coeff p n` (often denoted `p.coeff n`) is the coefficient of `X^n` in `p`.
- `ordinaryHypergeometricCoefficient` | module `Mathlib.Analysis.SpecialFunctions.OrdinaryHypergeometric` | package Mathlib | The coefficients in the ordinary hypergeometric sum.
- `Dilation.ratio_of_subsingleton` | module `Mathlib.Topology.MetricSpace.Dilation` | package Mathlib | **Dilation Ratio in a Subsingleton.** If the domain of a dilation is a subsingleton, then the ratio of the dilation is equal to 1.

### Query: `Constant-power work bridge`
- `RigidBody.rigid_body_work_and_power` | module `Physlib.ClassicalMechanics.RigidBody.Basic` | package PhysLean | The power delivered to a rigid body by forces is P = ∑ Fᵢ ⋅ vᵢ = F_tot ⋅ V + M ⋅ ω, where F_tot is total force, V the reference point velocity, and M the torque. Translational and rotational contributions separate.
- `LocallyConstant` | module `Mathlib.Topology.LocallyConstant.Basic` | package Mathlib | A (bundled) locally constant function from a topological space `X` to a type `Y`.
- `PowerSeries.IsRestricted.C` | module `Mathlib.RingTheory.PowerSeries.Restricted` | package Mathlib | **Constant Power Series are Restricted.** For any element $a$ in a normed ring $R$, the constant power series $C(a)$ is a restricted power series with respect to any positive real parameter $c$.

### Query: `Cooled-body calorimetric bridge`
- `SimpleGraph.IsBridge` | module `Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected` | package Mathlib | An edge of a graph is a *bridge* if without it, its incident vertices are not reachable from one another.
- `CanonicalEnsemble.fluctuation_dissipation_energy_parametric` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | Parametric FDT: C_V = Var(E)/(kB T²), assuming Var(E) = - dU/dβ.
- `CanonicalEnsemble.heatCapacity_eq_deriv_meanEnergyBeta` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | Relates C_V = dU/dT to dU/dβ. C_V = dU/dβ * (-1/(kB T²)).

### Query: `Accumulated Carnot heat relation`
- `CanonicalEnsemble.heatCapacity` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | The heat capacity (at constant volume) C_V = ∂U/∂T (as a derivWithin on T > 0).
- `adiabatic_relation_log` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in logarithmic form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then c * log (Ua/Ub) + log (Va/Vb) = 0.
- `CanonicalEnsemble.heatCapacity_eq_deriv_meanEnergyBeta` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | Relates C_V = dU/dT to dU/dβ. C_V = dU/dβ * (-1/(kB T²)).

### Query: `Refrigerator energy balance`
- `CanonicalEnsemble.energyVariance` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Basic` | package PhysLean | Energy variance at temperature `T`.
- `Finset.addEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The additive energy `E[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ + b₁ = a₂ + b₂`. The notation `E[s, t]` is available in scope `Combinato...
- `Finset.mulEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The multiplicative energy `Eₘ[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ * b₁ = a₂ * b₂`. The notation `Eₘ[s, t]` is available in scope `C...

### Query: `C.4 elapsed-time law`
- `Polynomial.C` | module `Mathlib.Algebra.Polynomial.Basic` | package Mathlib | `C a` is the constant polynomial `a`. `C` is provided as a ring homomorphism.
- `PolynomialLaw` | module `Mathlib.RingTheory.PolynomialLaw.Basic` | package Mathlib | A polynomial law `M →ₚₗ[R] N` between `R`-modules is a functorial family of maps `S ⊗[R] M → S ⊗[R] N`, for all `R`-algebras `S`. For universe reasons, `S` has to be restricted to the same universe as `R`.
- `MeasureTheory.hittingBtwn` | module `Mathlib.Probability.Process.HittingTime` | package Mathlib | Hitting time: given a stochastic process `u` and a set `s`, `hittingBtwn u s n m` is the first time `u` is in `s` after time `n` and before time `m` (if `u` does not hit `s` after time `n` and before `m` then the hitt...

### Query: `Paramagnetic equation of state`
- `WeierstrassCurve.Affine.Equation` | module `Mathlib.AlgebraicGeometry.EllipticCurve.Affine.Basic` | package Mathlib | The proposition that an affine point `(x, y)` lies in a Weierstrass curve `W`. In other words, it satisfies the Weierstrass equation `W(X, Y) = 0`.
- `IdealGas.ideal_gas_law` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The ideal gas law: PV = nRT. In our unitsless system, R = 1.
- `WeierstrassCurve.Projective.equation_of_equiv` | module `Mathlib.AlgebraicGeometry.EllipticCurve.Projective.Basic` | package Mathlib | **Invariance of the Weierstrass Equation under Projective Equivalence.** For any two points $P$ and $Q$ in the projective plane represented as triples in $R^3$, if $P$ and $Q$ are projectively equivalent, then $P$ sat...

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `Subsemigroup.corner` (Mathlib)
- `Cycle.nil` (Mathlib)
- `Cycle` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `Mathlib.Tactic.ITauto.Proof.hyp` (Mathlib)
- `HahnSeries.single` (Mathlib)
- `Polynomial.coeff` (Mathlib)
- `ordinaryHypergeometricCoefficient` (Mathlib)
- `Dilation.ratio_of_subsingleton` (Mathlib)
- `RigidBody.rigid_body_work_and_power` (PhysLean)
- `LocallyConstant` (Mathlib)
- `PowerSeries.IsRestricted.C` (Mathlib)
- `SimpleGraph.IsBridge` (Mathlib)
- `CanonicalEnsemble.fluctuation_dissipation_energy_parametric` (PhysLean)
- `CanonicalEnsemble.heatCapacity_eq_deriv_meanEnergyBeta` (PhysLean)
- `CanonicalEnsemble.heatCapacity` (PhysLean)
- `adiabatic_relation_log` (PhysLean)
- `CanonicalEnsemble.heatCapacity_eq_deriv_meanEnergyBeta` (PhysLean)
- `CanonicalEnsemble.energyVariance` (PhysLean)
- `Finset.addEnergy` (Mathlib)
- `Finset.mulEnergy` (Mathlib)
- `Polynomial.C` (Mathlib)
- `PolynomialLaw` (Mathlib)
- `MeasureTheory.hittingBtwn` (Mathlib)
- `WeierstrassCurve.Affine.Equation` (Mathlib)
- `IdealGas.ideal_gas_law` (PhysLean)
- `WeierstrassCurve.Projective.equation_of_equiv` (Mathlib)

## Local abstractions introduced

- `IPhO2026.Problem3.C5.AccumulatedCarnotHeatRelation`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C5.C4ElapsedTimeLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C5.ConstantPowerWork`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C5.CooledBodyHeatBalance`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C5.CycleFields`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C5.OperatingHistory`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C5.ParamagneticEquationOfState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C5.RefrigeratorEnergyBalance`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C5.RegimeAssumptions`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

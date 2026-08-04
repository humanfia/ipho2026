# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_1.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:9aefba50dfd9603b7b3eb888c30e248577b6ac71a8f3d552d0400a373072d8b5
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

### Query: `Declaration energyInJoules`
- `Finset.mulEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The multiplicative energy `Eₘ[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ * b₁ = a₂ * b₂`. The notation `Eₘ[s, t]` is available in scope `C...
- `Finset.addEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The additive energy `E[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ + b₁ = a₂ + b₂`. The notation `E[s, t]` is available in scope `Combinato...
- `DimEnergy.kilowattHour` | module `Physlib.Units.WithDim.Energy` | package PhysLean | The dimensional energy corresponding to 1 kilowatt-hours, (3,600,000 J).

### Query: `Declaration ParamagneticTorus`
- `torusIntegral` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | The integral over a generalized torus with center `c ∈ ℂⁿ` and radius `R ∈ ℝⁿ`, defined as the `•`-product of the derivative of `torusMap` and `f (torusMap c R θ)`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `torusMap` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | The n-dimensional exponential map $θ_i ↦ c + R e^{θ_i*I}, θ ∈ ℝⁿ$ representing a torus in `ℂⁿ` with center `c ∈ ℂⁿ` and generalized radius `R ∈ ℝⁿ`, so we can adjust it to every n axis.

### Query: `Declaration IsothermalFieldSweep`
- `Field` | module `Mathlib.Algebra.Field.Defs` | package Mathlib | A `Field` is a `CommRing` with multiplicative inverses for nonzero elements. An instance of `Field K` includes maps `ratCast : ℚ → K` and `qsmul : ℚ → K → K`. Those two fields are needed to implement the `DivisionRing...
- `WittVector.IsocrystalEquiv` | module `Mathlib.RingTheory.WittVector.Isocrystal` | package Mathlib | An isomorphism between isocrystals respects the Frobenius map. Notation `M ≃ᶠⁱ [p, k]` in the `Isocrystal` namespace.
- `WittVector.isocrystal_classification` | module `Mathlib.RingTheory.WittVector.Isocrystal` | package Mathlib | A one-dimensional isocrystal over an algebraically closed field admits an isomorphism to one of the standard (indexed by `m : ℤ`) one-dimensional isocrystals.

### Query: `Declaration netHeatEnteringInJoules`
- `Dynamics.IsDynNetIn` | module `Mathlib.Dynamics.TopologicalEntropy.NetEntropy` | package Mathlib | Given a subset `F`, an entourage `U` and an integer `n`, a subset `s` of `F` is a `(U, n)`-dynamical net of `F` if no two orbits of length `n` of points in `s` shadow each other.
- `IsEllipticNet.atomRel` | module `Mathlib.NumberTheory.EllipticDivisibilitySequence` | package Mathlib | The elliptic relator `ERₐ(a, b, c, d)` obtained by a change of variables in `ER(p, q, r, s)` (see `IsEllipticNet.rel_eq` and `IsEllipticNet.atomRel_eq`). Note that this is defined in terms of elliptic atoms, and hence...
- `DimEnergy.kilowattHour` | module `Physlib.Units.WithDim.Energy` | package PhysLean | The dimensional energy corresponding to 1 kilowatt-hours, (3,600,000 J).

### Query: `Declaration SatisfiesIsothermalParamagneticTorusLaws`
- `torusIntegral` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | The integral over a generalized torus with center `c ∈ ℂⁿ` and radius `R ∈ ℝⁿ`, defined as the `•`-product of the derivative of `torusMap` and `f (torusMap c R θ)`
- `TorusIntegrable` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | A function `f : ℂⁿ → E` is integrable on the generalized torus if the function `f ∘ torusMap c R θ` is integrable on `Icc (0 : ℝⁿ) (fun _ ↦ 2 * π)`.
- `torusMap` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | The n-dimensional exponential map $θ_i ↦ c + R e^{θ_i*I}, θ ∈ ℝⁿ$ representing a torus in `ℂⁿ` with center `c ∈ ℂⁿ` and generalized radius `R ∈ ℝⁿ`, so we can adjust it to every n axis.

### Query: `Declaration internalEnergyRate eq zero`
- `ClassicalMechanics.DampedHarmonicOscillator.energy_dissipation_rate` | module `Physlib.ClassicalMechanics.DampedHarmonicOscillator.Basic` | package PhysLean | Along a smooth solution of the damped equation of motion, the derivative of the mechanical energy is `-γ ‖ẋ‖^2`.
- `Finset.mulEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The multiplicative energy `Eₘ[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ * b₁ = a₂ * b₂`. The notation `Eₘ[s, t]` is available in scope `C...
- `Finset.addEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The additive energy `E[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ + b₁ = a₂ + b₂`. The notation `E[s, t]` is available in scope `Combinato...

### Query: `Declaration magnetizationRate eq`
- `Electromagnetism.ElectromagneticPotential.time_deriv_time_deriv_magneticFieldMatrix_of_isExtrema` | module `Physlib.Electromagnetism.Dynamics.IsExtrema` | package PhysLean | **Wave Equation for the Magnetic Field Matrix.** For an electromagnetic potential $A$ and a Lorentz current density $J$ that are both infinitely smooth, if $A$ is an extremum of the action in free space (thereby satis...
- `Electromagnetism.ElectromagneticPotential.IsPlaneWave.magneticFieldMatrix_space_deriv_eq_time_deriv` | module `Physlib.Electromagnetism.Vacuum.IsPlaneWave` | package PhysLean | **Space-Time Derivative Relation for the Magnetic Field Matrix of a Plane Wave.** For an electromagnetic potential $A$ in a $d$-dimensional free space with speed of light $c$ that is a $C^2$ plane wave propagating in...
- `Electromagnetism.ElectromagneticPotential.IsPlaneWave.magneticFieldMatrix_eq_magneticFunction` | module `Physlib.Electromagnetism.Vacuum.IsPlaneWave` | package PhysLean | **Magnetic Field Matrix of a Plane Wave.** For an electromagnetic potential $A$ that is a plane wave propagating in direction $s$ within a free space with speed of light $c$, the magnetic field matrix at any time $t$...

### Query: `Declaration heatRate eq`
- `CanonicalEnsemble.heatCapacity` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | The heat capacity (at constant volume) C_V = ∂U/∂T (as a derivWithin on T > 0).
- `Mathlib.Tactic.TFAE.Parser.tfaeHaveDecl` | module `Mathlib.Tactic.TFAE` | package Mathlib | See `haveDecl`. Any of `tfaeHaveIdDecl`, `tfaeHavePatDecl`, or `tfaeHaveEqnsDecl`.
- `CanonicalEnsemble.heatCapacity_eq_deriv_meanEnergyBeta` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | Relates C_V = dU/dT to dU/dβ. C_V = dU/dβ * (-1/(kB T²)).

## Grounded Mathlib/PhysLean names

- `Polynomial.derivative` (Mathlib)
- `bernsteinPolynomial.iterate_derivative_at_1` (Mathlib)
- `derivWithin_zero_of_not_accPt` (Mathlib)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `Finset.mulEnergy` (Mathlib)
- `Finset.addEnergy` (Mathlib)
- `DimEnergy.kilowattHour` (PhysLean)
- `torusIntegral` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `torusMap` (Mathlib)
- `Field` (Mathlib)
- `WittVector.IsocrystalEquiv` (Mathlib)
- `WittVector.isocrystal_classification` (Mathlib)
- `Dynamics.IsDynNetIn` (Mathlib)
- `IsEllipticNet.atomRel` (Mathlib)
- `DimEnergy.kilowattHour` (PhysLean)
- `torusIntegral` (Mathlib)
- `TorusIntegrable` (Mathlib)
- `torusMap` (Mathlib)
- `ClassicalMechanics.DampedHarmonicOscillator.energy_dissipation_rate` (PhysLean)
- `Finset.mulEnergy` (Mathlib)
- `Finset.addEnergy` (Mathlib)
- `Electromagnetism.ElectromagneticPotential.time_deriv_time_deriv_magneticFieldMatrix_of_isExtrema` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.IsPlaneWave.magneticFieldMatrix_space_deriv_eq_time_deriv` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.IsPlaneWave.magneticFieldMatrix_eq_magneticFunction` (PhysLean)
- `CanonicalEnsemble.heatCapacity` (PhysLean)
- `Mathlib.Tactic.TFAE.Parser.tfaeHaveDecl` (Mathlib)
- `CanonicalEnsemble.heatCapacity_eq_deriv_meanEnergyBeta` (PhysLean)

## Local abstractions introduced

- `IPhO2026Problems.ProblemIPhO2026_3_B_1.IsothermalFieldSweep`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_B_1.ParamagneticTorus`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_B_1.SatisfiesIsothermalParamagneticTorusLaws`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

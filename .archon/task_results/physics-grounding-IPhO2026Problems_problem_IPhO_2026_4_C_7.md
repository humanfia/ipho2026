# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:4c60bc0b3c47bf242711da03be1bbd987581fd51dede5b7be91158695d0e8094
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Thermal experiment readout data`
- `Mathlib.Meta.FunProp.FunctionData.toExpr` | module `Mathlib.Tactic.FunProp.FunctionData` | package Mathlib | Turn function data back to expression.
- `Turing.TM1to1.supportsStmt_read` | module `Mathlib.Computability.TuringMachine.PostTuringMachine` | package Mathlib | **Support of the Read Statement.** A finite set of labels $S$ supports a `read` statement if, for every possible symbol $a$ that can be read from the tape, the set $S$ supports the statement $f(a)$ that is executed af...
- `Turing.TM1to1.stepAux_read` | module `Mathlib.Computability.TuringMachine.PostTuringMachine` | package Mathlib | **Turing Machine Read Step Equivalence.** For a Turing machine transition function, the auxiliary step execution of a "read" command—which branches based on the symbol currently under the tape head—is equivalent to ex...

### Query: `Cylindrical wall geometry and lateral area`
- `Real.Wallis.W_le` | module `Mathlib.Analysis.Real.Pi.Wallis` | package Mathlib | **Upper Bound for the Wallis Product.** For any natural number $k$, the $k$-th partial product of the Wallis formula, $W(k)$, is less than or equal to $\pi/2$.
- `Real.Wallis.W_eq_factorial_ratio` | module `Mathlib.Analysis.Real.Pi.Wallis` | package Mathlib | **Factorial Representation of the Wallis Product.** For any natural number $n$, the $n$-th partial product of the Wallis formula, $W(n)$, is given by the identity $$W(n) = \frac{2^{4n} (n!)^4}{((2n)!)^2 (2n + 1)}.$$
- `DimArea` | module `Physlib.Units.WithDim.Area` | package PhysLean | The type of areas in the absence of a choice of unit.

### Query: `Lumped heat-flow law, Eq. (4)`
- `CanonicalEnsemble.heatCapacity` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | The heat capacity (at constant volume) C_V = ∂U/∂T (as a derivWithin on T > 0).
- `ProbabilityTheory.HasGaussianLaw` | module `Mathlib.Probability.Distributions.Gaussian.HasGaussianLaw.Def` | package Mathlib | The predicate `HasGaussianLaw X P` means that under the measure `P`, `X` has a Gaussian distribution.
- `adiabatic_relation_log` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in logarithmic form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then c * log (Ua/Ub) + log (Va/Vb) = 0.

### Query: `Radial Fourier conduction, Eq. (6)`
- `fourier` | module `Mathlib.Analysis.Fourier.AddCircle` | package Mathlib | The family of exponential monomials `fun x => exp (2 π i n x / T)`, parametrized by `n : ℤ` and considered as bundled continuous maps from `ℝ / ℤ • T` to `ℂ`.
- `Space.distDiv_inv_pow_eq_dim` | module `Physlib.SpaceAndTime.Space.Norm.Basic` | package PhysLean | The distributional divergence of the radial field `x ↦ ‖x‖ ^ (-d) • x` (i.e. `x / ‖x‖ ^ d`) equals `d * volume (Metric.ball 0 1)` — the surface area of the unit sphere `S^{d-1}` — times the Dirac delta at the origin....
- `FourierTransform.fourierEquiv` | module `Mathlib.Analysis.Fourier.Notation` | package Mathlib | The Fourier transform as a linear equivalence.

### Query: `Constancy of the wall heat current`
- `CanonicalEnsemble.heatCapacity` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | The heat capacity (at constant volume) C_V = ∂U/∂T (as a derivWithin on T > 0).
- `Electromagnetism.DistElectromagneticPotential.wireCurrentDensity` | module `Physlib.Electromagnetism.Current.InfiniteWire` | package PhysLean | The current density associated with an infinite wire carrying a current `I` along the `x`-axis.
- `Electromagnetism.DistElectromagneticPotential.wireCurrentDensity_chargeDesnity` | module `Physlib.Electromagnetism.Current.InfiniteWire` | package PhysLean | **Charge Density of a Wire Current.** For any speed of light $c$ and any constant current $I$, the charge density distribution associated with the Lorentz current density of an infinite wire carrying current $I$ is id...

### Query: `C.7 derivation formula: acrylic conductivity from the data`
- `Derivation` | module `Mathlib.RingTheory.Derivation.Basic` | package Mathlib | `D : Derivation R A M` is an `R`-linear map from `A` to `M` that satisfies the `leibniz` equality. We also require that `D 1 = 0`. See `Derivation.mk'` for a constructor that deduces this assumption from the Leibniz r...
- `Polynomial.derivation_C` | module `Mathlib.Algebra.Polynomial.Derivation` | package Mathlib | **Derivation of Constant Polynomials.** For any derivation $D$ from the polynomial ring $R[X]$ to an $R[X]$-module $A$, the image of any constant polynomial $C(a)$ under $D$ is zero for all $a \in R$.
- `Derivation.«termC^_⟮_,_;_⟯⟨_⟩»` | module `Mathlib.Geometry.Manifold.DerivationBundle` | package Mathlib | Type synonym, introduced to put a different `SMul` action on `C^n⟮I, M; 𝕜⟯` which is defined as `f • r = f(x) * r`. Denoted as `C^n⟮I, M; 𝕜⟯⟨x⟩` within the `Derivation` namespace.

### Query: `C.7 official sample value: realizability scale window`
- `Polynomial.scaleRoots_C` | module `Mathlib.RingTheory.Polynomial.ScaleRoots` | package Mathlib | **Scaling the Roots of a Constant Polynomial.** For any elements $r$ and $c$ in a semiring $R$, scaling the roots of the constant polynomial $c$ by $r$ results in the same constant polynomial $c$.
- `Polynomial.C` | module `Mathlib.Algebra.Polynomial.Basic` | package Mathlib | `C a` is the constant polynomial `a`. `C` is provided as a ring homomorphism.
- `Plausible.Rat.sampleableExt` | module `Mathlib.Testing.Plausible.Sampleable` | package Mathlib | **Rational Number Sampleability.** The set of rational numbers $\mathbb{Q}$ is equipped with an instance for extended sampling, allowing for the generation of random rational values within a testing framework.

### Query: `Thermal Experiment Data`
- `Mathlib.Meta.FunProp.FunctionData.toExpr` | module `Mathlib.Tactic.FunProp.FunctionData` | package Mathlib | Turn function data back to expression.
- `Temperature.beta_fun_T_formula` | module `Physlib.Thermodynamics.Temperature.Basic` | package PhysLean | Explicit closed-form for `Beta_fun_T t` when `t > 0`.
- `Temperature.ofNNReal_val` | module `Physlib.Thermodynamics.Temperature.Basic` | package PhysLean | **Value of a Temperature from a Nonnegative Real.** For any nonnegative real number $t$, the numerical value of the temperature constructed from $t$ is equal to $t$ itself.

### Query: `Cylindrical Wall Geometry`
- `HomotopicalAlgebra.Cylinder.symm` | module `Mathlib.AlgebraicTopology.ModelCategory.Cylinder` | package Mathlib | The cylinder object obtained by switching the two inclusions.
- `Cosmology.SpatialGeometry` | module `Physlib.Cosmology.FLRW.Basic` | package PhysLean | The inductive type with three constructors: - `Spherical (k : ℝ)` - `Flat` - `Saddle (k : ℝ)`
- `PiNat.mem_cylinder_iff_dist_le` | module `Mathlib.Topology.MetricSpace.PiNat` | package Mathlib | **Cylinder Membership and Distance in Sequence Spaces.** For any two sequences $x$ and $y$ in the product space $\prod_{n \in \mathbb{N}} E_n$, the sequence $y$ belongs to the cylinder set of length $n$ around $x$ if...

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `Mathlib.Meta.FunProp.FunctionData.toExpr` (Mathlib)
- `Turing.TM1to1.supportsStmt_read` (Mathlib)
- `Turing.TM1to1.stepAux_read` (Mathlib)
- `Real.Wallis.W_le` (Mathlib)
- `Real.Wallis.W_eq_factorial_ratio` (Mathlib)
- `DimArea` (PhysLean)
- `CanonicalEnsemble.heatCapacity` (PhysLean)
- `ProbabilityTheory.HasGaussianLaw` (Mathlib)
- `adiabatic_relation_log` (PhysLean)
- `fourier` (Mathlib)
- `Space.distDiv_inv_pow_eq_dim` (PhysLean)
- `FourierTransform.fourierEquiv` (Mathlib)
- `CanonicalEnsemble.heatCapacity` (PhysLean)
- `Electromagnetism.DistElectromagneticPotential.wireCurrentDensity` (PhysLean)
- `Electromagnetism.DistElectromagneticPotential.wireCurrentDensity_chargeDesnity` (PhysLean)
- `Derivation` (Mathlib)
- `Polynomial.derivation_C` (Mathlib)
- `Derivation.«termC^_⟮_,_;_⟯⟨_⟩»` (Mathlib)
- `Polynomial.scaleRoots_C` (Mathlib)
- `Polynomial.C` (Mathlib)
- `Plausible.Rat.sampleableExt` (Mathlib)
- `Mathlib.Meta.FunProp.FunctionData.toExpr` (Mathlib)
- `Temperature.beta_fun_T_formula` (PhysLean)
- `Temperature.ofNNReal_val` (PhysLean)
- `HomotopicalAlgebra.Cylinder.symm` (Mathlib)
- `Cosmology.SpatialGeometry` (PhysLean)
- `PiNat.mem_cylinder_iff_dist_le` (Mathlib)

## Local abstractions introduced

- `IPhO2026.Problem4.C7.CylindricalWallGeometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.C7.LumpedHeatFlowLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.C7.RadialFourierConduction`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.C7.ThermalExperimentData`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

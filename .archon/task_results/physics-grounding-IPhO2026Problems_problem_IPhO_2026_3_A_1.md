# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_1.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:707a3e921999dcc0104072117331a95e665fd2e9b262b4967feb3acff491cb4f
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Free space and instantaneous current`
- `Electromagnetism.ElectromagneticPotential.gradFreeCurrentPotential_eq_chargeDensity_currentDensity` | module `Physlib.Electromagnetism.Dynamics.Lagrangian` | package PhysLean | **Gradient of the Free Current Potential.** For a smooth electromagnetic potential $A$ and a smooth Lorentz current density $J$ in a free space $\mathcal{F}$ of dimension $d$, the gradient of the free current potentia...
- `Electromagnetism.ElectromagneticPotential.freeCurrentPotential` | module `Physlib.Electromagnetism.Dynamics.Lagrangian` | package PhysLean | The potential energy from the interaction of the electromagnetic potential with the free current `J`.
- `Electromagnetism.FreeSpace` | module `Physlib.Electromagnetism.Dynamics.Basic` | package PhysLean | Free space consists of the specification of the electric permittivity and the magnetic permeability.

### Query: `Radial profile and H-field readouts`
- `Space.distDiv_inv_pow_eq_dim` | module `Physlib.SpaceAndTime.Space.Norm.Basic` | package PhysLean | The distributional divergence of the radial field `x ↦ ‖x‖ ^ (-d) • x` (i.e. `x / ‖x‖ ^ d`) equals `d * volume (Metric.ball 0 1)` — the surface area of the unit sphere `S^{d-1}` — times the Dirac delta at the origin....
- `Electromagnetism.ElectromagneticPotential.IsPlaneWave.magneticFunction_unique` | module `Physlib.Electromagnetism.Vacuum.IsPlaneWave` | package PhysLean | **Uniqueness of the Magnetic Profile for Plane Waves.** For an electromagnetic potential $A$ propagating as a plane wave in a free space with speed of light $c$ along a unit direction $s$, the magnetic profile functio...
- `Electromagnetism.ElectromagneticPotential.harmonicWaveX_magneticFieldMatrix_space_deriv_succ` | module `Physlib.Electromagnetism.Vacuum.HarmonicWave` | package PhysLean | **Spatial Derivatives of the Magnetic Field Matrix for a Harmonic Plane Wave.** For a harmonic plane wave propagating in the $x_0$-direction within a $(d+1)$-dimensional free space, the spatial derivatives of all comp...

### Query: `Amperian filament`
- `Function.Antiperiodic` | module `Mathlib.Algebra.Ring.Periodic` | package Mathlib | A function `f` is said to be `antiperiodic` with antiperiod `c` if for all `x`, `f (x + c) = -f x`.
- `MSSMACC.AnomalyFreePerp.InLineEq` | module `Physlib.Particles.SuperSymmetry.MSSMNu.AnomalyCancellation.OrthogY3B3.ToSols` | package PhysLean | Those charge assignments perpendicular to `Y₃` and `B₃` which satisfy the condition `lineEqProp`.
- `Electromagnetism.DistElectromagneticPotential.infiniteWire_vectorPotential` | module `Physlib.Electromagnetism.Current.InfiniteWire` | package PhysLean | **Vector Potential of an Infinite Wire.** For a given free space with permeability $\mu_0$ and speed of light $c$, the magnetic vector potential of an infinite straight wire carrying a steady current $I$ is given by t...

### Query: `Ampère circulation law`
- `parallelogram_law` | module `Mathlib.Analysis.InnerProductSpace.Basic` | package Mathlib | Parallelogram law
- `ProbabilityTheory.HasGaussianLaw` | module `Mathlib.Probability.Distributions.Gaussian.HasGaussianLaw.Def` | package Mathlib | The predicate `HasGaussianLaw X P` means that under the measure `P`, `X` has a Gaussian distribution.
- `Electromagnetism.ElectromagneticPotential.isExtrema_iff_gauss_ampere_magneticFieldMatrix` | module `Physlib.Electromagnetism.Dynamics.IsExtrema` | package PhysLean | **Equivalence of Extremal Potential and Gauss-Ampère Laws.** For a smooth electromagnetic potential $A$ and a smooth Lorentz current density $J$ in a free space $\mathcal{F}$ with permittivity $\varepsilon_0$ and perm...

### Query: `Finite winding`
- `Finite` | module `Mathlib.Data.Finite.Defs` | package Mathlib | A type is `Finite` if it is in bijective correspondence to some `Fin n`. This is similar to `Fintype`, but `Finite` is a proposition rather than data. A particular benefit to this is that `Finite` instances are defini...
- `Set.Finite` | module `Mathlib.Data.Finite.Defs` | package Mathlib | A set is finite if the corresponding `Subtype` is finite, i.e., if there exists a natural `n : ℕ` and an equivalence `s ≃ Fin n`.
- `instFiniteAdditive` | module `Mathlib.Algebra.Group.TypeTags.Finite` | package Mathlib | **Finiteness of the Additive Wrapper.** If a type $\alpha$ is finite, then the type $\text{Additive } \alpha$ is also finite.

### Query: `Ampère law on the thin mean path`
- `curveIntegral` | module `Mathlib.MeasureTheory.Integral.CurveIntegral.Basic` | package Mathlib | Integral of a 1-form `ω : E → E →L[𝕜] F` along a path `γ`, defined as $\int_0^1 \omega(\gamma(t))(\gamma'(t))$. The actual definition uses `curveIntegralFun` which uses `Path.extend γ` and `derivWithin (Path.extend γ)...
- `Electromagnetism.ElectromagneticPotential.isExtrema_iff_gauss_ampere_magneticFieldMatrix` | module `Physlib.Electromagnetism.Dynamics.IsExtrema` | package PhysLean | **Equivalence of Extremal Potential and Gauss-Ampère Laws.** For a smooth electromagnetic potential $A$ and a smooth Lorentz current density $J$ in a free space $\mathcal{F}$ with permittivity $\varepsilon_0$ and perm...
- `CategoryTheory.thin_category` | module `Mathlib.CategoryTheory.Thin` | package Mathlib | Construct a category instance from a `CategoryStruct`, using the fact that hom spaces are subsingletons to prove the axioms.

### Query: `Uniform field magnitude interface`
- `UniformContinuous` | module `Mathlib.Topology.UniformSpace.Defs` | package Mathlib | A function `f : α → β` is *uniformly continuous* if `(f x, f y)` tends to the diagonal as `(x, y)` tends to the diagonal. In other words, if `x` is sufficiently close to `y`, then `f x` is close to `f y` no matter whe...
- `NumberField.IsCMField.regOfFamily_realFunSystem` | module `Mathlib.NumberTheory.NumberField.CMField` | package Mathlib | **Regulator of the Fundamental System of the Maximal Real Subfield.** In a CM field $K$ with maximal real subfield $K^+$, the regulator of the family of units in $K$ corresponding to a fundamental system of units of $...
- `ULift.field` | module `Mathlib.Algebra.Field.ULift` | package Mathlib | **Field Structure on Universe Lifting.** If $\alpha$ is a field, then the universe lift of $\alpha$, denoted $\text{ULift } \alpha$, also carries a field structure.

### Query: `Uniform-material winding law`
- `FluidDynamics.NavierStokes.materialAcceleration` | module `Physlib.FluidDynamics.NavierStokes.Momentum` | package PhysLean | The material acceleration `∂ₜ u + (u · ∇)u`.
- `UniformContinuous` | module `Mathlib.Topology.UniformSpace.Defs` | package Mathlib | A function `f : α → β` is *uniformly continuous* if `(f x, f y)` tends to the diagonal as `(x, y)` tends to the diagonal. In other words, if `x` is sufficiently close to `y`, then `f x` is close to `f y` no matter whe...
- `PolynomialLaw` | module `Mathlib.RingTheory.PolynomialLaw.Basic` | package Mathlib | A polynomial law `M →ₚₗ[R] N` between `R`-modules is a functorial family of maps `S ⊗[R] M → S ⊗[R] N`, for all `R`-algebras `S`. For universe reasons, `S` has to be restricted to the same universe as `R`.

### Query: `Vacuum-core constitutive identity`
- `SetRel.core_id` | module `Mathlib.Data.Rel` | package Mathlib | **Core of the Identity Relation.** For any set $t$, the core of $t$ with respect to the identity relation is equal to $t$ itself.
- `Stream'.identity` | module `Mathlib.Data.Stream.Init` | package Mathlib | **Identity Law for Stream Application.** Applying a constant stream of identity functions to any infinite sequence results in the original sequence.
- `balancedCoreAux_empty` | module `Mathlib.Analysis.LocallyConvex.BalancedCoreHull` | package Mathlib | **The Balanced Core of the Empty Set.** The auxiliary balanced core of the empty set in a vector space over a normed division ring is the empty set.

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `Electromagnetism.ElectromagneticPotential.gradFreeCurrentPotential_eq_chargeDensity_currentDensity` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.freeCurrentPotential` (PhysLean)
- `Electromagnetism.FreeSpace` (PhysLean)
- `Space.distDiv_inv_pow_eq_dim` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.IsPlaneWave.magneticFunction_unique` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.harmonicWaveX_magneticFieldMatrix_space_deriv_succ` (PhysLean)
- `Function.Antiperiodic` (Mathlib)
- `MSSMACC.AnomalyFreePerp.InLineEq` (PhysLean)
- `Electromagnetism.DistElectromagneticPotential.infiniteWire_vectorPotential` (PhysLean)
- `parallelogram_law` (Mathlib)
- `ProbabilityTheory.HasGaussianLaw` (Mathlib)
- `Electromagnetism.ElectromagneticPotential.isExtrema_iff_gauss_ampere_magneticFieldMatrix` (PhysLean)
- `Finite` (Mathlib)
- `Set.Finite` (Mathlib)
- `instFiniteAdditive` (Mathlib)
- `curveIntegral` (Mathlib)
- `Electromagnetism.ElectromagneticPotential.isExtrema_iff_gauss_ampere_magneticFieldMatrix` (PhysLean)
- `CategoryTheory.thin_category` (Mathlib)
- `UniformContinuous` (Mathlib)
- `NumberField.IsCMField.regOfFamily_realFunSystem` (Mathlib)
- `ULift.field` (Mathlib)
- `FluidDynamics.NavierStokes.materialAcceleration` (PhysLean)
- `UniformContinuous` (Mathlib)
- `PolynomialLaw` (Mathlib)
- `SetRel.core_id` (Mathlib)
- `Stream'.identity` (Mathlib)
- `balancedCoreAux_empty` (Mathlib)

## Local abstractions introduced

- `IPhO2026.Problem3.PartA1.AmpereLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.AmpereLawThinMeanPath`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.AmperianFilament`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.AmperianFilamentLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.FiniteWinding`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.FreeSpace`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.HFieldReadouts`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.InstantaneousCurrent`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.ParamagneticTorusA1`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.RadialProfile`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.UniformFieldMag`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.VacuumCoreIdentity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_3_A_3.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_3.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:47180de1503f9ca5c99c79e095f3dbf4543227c40f57af02f45dae1d3ecf8c0e
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Thin paramagnetic torus`
- `torusIntegral` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | The integral over a generalized torus with center `c ∈ ℂⁿ` and radius `R ∈ ℝⁿ`, defined as the `•`-product of the derivative of `torusMap` and `f (torusMap c R θ)`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `torusMap_eq_center_iff` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | **Equality of the Torus Map and its Center.** For a center $c \in \mathbb{C}^n$, a vector of radii $R \in \mathbb{R}^n$, and an angular vector $\theta \in \mathbb{R}^n$, the value of the torus map at $\theta$ is equal...

### Query: `Dense winding`
- `Dense` | module `Mathlib.Topology.Defs.Basic` | package Mathlib | A set is dense in a topological space if every point belongs to its closure.
- `BoundingSieve.nu_lt_one_of_dvd_prodPrimes` | module `Mathlib.NumberTheory.SelbergSieve` | package Mathlib | **Strict Upper Bound for the Sieve Density Function.** For any natural number $d > 1$ that divides the sifting product of a bounding sieve, the density function $\nu(d)$ is strictly less than $1$.
- `dense_liouville` | module `Mathlib.NumberTheory.Transcendental.Liouville.Residual` | package Mathlib | The set of Liouville numbers in dense.

### Query: `Ampère's-law predicate for the torus`
- `RigidBody.transport_law_for_momentum` | module `Physlib.ClassicalMechanics.RigidBody.Basic` | package PhysLean | For linear momentum, the relation between inertial and rotating derivatives is (dP/dt)_inertial = d'P/dt + Ω × P. So, d'P/dt + Ω × P = F which is the linear-momentum equation in the rotating frame.
- `Electromagnetism.ElectromagneticPotential.electricField` | module `Physlib.Electromagnetism.Kinematics.ElectricField` | package PhysLean | The electric field from the electromagnetic potential.
- `Electromagnetism.ElectromagneticPotential.isExtrema_iff_gauss_ampere_magneticFieldMatrix` | module `Physlib.Electromagnetism.Dynamics.IsExtrema` | package PhysLean | **Equivalence of Extremal Potential and Gauss-Ampère Laws.** For a smooth electromagnetic potential $A$ and a smooth Lorentz current density $J$ in a free space $\mathcal{F}$ with permittivity $\varepsilon_0$ and perm...

### Query: `Mean circumference in V/A form`
- `RootPairing.RootFormIn` | module `Mathlib.LinearAlgebra.RootSystem.Finite.CanonicalBilinear` | package Mathlib | A canonical bilinear form on the span of roots in a finite root pairing, taking values in a commutative ring, where the root-coroot pairing takes values in that ring.
- `AddCircle.volume_closedBall` | module `Mathlib.MeasureTheory.Integral.IntervalIntegral.Periodic` | package Mathlib | **Volume of a Closed Ball in an Additive Circle.** For an additive circle of circumference $T > 0$, the volume of a closed ball of radius $\epsilon$ centered at any point $x$ is equal to $\min(T, 2\epsilon)$.
- `QuaternionGroup.a` | module `Mathlib.GroupTheory.SpecificGroups.Quaternion` | package Mathlib | **Generator of the Quaternion Group.** For a natural number $n$, the element $a$ is a constructor for the generalized quaternion group of order $4n$ that maps an integer $i$ modulo $2n$ to the group element $a^i$.

### Query: `Uniform core field state`
- `UniformSpace.toCore` | module `Mathlib.Topology.UniformSpace.Defs` | package Mathlib | Construct a `UniformSpace.Core` from a `UniformSpace`.
- `uniformity` | module `Mathlib.Topology.UniformSpace.Defs` | package Mathlib | The uniformity is a filter on α × α (inferred from an ambient uniform space structure on α).
- `UniformSpace.Core` | module `Mathlib.Topology.UniformSpace.Defs` | package Mathlib | This core description of a uniform space is outside of the type class hierarchy. It is useful for constructions of uniform spaces, when the topology is derived from the uniform space.

### Query: `Constitutive law B = 0(H+M)`
- `dimH_bUnion` | module `Mathlib.Topology.MetricSpace.HausdorffDimension` | package Mathlib | **Hausdorff Dimension of a Countable Union.** The Hausdorff dimension of a union of a countable collection of sets is equal to the supremum of the Hausdorff dimensions of the individual sets. That is, for any countabl...
- `dimH` | module `Mathlib.Topology.MetricSpace.HausdorffDimension` | package Mathlib | Hausdorff dimension of a set in an (e)metric space.
- `TwoHiggsDoublet.quarticTerm_zero` | module `Physlib.Particles.BeyondTheStandardModel.TwoHDM.Potential` | package PhysLean | **Vanishing of the Quartic Term at Zero.** The quartic term of a two-Higgs-doublet model evaluated at the zero field configuration is zero.

### Query: `Admissible infinitesimal process`
- `Hyperreal.Infinitesimal` | module `Mathlib.Analysis.Real.Hyperreal` | package Mathlib | A hyperreal number is infinitesimal if its standard part is 0. **Do not use.** Write `0 < ArchimedeanClass.mk x` instead.
- `MeasureTheory.stoppedProcess` | module `Mathlib.Probability.Process.Stopping` | package Mathlib | Given a map `u : ι → Ω → E`, the stopped process with respect to `τ` is `u i ω` if `i ≤ τ ω`, and `u (τ ω) ω` otherwise. Intuitively, the stopped process stops evolving once the stopping time has occurred.
- `ADEInequality.Admissible` | module `Mathlib.NumberTheory.ADEInequality` | package Mathlib | A multiset `pqr` of positive natural numbers is `Admissible` if it is equal to `A' q r`, or `D' r`, or one of `E6`, `E7`, or `E8`.

### Query: `Vacuum-core B -increment`
- `instInhabitedVectorBundleCore` | module `Mathlib.Topology.VectorBundle.Basic` | package Mathlib | **Inhabited Vector Bundle Core.** For any index set $\iota$ that contains at least one element, the type of vector bundle cores over a base space $B$ with fiber $F$ and field $R$ is inhabited, as evidenced by the exis...
- `SzemerediRegularity.increment` | module `Mathlib.Combinatorics.SimpleGraph.Regularity.Increment` | package Mathlib | The **increment partition** in Szemerédi's Regularity Lemma. If an equipartition is *not* uniform, then the increment partition is a (much bigger) equipartition with a slightly higher energy. This is helpful since the...
- `balancedCoreAux_empty` | module `Mathlib.Analysis.LocallyConvex.BalancedCoreHull` | package Mathlib | **The Balanced Core of the Empty Set.** The auxiliary balanced core of the empty set in a vector space over a normed division ring is the empty set.

### Query: `Infinitesimal work budget of the Pm-T`
- `Hyperreal.Infinitesimal` | module `Mathlib.Analysis.Real.Hyperreal` | package Mathlib | A hyperreal number is infinitesimal if its standard part is 0. **Do not use.** Write `0 < ArchimedeanClass.mk x` instead.
- `WriterT.runThe` | module `Mathlib.Control.Monad.Writer` | package Mathlib | **Writer Transformer Execution.** The operation `runThe` executes a writer monad transformer action for a specified accumulation type, returning the underlying monadic computation of a pair containing the result and t...
- `PMF.ofFintype_apply` | module `Mathlib.Probability.ProbabilityMassFunction.Constructions` | package Mathlib | **Evaluation of a PMF Constructed from a Finite Type.** For a function $f$ defined on a finite type such that the sum of its values is $1$, the value of the associated probability mass function at any point $a$ is sim...

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `torusIntegral` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `torusMap_eq_center_iff` (Mathlib)
- `Dense` (Mathlib)
- `BoundingSieve.nu_lt_one_of_dvd_prodPrimes` (Mathlib)
- `dense_liouville` (Mathlib)
- `RigidBody.transport_law_for_momentum` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.electricField` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.isExtrema_iff_gauss_ampere_magneticFieldMatrix` (PhysLean)
- `RootPairing.RootFormIn` (Mathlib)
- `AddCircle.volume_closedBall` (Mathlib)
- `QuaternionGroup.a` (Mathlib)
- `UniformSpace.toCore` (Mathlib)
- `uniformity` (Mathlib)
- `UniformSpace.Core` (Mathlib)
- `dimH_bUnion` (Mathlib)
- `dimH` (Mathlib)
- `TwoHiggsDoublet.quarticTerm_zero` (PhysLean)
- `Hyperreal.Infinitesimal` (Mathlib)
- `MeasureTheory.stoppedProcess` (Mathlib)
- `ADEInequality.Admissible` (Mathlib)
- `instInhabitedVectorBundleCore` (Mathlib)
- `SzemerediRegularity.increment` (Mathlib)
- `balancedCoreAux_empty` (Mathlib)
- `Hyperreal.Infinitesimal` (Mathlib)
- `WriterT.runThe` (Mathlib)
- `PMF.ofFintype_apply` (Mathlib)

## Local abstractions introduced

- `IPhO2026.T3A3.AmpereLawTorus`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.T3A3.ConstitutiveBH`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.T3A3.PmTFieldState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.T3A3.PmTTorus`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.T3A3.PmTVariation`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.T3A3.PmTWinding`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.T3A3.PmTWorkBudget`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

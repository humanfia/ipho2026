# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_6.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:e2053bada4d6be163011ec7a0752beded075f9b5d0b554394e24ea9d3183ef90
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `electric charge`
- `Electromagnetism.ElectromagneticPotential.electricField` | module `Physlib.Electromagnetism.Kinematics.ElectricField` | package PhysLean | The electric field from the electromagnetic potential.
- `ChargeUnit.elementaryCharge` | module `Physlib.Electromagnetism.Charge.ChargeUnit` | package PhysLean | The charge unit of a elementryCharge (1.602176634×10−19 coulomb).
- `Electromagnetism.ElectricField` | module `Physlib.Electromagnetism.Basic` | package PhysLean | The electric field is a map from `d`+1 dimensional spacetime to the vector space `ℝ^d`.

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Dimensional length and pressure aliases`
- `FiniteDimensional` | module `Mathlib.LinearAlgebra.FiniteDimensional.Defs` | package Mathlib | `FiniteDimensional` vector spaces are defined to be finite modules. Use `Module.Basis.finiteDimensional_of_finite` to prove finite dimension from another definition.
- `DimPressure` | module `Physlib.Units.WithDim.Pressure` | package PhysLean | Pressure as a dimensional quantity with dimension `ML⁻¹T⁻2`..
- `NVEHamiltonian.pressure` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.ThermoQuantities` | package PhysLean | Pressure, as a function of T. Defined as the conjugate variable to volume.

### Query: `Abstract molar and specific wrappers`
- `Lean.Meta.DiscrTree.keysSpecific` | module `Mathlib.Lean.Meta.DiscrTree` | package Mathlib | Check if a `keys : Array DiscTree.Key` is "specific", i.e. something other than `[*]` or `[=, *, *, *]`.
- `WithAbs.delabToAbs` | module `Mathlib.Analysis.Normed.Ring.WithAbs` | package Mathlib | This prevents `toAbs p x` being printed as `{ ofAbs := x }` by `delabStructureInstance`.
- `AbstractMeasure` | module `Mathlib.NumberTheory.Padics.Measure.Basic` | package Mathlib | The space of `E`-valued measures on `X`, i.e. continuous linear maps `C(X, R) → E`. (The case `R = E` is the most important case.) This is the same space `C(X, R) →L[R] E`, but we do not want it to inherit the default...

### Query: `Catalog opaque constants`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `HahnSeries.single` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | `single a r` is the Hahn series which has coefficient `r` at `a` and zero otherwise.
- `Constants.ℏ` | module `Physlib.QuantumMechanics.PlanckConstant` | package PhysLean | The value of the reduced Planck's constant in units of J.s.

### Query: `Integrated Clausius--Clapeyron law`
- `parallelogram_law` | module `Mathlib.Analysis.InnerProductSpace.Basic` | package Mathlib | Parallelogram law
- `intervalIntegral` | module `Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic` | package Mathlib | The interval integral `∫ x in a..b, f x ∂μ` is defined as `∫ x in Ioc a b, f x ∂μ - ∫ x in Ioc b a, f x ∂μ`. If `a ≤ b`, then it equals `∫ x in Ioc a b, f x ∂μ`, otherwise it equals `-∫ x in Ioc b a, f x ∂μ`.
- `adiabatic_relation_log` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in logarithmic form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then c * log (Ua/Ub) + log (Va/Vb) = 0.

### Query: `Part-B.5 measurements and B.6 input package`
- `CartanMatrix.B` | module `Mathlib.LinearAlgebra.Matrix.Cartan` | package Mathlib | The Cartan matrix of type Bₙ (rank n, corresponding to so(2n+1)).
- `CoxeterMatrix.B` | module `Mathlib.GroupTheory.Coxeter.Matrix` | package Mathlib | The Coxeter matrix of type Bₙ. The corresponding Coxeter-Dynkin diagram is: ``` 4 o --- o --- o ⬝ ⬝ ⬝ ⬝ o --- o ```
- `Constants.kB` | module `Physlib.StatisticalMechanics.BoltzmannConstant` | package PhysLean | The Boltzmann constant in a given but arbitrary set of units. Boltzman's constant has dimension equivalent to `Energy/Temperature`.

### Query: `Molar-to-specific conversion relation`
- `Lean.Meta.DiscrTree.keysSpecific` | module `Mathlib.Lean.Meta.DiscrTree` | package Mathlib | Check if a `keys : Array DiscTree.Key` is "specific", i.e. something other than `[*]` or `[=, *, *, *]`.
- `UnitChoices.dimScale` | module `Physlib.Units.Basic` | package PhysLean | Given two choices of units `u1` and `u2` and a dimension `d`, the element of `ℝ≥0` corresponding to the scaling (by definition) of a quantity of dimension `d` when changing from units `u1` to `u2`.
- `DimSpeed.oneMeterPerSecond_eq_mul_oneMilePerHour` | module `Physlib.Units.WithDim.Speed` | package PhysLean | **Conversion of One Meter per Second to Miles per Hour.** One meter per second is equal to $\frac{3125}{1397}$ times one mile per hour.

### Query: `Official-answer value record`
- `Informal.constantInfoToInformalDefinition` | module `Physlib.Meta.Informal.Post` | package PhysLean | Takes a `ConstantInfo` corresponding to a `InformalDefinition` and returns the corresponding `InformalDefinition`.
- `AbsoluteValue` | module `Mathlib.Algebra.Order.AbsoluteValue.Basic` | package Mathlib | `AbsoluteValue R S` is the type of absolute values on `R` mapping to `S`: the maps that preserve `*`, are nonnegative, positive definite and satisfy the triangle inequality.
- `GenContFract.compExactValue_correctness_of_stream_eq_some` | module `Mathlib.Algebra.ContinuedFractions.Computation.CorrectnessTerminating` | package Mathlib | Shows the correctness of `compExactValue` in case the continued fraction `GenContFract.of v` did not terminate at position `n`. That is, we obtain the value `v` if we pass the two successive (auxiliary) continuants at...

### Query: `B.6 main target: conversion with official consistency`
- `WeierstrassCurve.b₆` | module `Mathlib.AlgebraicGeometry.EllipticCurve.Weierstrass` | package Mathlib | The `b₆` coefficient of a Weierstrass curve.
- `Lean.Elab.Tactic.getMainTarget''` | module `Mathlib.Lean.Elab.Tactic.Basic` | package Mathlib | Return expected type for the main goal, cleaning up annotations, using `Lean.MVarId.getType''`. Remark: note that `MVarId.getType'` uses `whnf` instead of `cleanupAnnotations`, and `MVarId.getType''` also uses `cleanu...
- `WeierstrassCurve.map_b₆` | module `Mathlib.AlgebraicGeometry.EllipticCurve.Weierstrass` | package Mathlib | **Transformation of the $b_6$ Invariant.** For a Weierstrass curve $W$ and a ring homomorphism $f$, the $b_6$ invariant of the curve mapped by $f$ is equal to the image of the $b_6$ invariant of $W$ under $f$.

## Grounded Mathlib/PhysLean names

- `Electromagnetism.ElectromagneticPotential.electricField` (PhysLean)
- `ChargeUnit.elementaryCharge` (PhysLean)
- `Electromagnetism.ElectricField` (PhysLean)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `FiniteDimensional` (Mathlib)
- `DimPressure` (PhysLean)
- `NVEHamiltonian.pressure` (PhysLean)
- `Lean.Meta.DiscrTree.keysSpecific` (Mathlib)
- `WithAbs.delabToAbs` (Mathlib)
- `AbstractMeasure` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `HahnSeries.single` (Mathlib)
- `Constants.ℏ` (PhysLean)
- `parallelogram_law` (Mathlib)
- `intervalIntegral` (Mathlib)
- `adiabatic_relation_log` (PhysLean)
- `CartanMatrix.B` (Mathlib)
- `CoxeterMatrix.B` (Mathlib)
- `Constants.kB` (PhysLean)
- `Lean.Meta.DiscrTree.keysSpecific` (Mathlib)
- `UnitChoices.dimScale` (PhysLean)
- `DimSpeed.oneMeterPerSecond_eq_mul_oneMilePerHour` (PhysLean)
- `Informal.constantInfoToInformalDefinition` (PhysLean)
- `AbsoluteValue` (Mathlib)
- `GenContFract.compExactValue_correctness_of_stream_eq_some` (Mathlib)
- `WeierstrassCurve.b₆` (Mathlib)
- `Lean.Elab.Tactic.getMainTarget''` (Mathlib)
- `WeierstrassCurve.map_b₆` (Mathlib)

## Local abstractions introduced

- `IPhO2026.Problem4.ConvertsMolarLatentHeatToSpecific`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.DimLength`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.InnerCylinderExperiment`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.IsClausiusClapeyronSlope`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.IsSpecificLatentHeatOf`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.MolarEnergy`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.MolarHeatCapacity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.MolarMass`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.PartB5Measurements`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.PartB6Input`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.Pressure`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.SatisfiesClausiusClapeyron`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.SpecificLatentHeat`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.SpecificLatentHeatValue`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

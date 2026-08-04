# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_3_C_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_1.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:73044def7e136f2fbe05b5b423b433ae2fa8b20417f44888292985b5fa43ccf2
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `electric charge`
- `Electromagnetism.ElectromagneticPotential.electricField` | module `Physlib.Electromagnetism.Kinematics.ElectricField` | package PhysLean | The electric field from the electromagnetic potential.
- `ChargeUnit.elementaryCharge` | module `Physlib.Electromagnetism.Charge.ChargeUnit` | package PhysLean | The charge unit of a elementryCharge (1.602176634×10−19 coulomb).
- `Electromagnetism.ElectricField` | module `Physlib.Electromagnetism.Basic` | package PhysLean | The electric field is a map from `d`+1 dimensional spacetime to the vector space `ℝ^d`.

### Query: `Temperature labels and heat processes`
- `Dimension.div_temperature` | module `Physlib.Units.Dimension` | package PhysLean | **Temperature dimension of a quotient.** The temperature dimension of the quotient of two physical dimensions is equal to the difference between the temperature dimension of the numerator and the temperature dimension...
- `CanonicalEnsemble.heatCapacity` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | The heat capacity (at constant volume) C_V = ∂U/∂T (as a derivWithin on T > 0).
- `Temperature.ofNNReal_val` | module `Physlib.Thermodynamics.Temperature.Basic` | package PhysLean | **Value of a Temperature from a Nonnegative Real.** For any nonnegative real number $t$, the numerical value of the temperature constructed from $t$ is equal to $t$ itself.

### Query: `Dimensionful volume`
- `Dimensionful` | module `Physlib.Units.Basic` | package PhysLean | The subtype of functions `UnitChoices → M`, for which `M` carries a dimension, which `HasDimension`.
- `dimH` | module `Mathlib.Topology.MetricSpace.HausdorffDimension` | package Mathlib | Hausdorff dimension of a set in an (e)metric space.
- `CarriesDimension.toDimensionful` | module `Physlib.Units.Basic` | package PhysLean | For `M` carrying a dimension `d`, the equivalence between `M` and `Dimension M`, given a choice of units.

### Query: `Dimensionful magnetic intensity`
- `Electromagnetism.ElectromagneticPotential.magneticFieldMatrix` | module `Physlib.Electromagnetism.Kinematics.MagneticField` | package PhysLean | The matrix corresponding to the magnetic field in general dimensions. In `3` space-dimensions this reduces to a vector.
- `Dimensionful` | module `Physlib.Units.Basic` | package PhysLean | The subtype of functions `UnitChoices → M`, for which `M` carries a dimension, which `HasDimension`.
- `Electromagnetism.MagneticField` | module `Physlib.Electromagnetism.Basic` | package PhysLean | The magnetic field is a map from `d+1` dimensional spacetime to the vector space `ℝ^d`.

### Query: `Dimensionful vacuum permeability`
- `Dimensionful` | module `Physlib.Units.Basic` | package PhysLean | The subtype of functions `UnitChoices → M`, for which `M` carries a dimension, which `HasDimension`.
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `Electromagnetism.FreeSpace.ε₀_ne_zero` | module `Physlib.Electromagnetism.Dynamics.Basic` | package PhysLean | **Non-zero Vacuum Permittivity.** In any free space, the vacuum permittivity $\varepsilon_0$ is non-zero.

### Query: `SI coordinate`
- `UnitChoices.SI` | module `Physlib.Units.Basic` | package PhysLean | The choice of units corresponding to SI units, that is - meters, - seconds, - kilograms, - coulombs, - kelvin.
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `UnitChoices.SI_time` | module `Physlib.Units.Basic` | package PhysLean | **The SI Unit of Time.** In the International System of Units (SI), the fundamental unit of time is defined to be the second.

### Query: `Temperature coordinate`
- `Temperature` | module `Physlib.Thermodynamics.Temperature.Basic` | package PhysLean | The type `Temperature` represents the temperature in a given (but arbitrary) set of units (preserving zero). It currently wraps `ℝ≥0`, i.e., absolute temperature in nonnegative reals.
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `Dimension.Θ𝓭` | module `Physlib.Units.Dimension` | package PhysLean | The dimension corresponding to temperature.

### Query: `Heat in joules`
- `JoinedIn` | module `Mathlib.Topology.Connected.PathConnected` | package Mathlib | The relation "being joined by a path in `F`". Not quite an equivalence relation since it's not reflexive for points that do not belong to `F`.
- `CanonicalEnsemble.heatCapacity` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | The heat capacity (at constant volume) C_V = ∂U/∂T (as a derivWithin on T > 0).
- `DimEnergy.kilowattHour` | module `Physlib.Units.WithDim.Energy` | package PhysLean | The dimensional energy corresponding to 1 kilowatt-hours, (3,600,000 J).

### Query: `Cycle points`
- `Cycle` | module `Mathlib.Data.List.Cycle` | package Mathlib | `Cycle α` is the quotient of `List α` by cyclic permutation. Duplicates are allowed.
- `Equiv.Perm.SameCycle` | module `Mathlib.GroupTheory.Perm.Cycle.Basic` | package Mathlib | The equivalence relation indicating that two points are in the same cycle of a permutation.
- `Equiv.Perm.isCycle_iff_exists_isCycleOn` | module `Mathlib.GroupTheory.Perm.Cycle.Basic` | package Mathlib | This lemma demonstrates the relation between `Equiv.Perm.IsCycle` and `Equiv.Perm.IsCycleOn` in non-degenerate cases.

### Query: `Oriented cycle legs`
- `EuclideanGeometry.oangle` | module `Mathlib.Geometry.Euclidean.Angle.Oriented.Affine` | package Mathlib | The oriented angle at `p₂` between the line segments to `p₁` and `p₃`, modulo `2 * π`. If either of those points equals `p₂`, this is 0. See `EuclideanGeometry.angle` for the corresponding unoriented angle definition.
- `Module.Oriented` | module `Mathlib.LinearAlgebra.Orientation` | package Mathlib | A type class fixing an orientation of a module.
- `IsEmpty.oriented` | module `Mathlib.LinearAlgebra.Orientation` | package Mathlib | A module is canonically oriented with respect to an empty index type.

## Grounded Mathlib/PhysLean names

- `Electromagnetism.ElectromagneticPotential.electricField` (PhysLean)
- `ChargeUnit.elementaryCharge` (PhysLean)
- `Electromagnetism.ElectricField` (PhysLean)
- `Dimension.div_temperature` (PhysLean)
- `CanonicalEnsemble.heatCapacity` (PhysLean)
- `Temperature.ofNNReal_val` (PhysLean)
- `Dimensionful` (PhysLean)
- `dimH` (Mathlib)
- `CarriesDimension.toDimensionful` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.magneticFieldMatrix` (PhysLean)
- `Dimensionful` (PhysLean)
- `Electromagnetism.MagneticField` (PhysLean)
- `Dimensionful` (PhysLean)
- `HahnSeries.orderTop` (Mathlib)
- `Electromagnetism.FreeSpace.ε₀_ne_zero` (PhysLean)
- `UnitChoices.SI` (PhysLean)
- `HahnSeries.orderTop` (Mathlib)
- `UnitChoices.SI_time` (PhysLean)
- `Temperature` (PhysLean)
- `HahnSeries.orderTop` (Mathlib)
- `Dimension.Θ𝓭` (PhysLean)
- `JoinedIn` (Mathlib)
- `CanonicalEnsemble.heatCapacity` (PhysLean)
- `DimEnergy.kilowattHour` (PhysLean)
- `Cycle` (Mathlib)
- `Equiv.Perm.SameCycle` (Mathlib)
- `Equiv.Perm.isCycle_iff_exists_isCycleOn` (Mathlib)
- `EuclideanGeometry.oangle` (Mathlib)
- `Module.Oriented` (Mathlib)
- `IsEmpty.oriented` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problems.ProblemIPhO2026_3_C_1.CycleLeg`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.CyclePoint`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.DimMagneticIntensity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.DimVacuumPermeability`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.DimVolume`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.Figure3bCarnotCycle`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.Figure3bGeometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.HeatTransfer`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.ParamagneticTorus`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.ProcessKind`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.Reservoir`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.SatisfiesCarnotRefrigeratorLaws`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.SatisfiesIsothermalHeatRelation`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.SatisfiesParamagneticEquationOfState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.TorusState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

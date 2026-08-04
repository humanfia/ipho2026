# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_1.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:07e86145f078cd4c96eae5e4e7f7696ba811209dd96074a0832cebe075b3e934
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Declaration LengthQuantity`
- `«command#long_names_»` | module `Mathlib.Util.LongNames` | package Mathlib | Lists all declarations with a long name, gathered according to the module they are defined in. Use as `#long_names` or `#long_names 100` to specify the length.
- `Mathlib.Tactic.ClickSuggestions.SectionKind` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | Whether the section corresponds to local hypotheses, declarations from the current file, or imported declarations.
- `Mathlib.Tactic.ClickSuggestions.SectionKind.imported` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | **Classification of Declaration Sources.** The source of a declaration is categorized into one of three kinds: a local hypothesis, a declaration within the current file, or a declaration from an imported module.

### Query: `Declaration VolumeQuantity`
- `Orientation.volumeForm` | module `Mathlib.Analysis.InnerProductSpace.Orientation` | package Mathlib | The volume form on an oriented real inner product space, a nonvanishing top-dimensional alternating form uniquely defined by compatibility with the orientation and inner product structure.
- `«command#long_names_»` | module `Mathlib.Util.LongNames` | package Mathlib | Lists all declarations with a long name, gathered according to the module they are defined in. Use as `#long_names` or `#long_names 100` to specify the length.
- `MeasureTheory.Measure.volumeIoiPow` | module `Mathlib.MeasureTheory.Constructions.HaarToSphere` | package Mathlib | The measure on `(0, +∞)` that has density `(· ^ n)` with respect to the Lebesgue measure.

### Query: `Declaration MassQuantity`
- `Finset.centerMass` | module `Mathlib.Analysis.Convex.Combination` | package Mathlib | Center of mass of a finite collection of points with prescribed weights. Note that we require neither `0 ≤ w i` nor `∑ w = 1`.
- `MassUnit.quarters` | module `Physlib.ClassicalMechanics.Mass.MassUnit` | package PhysLean | The mass unit of a quarter (28 pounds).
- `MassUnit` | module `Physlib.ClassicalMechanics.Mass.MassUnit` | package PhysLean | The choices of translationally-invariant metrics on the mass-manifold. Such a choice corresponds to a choice of units for mass.

### Query: `Declaration TemperatureQuantity`
- `Dimension.div_temperature` | module `Physlib.Units.Dimension` | package PhysLean | **Temperature dimension of a quotient.** The temperature dimension of the quotient of two physical dimensions is equal to the difference between the temperature dimension of the numerator and the temperature dimension...
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `Temperature` | module `Physlib.Thermodynamics.Temperature.Basic` | package PhysLean | The type `Temperature` represents the temperature in a given (but arbitrary) set of units (preserving zero). It currently wraps `ℝ≥0`, i.e., absolute temperature in nonnegative reals.

### Query: `Declaration MassDensityQuantity`
- `MeasureTheory.Measure.withDensity` | module `Mathlib.MeasureTheory.Measure.WithDensity` | package Mathlib | Given a measure `μ : Measure α` and a function `f : α → ℝ≥0∞`, `μ.withDensity f` is the measure such that for a measurable set `s` we have `μ.withDensity f s = ∫⁻ a in s, f a ∂μ`.
- `FluidDynamics.MassDensity` | module `Physlib.FluidDynamics.FluidState` | package PhysLean | A mass density field on `d`-dimensional space.
- `MassUnit.instInhabited` | module `Physlib.ClassicalMechanics.Mass.MassUnit` | package PhysLean | **Inhabited Mass Units.** The type of mass units is inhabited, with a default value defined as the mass unit corresponding to the positive real number $1$.

### Query: `Declaration siValue`
- `UnitChoices.SI` | module `Physlib.Units.Basic` | package PhysLean | The choice of units corresponding to SI units, that is - meters, - seconds, - kilograms, - coulombs, - kelvin.
- `UnitChoices.SI_time` | module `Physlib.Units.Basic` | package PhysLean | **The SI Unit of Time.** In the International System of Units (SI), the fundamental unit of time is defined to be the second.
- `UnitChoices.SI_temperature` | module `Physlib.Units.Basic` | package PhysLean | **SI Temperature Unit.** In the International System of Units (SI), the designated unit for temperature is the kelvin.

### Query: `Declaration AmountOfSubstance`
- `orderOf` | module `Mathlib.GroupTheory.OrderOfElement` | package Mathlib | `orderOf x` is the order of the element `x`, i.e. the `n ≥ 1`, s.t. `x ^ n = 1` if it exists. Otherwise, i.e. if `x` is of infinite order, then `orderOf x` is `0` by convention.
- `Mathlib.Tactic.ClickSuggestions.SectionKind` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | Whether the section corresponds to local hypotheses, declarations from the current file, or imported declarations.
- `setOf` | module `Mathlib.Data.Set.Defs` | package Mathlib | Turn a predicate `p : α → Prop` into a set, also written as `{x | p x}`

### Query: `Declaration MoleculePopulation`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `HahnSeries.order` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The order of a nonzero Hahn series `x` is a minimal element of `Γ` where `x` has a nonzero coefficient, the order of 0 is 0.
- `HahnSeries.single` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | `single a r` is the Hahn series which has coefficient `r` at `a` and zero otherwise.

### Query: `Declaration ScalarMeasurement`
- `IsScalarTower` | module `Mathlib.Algebra.Group.Action.Defs` | package Mathlib | An instance of `IsScalarTower M N α` states that the multiplicative action of `M` on `α` is determined by the multiplicative actions of `M` on `N` and `N` on `α`.
- `MeasurableSMul` | module `Mathlib.MeasureTheory.Group.Arithmetic` | package Mathlib | We say that the action of `M` on `α` has `MeasurableSMul` if for each `c` the map `x ↦ c • x` is a measurable function and for each `x` the map `c ↦ c • x` is a measurable function.
- `MeasureTheory.FiniteMeasure.smul_apply` | module `Mathlib.MeasureTheory.Measure.FiniteMeasure` | package Mathlib | **Scalar Multiplication of Finite Measures.** For a finite measure $\mu$ on a measurable space $\Omega$, a scalar $c$ from a type $R$ acting on $\mathbb{R}_{\geq 0}$, and any measurable set $s \subseteq \Omega$, the m...

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `«command#long_names_»` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind.imported` (Mathlib)
- `Orientation.volumeForm` (Mathlib)
- `«command#long_names_»` (Mathlib)
- `MeasureTheory.Measure.volumeIoiPow` (Mathlib)
- `Finset.centerMass` (Mathlib)
- `MassUnit.quarters` (PhysLean)
- `MassUnit` (PhysLean)
- `Dimension.div_temperature` (PhysLean)
- `HahnSeries.orderTop` (Mathlib)
- `Temperature` (PhysLean)
- `MeasureTheory.Measure.withDensity` (Mathlib)
- `FluidDynamics.MassDensity` (PhysLean)
- `MassUnit.instInhabited` (PhysLean)
- `UnitChoices.SI` (PhysLean)
- `UnitChoices.SI_time` (PhysLean)
- `UnitChoices.SI_temperature` (PhysLean)
- `orderOf` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind` (Mathlib)
- `setOf` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `HahnSeries.order` (Mathlib)
- `HahnSeries.single` (Mathlib)
- `IsScalarTower` (Mathlib)
- `MeasurableSMul` (Mathlib)
- `MeasureTheory.FiniteMeasure.smul_apply` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problems.Problem4A1.AgreesWithOfficialSample`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.AirInventoryLaws`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.AmbientDensityReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.AmountOfSubstance`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.ConfinedAirColumnState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.ExperimentalInputReadouts`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.Figure17Geometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.Figure17GeometryLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.InputReadoutsCover`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.InventoryInPropagatedBounds`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.InventoryReport`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.IsochoricApparatusRun`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.LengthQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.MassDensityQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.MassQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.MoleculePopulation`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.ScalarMeasurement`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.ScalarMeasurement.Covers`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.TemperatureQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.ValidInputReadouts`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.ValveLabel`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem4A1.VolumeQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

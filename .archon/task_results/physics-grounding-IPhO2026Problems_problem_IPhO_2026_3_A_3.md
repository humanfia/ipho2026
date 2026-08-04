# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_3_A_3.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_3.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:4e8445be76e7222694f038f65d6a299850fa0ee7c60ae51df58dee19430e3a85
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

### Query: `Declaration Length`
- `«command#long_names_»` | module `Mathlib.Util.LongNames` | package Mathlib | Lists all declarations with a long name, gathered according to the module they are defined in. Use as `#long_names` or `#long_names 100` to specify the length.
- `Mathlib.Tactic.ClickSuggestions.SectionKind` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | Whether the section corresponds to local hypotheses, declarations from the current file, or imported declarations.
- `Physlib.HTMLNote.ofFormal` | module `Physlib.Meta.Notes.HTMLNote` | package PhysLean | An formal definition or lemma to html for a note.

### Query: `Declaration Volume`
- `Orientation.volumeForm` | module `Mathlib.Analysis.InnerProductSpace.Orientation` | package Mathlib | The volume form on an oriented real inner product space, a nonvanishing top-dimensional alternating form uniquely defined by compatibility with the orientation and inner product structure.
- `MeasureTheory.Measure.volumeIoiPow` | module `Mathlib.MeasureTheory.Constructions.HaarToSphere` | package Mathlib | The measure on `(0, +∞)` that has density `(· ^ n)` with respect to the Lebesgue measure.
- `«command#long_names_»` | module `Mathlib.Util.LongNames` | package Mathlib | Lists all declarations with a long name, gathered according to the module they are defined in. Use as `#long_names` or `#long_names 100` to specify the length.

### Query: `Declaration Area`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `DimArea` | module `Physlib.Units.WithDim.Area` | package PhysLean | The type of areas in the absence of a choice of unit.
- `DimArea.hectare` | module `Physlib.Units.WithDim.Area` | package PhysLean | The dimensional area corresponding to 1 hectare (10,000 square meters).

### Query: `Declaration ElectricCurrent`
- `Electromagnetism.ElectromagneticPotential.electricField` | module `Physlib.Electromagnetism.Kinematics.ElectricField` | package PhysLean | The electric field from the electromagnetic potential.
- `Mathlib.Tactic.ClickSuggestions.SectionKind.currFile` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | **Current File Section.** Within the classification of declaration sources, this represents the case where a declaration originates from the current file.
- `Electromagnetism.CurrentDensity` | module `Physlib.Electromagnetism.Basic` | package PhysLean | Current density.

### Query: `Declaration MagneticFieldStrength`
- `Electromagnetism.ElectromagneticPotential.magneticFieldMatrix` | module `Physlib.Electromagnetism.Kinematics.MagneticField` | package PhysLean | The matrix corresponding to the magnetic field in general dimensions. In `3` space-dimensions this reduces to a vector.
- `Electromagnetism.ElectromagneticPotential.magneticField_coord_eq_fieldStrengthMatrix` | module `Physlib.Electromagnetism.Kinematics.MagneticField` | package PhysLean | **Magnetic Field Components as Field Strength Matrix Elements.** For an electromagnetic potential $A$ that is differentiable over $\mathbb{R}$, the $i$-th spatial component of the magnetic field $\mathbf{B}$ at time $...
- `Electromagnetism.ElectromagneticPotential.magneticField` | module `Physlib.Electromagnetism.Kinematics.MagneticField` | package PhysLean | The magnetic field from the electromagnetic potential.

### Query: `Declaration Magnetization`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `Mathlib.Tactic.registerGeneratingAttr` | module `Mathlib.Tactic.Translate.Attributes` | package Mathlib | For an attribute that generates new declarations, register the implementation that returns the generated declarations. This will be used by translation attributes for translating between generated declarations.
- `HahnSeries.order` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The order of a nonzero Hahn series `x` is a minimal element of `Γ` where `x` has a nonzero coefficient, the order of 0 is 0.

### Query: `Declaration MagneticFluxDensity`
- `Electromagnetism.ElectromagneticPotential.magneticField_div_eq_zero` | module `Physlib.Electromagnetism.Kinematics.MagneticField` | package PhysLean | **Divergence of the Magnetic Field.** For any electromagnetic potential $A$ that is twice continuously differentiable, the divergence of the associated magnetic field $\mathbf{B} = \nabla \times \mathbf{A}$ is zero at...
- `MeasureTheory.Measure.withDensity` | module `Mathlib.MeasureTheory.Measure.WithDensity` | package Mathlib | Given a measure `μ : Measure α` and a function `f : α → ℝ≥0∞`, `μ.withDensity f` is the measure such that for a measurable set `s` we have `μ.withDensity f s = ∫⁻ a in s, f a ∂μ`.
- `FluidDynamics.NavierStokes.momentumFlux` | module `Physlib.FluidDynamics.NavierStokes.Momentum` | package PhysLean | The convective momentum flux `rho u ⊗ u`.

### Query: `Declaration VacuumPermeability`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `Electromagnetism.FreeSpace.ε₀_ne_zero` | module `Physlib.Electromagnetism.Dynamics.Basic` | package PhysLean | **Non-zero Vacuum Permittivity.** In any free space, the vacuum permittivity $\varepsilon_0$ is non-zero.
- `Equiv.Perm.isCycleOn_empty` | module `Mathlib.GroupTheory.Perm.Cycle.Basic` | package Mathlib | **Permutation Cycle on the Empty Set.** Any permutation $f$ is vacuously a cycle on the empty set.

## Grounded Mathlib/PhysLean names

- `Electromagnetism.ElectromagneticPotential.electricField` (PhysLean)
- `ChargeUnit.elementaryCharge` (PhysLean)
- `Electromagnetism.ElectricField` (PhysLean)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `«command#long_names_»` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind` (Mathlib)
- `Physlib.HTMLNote.ofFormal` (PhysLean)
- `Orientation.volumeForm` (Mathlib)
- `MeasureTheory.Measure.volumeIoiPow` (Mathlib)
- `«command#long_names_»` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `DimArea` (PhysLean)
- `DimArea.hectare` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.electricField` (PhysLean)
- `Mathlib.Tactic.ClickSuggestions.SectionKind.currFile` (Mathlib)
- `Electromagnetism.CurrentDensity` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.magneticFieldMatrix` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.magneticField_coord_eq_fieldStrengthMatrix` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.magneticField` (PhysLean)
- `HahnSeries.orderTop` (Mathlib)
- `Mathlib.Tactic.registerGeneratingAttr` (Mathlib)
- `HahnSeries.order` (Mathlib)
- `Electromagnetism.ElectromagneticPotential.magneticField_div_eq_zero` (PhysLean)
- `MeasureTheory.Measure.withDensity` (Mathlib)
- `FluidDynamics.NavierStokes.momentumFlux` (PhysLean)
- `HahnSeries.orderTop` (Mathlib)
- `Electromagnetism.FreeSpace.ε₀_ne_zero` (PhysLean)
- `Equiv.Perm.isCycleOn_empty` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problems.Problem3A3.Area`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3A3.Assumptions`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3A3.ElectricCurrent`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3A3.Energy`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3A3.FieldIncrements`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3A3.Length`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3A3.MagneticFieldStrength`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3A3.MagneticFluxDensity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3A3.Magnetization`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3A3.ToroidalOrientation`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3A3.TorusData`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3A3.VacuumPermeability`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3A3.Volume`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3A3.WorkIncrements`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3A3.WorkSignConvention`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

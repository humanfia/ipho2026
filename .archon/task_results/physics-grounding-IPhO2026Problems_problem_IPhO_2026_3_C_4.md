# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:5f6e2fee099d867e8898b3d4cbf0ec8598cb16cd898fe8fd9f9b8bd308e241f3
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Declaration EnergyDimension`
- `DimEnergy` | module `Physlib.Units.WithDim.Energy` | package PhysLean | Energy as a dimensional quantity with dimension `MLT⁻2`..
- `Finset.addEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The additive energy `E[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ + b₁ = a₂ + b₂`. The notation `E[s, t]` is available in scope `Combinato...
- `Finset.mulEnergy` | module `Mathlib.Combinatorics.Additive.Energy` | package Mathlib | The multiplicative energy `Eₘ[s, t]` of two finsets `s` and `t` in a group is the number of quadruples `(a₁, a₂, b₁, b₂) ∈ s × s × t × t` such that `a₁ * b₁ = a₂ * b₂`. The notation `Eₘ[s, t]` is available in scope `C...

### Query: `Declaration TemperatureQuantity`
- `Dimension.div_temperature` | module `Physlib.Units.Dimension` | package PhysLean | **Temperature dimension of a quotient.** The temperature dimension of the quotient of two physical dimensions is equal to the difference between the temperature dimension of the numerator and the temperature dimension...
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `Temperature` | module `Physlib.Thermodynamics.Temperature.Basic` | package PhysLean | The type `Temperature` represents the temperature in a given (but arbitrary) set of units (preserving zero). It currently wraps `ℝ≥0`, i.e., absolute temperature in nonnegative reals.

### Query: `Declaration TimeQuantity`
- `Time` | module `Physlib.SpaceAndTime.Time.Basic` | package PhysLean | The type `Time` represents the time in a given (but arbitrary) set of units, and with a given (but arbitrary) choice of origin.
- `Mathlib.Tactic.ClickSuggestions.SectionKind` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | Whether the section corresponds to local hypotheses, declarations from the current file, or imported declarations.
- `Mathlib.Tactic.ClickSuggestions.SectionKind.imported` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | **Classification of Declaration Sources.** The source of a declaration is categorized into one of three kinds: a local hypothesis, a declaration within the current file, or a declaration from an imported module.

### Query: `Declaration VolumeQuantity`
- `Orientation.volumeForm` | module `Mathlib.Analysis.InnerProductSpace.Orientation` | package Mathlib | The volume form on an oriented real inner product space, a nonvanishing top-dimensional alternating form uniquely defined by compatibility with the orientation and inner product structure.
- `«command#long_names_»` | module `Mathlib.Util.LongNames` | package Mathlib | Lists all declarations with a long name, gathered according to the module they are defined in. Use as `#long_names` or `#long_names 100` to specify the length.
- `MeasureTheory.Measure.volumeIoiPow` | module `Mathlib.MeasureTheory.Constructions.HaarToSphere` | package Mathlib | The measure on `(0, +∞)` that has density `(· ^ n)` with respect to the Lebesgue measure.

### Query: `Declaration MagneticFieldStrengthQuantity`
- `Electromagnetism.ElectromagneticPotential.magneticFieldMatrix` | module `Physlib.Electromagnetism.Kinematics.MagneticField` | package PhysLean | The matrix corresponding to the magnetic field in general dimensions. In `3` space-dimensions this reduces to a vector.
- `Electromagnetism.ElectromagneticPotential.magneticField_coord_eq_fieldStrengthMatrix` | module `Physlib.Electromagnetism.Kinematics.MagneticField` | package PhysLean | **Magnetic Field Components as Field Strength Matrix Elements.** For an electromagnetic potential $A$ that is differentiable over $\mathbb{R}$, the $i$-th spatial component of the magnetic field $\mathbf{B}$ at time $...
- `Electromagnetism.ElectromagneticPotential.magneticField` | module `Physlib.Electromagnetism.Kinematics.MagneticField` | package PhysLean | The magnetic field from the electromagnetic potential.

### Query: `Declaration HeatCapacityQuantity`
- `CanonicalEnsemble.heatCapacity` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | The heat capacity (at constant volume) C_V = ∂U/∂T (as a derivWithin on T > 0).
- `CanonicalEnsemble.heatCapacity_eq_deriv_meanEnergyBeta` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | Relates C_V = dU/dT to dU/dβ. C_V = dU/dβ * (-1/(kB T²)).
- `CanonicalEnsemble.fluctuation_dissipation_energy_parametric` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | Parametric FDT: C_V = Var(E)/(kB T²), assuming Var(E) = - dU/dβ.

### Query: `Declaration PowerQuantity`
- `PowerSeries` | module `Mathlib.RingTheory.PowerSeries.Basic` | package Mathlib | Formal power series over a coefficient type `R`
- `Mathlib.Tactic.ClickSuggestions.SectionKind` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | Whether the section corresponds to local hypotheses, declarations from the current file, or imported declarations.
- `Mathlib.Tactic.ClickSuggestions.SectionKind.imported` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | **Classification of Declaration Sources.** The source of a declaration is categorized into one of three kinds: a local hypothesis, a declaration within the current file, or a declaration from an imported module.

### Query: `Declaration CarnotCycleState`
- `Stream'.cycleG` | module `Mathlib.Data.Stream.Defs` | package Mathlib | An auxiliary definition for `Stream'.cycle` corecursive def
- `Cycle` | module `Mathlib.Data.List.Cycle` | package Mathlib | `Cycle α` is the quotient of `List α` by cyclic permutation. Duplicates are allowed.
- `adiabatic_relation_UaUbVaVb` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in product form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then (Ua/Ub)^c * (Va/Vb) = 1.

### Query: `Declaration next`
- `List.next` | module `Mathlib.Data.List.Cycle` | package Mathlib | Given an element `x : α` of `l : List α` such that `x ∈ l`, get the next element of `l`. This works from head to tail, (including a check for last element) so it will match on first hit, ignoring later duplicates. For...
- `Lean.LocalContext.lastDeclM` | module `Mathlib.Lean.LocalContext` | package Mathlib | Return the result of `f` on the last local declaration on which `f` succeeds.
- `Cycle.next` | module `Mathlib.Data.List.Cycle` | package Mathlib | Given a `s : Cycle α` such that `Nodup s`, retrieve the next element after `x ∈ s`.

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `DimEnergy` (PhysLean)
- `Finset.addEnergy` (Mathlib)
- `Finset.mulEnergy` (Mathlib)
- `Dimension.div_temperature` (PhysLean)
- `HahnSeries.orderTop` (Mathlib)
- `Temperature` (PhysLean)
- `Time` (PhysLean)
- `Mathlib.Tactic.ClickSuggestions.SectionKind` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind.imported` (Mathlib)
- `Orientation.volumeForm` (Mathlib)
- `«command#long_names_»` (Mathlib)
- `MeasureTheory.Measure.volumeIoiPow` (Mathlib)
- `Electromagnetism.ElectromagneticPotential.magneticFieldMatrix` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.magneticField_coord_eq_fieldStrengthMatrix` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.magneticField` (PhysLean)
- `CanonicalEnsemble.heatCapacity` (PhysLean)
- `CanonicalEnsemble.heatCapacity_eq_deriv_meanEnergyBeta` (PhysLean)
- `CanonicalEnsemble.fluctuation_dissipation_energy_parametric` (PhysLean)
- `PowerSeries` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind.imported` (Mathlib)
- `Stream'.cycleG` (Mathlib)
- `Cycle` (Mathlib)
- `adiabatic_relation_UaUbVaVb` (PhysLean)
- `List.next` (Mathlib)
- `Lean.LocalContext.lastDeclM` (Mathlib)
- `Cycle.next` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problems.IPhO2026_3_C_4.CarnotCoolingExperiment`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.CarnotCoolingProcess`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.CarnotCycleState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.EnergyDimension`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.HeatCapacityQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.MagneticFieldStrengthQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.ParamagneticTorusContext`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.PowerQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.SatisfiesCarnotCoolingLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.TemperatureQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.TimeQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO2026_3_C_4.VolumeQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

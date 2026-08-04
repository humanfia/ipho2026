# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_3.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:071fb40637abdab31b443089fbf2d3de88b34da3bee264954d6beb32c1a0c117
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Real.sqrt square root`
- `Real.sqrt` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | The square root of a real number. This returns 0 for negative inputs. This has notation `√x`. Note that `√x⁻¹` is parsed as `√(x⁻¹)`.
- `Real.coe_sqrt` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | **Square Root of Nonnegative Reals.** For any nonnegative real number $x$, the real-valued square root of $x$ is equal to the square root of $x$ computed in the nonnegative real numbers and then cast to a real number.
- `Real.sqrt_lt'` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | **Strict Monotonicity of the Square Root.** For any real number $x$ and any positive real number $y$, the square root of $x$ is strictly less than $y$ if and only if $x$ is strictly less than $y^2$.

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Declaration PhysicalRole`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `CanonicalEnsemble.physicalProbability` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Basic` | package PhysLean | The dimensionless physical probability density. This is is the probability density w.r.t. the measure, obtained by dividing the phase space measure by the fundamental unit `h^dof`, making the probability density `ρ_ph...
- `Lean.Name.hasPos` | module `Physlib.Meta.Basic` | package PhysLean | Determines if a name has a location.

### Query: `Declaration PhysicalRole.dimension`
- `Dimension` | module `Physlib.Units.Dimension` | package PhysLean | The foundational dimensions. Defined in the order ⟨length, time, mass, charge, temperature⟩
- `SSet.HasDimensionLT` | module `Mathlib.AlgebraicTopology.SimplicialSet.Dimension` | package Mathlib | A simplicial set `X` has dimension `< d` iff for any `n : ℕ` such that `d ≤ n`, all `n`-simplices are degenerate.
- `CanonicalEnsemble.physicalProbability` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Basic` | package PhysLean | The dimensionless physical probability density. This is is the probability density w.r.t. the measure, obtained by dividing the phase space measure by the fundamental unit `h^dof`, making the probability density `ρ_ph...

### Query: `Declaration SIQuantity`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `UnitChoices.SI` | module `Physlib.Units.Basic` | package PhysLean | The choice of units corresponding to SI units, that is - meters, - seconds, - kilograms, - coulombs, - kelvin.
- `UnitChoices.SI_charge` | module `Physlib.Units.Basic` | package PhysLean | **SI Charge Unit.** In the International System of Units (SI), the fundamental unit of electric charge is defined to be the coulomb.

### Query: `Declaration SIQuantity.siValue`
- `UnitChoices.SI` | module `Physlib.Units.Basic` | package PhysLean | The choice of units corresponding to SI units, that is - meters, - seconds, - kilograms, - coulombs, - kelvin.
- `DimSpeed.speedOfLight_in_SI` | module `Physlib.Units.WithDim.Speed` | package PhysLean | **Value of the Speed of Light in SI Units.** The speed of light, when expressed in the International System of Units (SI), is exactly $299,792,458$.
- `DimArea.hectare_in_SI` | module `Physlib.Units.WithDim.Area` | package PhysLean | **Value of a Hectare in SI Units.** In the SI unit system, the value of one hectare is exactly $10,000$.

### Query: `Declaration CyclePoint`
- `Equiv.Perm.toCycle` | module `Mathlib.GroupTheory.Perm.Cycle.Concrete` | package Mathlib | Given a cyclic `f : Perm α`, generate the `Cycle α` in the order of application of `f`. Implemented by finding an element `x : α` in the support of `f` in `Finset.univ`, and iterating on using `Equiv.Perm.toList f x`.
- `Equiv.Perm.SameCycle` | module `Mathlib.GroupTheory.Perm.Cycle.Basic` | package Mathlib | The equivalence relation indicating that two points are in the same cycle of a permutation.
- `Equiv.Perm.IsCycle` | module `Mathlib.GroupTheory.Perm.Cycle.Basic` | package Mathlib | A cycle is a non-identity permutation where any two nonfixed points of the permutation are related by repeated application of the permutation.

### Query: `Declaration CarnotLegKind`
- `Mathlib.CrossRef.kerodonTags` | module `Mathlib.Tactic.CrossRefAttribute` | package Mathlib | The `#kerodon_tags` command retrieves all declarations that have the `kerodon` attribute. For each found declaration, it prints a line ``` 'declaration_name' corresponds to tag 'declaration_tag'. ``` The variant `#ker...
- `Lean.ConstantInfo.toDeclaration!` | module `Mathlib.Lean.Expr.Basic` | package Mathlib | Turn a `ConstantInfo` into a declaration.
- `Mathlib.Tactic.ClickSuggestions.SectionKind` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | Whether the section corresponds to local hypotheses, declarations from the current file, or imported declarations.

### Query: `Declaration TorusStateReading`
- `torusMap` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | The n-dimensional exponential map $θ_i ↦ c + R e^{θ_i*I}, θ ∈ ℝⁿ$ representing a torus in `ℂⁿ` with center `c ∈ ℂⁿ` and generalized radius `R ∈ ℝⁿ`, so we can adjust it to every n axis.
- `torusIntegral` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | The integral over a generalized torus with center `c ∈ ℂⁿ` and radius `R ∈ ℝⁿ`, defined as the `•`-product of the derivative of `torusMap` and `f (torusMap c R θ)`
- `TorusIntegrable` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | A function `f : ℂⁿ → E` is integrable on the generalized torus if the function `f ∘ torusMap c R θ` is integrable on `Icc (0 : ℝⁿ) (fun _ ↦ 2 * π)`.

### Query: `Declaration CarnotTorusCycle`
- `torusMap` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | The n-dimensional exponential map $θ_i ↦ c + R e^{θ_i*I}, θ ∈ ℝⁿ$ representing a torus in `ℂⁿ` with center `c ∈ ℂⁿ` and generalized radius `R ∈ ℝⁿ`, so we can adjust it to every n axis.
- `Equiv.Perm.IsCycle` | module `Mathlib.GroupTheory.Perm.Cycle.Basic` | package Mathlib | A cycle is a non-identity permutation where any two nonfixed points of the permutation are related by repeated application of the permutation.
- `torusMap_eq_center_iff` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | **Equality of the Torus Map and its Center.** For a center $c \in \mathbb{C}^n$, a vector of radii $R \in \mathbb{R}^n$, and an angular vector $\theta \in \mathbb{R}^n$, the value of the torus map at $\theta$ is equal...

## Grounded Mathlib/PhysLean names

- `Real.sqrt` (Mathlib)
- `Real.coe_sqrt` (Mathlib)
- `Real.sqrt_lt'` (Mathlib)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `CanonicalEnsemble.physicalProbability` (PhysLean)
- `Lean.Name.hasPos` (PhysLean)
- `Dimension` (PhysLean)
- `SSet.HasDimensionLT` (Mathlib)
- `CanonicalEnsemble.physicalProbability` (PhysLean)
- `HahnSeries.orderTop` (Mathlib)
- `UnitChoices.SI` (PhysLean)
- `UnitChoices.SI_charge` (PhysLean)
- `UnitChoices.SI` (PhysLean)
- `DimSpeed.speedOfLight_in_SI` (PhysLean)
- `DimArea.hectare_in_SI` (PhysLean)
- `Equiv.Perm.toCycle` (Mathlib)
- `Equiv.Perm.SameCycle` (Mathlib)
- `Equiv.Perm.IsCycle` (Mathlib)
- `Mathlib.CrossRef.kerodonTags` (Mathlib)
- `Lean.ConstantInfo.toDeclaration!` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind` (Mathlib)
- `torusMap` (Mathlib)
- `torusIntegral` (Mathlib)
- `TorusIntegrable` (Mathlib)
- `torusMap` (Mathlib)
- `Equiv.Perm.IsCycle` (Mathlib)
- `torusMap_eq_center_iff` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problems.Problem3C3.CarnotIsothermalHeatLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.CarnotLegKind`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.CarnotTemperaturePattern`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.CarnotTorusCycle`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.CycleHeatExchange`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.CyclePoint`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.HeliumCalorimetryLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.IPhO_2026_3_C_3_helium_temperature_after_one_cycle`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.LiquidHeliumSample`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.ParamagneticEquationOfState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.ParamagneticTorus`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.PhysicalRole`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.PreviousPartC2MagnetizationRelation`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.RefrigerationSetup`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.SIQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.SuppliedReadouts`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.TorusStateReading`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.Problem3C3.TorusVolumeMassBalance`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

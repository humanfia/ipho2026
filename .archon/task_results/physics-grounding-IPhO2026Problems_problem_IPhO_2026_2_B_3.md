# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_2_B_3.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_3.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:5a6e9b53986f9a762c37b74b46aafd8863f564e0e208761ff7a2f5676e546d9e
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Declaration radiantPowerDimension`
- `Dimension.instPowRat` | module `Physlib.Units.Dimension` | package PhysLean | **Rational Power of a Physical Dimension.** For any physical dimension $d$ and any rational number $n$, the power $d^n$ is defined as the dimension whose fundamental components—length, time, mass, charge, and temperat...
- `PowerSeries` | module `Mathlib.RingTheory.PowerSeries.Basic` | package Mathlib | Formal power series over a coefficient type `R`
- `QuantumMechanics.radiusPowOperator_domain_ge` | module `Physlib.QuantumMechanics.Operators.Position` | package PhysLean | **Domain of the Radial Power Operator.** For any dimension $d \in \mathbb{N}$ and real exponent $s$, the domain of the radial power operator $r^s$ contains the submodule of polynomially bounded Schwartz functions of o...

### Query: `Declaration irradianceDimension`
- `SSet.HasDimensionLT` | module `Mathlib.AlgebraicTopology.SimplicialSet.Dimension` | package Mathlib | A simplicial set `X` has dimension `< d` iff for any `n : ℕ` such that `d ≤ n`, all `n`-simplices are degenerate.
- `Dimension` | module `Physlib.Units.Dimension` | package PhysLean | The foundational dimensions. Defined in the order ⟨length, time, mass, charge, temperature⟩
- `HasDim` | module `Physlib.Units.Basic` | package PhysLean | This typeclass indicates that there is a dimension `dim M : Dimension` associated with the type `M`.

### Query: `Declaration LengthQuantity`
- `«command#long_names_»` | module `Mathlib.Util.LongNames` | package Mathlib | Lists all declarations with a long name, gathered according to the module they are defined in. Use as `#long_names` or `#long_names 100` to specify the length.
- `Mathlib.Tactic.ClickSuggestions.SectionKind` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | Whether the section corresponds to local hypotheses, declarations from the current file, or imported declarations.
- `Mathlib.Tactic.ClickSuggestions.SectionKind.imported` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | **Classification of Declaration Sources.** The source of a declaration is categorized into one of three kinds: a local hypothesis, a declaration within the current file, or a declaration from an imported module.

### Query: `Declaration RadiantPowerQuantity`
- `PowerSeries` | module `Mathlib.RingTheory.PowerSeries.Basic` | package Mathlib | Formal power series over a coefficient type `R`
- `QuantumMechanics.radiusPowOperator_hasDenseDomain` | module `Physlib.QuantumMechanics.Operators.Position` | package PhysLean | **Dense Domain of the Radial Power Operator.** For any real number $s$, the radial power operator $\mathcal{R}^s$ has a dense domain.
- `QuantumMechanics.radiusPowOperator_domain_ge` | module `Physlib.QuantumMechanics.Operators.Position` | package PhysLean | **Domain of the Radial Power Operator.** For any dimension $d \in \mathbb{N}$ and real exponent $s$, the domain of the radial power operator $r^s$ contains the submodule of polynomially bounded Schwartz functions of o...

### Query: `Declaration IrradianceQuantity`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `HahnSeries.order` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The order of a nonzero Hahn series `x` is a minimal element of `Γ` where `x` has a nonzero coefficient, the order of 0 is 0.
- `HahnSeries.single` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | `single a r` is the Hahn series which has coefficient `r` at `a` and zero otherwise.

### Query: `Declaration lengthInMetres`
- `LengthUnit.links` | module `Physlib.SpaceAndTime.Space.LengthUnit` | package PhysLean | The length unit of link (0.201168 meters).
- `LengthUnit.chains` | module `Physlib.SpaceAndTime.Space.LengthUnit` | package PhysLean | The length unit of a chain (20.1168 meters)
- `LengthUnit.rods` | module `Physlib.SpaceAndTime.Space.LengthUnit` | package PhysLean | The length unit of a rod (5.0292 meters)

### Query: `Declaration lengthInCentimetres`
- `«command#long_names_»` | module `Mathlib.Util.LongNames` | package Mathlib | Lists all declarations with a long name, gathered according to the module they are defined in. Use as `#long_names` or `#long_names 100` to specify the length.
- `LengthUnit.links` | module `Physlib.SpaceAndTime.Space.LengthUnit` | package PhysLean | The length unit of link (0.201168 meters).
- `LengthUnit.rods` | module `Physlib.SpaceAndTime.Space.LengthUnit` | package PhysLean | The length unit of a rod (5.0292 meters)

### Query: `Declaration powerInWatts`
- `PowerSeries` | module `Mathlib.RingTheory.PowerSeries.Basic` | package Mathlib | Formal power series over a coefficient type `R`
- `JoinedIn` | module `Mathlib.Topology.Connected.PathConnected` | package Mathlib | The relation "being joined by a path in `F`". Not quite an equivalence relation since it's not reflexive for points that do not belong to `F`.
- `RecursiveIn` | module `Mathlib.Computability.RecursiveIn` | package Mathlib | A partial function `f : α →. σ` between `Primcodable` types is recursive in a set of oracles `O` if its encoding as a function `ℕ →. ℕ` is `Nat.RecursiveIn O`.

### Query: `Declaration irradianceInSI`
- `DimArea.acre_in_SI` | module `Physlib.Units.WithDim.Area` | package PhysLean | **The Value of an Acre in SI Units.** In the International System of Units (SI), the area of one acre is defined as exactly $4046.8564224$ square meters.
- `DimArea.hectare_in_SI` | module `Physlib.Units.WithDim.Area` | package PhysLean | **Value of a Hectare in SI Units.** In the SI unit system, the value of one hectare is exactly $10,000$.
- `DimSpeed.speedOfLight_in_SI` | module `Physlib.Units.WithDim.Speed` | package PhysLean | **Value of the Speed of Light in SI Units.** The speed of light, when expressed in the International System of Units (SI), is exactly $299,792,458$.

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `Dimension.instPowRat` (PhysLean)
- `PowerSeries` (Mathlib)
- `QuantumMechanics.radiusPowOperator_domain_ge` (PhysLean)
- `SSet.HasDimensionLT` (Mathlib)
- `Dimension` (PhysLean)
- `HasDim` (PhysLean)
- `«command#long_names_»` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind` (Mathlib)
- `Mathlib.Tactic.ClickSuggestions.SectionKind.imported` (Mathlib)
- `PowerSeries` (Mathlib)
- `QuantumMechanics.radiusPowOperator_hasDenseDomain` (PhysLean)
- `QuantumMechanics.radiusPowOperator_domain_ge` (PhysLean)
- `HahnSeries.orderTop` (Mathlib)
- `HahnSeries.order` (Mathlib)
- `HahnSeries.single` (Mathlib)
- `LengthUnit.links` (PhysLean)
- `LengthUnit.chains` (PhysLean)
- `LengthUnit.rods` (PhysLean)
- `«command#long_names_»` (Mathlib)
- `LengthUnit.links` (PhysLean)
- `LengthUnit.rods` (PhysLean)
- `PowerSeries` (Mathlib)
- `JoinedIn` (Mathlib)
- `RecursiveIn` (Mathlib)
- `DimArea.acre_in_SI` (PhysLean)
- `DimArea.hectare_in_SI` (PhysLean)
- `DimSpeed.speedOfLight_in_SI` (PhysLean)

## Local abstractions introduced

- `IPhO2026Problem2B3.Figure2fAssumptions`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem2B3.IrradianceQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem2B3.LengthQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem2B3.PreviousPartResults`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem2B3.RadiantPowerQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problem2B3.SolarCooker`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.

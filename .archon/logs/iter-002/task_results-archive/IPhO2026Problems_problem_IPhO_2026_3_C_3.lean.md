# IPhO2026Problems/problem_IPhO_2026_3_C_3.lean

## Result

- Created a physics-specific autoformalization for IPhO 2026 Problem 3 C.3.
- The chapter contains `% archon:physics`, so the `physics-formalize`
  discipline was used.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_3.lean` succeeds.
- The only diagnostic is the expected `declaration uses sorry` warning for
  the main target theorem.
- The assigned Lean file did not previously exist, so there was no
  `/- USER: ... -/` file-specific hint.

## Assumption/target split

### Governing laws

- `TorusVolumeMassBalance.volumeDensityEquation` states the material relation
  `V ρ = n m_molar`, allowing the torus volume to be recovered from its amount,
  density, and molar mass.
- `ParamagneticEquationOfState.equationAtState` states the given equation
  `T M V = n K H` at all four labelled cycle vertices.
- `CarnotTemperaturePattern` states that `2 → 3` is at the cold temperature,
  `4 → 1` is at the hot temperature, and the cold temperature is strictly
  below the hot temperature.
- `CarnotIsothermalHeatLaw` applies the reusable B.1 heat formula separately
  to the oriented cold and hot isothermal legs. It also identifies the torus's
  cold-leg temperature with the initial helium temperature.
- `HeliumCalorimetryLaw.energyBalance` states that heat absorbed by the torus
  is removed from the helium:
  `Q_c = ρ_He V_He c_He (T_initial - T_final)`.
- `HeliumCalorimetryLaw.coolingOrientation` selects the cooling sign branch.

### Previous-part results

- `PreviousPartC2MagnetizationRelation.stateOneMagnetization` records
  `M₁ = sqrt (M₂² - M₃² + M₄²)` with the nonnegative magnitude branch.
- The B.1 isothermal heat relation is encoded locally in
  `CarnotIsothermalHeatLaw`; no sibling Lean file is imported.
- The C.2 magnetization relation is likewise encoded from its
  natural-language contract; no sibling Lean file is imported.

### Figure/data readouts

- `CyclePoint` preserves labels `1`, `2`, `3`, and `4`.
- `CarnotTorusCycle` preserves the directed Figure 3b order and branch kinds:
  `1 → 2` adiabatic cooling, `2 → 3` cold isothermal, `3 → 4`
  adiabatic heating, and `4 → 1` hot isothermal.
- `TorusStateReading` gives every vertex its `H`-versus-`T` coordinates and
  its magnetization.
- `SuppliedReadouts` records:
  - potassium chromate: `n = 2 mol`,
    `K = 1.87 × 10⁻⁶ K·m³/mol`, `ρ = 2730 kg/m³`, and
    `m_molar = 0.19 kg/mol`;
  - fields `H₁ = 411624`, `H₂ = 311306`, `H₃ = 204618`, and
    `H₄ = 240446 A/m`;
  - helium: `V = 1.00 L = 10⁻³ m³`, `T_initial = 1 K`,
    `ρ = 130 kg/m³`, and `c = 100 J/(kg·K)`;
  - the standard SI value `μ₀ = 4π × 10⁻⁷`.
- `CycleHeatExchange` keeps both named heat magnitudes `Q_c` and `Q_h`,
  even though only `Q_c` is needed for the requested final temperature.

### Current target conclusions

The theorem
`IPhO_2026_3_C_3_helium_temperature_after_one_cycle` concludes all three
reported numerical results:

- `Q_c` lies within `5 × 10⁻⁴ J` of `0.129 J`;
- the helium cooling lies within `5 × 10⁻⁵ K` of `0.00992 K`;
- the final temperature lies within `5 × 10⁻⁵ K` of `0.99008 K`.

These are rounding envelopes around the official answer, not hypotheses.

## Goal-faithfulness audit

None of the current numerical conclusions occurs in `SuppliedReadouts`,
`CarnotIsothermalHeatLaw`, `HeliumCalorimetryLaw`, another premise structure,
or a local definition. In particular:

- `Q_c` is constrained only by the general B.1 equation using `μ₀`, `n`, `K`,
  the cold temperature, `H₂`, and `H₃`;
- `T_final` is constrained only by the independent helium energy balance and
  the cooling orientation;
- no premise contains `0.129`, `0.00992`, or `0.99008`;
- `SIQuantity.siValue` merely exposes the SI coordinate of a dimension-tagged
  readout and does not encode any requested answer.

Thus the target requires substituting the input data into the heat law,
propagating that heat through calorimetry, and proving the displayed numerical
bounds.

## Derivability and bridge obligations

1. **Dimensional roles**
   - Source claim: temperature, volume, amount, Curie constant, density,
     molar mass, `H`, `M`, heat capacity, permeability, and energy have
     distinct physical/unit roles.
   - Lean carrier: `PhysicalRole.dimension`, `SIQuantity`, Physlib
     `Dimension`, and Physlib `WithDim`.
   - Evidence: the official C.3 source page and Physlib's dimensional API.
   - Status: **covered**.

2. **Figure 3b labels and orientation**
   - Source claim: the directed cycle is `1 → 2 → 3 → 4 → 1`, with cold and
     hot isothermal branches.
   - Lean carrier: `CyclePoint`, `CarnotLegKind`, `CarnotTorusCycle`, and
     `CarnotTemperaturePattern`.
   - Evidence: blueprint context and the official source's Carnot-cycle
     description.
   - Status: **covered**.

3. **Official scalar data**
   - Source claim: the given material, field, and helium readouts have the
     displayed SI values.
   - Lean carrier: the exact equations in `SuppliedReadouts`.
   - Evidence: official image `T3_page-4.png`.
   - Status: **covered**.

4. **Torus material volume**
   - Source claim: two moles with the given molar mass and density determine
     the torus volume.
   - Lean carrier:
     `TorusVolumeMassBalance.volumeDensityEquation`.
   - Evidence: mass equals molar amount times molar mass and also density times
     volume.
   - Status: **covered**.

5. **Paramagnetic equation of state**
   - Source claim: `T M V = n K H`.
   - Lean carrier:
     `ParamagneticEquationOfState.equationAtState`.
   - Evidence: blueprint problem context.
   - Status: **covered**.

6. **Previous-part C.2 square-root branch**
   - Source claim:
     `M₁ = sqrt (M₂² - M₃² + M₄²)`, taking the nonnegative magnitude.
   - Lean carrier:
     `PreviousPartC2MagnetizationRelation.stateOneMagnetization`, `Real.sqrt`,
     and the nonnegativity carried by each magnetization `SIQuantity`.
   - Evidence: the blueprint's reusable previous-part conclusion.
   - Status: **covered**.

7. **Cold isothermal heat**
   - Source claim: applying B.1 on `2 → 3` gives the positive magnitude
     `Q_c = -(μ₀ n K/(2T_c))(H₃²-H₂²)`.
   - Lean carrier:
     `CarnotIsothermalHeatLaw.coldReservoirContact`,
     `.coldTemperaturePositive`, and `.coldHeatEquation`.
   - Evidence: B.1's reusable equation and the cycle orientation.
   - Status: **covered**.

8. **Hot isothermal heat and sign convention**
   - Source claim: `Q_h` is the positive magnitude delivered to the hot
     reservoir on `4 → 1`, whereas heat entering the torus is negative there.
   - Lean carrier:
     `CarnotIsothermalHeatLaw.hotTemperaturePositive` and `.hotHeatEquation`.
   - Evidence: B.1's signed heat law and the problem's heat convention.
   - Status: **covered**.

9. **Helium energy balance**
   - Source claim: with constant density and specific heat, removing `Q_c`
     changes the helium temperature by
     `Q_c = ρ V c (T_initial - T_final)`.
   - Lean carrier: `HeliumCalorimetryLaw.energyBalance` and
     `.coolingOrientation`.
   - Evidence: the official C.3 helium assumptions.
   - Status: **covered**.

10. **Numerical evaluation and reported rounding**
    - Source claim: `Q_c ≈ 1.29 × 10⁻¹ J`,
      `|ΔT| ≈ 9.92 × 10⁻³ K`, and `T_final ≈ 0.99008 K`.
    - Lean carrier: the contract of
      `IPhO_2026_3_C_3_helium_temperature_after_one_cycle`, using `abs`
      bounds around all three reported values.
    - Evidence: direct substitution into the preceding heat and calorimetry
      equations; with exact `4π × 10⁻⁷`, the central computed values fall
      inside the stated rounding envelopes.
    - Status: **covered**; proof intentionally deferred with `sorry` in the
      autoformalize stage.

## Abstraction sufficiency and countermodel audit

Every local `Prop`-valued interface exposes usable mathematical constraints:

- `SuppliedReadouts` has thirteen exact SI-value equations.
- `TorusVolumeMassBalance` has the mass/volume/density equation.
- `ParamagneticEquationOfState` has one equation for every cycle point.
- `CarnotTemperaturePattern` has two temperature equalities and the strict
  hot/cold inequality.
- `PreviousPartC2MagnetizationRelation` has the explicit square-root equation.
- `CarnotIsothermalHeatLaw` has cold-contact and positivity constraints plus
  explicit cold- and hot-heat equations.
- `HeliumCalorimetryLaw` has the explicit energy-balance equation and the
  cooling inequality.

There is no opaque predicate that merely asserts existence without exposing
an equality or inequality. `CarnotTorusCycle` is a `Type`-valued data
structure, but its four equality fields fix all outgoing leg classifications.

Countermodel sanity check: after the exact data and cold-contact equation are
fixed, `coldHeatEquation` determines `Q_c`. The nonzero helium heat-capacity
factor supplied by the data then makes `energyBalance` determine
`T_final`. Hence the heat and final-temperature readouts cannot be interpreted
arbitrarily while all assumptions remain true. The other interfaces constrain
the full torus/Carnot context without assuming the requested numeric answer.

## Uncertainty and branch coverage

- **Uncertainty: not applicable.** The source reports no `value ± uncertainty`
  or error bar. The theorem's intervals express numerical rounding of the
  official answer and are not treated as measurement uncertainty.
- **Cycle orientation: covered.** All four directed legs and their
  adiabatic/isothermal roles are explicit.
- **Cold/hot reservoir branches: covered.** The isothermal temperature
  equalities and `T_c < T_h` are explicit.
- **Heat sign: covered.** `Q_c` and `Q_h` are nonnegative magnitudes; their
  separate formulas reflect heat into the torus on `2 → 3` and heat out of it
  on `4 → 1`.
- **Magnetization square-root branch: covered.** `Real.sqrt` and nonnegative
  magnetization readouts select the magnitude branch.
- **Helium cooling branch: covered.**
  `HeliumCalorimetryLaw.coolingOrientation` rules out the heating branch.

## Declarations created and blueprint correspondence

- Dimensional/data declarations:
  `PhysicalRole`, `PhysicalRole.dimension`, `SIQuantity`,
  `SIQuantity.siValue`, `CyclePoint`, `CarnotLegKind`,
  `TorusStateReading`, `CarnotTorusCycle`, `ParamagneticTorus`,
  `LiquidHeliumSample`, `RefrigerationSetup`, and `CycleHeatExchange`.
- Physics/data interfaces:
  `SuppliedReadouts`, `TorusVolumeMassBalance`,
  `ParamagneticEquationOfState`, `CarnotTemperaturePattern`,
  `PreviousPartC2MagnetizationRelation`, `CarnotIsothermalHeatLaw`, and
  `HeliumCalorimetryLaw`.
- Main declaration:
  `IPhO2026Problems.Problem3C3.IPhO_2026_3_C_3_helium_temperature_after_one_cycle`
  corresponds to `thm:physics:IPhO_2026_3_C_3:target`.
- The target is formalized with a `sorry` body and is ready for automated
  `\leanok` synchronization. The blueprint was not edited because prover
  permissions make it read-only and marker synchronization is automatic.

## LeanExplore queries/candidates actually used

1. Query: `physical quantity with SI units dimensions temperature energy heat
   capacity magnetic field strength`
   - Used candidates: `Dimension`, `Dimensionful`, `UnitChoices.SI`,
     `DimEnergy`.
   - `Dimension` and the unit-system declarations established the available
     Physlib foundation.

2. Query: `PhysLean Dimension Quantity SI unit temperature volume mass density
   molar amount magnetic field current per meter`
   - Used candidates: `Dimension`, `Dimension.L𝓭`,
     `UnitChoices.SI`, and `Electromagnetism.CurrentDensity`.
   - The continuum current-density result was a near miss; this problem needs
     scalar toroidal field-strength readouts.

3. Query: `Dimensionful physical quantity units OfDimension temperature unit
   system PhysLean`
   - Used candidates: `Dimensionful`, `Dimension`,
     `CarriesDimension.toDimensionful`, and `TemperatureUnit`.
   - Source/module information was fetched for `Dimensionful`,
     `Dimension`, and `UnitChoices.SI`.

4. Queries: `DimTemperature temperature as dimensional quantity`,
   `DimVolume volume dimensional quantity`, and
   `DimMass mass dimensional quantity`
   - Used candidates: the general `Dimension`/`WithDim` foundation and
     `Real.sqrt`.
   - No complete set of ready-made scalar aliases for this problem's
     quantities was found.

5. Queries: `magnetic field strength dimension ampere per meter dimensional
   quantity`, `specific heat capacity dimensional quantity`, and
   `density mass per volume dimensional quantity`
   - Near-miss candidates:
     `Electromagnetism.MagneticField`,
     `CanonicalEnsemble.heatCapacity`, and
     `FluidDynamics.MassDensity`.
   - They concern continuum fields or ensemble-specific objects, not the
     problem's uniform SI scalar readouts, so they were not used as carriers.

6. Query: `amount of substance mole physical unit`
   - Candidate: `Dimension`; inspection showed that Physlib's foundational
     dimensions are length, time, mass, charge, and temperature only.
   - This directly motivated retaining mole semantics through the local
     `PhysicalRole` index while assigning amount a dimensionless Physlib
     dimension.

## PhysLean/Mathlib names grounded

- Physlib:
  `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`,
  `Dimension.M𝓭`, `Dimension.C𝓭`, `Dimension.Θ𝓭`,
  `WithDim`, `Dimensionful`, `UnitChoices.SI`, and `DimEnergy`.
- Mathlib: `Real.sqrt`, `Real.pi`, `abs`, powers, real division, and real
  inequalities.
- Imports used: `Mathlib` and `Physlib.Units.WithDim.Basic`.
- Lean LSP `lean_run_code` independently verified the syntax and types of
  `WithDim`, all five foundational dimension constants, `Real.sqrt`, and
  `abs`.

## Local abstractions introduced

- `PhysicalRole` is a phantom role index over Physlib dimensions. It prevents
  accidental interchange of equal-dimensional but physically distinct
  readouts such as `H` and `M`.
- `SIQuantity` combines a dimension-tagged Physlib value with nonnegativity,
  faithfully representing the magnitude readouts in the source rather than
  collapsing physical primitives to transparent real aliases.
- Mole is not a Physlib foundational dimension. The role index therefore
  preserves `mol`, `kg/mol`, and `K·m³/mol` meanings while the dimensional
  component uses Physlib's available five-base-dimension system.
- The torus, helium, cycle, heat, equation-of-state, isothermal-heat, and
  calorimetry interfaces are local because no single matching
  Physlib/Mathlib API was found. Each exposes the source equations and
  inequalities needed for later proofs.

## Grounding gaps

- Physlib's `Dimension` does not include amount of substance, so mole cannot
  be represented as a sixth foundational exponent. The local role index
  preserves that semantic distinction without inventing a library name.
- LeanExplore found no ready-made scalar API for this lumped paramagnetic
  Carnot torus, the B.1 magnetic isothermal heat law, or the helium
  calorimetry coupling. Faithful local equation-bearing interfaces were used.
- No derivability bridge remains blocked.

## Redraft requests

- None.

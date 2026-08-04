# Autoformalization result: IPhO 2026 Problem 4 B.4

## Assumption/target split

### Governing laws

- The Figure 19 syringe arrangement keeps the inner-cylinder total pressure at the
  same idealized atmospheric pressure in both the reference and measured states.
- Dry-air and water-vapor partial-pressure readouts add to the total-pressure
  readout in each state.
- The B.4 approximation makes only the reference-state vapor-pressure readout
  zero.
- The amount of dry air is fixed, so its two states satisfy the ideal-gas
  invariant \(P_{\rm dry}V/T=\text{constant}\).
- The cylindrical gas volumes obey \(V_0=A H_0\) and \(V=A H\), with positive
  area, heights, volumes, absolute temperatures, and atmospheric pressure.
- Equation (3), the Clausius--Clapeyron law, is represented separately by
  `SatisfiesClausiusClapeyron`. It is contextual for subsequent part B.5 and is
  not needed to derive B.4.

### Previous-part results

- `PreviousPartB3Readout` records the official sample extrapolation
  \(H_0=5.9\,\mathrm{cm}\) and \(V_0=53.4\,\mathrm{mL}\).
- The main theorem accepts that readout without importing or depending on a Lean
  declaration from part B.3, as required by the natural-language prerequisite
  policy.

### Figure/data readouts

- `Figure19CylinderGeometry` names the inner-cylinder cross-sectional area, the
  procedure's initial water-level height, the reference/measured gas-column
  heights, and the corresponding reference/measured gas volumes.
- `DryAirWaterVaporExperiment.initialWaterLevel_eq` records the Figure 19
  procedure's \(h=5.0\,\mathrm{cm}\) setting.
- `DryAirWaterVaporExperiment.referenceTemperature_eq` records
  \(T_0=273.15\,\mathrm{K}\).
- Atmospheric, dry-air, and vapor pressures are physical `DimPressure` values;
  equations use their SI scalar readouts. Length, area, volume, and temperature
  readouts are likewise explicitly named by unit.
- `ClausiusClapeyronData` records \(Q_v\), the reference vapor pressure, and the
  quoted \(R=8.31\,\mathrm{J/(mol\,K)}\).

### Current target conclusion

- `vaporPressure_formula` concludes exactly
  \[
    P_v=P_{\rm atm}\left(1-\frac{H_0T}{HT_0}\right)
  \]
  for the pascal readouts of the two physical pressure quantities.

## Goal-faithfulness audit

- The B.4 vapor-pressure formula occurs only as the conclusion of
  `vaporPressure_formula`.
- It is not a field of `DryAirWaterVaporExperiment`,
  `PreviousPartB3Readout`, or `ClausiusClapeyronData`, and it is not made true
  by unfolding a local definition.
- The experiment predicate contains only independent physical laws, positivity
  conditions, geometry relations, and measured/reference data. Those laws
  require the later prover to eliminate the two dry-air pressures and the
  cross-sectional area.
- `referenceVaporPressure_zero` concerns the distinct reference state, not the
  measured vapor pressure that appears on the target's left-hand side.
- The exact Clausius--Clapeyron equation is deliberately kept out of the B.4
  experiment assumptions: applying it with the same reference pressure that
  B.4 approximates by zero would conflate the problem's exact equilibrium law
  with its special zero-pressure approximation.

## Declarations and blueprint labels

- `IPhO2026Problems.IPhO2026_4_B_4.DimLength`
- `IPhO2026Problems.IPhO2026_4_B_4.DimVolume`
- `IPhO2026Problems.IPhO2026_4_B_4.pressureInPascals`
- `IPhO2026Problems.IPhO2026_4_B_4.lengthInMeters`
- `IPhO2026Problems.IPhO2026_4_B_4.areaInSquareMeters`
- `IPhO2026Problems.IPhO2026_4_B_4.volumeInCubicMeters`
- `IPhO2026Problems.IPhO2026_4_B_4.temperatureInKelvin`
- `IPhO2026Problems.IPhO2026_4_B_4.Figure19CylinderGeometry`
- `IPhO2026Problems.IPhO2026_4_B_4.PreviousPartB3Readout`
- `IPhO2026Problems.IPhO2026_4_B_4.DryAirWaterVaporExperiment`
- `IPhO2026Problems.IPhO2026_4_B_4.ClausiusClapeyronData`
- `IPhO2026Problems.IPhO2026_4_B_4.SatisfiesClausiusClapeyron`
- `IPhO2026Problems.IPhO2026_4_B_4.vaporPressure_formula` corresponds to
  `thm:physics:IPhO_2026_4_B_4:target`.

The target theorem is formalized and ready for the blueprint's statement
environment to receive `\lean{IPhO2026Problems.IPhO2026_4_B_4.vaporPressure_formula}`
and the sync-managed `\leanok`.

## LeanExplore queries/candidates actually used

All searches used `packages: ["Mathlib", "Physlib"]`.

- `thermodynamic pressure temperature volume physical quantity with units`
  found and motivated the use of `DimPressure`, `Temperature`,
  `Temperature.toReal`, and the inspection of `IdealGas.ideal_gas_law`.
- `ideal gas law pressure volume temperature amount of gas` found
  `IdealGas.ideal_gas_law`. Its source states a units-free \(PV=nRT\) theorem
  for PhysLean's microcanonical ideal-gas model; it was not directly reusable
  for the experimental dry-air sample, so the file states the fixed-sample
  invariant as a local physical-law field.
- `SI pressure quantity temperature quantity length volume units` found
  `UnitChoices.SI`, `DimPressure`, and `DimPressure.pascal`; the SI unit choice
  is used by all dimensional readout projections.
- `Real logarithm exp Clausius Clapeyron vapor pressure` found `Real.exp` and
  `Real.log`. `Real.exp` is used to preserve the source page's equation (3)
  form.
- `DimLength dimensional length meters` found `Dimension.L𝓭` and
  `Dimensionful`, but no ready-made `DimLength`.
- `DimVolume dimensional volume cubic meters` found `Dimensionful`, but no
  ready-made `DimVolume`.
- `DimArea` found the PhysLean declaration `DimArea`, whose fetched source is
  `Dimensionful (WithDim (L𝓭 * L𝓭) ℝ≥0)`.

Fetched source/module/docstring information for the intended candidates:

- `DimPressure` and `DimPressure.pascal` —
  `Physlib.Units.WithDim.Pressure`
- `DimArea` — `Physlib.Units.WithDim.Area`
- `Temperature` and `Temperature.toReal` —
  `Physlib.Thermodynamics.Temperature.Basic`
- `IdealGas.ideal_gas_law` —
  `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas`
- `Dimensionful` and `UnitChoices.SI` — `Physlib.Units.Basic`
- `Dimension.L𝓭` — `Physlib.Units.Dimension`

## PhysLean/Mathlib names grounded

- PhysLean: `DimPressure`, `DimArea`, `Dimensionful`, `WithDim`,
  `Dimension.L𝓭`, `UnitChoices.SI`, `Temperature`, and
  `Temperature.toReal`.
- Mathlib: `Real.exp`.

## Local abstractions introduced

- `DimLength` is a unit-independent PhysLean dimensional quantity with
  dimension \(L\) and nonnegative values.
- `DimVolume` is the analogous quantity with dimension \(L^3\).
- The five `...In...` definitions are explicit SI readout projections, not
  aliases that identify physical quantities with `ℝ`.
- `DryAirWaterVaporExperiment` is the smallest local interface that retains
  pressure decomposition, fixed-dry-air ideal-gas behavior, the cylinder
  geometry, positivity, and the B.4 baseline approximation.
- `ClausiusClapeyronData` and `SatisfiesClausiusClapeyron` preserve equation
  (3) and its dimensional parameter roles without forcing that later-part law
  into the B.4 derivation.

## Grounding gaps

- PhysLean has no searched ready-made `DimLength` or `DimVolume` name.
- `IdealGas.ideal_gas_law` is specialized to a units-free statistical-mechanics
  model and does not expose the two-state experimental gas-sample interface
  needed here.
- PhysLean's `DimPressure` currently lacks same-dimension addition, so partial
  pressure addition is stated on injective SI readouts of the physical
  pressures.
- The blueprint theorem environment has no `\lean{...}` declaration mapping.
  An authorized blueprint phase should add the mapping listed above; this
  prover did not edit the protected blueprint chapter.

## Verification

- `archon-lean-lsp` diagnostics: one expected `declaration uses 'sorry'`
  warning and no errors.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_4.lean`: successful
  with the same single expected warning.
- `git diff --check`: clean.

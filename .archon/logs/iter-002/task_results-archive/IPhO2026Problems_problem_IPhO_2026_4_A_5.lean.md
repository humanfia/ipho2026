# Autoformalization result: IPhO 2026 problem 4 A.5

The assigned file was created and checked with
`lake env lean IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`. It compiles
with exactly three expected `declaration uses sorry` warnings and no errors.

## Assumption/target split

### Governing laws

- `ObeysIsochoricIdealGasLaw` states `P V = n R T` for every positive
  absolute temperature, using one fixed sealed-air volume throughout the run.
- `IsPreparedIsochoricApparatus` states the cylindrical CA volume relation,
  the positive geometry/volume conditions, the prescribed glycol height, and
  the closed-valve preparation that makes the process isochoric.
- Positivity of the amount of air and universal gas constant is explicit in
  the bridge and main theorem premises.

### Previous-part results

- `HasIsochoricPressureLinearity` locally restates the reusable A.3 result:
  there is a positive pressure slope such that `P(T) = slope * T` at every
  positive absolute temperature.
- No sibling Lean module is imported. The result is also derivable from the
  locally stated ideal-gas law by
  `idealGasLaw_implies_isochoricPressureLinearity`.

### Figure/data readouts

- `ApparatusLabel` retains the source labels CA, IC, OC, PG, D, and E.
- `Figure17Geometry` retains inner-cylinder diameter and internal height as
  metre readouts.
- `IsochoricApparatus` retains the glycol height, ambient-air density,
  sealed-air volume, and valve states.
- `IsPreparedIsochoricApparatus` records `h = 0.045 m`,
  `ρₐ = 1.12 kg/m³`, closed valves D/E, and the cylinder-volume equation.
- `IsochoricHeatingRun` retains the dimensionful pressure curve, Physlib
  absolute temperatures, air amount, and universal gas constant.
- `UsesStandardReferenceState` records `T₀ = 273.15 K` and `P₀ > 0`.
- `IsHeatingBranch` records the reference-to-heated temperature and pressure
  orientation.

### Current target conclusions

- `thermalPressureCoefficientPerKelvin run = 1 / T₀`.
- `thermalPressureCoefficientPerKelvin run = 1 / 273.15`.
- The coefficient lies in the official
  `0.0034 ± 0.0007 K⁻¹` uncertainty interval.
- The ideal-gas value is within `0.00005 K⁻¹` of `0.0037 K⁻¹`, expressing the
  source's four-decimal rounded reference.

These claims occur only in theorem conclusions.

## Goal-faithfulness audit

- No premise of the main theorem contains the coefficient formula's evaluated
  value, the official interval membership, or the rounded value `0.0037`.
- `ObeysIsochoricIdealGasLaw` contains only the governing state equation.
  `HasIsochoricPressureLinearity` contains only the allowed A.3
  proportionality result, with a generic slope.
- `thermalPressureCoefficientPerKelvin` is the definition supplied verbatim
  by the problem, not a definition of the requested numerical answer. Its
  substantive equalities and uncertainty membership do not follow by
  unfolding.
- `UsesStandardReferenceState` records the source's reference temperature and
  positive reference pressure; it does not mention beta.
- `officialCoefficientEstimatePerKelvin` is output/reporting data. It is used
  only in the conclusion, never as a law or hypothesis.
- Countermodel sanity check: without the ideal-gas/linearity equation,
  `pressureAt` can vary arbitrarily and beta need not be `1/T₀`; without the
  positive heating orientation, the secant denominator may vanish; without
  the reference-state condition, the exact numerical reference is not forced.
  The full premises exclude each countermodel without assuming the target.

## Derivability and bridge obligations

1. **Physical pressure and temperature to SI readouts — covered.**
   Source claim: `P` is a pressure and `T` is an absolute temperature, while
   the experimental formula uses pascal and kelvin scalar readings. Carriers:
   Physlib `DimPressure`, `Temperature`, `UnitChoices.SI`, local
   `pressureInPascals`, and local `temperatureInKelvin`. Evidence:
   LeanExplore source for `DimPressure`, `Temperature`,
   `Temperature.toReal`, `UnitChoices.SI`, and
   `CarriesDimension.toDimensionful` was inspected.

2. **Figure 17 dimensions to sealed CA volume — covered symbolically.**
   Source claim: cylinder dimensions and `h = 4.5 cm` determine the fixed air
   volume. Carrier: the explicit cylindrical-volume equality in
   `IsPreparedIsochoricApparatus`, with positivity and `h < H`. The exact
   numerical diameter/height readouts were not present on the only listed
   source page, so they remain parameters rather than invented constants.

3. **Ideal-gas law to A.3 linearity — covered.**
   Source claim: fixed `V`, `n`, and `R` in `P V = n R T` imply
   `P ∝ T`. Carrier:
   `idealGasLaw_implies_isochoricPressureLinearity`; its slope is mathematically
   forced to be `n R / V`, with positivity provided by the theorem premises.
   The theorem body is intentionally `sorry` at the autoformalization stage.

4. **Isochoric line to normalized secant slope — covered.**
   Source claim: for `P(T) = cT`,
   `(1/P₀)(ΔP/ΔT) = 1/T₀`. Carrier:
   `thermalPressureCoefficient_eq_inverse_referenceTemperature`, using
   `P₀ > 0` and the strictly heated branch to justify both divisions. Its body
   is intentionally `sorry`.

5. **Reference conditions to the exact ideal-gas value — covered.**
   Source claim: `T₀ = 273.15 K`. Carrier:
   `UsesStandardReferenceState` and the first two conclusions of
   `IPhO2026_4_A_5_thermalPressureCoefficient`.

6. **Exact reference to experimental uncertainty and rounded reference —
   covered.**
   Source claims: official sample `0.0034 ± 0.0007 K⁻¹` and ideal-gas
   reference `0.0037 K⁻¹`. Carriers: the explicit absolute-value inequality
   in `Estimate.Contains`, the exact value `1 / 273.15`, and the final
   rounding inequality in the main theorem. These reduce to exact rational
   arithmetic in the later proof.

7. **Complete source-to-contract mapping — covered.**
   Carrier: `IPhO2026_4_A_5_thermalPressureCoefficient`, whose premises are
   apparatus preparation, reference/heating orientation, positivity, and the
   governing law, and whose conclusions contain the complete requested
   relation and reported answer context.

No substantive target bridge is absent from the statement layer.

## Abstraction sufficiency and countermodel audit

- `IsPreparedIsochoricApparatus` is `Prop`-valued and exposes positive
  diameter/height/volume, the two numerical setup readouts, the height bound,
  both valve-state equalities, and the CA volume equation.
- `UsesStandardReferenceState` is `Prop`-valued and exposes the exact
  reference-temperature equation and strict reference-pressure positivity.
- `IsHeatingBranch` is `Prop`-valued and exposes strict temperature and
  pressure inequalities, preserving the signed reference-to-heated branch.
- `ObeysIsochoricIdealGasLaw` is `Prop`-valued and exposes the quantified
  `P V = n R T` equation; it is not an opaque assertion that a law holds.
- `HasIsochoricPressureLinearity` is `Prop`-valued and exposes a positive
  slope plus its quantified `P = slope * T` elimination equation.
- `Estimate.Contains` is `Prop`-valued and unfolds to uncertainty
  nonnegativity and a closed absolute-error inequality.
- The remaining local structures are data-valued. Pressure is not replaced by
  a scalar alias: `IsochoricHeatingRun.pressureAt` returns Physlib
  `DimPressure`. Real-valued fields are explicitly measured SI components.
- With all premises, the ideal-gas law fixes the pressure slope, the reference
  and heating inequalities make all divisions meaningful, and the standard
  reference fixes the numerical value. Consequently there is no model of the
  full premise set in which the requested conclusions can vary freely.

## Uncertainty and branch coverage

- **Reported uncertainty: covered.** The theorem conclusion uses
  `Estimate.Contains` with central value `0.0034` and uncertainty `0.0007`;
  it is an interval conclusion, not an exact central-value equality.
- **Raw-data uncertainty propagation: not applicable to the available
  source.** No A.2 table, pressure-sensor uncertainty, temperature-sensor
  uncertainty, or covariance is supplied in the chapter/source report. The
  only supplied uncertainty is already the final official reported
  uncertainty, which is preserved in the output contract.
- **Heating orientation: covered.** `IsHeatingBranch` fixes
  `T_heated > T₀` and `P_heated > P₀`; the code does not select this branch
  only in the conclusion.
- **Secant orientation: covered.** Both `ΔP` and `ΔT` are defined as
  heated-minus-reference quantities.
- **Absolute-temperature branch: covered.** The ideal-gas and linearity laws
  are applied only to strictly positive `temperatureInKelvin` values.

## Declarations created and blueprint labels

- Blueprint label `thm:physics:IPhO_2026_4_A_5:target` maps to
  `IPhO2026Problems.Problem4A5.IPhO2026_4_A_5_thermalPressureCoefficient`.
- Bridge theorems:
  `IPhO2026Problems.Problem4A5.idealGasLaw_implies_isochoricPressureLinearity`
  and
  `IPhO2026Problems.Problem4A5.thermalPressureCoefficient_eq_inverse_referenceTemperature`.
- Model declarations: `ApparatusLabel`, `Figure17Geometry`,
  `IsochoricApparatus`, `IsPreparedIsochoricApparatus`,
  `IsochoricHeatingRun`, `UsesStandardReferenceState`, `IsHeatingBranch`,
  `ObeysIsochoricIdealGasLaw`, `HasIsochoricPressureLinearity`, `Estimate`,
  and `Estimate.Contains`.
- Readout/reporting declarations: `pressureInPascals`,
  `temperatureInKelvin`, `thermalPressureCoefficientPerKelvin`, and
  `officialCoefficientEstimatePerKelvin`.
- The target environment is ready for statement-level `\leanok`. The chapter
  currently lacks a `\lean{...}` reference; per prover permissions it was not
  edited. The synchronization/review lane should attach the fully qualified
  main theorem name above and manage `\leanok`.

## LeanExplore queries/candidates actually used

All searches used package filters `["Mathlib", "Physlib"]`.

- Query `ideal gas law pressure volume amount of substance universal gas
  constant absolute temperature`: inspected
  `IdealGas.ideal_gas_law`, `DimPressure`, `Temperature`, and
  `Temperature.toReal`.
- Query `physical units pressure volume mass density length amount of
  substance SI quantity dimensions`: used `DimPressure`,
  `UnitChoices.SI`, and inspected `FluidDynamics.MassDensity`.
- Query `experimental measurement uncertainty value plus or minus error
  interval real`: no experiment-specific uncertainty carrier was suitable;
  the standard absolute-value interval was encoded locally.
- Query `DimPressure convert pressure dimensional quantity to real SI pascal
  value UnitChoices.SI`: used `DimPressure.pascal`, `UnitChoices.SI`, and
  inspected `WithDim.scaleUnit_val`.
- Query `Dimensionful toDimensionful value at UnitChoices definition`: used
  `Dimensionful` and inspected `CarriesDimension.toDimensionful`.
- Queries for `DimLength`, `DimArea`, and `DimVolume`: found `DimArea` but no
  suitable ready-made volume carrier for this contract; explicit SI geometry
  readouts were retained instead.

## PhysLean/Mathlib names grounded

- Physlib: `DimPressure`, `DimPressure.pascal`, `Dimensionful`, `WithDim`,
  `UnitChoices.SI`, `CarriesDimension.toDimensionful`, `Temperature`, and
  `Temperature.toReal`.
- Mathlib: `Real.pi`, real absolute value, ordered-field arithmetic, and
  decimal/rational notation.

`IdealGas.ideal_gas_law` was source-checked but not used: it models a
statistical-mechanics pressure with `n : ℕ` and a unitless convention `R = 1`,
whereas this problem requires measured moles, the universal gas constant, and
dimensionful experimental pressure.

## Local abstractions introduced

- `Figure17Geometry` and `IsochoricApparatus` are the smallest data interfaces
  retaining the named apparatus quantities whose exact figure readouts were
  unavailable.
- `ObeysIsochoricIdealGasLaw` locally supplies the SI `P V = n R T` interface
  because the near-match Physlib theorem uses an incompatible unitless model.
- `HasIsochoricPressureLinearity` faithfully restates A.3 with a usable
  quantified equation instead of importing a sibling formalization.
- `Estimate`/`Estimate.Contains` retain the symmetric reported uncertainty
  through a concrete inequality because no suitable experimental-measurement
  API was found.

## Grounding gaps

- The only listed official page image is page 9. It names CA, IC, OC, PG, D,
  and E but does not display Figure 17's numerical diameter/height labels.
  Those quantities are therefore explicit symbolic parameters; no numerical
  figure data were invented.
- The source provides no A.2 measurement table or raw uncertainty model, so a
  derivation of the reported uncertainty from sensor errors cannot be stated.
  The final reported uncertainty itself is fully preserved.
- Physlib's `IdealGas.ideal_gas_law` is not a signature match for this
  experimental SI model, as described above.
- `archon dag-query` was attempted, but `archon` was not available on this
  lane's `PATH`. The blueprint itself lists only A.3 as a natural-language
  prerequisite, which is represented locally without a sibling import.

## Redraft requests

- If exact Figure 17 numerical geometry is desired in this chapter, add the
  official page containing Figure 17 or transcribe its diameter and height
  values into the source report.
- No theorem-contract redraft is otherwise required.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors; exactly three
  expected `declaration uses sorry` warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`: exit code 0;
  exactly the same three warnings.
- `archon-protected.yaml` has no active rule affecting the assigned file.

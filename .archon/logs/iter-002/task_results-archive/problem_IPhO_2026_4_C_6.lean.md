## Assumption/target split

### Governing laws

- `ThermalExperiment.SatisfiesLaws.heatFlowIsHeatDerivative` identifies the
  SI heat-flow rate with `dQ/dt` using Mathlib's `HasDerivAt`.
- `innerTemperatureRateIsDerivative` identifies the recorded IC temperature
  rate with `dT_IC/dt`.
- `heatFlowResistanceLaw` states the source model
  `dQ/dt = (T_OC - T_IC) / R_Th`.
- `innerWaterCalorimetry` states
  `dQ/dt = c₀ m dT_IC/dt`; the absence of an apparatus heat-capacity term
  encodes the instructed approximation.
- `outwardGradientIsRadialDerivative` and `radialFourierLaw` state
  `dQ/dt = -λ A dT/dr` with the radial derivative oriented outwards and heat
  flow oriented from OC to IC.
- `Figure17Dimensions.Valid` and `ThermalExperiment.ValidParameters` supply
  geometric nesting and the positivity needed for physical denominators.

### Previous-part results

- `C5PreviousPartResult.slopeLaw` is exactly the reusable natural-language
  C.5 result: the fitted graph slope is
  `1 / (c₀ m R_Th)`.
- It is declared locally and does not import any sibling Lean file, respecting
  the source's `natural_language_prerequisite_only` policy.

### Figure/data readouts

- `Figure17Dimensions` retains the wall's inner and outer radius, conduction
  height and area, plus IC/OC water heights.
- `Figure17Dimensions.Valid` records the nested-radius ordering, slim-wall
  mean-radius area relation, and the procedure's `0.10 m` IC and `0.15 m` OC
  water levels.
- `C5GraphReadout` records sample times, finite-difference IC heating rates,
  interval-average OC-minus-IC temperature gaps, the fitted slope, the
  through-origin linear fit, and a nonzero gap.
- `SlopeMeasurement` records a nominal fitted slope and symmetric slope
  uncertainty. `SlopeMeasurement.ValidFor` ties them to the actual fitted
  slope by an absolute-error inequality.
- `officialSampleEstimate` records the official sample
  `1.17 ± 0.03 K/W` as an estimate, not as a universal fact about every run.

### Current target conclusions

- `determineEffectiveWallThermalResistance` concludes
  `R_Th = 1 / (c₀ m slope)`.
- `determineEffectiveWallThermalResistanceWithUncertainty` concludes a
  conservative propagated resistance-error bound from the C.5 slope error.
- `officialSampleEstimateReadout` exposes the two exact SI components of the
  reported sample estimate.

## Goal-faithfulness audit

- The C.6 reciprocal resistance formula occurs only as the conclusion of
  `determineEffectiveWallThermalResistance`.
- No premise, governing-law field, validity predicate, or local definition
  states that formula.
- The only premise mentioning the graph slope and resistance together is
  `C5PreviousPartResult.slopeLaw`, whose equation is the distinct C.5
  conclusion explicitly authorized by the blueprint.
- The resistance uncertainty bound occurs only as the conclusion of
  `determineEffectiveWallThermalResistanceWithUncertainty`.
  `SlopeMeasurement.ValidFor` contains only raw slope-error and positivity
  information.
- `officialSampleEstimate` is reported example data. It is deliberately not
  connected by assumption to an arbitrary experiment's true resistance.
- None of the substantive theorems is true merely by unfolding a definition.

## Derivability and bridge obligations

1. **Physical quantities to scalar equations**
   - Source claim: all equations compare quantities in compatible units.
   - Lean carrier: `Dimensionful (WithDim d ℝ)`, the locally derived
     `Dimension` expressions, `UnitChoices.SI`, `siValue`, and
     `areaInSquareMetres`.
   - Evidence: LeanExplore results for `Dimension`, `Dimensionful`,
     `UnitChoices.SI`, and `CarriesDimension.toDimensionful`; source and
     modules were fetched before use.
   - Status: **covered (grounded)**.

2. **`dQ/dt`, `dT_IC/dt`, and `dT/dr` interpretation**
   - Source claim: the rates and radial gradient are derivatives rather than
     unrelated scalar fields.
   - Lean carrier:
     `ThermalExperiment.SatisfiesLaws.heatFlowIsHeatDerivative`,
     `innerTemperatureRateIsDerivative`, and
     `outwardGradientIsRadialDerivative`, all using `HasDerivAt`.
   - Evidence: `HasDerivAt` was checked successfully with the Lean LSP.
   - Status: **covered (grounded)**.

3. **C.5 plotted coordinates**
   - Source claim: the vertical coordinate is the finite difference of IC
     temperature, and the horizontal coordinate is the interval-average
     `T_OC - T_IC`.
   - Lean carrier:
     `C5GraphReadout.finiteDifferenceRateDefinition` and
     `averageGapDefinition`.
   - Evidence: both coordinate equations and increasing sample times are
     exposed as fields.
   - Status: **covered (encoded locally)**.

4. **C.5 linear slope law**
   - Source claim: the fitted slope is `1 / (c₀ m R_Th)`.
   - Lean carrier: `C5PreviousPartResult.slopeLaw`.
   - Evidence: it is a reusable previous-part premise, separated from all
     C.6 conclusions.
   - Status: **covered (source-authorized local carrier)**.

5. **Solving the slope law for resistance**
   - Source claim: `R_Th = 1 / (c₀ m slope)`.
   - Lean carrier: the main theorem contract together with
     `C5PreviousPartResult.slopeLaw` and positivity from
     `ThermalExperiment.ValidParameters`.
   - Evidence: positivity rules out the zero-denominator countermodels and
     makes the reciprocal rearrangement algebraically derivable.
   - Status: **covered (the theorem body remains `sorry` by stage design)**.

6. **Propagation of slope uncertainty**
   - Source claim: uncertainty in the graph fit must propagate through the
     reciprocal relation.
   - Lean carrier: `SlopeMeasurement.ValidFor` and
     `determineEffectiveWallThermalResistanceWithUncertainty`.
   - Evidence: the target denominator uses the positive lower slope endpoint
     `nominalSlope - slopeUncertainty`; the assumptions ensure it is positive.
   - Status: **covered (the theorem body remains `sorry` by stage design)**.

7. **Fixed official sample versus raw graph**
   - Source claim: the official sample is `1.17 ± 0.03 K/W`.
   - Lean carrier: `officialSampleEstimate` and
     `officialSampleEstimateReadout`.
   - Evidence: both values have the thermal-resistance dimension and exact SI
     readouts.
   - Status: **blocked for linkage to an arbitrary run**. The supplied chapter
     and listed source-page image contain no raw fitted slope, slope error,
     mass, or `c₀` values from which those two numbers could honestly be
     derived. The file therefore records the sample without assuming that an
     arbitrary run equals it.

8. **Figure 17 numeric cylinder dimensions**
   - Source claim: use the dimensions in Figure 17.
   - Lean carrier: the dimensionful fields and validity equations in
     `Figure17Dimensions`.
   - Evidence: the only authorized listed page image contains the C.6 page and
     procedure but does not reproduce Figure 17 or its numerical radii.
   - Status: **blocked for numeric constants; covered as explicit parameters**.

## Abstraction sufficiency and countermodel audit

- `Figure17Dimensions.Valid` is constraining: it exposes radius positivity and
  ordering, positive wall height, the cylindrical area equation, and both
  water-height equations.
- `ThermalExperiment.ValidParameters` is constraining: it exposes strict
  positivity for mass, water specific heat, resistance, and conductivity.
- `ThermalExperiment.SatisfiesLaws` is constraining: every physical relation
  exposes a derivative equality or a scalar equation. It cannot be interpreted
  as an arbitrary opaque predicate.
- `C5GraphReadout` is a data structure with constraining proposition fields:
  increasing times, both coordinate definitions, a linear-through-origin
  equation, and a nonzero-gap witness.
- `C5PreviousPartResult` is constraining: its elimination field is the exact
  C.5 slope equation used by C.6.
- `SlopeMeasurement.ValidFor` is constraining: it exposes nonnegative
  uncertainty, a strictly positive lower slope endpoint, and an absolute-error
  inequality.
- Countermodel check for the exact result: with the slope law and all three
  factors positive, the main reciprocal conclusion cannot be made false by
  assigning arbitrary values to the local interfaces.
- Countermodel check for uncertainty: the absolute slope-error bound and
  positive lower endpoint supply exactly the inequalities needed to bound the
  reciprocal error.

## Uncertainty and branch coverage

- **Uncertainty: covered.** The fitted slope uncertainty occurs in a theorem
  contract and is propagated to an explicit resistance-error output. The
  official `0.03 K/W` value is retained as dimensionful sample data.
- **Heat-flow orientation: covered.** Heat flow is named outer-to-inner, the
  graph gap is `T_OC - T_IC`, the radial derivative is explicitly outward,
  and Fourier's law retains its minus sign.
- **Reciprocal branch: covered.** Positive mass, heat capacity, resistance,
  nominal slope lower endpoint, and slope uncertainty select the physical
  positive branch.

## Declarations created and blueprint labels

- Blueprint `thm:physics:IPhO_2026_4_C_6:target`:
  `IPhO2026Problems.IPhO2026_4_C_6.determineEffectiveWallThermalResistance`.
- Auxiliary uncertainty target:
  `IPhO2026Problems.IPhO2026_4_C_6.determineEffectiveWallThermalResistanceWithUncertainty`.
- Official sample readout:
  `IPhO2026Problems.IPhO2026_4_C_6.officialSampleEstimateReadout`.
- Supporting declarations: all dimension expressions and dimensionful quantity
  types, `Figure17Dimensions`, `ThermalExperiment`,
  `ThermalExperiment.SatisfiesLaws`, `C5GraphReadout`,
  `C5PreviousPartResult`, `SlopeMeasurement`, and `ResistanceEstimate`.
- The target blueprint statement is ready for the deterministic `sync_leanok`
  phase. The blueprint was not edited because prover write permissions reserve
  it as read-only.

## LeanExplore queries and candidates actually used

- Query: `physical dimensions SI units temperature thermal resistance thermal
  conductivity heat capacity`
  - Used candidates: `Dimension`, `UnitChoices.SI`.
- Query: `PhysLean Units SI temperature energy time length`
  - Used candidates: `DimEnergy`, `UnitChoices.SI`.
- Query: `DimensionalQuantity`
  - Used candidate: `Dimensionful`.
- Query: `dimensionful quantity with physical dimension and unit choices`
  - Used candidates: `Dimensionful`,
    `CarriesDimension.toDimensionful`.
- Query: `SI mass kilogram dimensional mass`
  - Used candidate: `UnitChoices.SI_mass` as API/unit-system grounding.
- Query: `temperature difference kelvin dimensional quantity`
  - Inspected candidates: `Temperature`, `UnitChoices.SI_temperature`.
    `Temperature` was not used because it is an absolute nonnegative
    temperature wrapper, whereas the graph needs signed temperature
    differences.
- Query: `thermal resistance kelvin per watt physical dimension`
  - No ready-made thermal-resistance quantity was found; `Dimension` and the
    SI temperature API were used to construct the derived dimension locally.
- Query: `measurement uncertainty value plus or minus error interval`
  - No matching physical measurement API was found.
- Query: `absolute value bound interval uncertainty propagation reciprocal`
  - The search found general reciprocal/absolute-value results but no matching
    uncertainty object; a faithful local interval predicate was introduced.

## Physlib/Mathlib names grounded

- Physlib: `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`,
  `Dimension.M𝓭`, `Dimension.Θ𝓭`, `Dimensionful`, `WithDim`,
  `UnitChoices.SI`, `CarriesDimension.toDimensionful`, `DimEnergy`,
  and `DimArea`.
- Mathlib: `HasDerivAt`, `Real.pi`, real absolute value, inequalities, and
  real division.

## Local abstractions introduced

- Derived dimensionful quantity types were introduced for heat-flow rate,
  temperature rate, inverse time, specific heat capacity, thermal resistance,
  thermal conductivity, and temperature gradient because LeanExplore found no
  ready-made thermal-conduction API. They are not scalar aliases: each is a
  Physlib `Dimensionful (WithDim d ℝ)` with the correct physical dimension.
- `Figure17Dimensions` preserves the apparatus geometry as physical quantities.
- `ThermalExperiment.SatisfiesLaws` preserves the governing heat and Fourier
  equations with derivative and sign information.
- `C5GraphReadout` preserves the actual graph axes and fit rather than replacing
  the graph with a bare scalar slope.
- `SlopeMeasurement.ValidFor` is the smallest local uncertainty interface that
  exposes the mathematical error inequality needed for propagation.

## Grounding gaps and redraft requests

- LeanExplore found no ready-made Physlib thermal resistance, thermal
  conductivity, temperature-gradient, heat-flow-rate, or measurement
  uncertainty API. Correct derived dimensions and explicit local relations
  were used instead.
- The authorized source-page image does not show Figure 17's numerical cylinder
  dimensions. A future plan/review pass should add those constants only if an
  authorized source image containing Figure 17 is supplied.
- The fixed official `1.17 ± 0.03 K/W` sample cannot be linked to a raw C.5
  regression without its fitted slope, slope uncertainty, mass, and `c₀`
  readouts. If such raw values are supplied, add a theorem instantiating the
  general uncertainty result; do not add the numerical C.6 answer as a premise.
- `archon dag-query` could not be run because `archon` was not on `PATH` in
  this prover environment. No sibling dependency was needed.

## Verification

- Lean LSP diagnostics: only the three expected `declaration uses sorry`
  warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_C_6.lean`: exit code 0,
  with the same three expected warnings.

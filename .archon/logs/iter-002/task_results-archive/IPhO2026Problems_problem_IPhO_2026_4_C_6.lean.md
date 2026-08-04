# Autoformalization result: `IPhO2026Problems/problem_IPhO_2026_4_C_6.lean`

## Assumption/target split

### Governing laws

- `GoverningLaws.heatFlowThroughWall` states
  `dQ/dt = (T_OC - T_IC) / R_Th`.
- `GoverningLaws.innerWaterEnergyBalance` states
  `dQ/dt = c₀ m dT_IC/dt`; this is the calorimetry balance after neglecting
  apparatus heat capacity.
- `GoverningLaws.radialFourierConduction` states
  `dQ/dt = -λ A dT/dr`.
- Positivity fields on `ThermalExperiment` state the physical ranges of
  specific heat, water mass, effective resistance, acrylic conductivity, and
  conduction area.

### Previous-part results

- The hypothesis `c5SlopeRelation` is exactly the allowed natural-language
  C.5 conclusion:
  `slope = 1 / (c₀ * m * R_Th)`.
- No C.5 Lean module is imported or referenced.

### Figure/data readouts

- `Figure17Geometry` retains the cylindrical-wall labels `r₁`, `r₂`, and `h`,
  including positive height and the ordering `0 < r₁ < r₂`. The supplied
  official page did not show the numerical Figure 17 dimensions, so these
  remain measured dimensionful inputs.
- `ProcedureReadouts` records the official-page settings: IC water height
  0.10 m, OC water height 0.15 m, and initial OC temperature 65 °C, with its
  absolute SI readout expressed as `65 + 273.15` K.
- `TemperatureObservation` records simultaneous `t`, `T_IC`, and `T_OC`.
  `finiteDifferenceInnerRateSI`, `averageDrivingTemperatureDifferenceSI`, and
  `c5PlotPointSI` encode the two plotted C.5 axes.
- `C5GraphReadout` retains the fitted inverse-time slope and its measured
  scalar uncertainty.
- `officialSampleResistance` records `1.17 ± 0.03 K/W` only as official sample
  metadata, not as a hypothesis about the experiment.

### Current target conclusions

- `effectiveWallThermalResistance_from_C5Graph` concludes
  `R_Th = 1 / (c₀ * m * slope)` in SI readouts.

## Goal-faithfulness audit

The current C.6 resistance formula does not occur as a hypothesis, structure
field, governing-law field, satisfaction predicate, or helper definition.
`ThermalExperiment` contains the independent physical quantities and their
positivity properties; `GoverningLaws` contains only the heat-flow,
calorimetry, and Fourier equations. The only solved-looking premise is
`c5SlopeRelation`, explicitly the reusable C.5 result stated by the blueprint.
Turning that inverse relation around to isolate `R_Th` remains the conclusion
of the C.6 theorem. The official numerical sample is a standalone reported
estimate and is never assumed equal to the experiment's resistance.

## Declarations created and blueprint correspondence

- Dimensional helpers and types:
  `energyDimension`, `powerDimension`, `thermalResistanceDimension`,
  `specificHeatCapacityDimension`, `thermalConductivityDimension`,
  `DimTemperature`, `DimTime`, `DimLength`, `DimMass`, `DimArea`,
  `DimHeatEnergy`, `DimHeatFlowRate`, `DimThermalResistance`,
  `DimSpecificHeatCapacity`, `DimThermalConductivity`,
  `DimTemperatureRate`, `DimTemperatureGradient`, `DimInverseTime`, and
  `siReadout`.
- Figure and graph declarations:
  `Figure17Geometry`, `ProcedureReadouts`, `TemperatureObservation`,
  `finiteDifferenceInnerRateSI`, `averageDrivingTemperatureDifferenceSI`,
  `c5PlotPointSI`, and `C5GraphReadout`.
- Physical-model declarations:
  `ThermalExperiment` and `GoverningLaws`.
- Sample metadata:
  `ThermalResistanceEstimate` and `officialSampleResistance`.
- `IPhO2026Problems.IPhO2026_4_C_6.effectiveWallThermalResistance_from_C5Graph`
  corresponds to blueprint label
  `thm:physics:IPhO_2026_4_C_6:target`.

The target statement is ready for statement-level `\leanok` association by the
deterministic marker sync. The prover did not edit the blueprint, as required
by the local role permissions.

## LeanExplore queries and candidates actually used

- Query:
  `physical dimensions SI units temperature time energy heat flow thermal resistance thermal conductivity`.
  Candidates inspected: `UnitChoices.SI`, `DimEnergy`, `Dimension`, and
  `DimEnergy.joule`.
- Query: `PhysLean Units SI Temperature Time Energy Power`.
  Candidates inspected included `UnitChoices.SI`, `DimEnergy`,
  `UnitChoices.SI_time`, `UnitChoices.SI_temperature`, and
  `TemperatureUnit`.
- Source/module details fetched and used:
  `Dimension` from `Physlib.Units.Dimension`,
  `UnitChoices.SI` from `Physlib.Units.Basic`, and
  `DimEnergy` / `DimEnergy.joule` from
  `Physlib.Units.WithDim.Energy`.

## PhysLean/Mathlib names grounded

- Physlib/PhysLean: `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`,
  `Dimension.M𝓭`, `Dimension.Θ𝓭`, `WithDim`, `Dimensionful`,
  `UnitChoices.SI`, and `DimEnergy`.
- Mathlib: `ℝ`, ordered-field arithmetic, lists, products, and `norm_num`
  for the nonnegative sample uncertainty.

## Local abstractions introduced

- Physlib has dimensional energy and a general unit system but no ready-made
  thermal-resistance, specific-heat-capacity, thermal-conductivity,
  heat-flow-rate, or temperature-gradient types. These were defined as
  `Dimensionful (WithDim d ℝ)` at their correct physical dimensions, rather
  than as scalar aliases or ad hoc one-field wrappers.
- `Figure17Geometry`, `ProcedureReadouts`, `TemperatureObservation`, and
  `ThermalExperiment` preserve the apparatus, measurement, and material roles
  as multi-field physical interfaces.
- `GoverningLaws` is a faithful local law interface because no matching
  radial-conduction API was found. It does not contain the current answer.
- Real numbers appear only as explicit SI projections, finite-difference graph
  coordinates, and reported central values/uncertainties.

## Grounding gaps and redraft requests

- LeanExplore returned no ready-made thermal-resistance or radial Fourier
  conduction declaration; faithful dimensioned local abstractions were needed.
- The official source page specified for this task contains the C.5/C.6 text
  and the 10 cm, 15 cm, and 65 °C protocol values, but not Figure 17 itself or
  its numerical `r₁`, `r₂`, `h` dimensions. The model therefore preserves
  these labels abstractly instead of inventing values.
- The chapter contains no `\lean{...}` declaration name. Marker sync or the
  plan/review agent should associate the target environment with
  `IPhO2026Problems.IPhO2026_4_C_6.effectiveWallThermalResistance_from_C5Graph`.
- The advertised `archon` dependency-graph executable was unavailable on
  `PATH` (`archon: command not found`). This caused no dependency ambiguity
  because the chapter explicitly requires the C.5 result only as a
  natural-language prerequisite.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_C_6.lean` exited 0 with
  only the expected `declaration uses sorry` warning on the target theorem.

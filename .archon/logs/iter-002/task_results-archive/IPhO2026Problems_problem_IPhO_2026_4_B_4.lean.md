# Autoformalization result: IPhO 2026 Problem 4 B.4

## Assumption/target split

### Governing laws

- `B4Assumptions.referenceDaltonLaw` and
  `B4Assumptions.measuredDaltonLaw` state that total pressure is the sum of
  the dry-air and water-vapor partial pressures in each state.
- `B4Assumptions.icOcReferencePressureBalance` and
  `B4Assumptions.icOcMeasuredPressureBalance` encode the idealized consequence
  of the Figure 19 IC/OC equal-water-level procedure: inner-cylinder total
  pressure equals atmospheric pressure.
- `B4Assumptions.referenceVaporPressureNegligible` is the problem-authorized
  zero-vapor-pressure approximation at the extrapolated `T₀` state.
- `B4Assumptions.dryAirIdealGasConservation` is the fixed-amount dry-air ideal
  gas invariant `P_d V / T = constant` between the reference and measured
  states.
- `B4Assumptions.referenceCylinderGeometry` and
  `B4Assumptions.measuredCylinderGeometry` state `V = A H` for the uniform
  inner cylinder.
- Positivity fields make atmospheric pressure, cross-sectional area, absolute
  temperatures, and both gas-column heights physically admissible and provide
  all nonzero factors needed by the later algebra.
- `ObeysClausiusClapeyron` records the surrounding logarithmic
  Clausius--Clapeyron law for the later vapor-pressure fit. It is deliberately
  not assumed by B.4, because its positive reference saturation pressure is a
  different modeling context from the B.4 instruction to neglect vapor
  pressure in the extrapolated calibration state.

### Previous-part results

- `officialB3ReferenceHeightMetre` records the official sample extrapolation
  `H₀ = 5.9 cm = 0.059 m`.
- `officialB3ReferenceVolumeCubicMetre` records its corresponding sample
  volume `V₀ = 53.4 mL = 0.0000534 m³`.
- These are recorded constants rather than hypotheses of the main theorem.
  Thus B.4 remains valid for an arbitrary experimental `H₀`, and no sibling
  Lean output is imported, in accordance with the
  `natural_language_prerequisite_only` policy.

### Figure/data readouts

- `Figure19Apparatus` distinguishes the inner-cylinder cross-section,
  atmospheric pressure, extrapolated reference state, and measured state.
- `InnerCylinderGasState` records absolute temperature, gas-column height,
  gas volume, total pressure, dry-air partial pressure, and water-vapor partial
  pressure.
- `PressureMeasurement`, `LengthMeasurement`, `AreaMeasurement`,
  `VolumeMeasurement`, and `AbsoluteTemperatureMeasurement` pair SI scalar
  readouts with dimensionful Physlib quantities.
- The Figure 19 labels and roles IC, OC, and valve E are preserved in the
  module and apparatus documentation. Their substantive consequence for B.4
  is exposed by the two IC/OC pressure-balance equations.
- `icePointTemperatureKelvin` records `T₀ = 273.15 K`, and
  `referenceTemperature_is_ice_point` ties the reference readout to it.
- `universalGasConstantJoulePerMoleKelvin` records the later-question reference
  value `R = 8.31 J/(mol·K)`. `ClausiusClapeyronContext` also retains `Qᵥ`,
  `R`, `Pᵥ₀`, and `T₀` with their physical roles.

### Current target conclusions

- The sole current answer is the conclusion of
  `IPhO2026Problems.IPhO2026_4_B_4.vaporPressurePascal_eq`:
  `Pᵥ = P_atm * (1 - H₀ * T / (H * T₀))`, expressed using the corresponding
  SI readouts in `Figure19Apparatus`.

## Goal-faithfulness audit

The requested B.4 formula appears only in the conclusion of
`vaporPressurePascal_eq`. It does not occur in `B4Assumptions`, in either
measurement or apparatus structure, in `ObeysClausiusClapeyron`, or in any
local definition.

The strongest premise is the independent ideal-gas invariant
`P_d0 V₀ / T₀ = P_d V / T`. Obtaining the target still requires using the
cylinder equations to replace both volumes, Dalton's law and the reference
zero-vapor approximation to identify `P_d0`, the measured Dalton/pressure
balance to eliminate `P_d`, and algebraic cancellation of positive factors.
The B.3 numeric constants and the ice-point definition do not unfold to the
current target. No current conclusion was smuggled into a premise field or a
definition.

## Derivability and bridge obligations

1. **Physical quantities to SI scalar equations — covered.**
   Source claim: pressure, height, area, volume, and absolute temperature have
   distinct dimensional roles but the requested expression uses measured
   scalar components. Lean carriers:
   `PressureMeasurement`, `LengthMeasurement`, `AreaMeasurement`,
   `VolumeMeasurement`, and `AbsoluteTemperatureMeasurement`, each with a
   `calibrated` equality using
   `CarriesDimension.toDimensionful UnitChoices.SI`. Evidence: Physlib
   `Dimensionful`, `WithDim`, `Dimension.L𝓭`, `Dimension.Θ𝓭`, and
   `DimPressure`.

2. **Figure 19 level matching to atmospheric total pressure — covered.**
   Source claim: adjustment through the OC/syringe/valve-E arrangement keeps
   IC pressure approximately atmospheric. Lean carriers:
   `icOcReferencePressureBalance` and `icOcMeasuredPressureBalance`.
   The exact equalities are the explicit idealization used by the official
   symbolic answer; no numerical pressure-head error is supplied.

3. **Cylinder height to gas volume — covered.**
   Source claim: the IC has a uniform cross-section, hence `V₀ = A H₀` and
   `V = A H`. Lean carriers: `referenceCylinderGeometry`,
   `measuredCylinderGeometry`, and `crossSection_pos`.

4. **Reference dry-air pressure — covered.**
   Source claim: at the calibration state the vapor contribution is neglected,
   while total pressure is atmospheric. Lean carriers:
   `referenceDaltonLaw`, `icOcReferencePressureBalance`, and
   `referenceVaporPressureNegligible`. Together they force
   `P_d0 = P_atm`.

5. **Fixed dry air from the reference state to the measured state — covered.**
   Source claim: the amount of dry air is unchanged and obeys the ideal-gas
   law. Lean carrier: `dryAirIdealGasConservation`. After substituting the two
   cylinder equations, the positive common cross-section cancels and yields
   `P_d = P_atm * H₀ * T / (H * T₀)`. The required nonzero temperature,
   height, and area facts are all explicit fields.

6. **Measured dry-air pressure to measured vapor pressure — covered.**
   Source claim: `P_atm = P_d + Pᵥ` in the measured state. Lean carriers:
   `measuredDaltonLaw` and `icOcMeasuredPressureBalance`.

7. **All physical bridges to the requested closed form — covered.**
   Lean carrier:
   `IPhO2026Problems.IPhO2026_4_B_4.vaporPressurePascal_eq`.
   This theorem contract combines the independent equations above and leaves
   the cancellation/rearrangement as its intentionally deferred `sorry` body.

8. **Clausius--Clapeyron context for the later fit — covered, not used by the
   current target.** Lean carrier: `ObeysClausiusClapeyron`, which supplies
   positivity and the logarithmic equation at every positive temperature.

No substantive source-to-Lean bridge is blocked.

## Abstraction sufficiency and countermodel audit

- `ObeysClausiusClapeyron` is a transparent `Prop`. For every positive
  temperature it requires both positive vapor pressure and the explicit
  logarithmic equation. It cannot be satisfied merely by assigning an opaque
  relation witness.
- `B4Assumptions` is the only other local `Prop`-valued interface. It exposes
  positivity inequalities, both `V = A H` equations, both Dalton equations,
  both atmospheric pressure-balance equations, the zero reference-vapor
  equation, measured-vapor nonnegativity, and the dry-air ideal-gas invariant.
- The measurement structures are data structures rather than opaque
  `Prop`-valued laws; each includes an equality calibrating its physical
  dimensionful quantity to its named SI scalar readout.

Countermodel check: the reference Dalton, pressure-balance, and zero-vapor
fields force `P_d0 = P_atm`. The two geometry equations and dry-air invariant,
together with positive `A`, `H`, `T₀`, and `T`, force the measured dry-air
pressure. The measured Dalton and pressure-balance equations then force
`Pᵥ`. Consequently the assumptions cannot all remain true while the main
formula is false merely by interpreting the local structures arbitrarily.

## Uncertainty and branch coverage

- **Reported numerical uncertainty: genuinely not applicable.** Neither the
  chapter nor the source report contains a `value ± uncertainty` datum.
- **Atmospheric-pressure approximation: covered as a documented model
  idealization.** The source says the level-matched pressure is approximately
  atmospheric, but provides no pressure-head correction or error bar to
  propagate. The two exact balance equations state the approximation used in
  the official one-point algebraic answer.
- **Units/dimensions: covered.** Every basic measured quantity is paired with
  its Physlib dimensionful SI quantity; scalar fields name pascals, metres,
  square metres, cubic metres, kelvins, joules per mole, or
  joules per mole-kelvin explicitly.
- **Height/temperature branches: covered.** Both heights, both absolute
  temperatures, and the cross-sectional area are strictly positive.
- **Pressure branch: covered.** Atmospheric pressure is positive and measured
  vapor pressure is nonnegative.
- **Reference-pressure modeling branch: covered.** The B.4 negligible-vapor
  calibration is kept separate from the positive-reference-pressure
  Clausius--Clapeyron context, avoiding an inconsistent branch conflation.
- **Signed orientation: not otherwise applicable.** The requested answer
  contains no incoming/outgoing, clockwise/counterclockwise, or tangent branch.

## Declarations created and blueprint correspondence

All declarations support blueprint label
`thm:physics:IPhO_2026_4_B_4:target`.

- Dimensioned measurements: `PressureMeasurement`, `LengthMeasurement`,
  `AreaMeasurement`, `VolumeMeasurement`,
  `AbsoluteTemperatureMeasurement`.
- Physical setup: `InnerCylinderGasState`, `Figure19Apparatus`.
- Source constants: `officialB3ReferenceHeightMetre`,
  `officialB3ReferenceVolumeCubicMetre`, `icePointTemperatureKelvin`,
  `universalGasConstantJoulePerMoleKelvin`.
- Contextual law: `ClausiusClapeyronContext`,
  `ObeysClausiusClapeyron`.
- B.4 governing interface: `B4Assumptions`.
- Main target:
  `IPhO2026Problems.IPhO2026_4_B_4.vaporPressurePascal_eq`.

The blueprint theorem currently has no `\lean{...}` declaration reference.
Per prover write permissions, the blueprint was not edited. The sync/review
lane should associate the environment with the fully qualified main theorem
and manage the statement-level `\leanok`; the proof remains intentionally
unfinished.

## LeanExplore queries/candidates actually used

All searches used `packages: ["Mathlib", "Physlib"]`.

- `physical dimensional quantity pressure temperature length SI units`
- `ideal gas law pressure volume temperature amount of substance`
- `DimLength DimTemperature DimVolume dimensional quantities`
- `dimensionful length meter quantity`
- `Dimension temperature basis symbol WithDim temperature`

Candidates whose source/module information informed the contract:

- `Dimension` from `Physlib.Units.Dimension`.
- `Dimensionful` and `CarriesDimension.toDimensionful`.
- `DimPressure` and `DimPressure.pascal` from
  `Physlib.Units.WithDim.Pressure`.
- `Dimension.L𝓭` and `Dimension.Θ𝓭`.
- `UnitChoices.SI` and `UnitChoices.SI_length`.
- `UnitExamples.meters400`, which confirmed the standard
  `toDimensionful SI ⟨readout⟩` construction.

Candidate inspected but not used directly:

- `IdealGas.ideal_gas_law` from
  `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas`. Its theorem
  is tied to that statistical-mechanics model and explicitly uses a unitsless
  convention `R = 1`; it is not a carrier for the two-state SI-readout
  conservation equation in this experiment. The faithful relation is therefore
  exposed locally as `B4Assumptions.dryAirIdealGasConservation`.

## PhysLean/Mathlib names grounded

- Physlib: `Dimension`, `Dimensionful`, `WithDim`, `Dimension.L𝓭`,
  `Dimension.Θ𝓭`, `DimPressure`, `CarriesDimension.toDimensionful`, and
  `UnitChoices.SI`.
- Mathlib: `ℝ` and `Real.log`.

## Local abstractions introduced

- The five measurement structures retain both a genuine Physlib
  dimensionful quantity and its usable SI scalar readout. They are not aliases
  or one-field scalar wrappers.
- `InnerCylinderGasState` and `Figure19Apparatus` preserve the physical roles
  of the mixture, its partial pressures, the IC geometry, the reference state,
  and the measured state.
- `B4Assumptions` is the smallest local governing-law interface sufficient to
  derive the answer while exposing every substantive equation.
- `ClausiusClapeyronContext` and `ObeysClausiusClapeyron` preserve the quoted
  surrounding law and later-fit quantities without incorrectly making that law
  a premise of the B.4 calibration derivation.

## Grounding gaps

- No ready-made Physlib/Mathlib declaration was found for Dalton partial
  pressure additivity, the Figure 19 water-level pressure balance, a uniform
  cylindrical gas-volume law, or the required two-state fixed-dry-air
  ideal-gas invariant with SI readouts. These are encoded as explicit,
  constraining local equations.
- The optional `archon dag-query` executable was not available on `PATH`.
  The blueprint itself specifies only B.3 as a natural-language prerequisite,
  which is recorded locally without a sibling Lean import.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_4.lean`: exit code 0
  with exactly the same expected warning.
- `archon-protected.yaml` contains no active protected declarations affecting
  this file.

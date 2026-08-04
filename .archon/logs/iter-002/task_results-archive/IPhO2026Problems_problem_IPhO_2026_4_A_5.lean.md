# Autoformalization result: IPhO 2026 problem 4, A.5

## Assumption/target split

### Governing laws

- `GoverningLaws` states that the reference, initial-recorded, and
  heated-recorded states have the same sealed-air volume and each obeys the
  molar ideal-gas equation `P V = n R T`.
- `PhysicalAdmissibility` supplies positivity of volume, amount, gas constant,
  reference pressure, and reference temperature, together with a nonzero
  measured temperature change.
- `ExperimentalConditions` records the prescribed apparatus operations:
  propylene glycol is introduced into `IC`, valves `D` and `E` are closed,
  `CA` is sealed, the pump homogenizes the water-bath temperature, and the
  `OC` water bath is heated.

### Previous-part results

- `PreviousPartA3Linearity` is the permitted natural-language prerequisite
  from A.3. It says that one positive pressure-per-temperature slope describes
  the reference state and the initial and heated recorded states. No previous
  Lean file is imported.

### Figure/data readouts

- `ApparatusLabel` retains the page/figure labels `CA`, `PG`, `IC`, `OC`,
  valve `D`, and valve `E`.
- `CylinderDimensions` and `Figure17Geometry` retain the inner- and
  outer-cylinder dimensions, the confined-air-column length, and its volume as
  dimensionful physical quantities.
- `SourceReadouts` states only supplied inputs: glycol height `0.045 m`,
  ambient-air density `1.12 kg m⁻³`, and reference temperature `273.15 K`.
- `IsochoricAirExperiment` retains the amount of air, universal gas constant,
  dimensional states, and procedure facts.

### Current target conclusions

- Existence of a physical `ThermalPressureCoefficient` whose SI readout obeys
  equation (2), `β₀ = (1/P₀)(ΔP/ΔT)`.
- The official result `β₀ = 0.0034 ± 0.0007 K⁻¹`, encoded by
  `MatchesOfficialExperimentalResult`.
- The ideal-gas comparison that `1 / 273.15 K` rounds to
  `0.0037 K⁻¹` within half of the last displayed decimal place.

## Goal-faithfulness audit

The requested coefficient relation and numerical interval occur only in the
conclusion of `target`. They do not occur in `SourceReadouts`,
`ExperimentalConditions`, `GoverningLaws`, `PhysicalAdmissibility`, or
`PreviousPartA3Linearity`. The A.3 hypothesis contains only the explicitly
permitted proportionality of pressure to absolute temperature and no A.5
coefficient or numerical answer. `pressureChangePascal` and
`temperatureChangeKelvin` are naming expansions of differences between the two
recorded states; neither asserts the result. `MatchesCoefficientDefinition`
states the problem's supplied definition on the conclusion side rather than
assuming it.

## Declarations created

- Blueprint label `thm:physics:IPhO_2026_4_A_5:target` corresponds to
  `IPhO2026Problems.IPhO2026_4_A_5.target`.
- Physical quantity roles: `Length`, `Volume`, `MassDensity`,
  `ThermalPressureCoefficient`, and `siValue`.
- Apparatus/data model: `ApparatusLabel`, `CylinderDimensions`,
  `Figure17Geometry`, `AirColumnState`, and `IsochoricAirExperiment`.
- Assumption interfaces: `SourceReadouts`, `ExperimentalConditions`,
  `SatisfiesIdealGasLawAt`, `GoverningLaws`, `PreviousPartA3Linearity`, and
  `PhysicalAdmissibility`.
- Target helpers: `pressureChangePascal`, `temperatureChangeKelvin`,
  `MatchesCoefficientDefinition`, `WithinUncertainty`, and
  `MatchesOfficialExperimentalResult`.

The blueprint currently contains no `\lean{...}` annotation. It is ready to
reference `\lean{IPhO2026Problems.IPhO2026_4_A_5.target}`. Per the prover role
rules, the blueprint was not edited; deterministic marker synchronization can
manage `\leanok`.

## LeanExplore queries/candidates actually used

Queries used with `packages: ["Mathlib", "Physlib"]`:

- `ideal gas equation of state pressure volume amount universal gas constant temperature`
- `thermodynamic pressure temperature constant volume isochoric process`
- `dimensioned physical quantity SI units pressure volume temperature density inverse temperature`
- `DimLength DimVolume dimensional volume length density`
- `physical quantity density mass per volume dimensionful`
- `kelvin temperature unit dimensionful temperature`

Candidates inspected:

- `IdealGas.ideal_gas_law`
- `DimPressure`
- `DimPressure.pascal`
- `Temperature`
- `UnitChoices.SI`
- `Dimensionful`
- `FluidDynamics.MassDensity`

## PhysLean/Mathlib names grounded

- Used `DimPressure` from `Physlib.Units.WithDim.Pressure`.
- Used `Temperature` from
  `Physlib.Thermodynamics.Temperature.Basic`.
- Used `Dimension`, `Dimensionful`, `WithDim`, dimension symbols `L𝓭`, `M𝓭`,
  `Θ𝓭`, and `UnitChoices.SI` from Physlib's units infrastructure.
- Used Mathlib real arithmetic and absolute-value notation for scalar SI
  readouts and uncertainty intervals.

`DimPressure.pascal` was inspected as the canonical one-pascal physical
quantity, but the final model uses the more general `siValue` evaluation at
`UnitChoices.SI`, matching Physlib's dimensionful representation.

## Local abstractions introduced

- `Length`, `Volume`, `MassDensity`, and `ThermalPressureCoefficient` are not
  scalar aliases. They specialize Physlib's `Dimensionful (WithDim ...)` to
  the required physical dimensions.
- `SatisfiesIdealGasLawAt` is a local governing-law predicate because the
  available `IdealGas.ideal_gas_law` is a unitless statistical-mechanics
  theorem with `R = 1`, not the source's molar SI law with an explicit
  universal gas constant.
- Amount of substance and the gas constant are explicit scalar SI readouts
  with unit-bearing field names because Physlib's dimension system has no
  amount-of-substance base dimension.
- `PreviousPartA3Linearity` faithfully packages only the natural-language A.3
  result and does not import or depend on an earlier Lean output.

## Grounding gaps

- LeanExplore did not expose a dimensionful molar ideal-gas-law declaration
  compatible with `P V = n R T`; the local predicate above records the exact
  mismatch rather than guessing an API.
- The only authorized source image is page 9. It names the apparatus and gives
  the `4.5 cm` fill height but does not display Figure 17's numerical cylinder
  dimensions. Those quantities are therefore retained symbolically in
  `Figure17Geometry`; no values were invented.
- The `archon` executable was not available on `PATH`, so `dag-query` could not
  be run. The chapter independently specifies that A.3 is a
  natural-language-only prerequisite.

## Verification

`lake env lean IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` exits successfully
with exactly the expected warning that `target` uses `sorry`.

# Autoformalization result: IPhO 2026 Problem 4 A.1

## Assumption/target split

### Governing laws

- `GoverningLaws.cylinder_geometry`: the sealed air volume is the cylindrical
  inner-cylinder volume below the usable height and above the propylene-glycol
  fill height.
- `GoverningLaws.mass_density`: `m = ρ V`.
- `GoverningLaws.ideal_gas`: `P V = n R T`, stated for SI scalar readouts of
  the dimensioned quantities and the model's mole readout.
- `GoverningLaws.molecule_amount`: `N = n N_A`.
- `PhysicalAdmissibility` records positivity of the radius, air-column height,
  density, pressure, temperature, gas constant, and Avogadro constant.
- `ExperimentalConditions` records introduction of propylene glycol into `IC`,
  closed valves `D` and `E`, sealed `CA`, fixed volume, and the heated
  outer-cylinder water bath.

### Previous-part results

- None. The source report lists no previous parts, and the file imports no
  preceding IPhO problem declaration.

### Figure/data readouts

- `Figure17Geometry` preserves the labelled inner-cylinder and outer-cylinder
  radial/axial quantities, propylene-glycol height, and confined air volume.
- `SourceReadouts.glycol_height` states `h = 0.045 m`.
- `SourceReadouts.ambient_density` states `ρ_a = 1.12 kg/m³`.
- `IsochoricAirSetup` preserves `CA`, `IC`, `OC`, valves `D`/`E`, the gas
  constant, and Avogadro conversion roles.

### Current target conclusions

`determineConfinedAirInventory` concludes, rather than assumes:

- `m = ρ π r² (H - h)`;
- `n = P π r² (H - h) / (R T)`;
- `N = N_A P π r² (H - h) / (R T)`.

The recorded numerical answer is represented separately by
`officialMassEstimateKilograms`, `officialAmountEstimateMoles`,
`officialMoleculeCountEstimate`, and `MatchesOfficialSample`.

## Goal-faithfulness audit

- None of the three solved target formulas occurs as a theorem hypothesis or
  premise field. The laws contain only the unsolved volume, mass-density,
  ideal-gas, and amount-to-population relations; the theorem must combine and
  algebraically solve them.
- `cylindricalAirVolumeSI` is only the standard cylinder-geometry expression.
  It does not mention mass, moles, molecule count, or any official answer.
- The official answer predicate is not assumed by the target theorem and is
  not used as an unfolding shortcut.
- Amount of substance and molecular population were not collapsed to real
  aliases. They are abstract physical roles with explicitly named scalar
  readouts in `SubstanceCountingModel`.
- The theorem is intentionally left with the required `by sorry` body for the
  `physics-formalize` stage; there are no `axiom` declarations.

## Declarations and blueprint labels

- Blueprint label `thm:physics:IPhO_2026_4_A_1:target` corresponds to
  `IPhO2026Problems.IPhO2026_4_A_1.determineConfinedAirInventory`.
- Supporting declarations:
  `Length`, `Volume`, `Mass`, `MassDensity`, `AbsoluteTemperature`, `Pressure`,
  `siValue`, `SubstanceCountingModel`, `ConfinedAirState`,
  `Figure17Geometry`, `IsochoricAirSetup`, `cylindricalAirVolumeSI`,
  `GoverningLaws`, `SourceReadouts`, `ExperimentalConditions`,
  `PhysicalAdmissibility`, `ScalarEstimate`, `WithinEstimate`, and
  `MatchesOfficialSample`.
- The blueprint chapter was not edited because the prover write permissions
  and `.archon/AGENTS.md` reserve blueprint markers for deterministic sync or
  review. The theorem is ready for a `\lean{...}` association and subsequent
  `\leanok` sync.

## LeanExplore queries/candidates actually used

- Query: `physical quantities with dimensions SI units mass volume density
  pressure temperature amount of substance`
  - Used `UnitChoices.SI`, `Dimension`, and `DimPressure`.
- Query: `PhysLean Dimension Length Mass Time Temperature AmountOfSubstance
  volume density`
  - Used `Dimension.L𝓭`, `Dimension.M𝓭`, and `Dimension.Θ𝓭`.
  - Rejected `FluidDynamics.MassDensity`: its source is an abbreviation for a
    spatial scalar field and does not retain the dimensional role required
    here.
- Queries: `PhysLean physical quantity with dimension Quantity dimensions units
  SI value` and `WithDim`
  - Used `WithDim` and `Dimensionful`-compatible SI evaluation.
- Query: `ideal gas law P V = n R T amount of substance Avogadro constant
  molecule count`
  - Inspected `IdealGas.ideal_gas_law`.
  - Rejected it as a near miss: its source explicitly uses a unitless system
    with `R = 1`, and its pressure is the pressure derived from that library's
    statistical-mechanics `IdealGas`, not the apparatus pressure quantity.
- Query: `Avogadro AvogadroConstant mole molar amount of substance`
  - Found `Constants.kB`, but no compatible amount-of-substance dimension,
    mole quantity, or Avogadro constant API.

## Physlib/Mathlib names grounded

- `Dimension`, `Dimension.L𝓭`, `Dimension.M𝓭`, `Dimension.Θ𝓭`
  (`Physlib.Units.Dimension`).
- `WithDim` (`Physlib.Units.WithDim.Basic`).
- `Dimensionful` and `UnitChoices.SI` (`Physlib.Units.Basic`).
- `DimPressure` (`Physlib.Units.WithDim.Pressure`).
- `Real.pi` and real absolute-value/order notation from the imported
  Mathlib/Physlib environment.

## Local abstractions introduced

- `SubstanceCountingModel` supplies abstract types for amount of substance and
  molecular population plus mole/count readouts. This is necessary because
  Physlib's `Dimension` has only length, time, mass, charge, and temperature
  components.
- `Figure17Geometry` is the smallest geometry interface that preserves the
  cylinder roles while allowing the missing Figure 17 numbers to be supplied
  later.
- `GoverningLaws`, `ExperimentalConditions`, and `PhysicalAdmissibility`
  separate physical assumptions from target conclusions.
- `ScalarEstimate` records the official experimental centres and
  uncertainties as scalar outputs, which the modeling rules explicitly permit.

## Grounding gaps

- The only supplied source image, `E1_page-9.png`, contains part A and the
  `h = 4.5 cm`/density text but does not contain Figure 17. Consequently the
  cylinder dimensions remain symbolic; no numerical radius or usable height
  was guessed. Source curation should attach the official page containing
  Figure 17 if a later theorem relating the symbolic solution to
  `MatchesOfficialSample` is desired.
- The recorded values deserve source verification: `n = 3.24 mmol` and
  `N = 1.95·10²¹` agree through Avogadro's constant, while `m = 0.94 g` would
  imply about `0.29 kg/mol`, a factor-of-ten mismatch with ordinary air's
  molar mass. The file faithfully records the chapter's `0.94 g` rather than
  silently correcting it, and keeps this numerical sample out of the
  governing-law theorem.
- The `archon dag-query` helper was unavailable on `PATH` in this prover lane,
  so no dependency-graph declarations were used.

## Verification

- Lean LSP diagnostics: one expected `declaration uses sorry` warning, no
  errors.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`: exit code 0
  with the same single expected warning.

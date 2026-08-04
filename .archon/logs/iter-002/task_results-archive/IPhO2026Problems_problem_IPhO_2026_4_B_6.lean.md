# Autoformalization result: `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`

## Assumption/target split

### Governing laws

- `GoverningLaws.partialPressureBalance` states that the inner-cylinder total
  pressure is the sum of the dry-air and water-vapor partial pressures.
- `GoverningLaws.clausiusClapeyron` states the supplied integrated
  Clausius--Clapeyron relation using `P_v`, `P_v0`, `Q_v`, `R`, `T`, and `T_0`.
- `GoverningLaws.vaporizedMassFromMoles` states that an arbitrary positive
  amount `n` of water has mass `M_0 n`.
- `GoverningLaws.latentEnergyFromMoles` states that vaporizing `n` moles
  requires energy `Q_v n`.
- `GoverningLaws.latentEnergyFromMass` independently states that the same
  energy is `L_v` times the vaporized mass.
- `GoverningLaws.molarMass_positive` records the nonzero physical range needed
  to obtain a quotient.

### Previous-part results

- `PreviousPartB5Result` contains exactly the licensed natural-language B.5
  readouts: graph slope `-4700 ± 200 K` and molar latent heat
  `Q_v = 39 ± 2 kJ/mol`, stored as `39000 ± 2000 J/mol`.
- No previous-part Lean file is imported or referenced.

### Figure/data readouts

- `VaporizationExperiment` retains the source labels `P_atm`, total pressure,
  dry-air pressure, `P_v`, `P_v0`, `H(T)`, `T_0`, `H_0`, `R`, `Q_v`, `M_0`,
  `L_v`, the fitted slope, latent energy for an amount in moles, and the
  corresponding vaporized water mass.
- `HasReferenceAndProcedureData` records `T_0 = 273.15 K`, the extrapolated
  height `H_0`, negligible vapor pressure at `T_0`, `R = 8.31 J/(mol K)`,
  water molar mass `M_0 = 18/1000 kg/mol`, and total pressure controlled near
  `P_atm`.
- The official page-12 image was inspected. It has no new B.6 geometry beyond
  the inner-cylinder labels and explicitly asks for the molar-to-specific
  conversion.

### Current target conclusions

- `latentHeatPerUnitMass_from_molarEstimate` concludes the requested formula
  `L_v = Q_v / M_0` on SI readouts.
- Its second conjunct expresses `L_v = 2190 ± 110 kJ/kg` as membership in the
  reported uncertainty band after converting the SI `J/kg` readout to
  `kJ/kg`.

## Goal-faithfulness audit

The quotient `L_v = Q_v / M_0` and the numerical `2190 ± 110 kJ/kg` report
occur only in the theorem conclusion. They are not hypotheses, setup fields,
data fields, or governing-law fields. In particular, `GoverningLaws` does not
assume the quotient: it separately describes mass and energy for every
positive mole amount. Obtaining the quotient requires specializing those laws
to a nonzero amount, identifying the common energy, and cancelling the
positive molar mass. The numerical band additionally requires the licensed B.5
readout and water molar-mass datum. No definition unfolds to the target
formula.

## Declarations created and blueprint correspondence

- `energyDimension`, `specificEnergyDimension`, the dimensioned quantity
  abbreviations, and `siReadout`: physical dimensions and SI projections.
- `MolarLatentHeatEstimate`: the two-component scalar experimental report in
  `J/mol`.
- `VaporizationExperiment`: apparatus, figure labels, material parameters,
  and unknown B.6 quantity.
- `HasReferenceAndProcedureData`: supplied/reference readouts.
- `GoverningLaws`: partial-pressure, Clausius--Clapeyron, mole-to-mass, and
  latent-energy laws.
- `PreviousPartB5Result`: the permitted B.5 conclusion.
- `IPhO2026Problems.IPhO2026_4_B_6.latentHeatPerUnitMass_from_molarEstimate`
  corresponds to blueprint label
  `thm:physics:IPhO_2026_4_B_6:target`.

The target statement is ready for statement-level `\leanok` synchronization.
The blueprint has no `\lean{...}` declaration name, and prover permissions
forbid editing the chapter; marker sync or the plan/review agent should
associate the environment with the fully qualified theorem name above.

## LeanExplore queries/candidates actually used

- Query: `molar mass and molar latent heat physical quantities with units`.
  Candidates inspected: `Dimension`, `CarriesDimension.toDimensionful`,
  `UnitChoices.SI`, and `Dimension.M𝓭`.
- Query: `specific energy energy per unit mass physical dimension`.
  Candidates inspected: `Dimensionful`,
  `UnitExamples.EnergyMassWithDim'`, and `UnitExamples.EnergyMass`.
- Query: `WithDim Dimensionful physical units`.
  Candidates inspected: `Dimensionful`,
  `CarriesDimension.toDimensionful`, and `WithDim.val_add`.
- Source/module/docstrings fetched for `Dimension`,
  `Dimensionful`, `CarriesDimension.toDimensionful`,
  `UnitExamples.EnergyMassWithDim'`, and `UnitExamples.EnergyMass`.

## PhysLean/Mathlib names grounded

- PhysLean: `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`,
  `Dimension.M𝓭`, `Dimension.Θ𝓭`, `WithDim`, `Dimensionful`,
  `UnitChoices.SI`, and the `DimEnergy` dimension convention.
- Mathlib: `Real.log` and real absolute value/order notation.

## Local abstractions introduced

- `MolarLatentHeatEstimate` is a multi-field experimental estimate rather than
  a physical scalar alias. It keeps central value, uncertainty, and the
  `J/mol` role explicit.
- Molar latent heat, water molar mass, gas constant, and graph slope use
  explicitly unit-named real readouts because PhysLean's foundational
  `Dimension` has no amount-of-substance component. All available
  non-molar quantities use PhysLean's dimension-carrying types.
- `VaporizationExperiment` and its law/data interfaces retain the apparatus
  and thermodynamic roles without defining the requested answer.

## Grounding gaps and redraft requests

- LeanExplore found no ready-made molar mass, molar latent heat, or specific
  latent heat declaration. PhysLean's `Dimension` source confirms that amount
  of substance is not among its five foundational dimensions, necessitating
  the explicitly unit-named molar scalar readouts.
- The advertised `archon dag-query` executable was not available on `PATH`
  (`archon: command not found`), so dependency navigation could not be used.
  The chapter's natural-language-only B.5 policy was followed directly.
- The chapter currently lacks a `\lean{...}` name for its theorem environment;
  associate it with
  `IPhO2026Problems.IPhO2026_4_B_6.latentHeatPerUnitMass_from_molarEstimate`.

## Verification

- Archon Lean LSP diagnostics: only the expected `declaration uses sorry`
  warning at the target theorem.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`: exit code 0,
  with only the expected `sorry` warning.

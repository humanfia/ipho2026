# IPhO2026Problems/problem_IPhO_2026_4_B_6.lean

The file was created and verified with:

```text
lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_6.lean
```

The command exits successfully with exactly four expected `sorry` warnings
and no errors.

## Assumption/target split

### Governing laws

- `VaporPressureLaws` records that the gas is in the inner cylinder, positive
  absolute temperatures and logarithm pressures, `T₀ = 273.15 K`,
  `R = 8.31 J/(mol·K)`, dry-air plus vapor partial-pressure balance, total
  pressure approximately equal to atmospheric pressure, the zero-vapor
  approximation at freezing, and
  `log(Pᵥ/Pᵥ₀) = -(1000 Qᵥ/R)(1/T - 1/T₀)`.
- `VaporizationExtensivity` is the governing conversion mechanism. For one
  positive batch it gives
  `m = n M₀`, `E = n Qᵥ`, and `E = m Lᵥ`, together with the corresponding two
  extensive uncertainty equations. It does not contain either quotient
  requested in B.6.
- `WaterMolarMassData` supplies the water datum
  `M₀ = 18/1000 kg/mol`, treated as exact for the stated propagation.

### Previous-part results

- `PreviousPartB5Result` records the natural-language B.5 input without
  importing a sibling Lean file: the graph has horizontal axis `1/T`,
  vertical axis `log(Pᵥ/P_atm)`, slope `-4700 ± 200 K`, and experimental molar
  latent heat `Qᵥ = 39 ± 2 kJ/mol`.

### Figure/data readouts

- `WaterVaporExperiment` preserves the IC/OC apparatus label and the named
  readouts `H`, `H₀`, `T`, `T₀`, `P_atm`, total gas pressure, dry-air pressure,
  `Pᵥ`, the freezing-point vapor pressure, the positive logarithm
  normalization pressure `Pᵥ₀`, and `R`.
- `CylinderLabel` preserves the inner-cylinder/outer-cylinder labels from the
  apparatus. The gas-region law selects the inner cylinder.
- `ClausiusClapeyronPlot` and `GraphAxisQuantity` preserve the axes and
  kelvin-valued slope from the B.5 graph.
- The provided page-12 figure gives no additional numerical geometry beyond
  the IC/OC and `H,H₀` setup, so no cylinder dimensions were invented.

### Current target conclusions

- `latent_heat_of_vaporization_per_unit_mass` concludes the requested formula
  `Lᵥ.central = Qᵥ.central / M₀.central`.
- It separately concludes the propagated absolute uncertainty
  `Lᵥ.uncertainty = Qᵥ.uncertainty / M₀.central`.
- It concludes
  `CompatibleReportedMeasurement Lᵥ 2190 110 2`, explicitly retaining the
  official `2190 ± 110 kJ/kg` report.

## Goal-faithfulness audit

Neither quotient conclusion occurs in `VaporPressureLaws`,
`PreviousPartB5Result`, `WaterMolarMassData`, or
`VaporizationExtensivity`. In particular, the extensivity interface stops at
the three source-level equations `m = nM₀`, `E = nQᵥ`, and `E = mLᵥ`; division
by the nonzero batch amount and positive molar mass remains a proof
obligation.

The official values `2190` and `110` occur only on the conclusion side of
`official_specific_latent_heat_report` and the main theorem. No premise field
mentions them. `CompatibleReportedMeasurement` unfolds to inequalities and is
not true by reflexivity.

The compatibility relation is intentional rather than a weakening hidden in a
hypothesis. The previous part reports the already-rounded input
`39 ± 2 kJ/mol`; exact division by `0.018 kg/mol` gives central and uncertainty
readouts `2166.6…` and `111.1…`, not the literal pair `2190,110`. The contract
therefore proves the exact conversion and exact uncertainty propagation first,
then states that the official printed central value lies in the propagated
uncertainty interval and that the printed uncertainty differs by at most
`2 kJ/kg`.

## Derivability and bridge obligations

1. **Experimental setup to thermodynamic molar quantity — covered.**
   Source claim: the IC dry-air/water-vapor experiment is governed by pressure
   balance and Clausius--Clapeyron. Lean carrier:
   `VaporPressureLaws.partial_pressure_balance`,
   `total_pressure_approximately_atmospheric`, and
   `clausius_clapeyron`. Evidence: these fields expose the exact equation and
   approximation inequality, including the kJ-to-J factor. This bridge grounds
   the physical role of `Qᵥ`; B.6 does not need to rederive B.5.

2. **Natural-language B.5 result to local B.6 premise — covered.**
   Source claim: plot `log(Pᵥ/P_atm)` against `1/T`, with sample slope
   `-4700 ± 200 K` and `Qᵥ = 39 ± 2 kJ/mol`. Lean carrier:
   `PreviousPartB5Result`. Evidence: all axis, central-value, and uncertainty
   fields are explicit equalities. No sibling Lean dependency is introduced.

3. **Extensive energy and mass to `Lᵥ = Qᵥ/M₀` — covered.**
   Source claim: latent heat per unit mass is molar latent heat divided by
   molar mass. Lean carrier:
   `specific_latent_heat_formula_of_extensivity`. Evidence:
   `VaporizationExtensivity` supplies `m=nM₀`, `E=nQᵥ`, and `E=mLᵥ`, while
   positive `n` and positive `M₀` discharge the required nonzero divisors.

4. **Uncertainty propagation through exact molar mass — covered.**
   Source claim: division by the exact `M₀` scales the absolute uncertainty by
   `1/M₀`. Lean carrier:
   `specific_latent_heat_uncertainty_of_extensivity`. Evidence: the two
   extensive energy-uncertainty equalities force the quotient after canceling
   the positive batch amount.

5. **Rounded inputs to the official `2190 ± 110` report — covered.**
   Source claim: state the official numerical result. Lean carrier:
   `official_specific_latent_heat_report`. Evidence: after substituting
   `Qᵥ = 39 ± 2` and `M₀ = 18/1000`, real arithmetic gives
   `|39/(18/1000)-2190| ≤ 2/(18/1000)` and
   `|2/(18/1000)-110| ≤ 2`. The carrier records both the propagated interval
   and uncertainty-rounding check.

6. **All source premises to the B.6 output — covered.**
   Lean carrier: `latent_heat_of_vaporization_per_unit_mass`, which consumes
   the apparatus thermodynamics, B.5 result, molar-mass data, and extensive
   batch laws and concludes the formula, uncertainty formula, and official
   report compatibility.

All carriers are present at statement level. Their four proof bodies are
intentionally `sorry` in the autoformalize stage.

## Abstraction sufficiency and countermodel audit

- `VaporPressureLaws` is a local `Prop`-valued interface constrained by
  positivity conditions, exact constants, a pressure-balance equality, an
  atmospheric-pressure error inequality, and the full logarithmic
  Clausius--Clapeyron equation.
- `PreviousPartB5Result` is constrained by exact axis-label and numerical
  central/uncertainty equalities.
- `WaterMolarMassData` is constrained by `M₀ = 18/1000`, zero uncertainty, and
  positivity.
- `VaporizationExtensivity` is constrained by eight explicit
  equations/inequalities. Its central and uncertainty equations are directly
  eliminable by structure projections.
- `CompatibleReportedMeasurement` is transparent and exposes nonnegativity
  plus two absolute-value inequalities; it is not an opaque report tag.

Countermodel check: `amount_positive` makes the amount nonzero,
`WaterMolarMassData.positive` makes `M₀` nonzero, and
`mass_from_amount_and_molar_mass` makes the batch mass nonzero. The two energy
equalities then force `Lᵥ.central = Qᵥ.central/M₀.central`; the two uncertainty
equalities force the analogous uncertainty quotient. Once B.5 and the molar
mass datum are substituted, the three inequalities in the official report are
fixed real-arithmetic facts. Thus the local interfaces cannot be interpreted
arbitrarily while all assumptions remain true and the current conclusions
become false.

## Uncertainty and branch coverage

- **Uncertainty: covered.** `Measurement` carries a nonnegative absolute
  uncertainty in the same display unit. B.5 retains both `±200 K` and
  `±2 kJ/mol`. The B.6 theorem propagates the latter by division through exact
  `M₀` and retains the official `±110 kJ/kg` report. The central comparison is
  against the propagated interval, not merely an unrelated fixed tolerance.
- **Molar-mass uncertainty: covered as an explicit modeling assumption.**
  `WaterMolarMassData.treated_as_exact` records why no denominator uncertainty
  term appears; the source provides no uncertainty for `M₀`.
- **Branch/orientation: genuinely not applicable.** B.6 is a positive scalar
  unit conversion and has no incoming/outgoing, clockwise/counterclockwise, or
  tangent branch. Positivity of amount and molar mass fixes the physically
  meaningful division branch.

## Declarations created and blueprint labels

All declarations support
`thm:physics:IPhO_2026_4_B_6:target`.

- Unit/data vocabulary: `DisplayUnit`, `Measurement`, `CylinderLabel`,
  `GraphAxisQuantity`, `ClausiusClapeyronPlot`,
  `WaterVaporExperiment`, `VaporizationBatch`.
- Governing/previous-data interfaces: `VaporPressureLaws`,
  `PreviousPartB5Result`, `WaterMolarMassData`,
  `VaporizationExtensivity`, `CompatibleReportedMeasurement`.
- Bridge obligations: `specific_latent_heat_formula_of_extensivity`,
  `specific_latent_heat_uncertainty_of_extensivity`,
  `official_specific_latent_heat_report`.
- Main target: `latent_heat_of_vaporization_per_unit_mass`.

The chapter currently contains only the generic autoformalization environment
and no `\lean{...}` declaration name. The semantic handoff is:

```text
\lean{IPhO2026Problems.IPhO2026_4_B_6.latent_heat_of_vaporization_per_unit_mass}
```

The theorem environment is ready for statement-level `\leanok`
synchronization. Per `.archon/AGENTS.md`, this prover lane did not edit the
blueprint; marker insertion belongs to the deterministic synchronization
phase.

## LeanExplore queries/candidates actually used

All searches passed `packages: ["Mathlib", "Physlib"]`.

- Query:
  `dimensionful physical quantity SI units energy per mole molar mass energy per mass latent heat`
  - Candidates inspected: `UnitChoices.SI`, `Dimensionful`, `DimEnergy`,
    `Dimension`, `CarriesDimension.toDimensionful`.
- Query:
  `Dimensionful SI Joule kilogram mole Kelvin pressure physical units definitions`
  - Candidates inspected: `UnitChoices.SI`, `Dimensionful`, `DimPressure`,
    `DimPressure.pascal`, `DimEnergy.joule`.
- Query:
  `uncertainty measurement plus minus interval absolute error propagation division real numbers`
  - Candidates inspected: `Real.instDivisionRing`,
    `WithDim.instHDivRealHMulDimensionInv`, and Mathlib interval declarations.
- Query:
  `WithDim DimMass DimEnergy division multiplication physical quantity syntax units PhysLean`
  - Candidates inspected: `WithDim`, `WithDim.val_div_val`,
    `WithDim.instHDivRealHMulDimensionInv`, `DimEnergy`.
- Query:
  `DimMass kilogram DimMoles mole amount of substance UnitChoices SI`
  - Candidates inspected: `UnitChoices.SI_mass`, `MassUnit`,
    `Dimensionful`; no amount-of-substance dimension was returned.
- Query: `Real.log natural logarithm real numbers`
  - Candidate used: `Real.log`.

Source/module details were fetched for `Dimensionful` from
`Physlib.Units.Basic`, `WithDim` from
`Physlib.Units.WithDim.Basic`, `DimEnergy` from
`Physlib.Units.WithDim.Energy`,
`WithDim.instHDivRealHMulDimensionInv`,
`WithDim.val_div_val`, and `Real.log`.

## PhysLean/Mathlib names grounded

- Mathlib: `ℝ`, real division and absolute value, and `Real.log`
  (`Mathlib.Analysis.SpecialFunctions.Log.Basic`) are used in the contract.
- Physlib candidates `Dimensionful`, `WithDim`, `DimEnergy`, `DimPressure`,
  `UnitChoices.SI`, and the `WithDim` division instance were grounded but are
  near misses for this theorem because the installed dimensional basis does
  not track moles and its quantity types do not carry experimental
  uncertainty.

## Local abstractions introduced

- `DisplayUnit` is an index, not a transparent alias to `ℝ`; it distinguishes
  pressure, temperature, length, energy, mass, amount, molar, and
  specific-energy roles at the type level.
- `Measurement unit` is a three-field experimental record containing a scalar
  readout, its absolute uncertainty, and a proof that the uncertainty is
  nonnegative. It is used because final measured scalar components may be real
  while their physical roles remain type-indexed.
- `WaterVaporExperiment` preserves the physical apparatus and named readouts
  without inventing absent cylinder dimensions.
- `VaporizationBatch` preserves amount, mass, and energy as distinct extensive
  measured quantities.
- The four local law/result structures expose equations, inequalities, and
  reusable elimination data. They do not hide the B.6 answer.

## Grounding gaps and redraft requests

- **Molar-dimension/uncertainty API gap:** the located Physlib dimensional
  quantities cover MLT-style energy, mass, and pressure, but the search found
  no mole/amount-of-substance dimension or measurement-uncertainty structure
  suitable for `kJ/mol`, `kg/mol`, and `kJ/kg`. The indexed local measurement
  abstraction fills this gap.
- **Source rounding gap:** the rounded B.5 sample `39 ± 2 kJ/mol` divided by
  `0.018 kg/mol` is not literally the exact pair `2190 ± 110 kJ/kg`. The
  contract preserves the exact quotient and exact propagated uncertainty, and
  represents the printed B.6 pair with an explicit, proof-relevant
  compatibility relation. A future blueprint expansion should document the
  official solution's unrounded intermediate value or rounding convention if
  available.
- **`Pᵥ₀` ambiguity:** the chapter simultaneously says vapor pressure at
  freezing is taken as zero and places `Pᵥ₀` in a logarithmic denominator.
  The file keeps a zero freezing-point approximation and a separate positive
  Clausius normalization pressure, avoiding a contradictory `log(Pᵥ/0)` model.
- **Dependency navigation:** `archon dag-query` returned no node/ancestor data
  for the generic blueprint label. The chapter explicitly requires the B.5
  conclusion to be carried as natural-language input only, so no sibling Lean
  import was introduced.

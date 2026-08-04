# IPhO2026Problems/problem_IPhO_2026_4_A_1.lean

## Result

- Created the assigned Lean file from a previously absent path.
- Confirmed the blueprint contains `% archon:physics`; the
  `physics-formalize` discipline was used.
- No `/- USER: ... -/` hint was present because the assigned file did not
  previously exist.
- Lean LSP diagnostics report no errors and exactly three expected
  `declaration uses sorry` warnings.

## Assumption/target split

### Governing laws

- `Figure17GeometryLaw` gives positivity, the prescribed glycol height
  `h = 0.045 m`, the remaining air height, and the cylindrical-volume equation.
- `IsochoricApparatusRun.volumeFixed` records the fixed-volume consequence of
  closing valves D and E; `stateVolumeFromFigure` identifies the state volume
  with the Figure 17 volume.
- `AirInventoryLaws.mass_from_density` states `m = ρV` on SI readouts.
- `AirInventoryLaws.ideal_gas` states `PV = nRT` on SI readouts.
- `AirInventoryLaws.molecules_from_amount` states `N = n N_A`.
- `ScalarMeasurement.Covers` gives the mathematical semantics of
  `central ± uncertainty`.

### Previous-part results

- None. The source report has `previous_parts: []`, and the file imports no
  sibling IPhO module.

### Figure/data readouts

- `Figure17Geometry` names the inner-cylinder diameter, usable height,
  prescribed glycol fill height, remaining confined-air height, and confined
  volume.
- `ValveLabel.D` and `ValveLabel.E` preserve the two valve labels from the
  procedure.
- `AmbientDensityReadout` records `ρ_a = 1.12 kg m⁻³`.
- `IsochoricApparatusRun` records the pressure, temperature, and volume traces
  during outer-bath heating.
- `ExperimentalInputReadouts` carries central values and uncertainties for
  diameter, usable height, glycol height, density, pressure, and temperature.
- The supplied official page shows the A.1 procedure and `PV = nRT`, but it
  does not show Figure 17's numerical cylinder dimensions or uncertainty
  readouts.

### Current target conclusions

- `determineConfinedAirInventory` concludes the exact mass formula after
  substituting the cylindrical volume, solves the ideal-gas law for amount in
  moles, and substitutes that result into the Avogadro relation for molecule
  population.
- `propagateInventoryUncertainty` concludes lower and upper bounds for mass,
  amount, and molecule population obtained from the input error intervals.
- `officialSampleTarget` concludes agreement with the recorded sample:
  `0.94 ± 0.02 g`, `3.24 ± 0.7 mmol`, and
  `(1.95 ± 0.05) × 10²¹` molecules.

## Goal-faithfulness audit

The three official output intervals occur only through
`AgreesWithOfficialSample`, which is the conclusion of
`officialSampleTarget`. They do not occur in `Figure17GeometryLaw`,
`AirInventoryLaws`, `AmbientDensityReadout`, `IsochoricApparatusRun`, or any
other theorem premise. `officialSample` merely records the source's reported
data and does not make `AgreesWithOfficialSample` true by unfolding: after
unfolding, three nontrivial absolute-error inequalities remain.

The governing-law fields stop at the independent physical relations `m = ρV`,
`PV = nRT`, and `N = nN_A`. The symbolic target additionally requires
substituting the figure geometry and solving the ideal-gas equation. The
uncertainty target requires monotone interval propagation. No current target
conclusion has been smuggled into a premise structure or local law.

The numerical target is faithfully stated but not proof-ready from the supplied
source page: its missing numerical figure/readout data are explicitly recorded
as a blocked bridge below, rather than being invented or added as a
target-equivalent premise.

## Derivability and bridge obligations

1. **Physical dimensions and SI projection — covered.**
   - Source claim: diameter/height, volume, mass, density, pressure, and
     temperature have distinct dimensional roles.
   - Lean carrier: `LengthQuantity`, `VolumeQuantity`, `MassQuantity`,
     `MassDensityQuantity`, `DimPressure`, `TemperatureQuantity`, and
     `siValue`.
   - Evidence: Physlib `Dimensionful`, `WithDim`, `Dimension`, and
     `UnitChoices.SI`.

2. **Figure 17 geometry to fixed air volume — covered symbolically.**
   - Source claim: filling PG to `4.5 cm` fixes the cylindrical CA volume.
   - Lean carrier: `Figure17GeometryLaw` and
     `IsochoricApparatusRun.stateVolumeFromFigure`.
   - Evidence: the blueprint context and official page procedure.

3. **Closing valves to an isochoric run — covered.**
   - Source claim: closing D and E keeps CA volume fixed while pressure and
     temperature are recorded.
   - Lean carrier: `valveDClosed`, `valveEClosed`, and `volumeFixed`.

4. **Density and volume to mass — covered.**
   - Source claim: confined-air mass is ambient density times volume.
   - Lean carrier: `AirInventoryLaws.mass_from_density`, combined with
     `Figure17GeometryLaw` by `determineConfinedAirInventory`.

5. **Ideal-gas equation to amount — covered.**
   - Source claim: `PV = nRT`.
   - Lean carrier: `AirInventoryLaws.ideal_gas`, with nonzero gas constant and
     temperature hypotheses; `determineConfinedAirInventory` carries the
     division/algebra bridge to `n = PV/(RT)`.
   - Physlib's `IdealGas.ideal_gas_law` was inspected but rejected because it
     is explicitly unitless and fixes `R = 1`.

6. **Amount to molecule count — covered.**
   - Source claim: `N = nN_A`.
   - Lean carrier: `AirInventoryLaws.molecules_from_amount`; the main theorem
     substitutes the amount solved from the gas law.

7. **Input uncertainties to output intervals — covered.**
   - Source claim: dimensional/data uncertainty must be propagated to `m`,
     `n`, and `N`.
   - Lean carrier: `InputReadoutsCover`, `ValidInputReadouts`,
     `propagatedVolumeLower/Upper`, `propagatedMassLower/Upper`,
     `propagatedAmountLower/Upper`, `InventoryInPropagatedBounds`, and
     `propagateInventoryUncertainty`.
   - The lower/upper expressions expose the actual interval arithmetic rather
     than merely placing a fixed tolerance around an output.

8. **Symbolic inventory to the official numerical sample — blocked.**
   - Source claim: the outputs are the three reported numerical intervals.
   - Lean carrier: `officialSample`, `AgreesWithOfficialSample`, and
     `officialSampleTarget`.
   - Missing evidence: the only supplied source-page image does not contain
     Figure 17's numerical dimensions, pressure/temperature values used for
     A.1, or input error bars. Consequently the physical assumptions admit
     countermodels with other volumes and inventories.
   - Status: **blocked pending source/blueprint redraft**. No fabricated
     dimensions or target-equivalent premise was introduced.

9. **Direct source-to-contract mapping — covered.**
   - Source claim: determine `m`, `n`, and `N` while preserving the reported
     values and uncertainties.
   - Lean carriers: `determineConfinedAirInventory`,
     `propagateInventoryUncertainty`, and `officialSampleTarget`.
   - The theorem bodies remain `sorry` as required at autoformalization.

## Abstraction sufficiency and countermodel audit

- `ScalarMeasurement.Covers` unfolds to
  `|actual - central| ≤ uncertainty`; `lower` and `upper` expose its interval
  endpoints.
- `Figure17GeometryLaw` exposes three positivity constraints, the exact
  `4.5 cm` conversion, the remaining-height equation, and the cylinder-volume
  equation.
- `IsochoricApparatusRun` is constrained by Boolean equations closing D and E,
  a pointwise fixed-volume equality, and equality of state and figure volume.
- `AirInventoryLaws` exposes the three independent physical equations
  `m = ρV`, `PV = nRT`, and `N = nN_A`.
- `AmbientDensityReadout` unfolds to the explicit SI equality `ρ_a = 1.12`.
- `InputReadoutsCover` unfolds to six absolute-error inequalities.
- `ValidInputReadouts` exposes all nonnegativity/positivity inequalities needed
  to use endpoint monotonicity.
- `InventoryInPropagatedBounds` exposes six lower/upper inequalities on the
  three requested outputs.
- `AgreesWithOfficialSample` unfolds to three absolute-error inequalities after
  explicit `kg → g`, `mol → mmol`, and `N → N/10²¹` conversions.

Countermodel sanity:

- For `determineConfinedAirInventory`, the geometry and inventory-law
  equations force every conclusion after field algebra; the interface cannot
  be interpreted arbitrarily while falsifying the target.
- For `propagateInventoryUncertainty`, coverage and positivity constrain every
  input to its interval and the endpoint expressions propagate those
  constraints through the monotone formulas.
- For `officialSampleTarget`, the current supplied assumptions are
  underdetermined because no numerical Figure 17/readout calibration is
  present. This is intentionally reported as a blocked contract requiring
  source redraft, not concealed by a fake law or answer hypothesis.

## Uncertainty and branch coverage

- **Mass uncertainty: preserved; propagation interface covered; numerical
  calibration blocked.** The `±0.02 g` interval occurs in the official target,
  and `propagateInventoryUncertainty` derives a mass interval from density and
  geometry uncertainties. The source does not supply those input errors.
- **Amount uncertainty: preserved; propagation interface covered; numerical
  calibration blocked.** The `±0.7 mmol` interval occurs in the official
  target, and pressure/volume/temperature intervals propagate through
  `n = PV/(RT)`.
- **Molecule uncertainty: preserved; propagation interface covered; numerical
  calibration blocked.** The `±0.05 × 10²¹` interval occurs in the official
  target and the Avogadro conversion propagates the amount interval.
- **Uncertainty consistency warning:** propagating the stated
  `±0.7 mmol` amount uncertainty with an Avogadro factor near
  `6.02 × 10²³ mol⁻¹` would produce roughly
  `±0.42 × 10²¹` molecules, not the reported `±0.05 × 10²¹`. The blueprint
  should confirm whether `0.7 mmol` is a decimal-place transcription issue or
  an independently defined uncertainty.
- **Branch/orientation: genuinely not applicable.** Mass, amount, molecule
  population, dimensions, temperature, gas constant, and Avogadro factor are
  constrained nonnegative/positive. No signed trajectory, tangent,
  clockwise/counterclockwise, or asymptotic branch occurs in A.1.
- **Isochoric procedure branch: covered.** Both named valves are explicitly
  closed and the entire volume trace equals the state volume.

## Declarations created and blueprint correspondence

All declarations support
`thm:physics:IPhO_2026_4_A_1:target`.

- Physlib-backed quantity declarations:
  `LengthQuantity`, `VolumeQuantity`, `MassQuantity`,
  `TemperatureQuantity`, `MassDensityQuantity`, and `siValue`.
- Local physical/data declarations:
  `AmountOfSubstance`, `MoleculePopulation`, `ScalarMeasurement`,
  `InventoryReport`, `officialSample`, `Figure17Geometry`,
  `ConfinedAirColumnState`, `ValveLabel`, `IsochoricApparatusRun`,
  `ExperimentalInputReadouts`.
- Governing relations:
  `Figure17GeometryLaw`, `AirInventoryLaws`,
  `AmbientDensityReadout`, `InputReadoutsCover`,
  `ValidInputReadouts`, and `InventoryInPropagatedBounds`.
- Bridge/target declarations:
  `determineConfinedAirInventory`, `propagateInventoryUncertainty`,
  `AgreesWithOfficialSample`, and `officialSampleTarget`.

The blueprint has no `\lean{...}` name. The review/planning pass should map its
target environment to
`\lean{IPhO2026Problems.Problem4A1.officialSampleTarget}` and may also link the
symbolic and uncertainty bridge theorems. The declarations are ready for
statement-level `\leanok` synchronization. Per prover permissions and
`.archon/AGENTS.md`, this lane did not edit the blueprint; marker synchronization
owns that change.

## LeanExplore queries/candidates actually used

Every query used `packages: ["Mathlib", "Physlib"]`.

1. `physical quantity with SI units and dimensions, mass volume density amount
   of substance temperature pressure`
   - Used: `UnitChoices.SI`, `Dimension`, `Dimensionful`, `DimPressure`.

2. `PhysicalQuantity Measure DimMass DimVolume density mole amount of
   substance SI kilogram meter`
   - Used: `Dimensionful`, `CarriesDimension.toDimensionful`, `WithDim`.

3. `ideal gas equation pressure volume amount gas constant temperature
   Avogadro number molecules moles`
   - Inspected: `IdealGas.ideal_gas_law`.
   - Rejected for this contract: its source states that it is a unitless system
     with `R = 1`, while A.1 requires dimensional SI readouts and the universal
     gas constant.

4. `DimLength DimMass DimVolume` and
   `DimLength DimMass DimVolume DimDensity Dimensionful SI value unit
   conversion kilograms meters cubic meter`
   - Used compositionally: `Dimension.L𝓭`, `Dimension.M𝓭`, `WithDim`, and
     `Dimensionful`.
   - `DimArea` was inspected as the pattern for constructing derived
     dimensionful quantities.

5. `AmountOfSubstance mole molar amount Avogadro constant molecule count`
   - No usable amount-of-substance or Avogadro carrier was returned.
   - `Constants.kB` is Boltzmann's constant and does not replace `R` or `N_A`.

Source and module metadata were fetched for `Dimensionful`,
`UnitChoices.SI`, `CarriesDimension.toDimensionful`, `WithDim`, `DimArea`,
`DimPressure`, and `IdealGas.ideal_gas_law`.

## PhysLean/Mathlib names grounded

- Physlib:
  `Dimension`, `Dimension.L𝓭`, `Dimension.M𝓭`, `Dimension.Θ𝓭`,
  `WithDim`, `Dimensionful`, `UnitChoices.SI`, and `DimPressure`.
- Mathlib:
  `ℝ`, `Real.pi`, real absolute value notation, powers, inequalities, and
  `norm_num` for nonnegative literal uncertainties.

## Local abstractions introduced

- `AmountOfSubstance` is a distinct nonnegative physical quantity with a mole
  readout because Physlib's dimension system currently omits amount of
  substance. It is not a transparent real alias.
- `MoleculePopulation` is a nonnegative experimental count estimate, allowing
  the real-valued uncertainty reported by the source.
- `ScalarMeasurement` preserves central value and uncertainty separately and
  exposes an absolute-error inequality.
- `Figure17Geometry`, `ConfinedAirColumnState`, and
  `IsochoricApparatusRun` preserve apparatus roles, figure labels, unit-bearing
  quantities, valve states, traces, and the fixed-volume law.
- `AirInventoryLaws` supplies constraining physical equations rather than an
  opaque “valid physics” tag.

## Grounding gaps

- **Amount/Avogadro API gap:** Physlib has no amount-of-substance base dimension
  or Avogadro constant carrier. Faithful constrained local abstractions are
  used.
- **Ideal-gas API mismatch:** `IdealGas.ideal_gas_law` uses a unitless
  statistical-mechanics model with `R = 1`; it cannot carry this SI experiment.
- **Dependency navigation gap:** the advertised `archon dag-query` executable
  was not on `PATH`; the source report has no previous parts, so this did not
  create a dependency ambiguity.

## Redraft requests

- **Figure/data gap:** provide Figure 17's numerical inner-cylinder dimensions,
  the pressure/temperature or molar-mass data used for A.1, and the associated
  input uncertainties. Without them, `officialSampleTarget` is not derivable.
- **Recorded-answer consistency request:** confirm the decimal places in
  `0.94 g`, `3.24 ± 0.7 mmol`, and the molecule uncertainty. The current amount
  and molecule error bars do not propagate consistently under `N = nN_A`.
- **Blueprint link request:** add the declaration links described above and
  flesh out the informal numerical derivation once the missing Figure 17 data
  are available.

# Autoformalization result: IPhO 2026 Problem 3 C.1

## Outcome

- Iteration 009 made the single requested code change: a direct `import Mathlib` was added before the two existing Physlib imports.
- All declarations, theorem signatures, physical hypotheses, conclusions, and named SI projections were preserved.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_1.lean` succeeds with no errors and exactly two intended warnings:
  - `identify_isothermal_reservoir_contacts` uses `sorry`.
  - `identify_temperature_labels_and_heat_processes` uses `sorry`.
- The Archon Lean LSP independently reports exactly the same two warnings at theorem declaration lines 277 and 291 and no failed dependencies.
- The requested command
  `lake build IPhO2026Problems.problem_IPhO_2026_3_C_1`
  was run, but Lake reports `unknown target`. The checkout's `lakefile.toml`
  declares only the library root `IPhO2026Run`; `IPhO2026Problems` is not a
  registered Lean library root. This target-registration issue is outside this
  prover lane's permitted files. The direct module check above confirms that
  the assigned file itself elaborates.

The blueprint contains `% archon:physics`. It was read but not edited, in
accordance with the prover write permissions and the project rule that
`\leanok` is synchronized automatically.

## Physical model extracted

- **Named state quantities:** absolute temperature (`Temperature`),
  magnetic-field strength and magnetization
  (`DimMagneticIntensity`), plus the four figure state labels
  `1`, `2`, `3`, and `4`.
- **Fixed torus quantities:** volume (`DimVolume`), amount in moles, Curie
  constant in kelvin-cubic-metres per mole, and vacuum permeability
  (`DimVacuumPermeability`).
- **Heat quantities:** `Q_h`, `Q_c`, and signed heat entering the torus all use
  Physlib's dimensionful `DimEnergy`; `HeatTransfer` separately records no
  transfer, absorption from the cold reservoir, or delivery to the hot
  reservoir.
- **Named SI projections:** `siValue`, `temperatureValue`, and
  `heatInJoules` expose real coordinates only where the scalar physical laws
  require them.
- **Geometry/orientation:** `CycleLeg` fixes the directed cycle
  `1 → 2 → 3 → 4 → 1`; `CycleLeg.initial` and `.final` preserve the endpoint
  orientation.
- **Governing laws:** the paramagnetic equation of state
  `T M V = n K H`, the part-B isothermal heat formula, endpoint equilibrium at
  a contacted reservoir, reservoir-dependent heat direction, adiabatic
  isolation, and consistency between qualitative and signed heat.
- **Requested relation:** states `1,4` are at `T_h`, states `2,3` are at
  `T_c`, `Q_c` is absorbed on `2 → 3`, `Q_h` is delivered on `4 → 1`, and
  the two adiabatic legs have no heat transfer.

## Assumption/target split

### Governing laws

- `SatisfiesParamagneticEquationOfState` gives positivity of the relevant
  torus parameters and the statewise equation `T M V = n K H`.
- `SatisfiesIsothermalHeatRelation` gives positive vacuum permeability and
  the signed field-strength heat equation on every isothermal leg.
- `SatisfiesCarnotRefrigeratorLaws` gives positive and strictly ordered
  reservoir temperatures, nonnegative heat magnitudes, contact/isotherm
  compatibility, adiabatic isolation, endpoint equilibrium, reservoir-specific
  heat direction, and the signed-heat interpretation.

### Previous-part results

- The reusable result from part B is represented by
  `SatisfiesIsothermalHeatRelation`. It is retained as a premise of the main
  contract for source fidelity, although the qualitative C.1 derivation does
  not need its numerical equation.

### Figure/data readouts

- `Figure3bGeometry.one_to_two_adiabatic`
- `Figure3bGeometry.two_to_three_isothermal`
- `Figure3bGeometry.three_to_four_adiabatic`
- `Figure3bGeometry.four_to_one_isothermal`
- `Figure3bGeometry.state_two_colder_than_state_one`

The figure interface does not assign either isotherm to a named reservoir and
does not state any requested endpoint-temperature equality.

### Current target conclusions

- Auxiliary target: `2 → 3` contacts `.cold` and `4 → 1` contacts `.hot`.
- Main target: state `1` and state `4` equal `T_h`; state `2` and state `3`
  equal `T_c`; the two stated heat processes have their requested directions;
  and both adiabatic legs have transfer `.none`.

## Goal-faithfulness audit

No current conclusion is a premise. In particular:

- `isothermal_has_reservoir_contact` supplies only an existential reservoir,
  not the cold/hot assignment requested by C.1.
- `endpoint_temperatures_at_reservoir` and
  `heat_transfer_at_reservoir` are conditional governing laws; they become
  useful only after the reservoir contact has been derived.
- `Figure3bGeometry` contains only process classifications and the strict
  ordering `T₂ < T₁`.
- `Figure3bCarnotCycle.reservoirTemperature` merely selects the stored
  reservoir temperature for an already chosen `Reservoir`; it does not equate
  any cycle state with that temperature.
- Neither theorem conclusion is made true by unfolding a local definition.

Thus an arbitrary or swapped contact assignment cannot satisfy all the
ordering and endpoint-equilibrium assumptions, and the main answer remains on
the conclusion side of the theorem.

## Derivability and bridge obligations

1. **Existence of contacts on the two isotherms — covered.**
   Source claim: every isothermal process contacts a reservoir.
   Lean carriers:
   `Figure3bGeometry.two_to_three_isothermal`,
   `Figure3bGeometry.four_to_one_isothermal`, and
   `SatisfiesCarnotRefrigeratorLaws.isothermal_has_reservoir_contact`.
   Evidence: the law produces an explicit `Reservoir` witness for each of the
   two figure-classified isothermal legs.

2. **The two isotherms cannot contact the same reservoir — covered.**
   Source claim: same-reservoir contact would force `T₂ = T₁`.
   Lean carriers:
   `Reservoir` (the finite two-constructor branch type),
   `endpoint_temperatures_at_reservoir`, and
   `Figure3bGeometry.state_two_colder_than_state_one`.
   Evidence: endpoint equilibrium gives both endpoint equalities, while the
   strict real inequality rules out equality.

3. **The swapped hot/cold assignment is impossible — covered.**
   Source claim: assigning `2 → 3` to hot and `4 → 1` to cold would imply
   `T_h < T_c`, contrary to refrigerator ordering.
   Lean carriers:
   `Figure3bCarnotCycle.reservoirTemperature`,
   `endpoint_temperatures_at_reservoir`,
   `Figure3bGeometry.state_two_colder_than_state_one`, and
   `SatisfiesCarnotRefrigeratorLaws.cold_below_hot`.
   Evidence: these expose all required equalities and both opposing strict
   inequalities.

4. **Identification of the only remaining contact branches — covered.**
   Source claim: `2 → 3` is cold and `4 → 1` is hot.
   Lean carrier:
   `identify_isothermal_reservoir_contacts`
   (`lem:physics:IPhO_2026_3_C_1:aux022`).
   Evidence: the theorem contract is the direct formal counterpart of the
   source bridge. Its proof body is intentionally the first of the two open
   autoformalization obligations.

5. **Reservoir contacts give the four temperature labels — covered.**
   Source claim: contacted endpoints equilibrate with their reservoir.
   Lean carriers:
   `identify_isothermal_reservoir_contacts`,
   `endpoint_temperatures_at_reservoir`, the explicit
   `CycleLeg.initial`/`.final` maps, and `reservoirTemperature`.
   Evidence: specializing the endpoint law to the two derived contacts yields
   exactly the four requested equalities.

6. **Reservoir contacts give the two directed heat processes — covered.**
   Source claim: the torus absorbs `Q_c` at the cold contact and delivers
   `Q_h` at the hot contact.
   Lean carriers:
   `identify_isothermal_reservoir_contacts` and
   `SatisfiesCarnotRefrigeratorLaws.heat_transfer_at_reservoir`.
   Evidence: the reservoir match in the law reduces to the corresponding
   `HeatTransfer` constructor and stored magnitude.

7. **The adiabatic legs have no transfer — covered.**
   Source claim: `1 → 2` and `3 → 4` are isolated and carry no heat.
   Lean carriers:
   the two adiabatic fields of `Figure3bGeometry`,
   `adiabatic_has_no_reservoir_contact`, and
   `no_reservoir_contact_has_no_heat_transfer`.
   Evidence: these form the explicit process-kind → no-contact → no-transfer
   elimination chain.

8. **Assembly of all C.1 outputs — covered.**
   Source claim: the labels and heat processes form one combined answer.
   Lean carrier:
   `identify_temperature_labels_and_heat_processes`
   (`thm:physics:IPhO_2026_3_C_1:target`).
   Evidence: the theorem conclusion contains every qualitative source output;
   its proof body is intentionally the second open autoformalization
   obligation.

9. **Dimensionful quantities to scalar law coordinates — covered.**
   Source claim: the equations are numerical SI relations while the physical
   quantities retain their dimensions.
   Lean carriers: `siValue`, `temperatureValue`, and `heatInJoules`, grounded
   respectively in `Dimensionful`/`WithDim`/`UnitChoices.SI`,
   `Temperature.toReal`, and `DimEnergy`.
   Evidence: each projection has an explicit physical-role name and result
   type `ℝ`; no dimensionful primitive is collapsed to a scalar alias.

There are no blocked physics derivability bridges in the theorem contracts.
The two theorem proofs remain deliberately open because this stage is
autoformalization, not proving.

## Abstraction sufficiency and countermodel audit

The local `Prop`-valued interfaces are constraining as follows:

- `Figure3bGeometry`: exposes four exact process-kind equations and the strict
  scalar inequality `T₂ < T₁`. A countermodel cannot freely relabel the two
  isotherms or erase the temperature ordering.
- `SatisfiesParamagneticEquationOfState`: exposes three positivity
  inequalities and a `∀ point` scalar equation `T M V = n K H`. It is a
  genuine statewise physical law, not an opaque satisfiability predicate.
- `SatisfiesIsothermalHeatRelation`: exposes a positivity inequality and a
  `∀ leg` equation for signed heat under an isothermal premise. It constrains
  every isothermal leg rather than merely claiming a witness exists.
- `SatisfiesCarnotRefrigeratorLaws`: exposes strict reservoir ordering,
  magnitude inequalities, contact/isotherm implications, an existential with
  a concrete contact equation, endpoint-temperature equations,
  reservoir-indexed heat-transfer equations, and signed-heat equations for
  every `HeatTransfer` branch.

Countermodel sanity check: arbitrary contacts are ruled out by the combination
of finite `Reservoir` branching, endpoint equilibrium, `T₂ < T₁`, and
`T_c < T_h`; arbitrary qualitative heat labels are ruled out by
`heat_transfer_at_reservoir`; arbitrary heat on adiabatic legs is ruled out by
the two-step isolation law. Therefore the current target cannot be falsified
while interpreting the substantive local interfaces arbitrarily.

## Uncertainty and branch coverage

- **Uncertainty: not applicable.** The source states no measured
  `value ± uncertainty`, error bars, intervals, or tolerances for C.1.
- **Cycle orientation: covered.** The four `CycleLeg` constructors and their
  initial/final maps encode the exact incoming/outgoing direction
  `1 → 2 → 3 → 4 → 1`.
- **Reservoir branch: covered.** `Reservoir` has exactly `.cold` and `.hot`,
  and the strict temperature ordering is available to select the physically
  correct assignment rather than assuming it.
- **Heat direction/sign: covered.** `HeatTransfer` distinguishes absorption
  from delivery, and `signed_heat_agrees_with_transfer` records positive heat
  into the torus and negative heat rejected to the hot reservoir.

## Declarations and blueprint labels

- `aux001` — `DimVolume`
- `aux002` — `DimMagneticIntensity`
- `aux003` — `DimVacuumPermeability`
- `aux004` — `siValue`
- `aux005` — `temperatureValue`
- `aux006` — `heatInJoules`
- `aux007` — `CyclePoint`
- `aux008` — `CycleLeg`
- `aux009` — `CycleLeg.initial`
- `aux010` — `CycleLeg.final`
- `aux011` — `ProcessKind`
- `aux012` — `Reservoir`
- `aux013` — `HeatTransfer`
- `aux014` — `TorusState`
- `aux015` — `ParamagneticTorus`
- `aux016` — `Figure3bCarnotCycle`
- `aux017` — `Figure3bCarnotCycle.reservoirTemperature`
- `aux018` — `Figure3bGeometry`
- `aux019` — `SatisfiesParamagneticEquationOfState`
- `aux020` — `SatisfiesIsothermalHeatRelation`
- `aux021` — `SatisfiesCarnotRefrigeratorLaws`
- `aux022` — `identify_isothermal_reservoir_contacts`
- `target` — `identify_temperature_labels_and_heat_processes`

All declaration statements elaborate and are ready for the project's
deterministic statement-level `\leanok` synchronization. The two theorem proof
blocks are not proof-closed.

## LeanExplore queries and candidates actually used

Queries were run with package filters `["Mathlib", "Physlib"]`:

- `absolute temperature physical quantity SI units`
  - used: `Temperature`, `UnitChoices.SI`
- `WithDim physical dimensions quantity SI value`
  - used: `WithDim`, `UnitChoices.SI`
- `Temperature.toReal`
  - used: `Temperature.toReal`
- `Dimensionful WithDim DimEnergy`
  - used: `Dimensionful`, `WithDim`
- `Real inequality not equal of strict less-than`
  - future proof-relevant candidate: `ne_of_lt`; no proof code was changed in
    this iteration.

Source/module details fetched and checked:

- `Temperature.toReal`:
  `Physlib.Thermodynamics.Temperature.Basic`; converts `Temperature` to `ℝ`.
- `Dimensionful`:
  `Physlib.Units.Basic`; the subtype of unit-choice functions satisfying the
  dimension law.
- `WithDim`:
  `Physlib.Units.WithDim.Basic`; a dimension-tagged type with underlying
  `.val`.
- `UnitChoices.SI`:
  `Physlib.Units.Basic`; the SI choices metres, seconds, kilograms, coulombs,
  and kelvin.

## Physlib/Mathlib names grounded

- Physlib: `Temperature`, `Temperature.toReal`, `Dimensionful`, `WithDim`,
  `Dimension`, `UnitChoices.SI`, `DimEnergy`, and the dimension symbols
  `L𝓭`, `C𝓭`, `T𝓭`, `M𝓭`.
- Mathlib: `ℝ`, its ordered-field operations and powers, `Option`, and the
  inductive/structure infrastructure used by the contract. The direct
  `import Mathlib` requested by the iteration objective is now present.

## Local abstractions introduced and retained

No new physical abstraction was introduced in iteration 009. The existing
faithful local model was retained unchanged:

- `DimVolume`, `DimMagneticIntensity`, and `DimVacuumPermeability` specialize
  Physlib's dimension system instead of replacing physical quantities by bare
  reals.
- `CyclePoint`, `CycleLeg`, `ProcessKind`, `Reservoir`, and `HeatTransfer`
  preserve figure labels, orientation, process class, reservoir branch, and
  heat direction.
- `TorusState`, `ParamagneticTorus`, and `Figure3bCarnotCycle` gather the
  typed state/material/cycle data without asserting the answer.
- The four `Prop` interfaces listed in the countermodel audit expose the
  equations and inequalities required to derive the target.
- Physlib currently lacks an amount-of-substance base dimension in this model,
  so amount and the Curie constant remain explicitly named coherent-SI scalar
  readouts. This is a documented projection compromise, not a collapse of
  volume, field strength, magnetization, permeability, temperature, or heat.

## Grounding gaps and redraft requests

- **Physics/library grounding:** no unresolved gap. The retained local
  abstractions expose all mathematical consequences needed by the C.1
  derivation.
- **DAG navigation:** the prompt states that `archon` is on `PATH`, but
  invoking `archon dag-query ...` returns `command not found`. The blueprint
  itself supplies the exact dependency list, so this did not block the
  formalization audit.
- **Lake target registration:** the requested dotted module is not registered
  as a Lake target. If target-level `lake build
  IPhO2026Problems.problem_IPhO_2026_3_C_1` is mandatory for later automation,
  the project configuration must register `IPhO2026Problems` as a library
  root or the automation must validate the file with `lake env lean`. No
  configuration edit was made because this lane may edit only the assigned
  Lean file and this report.

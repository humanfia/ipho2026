# Autoformalization result: IPhO 2026 Problem 4 A.1

## Assumption/target split

### Governing laws

- Figure 18's total inner-cylinder height is partitioned into the confined-air
  height and propylene-glycol height.
- The inner bore diameter is twice its radius, and the physical confined-air
  volume obeys the cylinder relation `V = π r² H`.
- The confined-air mass obeys `m = ρ V`.
- The confined-air state obeys the supplied ideal-gas equation
  `P V = n R T`.
- Mass and amount obey the primitive molar-mass relation `m = Mₐ n`.
- Molecular population and amount obey the primitive Avogadro relation
  `N = Nₐ n`.
- `PhysicalAdmissibility` supplies positivity of the geometric,
  thermodynamic, molar-mass, and Avogadro readouts needed to solve these
  relations.

### Previous-part results

- None. A.1 has no previous-part dependency.

### Figure/data readouts

- Figure 17 supplies the inner-cylinder bore diameter
  `33.7 mm = 0.0337 m`.
- Figure 18/the official solution supplies the confined-air height
  `9.5 cm = 0.095 m`; the procedure supplies the propylene-glycol height
  `4.5 cm = 0.045 m`.
- The procedure supplies ambient air density `1.12 kg/m³`.
- The reference data supply air molar mass
  `28.96 g/mol = 0.02896 kg/mol` and Avogadro's constant
  `6.02 · 10²³ mol⁻¹`.
- `ExperimentalConditions` records introduction of propylene glycol, closure
  of valves D and E, sealing and fixed volume of CA, and the water-bath
  apparatus state.
- The molar mass and Avogadro constant are not bare setup scalars: each is a
  separate abstract physical type in `SubstanceCountingModel` with an
  explicitly unit-named scalar readout.

### Current target conclusions

- The stored physical volume equals
  `π (d / 2)² H`.
- The mass equals ambient density times that diameter-based volume.
- The amount in moles equals the mass divided by the air molar mass.
- The molecule count equals the amount in moles times Avogadro's constant.
- Mass lies in the corrected `0.094 ± 0.002 g` interval, amount lies in the
  reported `3.24 ± 0.7 mmol` interval, and molecule count lies in the
  reported `(1.95 ± 0.05) · 10²¹` interval.

## Goal-faithfulness audit

The requested substituted formulas and all three numerical interval claims
occur only in the conclusion of `determineConfinedAirInventory`.
`SourceReadouts` contains only independently supplied central readouts, and
`ExperimentalConditions` contains only apparatus propositions.

`GoverningLaws` deliberately does not contain the theorem's diameter-based or
fully substituted formulas. It relates diameter to an independently stored
radius, states cylinder volume using that radius and the physical stored
volume, and states the primitive density, molar-mass, and Avogadro relations.
Consequently the target must still eliminate radius, substitute physical
volume, divide by the positive molar mass, commute the Avogadro product, and
perform the numerical estimates. In particular, `MatchesOfficialSample` is
never assumed: it is only a named conclusion predicate, and unfolding it
exposes three nontrivial absolute-value inequalities rather than proving them.
No current answer is stored in a setup field or made true by a naming
definition.

## Declarations created and blueprint labels

- `Length`, `Volume`, `Mass`, `MassDensity`, `AbsoluteTemperature`, `Pressure`,
  and `siValue` correspond to their same-named
  `decl:physics:IPhO_2026_4_A_1:*` environments.
- `SubstanceCountingModel` —
  `decl:physics:IPhO_2026_4_A_1:SubstanceCountingModel`.
- `ConfinedAirState` —
  `decl:physics:IPhO_2026_4_A_1:ConfinedAirState`.
- `Figure17Geometry` —
  `decl:physics:IPhO_2026_4_A_1:Figure17Geometry`.
- `IsochoricAirSetup` —
  `decl:physics:IPhO_2026_4_A_1:IsochoricAirSetup`.
- `cylindricalAirVolumeSI` —
  `decl:physics:IPhO_2026_4_A_1:cylindricalAirVolumeSI`.
- `GoverningLaws`, `SourceReadouts`, `ExperimentalConditions`, and
  `PhysicalAdmissibility` correspond to their same-named
  `decl:physics:IPhO_2026_4_A_1:*` environments.
- `ScalarEstimate`, `officialMassEstimateKilograms`,
  `officialAmountEstimateMoles`, `officialMoleculeCountEstimate`,
  `WithinEstimate`, and `MatchesOfficialSample` correspond to their
  same-named `decl:physics:IPhO_2026_4_A_1:*` environments.
- `determineConfinedAirInventory` —
  `thm:physics:IPhO_2026_4_A_1:target`.

All statement environments are ready for the project-managed `\leanok`
synchronization. The theorem proof intentionally remains `by sorry` as
required by the `physics-formalize` stage, so its proof environment is not
claimed complete. The blueprint was not edited because prover permissions
reserve it for project automation/review.

## LeanExplore queries/candidates actually used

- Natural-language query
  `dimensional physical quantity SI units Physlib Dimensionful WithDim`
  with packages `["Mathlib", "Physlib"]` found `Dimensionful`,
  `UnitChoices.SI`, `CarriesDimension.toDimensionful`, and `Dimension`.
- Natural-language query
  `thermodynamic pressure quantity Physlib DimPressure` found
  `DimPressure` and `DimPressure.pascal`.
- Natural-language query
  `amount of substance mole molar mass physical dimension Physlib` found no
  amount-of-substance or molar-mass dimension; the returned candidates were
  only the five-component `Dimension` API.
- Natural-language query `absolute value interval uncertainty real number`
  found general absolute-value declarations but no experiment-estimate
  predicate matching the source.
- Likely-name queries `DimLength`, `DimMass`, `DimVolume`, `DimTemperature`,
  and `MolarMass` confirmed that Physlib has no matching scalar aliases for
  most of these roles. `DimTemperature` returned Physlib's `Temperature` as a
  near match.
- Source, module, and docstring were fetched for `Dimensionful`
  (`Physlib.Units.Basic`), `UnitChoices.SI` (`Physlib.Units.Basic`), and
  `DimPressure` (`Physlib.Units.WithDim.Pressure`). Source, module, and
  docstring were also fetched for the near-match `Temperature`
  (`Physlib.Thermodynamics.Temperature.Basic`).
- The generated preflight grounding report was checked as well. Its relevant
  near matches were `FluidDynamics.MassDensity`, `Temperature`,
  `DimPressure`, and `UnitChoices.SI`.

## PhysLean/Mathlib names grounded

- Physlib/PhysLean: `Dimensionful`, `WithDim`, `Dimension`, `L𝓭`, `M𝓭`,
  `T𝓭`, `Θ𝓭`, `UnitChoices.SI`, and `DimPressure`.
- Mathlib: `Real.pi`, real absolute-value notation, powers, division,
  inequalities, and real-number arithmetic.
- Imports actually used: explicit `Mathlib` and
  `Physlib.Units.WithDim.Pressure`.

## Local abstractions introduced

- `Length`, `Volume`, `Mass`, `MassDensity`, and `AbsoluteTemperature` use
  `Dimensionful (WithDim ... ℝ)`, so physical roles are not collapsed to
  transparent scalar aliases. `Pressure` reuses Physlib's `DimPressure`.
- `SubstanceCountingModel` is the minimal missing amount-dimension interface:
  it keeps amount, molecular population, molar mass, and the Avogadro quantity
  as distinct abstract types and exposes only the unit-specific observations
  needed by the statement.
- `Figure17Geometry` retains both bore diameter and radius, the inner/outer
  cylinder labels, the independent `H` and `h` lengths, and physical volume.
  This permits the target diameter formula to be derived from more primitive
  geometric relations rather than assumed.
- `ConfinedAirState` and `IsochoricAirSetup` preserve the physical state,
  inventory, constants, and labelled experimental apparatus.
- `GoverningLaws`, `SourceReadouts`, `ExperimentalConditions`, and
  `PhysicalAdmissibility` separate laws, observations, procedure, and physical
  domains rather than bundling the desired answer into one premise.
- `ScalarEstimate`, `WithinEstimate`, and `MatchesOfficialSample` make the
  numerical result an explicit uncertainty contract on the conclusion side.

Physlib's `Temperature` near match wraps a nonnegative scalar in an arbitrary
temperature unit system, whereas this file needs a coherent SI projection
alongside all other dimensionful readouts. The dimension-tagged local
`AbsoluteTemperature` is therefore retained. `FluidDynamics.MassDensity` is a
spatial field, not the scalar ambient density needed here.

## Grounding gaps

- Physlib's current dimension basis has no amount-of-substance component.
  Therefore no library type can directly express molar mass or inverse moles;
  `SubstanceCountingModel` supplies faithful abstract types and explicit
  kg/mol and mol⁻¹ projections.
- No Mathlib/Physlib experimental uncertainty object matched the three
  symmetric scalar estimates, so the small local `ScalarEstimate` and
  `WithinEstimate` abstractions were retained.
- The `archon dag-query` executable advertised by the task was not available
  on this prover process's `PATH`. There are no previous-part dependencies for
  A.1, and the blueprint fully specifies the target.
- No blueprint redraft is requested.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`: exit code
  `0`, with exactly the expected `sorry` warning.

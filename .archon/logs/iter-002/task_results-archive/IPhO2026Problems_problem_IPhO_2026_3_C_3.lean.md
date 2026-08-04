# Autoformalization result

## Assumption/target split

### Governing laws

- `GoverningLaws.stateOneAtHotReservoir` through
  `stateFourAtHotReservoir` encode the two isothermal levels of Figure 3b:
  states 1 and 4 are at `T_h`, while states 2 and 3 are at `T_c`.
- `GoverningLaws.coldReservoirInitiallyIsHelium` identifies the initial helium
  sample as the cold reservoir for this cycle.
- `GoverningLaws.torusMassDensityRelation` is the material relation
  `density * volume = amount * molar mass`.
- `GoverningLaws.equationOfState` records `T M V = n K H` at every labelled
  state.
- `GoverningLaws.heliumCalorimetry` records energy conservation
  `Q_c = rho V c (T_initial - T_final)` for the constant-density,
  constant-specific-heat helium sample.
- The remaining `GoverningLaws` fields state the physical positivity and
  nonnegativity conditions for temperatures, magnetization magnitudes, and
  heat magnitudes.

### Previous-part results

- `PreviousPartResults.coldIsothermalHeat` restates the B.1 isothermal heat
  formula on the cold leg `2 -> 3`.
- `PreviousPartResults.hotIsothermalHeat` applies the same B.1 formula to the
  magnitude `Q_h` delivered on the hot leg `4 -> 1`.
- `PreviousPartResults.magnetizationOne` restates the C.2 nonnegative
  magnetization-magnitude result
  `M_1 = sqrt (M_2^2 - M_3^2 + M_4^2)`.
- These results are restated locally; no Lean output from the previous parts
  is imported, in accordance with the chapter's dependency policy.

### Figure/data readouts

- `CarnotState` and `CarnotState.next` preserve the labelled order
  `1 -> 2 -> 3 -> 4 -> 1`.
- `Setup.cycleTemperature`, `magneticFieldStrength`, and `magnetization`
  represent the `H`-versus-`T` figure coordinates and state quantities.
- `HasSuppliedData` records the official readouts: 2 mol potassium chromate;
  `K = 1.87e-6 K m^3/mol`; density `2730 kg/m^3`; molar mass `0.19 kg/mol`;
  `H_1 = 411624`, `H_2 = 311306`, `H_3 = 204618`, and `H_4 = 240446 A/m`;
  1.00 L helium initially at 1.00 K; helium
  `c = 100 J/(kg K)` and `rho = 130 kg/m^3`; and
  `mu_0 = 4 pi * 1e-7 N/A^2`.

### Current target conclusions

`helium_temperature_after_one_cycle` concludes all three reported numerical
outputs, using explicit tolerances suitable for the rounded source data:

- `Q_c` is within `0.0005 J` of `0.129 J`;
- `T_initial - T_final` is within `0.00005 K` of `0.00992 K`;
- `T_final` is within `0.00005 K` of `0.99008 K`.

## Goal-faithfulness audit

The target values `0.129`, `0.00992`, and `0.99008` occur only in the conclusion
of `helium_temperature_after_one_cycle`.  They do not occur in `Setup`,
`HasSuppliedData`, `GoverningLaws`, `PreviousPartResults`, or a local definition.
In particular, `heliumCalorimetry` contains the final temperature only as an
unknown in the governing energy-balance law, and `coldIsothermalHeat` contains
the unknown heat magnitude only as the result of the licensed B.1 physical law.
Neither premise evaluates those unknowns to a current-answer value.  No target
relation is made true by unfolding.

The numerical statements are inequalities rather than artificial exact
equalities because both the official inputs and recorded outputs are decimal
measurements/rounded values.  The tolerances contain the value obtained from the
exact formal model with `mu_0 = 4 pi * 1e-7`.

## Declarations created and blueprint correspondence

- `CarnotState`, `CarnotState.next`: Figure 3b labels and cycle orientation.
- `Temperature`, `Volume`, `MassDensity`, `SpecificHeatCapacity`,
  `MagneticFieldStrength`, `Magnetization`, `Energy`, and
  `MagneticPermeability`: dimension-indexed physical quantity types.
- `Setup`: torus, reservoir, cycle-state, heat, and helium quantities.
- `HasSuppliedData`: official potassium-chromate, field, and liquid-helium
  readouts.
- `GoverningLaws`: the equation of state, figure temperature labels,
  material-volume relation, calorimetry, and positivity conditions.
- `PreviousPartResults`: the permitted B.1 and C.2 results.
- `IPhO2026Problems.IPhO2026_3_C_3.helium_temperature_after_one_cycle`
  corresponds to `thm:physics:IPhO_2026_3_C_3:target`.

The target statement compiles with its required `by sorry` body and is ready
for statement `\leanok` handling by the deterministic sync.  The blueprint
currently has no `\lean{...}` declaration name; the plan/review layer should
attach
`\lean{IPhO2026Problems.IPhO2026_3_C_3.helium_temperature_after_one_cycle}`.

## LeanExplore queries/candidates actually used

- Query `physical dimensional quantities SI units temperature heat energy
  volume density specific heat capacity molar mass magnetic field strength
  magnetization amount of substance` found `UnitChoices.SI`, `Dimension`,
  `Dimensionful`, `IsDimensionallyCorrect`,
  `Electromagnetism.MagneticField`, and
  `CanonicalEnsemble.heatCapacity`.
- Query `PhysLean units temperature energy heat capacity density volume
  magnetic field` confirmed the PhysLean units API, `TemperatureUnit`, and the
  two near-miss physics declarations above.
- Query `Real.sqrt nonnegative square root` found `Real.sqrt` and its standard
  nonnegativity/square-root lemmas.
- Query `WithDim Dimension.Ld Dimension.Td Dimension.Md Dimension.Cd
  Dimension.Thetad` (entered with the actual Unicode declaration characters)
  found `WithDim`, `Dimension.L𝓭`, `Dimension.T𝓭`, and `Dimension.C𝓭`.
- Query `Real.pi mathematical constant` found `Real.pi`.
- Query `temperature absolute nonnegative PhysLean Temperature` found
  `Temperature` and `Temperature.ofNNReal`.

Source and module details were fetched for `UnitChoices.SI`, `Dimension`,
`Dimensionful`, `IsDimensionallyCorrect`, `TemperatureUnit`,
`Electromagnetism.MagneticField`, `CanonicalEnsemble.heatCapacity`, `WithDim`,
`Dimension.L𝓭`, `Dimension.T𝓭`, `Dimension.C𝓭`, `Real.pi`, and
`Temperature`.

## PhysLean/Mathlib names grounded

- PhysLean/Physlib: `Dimension`, `WithDim`, `Dimension.L𝓭`,
  `Dimension.T𝓭`, `Dimension.M𝓭`, `Dimension.C𝓭`, and `Dimension.Θ𝓭`.
- Mathlib: `Real.pi` and `Real.sqrt`.
- Import actually used: `Physlib.Units.WithDim.Basic`.

## Local abstractions introduced

- The eight physical quantity aliases are not scalar aliases: each is a
  `WithDim` type indexed by its genuine combination of PhysLean base
  dimensions.  Their `.val` projections are explicitly fixed-SI readouts.
- `CarnotState` is the smallest discrete abstraction preserving the four
  figure labels and their directed order.
- `Setup`, `HasSuppliedData`, `GoverningLaws`, and `PreviousPartResults`
  separate physical objects, measurements, governing laws, and reusable
  prior conclusions.  This prevents data from being confused with the
  current target.
- Amount of substance, molar mass, and molar Curie constant use explicitly
  unit-named real readouts.  This preserves their mole-based physical roles
  without inventing a false PhysLean dimension.

## Grounding gaps

- PhysLean's `Dimension` has foundational components for length, time, mass,
  charge, and temperature, but no amount-of-substance component.  Therefore no
  dimensionally honest packaged mole, molar-mass, or molar-Curie-constant type
  was available.
- `Electromagnetism.MagneticField` is a spacetime-dependent vector magnetic
  field, whereas the problem supplies four scalar `H` field-strength
  readouts.  It is not a compatible replacement.
- `CanonicalEnsemble.heatCapacity` is a derivative in a statistical canonical
  ensemble, not the supplied macroscopic specific heat capacity of liquid
  helium.
- PhysLean's packaged `Temperature` wraps a nonnegative scalar in an arbitrary
  fixed unit.  The formalization instead uses `WithDim Dimension.Θ𝓭 ℝ` so
  temperature participates in the same explicit dimensional framework as
  volume, density, field strength, and energy; physical nonnegativity is
  stated in `GoverningLaws`.
- The `archon dag-query` executable requested by the prompt was not present on
  `PATH`.  This did not block the task because the chapter explicitly requires
  natural-language-only reuse of B.1 and C.2, which is restated locally.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors; exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`: exit code 0
  with exactly the expected `sorry` warning.

# Autoformalization result: IPhO 2026 Problem 3 C.4

## Assumption/target split

### Governing laws

- `ObeysParamagneticEquationOfState` states the supplied torus equation
  `T M V = n K H` at each of the four Figure 3b states.
- `ObeysContinuousCarnotCoolingLaws` states, at every interior time:
  - positivity of the hot- and cold-side heat-flow magnitudes;
  - constant input-power balance
    `dQ_h/dt - dQ_c/dt = P`;
  - the official-source Carnot relation
    `(dQ_c/dt) / (dQ_h/dt) = T_c / T_h`, equivalent to
    `dQ_c/dQ_h = T_c/T_h`;
  - the constant-heat-capacity body balance
    `dT_c/dt = -(dQ_c/dt)/C_c`, represented by `HasDerivAt`.
- `HasPhysicalOperatingRange` states positivity of `C_c`, `P`, the final
  absolute temperature, and elapsed time; the inequalities
  `0 < T < T_0 < T_h`; the initial and final trajectory values; continuity on
  the closed operating interval; and that the trajectory remains between
  absolute zero and `T_h`.
- `h_sameUnits` and `h_sameHotReservoir` identify the cooling run with the
  chosen coherent units and hot reservoir of the represented torus cycle.

### Previous-part results

- No previous Lean output is imported or referenced, matching the source
  report's natural-language-only policy.
- The shortened blueprint mentions the part-B isothermal heat relation as
  reusable context, but it is not required for C.4. The current derivation
  instead uses the heat-increment ratio explicitly supplied in the official
  C.4 statement.

### Figure/data readouts

- `CyclePoint` names states 1, 2, 3, and 4.
- `refrigerationCycleOrder` records `1 → 2 → 3 → 4 → 1`.
- `FollowsFigureThreeB` records states 1 and 4 on the hot isotherm and states 2
  and 3 on the cold isotherm.
- `ParamagneticCarnotCycle` retains the coherent unit choice, torus volume,
  amount `n`, Curie constant `K`, state temperatures, magnetic fields `H`,
  magnetizations `M`, reservoir temperatures, and heat magnitudes `Q_h` and
  `Q_c`.
- `ContinuousCoolingRun` retains the constant heat capacity `C_c`, constant
  input power `P`, constant `T_h`, `T_0`, `T`, unknown elapsed time, the body
  temperature trajectory, and instantaneous hot/cold heat-flow magnitudes.
- The official page image
  `/root/proposal_for_physic/science-mango/ipho_2026_source/image/T3_page-4.png`
  was inspected because it contains the exact C.4 relation omitted from the
  shortened blueprint.

### Current target conclusion

- `IPhO2026_3_C_4_elapsedTime` concludes exactly
  `t = (C_c T_h / P) *
  (log (T_0 / T) - (T_0 - T) / T_h)` for the elapsed-time readout.

## Goal-faithfulness audit

The logarithmic elapsed-time expression occurs only in the conclusion of
`IPhO2026_3_C_4_elapsedTime`. It does not occur in either data structure,
`HasPhysicalOperatingRange`, `ObeysContinuousCarnotCoolingLaws`,
`FollowsFigureThreeB`, the equation-of-state predicate, or a helper
definition. In particular, `elapsedTime` remains an unknown readout constrained
only by trajectory endpoints and independent local physical laws. Deriving the
conclusion still requires solving the heat-rate algebra, obtaining the cooling
ODE, and integrating its logarithmic antiderivative. Closed-interval
continuity was included to rule out endpoint jumps that would otherwise make
the mathematical statement false; it does not encode any part of the requested
answer.

## Declarations created and blueprint correspondence

- Dimension declarations: `energyDimension`, `volumeDimension`,
  `magneticIntensityDimension`, `heatCapacityDimension`, `powerDimension`,
  and `molarCurieConstantDimension`.
- Dimensioned readout types: `EnergyReadout`, `VolumeReadout`,
  `MagneticIntensityReadout`, `HeatCapacityReadout`, `PowerReadout`, and
  `TimeReadout`.
- Physical and figure data: `AmountOfSubstanceReadout`, `CyclePoint`,
  `refrigerationCycleOrder`, and `ParamagneticCarnotCycle`.
- Context laws: `ObeysParamagneticEquationOfState` and
  `FollowsFigureThreeB`.
- Current experiment: `ContinuousCoolingRun`, `HasPhysicalOperatingRange`,
  and `ObeysContinuousCarnotCoolingLaws`.
- `IPhO2026Problems.IPhO2026_3_C_4.IPhO_2026_3_C_4_elapsedTime` corresponds to
  blueprint label `thm:physics:IPhO_2026_3_C_4:target`.

The target statement has its required autoformalization-stage `by sorry` body
and is ready for statement-level `\leanok` synchronization. The blueprint has
no `\lean{...}` declaration name; the plan/review layer should attach
`\lean{IPhO2026Problems.IPhO2026_3_C_4.IPhO_2026_3_C_4_elapsedTime}`. The
blueprint was not edited because prover permissions make it read-only and local
project rules delegate `\leanok` changes to deterministic synchronization.

## LeanExplore queries/candidates actually used

All searches used `packages: ["Mathlib", "Physlib"]`.

- `dimensioned physical quantities SI units temperature heat capacity power
  time` found and grounded `UnitChoices.SI`, `Dimension`,
  `CarriesDimension.toDimensionful`, and
  `CanonicalEnsemble.heatCapacity`.
- `Physlib Temperature physical quantity type Time Energy Power HeatCapacity`
  found and grounded `Temperature`, `DimEnergy`, `UnitChoices`, and
  `CanonicalEnsemble.heatCapacity`.
- `DimTime DimPower dimensionful time power quantities Physlib Units WithDim`
  found and grounded `WithDim`, `Dimensionful`, `Dimension.T𝓭`, `DimEnergy`,
  and the `WithDim` multiplication/division interface.
- `HasDerivAt differential equation temperature cooling logarithm Real.log
  derivative` found and grounded `Real.log`, `Real.hasDerivAt_log`, and
  related logarithmic derivative declarations.
- `HasDerivAt` found and grounded the core
  `Mathlib.Analysis.Calculus.Deriv.Basic.HasDerivAt` predicate.

Source text was fetched explicitly for `WithDim` and `Temperature`; the module
for `Real.log` was fetched explicitly. The full search results supplied source,
module, and docstring data for the other candidates assessed.

## PhysLean/Mathlib names grounded

- PhysLean/Physlib: `Temperature`, `UnitChoices`, `Dimension`,
  `Dimension.M𝓭`, `Dimension.L𝓭`, `Dimension.T𝓭`, `Dimension.C𝓭`,
  `Dimension.Θ𝓭`, `WithDim`, and `WithDim.val`.
- Mathlib: `HasDerivAt`, `ContinuousOn`, `Real.log`, `Set.Icc`, and `Set.Ioo`.
- Imports actually used:
  `Physlib.Thermodynamics.Temperature.Basic`,
  `Physlib.Units.WithDim.Basic`,
  `Mathlib.Analysis.Calculus.Deriv.Basic`, and
  `Mathlib.Analysis.SpecialFunctions.Log.Basic`.

## Local abstractions introduced

- The local dimension declarations compose Physlib's five base dimensions and
  tag every scalar readout through `WithDim`; heat capacity, power, energy,
  time, magnetic intensity, volume, and the Curie constant are therefore not
  collapsed to aliases of `ℝ`.
- `AmountOfSubstanceReadout` is an explicit molar measurement interface because
  Physlib's `Dimension` has no amount-of-substance coordinate.
- `ParamagneticCarnotCycle` and its two predicates preserve the torus,
  Figure 3b labels and isotherms, reservoir heat roles, and equation of state.
- `ContinuousCoolingRun` separates experimental data from
  `ObeysContinuousCarnotCoolingLaws`. The latter is the smallest local
  governing-law interface needed for the official heat-increment relation,
  power balance, and body heat balance.

## Grounding gaps and redraft requests

- No ready-made PhysLean types were found for heat capacity, power, elapsed
  time, scalar magnetic field strength/magnetization, or a paramagnetic Carnot
  refrigerator. Dimension-tagged local readouts preserve these roles.
- `CanonicalEnsemble.heatCapacity` is a derivative of mean energy for a
  canonical ensemble at constant volume; it does not represent the externally
  cooled body's given constant heat capacity.
- `DimEnergy` is a unit-independent `Dimensionful` quantity, while the problem
  presents mutually coherent scalar readouts in a chosen unit system. The
  lower-level `WithDim` API is used so the closed-form numerical relation can
  be stated without inventing unit-conversion equalities.
- Physlib's `Dimension` omits amount of substance, so the mole role of `n` and
  the per-mole role of `K` cannot both be encoded in its five-component
  dimension vector; the molar component is retained explicitly by names and
  `AmountOfSubstanceReadout`.
- No ready-made Carnot heat-ratio or continuous refrigerator law was found, so
  the exact official-source relations were stated locally.
- The advertised `archon dag-query` executable was unavailable on `PATH`
  (`archon: command not found`), so no dependency-graph result could be used.
- The assigned Lean file did not exist initially, so there was no file-specific
  `/- USER: ... -/` hint.
- The blueprint needs the `\lean{...}` name above for deterministic marker
  synchronization.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages` reported no errors and only
  the expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_4.lean` exited
  successfully with only the expected `sorry` warning.

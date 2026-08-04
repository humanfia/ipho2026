# Autoformalization result: IPhO 2026 Problem 3 C.4

## Status

- Created `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_4.lean` exits
  successfully.
- The only diagnostics are the two expected `declaration uses sorry` warnings
  on `instantaneous_cooling_power_equation` and `elapsed_time_formula`.
- No `/- USER: ... -/` comment existed because the assigned Lean file did not
  exist before this lane.
- The chapter contains `% archon:physics`, so the physics-formalize discipline
  was used.
- The official source-page image was inspected. It confirms the differential
  relation `dQ_c / dQ_h = T_c / T_h`, the initial condition at `t = 0`, the
  strict cooling condition `T < T₀`, and constancy of `C_c`, `P`, and `T_h`.

## Assumption/target split

### Governing laws

- `ParamagneticTorusContext.equationOfState` records the inherited torus law
  `T M V = n K H` at each labelled cycle state.
- `SatisfiesCarnotCoolingLaw.carnot_heat_ratio` records the source law
  `dQ_c / dQ_h = T_c / T_h` in terms of positive instantaneous heat-transfer
  rates.
- `SatisfiesCarnotCoolingLaw.body_heat_balance` records constant heat
  capacity through `dQ_c/dt = -C_c dT_c/dt`.
- `SatisfiesCarnotCoolingLaw.refrigerator_power_balance` records constant
  refrigerator work-input power through
  `P = dQ_h/dt - dQ_c/dt`.
- Differentiability and positivity fields make the differential laws and all
  heat/temperature ratios mathematically usable.

### Previous-part results

- The source report lists no previous parts for this lane, and no sibling Lean
  module is imported.
- The chapter's inherited paramagnetic-torus equation of state is restated
  locally as setup context.
- The earlier isothermal heat relation is not needed in the C.4 derivation and
  is therefore not installed as an unused assumption.

### Figure/data readouts

- `CarnotCycleState` retains labels `1`, `2`, `3`, and `4`.
- `CarnotCycleState.next` retains the oriented Figure 3b cycle
  `1 → 2 → 3 → 4 → 1`.
- `ParamagneticTorusContext` retains volume, amount of substance, Curie
  constant, temperature, magnetization, and magnetic field.
- `CarnotCoolingExperiment` retains the constant heat capacity `C_c`, input
  power `P`, hot-reservoir temperature `T_h`, initial temperature `T₀`, target
  temperature `T`, and elapsed time `t`, with the physical inequalities
  `0 < T < T₀ < T_h`, `C_c > 0`, `P > 0`, and `t ≥ 0`.
- `CarnotCoolingProcess` retains the time-dependent temperature and the
  magnitudes of the cold- and hot-side heat-transfer rates.

### Current target conclusions

- `instantaneous_cooling_power_equation` derives the intermediate ODE
  `P = C_c (T_h/T_c - 1) (-dT_c/dt)`.
- `elapsed_time_formula` concludes exactly
  `t = (C_c T_h/P) [log (T₀/T) - (T₀ - T)/T_h]`.

Neither conclusion occurs in any premise field.

## Goal-faithfulness audit

The current elapsed-time answer appears only in the conclusion of
`elapsed_time_formula`. It is not a hypothesis, a field of
`CarnotCoolingExperiment`, a field of `SatisfiesCarnotCoolingLaw`, or a local
definition. The final endpoint equation in `SatisfiesCarnotCoolingLaw` merely
says that the actual trajectory reaches the requested target temperature at
the elapsed time; it does not constrain that time by the requested closed
form.

The instantaneous cooling equation likewise appears only as a bridge-theorem
conclusion. The law interface contains the three lower-level source
relations—Carnot heat ratio, body heat balance, and refrigerator power
balance—from which that ODE must be eliminated algebraically.

No substantive result is true by unfolding a naming definition. The only
closed definitions are dimensional names and the figure's oriented successor
map.

## Derivability and bridge obligations

1. **Source claim:** the torus follows the cycle `1 → 2 → 3 → 4 → 1` and obeys
   `T M V = n K H`.
   **Lean carrier:** `CarnotCycleState.next` and
   `ParamagneticTorusContext.equationOfState`.
   **Evidence:** the orientation is an explicit finite map, and the equation
   of state is an explicit equality at every state.
   **Status:** covered (encoded locally).

2. **Source claim:** each Carnot cycle satisfies
   `dQ_c/dQ_h = T_c/T_h`.
   **Lean carrier:** `SatisfiesCarnotCoolingLaw.carnot_heat_ratio`.
   **Evidence:** both heat-transfer magnitudes are represented by
   power-dimensioned rates; positivity fields ensure the denominator is
   nonzero.
   **Status:** covered (direct source-to-contract mapping).

3. **Source claim:** constant body heat capacity gives
   `dQ_c/dt = -C_c dT_c/dt`.
   **Lean carrier:** `SatisfiesCarnotCoolingLaw.body_heat_balance`, with
   `temperatureReadout_differentiable`.
   **Evidence:** the field is a pointwise equation involving Mathlib `deriv`,
   not an opaque thermodynamic predicate.
   **Status:** covered (encoded locally).

4. **Source claim:** constant refrigerator input power is the difference
   between hot-side delivery and cold-side absorption rates.
   **Lean carrier:**
   `SatisfiesCarnotCoolingLaw.refrigerator_power_balance`.
   **Evidence:** the field directly states
   `hotHeatDeliveryRate - coldHeatAbsorptionRate = inputPower`.
   **Status:** covered (encoded locally).

5. **Source claim:** eliminating both heat rates yields
   `P = C_c (T_h/T_c - 1) (-dT_c/dt)`.
   **Lean carrier:** theorem `instantaneous_cooling_power_equation`, using the
   three law fields and their positivity consequences.
   **Evidence:** all divisions needed for field algebra have explicit positive
   denominators.
   **Status:** covered at the statement layer; proof intentionally deferred by
   `sorry` to the physics prover stage.

6. **Source claim:** integrating the instantaneous equation from time `0` to
   `t` and temperature `T₀` to `T` produces the logarithmic term.
   **Lean carrier:** Mathlib `Real.deriv_log` and the global differentiability,
   positivity, and endpoint fields in `SatisfiesCarnotCoolingLaw`.
   **Evidence:** the derivative of
   `T_h * log (temperature) - temperature` is exactly the factor multiplying
   the temperature derivative in the ODE.
   **Status:** covered at the contract/API layer; analytic proof intentionally
   deferred by `sorry`.

7. **Source claim:** the requested closed form is
   `(C_c T_h/P) [log(T₀/T) - (T₀-T)/T_h]`.
   **Lean carrier:** the complete contract of `elapsed_time_formula`.
   **Evidence:** the target has the exact source ordering, sign, logarithmic
   ratio, and correction term; `inputPower_pos` permits division by `P`.
   **Status:** covered (direct source-to-contract mapping).

No substantive source-to-Lean bridge is absent from the statement layer.

## Abstraction sufficiency and countermodel audit

- `SatisfiesCarnotCoolingLaw` is the only locally introduced `Prop`-valued
  interface. It is constraining through:
  - two endpoint equalities;
  - global differentiability of the temperature readout;
  - positive-temperature and below-hot-reservoir inequalities on the run;
  - positive cold- and hot-side heat-rate inequalities;
  - the exact Carnot heat-ratio equation;
  - the exact body heat-balance equation; and
  - the exact refrigerator power-balance equation.
- `ParamagneticTorusContext` is data-valued, but its physical-law fields expose
  positivity and the equation of state as directly reusable mathematical
  consequences.
- `CarnotCoolingExperiment` and `CarnotCoolingProcess` are data-valued rather
  than opaque propositions. Constancy is represented by fixed experiment
  parameters; the varying quantities are explicitly functions of time.

Countermodel check: if the three governing equations are interpreted
arbitrarily, their explicit equality fields still have to hold pointwise.
They algebraically force the instantaneous ODE. Differentiability,
temperature positivity, and the two endpoint equations then force its
integrated logarithmic relation. Thus a freely chosen elapsed time cannot
satisfy the entire interface while falsifying the target formula. Dropping
any one of the Carnot ratio, heat-capacity balance, or power balance would
permit such a countermodel; all three are present.

## Uncertainty and branch coverage

- **Uncertainty:** genuinely not applicable. The source gives no measured
  `value ± uncertainty`, tolerance, or experimental error.
- **Cooling branch:** covered by
  `finalTemperature_lt_initial`, positive temperature throughout the run,
  and the trajectory endpoint equalities.
- **Hot/cold orientation:** covered by
  `temperature_lt_hot_on_run`; `coldHeatAbsorptionRate` and
  `hotHeatDeliveryRate` are separate named positive magnitudes, so their signs
  cannot be exchanged only in the conclusion.
- **Cycle orientation:** covered by `CarnotCycleState.next`, which explicitly
  records `1 → 2 → 3 → 4 → 1`.
- **Logarithm branch:** covered by positive temperatures, so the ratio
  `T₀/T` lies in the positive real branch of `Real.log`.

## Declarations created and blueprint correspondence

All declarations are in namespace
`IPhO2026Problems.IPhO2026_3_C_4`.

- Dimensional model:
  `EnergyDimension`, `TemperatureQuantity`, `TimeQuantity`,
  `VolumeQuantity`, `MagneticFieldStrengthQuantity`,
  `HeatCapacityQuantity`, and `PowerQuantity`.
- Figure/setup model:
  `CarnotCycleState`, `CarnotCycleState.next`, and
  `ParamagneticTorusContext`.
- Cooling model:
  `CarnotCoolingExperiment`, `CarnotCoolingProcess`, and
  `SatisfiesCarnotCoolingLaw`.
- Bridge theorem:
  `IPhO2026Problems.IPhO2026_3_C_4.instantaneous_cooling_power_equation`.
- Main theorem:
  `IPhO2026Problems.IPhO2026_3_C_4.elapsed_time_formula`.

The main theorem corresponds to blueprint label
`thm:physics:IPhO_2026_3_C_4:target`. The chapter currently has no
`\lean{...}` annotation naming it. Per prover write permissions, the blueprint
was not edited; plan/review synchronization should attach
`\lean{IPhO2026Problems.IPhO2026_3_C_4.elapsed_time_formula}` before expecting
deterministic `\leanok` synchronization.

## LeanExplore queries/candidates actually used

All searches passed package filters `["Mathlib", "Physlib"]`.

- Query: `physical dimension quantity temperature power heat capacity time
  units`
  - Used `Dimension`, `Dimension.T𝓭`, and `Dimension.Θ𝓭`.
  - Inspected `CanonicalEnsemble.heatCapacity`, but it is a statistical-
    mechanics derivative rather than the finite body's constant heat-capacity
    quantity required here.
- Query: `PhysLean quantity with physical dimension value in unit system
  Quantity Dimensionful`
  - Used `WithDim` as the smallest grounded dimension-tagged quantity type.
  - Inspected `Dimensionful` and `CarriesDimension.toDimensionful`; the
    theorem contract instead consistently uses one fixed coherent readout
    convention.
- Query: `WithDim type physical units quantity Physlib.Units.WithDim`
  - Used `WithDim` from `Physlib.Units.WithDim.Basic`.
- Query: `Dimension temperature time energy power dimensions T𝓭 Θ𝓭 Physlib`
  - Used the five-component `Dimension` algebra and its `M𝓭`, `L𝓭`, `T𝓭`,
    `C𝓭`, and `Θ𝓭` base dimensions to compose energy, heat capacity, power,
    volume, and `A/m`.
  - Inspected `DimEnergy` to confirm Physlib's `M L² T⁻²` convention.
- Query: `Real.log logarithm division positive real identity derivative
  integral`
  - Used `Real.log` and `Real.deriv_log`.
- Query: `thermodynamic Carnot refrigerator coefficient of performance
  cooling power heat reservoir`
  - No ready-made Carnot refrigerator or coefficient-of-performance law was
    returned.

## PhysLean/Mathlib names grounded

- Physlib:
  `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`, `Dimension.M𝓭`,
  `Dimension.C𝓭`, `Dimension.Θ𝓭`, `WithDim`, `Dimensionful`, and
  `DimEnergy`.
- Mathlib:
  `Real.log`, `Real.deriv_log`, `deriv`, `Differentiable`, and `Set.Icc`.

The concrete source and module for `WithDim` were checked:
`Physlib.Units.WithDim.Basic`. The source/module for `Real.deriv_log` was
checked: `Mathlib.Analysis.SpecialFunctions.Log.Deriv`.

## Local abstractions introduced

- `EnergyDimension` and the quantity abbreviations compose standard Physlib
  base dimensions. They are aliases to Physlib `WithDim` quantities, not
  aliases to `ℝ` or ad hoc one-field physical wrappers.
- `CarnotCycleState` and its successor retain the four figure labels and
  cycle orientation.
- `ParamagneticTorusContext` retains the inherited torus, its equation of
  state, and the physical roles of its state variables.
- `CarnotCoolingExperiment` separates fixed physical data from the
  time-dependent process.
- `CarnotCoolingProcess` separates temperature, cold-side heat absorption,
  and hot-side heat delivery.
- `SatisfiesCarnotCoolingLaw` is the smallest local law interface found that
  exposes the exact equations needed to derive the answer without assuming
  the answer.

Real numbers are used only as readouts in a fixed coherent unit convention,
for time coordinates of those readouts, and for the amount-of-substance and
Curie-constant SI projections unsupported by Physlib's five-base-dimension
type.

## Grounding gaps

- No matching Mathlib/Physlib Carnot-refrigerator interface was found. The
  local law relation therefore exposes the exact source equations directly.
- Physlib's `Dimension` has components for length, time, mass, charge, and
  temperature, but not amount of substance. Consequently
  `amountOfSubstanceMoles` and `curieConstantSI` are explicitly named SI scalar
  readouts rather than falsely dimension-tagged quantities.
- The `archon dag-query` executable was unavailable on this lane's `PATH`, so
  the read-only dependency graph could not be queried. The source report lists
  no previous-part Lean dependencies, and no sibling module was imported.
- Blueprint redraft request: add
  `\lean{IPhO2026Problems.IPhO2026_3_C_4.elapsed_time_formula}` to the target
  theorem environment. The later deterministic synchronization phase, not
  this prover, should manage `\leanok`.

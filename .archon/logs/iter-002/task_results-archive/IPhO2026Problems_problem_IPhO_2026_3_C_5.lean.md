# Autoformalization result: IPhO 2026 Problem 3 C.5

The file `IPhO2026Problems/problem_IPhO_2026_3_C_5.lean` was created and
compiled successfully with the single expected warning for the main theorem's
`sorry`.

Verification command:

```text
lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_5.lean
```

Result: exit code 0; warning only at
`overall_coefficient_of_performance`.

## Assumption/target split

### Governing laws

- The paramagnetic equation of state is represented in SI readouts by
  `Figure3bCarnotLaws.equation_of_state`:
  `T * M * V = n * K * H` at each of the four labeled states.
- The reusable part-B isothermal heat law is represented by
  `IsothermalHeatRelation.equation`, including the sign convention that heat
  entering the torus is positive.
- Figure 3b's reservoir assignments are represented by
  `state_one_is_hot`, `state_four_is_hot`, `state_two_is_cold`, and
  `state_three_is_cold`.
- The directed heat-transfer branches are represented by
  `cold_heat_on_two_to_three` and `hot_heat_on_four_to_one`, with explicit
  magnitude/sign conventions.
- Constant heat capacity gives total removed heat through
  `ConstantPowerCoolingLaws.heat_removed_from_constant_heat_capacity`:
  `Q_c = C_c * (T_0 - T)`.
- Constant input power gives total work through
  `ConstantPowerCoolingLaws.work_from_constant_power`: `W = P * t`.
- Positivity, ordering, and endpoint hypotheses record
  `0 < T < T_0 < T_h`, positive heat capacity, positive power, positive
  duration, and agreement of the last cycle's cold reservoir with the body's
  final temperature.

### Previous-part results

- `C4ElapsedTimeResult.elapsed_time` is exactly the natural-language reusable
  C.4 conclusion
  `t = (C_c*T_h/P) * (log (T_0/T) - (T_0-T)/T_h)`.
- No sibling Lean file is imported or used.

### Figure/data readouts

- `CyclePoint`, `figure3bCycleOrder`, `coldHeatBranch`, and `hotHeatBranch`
  preserve labels `1,2,3,4`, the order `1 → 2 → 3 → 4 → 1`, and both
  oriented heat-transfer legs.
- `Figure3bCarnotCycle` records the hot and cold temperatures, `H`, `M`,
  `Q_c`, and `Q_h`.
- `ParamagneticTorus` records fixed volume, amount in moles, and the Curie
  constant readout with its stated SI role.
- `CoolingRun` distinguishes the per-cycle heat magnitudes from the total
  heat and total work accumulated through time `t`.

### Current target conclusions

- The only current target is
  `overall_coefficient_of_performance`, whose conclusion is
  `COP = (T_h/(T_0-T) * log(T_0/T) - 1)⁻¹`.
- `overallCoefficientOfPerformance` defines only the source quantity
  `COP = Q_c/W`; it does not define COP to be the requested closed form.

## Goal-faithfulness audit

- The requested closed-form COP occurs only in the conclusion of
  `overall_coefficient_of_performance`.
- No hypothesis, structure field, predicate, or local definition contains
  that closed-form result.
- The C.4 elapsed-time equation is legitimately on the premise side because
  the blueprint explicitly marks it as a reusable previous-part conclusion.
- The two equations `Q_c = C_c(T_0-T)` and `W = Pt` are governing
  constant-heat-capacity and constant-power relations, not reformulations of
  the current answer.
- The definition of `overallCoefficientOfPerformance` is the problem's stated
  definition `Q_c/W`; unfolding it does not prove the target without all
  three substantive bridge equations and algebra.

## Derivability and bridge obligations

1. **Dimensionful quantities to scalar equations**
   - Source claim: all displayed thermodynamic equations are read in a
     consistent unit system.
   - Carrier: `siValue`, evaluating Physlib `Dimensionful (WithDim d ℝ)` at
     `UnitChoices.SI`; temperatures use `Temperature.toReal`.
   - Evidence: grounded Physlib declarations and successful elaboration.
   - Status: **covered**.

2. **Paramagnetic equation of state**
   - Source claim: `T*M*V = n*K*H`.
   - Carrier: `Figure3bCarnotLaws.equation_of_state`.
   - Evidence: an equation is exposed for every `CyclePoint`.
   - Status: **covered**.

3. **Reusable isothermal heat relation**
   - Source claim:
     `Q = -(μ₀*n*K/(2*T))*(H_f^2-H_i^2)` at fixed temperature.
   - Carrier: `IsothermalHeatRelation.equation`.
   - Evidence: the carrier requires equal endpoint temperatures and returns
     the exact scalar heat equation.
   - Status: **covered**.

4. **Total heat removed from the cooled body**
   - Source claim: constant body heat capacity integrates to
     `Q_c = C_c(T_0-T)`.
   - Carrier:
     `ConstantPowerCoolingLaws.heat_removed_from_constant_heat_capacity`.
   - Evidence: exact equality in SI readouts.
   - Status: **covered**.

5. **Total work up to time `t`**
   - Source claim: constant input power gives `W = Pt`.
   - Carrier: `ConstantPowerCoolingLaws.work_from_constant_power`.
   - Evidence: exact equality in SI readouts.
   - Status: **covered**.

6. **Elapsed time from C.4**
   - Source claim: the reusable C.4 logarithmic formula for `t`.
   - Carrier: `C4ElapsedTimeResult.elapsed_time`.
   - Evidence: exact source-to-contract mapping, with all five requested
     quantities retained.
   - Status: **covered**.

7. **Definition of overall COP**
   - Source claim: `COP = Q_c/W`.
   - Carrier: `overallCoefficientOfPerformance`.
   - Evidence: definition uses total, rather than single-cycle, heat and work.
   - Status: **covered**.

8. **Algebraic elimination of `Q_c`, `W`, `t`, `C_c`, and `P`**
   - Source claim: substituting the three relations above yields the recorded
     inverse expression.
   - Carrier: the contract of
     `overall_coefficient_of_performance`, together with the positivity and
     strict-temperature-order fields in `ConstantPowerCoolingLaws`.
   - Evidence: all denominators needed for the future field-algebra proof are
     constrained to be nonzero.
   - Status: **covered at statement level**; the proof body is intentionally
     deferred with `sorry` in this autoformalization stage.

## Abstraction sufficiency and countermodel audit

The local `Prop`-valued interfaces are:

- `IsothermalHeatRelation`: constrained by positivity of `μ₀` and an explicit
  elimination equation for every isothermal pair of endpoints. It is not an
  opaque witness predicate.
- `Figure3bCarnotLaws`: constrained by four temperature equalities, positivity
  and ordering inequalities, the equation of state at every point, two
  directed heat equations, and two magnitude inequalities.
- `ConstantPowerCoolingLaws`: constrained by positivity/order inequalities,
  a last-cycle endpoint equality, the total heat equation, and the total work
  equation.
- `C4ElapsedTimeResult`: constrained by the exact logarithmic elapsed-time
  equality from C.4.

Countermodel check: after fixing a `CoolingRun`, these interfaces cannot be
interpreted arbitrarily while changing `Q_c`, `W`, or `t`; their scalar
readouts are tied to `C_c`, `P`, and the three temperatures by explicit
equalities. Thus the conclusion is determined by ordinary real algebra.
The figure and material relations are separately constraining, even though
the final C.5 algebra does not need to eliminate their state variables.

## Uncertainty and branch coverage

- **Uncertainty: not applicable.** C.5 and its C.4 prerequisite state exact
  symbolic quantities and provide no `value ± uncertainty` data.
- **Branch/orientation: covered.** `figure3bCycleOrder` records
  `1 → 2 → 3 → 4 → 1`; `coldHeatBranch` is `2 → 3`; `hotHeatBranch` is
  `4 → 1`. `Figure3bCarnotLaws` links these branches to positive heat
  magnitudes while `IsothermalHeatRelation` retains the signed heat-entering
  convention.
- **Logarithm/temperature branch: covered.** Absolute temperatures are
  positive, the body cools strictly from `T_0` to `T`, and
  `T_0 < T_h`.

## Declarations created and blueprint labels

- `IPhO2026_3_C_5.overall_coefficient_of_performance`
  - Blueprint label: `thm:physics:IPhO_2026_3_C_5:target`.
- Supporting declarations for that label:
  `energyDimension`, `DimDuration`, `DimPower`, `DimHeatCapacity`,
  `DimVolume`, `DimAmperePerMeter`, `siValue`, `temperatureValue`,
  `CyclePoint`, `figure3bCycleOrder`, `coldHeatBranch`, `hotHeatBranch`,
  `ParamagneticTorus`, `Figure3bCarnotCycle`, `IsothermalHeatModel`,
  `IsothermalHeatRelation`, `Figure3bCarnotLaws`, `CoolingRun`,
  `ConstantPowerCoolingLaws`, `C4ElapsedTimeResult`, and
  `overallCoefficientOfPerformance`.

The theorem environment is ready for `\leanok` at the statement level. The
blueprint was not edited because `.archon/AGENTS.md` assigns blueprint marker
management to the deterministic sync/review phase. The chapter currently has
no `\lean{...}` declaration name; the semantic handoff is
`\lean{IPhO2026_3_C_5.overall_coefficient_of_performance}`.

## LeanExplore queries/candidates actually used

All searches used package filters `["Mathlib", "Physlib"]`.

- Query:
  `dimensionful thermodynamic temperature heat capacity energy power time physical units`
  - Used candidates: `Dimensionful`, `DimEnergy`,
    `CarriesDimension.toDimensionful`, `UnitChoices`.
- Query: `PhysLean Temperature Energy Power units`
  - Used candidates: `DimEnergy`, `Temperature`, `TemperatureUnit`.
- Query: `DimTemperature`
  - Used candidate: `Temperature`.
- Query: `DimPower physical dimension`
  - Used candidates: `Dimension`, `WithDim`.
- Query: `DimTime physical dimension`
  - Used candidates: `Dimension.T𝓭`, `WithDim`.
- Query: `DimHeatCapacity physical dimension`
  - Used candidates: `Dimension`, `WithDim`.
- Query: `Dimensionful SI unit value real`
  - Used candidates: `UnitChoices.SI`, `Dimensionful`,
    `WithDim.scaleUnit_val`.
- Query: `Real.log division positivity logarithm quotient`
  - Used candidates: `Real.log`, `Real.log_div`.

Source/module details were fetched for `Temperature`, `Dimensionful`,
`WithDim`, `DimEnergy`, `UnitChoices.SI`, and `WithDim.scaleUnit_val` before
the local declarations were written.

## PhysLean/Mathlib names grounded

- Physlib:
  - `Temperature`, `Temperature.toReal`
    (`Physlib.Thermodynamics.Temperature.Basic`)
  - `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`, `Dimension.M𝓭`,
    `Dimension.C𝓭`, `Dimension.Θ𝓭`
  - `Dimensionful`, `UnitChoices.SI`
    (`Physlib.Units.Basic`)
  - `WithDim` (`Physlib.Units.WithDim.Basic`)
  - `DimEnergy` (`Physlib.Units.WithDim.Energy`)
- Mathlib:
  - `Real.log`
    (`Mathlib.Analysis.SpecialFunctions.Log.Basic`)

## Local abstractions introduced

- The dimensional aliases for duration, power, heat capacity, volume, and
  ampere/metre are specializations of Physlib's dimension-aware
  `Dimensionful (WithDim d ℝ)`, not aliases to bare `ℝ`.
- `ParamagneticTorus` is a multi-field physical model. Amount of substance and
  Curie constant are explicitly named scalar SI readouts because the current
  Physlib `Dimension` basis has no mole component.
- `CyclePoint`, `Figure3bCarnotCycle`, `IsothermalHeatModel`, and
  `CoolingRun` preserve the state labels, branch orientation, sign convention,
  per-cycle quantities, and run totals.
- The four law/result structures expose reusable equations and inequalities;
  none is an unconstrained opaque predicate.

## Grounding gaps

- Physlib currently supplies `DimEnergy` but no ready aliases for power,
  duration, heat capacity, volume, or ampere/metre. These were faithfully
  constructed from `Dimensionful`, `WithDim`, and the base dimensions.
- Physlib's dimension basis has no amount-of-substance/mole coordinate.
  Molar amount and Curie-constant values therefore remain explicitly named SI
  scalar readouts inside `ParamagneticTorus`.
- No grounded library API for the specific paramagnetic Carnot cycle,
  isothermal magnetic heat law, or overall refrigerator COP was found. Small
  local structures were introduced with explicit equations rather than opaque
  physics predicates.
- The `archon` DAG command advertised in the task prompt was unavailable on
  this lane's shell `PATH`; no sibling Lean dependency was introduced, in
  accordance with the natural-language-only previous-part policy.

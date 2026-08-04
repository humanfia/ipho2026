# Autoformalization result: `IPhO2026Problems/problem_IPhO_2026_3_C_5.lean`

## Assumption/target split

### Governing laws

- `SatisfiesParamagneticEquationOfState cycle` states `T M V = n K H` at
  each of the four labelled torus states.
- `SatisfiesIsothermalHeatRelation cycle` states the part-B.1 heat formula
  on the two isothermal legs, with heat entering the torus positive.
- `hTotalColdHeat` is the constant-heat-capacity balance
  `Q_c = C_c (T₀ - T)` for the whole cooling run.
- `hTotalInputWork` is the constant-input-power balance `W = P t`.
- The temperature, heat-capacity, power, and torus positivity hypotheses
  express the physical range required by the model.

### Previous-part results

- `hElapsedTimeFromC4` is exactly the natural-language C.4 result
  `t = (C_c T_h / P) [log (T₀ / T) - (T₀ - T) / T_h]`.
- No C.4 Lean file is imported or referenced.

### Figure/data readouts

- `CycleState` records Figure 3b states 1, 2, 3, and 4.
- `CycleLeg` records the directed order `1 → 2 → 3 → 4 → 1`.
- `FollowsFigureThreeB` records states 1 and 4 at `T_h`, states 2 and 3
  at `T_c`, `Q_c` absorbed on `2 → 3`, `Q_h` delivered on `4 → 1`,
  and zero heat on the two adiabatic legs.
- `MagneticCarnotCycle` retains the field, magnetization, torus volume,
  mole amount, Curie constant, vacuum permeability, reservoir temperatures,
  and signed per-leg heat readouts. SI units are made explicit in field names.
- `CoolingRun` retains `T₀`, `T`, `T_h`, `C_c`, `P`, elapsed time, total
  cold-side heat, and total input work.

### Current target conclusions

- `overallCoefficientOfPerformance` concludes only
  `COP = [(T_h / (T₀ - T)) * log (T₀ / T) - 1]⁻¹`, where the left side
  unfolds only to the general definition `Q_c / W`.

## Goal-faithfulness audit

The requested closed-form COP is not a hypothesis, structure field, law
predicate, or local definition. `coefficientOfPerformance` defines only the
problem's general ratio `Q_c / W`; it does not contain the target expression.
The elapsed-time formula is explicitly identified as a reusable previous-part
result, while the cold-heat and work equations are independent physical
balances. The schematic torus laws and Figure 3b readouts contain no accumulated
COP conclusion. Thus the theorem still requires the substantive algebraic and
logarithmic derivation from the stated physical assumptions.

## Declarations created and blueprint correspondence

- `CycleState`, `CycleLeg`, `CycleLeg.startState`, `CycleLeg.endState`:
  Figure 3b labels and cycle geometry.
- `MagneticCarnotCycle`, `FollowsFigureThreeB`,
  `SatisfiesParamagneticEquationOfState`,
  `SatisfiesIsothermalHeatRelation`, and `HasPhysicalCycleParameters`:
  physical setup and governing laws.
- `CoolingRun` and `coefficientOfPerformance`: accumulated-run readouts and
  the definition `COP = Q_c / W`.
- `IPhO2026Problems.IPhO2026_3_C_5.overallCoefficientOfPerformance`
  corresponds to blueprint label
  `thm:physics:IPhO_2026_3_C_5:target`.

The target statement is ready for the statement-level `\leanok` marker once
the deterministic marker sync associates the blueprint environment with the
declaration. Its proof remains intentionally `sorry` at the autoformalize stage.

## LeanExplore queries and candidates used

- Query: `Real.log natural logarithm of a positive real quotient`.
  Candidate inspected: `Real.log_div` from
  `Mathlib.Analysis.SpecialFunctions.Log.Basic`; the target uses the grounded
  function `Real.log`.
- Query: `SI physical quantity temperature energy work power heat capacity units`.
  Candidate inspected and used: `Temperature` from
  `Physlib.Thermodynamics.Temperature.Basic`.
- Query: `PhysLean SIUnit Temperature Energy Power HeatCapacity`.
  Candidate inspected: `UnitChoices.SI_temperature`; the explicit unit-system
  equality was not needed after using absolute `Temperature`.
- Query: `dimensional quantity with SI dimensions and units`.
  Candidates inspected: `DimEnergy` and `HasDimension`.
- Query: `thermodynamics Carnot refrigerator coefficient of performance heat work`.
  No matching Carnot-refrigerator or COP declaration was returned.
- Candidate inspected but not used:
  `CanonicalEnsemble.heatCapacity`; it is a derivative of mean energy for a
  canonical ensemble at constant volume, not the given constant heat capacity
  of the externally cooled body.

## PhysLean/Mathlib names grounded

- PhysLean: `Temperature`, `Temperature.val`.
- Mathlib: `Real.log` (with `Real.log_div` inspected for its quotient API).

## Local abstractions introduced

- `MagneticCarnotCycle` is a multi-field physical readout interface rather than
  a scalar alias. It preserves the magnetic, thermodynamic, geometric, and
  sign-convention roles needed by the source.
- `FollowsFigureThreeB`,
  `SatisfiesParamagneticEquationOfState`, and
  `SatisfiesIsothermalHeatRelation` faithfully state the unavailable
  figure/refrigerator laws without embedding the current answer.
- Energy, work, power, time, heat capacity, magnetic field, magnetization,
  volume, and material constants are real-valued measured SI components with
  their units in the names. This follows the problem's scalar-readout use while
  retaining PhysLean's nonnegative absolute `Temperature` object.

## Grounding gaps and redraft requests

- LeanExplore exposed no ready-made Carnot refrigeration cycle or coefficient
  of performance API, so faithful local predicates were required.
- `DimEnergy` is unit-system dependent and does not directly match the source's
  requested scalar joule readouts without additional conversion infrastructure;
  it was therefore not used.
- The `archon` executable advertised for dependency-graph navigation was not
  available on `PATH` (`archon: command not found`). The chapter's
  natural-language-only C.4 policy was followed directly.
- The chapter currently has no `\lean{...}` declaration name. Marker sync or
  the plan/review agent should associate its target environment with
  `IPhO2026Problems.IPhO2026_3_C_5.overallCoefficientOfPerformance`.

## Verification

- LSP diagnostics: only the expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_5.lean`: exit code 0,
  with only the expected `sorry` warning.

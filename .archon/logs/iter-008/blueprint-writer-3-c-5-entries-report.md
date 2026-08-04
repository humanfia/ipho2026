# Blueprint Writer Report: 3-c-5-entries
**Status:** COMPLETE

Chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_5.tex` (only file touched). Skeleton kept verbatim (source paragraphs, target block, iter-002 import-exemption NOTE); umbrella `thm:physics:IPhO_2026_3_C_5:target` wired; ledger appended after `% --- Archon physics formalization source end ---` mirroring sibling-ledger placement (2-c-3-entries).

## Blocks added (label — \lean pin, verbatim on disk)
- `def:...:CycleFields` — `IPhO2026.Problem3.C5.CycleFields` (figure content: Fig. 3b corners H1..H4)
- `def:...:RegimeAssumptions` — `IPhO2026.Problem3.C5.RegimeAssumptions`
- `def:...:coefficientOfPerformance` — `IPhO2026.Problem3.C5.coefficientOfPerformance` (quantity def, no value)
- `def:...:ConstantPowerWork` — `IPhO2026.Problem3.C5.ConstantPowerWork` (governing law)
- `def:...:CooledBodyHeatBalance` — `IPhO2026.Problem3.C5.CooledBodyHeatBalance` (governing law)
- `def:...:AccumulatedCarnotHeatRelation` — `IPhO2026.Problem3.C5.AccumulatedCarnotHeatRelation` (governing law)
- `def:...:RefrigeratorEnergyBalance` — `IPhO2026.Problem3.C5.RefrigeratorEnergyBalance` (governing law)
- `def:...:C4ElapsedTimeLaw` — `IPhO2026.Problem3.C5.C4ElapsedTimeLaw` (C.4 licensed prerequisite)
- `def:...:ParamagneticEquationOfState` — `IPhO2026.Problem3.C5.ParamagneticEquationOfState`
- `def:...:OperatingHistory` — `IPhO2026.Problem3.C5.OperatingHistory` (uses the five law defs)
- `thm:...:overall_coefficient_of_performance` — `IPhO2026.Problem3.C5.overall_coefficient_of_performance` (C.5 official-answer entry)
- `thm:...:coefficient_of_performance_via_energy_balance` — `IPhO2026.Problem3.C5.coefficient_of_performance_via_energy_balance` (direct energy-balance route)

## Umbrella wire
- `thm:physics:IPhO_2026_3_C_5:target` now carries `\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_C_5:overall_coefficient_of_performance}`.

## Verification
- Pins: 12/12 unique `\lean{}` names grep-match disk declarations (namespace `IPhO2026.Problem3.C5` — file header verified: `import Mathlib` only; no PhysLean import, matching the chapter's exemption NOTE).
- `\uses{}`: script check (extract labels vs uses) → 0 unknown in-chapter.
- Environments balanced (definition 10/10, theorem 3/3, proof 13/13, itemize 1/1).
- Official value `COP = [(T_h/(T_0-T)) ln(T_0/T) - 1]^{-1}` appears ONLY in the two conclusion-side theorem entries (plus pre-existing recorded-answer paragraph); assumption-side blocks carry only hypothesis equations.
- Markers: no `\leanok`/`\mathlibok` added/removed; no other file modified by this writer.

## Deviations
- `leandag` CLI not on PATH in this environment; `\uses{}` resolved via script instead (0 unknown, 0 isolated new blocks: quantity/law defs feed OperatingHistory/value theorems; value theorem feeds umbrella).
- Directive listed decl `coefficient_of_performance`; on disk the def is `coefficientOfPerformance` — pinned to disk name. Opaque scalar quantities (tempFinal, tempHot, tempInitial, totalHeatCold, totalWork, elapsedTime, heatCapacityBody, inputPower, workingMass, torusVolume, amountOfSubstance, materialConstantK) documented in one ledger comment line, not individual blocks (family-grouping convention).

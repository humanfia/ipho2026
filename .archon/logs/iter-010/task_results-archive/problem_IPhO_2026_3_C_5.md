# Task result: IPhO2026Problems/problem_IPhO_2026_3_C_5.lean (autoformalize, iter-009)

- Assigned file: `IPhO2026Problems/problem_IPhO_2026_3_C_5.lean` (review-gate retry lane, 1/3 used; statements planner-frozen per PROGRESS.md — no redraft dispatched this iter).
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_5.tex` (contains `% archon:physics`; ran under physics-formalize discipline).
- Verification: fresh `~/.elan/bin/lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_5.lean` — 0 errors, exactly the 2 contracted `sorry` warnings (L184:8 `overall_coefficient_of_performance`, L198:8 `coefficient_of_performance_via_energy_balance`). Matches the iter-009 planner audit (3_C_5 sorry count 2).
- File status: contracts discharged; unchanged (planner-frozen). This result provides the required per-lane assumption/target split, faithfulness audit, bridge inventory, countermodel audit, and grounding-gap record.

## Assumption/target split

Governing laws (assumed, hypothesis-side):
- Constant input power: `W = P * t` — `ConstantPowerWork` (L119).
- Calorimetric body balance at constant heat capacity: `Q_c = C_c (T_0 - T)` — `CooledBodyHeatBalance` (L125).
- Accumulated Carnot quota over all infinitesimal cycles with `T_h` constant (`dQ_c/dQ_h = T_c/T_h` per cycle): `Q_h = Q_c * T_h * ln(T_0/T) / (T_0 - T)` — `AccumulatedCarnotHeatRelation` (L137).
- First law for the accumulated operation: `Q_h = Q_c + W` — `RefrigeratorEnergyBalance` (L143).

Previous-part results (licensed natural-language prerequisites):
- C.4 elapsed time `t = (C_c T_h / P) (ln(T_0/T) - (T_0 - T)/T_h)` — `C4ElapsedTimeLaw` (L150); policy `natural_language_prerequisite_only` honored (no Lean import of a C.4 artifact; the law is restated locally as a predicate).
- Per-cycle Carnot ratio from T3-C.4 (embedded in `AccumulatedCarnotHeatRelation`).

Figure/data readouts:
- Cycle corner fields `H1..H4` of Figure 3b (H-versus-T plane) — `CycleFields` (L75), context carrier only.
- Context parameters of part C: mass `workingMass`, `torusVolume`, `amountOfSubstance`, `materialConstantK` = 1.87e-6 K m^3/mol, and the equation of state `T*M*V = n*K*H` — `ParamagneticEquationOfState` (L157).
- Physical regime `0 < T < T_0 < T_h`, positive `C_c`, `P`, `t` — `RegimeAssumptions` (L80).
- Cop definition `COP = Q_c / W` — `coefficientOfPerformance` (L108) (definition of the *quantity*, not its value).

Current target conclusions (conclusion-side only):
- `COP = [(T_h/(T_0 - T)) * ln(T_0/T) - 1]^{-1}` via the constant-power + C.4-time route — `overall_coefficient_of_performance` (L181), `by sorry`.
- Same value via the first-law/energy-balance route alone — `coefficient_of_performance_via_energy_balance` (L198), `by sorry`.

## Goal-faithfulness audit

- The target equation `COP = [(T_h/(T_0-T)) ln(T_0/T) - 1]^{-1}` appears nowhere hypothesis-side: not in `RegimeAssumptions`, not in any law predicate, not in `OperatingHistory`, and not in any local definition. Each law predicate is an independent physical relation over opaque totals (`totalHeatCold`, `totalWork`, the bound `Qh`) and temperatures; none mentions the COP formula or is definitionally equal to it.
- `coefficientOfPerformance` is only `totalHeatCold / totalWork` (the definition of the physical quantity asked for), not the answer value.
- `OperatingHistory` bundles exactly the five governing/previous-part laws; the C.5 conclusion is not one of its fields.
- No `abbrev`/`def` aliases temperatures, heats, or work to transparent values; all are `opaque` scalars with SI-unit docstrings, so the theorems cannot close by unfolding. `Real.log` is used for `ln`.
- No uncertainty data in source C.5 (exact formula) — nothing smuggled.

## Derivability and bridge obligations

1. Claim: `W = C_c T_h (ln(T_0/T) - (T_0-T)/T_h)` from `W = P t` + C.4 time law (constant-power route).
   Carrier: `overall_coefficient_of_performance` via `OperatingHistory.work_law` + `OperatingHistory.c4_time` (encoded locally as `ConstantPowerWork`, `C4ElapsedTimeLaw`). Status: `covered` — body sorried by design (autoformalize); algebraic closure is substitution + `field_simp`/`ring` with `RegimeAssumptions` positivity/ne-zero side facts.
2. Claim: `Q_c = C_c (T_0 - T)` then `COP = Q_c/W` cancellation of `C_c`, `P` to the displayed `[T_h/(T_0-T) ln(T_0/T) - 1]^{-1}` form.
   Carrier: `overall_coefficient_of_performance` via `OperatingHistory.body_heat`; needs `T_0 ≠ T`, `C_c ≠ 0`, `W ≠ 0` from `RegimeAssumptions` + positivity transport (encoded). Status: `covered` (sorried).
3. Claim (independent route): from `Q_h = Q_c + W` and the accumulated Carnot relation, `W = Q_c [(T_h/(T_0-T)) ln(T_0/T) - 1]`, hence `Q_c/W` is the inverse — no C.4 time or constant power used.
   Carrier: `coefficient_of_performance_via_energy_balance` via its three hypothesis predicates (`CooledBodyHeatBalance`, `AccumulatedCarnotHeatRelation`, `RefrigeratorEnergyBalance`). Status: `covered` (sorried).
4. Claim: previous-part C.4 inputs usable without circularity.
   Carrier: blueprint policy `natural_language_prerequisite_only`; local restatement `C4ElapsedTimeLaw` as a `Prop` equation. Status: `covered` (encoded locally; upstream C.4 file `problem_IPhO_2026_3_C_4.lean` exists but is not imported by design — no Lean dependency between siblings is required by the mode).

## Abstraction sufficiency and countermodel audit

- `ConstantPowerWork`, `CooledBodyHeatBalance`, `AccumulatedCarnotHeatRelation`, `RefrigeratorEnergyBalance`, `C4ElapsedTimeLaw`, `ParamagneticEquationOfState`: each exposes a literal equation over `ℝ`, fully eliminable (`rw`/`subst`); not witness-only opacity. Interpreted arbitrarily, the equation fails, so the carrier constrains the model.
- `RegimeAssumptions`: eight strict-inequality fields; provides the `ne`-guards (`T_0 - T > 0`, `T_0 ≠ T`, `T/T_0 > 0` for log well-definedness, `P ≠ 0`, `C_c ≠ 0`) needed for the divisions and for excluding the degenerate `W = 0` countermodel.
- `OperatingHistory`: conjunction packaging the five laws; countermodel-resistance argued in the gate certificate (a COP differing from the inverse form requires violating `Q_h = Q_c + W` or the Carnot accumulation — both are law fields).
- `CycleFields`: pure figure-data record (no Prop content); cannot constrain, and is not relied on by the targets.
- Countermodel sanity check: totals `Q_c, Q_h, W, t` are pinned by the law fields up to the free scale `C_c` (which cancels in `Q_c/W`); with `0 < T < T_0 < T_h` both target formulas are well-defined and the two routes agree. Degenerate readings (`T = T_0`, `T = 0`, `P = 0`) are excluded by `RegimeAssumptions`.

## Uncertainty and branch coverage

- Uncertainty: `not applicable` — C.5 asks for the exact COP formula; the source records no `±` data for this part.
- Branch/orientation: `covered` — refrigeration orientation (work input positive, heat extracted from the cooling body positive) is carried by the signs inside the law equations; the cooling branch `T < T_0` vs. heating `T > T_0` is fixed by `RegimeAssumptions.final_lt_initial`, and `RegimeAssumptions.initial_lt_hot` fixes `T_0 < T_h` (refrigerator below the hot reservoir). The log argument `T_0/T > 1` is therefore the correct, positive branch.

## Declarations created and blueprint labels

All live, pinned in the chapter (sync_leanok owns `\leanok`; none were stale — bodies are contracted `sorry`s): 12 opaques/`structure` context declarations + `CycleFields` (def:...:CycleFields), `RegimeAssumptions` (def:...:RegimeAssumptions), `coefficientOfPerformance` (def:...:coefficientOfPerformance), `ConstantPowerWork` (def:...:ConstantPowerWork), `CooledBodyHeatBalance` (def:...:CooledBodyHeatBalance), `AccumulatedCarnotHeatRelation` (def:...:AccumulatedCarnotHeatRelation), `RefrigeratorEnergyBalance` (def:...:RefrigeratorEnergyBalance), `C4ElapsedTimeLaw` (def:...:C4ElapsedTimeLaw), `ParamagneticEquationOfState` (def:...:ParamagneticEquationOfState), `OperatingHistory` (def:...:OperatingHistory), `overall_coefficient_of_performance` (thm:...:overall_coefficient_of_performance), `coefficient_of_performance_via_energy_balance` (thm:...:coefficient_of_performance_via_energy_balance). No `\leanok` added by hand — the two theorem bodies still carry contracted `sorry`s, so the deterministic sync correctly keeps them un-`leanok` until the prover stage.

## LeanExplore queries/candidates actually used

- Preflight grounding log (iter-002, `task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_5.md`, backend local, packages Mathlib+Physlib): queries "Physics formalization target", "Carnot-cycle corner fields", "Regime assumptions", "Coefficient of performance as a ratio", "Constant-power work bridge", "Cooled-body calorimetric bridge", "Accumulated Carnot heat relation", "Refrigerator energy balance", "C.4 elapsed-time law", "Paramagnetic equation of state". Outcome: all near misses; no candidate signature was usable for the contracts, so faithful local abstractions were introduced (the standing PhysLean-coverage exemption NOTE in the chapter).
- This iter (re-verification, packages ["Mathlib","Physlib"]): "Carnot refrigeration cycle coefficient of performance thermodynamic heat engine", "magnetization Curie law paramagnetic material equation of state", "first law of thermodynamics energy balance heat work refrigeration cycle heat pump". Best hits (`CanonicalEnsemble.thermodynamicEntropy`, `CanonicalEnsemble.heatCapacity`, `adiabatic_relation_log`, `IdealGas.ideal_gas_law`, `Temperature`, `Constants.kB`) remain near misses — ideal-gas/ensemble machinery, not a Curie-law magnetic Carnot cycle with mechanical input power; no COP/first-law-cycle contract found.

## PhysLean/Mathlib names grounded

- `Real.log` (Mathlib) used for `ln` in `AccumulatedCarnotHeatRelation`, `C4ElapsedTimeLaw`, both theorems.
- PhysLean candidates recorded but not adopted (near misses; see Grounding gaps): `Physlib.Thermodynamics.Basic`, `Physlib.Thermodynamics.Temperature.Basic` — probed live this iter: `Temperature` carries no `Sub`/`Div` instances, so the ratio/log algebra of the C.5 formula cannot be stated over it without destructuring; local ℝ-scalar contracts with SI-unit docstrings are the faithful minimal carrier, matching the planner-recorded exemption policy shared with sibling 3_C_4.

## Local abstractions introduced and why they preserve the physical meaning

- Opaque SI scalars for `T, T_h, T_0, Q_c, W, t, C_c, P, m, V, n, K` — determined measurable quantities; opacity prevents definitional smuggling while the equations carry all physics. (Approved convention for final scalars/readouts.)
- Equation-valued `Prop` predicates for each physical law — the smallest interfaces preserving each law's physical role and proof-usable content (equations, eliminable by `rw`).
- `CycleFields`, `ParamagneticEquationOfState`, context opaques (`workingMass`, `torusVolume`, `amountOfSubstance`, `materialConstantK`) — figure/setup parameters preserved even though they cancel from the closed form C.5 answer.

## Grounding gaps / redraft requests

- PhysLean has no thermodynamic-cycle/Carnot/COP contract and no Curie-law paramagnet EOS as of rev `1706ae68`; documented in the chapter's exemption NOTE (iter-002, planner-recorded) and re-confirmed by this iter's queries. No new gap.
- Gate note (read-only observation, no action taken): the stale recorded reason "physics target does not import Physlib/PhysLean" is contradicted by the planner-recorded exemption NOTE convention shared by the same-family 3_C_4 file; with statements planner-frozen and the deterministic review re-pass as the sole next consumer, no edit was made. The retry-lane next consumer remains the deterministic review re-pass per PROGRESS.md.
- No redraft requested; contracts stand.

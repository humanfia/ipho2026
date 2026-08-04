# Task Result: `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean` (IPhO 2026 P3 C.4)

- Stage: autoformalize (Archon iter-009, prover mode: **physics-formalize**)
- Compile status: **PASS** under fresh `lake env lean` — 0 errors, exactly the
  8 contracted `sorry` warnings (L274, L283, L317, L325, L335, L355, L375,
  L401), no other warnings.
- Blueprint chapter: `% archon:physics` confirmed at L2 of
  `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex`.
- File state: **unchanged this iter** — statements planner-frozen (review-gate
  retry lane, 2/3 used per `.archon/formalization-review-gate.json`); this lane
  re-verified the frozen formalization and audits it below. No `/- USER: -/`
  hints present. `\leanok` markers left to the deterministic sync (none in
  chapter; all proofs are contracted sorries, so none are due).

## Assumption/target split

**Governing laws (assumption side, `section GoverningLaws`):**
- `ParamagnetEOS` — equation of state `T * M * V = n * K * H` (equation form).
- `IsothermalHeatIntoTorus` — part-B result
  `Q = -(mu0 * n * K / (2 * T)) * (Hf^2 - Hi^2)`, heat *into* the torus.
- `CarnotHeatRatio` — reversible-cycle ratio in product form
  `Qh * Tc = Qc * Th` plus refrigerator-branch sign conditions
  (`0 < Qc`, `0 <= Qh`).
- `CycleWorkHeatBalance` — first law per infinitesimal cycle `W = Qh - Qc`.
- `ConstantPowerDensityLaw` — constant input power in density form
  `dW/dT' = P * ds/dT'`.
- `BodyCalorimeterDensityLaw` — calorimetric meaning of `C_c`:
  heat drawn per unit temperature drop equals `C_c`.
- `InfinitesimalCycleLaw` / `IsCoolingRun` — bundling of the four per-cycle
  laws plus residence-time positivity, quantified over the control
  temperature `T' in Set.Ioo tempFinal tempInitial` (cooling branch).

**Previous-part results (assumption side):**
- Isothermal heat relation (part B) as `IsothermalHeatIntoTorus`.

**Figure/data readouts (assumption side):**
- `TorusParams` — `mu0`, `n`, `K`, `V` with positivity certificates (material
  constant of potassium chromate; captured though the C.4 answer is
  independent of them).
- `WorkingState`, `CycleCorners`, `Figure3bCorners` — Figure 3b corner labels
  `1,2,3,4`, states `1,4` at `T_h`, states `2,3` at `T'`, EOS at each corner.
- `RegimeAssumptions` — `0 < T < T_0 < T_h`, `0 < C_c`, `0 < P`, `0 < t`
  (positions the cooling run on the physical branch).

**Current target conclusions (conclusion side only):**
- `c4_elapsed_time` —
  `t = (C_c * T_h / P) * (log (T_0 / T) - (T_0 - T) / T_h)` (official answer).
- Intermediate-value conclusions: `elapsedTime_eq_integral` (accumulated
  integral form) and `cooling_time_integral_eval` (FTC evaluation).

## Goal-faithfulness audit

- The recorded answer appears only in the conclusion of `c4_elapsed_time`;
  no hypothesis, premise structure field, `IsCoolingRun` clause, or local
  `def` contains the target formula or any rearrangement of it.
- `elapsedTime` is an `opaque` scalar; nothing defines it as the target
  expression, so no `rfl`/unfolding route exists.
- The operational meaning of `t` enters only via the theorem-local hypothesis
  `haccum : elapsedTime = integral over Icc of run.residenceDensity`, which
  states additivity of time over the run — a modeling relation, not the
  answer (the integrand is the abstract un-evaluated `residenceDensity`).
- `haccum` mentions only `run.residenceDensity`, whose closed form is itself
  proved (as `residenceDensity_eq`) from the governing laws — it is not
  assumed to equal `(C_c/P)(T_h/T' - 1)` anywhere upstream.
- No hypothesis was weakened: ordering `T < T_0 < T_h`, positivity, and the
  refrigerator-branch sign conditions are all present.

## Derivability and bridge obligations

1. Carnot ratio + calorimetry => heat-dumped density `dQ_h = C_c * T_h / T'`.
   - Source claim: `Q_h/Q_c = T_h/T'` per cycle at cold temperature `T'`.
   - Carrier: `IPhO2026.Problem3.C4.heatDumpedDensity_eq`
     (uses `CarnotHeatRatio`, `BodyCalorimeterDensityLaw`, `T' != 0` from
     `Set.Ioo` membership plus regime-side positivity).
   - Status: **covered** (stated as a rewriting equation; proof `sorry`).
2. First law => work density `dW = C_c (T_h/T' - 1)` per unit drop.
   - Carrier: `IPhO2026.Problem3.C4.workDensity_eq`
     (uses `CycleWorkHeatBalance` plus bridge 1).
   - Status: **covered** (`sorry`).
3. Constant-power law => residence density `ds = (C_c/P)(T_h/T' - 1)` per drop.
   - Carrier: `IPhO2026.Problem3.C4.residenceDensity_eq`
     (divides by `P != 0`; cooling branch built into the density formulation).
   - Status: **covered** (`sorry`).
4. Accumulation: `t = integral over [T,T_0] of the explicit residence density`.
   - Carrier: `IPhO2026.Problem3.C4.elapsedTime_eq_integral` — set-integral
     congruence, rewriting on `Set.Ioo` and absorbing the measure-zero
     endpoints (`MeasureTheory.setIntegral_congr` family).
   - Status: **covered** (`sorry`).
5. Evaluation (real analysis):
   `integral over [T,T_0] of (C_c/P)(T_h/T' - 1)
     = (C_c/P)(T_h log(T_0/T) - (T_0 - T))`.
   - Carrier: `IPhO2026.Problem3.C4.cooling_time_integral_eval`; Mathlib
     anchors `intervalIntegral.integral_one_div`, `integral_const`, and the
     `Set.Icc`-to-`intervalIntegral` identity (`intervalIntegral.integral_of_le`).
   - Status: **covered** (`sorry`).
6. Field algebra to the official form
   `(C_c/P)(T_h log(T_0/T) - (T_0-T))
     = (C_c T_h/P)(log(T_0/T) - (T_0-T)/T_h)`.
   - Carrier: main contract `IPhO2026.Problem3.C4.c4_elapsed_time`
     (source-to-contract mapping, `T_h != 0` from regime).
   - Status: **covered** (`sorry`).

Context eliminations supporting the assumptions (both `sorry`):
- `magnetization_of_eos` — EOS transport form `M = n K H / (V T)`.
- `heat_leaves_torus_on_field_increase` — sign of isothermal heat on field
  increase (orientation of the `3 -> 4` leg of Figure 3b).

No blocked bridges.

## Abstraction sufficiency and countermodel audit

Every local `Prop`-valued interface is a conjunction of equations and strict
inequalities, hence constraining (no vacuous witness predicates):
- `ParamagnetEOS` — single equation; elimination contracted by
  `magnetization_of_eos`.
- `IsothermalHeatIntoTorus` — single equation; sign elimination contracted by
  `heat_leaves_torus_on_field_increase`.
- `CarnotHeatRatio` — equation `Qh*Tc = Qc*Th` plus `0 < Qc` plus `0 <= Qh`
  (ratio `Th/Tc` recoverable off `Tc != 0`).
- `CycleWorkHeatBalance`, `ConstantPowerDensityLaw`,
  `BodyCalorimeterDensityLaw` — one equation each.
- `InfinitesimalCycleLaw` / `IsCoolingRun` — conjunction of the above plus
  `0 < residenceDensity T'` (refrigerator branch: cooling takes time),
  quantified on `Set.Ioo`.

Countermodel check: fixing `RegimeAssumptions` values and any `CoolingRun`,
the equations force, at every interior control temperature,
`heatDrawnDensity T' = C_c`,
`heatDumpedDensity T' = C_c T_h/T'`,
`workDensity T' = C_c(T_h/T' - 1)`,
`residenceDensity T' = (C_c/P)(T_h/T' - 1)`;
the arbitrary-interpretation freedom is eliminated on the integrating region,
so an assignment making all assumptions true while the conclusion fails
cannot exist (any countermodel must violate a law equation or `haccum`,
which merely re-expresses `t` via the operationally defined density).
Endpoint freedom is explicit and physically correct (zero-width windows).
The contract is fully determined; no redraft needed.

## Uncertainty and branch coverage

- Uncertainty (`value +/- error`): **not applicable** — the source reports an
  exact closed-form elapsed time with no measurement uncertainties.
- Branch/orientation: **covered** — cooling branch via densities per unit
  temperature *drop* (positive window width, documented on `CoolingRun`);
  `T < T_0 < T_h` ordering in `RegimeAssumptions`; refrigerator branch via
  `0 < Qc`, `0 <= Qh` in `CarnotHeatRatio` and `0 < residenceDensity T'` in
  `InfinitesimalCycleLaw`; hot-end heat-delivery orientation via
  `heat_leaves_torus_on_field_increase`.

## Declarations created and blueprint labels

All in namespace `IPhO2026.Problem3.C4`; labels below use the chapter prefix
`IPhO2026Problems_problem_IPhO_2026_3_C_4`.

- `opaque tempHot | tempInitial | tempFinal | heatCapacityBody | inputPower | elapsedTime`
  — `def:...:globalQuantities`
- `structure TorusParams` — `def:...:TorusParams`
- `structure WorkingState` — `def:...:WorkingState`
- `structure CycleCorners` — `def:...:CycleCorners`
- `structure CoolingRun` — `def:...:CoolingRun`
- `structure RegimeAssumptions` — `def:...:RegimeAssumptions`
- `def ParamagnetEOS` — `def:...:ParamagnetEOS`
- `def IsothermalHeatIntoTorus` — `def:...:IsothermalHeatIntoTorus`
- `def CarnotHeatRatio` — `def:...:CarnotHeatRatio`
- `def CycleWorkHeatBalance` — `def:...:CycleWorkHeatBalance`
- `def ConstantPowerDensityLaw` — `def:...:ConstantPowerDensityLaw`
- `def BodyCalorimeterDensityLaw` — `def:...:BodyCalorimeterDensityLaw`
- `def InfinitesimalCycleLaw` — `def:...:InfinitesimalCycleLaw`
- `def IsCoolingRun` — `def:...:IsCoolingRun`
- `lemma magnetization_of_eos` — `lem:...:magnetization_of_eos`
- `lemma heat_leaves_torus_on_field_increase` — `lem:...:heat_leaves_torus_on_field_increase`
- `def Figure3bCorners` — `def:...:Figure3bCorners`
- `lemma heatDumpedDensity_eq` — `lem:...:heatDumpedDensity_eq`
- `lemma workDensity_eq` — `lem:...:workDensity_eq`
- `lemma residenceDensity_eq` — `lem:...:residenceDensity_eq`
- `theorem elapsedTime_eq_integral` — `thm:...:elapsedTime_eq_integral`
- `theorem cooling_time_integral_eval` — `thm:...:cooling_time_integral_eval`
- `theorem c4_elapsed_time` — `thm:...:c4_elapsed_time`
  (umbrella `thm:physics:IPhO_2026_3_C_4:target` `\uses` it)

## LeanExplore grounding

Grounding register:
`.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_4.md`
(iter-002 preflight, status complete; the file content is byte-identical
since then). Packages searched: Mathlib + Physlib. Queries covered every
blueprint entry name (quantities, torus params, working state, cycle corners,
cooling-run densities, isothermal heat, Carnot ratio). Relevant candidates
consulted: `CanonicalEnsemble.heatCapacity` (PhysLean — heat *capacity*
definition, not the calorimetric cooling law needed here),
`adiabatic_relation_UaUbVaVb` (PhysLean ideal-gas adiabats — different
model), `MeasureTheory.Measure.withDensity` (Mathlib — near miss for the
density formulation). None were applicable to the paramagnetic `(M,H,T)`
infinitesimal-cycle model, so the faithful local abstractions above were
kept; Mathlib's measure/interval-integral API (`Set.Icc` set integrals,
`intervalIntegral.integral_one_div`) provides the analysis anchors.

## Grounding gaps

- PhysLean thermodynamics does not cover this paramagnetic-torus
  infinitesimal-cycle `(M,H,T)` model — planner-recorded exemption NOTEs in
  the chapter (iter-002 ruling, re-confirmed iter-008); `import Mathlib`
  baseline retained. Not a blocker for the by-sorry formalization.
- No other unresolved gaps.

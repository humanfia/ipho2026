# Task result: IPhO2026Problems/problem_IPhO_2026_3_C_4.lean (T3-C.4)

- Mode: physics-formalize (autoformalize); all proof bodies `by sorry` by design.
- Verification: `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_4.lean` exits 0 with **only** the 8 expected `sorry` warnings (no errors, no other warnings).
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex` contains `% archon:physics` and umbrella label `thm:physics:IPhO_2026_3_C_4:target` (no per-decl `\lean{}` pins exist yet — memory: physics chapters carry only the umbrella node).

## Physical model extracted

Paramagnetic torus on a Carnot refrigeration cycle 1→2→3→4→1 (Figure 3b, `H`-`T` plane) cools a body of constant heat capacity `C_c` from `T_0` to `T`. Cold reservoir = the body, so the cold temperature tracks `T' ∈ [T, T_0]`; hot reservoir `T_h` and input power `P` constant. Named quantities (all real scalars, SI): `T_h, T_0, T` (K), `C_c` (J/K), `P` (W), `t` (s), run densities `δQ_c/ΔT'`, `δQ_h/ΔT'`, `δW/ΔT'`, `δs/ΔT'` (J/K or s/K), plus context parameters `μ₀, n, K, V` and corner readouts `(T, H, M)` of Figure 3b. The derivation: per-cycle Carnot ratio `δQ_h = δQ_c T_h/T'`, first law `δW = δQ_h − δQ_c`, calorimetry `δQ_c/ΔT' = C_c`, constant power `δW = P δs` ⇒ `ds/ΔT' = (C_c/P)(T_h/T' − 1)` ⇒ `t = ∫_T^{T_0} … dT'`.

## Assumption/target split

- **Governing laws (assumed, `Prop`-valued equation interfaces):** `ParamagnetEOS` (`T*M*V = n*K*H`); `IsothermalHeatIntoTorus` (part-B result `Q = -(μ₀nK/(2T))(H_f²−H_i²)`, signed); `CarnotHeatRatio` (`Qh*Tc = Qc*Th` + refrigerator-branch sign conditions); `CycleWorkHeatBalance` (first law `W = Qh − Qc`); `ConstantPowerDensityLaw` (`δW/ΔT' = P·δs/ΔT'`); `BodyCalorimeterDensityLaw` (`δQ_c/ΔT' = C_c`).
- **Previous-part results used:** B.1 isothermal heat relation (context); the per-cycle Carnot heat ratio is the C-part law; no Lean import (file is `import Mathlib` only, self-contained).
- **Figure/data readouts:** `T_h, T_0, T, C_c, P` constants with regime ordering `0 < T < T_0 < T_h` (`RegimeAssumptions`); `Figure3bCorners` records corners 1,4 at `T_h`, 2,3 at `T'` with EOS at all corners (figure labels preserved, unused by the final closed form, per modeling rule).
- **Current target conclusions (conclusion side only):** `t = ∫_{[T,T_0]} (C_c/P)(T_h/T'−1)` and the closed form `t = (C_c·T_h/P)·(ln(T_0/T) − (T_0−T)/T_h)` — carriers `elapsedTime_eq_integral`, `cooling_time_integral_eval`, `c4_elapsed_time`.

## Goal-faithfulness audit

- The recorded answer appears only in the conclusions of `cooling_time_integral_eval` (integrand side) and `c4_elapsed_time` (exact closed form matching the official answer string after ring algebra).
- No hypothesis, structure field, `opaque`, or local `def` equals or unfolds to the target formula. `InfinitesimalCycleLaw` contains only per-cycle laws (ratio, first law, power, calorimetry, positivity); it quantifies over `T'` and never integrates, so it cannot yield the logarithm by unfolding. `elapsedTime` is an `opaque ℝ` constrained only by `haccum` (operational definition: time = ∫ residence density) — the answer must be *derived*.
- The cooling branch (`dT' < 0`) is recorded structurally: densities are per unit *drop* `ΔT' > 0`, regime gives `T < T_0`, so the signed answer's orientation is hypothesis-borne, not conclusion-selected.
- Substantive `Prop` relations all expose equations/inequalities (see countermodel audit); none is a bare ∃-witness.

## Derivability and bridge obligations

| Source claim | Lean carrier | Evidence / status |
|---|---|---|
| EOS `TMV=nKH` ⇒ `M = nKH/(VT)` | `magnetization_of_eos` | EOS def + `field_simp`; **covered** (statement-level, `sorry` body) |
| Isothermal field increase ⇒ `Q < 0` (orientation of leg 3→4) | `heat_leaves_torus_on_field_increase` | `IsothermalHeatIntoTorus` + `p.μ₀_pos…` + `sq` monotonicity; **covered** |
| Carnot ratio per cycle: `δQ_h = δQ_c·T_h/T'` | `heatDumpedDensity_eq` (= `C_c·T_h/T'`) | `CarnotHeatRatio` product form ÷ `T' ≠ 0` (from `hT'`) + `BodyCalorimeterDensityLaw`; **covered** |
| First law: `δW = δQ_h − δQ_c` ⇒ `δW/ΔT' = C_c(T_h/T' − 1)` | `workDensity_eq` | `CycleWorkHeatBalance` + previous lemma; **covered** |
| Constant power `δW = P δs` ⇒ `ds/ΔT' = (C_c/P)(T_h/T' − 1)` | `residenceDensity_eq` | `ConstantPowerDensityLaw` ÷ `P > 0` (regime); **covered** — this is the informal differential equation `P ds = C_c(T_h/T'−1)(−dT')` |
| Accumulation: `t = ∫ residence density` ⇒ `t = ∫ (C_c/P)(T_h/T'−1)` | `elapsedTime_eq_integral` (`haccum` + `residenceDensity_eq` on `Ioo`, `Icc` vs `Ioo` measure-zero) | **covered** as contract; proof will need `setIntegral_congr_ae`/`MeasureTheory` plumbing |
| FTC evaluation `∫_T^{T_0} (C_c/P)(T_h/T'−1)dT' = (C_c/P)(T_h ln(T_0/T) − (T_0−T))` | `cooling_time_integral_eval` | Mathlib `intervalIntegral.integral_one_div`, `integral_const`, `setIntegral_eq_intervalIntegral`; **covered** as contract |
| Main theorem contract: assemble ⇒ `t = (C_c T_h/P)(ln(T_0/T) − (T_0−T)/T_h)` | `c4_elapsed_time` | composition of the two bridges + field algebra ÷ `T_h ≠ 0`; **covered** (direct source-to-contract mapping names this carrier) |

No blocked bridges. The current subquestion's target does **not** reuse sibling-file results: C.5's idioms were consulted for house style only (no import, per policy).

## Abstraction sufficiency and countermodel audit

- `ParamagnetEOS` — equation `s.T*s.M*p.V = p.n*p.K*s.H`; elimination: `magnetization_of_eos`. Countermodel check: an `s` violating the equation falsifies the predicate ⇒ constraining.
- `IsothermalHeatIntoTorus` — exact previous-part equation; elimination: `heat_leaves_torus_on_field_increase` (strict inequality consequence). Constraining via value-fixing of `Q`.
- `CarnotHeatRatio` — equation `Qh*Tc = Qc*Th` plus `0 < Qc`, `0 ≤ Qh`; yields ratio form off nonzero data ⇒ determines `Qh` from `Qc, Th, Tc`.
- `CycleWorkHeatBalance`, `ConstantPowerDensityLaw`, `BodyCalorimeterDensityLaw` — each a single equation fixing one quantity from others (work; residence time; heat drawn). A `CoolingRun` assigning arbitrary densities violates at least one conjunct of `InfinitesimalCycleLaw` ⇒ no underdetermination: with `regime`, the four densities are pinned to `C_c·T_h/T'`, `C_c`, `C_c(T_h/T'−1)`, `(C_c/P)(T_h/T'−1)` respectively, which is exactly the force of `heatDumpedDensity_eq…residenceDensity_eq`.
- `IsCoolingRun` quantifies the cycle law over `T' ∈ Ioo T T₀`; the accumulation `haccum` is an equation. Global countermodel attempt (arbitrary `run`) fails `IsCoolingRun` unless densities equal the pinned values a.e., making `elapsedTime` forced to the target via the bridge contracts.
- `Figure3bCorners`/`CycleCorners` — figure-label data (conjunction of equations + EOS at corners); present for the per-cycle justification of the Carnot ratio, intentionally not wired into the time contract.

## Uncertainty and branch coverage

- **Uncertainty:** not applicable — the source reports no `value ± uncertainty` data; all inputs are exact symbolic parameters.
- **Branch/orientation:** covered. Cooling branch: `tempFinal < tempInitial` in `RegimeAssumptions`, densities per unit *drop* (`ΔT' > 0`) with positive residence time (`0 < residenceDensity T'`); refrigerator heat-flow orientation: `0 < Qc` in `CarnotHeatRatio` and `heat_leaves_torus_on_field_increase` for the hot leg; reservoir ordering `T₀ < T_h` preserved explicitly.

## Declarations created ↔ blueprint labels

- `IPhO2026.Problem3.C4.c4_elapsed_time` → `thm:physics:IPhO_2026_3_C_4:target` (umbrella; ready for `\lean{IPhO2026.Problem3.C4.c4_elapsed_time}` pin once planner pins targets).
- Supporting (unlabelled helpers, ready for blueprint transcription): `tempHot, tempInitial, tempFinal, heatCapacityBody, inputPower, elapsedTime` (opaque), `TorusParams, WorkingState, CycleCorners, CoolingRun, RegimeAssumptions`, `ParamagnetEOS, IsothermalHeatIntoTorus, CarnotHeatRatio, CycleWorkHeatBalance, ConstantPowerDensityLaw, BodyCalorimeterDensityLaw, InfinitesimalCycleLaw, IsCoolingRun, Figure3bCorners`, lemmas `magnetization_of_eos, heat_leaves_torus_on_field_increase, heatDumpedDensity_eq, workDensity_eq, residenceDensity_eq, elapsedTime_eq_integral, cooling_time_integral_eval`.
- Chapter currently lacks per-declaration `\begin{theorem}` environments beyond the umbrella; nothing to mark `\leanok` (autoformalize source chapters carry only the target node). Planner may flesh out helper entries in a later bookkeeping iter.

## LeanExplore queries/candidates used

- "Carnot cycle refrigerator coefficient of performance" (Mathlib+PhysLean): only irrelevant `Cycle.*` / polynomial hits plus PhysLean `adiabatic_relation_UaUbVaVb` (ideal-gas adiabatic relation — wrong system).
- "heat engine thermodynamics entropy second law" (PhysLean): `CanonicalEnsemble.*`, `entropy` (ideal gas), `CanonicalEnsemble.heatCapacity` — statistical-mechanics ensemble API, no classical Carnot-refrigerator development; **near miss, recorded as gap**.
- (Preflight log `physics-grounding-…C_4.md` likewise found no usable thermodynamics-cycle API.)

## PhysLean/Mathlib names grounded

- `Real.log` (Mathlib) for `ln`; `MeasureTheory` set integrals (`∫ x in Set.Icc a b, f x`) for the accumulation/evaluation contracts; `Set.Icc/Ioo`, `Filter.Tendsto` available; intended proof-side anchors (not needed to compile): `intervalIntegral.integral_one_div`, `MeasureTheory.setIntegral_congr_ae`.
- No PhysLean declaration used (no matching classical-thermodynamics Carnot API at pinned rev `1706ae68`).

## Local abstractions introduced (and why they preserve physical meaning)

- `CoolingRun` density fields (`ℝ → ℝ` per control temperature) — operational per-cycle heat/work/time magnitudes in density form; the only faithful way to state "infinitesimal cycles at constant `P`" without ultrafilter-level infinitesimals; density formulation keeps every law an ordinary equation.
- `ParamagnetEOS`, `IsothermalHeatIntoTorus`, `CarnotHeatRatio`, `CycleWorkHeatBalance`, `ConstantPowerDensityLaw`, `BodyCalorimeterDensityLaw` — faithful governing-law predicates (equations), not answer-shaped definitions.
- `RegimeAssumptions` — physical regime ordering/positivity, separated so proofs can cite `T' ≠ 0`, `P ≠ 0`, `ln`-domain side goals.
- `opaque` scalars for `T_h, T_0, T, C_c, P, t` — prevent answer-by-unfolding; SI-scalar nature documented.

## Grounding gaps / redraft requests

- **Gap (recorded, non-blocking):** neither Mathlib nor PhysLean (pinned rev) ships a classical thermodynamics Carnot/refrigerator cycle API or a general "heat-capacity body cooled at constant power" development; the file therefore introduces the faithful local law predicates above, mirroring sibling files `problem_IPhO_2026_3_C_2.lean` / `problem_IPhO_2026_3_C_5.lean` house style (same idioms, no cross-import).
- No redraft requests; the file is self-contained (`import Mathlib` only) per `formalization_input_policy`.

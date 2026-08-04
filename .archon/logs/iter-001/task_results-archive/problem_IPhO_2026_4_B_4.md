# Task result: `IPhO2026Problems/problem_IPhO_2026_4_B_4.lean` (autoformalize, physics-formalize)

- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_4.tex` (contains `% archon:physics`).
- Source report: `reports/ipho_2026_k3/problem_IPhO_2026_4_B_4.source.json`.
- Official page images read: `E1_page-11.png` (Part B statement, Eq. (3), Fig. 19, procedure), `E1_page-12.png` (B.4 box: "deduce an algebraic expression for the vapor pressure P_v in terms of P_atm, H_0, H, T_0 and T ... you can assume that the vapor pressure at 0 °C is zero").
- Build status: `lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_4.lean` exits 0 with exactly two `declaration uses sorry` warnings (lines 213, 221 — the two target theorems). All auxiliary context lemmas are fully proved.

## Assumption/target split

### Governing laws (assumed, as structure fields of `VaporPressureB4Data`)
- Dalton's law + syringe arrangement: `total_pressure_eq_atm` — dry-air partial pressure + vapor pressure = constant `P_atm` at every admitted state `(T', H')` with `0 < T'`, `0 < H'` (procedure, page 11).
- Ideal-gas law per trapped component: `idealGas` — `p_da * (A*H) = n_da * R * T` with fixed `dryAirMoles` (IC sealed after valve E closes), and `p_v * (A*H) = n_v * R * T'` with state-dependent `vaporMoles`.
- `vaporMoles_nonneg`: physical nonnegativity of the vapor content.

### Previous-part results (natural-language prerequisite only)
- B.3: `H₀` is the extrapolated height at `0 °C` (official sample 5.9 cm). Carried as parameter `H₀` with positivity `H₀_pos`; not imported from any Lean output.

### Figure/data readouts
- Fig. 19 geometry: uniform-cross-section gas column in the inner cylinder (IC) → `GasColumnGeometry` + `gasVolume H = A * H`.
- `T₀ = 273.15 K` readout: field `T₀_val : T₀ = 273.15`.
- `P_atm` constant total pressure, `R ≈ 8.31 J/(mol·K)` (positivity fields `P_atm_pos`, `R_pos`).
- B.4 explicit hypothesis: `vaporPressure_zero_at_T₀ : vaporPressure T₀ H₀ = 0`.

### Current target conclusions (proved obligations, `sorry` bodies)
- `VaporPressureB4Data.vaporPressure_eq`: `P_v(T,H) = P_atm * (1 - (H₀ * T) / (H * T₀))`.
- `VaporPressureB4Data.target`: the same relation, named for blueprint label `thm:physics:IPhO_2026_4_B_4:target`.

No current target conclusion appears as a hypothesis, structure field, premise, `Satisfies...` predicate, or local definition; the Clausius–Clapeyron predicate is unused by the B.4 target theorem.

## Goal-faithfulness audit
- The structure `VaporPressureB4Data` contains only: geometry/constants (area, `P_atm`, `R`, fixed `dryAirMoles`, `T₀`, `H₀`), physical state functions (`dryAirPartialPressure`, `vaporMoles`, `vaporPressure`), and the three law fields above. None of these unfolds to, or asserts, `P_v = P_atm * (1 - (H₀*T)/(H*T₀))`; instantiating the structure with arbitrary functions obeying the laws does not make the target true by unfolding (see countermodel audit).
- `ClausiusClapeyron` states Eq. (3) itself, not the B.4 formula; it is context for B.5/B.6 and does not enter the target theorem's hypotheses.
- The two target theorems keep the recorded official answer verbatim on the conclusion side: `P_v = P_atm * (1 - (H₀ * T) / (H * T₀))`.
- `rfl`-proved items: only `gasVolume` unfolding in algebraic bridges; no substantive answer is closed by definition.

## Derivability and bridge obligations
| Source step | Lean carrier | Evidence | Status |
|---|---|---|---|
| Constant total pressure & Dalton splitting (procedure p.11) | field `total_pressure_eq_atm` | equation `p_da + p_v = P_atm` at all admitted states | covered (encoded as law field) |
| Ideal-gas law per component, fixed dry-air content | field `idealGas` | two equations `p * (A*H) = n * R * T` per component | covered (encoded as law field) |
| `P_v(T₀) = 0` (B.4 hypothesis) | field `vaporPressure_zero_at_T₀` | equation at `(T₀, H₀)` | covered (encoded as hypothesis field) |
| At `T₀`, dry air alone carries `P_atm` | lemma `dryAirPartialPressure_at_T₀` | proved (rw + add_zero) | covered (proved) |
| Combined gas invariant `P_atm * A * H = (n_da + n_v) * R * T` | lemma `total_pressure_mul_volume` | proved (calc + ring) | covered (proved) |
| Main B.4 algebra: eliminate `n_da` between states `(T,H)`, `(T₀,H₀)`, divide by `P_atm`, cancel `A` | theorem `vaporPressure_eq` / `target` | conclusion of target theorems | covered as statement; proof `sorry` (autoformalize stage) |
| Clausius–Clapeyron Eq. (3) context | def `ClausiusClapeyron` (+ `Real.exp`) | grounded in Mathlib `Real.exp` | covered (context predicate, not needed by B.4) |
| Consistency `P_v0 = 0 → P_v ≡ 0` under Eq. (3) | theorem `eq_zero_of_clausiusClapeyron_zero` | proved | covered (context lemma) |

## Abstraction sufficiency and countermodel audit
Local `Prop`-valued interfaces and why they constrain the model:
- `ClausiusClapeyron` — exposes a closed-form equation per positive temperature; elimination available via `eq_zero_of_clausiusClapeyron_zero`. Constraining: with `P_v0 = 0` it forces `P_v ≡ 0`.
- `total_pressure_eq_atm` — per-state equation; together with `vaporPressure_zero_at_T₀` it yields the proved consequence `dryAirPartialPressure_at_T₀`. Constraining.
- `idealGas` — per-state pair of equations linking pressures, volume, and molar content; yields the proved consequence `total_pressure_mul_volume`. Constraining.
- `vaporPressure_zero_at_T₀`, positivity fields — point equations/inequalities used to discharge denominators (`P_atm`, `T₀`, `H₀`, `T`, `H`, `A` all nonzero).

Countermodel sanity check: fields (`P_atm`, `dryAirMoles`, `H₀`, areas) can be chosen arbitrarily positive and the partial-pressure functions can still vary with `(T, H)` subject to the laws; the laws do not by themselves make the target equation true by unfolding — it must be derived from the pair of states and the fixed `n_da`, so the contract is not underdetermined by construction. With `vaporMoles` also arbitrary per state, the only underdetermination of `P_v(T,H)` is resolved precisely by the target equation's derivation route (ratio of dry-air invariants), confirming the assumptions match the official solution route.

## Uncertainty and branch coverage
- Uncertainty: `not applicable` — the source reports no `±` value for B.4 (official sample `H₀ = 5.9 cm` from B.3 is a previous-part natural-language readout, not part of the B.4 contract; the target is a symbolic expression).
- Branch/orientation: `not applicable` — the target is a positive scalar expression; no signed/directional information is requested. Positivity side conditions for absolute temperature and heights are recorded (`T_pos`, `H_pos`, `H₀_pos`, `T₀` via `T₀_val` + `referenceState`) so the signed division in the target is meaningful.

## Declarations created (blueprint labels)
- `IPhO2026_4_B_4.GasColumnGeometry` — Fig. 19 gas-column geometry (no blueprint env; context).
- `IPhO2026_4_B_4.gasVolume` — headspace volume from height (context).
- `IPhO2026_4_B_4.ClausiusClapeyron` — Eq. (3) predicate (context for B.5/B.6).
- `IPhO2026_4_B_4.VaporPressureB4Data` — B.4 physics contract (structure).
- `IPhO2026_4_B_4.VaporPressureB4Data.MeasuredState` — admissible `(T, H)` readout (B.1/B.2 table rows).
- `IPhO2026_4_B_4.VaporPressureB4Data.referenceState` — `(T₀, H₀)` as measured state.
- `IPhO2026_4_B_4.VaporPressureB4Data.dryAirPartialPressure_at_T₀` — proved bridge.
- `IPhO2026_4_B_4.VaporPressureB4Data.total_pressure_mul_volume` — proved bridge.
- `IPhO2026_4_B_4.VaporPressureB4Data.eq_zero_of_clausiusClapeyron_zero` — proved context lemma.
- `IPhO2026_4_B_4.VaporPressureB4Data.vaporPressure_eq` — **target** (sorry).
- `IPhO2026_4_B_4.VaporPressureB4Data.target` — corresponds to `thm:physics:IPhO_2026_4_B_4:target` (sorry). Suggest the review agent map `\lean{IPhO2026_4_B_4.VaporPressureB4Data.target}` to that label; `\leanok` should be applied by the deterministic sync only after sorries close.

## LeanExplore queries/candidates actually used
- Preflight grounding log (`.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_4.md`) returned only near misses (`Path.target`, `Physlib.Meta.Informal.semiformal_result`, `stereographic_target`) — none usable; recorded as mismatch.
- Direct environment check via `lake env lean`: `Real.exp`, `Real.log` (Mathlib) confirmed; `Real.exp` used in `ClausiusClapeyron`.

## PhysLean/Mathlib names grounded
- `Real.exp` (Mathlib) — Clausius–Clapeyron exponent.
- Tactic/library lemmas used in proved bridges: `rw`, `ring`, `norm_num`, `add_zero`, `zero_mul`.
- No suitable PhysLean foundry object for gas mixtures/Dalton was found in this rev; local structure abstraction used instead (recorded above).

## Local abstractions introduced (and why they preserve physical meaning)
- `GasColumnGeometry`/`gasVolume`: keeps the figure's uniform-cross-section geometry rather than aliasing volume to `ℝ`; `H` retains its role as volume per unit area.
- `VaporPressureB4Data`: keeps dry-air and vapor partial pressures as state-dependent physical functions (not scalar aliases), keeps molar contents explicit, and states laws as equations — matching the official derivation `n_da = P_atm A H₀/(R T₀) = (P_atm - P_v) A H/(R T) → P_v = P_atm(1 - H₀ T/(H T₀))`.
- `MeasuredState`/`referenceState`: separates measured readouts from constants, providing the strict positivity needed for the target's division.

## Grounding gaps / redraft requests
- No PhysLean gas-law/Dalton API located in rev `1706ae68`; local faithful abstractions used instead (documented above). No redraft requested.
- Note for plan/review: the B.4 target theorems intentionally do **not** assume `ClausiusClapeyron`; downstream files B.5/B.6 (out of scope here) should consume `ClausiusClapeyron` plus this file's `vaporPressure_eq` shape if they import it.

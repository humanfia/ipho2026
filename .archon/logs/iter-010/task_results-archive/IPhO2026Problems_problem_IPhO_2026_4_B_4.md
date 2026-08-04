# Task result: IPhO2026Problems/problem_IPhO_2026_4_B_4.lean (iter-009, physics-formalize — review-gate retry 1/3)

Status: **re-verified iter-009, unchanged** (review-gate retry lane, 1/3 count recorded —
planner-frozen statements; deterministic review pass is the next consumer
per PROGRESS.md iter-009). This lane re-audited the on-disk file: fresh
`lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_4.lean` run gives
0 errors and exactly the 2 contracted sorries (`vaporPressure_eq` L216,
`target` L224 — sorry-warning lines 213/221 were the pre-blank-line
numbering; current warnings report L213:8 and L221:8 for the theorem
headers, sorries on 216/224). Blueprint chapter
`IPhO2026Problems_problem_IPhO_2026_4_B_4.tex` still carries the full
11-entry declaration ledger with correct flat `IPhO2026_4_B_4.*` pins
(`leandag` node lookups this lane: all 9 pinned declarations matched,
[target]/[vaporPressure_eq] marked [sorry], defs/lemmas clean); no
statement or pin change was needed, so per AGENTS.md the planner-frozen
`.lean` file and the blueprint chapter were left untouched (`\leanok` is
owned by the deterministic sync; the three helper lemmas
`dryAirPartialPressure_at_T₀`, `total_pressure_mul_volume`,
`eq_zero_of_clausiusClapeyron_zero` are proof-complete and marker-ready).
The prior iter-008 lane reached the same conclusion (see last_message
archive) but its task-result file was lost in an iter-008 collect
incident; this report restores and updates it.

## Assumption/target split

Governing laws (assumption side, `VaporPressureB4Data` fields):
- Dalton's law + syringe pressure lock: `total_pressure_eq_atm` —
  `dryAirPartialPressure T' H' + vaporPressure T' H' = P_atm` at every
  admitted state (`0 < T'`, `0 < H'`).
- Ideal-gas law per component: `idealGas` —
  `p_air·(A·H') = n_air·R·T'` with fixed `dryAirMoles` (sealed headspace),
  and `P_v·(A·H') = n_vap(T',H')·R·T'`.
- Nonnegativity of the vapor content: `vaporMoles_nonneg`.

Figure/data readouts (assumption side):
- Geometry: `GasColumnGeometry` (uniform cross-section `A > 0`, Fig. 19);
  `gasVolume H = A·H`.
- Reference temperature: `T₀ = 273.15` K (field `T₀_val`).
- Previous-part result (B.3, natural-language prerequisite): `H₀ > 0`
  (field `H₀_pos`; official sample value 5.9 cm stays natural-language
  only, per the `previous-part-policy` line in the chapter).
- Calibrated scalar roles: `P_atm > 0`, `R > 0`, `dryAirMoles > 0`.

Explicit B.4 hypothesis (assumption side):
- `vaporPressure_zero_at_T₀ : vaporPressure T₀ H₀ = 0` — "you can assume
  that the vapor pressure at 0 °C is zero".

Current target conclusions (conclusion side ONLY):
- `vaporPressure_eq` and `target`:
  `D.vaporPressure s.T s.H = D.P_atm * (1 - (D.H₀ * s.T) / (s.H * D.T₀))`
  for an arbitrary admissible `MeasuredState` `(T, H)`.

## Goal-faithfulness audit

- The official answer `P_atm * (1 - (H₀ * T) / (H * T₀))` occurs in exactly
  two places: the conclusions of `vaporPressure_eq` and `target`. It does
  not occur in any structure field, hypothesis, premise, or local
  definition. Grep-verified.
- `ClausiusClapeyron` (Eq. (3)) is context for B.5/B.6 only; it is NOT a
  hypothesis of the B.4 target (recorded as standalone predicate plus the
  consistency lemma `eq_zero_of_clausiusClapeyron_zero`).
- No scalar-alias collapse: partial pressures and molar contents are genuine
  state-dependent functions `ℝ → ℝ → ℝ` on admitted states, not `abbrev … := ℝ`.
- `gasVolume` is a real geometric definition (`A * H`), not the target
  relation in disguise; `MeasuredState` only bundles positivity readouts.
- The two sorries are the contracted ones (`by sorry` bodies of
  `vaporPressure_eq`, `target`); all derivation-bridge lemmas
  (`dryAirPartialPressure_at_T₀`, `total_pressure_mul_volume`,
  `eq_zero_of_clausiusClapeyron_zero`) are fully proved, so the physics
  content is checkable.

## Derivability and bridge obligations

1. Source: Dalton at (T₀,H₀) + zero vapor pressure ⇒ dry air carries P_atm.
   Carrier: `VaporPressureB4Data.dryAirPartialPressure_at_T₀` — **covered**
   (proved: rewrite by `vaporPressure_zero_at_T₀`, `add_zero`).
2. Source: Dalton + ideal gas (both components) ⇒ combined law
   `P_atm·A·H' = (n_air + n_vap)·R·T'`. Carrier:
   `VaporPressureB4Data.total_pressure_mul_volume` — **covered** (proved
   `calc` via `idealGas`, `ring`).
3. Source: eliminate fixed `n_air` between the reference balance
   `P_atm·A·H₀ = n_air·R·T₀` (from 1 + `idealGas` at (T₀,H₀)) and the
   state balance (2) ⇒ `p_air(T,H)·H·T₀ = P_atm·H₀·T`; Dalton
   subtraction ⇒ target formula. Carrier: conclusion-side theorems
   `vaporPressure_eq` / `target` — **blocked → contracted sorry** (prover
   stage; needs field-division bookkeeping using `T₀_val`, `H₀_pos`,
   `s.T_pos`, `s.H_pos`, all present).
4. Source: Eq. (3) consistency, P_v0 = 0 ⇒ identically-zero vapor curve.
   Carrier: `eq_zero_of_clausiusClapeyron_zero` — **covered** (proved;
   context only, used by later parts).

## Abstraction sufficiency and countermodel audit

Local `Prop`-valued interfaces:
- `total_pressure_eq_atm` — equation per admitted state; combined with
  `idealGas` it determines `vaporPressure` pointwise once `n_air` is fixed,
  so the model is not underdetermined: given all fields, the target formula
  is forced (bridge 3 derives it algebraically; the dry-air content
  elimination is unique because `A·H₀·T₀ ≠ 0` via `area_pos`, `H₀_pos`,
  `T₀_val`).
- `idealGas` — two equations per admitted state (one per component); not a
  bare witness.
- `vaporPressure_zero_at_T₀`, `vaporMoles_nonneg` — point equations /
  inequalities as stated.
- `ClausiusClapeyron` — functional equation with elimination theorem
  `eq_zero_of_clausiusClapeyron_zero` exposing consequences.
Countermodel check: arbitrary reinterpretation of the function fields is
blocked because the law fields pin their values at every admitted state;
the gas-column area cancels between reference and state balances, matching
the official derivation (A absent from the answer by physics, not by
omission).

## Uncertainty and branch coverage

- Uncertainty: **not applicable** — B.4 asks for an exact algebraic
  expression; no `±` data in the source for this part. (B.3's H₀ sample
  value enters only as the natural-language prerequisite `0 < H₀`.)
- Branch/orientation: **not applicable** — no signed direction choice;
  the only sign content is positivity of the measured readouts, carried by
  `MeasuredState.T_pos/H_pos`, `T₀_val`, `H₀_pos`.

## Declarations created (blueprint pins — all present in the chapter ledger)

- `IPhO2026_4_B_4.GasColumnGeometry` ↔ `def:…:GasColumnGeometry`
- `IPhO2026_4_B_4.gasVolume` ↔ `def:…:gasVolume`
- `IPhO2026_4_B_4.ClausiusClapeyron` ↔ `def:…:ClausiusClapeyron`
- `IPhO2026_4_B_4.VaporPressureB4Data` ↔ `def:…:VaporPressureB4Data`
- `IPhO2026_4_B_4.VaporPressureB4Data.MeasuredState` ↔ `def:…:MeasuredState`
- `IPhO2026_4_B_4.VaporPressureB4Data.dryAirPartialPressure_at_T₀` ↔ `lem:…:dryAirPartialPressure_at_T0` (proved; marker-ready)
- `IPhO2026_4_B_4.VaporPressureB4Data.total_pressure_mul_volume` ↔ `lem:…:total_pressure_mul_volume` (proved; marker-ready)
- `IPhO2026_4_B_4.VaporPressureB4Data.eq_zero_of_clausiusClapeyron_zero` ↔ `lem:…:eq_zero_of_clausiusClapeyron_zero` (proved; marker-ready)
- `IPhO2026_4_B_4.VaporPressureB4Data.vaporPressure_eq` ↔ `thm:…:vaporPressure_eq` (contracted sorry)
- `IPhO2026_4_B_4.VaporPressureB4Data.target` ↔ `thm:…:target` and umbrella `thm:physics:IPhO_2026_4_B_4:target` (contracted sorry)

## LeanExplore queries/candidates actually used

Preflight log (this file's physics-grounding report, restored iter-008):
queries over Mathlib + Physlib for ideal-gas law, Clausius–Clapeyron,
Dalton, gas-column geometry, measured state, target formula. Candidates
inspected: `IdealGas.ideal_gas_law` (PhysLean, unitless R=1 Hamiltonian
model — mismatch: no partial pressures / sealed-component content),
`DimPressure`/`standardAtmosphere` (dimensional unit wrappers — mismatch:
the experiment's readouts are unit-mixed cm/K scalars), `NVEHamiltonian.pressure`,
`adiabatic_relation_log` (wrong ensemble/law). Recorded as near misses in
the grounding log; faithful local abstractions used instead.

## PhysLean/Mathlib names grounded

- `Real.exp`, `Real.logb` (Mathlib, context predicate arithmetic).
- No PhysLean declaration used; chapter carries the planner-recorded
  PhysLean-coverage exemption NOTE (iter-002/iter-001 import policy).

## Local abstractions introduced

- `GasColumnGeometry` + `gasVolume`: preserves Fig. 19 headspace geometry
  (H as volume per unit cross-section) instead of erasing the volume.
- `VaporPressureB4Data`: bundles Dalton + per-component ideal-gas law +
  zero-at-T₀ hypothesis with state-dependent partial-pressure functions —
  the smallest interface keeping the mixture physics intact.
- `MeasuredState`: positivity-guarded readout pair (T, H).
- `ClausiusClapeyron`: standalone Eq. (3) predicate for B.5/B.6 reuse.

## Grounding gaps / redraft requests

- None. PhysLean has no module for this experimental vapor-pressure
  readout at the needed granularity (documented exemption). No redraft
  requested; file is in the review-gate queue (retry 1/3) and expected
  green at the deterministic review pass.

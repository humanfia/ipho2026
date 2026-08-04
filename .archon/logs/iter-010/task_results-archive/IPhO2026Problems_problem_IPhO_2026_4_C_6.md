# Task Result: IPhO2026Problems/problem_IPhO_2026_4_C_6.lean (autoformalize re-audit, iter-009)

- Mode: physics-formalize (by-sorry autoformalization; review-gate 2/3 **provenance-blocked** lane —
  `raw/E1_solution.pdf` absent from this checkout, find-verified iter-007; TO_USER escalation stands, no redraft dispatch).
- Fresh check: `lake env lean IPhO2026Problems/problem_IPhO_2026_4_C_6.lean` → exit 0, **0 errors**, exactly the 4
  contracted sorry warnings (L369 `wall_thermal_resistance_from_C5`, L396 `uncertainty_propagates_to_resistance`,
  L424 `official_sample_value`, L439 `official_sample_uncertainty`). No other warnings. Matches the planner audit.
- Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_6.tex` starts with `% archon:physics` ✔.
- Chapter ↔ Lean coverage: all `\lean{...}` pins in the chapter resolve to existing declarations in the file
  (namespace `IPhO2026_4_C_6`), including the full autoformalization helper ledger added iter-007.
- DAG check: `archon dag-query node --node thm:IPhO2026Problems_problem_IPhO_2026_4_C_6:wall_thermal_resistance_from_C5`
  → `has_sorry: true`, 1 node, deps wired (`dep_count 4`) ✔.
- **Edit this iter:** one docstring repair only — `DimC5Slope` referenced a nonexistent declaration
  `ExperimentC.actionDim_is_watt_second` (a stale name dropped in an earlier redraft); now points at the existing
  `ExperimentC.slope_inversion_is_dimensionally_correct`. Comment-only; statements, signatures, proofs untouched
  (planner-frozen lane; sorry count and line positions unchanged, reverified post-edit).

## Assumption/target split

**Governing laws (assumption side, conclusion-side-clean):**
- Lumped heat-flow model (source Eq. 4) + energy conservation with apparatus heat capacity ignored:
  `c₀·m·dT_IC/dt = (T_OC − T_IC)/R_Th` — carried by `CoolingModel` and structure field `ExperimentC.cooling_model`.
- Finite-difference model on measurement intervals (source Eq. 5):
  `c₀·m·(T_IC(t₁)−T_IC(t₀))/(t₁−t₀) = ΔT̄(t₀,t₁)/R_Th` — `FiniteDifferenceModel` + field `finite_difference_model`.
- Fourier radial-conduction law (source Eq. 6): `dQ/dt = −λ·A·dT/dr` jointly with the lumped drive
  `dQ/dt = ΔT/R_Th` — `FourierRadialConductionLaw` + field `fourier_law` (Figure 17 material/geometry inputs
  `thermalConductivity`, `wallArea`, `radialTempGradient`, `wallTempDiff`).

**Previous-part results (natural-language prerequisites):**
- C.4 equilibrium temperature `T_eq` (environment-loss channel) — field `T_eq`, assumption-only.
- C.5 calibrated graph readout: the finite-difference rate vs. interval-averaged temperature difference is a
  least-squares line with slope `s` — fields `samples`/`samples_ge`, `xSample`/`ySample`, `slopeC5`, `interceptC5`,
  `x_varies` (nondegenerate abscissae), `c5_linear_fit : IsLeastSquaresLine ...`. The C.5 conclusion **named**
  `s = 1/(c₀·m·R_Th)` appears nowhere assumption-side; only the data-fit relation is assumed.

**Figure/data readouts:**
- C.5 slope readout uncertainty — field `slope_readout : MeasuredValue slopeC5.valSI.val` (half-width via
  `StrictBand`/`MeasuredValue`, propagates in `official_sample_uncertainty`).
- Positivity certificates: `RTh_pos`, `slopeC5_pos`, `heatCapacity_pos` (inversion well-posedness), `samples_pos`.
- Official sample microdata (from the official solution material; provenance caveat below):
  `a = 2.28e-3 1/s`, `m = 0.089 kg`, `c₀ = 4186 J/(kg·K)` — appear only inside the *conclusions*
  `official_sample_value` / `official_sample_uncertainty`.

**Current target conclusions (conclusion side only):**
- `wall_thermal_resistance_from_C5` : `R_Th = 1/(c₀·m·s)` as real SI values (≡ source form `c₀·m·s·R_Th = 1`).
- `uncertainty_propagates_to_resistance` : worst-case relative band `|δR/R| ≤ us + uq` for the inversion.
- `official_sample_value` : recorded band `1.17 ± 0.03 K/W` certified against `1/(4186·0.089·2.28e-3)`.
- `official_sample_uncertainty` : `1.17·(Δa/a + Δm/m)/2 ≤ 0.03`.

## Goal-faithfulness audit

- No hypothesis, premise field, `Laws`-field, `Valid...`/`Satisfies...` predicate, or local definition equates
  `RTh` to an expression of `c₀`, `m`, or `slopeC5`: audited every field of `ExperimentC` — the RTh-related fields
  are `RTh` (unconstrained quantity), `RTh_pos` (positivity only, needed since the model divides by R_Th), and the
  two model-law fields (`cooling_model`, `finite_difference_model`), which are the *governing equations* that later
  *derive* `s = 1/(c₀·m·R_Th)`; they do not contain the slope fit and cannot be unfolded into the C.6 conclusion.
- `IsLeastSquaresLine` assumes only that the recorded data lie on a line through the fitted `(s,b)` with the
  least-squares estimator formula — the physical identification of that `s` with `1/(c₀·m·R_Th)` is precisely the
  content of the main theorem, left on conclusion side.
- The C.6 identity `c₀·m·s·R₀ = 1` appears as the *theorem* `cooling_model_inversion_key` (proved by real algebra,
  no `sorry`), not as a definition; `official_sample_*` are pure conclusion-side numerical certificates.
- `DimMassQ`/`DimSpecificHeat`/`DimThermalResistance`/`DimC5Slope` are dimension-carrying `SIQuantity d` wrappers
  over PhysLean `WithDim`, not scalar aliases; `Temperature`/`Time` are the PhysLean types (temperature differences
  and rates are scalar `WithDim` readouts per the permitted measured-component rule, explicitly documented).
- No `True`/tautology replacement: each theorem states the physical relation or the numerical band of the source.
- `c5_first_point` is a naming/helper expansion (pure projection of the fit hypothesis onto the first sample),
  explicitly not the C.6 answer; the `rfl`-proved items are only SI-coherence lemmas (`valSI_mul`, `valSI_div`,
  `castTo_valSI`) and the dimension-arithmetic certificate `slope_inversion_is_dimensionally_correct`.

## Derivability and bridge obligations

| # | Source claim | Lean carrier | Evidence / status |
|---|---|---|---|
| 1 | Eq. 4 + energy conservation ⇒ `c₀·m·dT_IC/dt = (T_OC − T_IC)/R_Th` | `CoolingModel` (def, equation holding ∀ t) + field `cooling_model` | grounded locally; assumption-side ✔ |
| 2 | Eq. 5 finite-difference rate tracks `ΔT̄/(R_Th·c₀·m)` per interval | `FiniteDifferenceModel` + field `finite_difference_model` | grounded locally; assumption-side ✔ |
| 3 | C.5 graph linear with least-squares slope `s` | `IsLeastSquaresLine` + fields `c5_linear_fit`, `x_varies`, `samples_ge` | grounded locally (real least-squares estimator in Mathlib `Finset.sum` form); assumption-side ✔ |
| 4 | Bridges 1–3 ⇒ slope `s = 1/(c₀·m·R_Th)` ⇒ **C.6: `R_Th = 1/(c₀·m·s)`** | main theorem `wall_thermal_resistance_from_C5` (direct source-to-contract carrier), dimensional side certified by `ExperimentC.slope_inversion_is_dimensionally_correct` (proved, `ext <;> dim_component`) | `sorry`; **covered** for prover stage — route: unfold the two model fields, read rate-per-`ΔT̄` off the fit (nondegeneracy via `x_varies`), invert with `RTh_pos`/`slopeC5_pos`/`heatCapacity_pos` |
| 5 | Exact algebraic key `c₀·m·s·R₀ = 1` for `R₀ = 1/(c₀·m·s)` | `cooling_model_inversion_key` — **proved** (`mul_inv_cancel₀`, no sorry) | **covered** (grounded on Mathlib) |
| 6 | `|δR/R| = |δs/s| + |δc₀/c₀| + |δm/m|` worst-case propagation | `uncertainty_propagates_to_resistance` (isolated inversion estimate `|1/(q·s) − R| ≤ R·(us+uq)`, budgets `< 1/2`) | `sorry`; **covered** prover-stage route documented in docstring (`|1/(qs)−1/(cms)| = |(cm−q)/(q·cm·s)|`, denominator bounded away from 0, worst-case addition); uncertainty half-widths stay in the contract per the propagation rule ✔ |
| 7 | Official sample: `1/(4186·0.089·2.28e-3) ≈ 1.177` lies in `1.17 ± 0.03 K/W` | `official_sample_value` | `sorry`; **covered** as certified interval arithmetic (deviation ≈ 0.007, 4× margin); provenance caveat below |
| 8 | Official budget `1.17·(0.06/2.28 + 1/89)/2 ≈ 0.022 ≤ 0.03` | `official_sample_uncertainty` (`/2` mean-error combining convention documented as load-bearing) | `sorry`; **covered** as certified interval arithmetic |

All 4 by-sorry bodies carry an explicit proof route; no bridge is blocked by a missing Mathlib/PhysLean API
(real-algebra + interval-arithmetic discharge suffices everywhere).

## Abstraction sufficiency and countermodel audit

- `SIQuantity d` / `WithDim` operations (`HMul`, `HDiv`, `castTo`): coherence fixed by `@[simp]` `rfl` lemmas —
  dimension arithmetic is constraining (type-level `Dimension` index; wrong-dimensioned laws do not elaborate) ✔.
- `CoolingModel` / `FiniteDifferenceModel`: `Prop`-valued ∀-quantified *equations* on SI values (derivatives via
  `deriv`, finite differences via explicit quotient). Constraining — a countermodel must satisfy the ODE/difference
  equation pointwise; they are law-shaped, not witness-shaped ✔.
- `FourierRadialConductionLaw`: two instant equations tying `heatCurrent` to both `−λ·A·dT/dr` and `ΔT/R_Th` —
  the elimination of `heatCurrent` yields `R_Th`'s material/geometry determination; fields cannot be interpreted
  arbitrarily without falsifying the conjunction ✔.
- `IsLeastSquaresLine`: pointwise line equation (∀ j < n) + the exact least-squares estimator identity; with
  `x_varies` the slope is uniquely determined, so the fit is constraining (degenerate fits excluded) ✔.
- `StrictBand` / `MeasuredValue`: `lower`/`upper` bounds + positivity — band membership is an inequality pair,
  not an opaque predicate; the central readout `v` sits strictly inside `(v−δ, v+δ]` ✔ (per memory note,
  readout structs carry the guard against degenerate countermodels).
- `ExperimentC` bundle countermodel check: fields may be instantiated arbitrarily (temperature records, fits,
  RTh values satisfying the model laws and the fit), and the C.6 conclusion `RTh = 1/(c₀·m·s)` is *not* forced to
  be false by any admissible instantiation — but neither is it true by unfolding: its instances include both
  satisfying and falsifying parameter assignments *only when the model laws and fit are jointly satisfiable*, and
  for the actual physical record they jointly pin `s·c₀·m·R_Th = 1`. The target stays proof-requiring ✔.

## Uncertainty and branch coverage

- Uncertainty: **covered** — the C.5 slope readout carries `MeasuredValue` (half-width + band) on the assumption
  side; propagation is the conclusion-side theorems `uncertainty_propagates_to_resistance` (general worst-case
  form `|δR/R| = |δs/s| + |δc₀/c₀| + |δm/m|`), `official_sample_value` (`± 0.03` band in contract), and
  `official_sample_uncertainty` (propagation inputs `Δa/a`, `Δm/m` name-symmetric in the contract).
- Branch/orientation: **covered statement-side** — signed temperature drive `T_OC − T_IC` is preserved
  (no `|·|` introduced anywhere); the inversion branch uses strict positivity certificates
  (`RTh_pos`, `slopeC5_pos`, `heatCapacity_pos`) rather than an unsigned absolute value; the strict vs. non-strict
  band edges (`StrictBand.lower` strict / `.upper` non-strict) record the one-sided band convention.
- No other branches (tangent/asymptotic/incoming-outgoing) occur in this subquestion: **not applicable**.

## Declarations created / blueprint labels

All in namespace `IPhO2026_4_C_6` (unchanged; chapter ledger pins verified live against the file):
- `SIQuantity` (+ `valSI_mul`, `valSI_div`, `castTo`, `castTo_valSI`) — `def:..._4_C_6:SIQuantity` +
  `lem:...:Coherence of the SI liftings` block.
- `DimMassQ`, `DimSpecificHeat`, `DimThermalResistance`, `DimC5Slope`, `DimTempDiffQ`, `DimWattQ` —
  named-dimension-alias block.
- `StrictBand`, `MeasuredValue` — band/measured-value block.
- `tempDiffSI`, `coolingRateSI`, `finiteDiffRateSI`, `innerHeatCapacitySI`, `driveSI` —
  temperature-difference/rate + heat-capacity/drive block.
- `CoolingModel`, `FiniteDifferenceModel`, `FourierRadialConductionLaw`, `IsLeastSquaresLine` —
  governing-law `Prop` blocks.
- `ExperimentC` (+ `ExperimentC.samples_pos`, `ExperimentC.c5_first_point`,
  `ExperimentC.slope_inversion_is_dimensionally_correct`) — `def:..._4_C_6:ExperimentC` + helper lemmas.
- `wall_thermal_resistance_from_C5` — `thm:IPhO2026Problems_problem_IPhO_2026_4_C_6:wall_thermal_resistance_from_C5`
  (umbrella `thm:physics:IPhO_2026_4_C_6:target`),
  `cooling_model_inversion_key` — `lem:...:cooling_model_inversion_key` (proved),
  `uncertainty_propagates_to_resistance` — `thm:...:uncertainty_propagates_to_resistance`,
  `official_sample_value` — `thm:...:official_sample_value`,
  `official_sample_uncertainty` — `thm:...:official_sample_uncertainty`.
- `\leanok` markers: **not applied** (0 present in the chapter; 4 proofs remain `sorry`, so the deterministic
  `sync_leanok` phase owns any future marking — recorded per the read-only-markers rule).

## LeanExplore queries / PhysLean/Mathlib grounding

- Grounding register preserved at `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_6.md`
  (queries over packages Mathlib+Physlib: SI-valued quantity → `WithDim`/`UnitChoices.SI`/`Dimension`; temperature →
  `Temperature`, `Dimension.div_temperature`; derivative → `deriv`; etc.).
- Grounded names actually used in the file: `Physlib` `Dimension` basis (`L𝓭, T𝓭, M𝓭, Θ𝓭`, `WithDim`, `WithDim.cast`,
  `Temperature`, `Time`) via the six targeted Physlib imports (positive targeted-import case per the chapter's
  iter-003 reconciliation NOTE); `Mathlib` `deriv`, `Finset.sum`, `abs`, `mul_inv_cancel₀`, `one_div`.
- No new queries needed this iter (doc-link repair only).

## Local abstractions (why they preserve physical meaning)

- `SIQuantity d` + named dimension aliases keep K/W, s⁻¹, J/K, W as distinct dimension-carrying types instead of
  scalars — the C.6 inversion is type-checked dimensionally on both sides.
- `CoolingModel`/`FiniteDifferenceModel`/`FourierRadialConductionLaw` are law-shaped `Prop`s carrying the actual
  source equations (Eq. 4/5/6 + conservation), not conclusion-shaped formulas.
- Figure-17 material parameters (`thermalConductivity`, `wallArea`, `radialTempGradient`) are record fields even
  though they drop out of the closed form — they are part of the setup and of the C.7 proof route (per the
  parameter-capture rule); `T_eq` keeps the C.4 environment-loss channel on the assumption side.

## Grounding gaps / redraft requests / provenance

- **Provenance caveat (standing, TO_USER):** the official sample microdata (`a = (2.28 ± 0.06)·10⁻³ 1/s`,
  `m = (89 ± 1) g`, `c₀ = 4186` exact) rest in the iter-004 lane's quotation of `raw/E1_solution.pdf`, which is
  **absent from this checkout** (find-verified iter-007). Arithmetic independently re-verified
  (`1/(4186·0.089·2.28e-3) = 1.1773`, deviation from 1.17 is 0.0073 ≤ 0.03 with 4× margin); citation verification
  is a TO_USER escalation, not a statement defect. Review gate: 4_C_6 stays 2/3 provenance-blocked; no redraft
  requested — statements are faithful as designed.
- No Mathlib/PhysLean grounding gaps: PhysLean lacks heat-conduction/thermal-resistance objects (recorded in the
  chapter's import-policy NOTE), so the laws are faithful local abstractions; all discharge routes are real algebra
  + certified interval arithmetic already available in Mathlib.
- No `/- USER: ... -/` hints present in the file.

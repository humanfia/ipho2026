# Prover task result: problem_IPhO_2026_3_B_1.lean (iter-013, lane 8)

## Verdict
closed, sorry-free. Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`
reports 0 errors, 0 warnings, 0 sorries (exit 0, empty log). The iter-011
proof-review redraft (field-parametrized work law) was faithful and fully
derivable — the 7 sorries were unfinished proof bodies, not modeling defects.
Contract unchanged: every edit is strictly after `:= by`; the file at lane
start was byte-identical to the iter-013 lane snapshot
(`.archon/logs/iter-013/snapshots/IPhO2026Problems_problem_IPhO_2026_3_B_1/baseline.lean`).

## What was proved (all 7 former sorries)
- `magnetization_deriv` — pointwise EOS solution (`magnetization_eq_eos_solution`)
  via `funext`, then `HasDerivAt.deriv` of `(hasDerivAt_id' H).const_mul c`
  (simpa reconciles the `c * 1` derivative).
- `workOnDensity_eq_linear` — unfold `IsMagneticWorkDensity` (`hwork H`),
  rewrite the Jacobian with `magnetization_deriv`, close by `ring`.
- `workOnDensity_contDiff` — `funext` to the linear form, then
  `contDiff_const.mul contDiff_id`.
- `q_in_eq_neg_integral` — first-law leg balance at `(0, H)` plus calibration
  `proc.h_ref` (`sub_zero`).
- `q_in_deriv` — rewrite `Q_in` as `fun x => -∫ H' in 0..x, workOnDensity H'`
  (`funext` of `q_in_eq_neg_integral`), then FTC-1
  `intervalIntegral.integral_hasDerivAt_right` (integrability from
  `Continuous.intervalIntegrable`, measurability from
  `Continuous.stronglyMeasurableAtFilter`, both from
  `workOnDensity_contDiff`), `HasDerivAt.neg`, and `.deriv`.
- `leg_work_integral_eval` — rewrite the integrand as
  `H' ↦ c * H'` (`funext` of `workOnDensity_eq_linear`), then
  `intervalIntegral.integral_const_mul` + `integral_id`, and
  `field_simp`+`ring` with `proc.hV`/`proc.hT` reconciling
  `μ₀ * V * n * K / (V * T) * (H²/2)` with `(μ₀ * n * K / (2 * T)) * H²`.
- `isothermal_heat_into_torus` (target) — unfold `heatTransferredIntoTorus`
  and `heat_into_torus_value`, rewrite both endpoints with
  `q_in_eq_neg_integral` + `leg_work_integral_eval`, close by `ring`, giving
  `Q = -(μ₀ * n * K / (2 * T)) * (H_f² - H_i²)`, the official answer.

`official_answer_value` and `magnetization_eq_eos_solution` were already
sorrie-free at lane start; no hypothesis, signature, or conclusion was touched.

## Axiom check
Inlined the file body and ran `#print axioms` on all eight named
lemmas/theorems: each depends only on the Mathlib-standard
`[propext, Classical.choice, Quot.sound]`. No `sorryAx`, no new `axiom`,
no `admit`, no `native_decide`; grep over the file shows `sorry` only in the
stale header docstring sentence.

## Blueprint markers
Added `\leanok` inside the nine closed proof environments of
`blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_1.tex`:
lemmas MagnetizationFixedByEOS, MagnetizationDerivative, WorkOnDensityLinear,
WorkOnDensityC1, HeatReadoutAntiderivative, HeatReadoutDerivative,
LegWorkIntegralEval; theorems IsothermalHeatIntoTorus, OfficialAnswerValue.
The five definition environments (TorusParams, TorusState, HeatCapacityConstM,
SatisfiesEOS, HasHeatCapacityLaw, IsMagneticWorkDensity,
ObeysFirstLawMagnetic, IsothermalFieldChange, HeatTransferredIntoTorus,
HeatIntoTorusValue) carry "Definition; no claim." proofs — left unmarked,
consistent with sibling lanes leaving definition entries to the sync.

## Housekeeping
- Header docstring still says "all proof bodies requiring real content are
  `by sorry`" — now stale; left untouched (docstring-only cosmetic issue,
  flagged for the polish/review phase rather than edited under signature
  discipline).
- `archon dag-query` CLI is not on PATH in this lane; dependency navigation
  was done directly against the chapter and Mathlib sources.

## Redraft needed
None — the iter-011 contract is provable as stated.

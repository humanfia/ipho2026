# Session 4 Review Summary — iter-004 autoformalize (1 target)

## Scope & method
Reviewed exactly the 1 deterministic-candidate target of iter-004:
`IPhO2026Problems/problem_IPhO_2026_4_C_6.lean` (repair lane, review attempt 1/3).
Compile results taken from the orchestrator preflight (12.90 s, **1 passed / 0 failed**;
status `passed` — no rerun per bounded-review rule). `blueprint-doctor.json` consumed as
the structural/physics-doctor verdict. Semantic/faithfulness audit done from the
candidate-pack excerpt + task/grounding reports + first-hand reads of the full statement
file (all 443 lines) + independent reviewer arithmetic on every numerical contract +
provenance check of the claimed primary source (`raw/E1_solution.pdf` — **absent from
this checkout**). No subagents enabled; reviewer applied the physics checklist directly
(no dedicated `physics-reviewer` report exists).

## Headline metrics
- Compile: **PASSED** — 0 errors; exactly 4 `sorry` warnings = the 4 contracted
  `by sorry` bodies (`wall_thermal_resistance_from_C5` L369,
  `uncertainty_propagates_to_resistance` L396, `official_sample_value` L424,
  `official_sample_uncertainty` L439).
- Review verdict: **1 failed / 0 passed** under the mandatory `formalization_review`
  gate; `status=partial`. All 6 structured checks pass at statement level; the fail is
  carried by two durable non-statement blockers (grounding-log noise; unverifiable
  sample-microdata provenance) — full evidence in `milestones.jsonl`.
- Doctor (iter-004 JSON): 19 `physics_modeling_problems`, ALL kind
  `missing-physlib-import`; **4_C_6 is NOT among them** (positive targeted-import case —
  6 genuinely-used Physlib imports). 0 grounding problems, 0 orphans, 0 broken/malformed
  refs, 0 axioms, 0 covers problems.
- sync_leanok: iter=4, scope current-objectives, targets_checked = [4_C_6],
  added=0/removed=0; the chapter carries no `\leanok` — deterministic non-action on a
  sorry-bodied target; no laundering.

## What the lane did (vs its directive)
- The iter-004 objective O2 ordered a **quarantine-delete** of the numerically-false
  `official_sample_value` (old readouts gave `1/(4186·0.55·7.3e-4)=0.595 ∉ 1.17±0.03`).
- The lane **deviated (redraft-class)**: it claims to have recovered the official sample
  microdata from `raw/E1_solution.pdf` (C.5 rate-slope `a=(2.28±0.06)·10⁻³ 1/s`,
  `m=(89±1) g`, `c₀=4186 J/(kg·K)` exact) and **restated** `official_sample_value`
  against `1/(4186·0.089·2.28e-3)`, adding `official_sample_uncertainty`.
- Reviewer-verified arithmetic (independent, this review): model value 1.17727,
  deviation 0.00727 ≤ 0.03 (4× margin); uncertainty budget 0.02197 ≤ 0.03 with the
  documented `/2` mean-error convention (worst-case full sum 0.04394 > 0.03, so the
  convention is load-bearing and honestly disclosed). **The iter-002 false-existential
  numerical defect is genuinely closed.**
- Preservation per directive: main inversion theorem, abstract worst-case propagation
  carrier, 6 Physlib imports, `DimThermalResistance` typed model, all governing-law
  fields, all remaining sorries. Recorded answer `1.17` stays strictly conclusion-side.

## Statement audit highlights (full evidence in milestones.jsonl)
- source_faithfulness PASS — Eq.4/Eq.6/energy-conservation laws all assumption-side;
  K/W = Θ·T³·L⁻²·M⁻¹ spelled out dimensionally; Figure-17 wall data captured;
  answer conclusion-side only. Residual: sample microdata provenance is
  prover-asserted (primary source absent from checkout).
- derivability PASS — every bridge has a named carrier; `cooling_model_inversion_key`
  PROVED (`mul_inv_cancel₀`); the 4 sorries are exactly the contracted bridges.
- abstraction_sufficiency PASS — law predicates eliminate to equations;
  `IsLeastSquaresLine` gives the normal-equation slope formula; no ghost Props.
- uncertainty_propagation PASS — `MeasuredValue` field + worst-case carrier +
  official budget certificate; no uncertainty data dropped.
- branch_orientation PASS — graph/slope branch fixed by dimension `T⁻¹` + `slopeC5_pos`;
  the pdftotext exponent-sign ambiguity (10⁻² vs 10⁻³) resolved toward 10⁻³ by the
  band-center consistency argument (implied `a=2.294e-3`; 2.28e-2 off by an order of
  magnitude), documented header-side.
- countermodel_resistance PASS — degenerate fit excluded by `x_varies`;
  `δ=0.03` fixed in the existential; laws as equations constrain arbitrary
  interpretations. Bridge obligations: 4/4 covered.

## Why the gate still fails (2 blockers, both durable/systematic — neither is a
## statement defect in this file)
1. **Grounding-log noise (systematic, iter-002 → iter-004).** The deterministic
   preflight log again shows only `Path.target` / `semiformal_result` /
   `stereographic_target` noise hits and `None detected` for local abstractions —
   contradicted by the file's real inventory (7 abstraction families incl. 6
   genuinely-used Physlib imports). Per the durable iter-002/iter-003 ruling the task
   report's grounded-names section (`WithDim`, `Dimension`+basis+`Dimension.ext`,
   `Temperature(+toReal)`, `Time`, `UnitChoices`; Mathlib `deriv`, `Finset`,
   `mul_inv_cancel₀`, `abs`) is the register of record — but the review-prompt
   condition "a compiling Lean file without this log is a BLOCKER" still binds at gate
   level until the loop fixes the preflight-vs-report contradiction.
2. **Unverifiable sample provenance (new detector this iter).** The recovered
   microdata on which `official_sample_value`'s fidelity rests is not
   reviewer-verifiable: `raw/E1_solution.pdf` is absent (`references/` holds only
   `summary.md`) and `reports/.../4_C_6.source.json` records only the final band
   `1.17±0.03 K/W` and the slope law — no run microdata. The only evidence is the
   lane's own task-report quote: prover-asserted provenance inside a conclusion-side
   theorem, the same defect class this file was quarantined for at iter-002. The
   internal arithmetic is TRUE; the external citation is unverifiable in this checkout.

## Stale-blueprint flag
The chapter's iter-003 planner NOTE still narrates "quarantined — microdata cannot be
recovered from the C.5 source page," which the on-disk theorems now contradict. The
lane's task report already requested the chapter-NOTE rewrite (chapters are outside its
write domain). Surfaced for the next plan agent.

## Routing
Re-review at attempt 2/3 — **not** redraft. Next plan must (1) secure provenance
(restore the solution PDF / extract the C.6 page into `reports/`, else revert to the
quarantine-delete), (2) rewrite the stale chapter NOTE, (3) keep the grounding-log
noise defect routed as the systematic 26-file blocker. This file is semantically the
strongest version of the target so far; do not churn its statements.

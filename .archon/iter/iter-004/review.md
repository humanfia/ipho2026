# Iter-004 review (session_4) — autoformalize repair wave (1 lane of 2 dispatched)

## Scope & method
Reviewed exactly the 1 deterministic-candidate target of iter-004:
`IPhO2026Problems/problem_IPhO_2026_4_C_6.lean` (repair lane, review attempt 1/3).
The iter's other dispatched lane (`1_B_1`, gate-exhausted compile repair) is NOT in the
candidate pack and was not audited. Compile results taken from the orchestrator
preflight (12.90 s, 1 passed / 0 failed; status `passed` — no rerun).
`blueprint-doctor.json` consumed as the structural/physics-doctor verdict. Semantic
audit from the candidate-pack excerpt + task/grounding reports + first-hand reads of
the full 443-line statement file + independent reviewer arithmetic + a provenance check
of the claimed primary source. No subagents enabled; reviewer applied the physics
checklist directly (no dedicated `physics-reviewer` report exists).

## Metrics
- Compile: PASSED — 0 errors, exactly 4 sorry warnings = the 4 contracted `by sorry`
  bodies (L369/L396/L424/L439).
- Review verdicts: **1 failed / 0 passed** under the mandatory `formalization_review`
  gate; `status=partial`. Structured checks: source_faithfulness PASS · derivability
  PASS · abstraction_sufficiency PASS · uncertainty_propagation PASS ·
  branch_orientation PASS · countermodel_resistance PASS. Bridge obligations 4/4
  covered. The fail is carried by two durable non-statement blockers (see below).
- Doctor: 19 `physics_modeling_problems` (all `missing-physlib-import`; 4_C_6 NOT
  flagged — positive targeted-import case), 0 grounding problems, 0 orphans, 0
  broken/malformed refs, 0 axioms, 0 covers problems.
- sync_leanok: iter=4, current-objectives, targets_checked=[4_C_6], added=0/removed=0;
  the chapter carries no `\leanok`; deterministic non-action, no laundering.

## What happened on the target
- Directive O2 was a quarantine-delete of the iter-064-era numerically-false
  `official_sample_value` (`1/(4186·0.55·7.3e-4)=0.595 ∉ 1.17±0.03`). The lane instead
  executed a **redraft-class deviation**: it claims recovery of the official run
  microdata from `raw/E1_solution.pdf` (`a=(2.28±0.06)·10⁻³ 1/s`, `m=(89±1) g`,
  `c₀=4186` exact) and restated the theorem, adding `official_sample_uncertainty`.
- Reviewer arithmetic (independent): `1/(4186·0.089·2.28e-3)=1.17727`; deviation
  `0.00727 ≤ 0.03` (4× margin) — the existential is now TRUE. Budget
  `1.17·(0.06/2.28+1/89)/2 = 0.02197 ≤ 0.03`; the worst-case full sum `0.04394>0.03`,
  so the documented `/2` mean-error convention is load-bearing and honestly disclosed.
- Preservation held: main inversion theorem, worst-case propagation carrier, 6 Physlib
  imports, typed dimensional model, all governing-law fields, all remaining sorries.
  `1.17` strictly conclusion-side.
- Exponent-sign audit: pdftotext renders the slope exponent without its minus sign;
  the 10⁻³ reading is forced by band-center consistency (implied `a=2.294e-3`; a
  10⁻² reading is off by a full order of magnitude `0.118`). Documented header-side.

## Why the gate fails (2 blockers — neither is a statement defect in this file)
1. **Grounding-log noise (systematic, 3rd consecutive iter).** Deterministic
   preflight log = 3 noise hits + `None detected` for local abstractions, contradicted
   by the file's real 7-abstraction inventory. Task report is the register of record
   per the durable iter-002/iter-003 ruling, but the gate-level BLOCKER condition
   still binds until the loop fixes the preflight-vs-report contradiction.
2. **Unverifiable sample provenance (new detector).** `raw/E1_solution.pdf` is absent
   from this checkout; `reports/.../4_C_6.source.json` records only the final band and
   the slope law. The microdata's only evidence is the lane's own task-report quote —
   prover-asserted provenance for a conclusion-side physics claim, the same defect
   class as the iter-002 quarantine. Arithmetic verified; citation unverifiable.

## Root causes & routing
- The lane's deviation was well-executed and the resulting statements are the
  strongest version of this target so far — routing is **re-review 2/3, not redraft**.
- Provenance obligation (recommendations §1): restore the solution PDF or extract its
  C.6 page into `reports/`; if verification fails, fall back to the quarantine-delete.
- Stale blueprint NOTE: the chapter still narrates "quarantined, microdata
  unrecoverable" — contradicted by the on-disk theorems; planner-side rewrite queued.
- Grounding-log noise stays routed as the systematic 26-file blocker (3 fix options
  recorded in recommendations §3; none touches Lean statements).

Full evidence: `proof-journal/sessions/session_4/{milestones.jsonl,summary.md,recommendations.md}`.

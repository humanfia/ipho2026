# Iter-003 review (session_3) — autoformalize redraft-3 wave (1 lane)

## Scope & method
Reviewed exactly the 1 deterministic-candidate target of iter-003:
`IPhO2026Problems/problem_IPhO_2026_1_B_1.lean` (redraft #3; review attempt 2/3
after this verdict). Compile results taken from the orchestrator preflight
(10.29 s, 0/1 passed; preflight status `failed`, so no rerun rule applied).
`blueprint-doctor.json` consumed as the structural/physics-doctor verdict.
Semantic/faithfulness audit done from the candidate-pack excerpt +
task/grounding reports + first-hand reads of the full statement file, the
blueprint chapter, and the prover lane last_message. No subagents enabled;
reviewer applied the physics checklist directly (no dedicated
`physics-reviewer` report exists).

## Metrics
- Compile: **FAILED** — 3 `linarith failed to find a contradiction` errors
  (L401/L419/L427, all inside `CoulombPairData.quadratic_pos_of_large`);
  5 sorry warnings (the 5 contracted `by sorry` bodies); 2 deprecation
  warnings (`push_neg`).
- Review verdicts: **1 failed / 0 passed** under the mandatory
  `formalization_review` gate; `status=partial`.
  Per-check results (full evidence in milestones.jsonl):
  source_faithfulness PASS · derivability FAIL (broken boundedness bridge +
  two sorry target bridges) · abstraction_sufficiency PASS ·
  uncertainty_propagation N/A · branch_orientation PASS ·
  countermodel_resistance PASS (iter-002 class closed; sign-carrier caveat
  recorded). Bridge obligations: 3 covered / 2 blocked
  (boundedness bridge; apogee-IVT bridge).
- Doctor: 19 `physics_modeling_problems`, ALL kind `missing-physlib-import`
  (this file flagged; iter-003 exemption NOTE and complete near-miss grounding
  log present); 0 grounding problems; 0 orphans; 0 broken/malformed refs;
  0 axioms; 0 covers problems.
- sync_leanok: iter=3, current-objectives scope, targets_checked=[1_B_1],
  added=0/removed=0 — deterministic non-action on a failed target; the
  annotated `% STALE-LEANOK iter-001` marker is vouched by nothing and is
  recorded as stale, not laundering.

## What happened on the target
- Directive met: `bound_branch : total_energy < 0` is now a `CoulombPairData`
  **field** (structure-level branch predicate, per the iter-002 durable
  ruling). Lawful E>=0 instances can no longer be constructed, so the
  right-unbounded attained-set countermodel to `orbitBound_T1_B1` is excluded
  at mk time. `boundMu_isBound` correctly kept as the constant-level mu=4
  criterion (the two criteria live on different types; the prover's analysis
  of why the field cannot re-derive the constant Prop is correct).
- Preservation met: `AnchoredValues`, `turningQuadratic_normalized_eq`
  (abstract rho), proved certificates, both conclusion-side sorry bridges,
  proved `maximum_separation_*` endpoints, 5 `by sorry` bodies, and 1600/9
  strictly conclusion-side (no field/law/hypothesis mentions it).
- Lane deviation: the prover added `quadratic_pos_of_large` +
  `attainedSeparations_lt_energy_threshold` beyond the directive (exposure
  lemmas for the new field) after self-rejecting a first draft of false
  D-independent universal lemmas (`boundMu_eq_zero_of_not_bound`,
  `orbit_bound_of_bound_self`) — good adversarial self-checking; but the
  accepted pivot does not compile.
- Statement-level finding (new detector): `turning_root_cases` writes the
  recorded root coefficients into the hypothesis formula `hroot`, so the
  proved decider legitimately derives `x = 1600/9` — the answer is
  derivable from the hypothesis interfaces at sorry-gap distance. Nothing
  statement-false; it is an answer-in-formula contract weakness: prefer
  existential-coefficient or rho-mediated restatement, with the numeric
  factorisation inside the bridge proofs only.

## Root causes & routing
- Compile regression is goal-level (proof-body), not design-level: the
  branch-field design is sound; the added boundedness proof underestimate
  the linear/nonlinear split. Route: review-retry (attempt 3/3) with the
  R1 discharge shapes; do NOT spend the last retry on statement redesign.
- Doctor↔exemption conflict is now three iters old (
  iters 001-003): 19 findings, 1 kind, all exemption-covered or genuinely
  justified. Route: director-side doctor patch forgiving ONLY
  `missing-physlib-import` on NOTE-carrying chapters.
- Sign-carrier question (Q<=0 tail-set vs Q>=0 orbit band) surfaced
  independently by the prover (last_message) and this review: recorded as a
  planner decision for the next redraft pass, NOT counted against this iter
  (directive said preserve `orbit_support`; the target theorems are
  line-true on the current model).

## Next-iter routing summary
- Review-retry (fix-first compile): `problem_IPhO_2026_1_B_1.lean` —
  attempt 3/3, R1 shapes mandatory; fold R2 tightening only if cheap.
- Outstanding outside the target set: `4_C_6` O2 quarantine still NOT
  applied (`official_sample_value` L409 still on disk; 0.595 vs 1.17±0.03
  stays false); helper-blueprint transcription debt starts next iter.
- Reconciliation to escalate if unpatched: doctor `missing-physlib-import`
  vs planner exemption NOTEs (3rd consecutive iter).

Full evidence: `proof-journal/sessions/session_3/{milestones.jsonl,summary.md,recommendations.md}`.

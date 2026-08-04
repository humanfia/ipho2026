# Session 3 Review Summary — iter-003 autoformalize (1 target)

## Scope & method
Reviewed exactly the 1 deterministic-candidate target of iter-003:
`IPhO2026Problems/problem_IPhO_2026_1_B_1.lean` (redraft #3, review attempt 2/3).
Compile results taken from the orchestrator preflight (10.29 s, 0 passed / 1 failed;
status `failed` — no rerun needed beyond confirming what was already recorded).
`blueprint-doctor.json` consumed as the structural/physics-doctor verdict.
Semantic/faithfulness audit done from the candidate-pack excerpt + task/grounding
reports + first-hand reads of the full statement file (all 614 lines), the
blueprint chapter, and the prover lane's last_message (which documents its own
design reasoning). No subagents enabled; reviewer applied the physics checklist
directly (no dedicated `physics-reviewer` report exists).

## Headline metrics
- Compile: **FAILED** — 3 `linarith failed to find a contradiction` errors at
  L401 / L419 / L427 inside `CoulombPairData.quadratic_pos_of_large`.
  5 sorry warnings (L137/319/361/563/576 preflight numbering) = the 5 contracted
  `by sorry` bodies — sorry count itself is per contract.
- Review verdict: **1 failed / 0 passed** under the mandatory
  `formalization_review` gate; `status=partial`.
- Full structured verdict in `milestones.jsonl` (all 6 checks + 5 bridge
  obligations, 3 covered / 2 blocked).

## What the lane did (from provers-combined/last_message)
- Fulfilled the core directive: `bound_branch : total_energy < 0` added as a
  `CoulombPairData` **field** — the iter-002 countermodel class (lawful E>0
  instances falsifying the maximum) is closed at construction time.
- Preserved as ordered: `AnchoredValues`, `turningQuadratic_normalized_eq`
  (abstract rho), both conclusion-side sorry bridges `orbitBound_T1_B1` /
  `apogee_attained_T1_B1`, the proved `maximum_separation_*` endpoints, and
  1600/9 strictly conclusion-side (no structure field, law, or hypothesis
  mentions it).
- Deviated from 'preserve' in one place: it added new proof obligations
  (`quadratic_pos_of_large`, `attainedSeparations_lt_energy_threshold`) as the
  usable-consequence exposure of the new field — after detecting and
  self-rejecting a first draft of false D-independent universal lemmas
  (`boundMu_eq_zero_of_not_bound` / `orbit_bound_of_bound_self`). The pivot is
  semantically right but the proof does not compile.

## Blocking findings (route to next iter)
1. **Compile regression (BLOCKER, fix-first).** 3 linarith gaps in
   `quadratic_pos_of_large`: (a) L401 div-to-mul step
   `k*e^2 <= r*(-E)  ==>  0 <= E*r + k*e^2` — genuinely nonlinear; `nlinarith`
   was tried with the wrong product hints; (b) L419 the L=0-vs-`turning_100`
   contradiction; (c) L427 final combination. Either repair with explicit
   `have` + `nlinarith [mul_nonneg ..., hkey]` products, or simplify by keeping
   only `attainedSeparations_lt_energy_threshold`'s contrapositive skeleton and
   discharging positivity of the threshold directly. This is a review-retry
   (reviews used 2/3), not a fresh redraft.
2. **Answer-in-formula contract weakness (recorded, not a fake).** Proved
   decider `turning_root_cases` carries the recorded root coefficients in the
   hypothesis formula `hroot`, so `x = 1600/9` is legitimately derivable from
   the current hypothesis interfaces at sorry-gap distance. Nothing is
   statement-false; it weakens the conclusion-side-only discipline. Prefer in
   the next pass: keep the root identities *inside* the proofs of
   `orbitBound/apogee_attained` (term-level `have`), and state the abstract-root
   decider with an existential coefficient (`exists c1 c2, ... = c1*... + c2`)
   or via `turningQuadratic_normalized_eq`'s rho.
3. **Doctor blocker (standing, director-side).** `physics_modeling_problems`
   = 19, ALL kind `missing-physlib-import`; this file flagged despite the
   iter-003 planner-recorded `% NOTE:` PhysLean-coverage exemption on the
   chapter and a complete grounding log showing only near-miss PhysLean hits.
   `physics_grounding_problems` = 0. Same doctor-vs-exemption conflict as
   iters 001–002 — needs one central doctor patch (forgive ONLY the
   physlib-import check), not per-file oscillation.
4. **Recorded for the planner (not counted as fail): sign-convention note.**
   `attainedSeparations := {r | 0<r and Q r <= 0}` names the sign tails; with
   E<0 the physical orbit band [x1,x2] satisfies Q >= 0. The maximum theorems
   are line-true on the current model (turning points lie on the boundary),
   but the set does not model the orbit interior. The prover's own
   last_message flags exactly this as a redraft request; the planner should
   decide whether the next pass flips the carrier sign (and updates the
   doc language on `bound_branch`, which already argues in the >=-convention).

## sync_leanok attribution
`sync_leanok-state.json`: iter=3, scope=current-objectives,
targets_checked=[this file], added=0/removed=0, chapters_touched=[].
The chapter's `\leanok` remains annotated `% STALE-LEANOK iter-001: marker
does not vouch` — the sync's deterministic non-action on a failed target;
no laundering.

## Stage bookkeeping
- Autoformalize gate for 1_B_1 is NOT passed (reviews used 2/3 after this
  verdict; one review-retry remains). Do not advance the stage on this file.
- The 26 out-of-target review-ready files are unchanged by this review;
  per iter-003 objectives they re-enter at the next formalization-review gate.

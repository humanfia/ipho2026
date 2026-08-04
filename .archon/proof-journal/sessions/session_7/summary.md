# Session 7 summary — iter-007 autoformalize review (1 deterministic target)

## Scope & method
Reviewed exactly the 1 candidate in `logs/iter-007/deterministic-review-candidates.md`:
`IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` (iter-007 O1 statement-repair lane; second
formalization review, gate 1/3 → 2/3). Compile taken from the orchestrator parallel preflight
(9.083 s, `passed`) — no rerun per the bounded-review rule. `blueprint-doctor.json` consumed as the
injected structural/physics verdict (no leandag/DAG rebuild, no repo-wide scans). Semantic audit
from the candidate pack + full first-hand read of the 353-line file on disk + gate ledger +
sync-leanok state + attempts log. No subagents enabled; the physics checklist was applied directly
(no dedicated `physics-reviewer` report exists).

## Metrics
- Compile: PASSED — 0 errors; exactly 10 contracted `by sorry` warnings
  (L124/L128/L132/L140/L154/L180/L287/L302/L321/L349). Same count before/after the refactor.
- Review verdicts: **1 passed / 0 failed** with the mandatory structured `formalization_review`;
  milestone `status: success`.
- Structured checks: source_faithfulness PASS · derivability PASS (all 3 conjuncts, conjunct 3 now
  with the hT12 cancellation) · abstraction_sufficiency PASS · uncertainty_propagation PASS ·
  branch_orientation N/A (scalar isochoric process) · countermodel_resistance PASS (session_6
  degenerate instance structurally excluded).
- Bridge obligations: 6 covered / 0 blocked (session_6's blocked uncertainty bridge flips to covered).
- Doctor: injected 19 `missing-physlib-import` findings = the stale iter-003 snapshot (6th iter,
  retired per iters-004..007 live reruns returning 0 findings); **4_A_5 not flagged** (positive
  targeted-import case). 0 orphans, 0 broken/malformed refs, 0 axioms, 0 covers problems,
  `physics_grounding_problems = []`.
- sync_leanok: iter=7, current-objectives, targets_checked=[4_A_5], added=0/removed=0 —
  deterministic non-action; no laundering.

## What happened on the target
The iter-007 O1 lane executed exactly the session_6 prescription: the refactor subagent added
`(hT12 : T₁ ≠ T₂)` to `IsochoricReadout` (after `T₂`, L228) plus one doc sentence (L218–L220);
diff +2/−1; no construction-site churn because `beta0_uncertainty_bound` and `main` take `readouts`
as a hypothesis. Verified on disk first-hand: field present, all theorem signatures and sorry sites
unchanged. The session_6 countermodel (T₁ = T₂ vacuous premise falsifying `|β₀ − 1/T₀| ≤ σ` for
arbitrary β₀) is no longer constructible. The closure algebra now runs: deviation reduces via
`measured_hP₁/measured_hP₂` to `P₀·(T₂−T₁)·(β₀ − 1/T₀)`, and the strictly positive factor
`P₀·|T₂−T₁|` cancels (`IsReferenceState.hP₀` + `hT12`). The blueprint chapter gained the iter-007
`% NOTE: Statement reconciliation` recording the field and the closure algebra. Answer discipline
re-audited: `1/T₀`, `0.0037`, `0.0034 ± 0.0007` remain strictly conclusion-side; `hT12` is a
data-interface non-degeneracy guard, disjoint from every conclusion value.

## Gate state after this review
- `4_A_5`: **passed at 2/3** holding a structured green certificate — re-reviewable next pass.
- `1_B_1`: unchanged (3 linarith errors L401/419/427; `review_exhausted`; prover-stage
  proof-Review redraft is the only reopen channel; frozen spec in iter/iter-005+006 objectives).
- `4_C_6`: 2/3, provenance-blocked (`raw/E1_solution.pdf` absent; quarantine-delete fallback at
  final attempt; TO_USER stands).
- 25 gate-enrolled clean targets: deterministic final review pass is their next consumer.

## Blockers surfaced
None on-target. Recurring systemic (non-statement) items, unchanged from iters 002–006:
- The deterministic physics-grounding preflight for 4_A_5 is again generic noise
  (`Path.target`/`semiformal_result`/`stereographic_target`, "None detected" for local
  abstractions) contradicted by the task report's real register — routed to loop-level repair;
  not re-counted as a statement blocker.
- The injected 19-finding doctor payload remains the iter-003 stale snapshot; needs a
  director/loop-side fix so future iterations stop re-injecting it.

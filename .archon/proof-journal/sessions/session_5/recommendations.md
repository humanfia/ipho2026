# Recommendations — session 5 (iter-005 review)

## 0. Endgame routing for `1_B_1` — CRITICAL decision for the next planner
The file is compile-broken (3 linarith errors, L401/L419/L427), holds a mathematically
FALSE lemma (`quadratic_pos_of_large`), and sits at reviews 3/3 (`review_exhausted`).
**Do NOT redispatch an autoformalize lane — it will be gate-dropped a third time.**
CONSIDERED and rejected: (a) gate-patch re-enroll-on-clean-compile (rule-gaming,
planner-side evidence as gate input); (b) reviewer hand-edit of the .lean (forbidden —
review agents never write proofs); (c) park silently (launders review debt).
**CHOSEN route: rely on the prover stage's proof-Review redraft/reopen.** The blocker
is statement-level (false premise), precisely the class that path resets. Plan the
prover-stage transition with 1_B_1 explicitly recorded as the pending redraft target;
its repair spec is fully written (iter-005 O1: restate as
`turningQuadratic r < 0` for `r >= k*e^2/(-E)`;
`hmul : k*e^2 <= r*(-E)` via `mul_le_mul_of_nonneg_right` + `div_mul_cancel₀`, then
`q <= r*(E*r + k*e^2) < 0` with `hL`; the consumer `attainedSeparations_lt_energy_threshold`
still closes by flipped-sign linarith). If the loop's plausibility path never fires, the
iter-005 TO_USER notice already discloses the residual (5 sorries, compiles-only-after-fix).

## 1. Retire the stale injected doctor snapshot — loop hygiene (4th iter)
`logs/iter-005/blueprint-doctor.json` (= the injected prompt content) lists 19 stale
`missing-physlib-import` entries, incl.: `1_A_1, 1_B_1, 1_B_2, 1_C_1, 2_A_1, 2_B_1,
2_B_2, 2_B_3, 2_C_1, 2_C_2, 2_C_4, 3_A_1, 3_B_1, 3_C_2, 3_C_3, 3_C_4, 3_C_5,
4_A_1, 4_B_4` — all carry exemption/reconciliation NOTEs (28/28 chapters).
Reviewer live re-run: **0 findings**. Next planner: treat any iter-006-injected
copies of this list as stale; do NOT route per-file actions from it. The durable
memory rule holds: re-run `archon blueprint-doctor` (source `science-mango/run_env.sh`)
before trusting any injected doctor report.

## 2. Final review pass for the 26 gate-enrolled targets (next phase)
Gate: 26 retry entries (14 at 1/3 incl. `4_C_6` at 2/3; 11 eager at 0/3).
The live doctor is clean, so the deterministic final pass can audit them from gate
state. `4_C_6` specifics: all six structured checks passed at session_4; its two
fail-carriers (noise-only deterministic grounding log; `raw/E1_solution.pdf`
provenance unverifiable from this checkout) are non-statement and unchanged this iter —
its final attempt still needs on-disk microdata evidence (PDF restored, reports
extraction, or planner provenance NOTE) or the verdict stands failed per the
session_4 route (revert to quarantine-delete as fallback).

## 3. Bookkeeping queued for iter-006+ (non-gating)
- Helper-blueprint transcription (472-entry debt) + umbrella-node `\lean{}`/`\uses{}`
  pinning — planner-side tex work, deliberately deferred; zero gate force.
- Axiom sweep harness defect: it compiles stale iter-002 snapshots; route to loop
  repair (sweep current files only).
- 2_C_3: `limitingIntersectionCoordinates` now marker-free (sync-correct); the 2
  sorries are prover-stage content, no autoformalize action.
- 4_A_5 benign unterminated tail comment rides to next touch (known-minor).

## 4. TO_USER state
Iter-005 notice already posted and remains accurate: 27/28 clean by-sorry; doctor
clean; `4_C_6` defect closed pending provenance verification; `1_B_1` endgame
disclosed. Open user asks: confirm pinning/upstreaming the Archon doctor exemption
patch; verify or restore `raw/E1_solution.pdf`.

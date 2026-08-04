# Recommendations — session 9 (iter-009 deterministic review re-pass)

## R1 (GATE, for the planner): write the iter-009 verdicts into the review ledger
16 lanes passed this pass and should be marked `passed` at their next gate ordinals:
- Final third review (2/3 → passed): `1_B_2`, `1_C_1`, `2_A_1`, `2_B_1`, `2_C_2`,
  `2_C_4`, `3_A_1`, `3_B_1`, `3_C_2`, `3_C_3` (recorded-stale re-registry), `3_C_4`.
- Second review (1/3 → passed): `2_B_2` (post-repair re-pass — session-8 R1 landed),
  `2_B_3`, `3_C_5`, `4_A_1`, `4_B_4`.
- `4_C_6`: **failed, reviews exhausted (3/3)** — permanently block from prover dispatch
  per the gate rule; keep the ledger reason of record (provenance blocker class).
Gate state after write: 25 passed + `4_C_6` review-exhausted-provenance + `1_B_1`
review_exhausted = the convergence end-state session-8 R7 defined. Stage advance to
prover is now unblocked **under the recorded caveat** that `4_C_6` is closed as
provenance-pending/exhausted and `1_B_1` as the documented residual — neither as passes.

## R2 (BLOCKER, TO_USER — standing, sharpened): `4_C_6` provenance
The third and final review confirms the statements are faithful-by-design and compile
clean (4 contracted sorries), and the uncertainty propagation contract is first-class —
but the sample microdata (`a = (2.28 ± 0.06)·10⁻³ 1/s`, `m = (89 ± 1) g`, `c₀ = 4186`
exact) remain **reviewer-unverifiable in this checkout** (`raw/E1_solution.pdf` absent,
find-verified iters 007 + 009; `sources.json` records only the final band `1.17 ± 0.03` K/W).
The gate is exhausted; routes, in preference order:
1. User restores `raw/E1_solution.pdf` (or any independent extraction of the C.6 sample
   run) ⇒ planner provenance NOTE ⇒ one fresh review re-opens the lane out-of-band.
2. No provenance next iter ⇒ dispatch the **quarantine-delete lane** (iter-004 fallback):
   excise `official_sample_value` + `official_sample_uncertainty` (and their chapter
   entries) or the whole file, so the prover stage does not inherit an unverifiable
   citation inside a conclusion-side theorem.
Do NOT weaken the target statements to buy a pass — the defect is provenance, not form.

## R3 (planner audit, standing from session-8): pre-correction factor across `3_C_2/3_C_4/3_C_5`
Session-8 noted these files encode the pre-correction B.1 `/(2·T)` heat law (+ mirrored
geometry). Non-blocking for every pass so far (internal identities factor-insensitive),
and iter-009 re-registry of `3_C_3` does not change that — but the prover stage will
consume these statements against the B.1-corrected law. Action: one planner-side audit
pass (no lanes) comparing the `3_C_x` encoded heat law against the settled `3_B_1`
contract; if the factor mismatch is real, schedule one statement-repair lane per file
BEFORE prover dispatch touches them.

## R4 (hygiene, cheap durable fix): stop the stale `missing-physlib-import` re-injection
The 18-finding stale snapshot has now been retired in 8 consecutive reviews
(sessions 2–9). Every retirement burns review attention and risks a future reviewer
misreading it as live. The chapters all carry the exemption NOTEs (verified). Fix the
injector (doctor snapshot source) to re-base on the live doctor output, or add the
snapshot's 18 files to a permanent suppress-list keyed by the presence of the chapter
import-policy NOTE.

## R5 (note for prover stage, no action): sorry surface handed over
Sorry inventory after this pass (contracted bodies, all statement-audited):
`1_B_2`(7), `1_C_1`(6), `2_A_1`(5), `2_B_2`(5), `2_B_3`(4), `2_C_2`(3), `2_C_4`(1),
`3_A_1`(6), `3_B_1`(3), `3_C_2`(10), `3_C_4`(8), `3_C_5`(2), `4_B_4`(2), `4_A_1`(0),
`2_B_1`(0), `3_C_3`(0). The bridge obligations in session_9/milestones.jsonl localize
exactly what each sorried body must supply — use them as the prover dispatch specs.
`1_B_1` re-entry: frozen redraft spec (iter-005/006 objectives); proof-Review reopen only.

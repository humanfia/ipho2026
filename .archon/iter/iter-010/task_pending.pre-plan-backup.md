# Index
<!-- One line per file. Update line numbers when the file changes. -->

## Iter-008 ground truth (planner audit this iter — fresh runs)
- 27/28 compile by-sorry; sole exception `1_B_1` (fresh `lake env lean` this iter: same 3 linarith errors L401/419/427 + 5 contracted sorries). Chapters this iter touched are tex-only — all 17 ledger-edited Lean files re-run post-dispatch: 0 errors each.
- Gate ledger (unchanged this iter — NO review pass ran): `4_A_5` PASSED (2/3, all-six-green); 14 retry at 1/3 `1_A_1, 1_B_2, 1_C_1, 1_C_2, 2_A_1, 2_B_1, 2_C_1, 2_C_2, 2_C_4, 3_A_1, 3_A_2, 3_B_1, 3_C_2, 3_C_3, 3_C_4`; 11 retry at 0/3 `2_B_2, 2_B_3, 2_C_3, 3_A_3, 3_B_2, 3_C_5, 4_A_1, 4_B_4, 4_B_6, 4_C_7`; `4_C_6` at 2/3 provenance-blocked (`raw/E1_solution.pdf` absent, find-verified iter-007); `1_B_1` `review_exhausted` (4 entries).
- Live `archon blueprint-doctor` (venv, patched upstream): **clean** at phase end — iter-008 transient findings created-and-fixed this phase: bare-label in `2_C_3` (→`\cref`), `\textunderscore` typo in `3_B_1` (→ plain). The injected 19 `missing-physlib-import` findings = iter-003 stale snapshot, 7th iter; formally retired; exemption NOTEs verified all 28 chapters iter-008.
- `1_B_1`: NO autoformalize redispatch (would be 4th gate-drop; session_6 R3 durable). Reopen via prover-stage proof-Review redraft ONLY; frozen spec iter/iter-005 O1 (`q<0` true restatement) + iter/iter-006 O2 consumer decision tree; TO_USER iters 005/007 stands. Its 5 sorries are the accepted autoformalize residual if reopen never fires.

## Coverage debt — CLEARED to the design floor iter-008 (472 → 363 → 33)
- Iter-008 dispatched 14 blueprint-writer lanes (4 waves; all COMPLETE; directives + reports `logs/iter-008/`, mirrors `task_results/blueprint-writer-*.md`): `3_C_4`(22) `3_C_5`(12) `4_C_7`(8) `3_B_1`(15) `1_C_1`(17) `2_B_2`(18) `4_A_1`(15+2proj) `3_C_2`(25..31) `2_B_1`(15) `3_B_2`(11) `4_B_4`(11) `3_A_2`(8) `2_C_4`(7) `2_C_1`(5) `2_C_2`(5) `2_A_1`(6) `2_B_3`(10 root-level; scan-invisible `noncomputable def` pins documented in-chapter, same convention as 1_B_2 opaques).
- `dag-query unmatched` end-state: **33** = `1_B_1` (32, deferred to prover-stage reopen — batch must reflect redraft end-state; writing it now would pin the FALSE `quadratic_pos_of_large` into tex) + `hello` (1, `IPhO2026Run/Basic.lean` scaffolding; entry-or-`private` decision at polish/refactor — outside every covered file).
- `dag-query gaps` (∞-effort): **0**. `needs-lean`: 28 = only the umbrella `thm:physics:*:target` nodes (by design: umbrellas receive their `\lean{}` pin when the prover stage names each file's main theorem the pinned one). Isolated umbrellas: **1** (`1_B_1`, by design). 7 benign isolated non-umbrella entries recorded (scan-invisible pins; cosmetic only — objectives.md).
- Umbrella `\uses{}` wiring complete for ALL 27 settled chapters (batches 1–3's owed wiring landed iter-008: 3_C_3, 4_C_6, 4_B_6, 3_A_1, 1_B_2 + all iter-008 writers wired theirs; 4_A_5 wired by its writer to `main`).
- Iter-008 pin-repair lesson (now in ARCHON_MEMORY): writers self-verify against STALE graphs and emit renderer-escaped `\_` in `\lean{}`/`\uses{}`; planner MUST rebuild (`leandag build`) + re-query after every writer wave, then strip `\_` in pins (7 chapters) and repoint namespaces (2_B_2→`IPhO2026_2_B_2.*`, 4_A_1→`ConfinedAirColumn.*`) as needed.

## Awaiting next review pass (deterministic; statements static; doctor clean 7 iters)
- The 26-lane queue above. Nothing pending anywhere: no statement change, no compile error, no arithmetic defect open. Expected convergent pass barring genuinely new findings; 4_C_6 remains the lone designed exception (provenance gate).

## Known-minor (scheduled with next touch, not worth a lane)
- 2 unused-variable linter warnings on `1_C_2`; 2 deprecated `push_neg` warnings on `1_B_1` (fix inside its prover-stage reopen lane, optional).
- Stale `\leanok` on `thm:physics:IPhO_2026_1_B_1:target` (annotated `% STALE-LEANOK iter-001`): deterministic sync owns removal.

## Planner debt (post-iter-008)
- NONE open on blueprint coverage. Remaining scheduled items: (a) `1_B_1` batch at its reopen; (b) `hello` entry-or-private at polish; (c) 26 scan-invisible-pin warnings stay documented in-chapter (no action); (d) optional cosmetic wiring of the 7 benign isolated nodes at prover stage.
- Escalations pending (unchanged since iter-003): user to confirm upstream Archon doctor-patch pinning (venv editable install; TO_USER iters 003/005/007/008). Loop-side: session_7 R5 (grounding preflight generic noise log) + R6 (stale 19-finding re-injection, now 7 iters).
- **Standing rule (iter-008 incident)**: `task_results/physics-grounding-*.md` are loop-consumed registers — NEVER batch-delete on collect; the 28 registers were reconstructed from audit streams after a pruning slip transiently tripped 28 doctor findings (repaired in-phase, doctor clean).

## Resolved recently (iter-008)
- Orphan mid-run `4-a-5-entries` dispatch joined via blocking re-issue; COMPLETE 331 s cleanly (see iter/iter-008/plan.md auto-execution record).
- 14 writer waves landed; graph hygiene repaired; `dag-query unmatched` 363 → 33 with the 33 fully accounted.
- `leandag build` statistics at phase end: 420 blueprint declarations, 343 proof blocks, 496 Lean decls scanned, 26 unmatched-`\lean{}` warnings (documented scan-invisible opaques/projections).

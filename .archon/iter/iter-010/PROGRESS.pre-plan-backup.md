# Project Progress

## Current Stage

autoformalize

## Stages
- [x] init
- [ ] autoformalize — 27/28 compile clean by-sorry (iter-009 fresh `lake env lean` re-runs on all files touched this iter). Sole compile blocker: `1_B_1` (unchanged 3 linarith errors L401/419/427; gate `review_exhausted` ×4 — no autoformalize redispatch; reopen via prover-stage proof-Review redraft, frozen spec iter/iter-005+006 objectives; TO_USER stands). Gate ledger after the iter-008 deterministic pass: **8 passed** (`4_A_5` iter-007; `1_A_1`, `1_C_2`, `2_C_3`, `3_A_2`, `3_A_3`, `3_B_2`, `4_B_6`, `4_C_7` iter-008), **17 retry** (`1_B_2 2/3`, `1_C_1 2/3`, `2_A_1 2/3`, `2_B_1 2/3`, `2_C_2 2/3`, `2_C_4 2/3`, `3_A_1 2/3`, `3_B_1 2/3`, `3_C_2 2/3`, `3_C_3 2/3`, `3_C_4 2/3` recorded-stale; `2_B_3 1/3`, `3_C_5 1/3`, `4_A_1 1/3`, `4_B_4 1/3`, and `2_B_2 1/3` **repair LANDED iter-009** — see Current Objectives), `4_C_6` 2/3 provenance-blocked (`raw/E1_solution.pdf` absent, find-verified iter-007 — TO_USER stands), `1_B_1` exhausted. Blueprint coverage at the design floor iter-009 (fresh `leandag build`: `unmatched` **33** = `1_B_1` 32 deferred + `hello` 1; `gaps` ∞-holes 0; umbrellas wired 27/27). Doctor: live rerun clean (0 findings) at iter-009 phase end; the 18 injected `missing-physlib-import` findings are the iter-003 stale snapshot (8th iter), formally retired (exemption NOTEs present; the 2_B_2 chapter's exemption NOTE was restored with its ledger this iter). Stage advance to prover belongs to the REVIEW phase after the 17-lane pass converges (session-8 R7): on convergence the gate closes autoformalize at 27 passes + `1_B_1` documented-residual + `4_C_6` provenance-pending.
- [ ] prover
- [ ] polish

## Current Objectives

- **`IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`** — Redraft after failed formalization Review (2/3 used). [prover-mode: physics-formalize]
- **`IPhO2026Problems/problem_IPhO_2026_2_B_3.lean`** — Redraft after failed formalization Review (2/3 used). [prover-mode: physics-formalize]
- **`IPhO2026Problems/problem_IPhO_2026_2_C_1.lean`** — Redraft after failed formalization Review (1/3 used). [prover-mode: physics-formalize]
- **`IPhO2026Problems/problem_IPhO_2026_3_C_5.lean`** — Redraft after failed formalization Review (2/3 used). [prover-mode: physics-formalize]
- **`IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`** — Redraft after failed formalization Review (2/3 used). [prover-mode: physics-formalize]
- **`IPhO2026Problems/problem_IPhO_2026_4_B_4.lean`** — Redraft after failed formalization Review (2/3 used). [prover-mode: physics-formalize]

## Iter-009 landed work (this phase — full record in iter/iter-009/plan.md + objectives.md)

- **INCIDENT repaired planner-side**: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_2.tex` was found truncated back to its 51-line iter-002 skeleton (entire 295-line iter-008 ledger lost; root cause unknown — possibly the `git checkout` recovery attempt of this iter's first edit script. Recovered planner-side from the iter-008 writer report + pre-incident content captured earlier this session: skeleton verbatim + umbrella `\uses{}` wiring + exemption NOTE + all 18 declaration blocks. Post-restore fresh `leandag build`: all 18 pins live, doctor clean.
- **T1 (session-8 R1 blocker) LANDED**: 2_B_2 aperture-coverage repair — tex first (reconciliation NOTE + strengthened clause (e) + `collectedWidth_eq_radius` proof block + `\uses{}` +`CookerParams`), then refactor subagent lane `2-b-2-aperture-coverage` (108 s; enabled in `config.json` for the dispatch, reverted after per classic-loop setting). Fresh compile: 0 errors, 5 contracted sorries, zero line drift.
- **T2 (session-8 R2) LANDED**: `1_C_2` ledger restated to the redrafted declarations — new blocks `ThresholdBalance`, `LowerRootBranch`, `threshold_excess_enclosure` (thm), `mc2eV_trusted` + `_pos`/`_big`/`_num_form`, `thresholdBalance_to_ev_units`; the two C.2 target theorems' `\uses{}` rewired onto them (+`ThresholdRealizable`, `angular_factor_at_pi_div_six`, `hbarOmegaMin_at_pi_div_six`, `rest_energy_gap_nonneg`); upstream factor-2 C.1 formula finding recorded as a `% NOTE` (TO_USER-level).
- **T3 LANDED**: `3_C_3` readout anchors — stale "opaque supplied-data" blocks modernized (the Lean record is transparent `noncomputable` with literal values); unified projections/readout-values lemma block now pins the 6 `*_value` rfl lemmas + 6 projections + 6 positivity certificates; new `vacuumPermeability`/`vacuumPermeability_pos` anchor block. Post-wave `leandag build`: `unmatched` 49 → **33** (design floor: `1_B_1` 32 + `hello` 1), `gaps` 0, doctor clean.
- **Collected `task_results/`** (24 reviewed iter-008 prover-verify reports + this iter's refactor report, mirrored in `logs/iter-008`/`iter-009`); the 28 loop-consumed `physics-grounding-*.md` registers preserved per standing rule.

## Review gate queue (17/28 — deterministic review re-pass is their next consumer; NO further redraft dispatch)

Enrolled in `.archon/formalization-review-gate.json`: 12 retry (11 recorded-stale 2/3 + `2_B_2` 1/3 with its repair landed iter-009 — next pass counts). PASSED already (8): `4_A_5` (iter-007), `1_A_1`, `1_C_2`, `2_C_3`, `3_A_2`, `3_A_3`, `3_B_2`, `4_B_6`, `4_C_7` (iter-008) — out of the queue. `4_C_6` 2/3 provenance-blocked; `1_B_1` `review_exhausted` (4 entries). Session-8 record: the sole semantic failure of the last pass (`2_B_2`) is repaired; all 12 live lanes are doctor-clean (7 iters) ⇒ re-pass expected convergent-green barring genuinely new findings; `4_C_6` remains the designed exception. On convergence autoformalize closes at 27 passes + `1_B_1` documented-residual + `4_C_6` provenance-pending and the loop advances to prover. The PROVER stage inherits (STRATEGY.md risk cell): frozen `1_B_1` repair spec (iter/iter-005 O1 true-`q<0` restatement + iter/iter-006 O2 decision tree), session-8 R4 `1_A_1` hinge-field hygiene, `hello` entry-or-`private` decision, and all contracted sorries as its work queue.

## Clean by-sorry (planner audit iter-009 — 27/28)

All non-`1_B_1` files compile 0 errors under fresh `lake env lean` (2_B_2, 1_C_2, 3_C_3 re-run this iter post-landing; the rest per the iter-008 25/25 preflight + 4_A_5 iter-007 gate). Sorry counts unchanged from iter-008 audit (`1_A_1` 10, `1_B_2` 5, `1_C_1` 6, `2_A_1` 5, `2_B_1` 4, `2_B_2` 5, `2_B_3` 4, `2_C_1` 4, `2_C_2` 3, `2_C_3` 1, `2_C_4` 1, `3_A_1` 6, `3_A_2` 2, `3_A_3` 5, `3_B_1` 3, `3_B_2` 3, `3_C_2` 10, `3_C_3` 8, `3_C_4` 8, `3_C_5` 2, `4_A_1` 8, `4_A_5` 10, `4_B_4` 2, `4_B_6` 5, `4_C_6` 4, `4_C_7` 2; `1_C_2`/`2_B_1`/`3_C_3` sorry-free… see review pass record — `1_C_2` counted 2 pos-linter warnings only). Remaining broken: `1_B_1` only.

## Bookkeeping owed (in flight, planner-side)

- Coverage-debt transcription **at the design floor (33)**; iter-009 cleared the residuals the review surfaced (1_C_2 redraft decls 8 + 3_C_3 steppers 8). Residual 33 = `1_B_1` (32 — deferred to its prover-stage reopen so the batch reflects the redraft end-state) + `hello` (1 — scaffolding; polish-stage decision). `needs-lean`: 28 umbrellas only (design state).
- Stale-doctor-payload + grounding-preflight escalations (iter-003 onward, session-7/8 R5-R6): unchanged; user confirmation of the venv doctor-patch pinning stands.
- **Iter-009 chapter-truncation incident**: 2_B_2 chapter found reverted to skeleton at phase start. Restored fully (see above); the dashboard/DAG never saw the gap because the incident pre-dated this iter's first `leandag build`. Recorded in iter/iter-009/plan.md; if it recurs on another chapter, audit `git` reflog/checkout automation.

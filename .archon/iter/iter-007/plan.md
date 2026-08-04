# Plan — iter 007 (autoformalize endgame: 1 statement-repair lane + planner bookkeeping wave 1)

## User-silent fallback executed
No prior-iter `## Fallback if no user response` section; no user hints. Proceeded normally.

## State found (planner re-audit this iter, fresh runs)
- Live `archon blueprint-doctor` (science-mango venv, patched upstream): **clean, 0 findings** on all 28 chapters — the 19 injected `missing-physlib-import` findings are the iter-003 stale snapshot, 5th iter; formally retired again, no per-file action.
- `4_A_5` re-run (`lake env lean`, 8.8 s): **0 errors, 10 sorry warnings** (L122/127/131/136/150/174/259/289/306/326) — O1 comment-syntax repair landed iter-006; compile blocker CLOSED on disk.
- `1_B_1` re-run: **unchanged-broken** — same 3 `linarith` errors L401/419/427 in `quadratic_pos_of_large` (+2 deprecated `push_neg` warnings, trivial). Disk untouched since iter-003; iter-004/005/006 repair lanes all gate-dropped (`review_exhausted`).
- Session_6 review: `4_A_5` gate 0/3→1/3, sole semantic blocker = NEW countermodel: `IsochoricReadout` lacks `T₁ ≠ T₂` guard ⇒ uncertainty conjunct FALSE as stated at the degenerate instance. Repair = one structure field `hT12 : T₁ ≠ T₂` (free: no construction sites; consumers take `readouts` as hypothesis). Five other structured checks PASS.
- Fallback audit carried in session_6 R4 (readout-degeneracy pattern): `4_C_6` already guarded (`x_varies` L314, `t₀ ≠ t₁` L215); `4_C_7` guarded (`hΔT : D.T_IC < D.T_OC` L179); `3_C_x` carriers use ≠-guarded product/ratio forms (L418, L275, L315). No other instance of the defect class.

## Decision made
- **Dispatch exactly 1 lane this iter: `4_A_5` statement repair via `refactor` subagent** (blocking call, directive at `logs/iter-007/refactor-4-a-5-iso-readout-directive.md`). Chosen over: (a) planner-direct edit — boundary (no .lean writes); (b) redispatching the full 26-lane review queue for cosmetic PROGRESS churn — no statement change pending on them, deterministic review pass is their correct next consumer. Session_6 R1 specifies the field, the doc sentence, and the post-repair provability algebra; routing via the review-retry machinery (1/3 → re-review).
- **`1_B_1`: do NOT redispatch** (4th gate-drop is certain). Session_6 R3 (durable): re-entry only via prover-stage proof-Review redraft-reopen; frozen repair spec lives in iter/iter-005+006 objectives. PROVER stage approach recorded in STRATEGY.md risk cell. TO_USER iter-005 stands.
- **`4_C_6` final attempt (2/3): record blocking-evidence search this iter**: `references/` holds only `summary.md`; no `raw/E1_solution.pdf` exists anywhere in this checkout (find-verified). Review route stands: re-review once provenance is on disk in a later iter (user may place the PDF — surfaced on TO_USER), else the gate's documented fallback is the quarantine-delete lane. Not dispatched — the search result is new evidence for the record, not a found file.
- **Coverage-debt transcription STARTS planner-side this iter** (chapter edits are mine, not a lane): batch 1 = the two largest settled buckets, `3_C_3` (42) + `4_C_6` (31), after the refactor verdict so 4_A_5's signature settles before its own batch (15 turns 16 with `hT12`). Order by iter-006 bucket sizes; `\uses{}` from the prover task_results "Needs blueprint entry" lists + first-hand dependency reads.
- **Pre-review cheap grep (session_6 R4 trap-2)**: verify no `+/-` survives in any physics file's comments before the 26-target review pass fires; `/-!`-before-`import` already known-clean (26 files compile). Record verdict in objectives/task_pending.

## Iter-007 outputs (end-of-phase record)
- O1 LANDED: `refactor` subagent (`4-a-5-iso-readout-hT12`, 101 s; enabled it in `config.json` for the dispatch, reverted after per the project's classic-loop setting). `hT12 : T₁ ≠ T₂` added to `IsochoricReadout` (L226) + doc sentence; diff +2/−1; verified `lake env lean` 0 errors + exactly 10 contracted sorries.
- Coverage-debt batch 1 LANDED: `3_C_3` (42) + `4_C_6` (31) transcribed with family-grouping (multi-`\lean{}` entries); both `dag-query unmatched` buckets verified at 0; doctor clean; 472 → 422.
- `4_A_5` chapter: iter-007 reconciliation NOTE added (field + closure algebra) before the refactor dispatch — blueprint precedes Lean confirmed.
- `4_C_6` provenance: `raw/E1_solution.pdf` find-verified ABSENT (`references/` = only `summary.md`); TO_USER iter-007 notice published.
- Audits: `+/-` grep clean project-wide; degeneracy-guard fallback audit clean (`4_C_6`/`4_C_7`/`3_C_x` all guarded).
- Gate trajectory: `4_A_5` re-reviews at 2/3 next phase with all 6 structured checks expected green (session_6 pre-verified the post-repair algebra); the 26-target queue's next consumer is the deterministic review pass.

## Addendum (late same-phase): coverage-debt batch 2 LANDED + leandag correction
- **Accurate per-part bucket sizes** (derivation root-caused: names like `IPhO2026.Problem1.B1.*`, `IPhO2026.Problem3.PartA1.*`, `IPhO2026.Problem4.*`+decl-scan disambiguation, `IPhO2026.T3A3.*` are all part-bucketable; earlier "91 dotted-suffix tails" figure was an under-derived artifact — only **11 true _raw** decls exist: 10 top-level names decl-file-verified in `2_B_3` (whose own namespaced bucket is 0-matched) + `hello` in `IPhO2026Run/Basic.lean`). Full 412-part map recorded in `task_pending.md`.
- **Batch 2 LANDED** (planner-side, tex-only): `IPhO2026.Problem4.*` (23 decls → `4_B_6` chapter, 7 entries) + `IPhO2026.Problem3.PartA1.*` (35 → `3_A_1` chapter, 13 entries incl. the 4-bridge derivation route + 2 target theorems with correct-of-9 `\uses{}` wiring signposted for the prover stage) +
Verified: `dag-query unmatched` **422 → 363**; live doctor **clean, 0 findings**.
- **Conventions confirmed**: (a) dots-to-text (`$(v_1)$`-style, `\mu_0`, no `\texttt` inside math) — doctor's LaTeX renderer forgives but stay renderer-safe (fixed one `\lnRatio/\invTdiff` slip in 4_B_6); (b) multi-`\lean{}` family entries stay honest: each named decl appears on its own `\lean{}` line; (c) umbrella `thm:physics:…:target` `\uses{}` wiring still owed per batch — flagged: 4_B_6's umbrella should additionally use the 5 target entries (its own main target sits outside `thm:…:target`'s sub-list; the graph adds it when the prover stage's `\uses{}`-wiring pass runs — recorded as planner debt).

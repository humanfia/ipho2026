# Plan — iter 006 (autoformalize endgame closeout: 2 repair lanes)

## User-silent fallback executed
No prior-iter `## Fallback if no user response` section exists; no user hints this iteration. Proceeded normally.

## State found (planner re-audit, not trusting prior claims)
- **26/28 compile by-sorry, 2 broken.** Re-ran `lake env lean` on all 27 non-`1_B_1` files this iter (233 s total): `4_A_5` FAILS with `unterminated comment` at L351 (the iter-002-era "benign tail" note is stale) — the swallowed tail is the real `beta0_uncertainty_bound` theorem (~26 documented lines: uncertainty propagation `|β₀ − 1/T₀| ≤ σ`, the A.5 official-band content `β₀ = 0.0034 ± 0.0007 K⁻¹`) plus both `end` lines; stripped-comment view confirms `beta0_eq_ideal_of_linear` is intact, so only the last component + terminators are missing. All other 26 files: 0 errors.
- **`1_B_1` unchanged-broken**: same 3 `linarith` errors at L401/L419/L427 in `quadratic_pos_of_large`; iter-005 lane gate-dropped (`review_exhausted`), disk untouched.
- **Injected 19 `missing-physlib-import` findings = same stale iter-003 snapshot, 4th iter.** Live `archon blueprint-doctor` (science-mango venv, patched upstream): **"clean — no structural or rendering findings"** on all 28 chapters. Formally retired again, no action.
- **Coverage debt (472) re-quantified**: `archon dag-query unmatched --json` → 381 decls cluster inside `IPhO2026.Problem*/IPhO2026_*` per-problem namespaces; 91 scan-visible suffix tails of longer dotted parents (e.g. `hello`=`IPhO2026Run/Basic.lean`, `CrossSectionPlane`, `thetaMaxRecorded`, `SolarCookerGeometry`).

## Decision made
- **2 objective lanes this iter (dual endgame; alternate would leave one compile error masking the stage gate).** O1 = `4_A_5` comment-terminator repair (NEW compile defect; reviews 0/3, dispatchable). O2 = `1_B_1` proof-body repair dispatched verbatim iter-005 O1 (gate-exhausted; expected gate-drop recorded on the directive so the repair spec survives for proof-Review reopen in prover stage). Rejected alternatives: (a) reorder (1_B_1 first) — its lane is a known no-op, the exempt-rule already covers it, giving the new defect the exempt-filter benefit is better use of the slot; (b) planner-direct fix of `4_A_5` — boundary (no .lean edits), and the recovered theorem text must be re-anchored against the PDF source by the lane, not guessed by the planner; (c) redispatch the 26-lane review queue — no statement changes pending; deterministic review pass audits them from gate state next phase (doctor clean ⇒ expected convergent pass).
- **`4_A_5` repair scope: restore exactly what the terminator swallowed, no rewrite.** The on-disk theorem prose, hypotheses, and bound (`|β₀ − 1/T₀| ≤ σ` with deviation carrier `≤ P₀|ΔT|σ`, band `3.4e-3 ± 7e-4` covering `1/273.15 ≈ 3.66e-3`) are iter-001-review-clean; re-anchor against `references/` / `reports/.../4_A_5.source.json` before restoring; change surface = insert `-/` + restore tail; 11 sorry sites preserved (4_A_5 counts: file holds 11 `sorry` bodies incl. `main`); gate = 0 errors + only the contracted sorries.
- **Coverage-debt transcription stays planner-side batched (iter-006 wave starts post-lane).** 472-debt is tex-only bookkeeping on settled decl sets; routing it while 2 files are compile-broken would dispatch blueprint churn against possibly-moving signatures. Batch order (largest first, confirmed by namespace bucketing): P3_C3 (42), P1_B1+P1_B2 (32 each), P4_C6 (31), P1_A1 (28), P3_C2 (25)… Each per-problem batch = one `\begin{lemma}…\label{}\lean{}\uses{}` + 1-line proof block family in that part's chapter; umbrella `thm:…:target` `\uses{}` wiring once per batch. Scaffolding leftovers (`hello` = `IPhO2026Run/Basic.lean`) get a one-line tex entry or `private` marking decision at refactor next phase.
- **No STRATEGY.md edit** — phase table already describes the ACTIVE gate row; iter-006 narrows the risk cell language only if both lanes land (deferred to iter-007 after compile evidence).

## Notification actions
- `TO_USER.md` NOT touched this iter (the 1_B_1 endgame + 4_C_6 provenance items from iter-005 stand; no new user-facing decision).
- `USER_HINTS.md` expected to receive the `1_B_1` gate-drop notice from plan-validate (mechanical, non-fatal).

## Cheapest reversal signals
- If `4_A_5`'s lane reports the swallowed tail was MORE than `beta0_uncertainty_bound` + ends (i.e. disk drift beyond the documented state), repair becomes audit-the-restoremode against `reports/.../4_A_5.source.json` + iter-001 review journal.
- If the deterministic review pass on the 26-queue surfaces a REAL finding (not noise/stale), it re-enters objectives iter-007; else autoformalize completes at 27/28 with `1_B_1` carried to prover-stage proof-Review.

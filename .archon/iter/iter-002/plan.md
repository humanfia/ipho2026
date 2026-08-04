# Plan — iter 002 (autoformalize, wave 3/3 repair wave)

## User-silent fallback executed
No prior-iter `## Fallback if no user response` section exists; no user hints this iteration. Proceeded normally.

## State found
- **All 28/28 files exist on disk** (wave-2 task_results landed for the 6 iter-001 objectives and agree with disk). The 28 umbrella blueprint nodes are all "ready" in leandag but that only means chapters exist — planner audited reality directly.
- **Full-file audit (`lake env lean` × 28, run by planner this iter):**
  - 15 clean by-sorry (0 errors): `2_A_1, 2_B_1, 2_B_2, 2_B_3, 2_C_1, 2_C_2, 2_C_3, 3_A_3, 3_B_2, 3_C_4, 3_C_5, 4_A_1, 4_B_4, 4_B_6, 4_C_7`.
  - 1 benign-end defect: `4_A_5` unterminated `/-` at L~351 (error-free because the tail is pure comment).
  - **8 ERROR files** (wave-1 outputs the wave-1 spot-check misjudged clean): `1_C_1` (parse: `where`-in-field, placeholder identifiers), `1_C_2` (one unsolved-goals bridge, field-level), `2_C_4` + tail of `3_A_1` (dot-notation on function), `3_A_1` (47 errors: synthInstance/unsolved goals/invalidField), `3_A_2` (`Real.pi` unknown under lone Physlib import + stray `where`), `3_B_1` (bound-var application mismatch), `3_C_2` (`$$` in doc-comment), `4_C_6` (parse cascade from Physlib-units syntax).
  - **2 stubs confirmed**: `1_B_2` (42-line doc-only, 0 decls), `3_C_3` (garbaged scratch `#eval`s, 32 lines).
  - **1 redraft per iter-001 review**: `1_B_1` (compiles but vacuous `radial_energy` + answer-valued hypotheses).

## Decision made
- **Import-policy contradiction — resolved by exemption NOTEs, keeping the file rule.** Options: (a) add a cosmetic Physlib import to every file to appease the doctor — rejected: irrelevant imports violate faithfulness and the memory/PROJECT_STATUS "self-contained, import Mathlib baseline" invariant; (b) edit `domain_profile.target_import_prefixes`/config — rejected: planner writing loop config to silence its own checker is rule-gaming, and the user owns config; (c) chosen: per-chapter `% NOTE:` PhysLean-coverage exemptions citing each file's physics-grounding (LeanExplore near-miss) log, per iter-001's reconciled ruling (already recorded in PROJECT_STATUS.md: targeted import where a real module exists — the 4_C_6/4_C_7 pattern — otherwise documented exemption). 16 Mathlib-only chapters got NOTEs; the 6 repair-wave files pick up NOTEs when their lanes land (their domains are the same near-miss set). Cheapest reversal signal: blueprint-doctor next-iter still flags `missing-physlib-import` despite the NOTEs ⇒ escalate to TO_USER and re-examine.
- **Repair over defer for the 8 error files.** The plan-validate hard gate drops compile-failing objectives from OTHER iters' lanes; leaving them means the review gate can never pass them and the stage never advances. All 8 defects are mechanical (parse/notation/instance-level), cheap to fix inside the autoformalize mode that owns statement editing anyway. `1_B_1` and the 2 stubs join the same wave ⇒ 11 lanes, well under `max_parallel = 28`.
- **`1_B_1` redraft scope**: preserve the audited-honest algebra certificates (`certified_factorization`, `turning_root_cases`) and the structure/law-field idiom; only the vacuous law and the two answer-valued hypotheses are replaced (lane directive spells out the replacement options). Stale `\leanok` left to the deterministic sync (planner must not touch markers; flagged in the lane so the review agent can judge).
- **`3_A_1` two mandates in one lane**: the file is broken (47 errors) AND carries the doctor's `scalar-fallback`. One lane fixes both: typed `Current` model (PhysLean-units-style amount+dimension, documented scalar projection) + the error cascade. Splitting would force two passes over the same heavily-coupled decl set.
- **Helper-debt transcription deferred one more iter** (359 decls): the repair wave is precisely the set of files whose decl sets are still churning; writing ~359 entries now would fabricate edges against moving targets (same call as iter-001, now transiting). Scheduled: batch per problem part starting next iter against the settled post-repair decl sets; `dag-query unmatched` keeps the ledger. Deliberate deferral, not silent carry-over.
- **Frontier NOT dispatched to provers**: all 27 "ready" nodes are umbrella autoformalize targets with `sorry` bodies by design; the stage gate is autoformalize→review, not proof. No prover dispatch while the formalization review gate is unsatisfied (and 11 files don't even typecheck).

## Progress
- Annotated `1_B_1`'s chapter `\leanok` with a `% STALE-LEANOK` caveat comment (marker text untouched — the deterministic sync owns removal; the review agent sees the caveat without a planner marker edit).
- Read role/prompt/state; adjudicated wave-2 task_results (all six cleared from `task_results/` into `logs/iter-001/task_results-archive/`).
- Ran the first FULL per-file compile audit (28/28) — replacing wave-1's 20-file spot-check that let 8 error files masquerade as clean.
- PROGRESS.md rewritten: 11 repair objectives with file-specific, diagnostic-level directives; review-retry queue (5) and clean-15 recorded; `4_A_5` tail-comment flagged as known-minor.
- 16 blueprint chapters: appended `% NOTE:` PhysLean-coverage exemptions (planner-owned prose; no markers touched).
- task_pending.md / task_done.md / STRATEGY.md updated to the audited state (wave 2 marked completed; wave 3 = repair wave ACTIVE).

## Objectives (wave 3 — see PROGRESS.md `## Current Objectives` for full directives)
11 `physics-formalize` lanes: `1_B_1` (redraft), `1_B_2` (from-stub), `1_C_1`, `1_C_2`, `2_C_4`, `3_A_1` (repair+typed current), `3_A_2`, `3_B_1`, `3_C_2`, `3_C_3` (from-scratch), `4_C_6`. Mode rationale: stage is autoformalize; files carry `% archon:physics` chapters; lanes must create/repair compiling statements with `sorry` bodies — exactly `physics-formalize` (the default `formalize` also resolves to it, tags kept for clarity).

## Risks / notes
- Repair lanes are surgical; risk is a lane "fixing" a file by weakening physics content — every directive names the physical contract to preserve and repeats "answer conclusion-side only; sorries stay `by sorry`".
- If the next blueprint-doctor run still reports the 16 exempted files as `missing-physlib-import`, the NOTE mechanism isn't honored by the deterministic checker ⇒ escalate via TO_USER.md and consider a config-level allowlist with the user.
- Next iter: transcribe helper blueprint entries per problem-part batch (start with the clean-15 whose decl sets are stable), fix `4_A_5` terminator with its next touch, then the review gate over the full 28.

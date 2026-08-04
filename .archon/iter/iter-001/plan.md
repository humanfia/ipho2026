# Plan — iter 001 (autoformalize, wave 2/2)

## User-silent fallback executed
No prior fallback section exists (first iteration); proceeded normally. No user hints this iteration.

## State found (mid-flight wave 1)
Iter 001 is the first autoformalize wave and it is **still running**: 28
`physics-formalize` prover lanes were dispatched by the previous plan agent
session ~40 min into this plan phase. A wave-1 snapshot check shows
**22/28 files already on disk and compiling** (all independent, `import Mathlib`
only, 86 `sorry` total): 1_B_2(partial/stub), 1_C_1, 1_C_2, 2_B_2, 2_B_3,
2_C_1, 2_C_3, 2_C_4, 3_A_1, 3_A_2, 3_A_3, 3_B_1, 3_B_2, 3_C_2, 3_C_3(stub),
3_C_5, 4_A_1, 4_A_5, 4_B_4, 4_B_6, 4_C_6, 4_C_7.
**6 files still missing** (lanes in flight): 1_A_1, 1_B_1, 2_A_1, 2_B_1,
2_C_2, 3_C_4. Orchestrator meta still labels several lanes `running`/`error`
— stale labels; the on-disk files are the ground truth and many `error` lanes
actually landed their file.

## Decision made
- **Two-wave autoformalize (chosen) vs cancelling in-flight work:** dispatch
  only the 6 missing files as wave 2, AFTER wave 1 returns its task_results
  (same iter). Repeating the 22 existing files as objectives would needlessly
  redo good work (deterministic engine may batch≤~10/iter; autoformalize stage
  needs no review gate) and rewriting over in-flight lanes risks clobbering
  them. Cheapest reversal signal: if wave-1 task_results report a file as
  failed/missing, re-add it next iter.
- **Lean→blueprint coverage debt (261 helper decls):** chapters currently hold
  only the umbrella `thm:physics:<part>:target` node with no `\lean{}` pin and
  no `\uses{}` (27 isolated blueprint nodes). Defer the full helper-entry
  transcription to **post-dispatch**: the helper set is still churning inside
  the running lanes; writing entries against a moving target fabricates edges.
  Next iters transcribe the final helper sets from the settled task_results
  ('## Needs blueprint entry' sections) per problem part batch.
- **guardian stub files** (1_B_2: 42-line doc-only; 3_C_3: header + 1 def):
  keep in wave-1 audit queue; if their task_results confirm truncation they
  are re-dispatched with an explicit completeness directive next iter.

## Progress
- Read role/prompt/state; verified 22 compiling formalizations, 6 lanes in flight.
- Established stage bookkeeping: physics chapters are autoformalize *sources*
  (umbrella target node), so the real gate per file is: exists + compiles with
  only `sorry` warnings + review verdict.

## Objectives (wave 2)
6 `physics-formalize` objectives, one per missing file — see PROGRESS.md.
Modes: default `formalize` fits all chapters (`% archon:physics` present, so
`physics-formalize` is the correct default per its dispatcher notes — kept the
explicit tag for clarity).

## Risks / notes
- 28-way concurrency already saturates workers; wave 2 is small (6) so it can
  start as lanes finish.
- Next iter (wave 3 bookkeeping): audit 1_B_2 & 3_C_3 stubs, transcribe helper
  blueprint entries (261-debt), then advance autoformalize→prover gate once all
  28 files compile and pass the formalization review gate (max 3 review iters/target).

# Objectives — iter 007 dispatch (1 statement-repair lane + planner-side blueprint transcription wave 1)

Stage: autoformalize. One dispatched lane; everything else is planner-side bookkeeping or deferred to the deterministic review pass.

## O1 — `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` (STATEMENT REPAIR, review session_6 R1; gate 1/3 — dispatchable via `refactor` subagent)

Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex` (`% archon:physics`; iter-007 planner NOTE records the required field + closure algebra).
Directive: `.archon/logs/iter-007/refactor-4-a-5-iso-readout-directive.md` (verbatim spec; change surface = +1 structure field + 1 doc sentence).

**Defect (session_6 verdict)**: `IsochoricReadout (P₀ T₀ β₀ : ℝ)` (~L221–L229) lacks a `T₁ ≠ T₂` non-degeneracy field. At `T₁ = T₂` the consistency fields force both measured pressures to `P₀`, so the deviation premise of `beta0_uncertainty_bound` (and `main` conjunct 3) is `0 ≤ 0` for every `β₀` while `|β₀ − 1/T₀| ≤ σ` fails at `β₀ = 2/T₀ + σ` — conjunct FALSE as stated; `countermodel_resistance` FAIL, uncertainty bridge BLOCKED.

**Repair (exactly this)**: add field `hT12 : T₁ ≠ T₂` to `IsochoricReadout` immediately after `T₂`; one doc comment sentence stating the two readouts are recorded at distinct temperatures (A.2 around-the-reference protocol; matches `main`'s `hvar` analog). Nothing else: consumers take `readouts` as a hypothesis (no construction sites); imports, law structures, answer placement, and the 10 contracted sorries stay bit-identical. Comment-lexing traps (session_6 R4): never write ASCII `+/-` in comments; headers stay plain `/-`.

**Gate**: `lake env lean` → 0 errors + exactly the 10 contracted sorry warnings. Post-repair provability recorded for the prover stage: deviation `= P₀·|T₂−T₁|·|β₀ − 1/T₀|` via `measured_hP₁/₂`; cancel `P₀·|T₂−T₁| > 0` using `IsReferenceState.hP₀` + `hT12`.

## Planner-side (this iter, no lane)
- **Blueprint helper-entries batch 1**: transcribe the two largest settled coverage-debt buckets, `3_C_3` (42 decls) + `4_C_6` (31), into `\begin{lemma}`/statement + `\label{}` + `\lean{full.Name}` + accurate `\uses{}` + 1-line informal proof blocks in their chapters, with per-batch umbrella `thm:physics:…:target` `\uses{}` wiring. Sources for `\uses{}`: the files' own task_results "Needs blueprint entry" lists + first-hand reads of the Lean dependency structure. `4_A_5`'s batch (15 → 16 incl. `hT12`) deferred one iter until O1's refactor verdict lands (signature settles).
- **Pre-review grep audit**: verify no `+/-` substring survives in any `IPhO2026Problems/*.lean` comment (trap that hid `4_A_5`'s blocker 4 iters); result recorded in `task_pending.md`.

## Not dispatched (recorded for the loop)
- **26 gate-enrolled review-queue targets** (14 at 1/3 incl. `4_C_6` at 2/3; 11 eager at 0/3 incl. `4_A_5` — it re-reviews at 2/3 next phase): no statement change warranted; deterministic review pass audits them from gate state. Live doctor clean (iter-007 rerun: 0 findings) ⇒ pass expected barring genuine findings.
- **`1_B_1`** (compile-broken, gate 3/3 `review_exhausted`): no autoformalize redispatch (iter-004/005/006 all gate-dropped). Session_6 R3: reopen only via prover-stage proof-Review redraft; frozen repair spec at iter/iter-005/objectives.md O1 (true downward-parabola restatement) + iter/iter-006/objectives.md O2 (consumer re-derive/weaken/delete decision tree). TO_USER iter-005 stands.
- **`4_C_6` provenance**: `raw/E1_solution.pdf` absent from this checkout (find-verified iter-007; `references/` = only `summary.md`). Route per gate entry: re-review when provenance is on disk, else quarantine-delete fallback lane at final attempt. Surfaced on TO_USER this iter.

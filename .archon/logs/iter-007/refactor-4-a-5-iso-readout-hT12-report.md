# Refactor Report

## Slug
4-a-5-iso-readout-hT12

## Status
COMPLETE

## Directive
**Problem:** `structure IsochoricReadout (P₀ T₀ β₀ : ℝ)` lacked a non-degeneracy guard `T₁ ≠ T₂`. At `T₁ = T₂` the consistency fields `measured_hP₁/measured_hP₂` force both measured pressures to `P₀`, so the deviation premise of `beta0_uncertainty_bound` (and `main` conjunct 3) reads `0 ≤ 0` for EVERY `β₀` while the conclusion `|β₀ − 1/T₀| ≤ σ` fails for `β₀ = 2/T₀ + σ` — the conjunct is mathematically FALSE as stated. `countermodel_resistance` FAIL; uncertainty bridge obligation BLOCKED.

**Changes requested (only this):**
1. Add ONE field `hT12 : T₁ ≠ T₂` to `IsochoricReadout`, immediately after `T₂`, before `measuredPressure`.
2. Extend the structure's doc comment with one sentence: readouts recorded at two distinct temperatures, `T₁ ≠ T₂`, so the finite-difference slope carrier is non-degenerate. No ASCII `+/-` substring anywhere in comments.
3. Nothing else — no construction sites exist (all consumers take `readouts` as a hypothesis); the 10 contracted `by sorry` bodies, answer placement, governing-law structures, and imports stay bit-identical.

## Changes Made

### File: `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`
- **What (exact inserted text, doc-comment extension):** appended to the `/-- … -/` block directly above `structure IsochoricReadout`:
  ```
  The readouts are recorded at
  two distinct temperatures, `T1 != T2`, so the finite-difference slope
  carrier is non-degenerate.
  ```
  (Existing doc-comment style writes temperatures as `T1`/`T2` and operators in ASCII; the sentence asserts the `T₁ ≠ T₂` guard in that same style and avoids the `+/-` lexing trap. The `≠` symbol itself appears in the new field's type.)
- **What (exact inserted text, field):** one line inserted between `T₂ : ℝ` and `measuredPressure`:
  ```
    hT12 : T₁ ≠ T₂
  ```
- **Why:** directive item 1+2 — restores countermodel-resistance of `main` conjunct 3 / `beta0_uncertainty_bound`; with `hT12`, `|T₂ − T₁| ≠ 0` so `P₀·|T₂ − T₁| > 0` can be cancelled in the uncertainty propagation algebra (post-condition recorded for the prover stage).
- **Cascading:** none. No construction sites exist; `main` (L265) and `beta0_uncertainty_bound` (L333) take `readouts : IsochoricReadout …` as a hypothesis. No other declaration, proof body, import, or doc block was touched; no fields reordered beyond the single insertion.

## New Sorries Introduced
None. Sorry-count invariant holds: exactly the 10 pre-existing contracted sites (now at body lines L124/L128/L132/L140/L154/L180/L287/L302/L321/L349; Lean reporter prints warning spans starting at L122/L127/L131/L136/L150/L174/L262/L292/L309/L329 — the same 10 declarations, +2/+3 line drift from the +2-line insertion, count is the invariant).

## Compilation Status
- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` → **EXIT 0**, 0 errors, exactly 10 `declaration uses 'sorry'` warnings (the contracted sites). No other warnings or infos.
- No other file touched or recompiled (write domain is exactly this one file; nothing imports it).

## Diff summary (nothing else changed)
Whole-repo `git status`: the working tree was already dirty before this refactor (28 pre-modified `blueprint/src/chapters/*.tex` files from earlier iteration bookkeeping — untouched by me; `.tex` is outside my write domain), and the target Lean file is untracked (`??`) in this checkout, so no tracked-git diff of the Lean file exists. The net change to `problem_IPhO_2026_4_A_5.lean` in this session is exactly +2/−1 lines: the one-field insertion and the 3-line doc-comment extension, verified against the pre-edit copy read at session start. Nothing else in the file changed: statements, signatures, hypotheses, imports, answer placement, and all 10 `by sorry` bodies are bit-identical.

## Declarations deleted / renamed
None.

## Notes for Plan Agent
- Mathematical justification was sufficient; no cascading fixes were needed because the structure is only ever consumed, never constructed.
- Post-condition for the prover stage (from the directive, not implemented here): with `hT12` + `IsReferenceState.hP₀`, the uncertainty conjunct is provable — deviation `= P₀·|T₂ − T₁|·|β₀ − 1/T₀|` via `measured_hP₁/measured_hP₂`, then cancel `P₀·|T₂ − T₁| > 0` (`hT12` gives `|T₂ − T₁| ≠ 0`).
- Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex` was NOT touched (refactor agent cannot write tex); the planner may wish to mirror the new `hT12` guard sentence there.

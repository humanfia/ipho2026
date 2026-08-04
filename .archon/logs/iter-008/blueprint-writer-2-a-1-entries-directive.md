# Directive — `blueprint-writer` subagent `2-a-1-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_A_1.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`). You write ONLY this .tex file.

## Why
6 live Lean declarations (the A.1 threshold-reflection-count layer) have NO blueprint entry
(leandag `dag-query unmatched` bucket, iter-008 re-derivation: `IPhO2026_2_A_1.*` — flat
underscore namespace).
Coverage-debt rule: every non-private decl gets a chapter block. The file passes the deterministic
preflight (0 errors, 5 contracted sorries), so the statements on disk are the frozen contract —
transcribe faithfully, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_2_A_1.lean` in full first-hand. Namespace `IPhO2026_2_A_1` (flat); imports (verify on disk; mirror the chapter's import-policy NOTE).
0 errors, 5 `sorry` warnings at last audit.

## Decl inventory (dependency order; verify exact names on disk)
The exact unmatched set: `IPhO2026_2_A_1.HalfCylindricalMirror`, `IPhO2026_2_A_1.HalfCylindricalMirror.limiting_ray_reflection_count`, `IPhO2026_2_A_1.HalfCylindricalMirror.threshold_forms_agree`, `IPhO2026_2_A_1.HalfCylindricalMirror.threshold_x_N`, `IPhO2026_2_A_1.HalfCylindricalMirror.threshold_x_N_cos`, `IPhO2026_2_A_1.HalfCylindricalMirror.threshold_x_N_sin`
- `HalfCylindricalMirror` (+ folded projections `limiting_ray_reflection_count`,
  `threshold_forms_agree`, `threshold_x_N_cos`, `threshold_x_N_sin`, `threshold_x_N`) — the
  threshold-count packaging carrying the A.1 official answer (the maximum number of reflections
  `N = floor(...)`-family content / threshold position, as the disk records them; keep the
  formulas conclusion-side).

## What to add (conventions MUST match the sibling ledgers landed iters 007/008)
1. Keep ALL prior content verbatim (source paragraphs, `thm:physics:IPhO_2026_2_A_1:target`
   umbrella, exemption NOTE) — append a ledger, do not rewrite the skeleton.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 2-a-1-entries) ---` then
   `\subsection*{...}` ledger sections: quantities/:geometry first, governing-law structures,
   derivation bridges, value/target theorems last.
3. One block per inventory item (family-grouping allowed for projections), each with
   `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_2_A_1:<name>}`,
   `\lean{IPhO2026_2_A_1.<exact disk name>}` (grep-verify), 1–3-line statement,
   `\uses{...}` resolving in-chapter, 1–3-line informal proof
   ("Definition; no claim." for packaging defs). NO tactic names, NO numerics off conclusion-side.
4. Wire the umbrella: add
   `\uses{thm:IPhO2026Problems_problem_IPhO_2026_2_A_1:threshold_x_N, thm:IPhO2026Problems_problem_IPhO_2026_2_A_1:limiting_ray_reflection_count}`
   (labels as you create them for the folded projections) to
   `thm:physics:IPhO_2026_2_A_1:target`.

## Verification before you report
- pins grep-match exact disk names (report N/N); `\uses` resolve in-chapter (0 unknown);
  begin/end balanced; official threshold formulas confined to the conclusion-side bridges;
  markers untouched; no other file modified.

## Report
`task_results/blueprint-writer-2-a-1-entries.md`: blocks added, pins N/N, uses 0 unknown,
official-value location, deviations.

# Directive — `blueprint-writer` subagent `2-c-1-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_1.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_2_C_1.lean`). You write ONLY this .tex file.

## Why
5 live Lean declarations (the C.1 reflected-ray slope/intercept layer) have NO blueprint entry
(leandag `dag-query unmatched` bucket, iter-008 re-derivation: `IPhO2026_2_C_1.*` — flat underscore namespace).
Coverage-debt rule: every non-private decl gets a chapter block. The file passes the deterministic
preflight (0 errors, 4 contracted sorries), so the statements on disk are the frozen contract —
transcribe faithfully, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_2_C_1.lean` in full first-hand. Namespace `IPhO2026_2_C_1` (flat); imports (verify on disk; mirror the chapter's import-policy NOTE).
0 errors, 4 `sorry` warnings at last audit.

## Decl inventory (dependency order; verify exact names on disk)
The exact unmatched set: `IPhO2026_2_C_1.HalfCylindricalMirrorReflection`, `IPhO2026_2_C_1.HalfCylindricalMirrorReflection.intercept_is_length`, `IPhO2026_2_C_1.HalfCylindricalMirrorReflection.reflected_ray_A_intercept`, `IPhO2026_2_C_1.HalfCylindricalMirrorReflection.reflected_ray_A_slope`, `IPhO2026_2_C_1.HalfCylindricalMirrorReflection.reflected_ray_A_slope_and_intercept`
- `HalfCylindricalMirrorReflection` (+ folded projections `intercept_is_length`,
  `reflected_ray_A_slope`, `reflected_ray_A_intercept`, `reflected_ray_A_slope_and_intercept`)
  — the reflected-ray line packaging whose field projections carry the C.1 official content
  (slope/intercept of the ray reflected at angle, as the disk records them; keep any numeric
  readouts conclusion-side).

## What to add (conventions MUST match the sibling ledgers landed iters 007/008)
1. Keep ALL prior content verbatim (source paragraphs, `thm:physics:IPhO_2026_2_C_1:target`
   umbrella, exemption NOTE) — append a ledger, do not rewrite the skeleton.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 2-c-1-entries) ---` then
   `\subsection*{...}` ledger sections: quantities/:geometry first, governing-law structures,
   derivation bridges, value/target theorems last.
3. One block per inventory item (family-grouping allowed for projections), each with
   `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_2_C_1:<name>}`,
   `\lean{IPhO2026_2_C_1.<exact disk name>}` (grep-verify), 1–3-line statement,
   `\uses{...}` resolving in-chapter, 1–3-line informal proof
   ("Definition; no claim." for packaging defs). NO tactic names, NO numerics off conclusion-side.
4. Wire the umbrella: add `\uses{thm:IPhO2026Problems_problem_IPhO_2026_2_C_1:reflected_ray_A_slope_and_intercept}`
   to `thm:physics:IPhO_2026_2_C_1:target`.

## Verification before you report
- pins grep-match exact disk names (report N/N); `\uses` resolve in-chapter (0 unknown);
  begin/end balanced; official slope/intercept values confined to the conclusion-side bridge;
  markers untouched; no other file modified.

## Report
`task_results/blueprint-writer-2-c-1-entries.md`: blocks added, pins N/N, uses 0 unknown,
official-value location, deviations.

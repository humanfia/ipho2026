# Directive — `blueprint-writer` subagent `2-b-1-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_1.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`). You write ONLY this .tex file.

## Why
15 live Lean declarations (the B.1 extremal-ray / container-fit-parameter layer) have NO blueprint entry
(leandag `dag-query unmatched` bucket, iter-008 re-derivation: `IPhO2026_2_B_1.*` — flat underscore namespace).
Coverage-debt rule: every non-private decl gets a chapter block. The file passes the deterministic
preflight (0 errors, 4 contracted sorries), so the statements on disk are the frozen contract —
transcribe faithfully, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean` in full first-hand. Namespace `IPhO2026_2_B_1` (flat); imports (verify on disk; mirror the chapter import-policy NOTE).
0 errors, 4 `sorry` warnings at last audit.

## Decl inventory (dependency order; verify exact names on disk)
The exact unmatched set: `IPhO2026_2_B_1.CoeffSpec`, `IPhO2026_2_B_1.CookerB1`, `IPhO2026_2_B_1.CookerParams`, `IPhO2026_2_B_1.ExtremalRaySpec`, `IPhO2026_2_B_1.IsThetaMax`, `IPhO2026_2_B_1.Line2D`, `IPhO2026_2_B_1.SecondExtremalConfig`, `IPhO2026_2_B_1.Vec`, `IPhO2026_2_B_1.alpha_beta_in_terms_of_R`, `IPhO2026_2_B_1.container_radius_at_extremal_angle`, `IPhO2026_2_B_1.distToLine`, `IPhO2026_2_B_1.impactParam_eq_sin`, `IPhO2026_2_B_1.incidenceAngle`, `IPhO2026_2_B_1.sin_two_pos`, `IPhO2026_2_B_1.vnorm`
- Geometry/data: `Vec`, `vnorm`, `Line2D`, `distToLine`, `CookerParams`, `CookerB1`,
  `CoeffSpec`, `ExtremalRaySpec`, `IsThetaMax`, `SecondExtremalConfig`, `incidenceAngle`,
  `impactParam_eq_sin`, `sin_two_pos` (verify each on disk first; several are value theorems).
- Value theorems (conclusion-side): `container_radius_at_extremal_angle`,
  `alpha_beta_in_terms_of_R` — the official B.1 answers (the `alpha = R(1+...)` /
  `beta = ...` fit parameters at the extremal angle, as the disk records them) live ONLY here.

## What to add (conventions MUST match the sibling ledgers landed iters 007/008)
1. Keep ALL prior content verbatim (source paragraphs, `thm:physics:IPhO_2026_2_B_1:target`
   umbrella, exemption NOTE) — append a ledger, do not rewrite the skeleton.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 2-b-1-entries) ---` then
   `\subsection*{...}` ledger sections: quantities/:geometry first, governing-law structures,
   derivation bridges, value/target theorems last.
3. One block per inventory item (family-grouping allowed for projections), each with
   `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_2_B_1:<name>}`,
   `\lean{IPhO2026_2_B_1.<exact disk name>}` (grep-verify), 1–3-line statement,
   `\uses{...}` resolving in-chapter, 1–3-line informal proof
   ("Definition; no claim." for packaging defs). NO tactic names, NO numerics off conclusion-side.
4. Wire the umbrella: add `\uses{thm:IPhO2026Problems_problem_IPhO_2026_2_B_1:alpha_beta_in_terms_of_R}`
   to `thm:physics:IPhO_2026_2_B_1:target`.

## Verification before you report
- pins grep-match exact disk names (report N/N); `\uses` resolve in-chapter (0 unknown);
  begin/end balanced; official fit-parameter values confined to the target theorems;
  markers untouched; no other file modified.

## Report
`task_results/blueprint-writer-2-b-1-entries.md`: blocks added, pins N/N, uses 0 unknown,
official-value location, deviations.

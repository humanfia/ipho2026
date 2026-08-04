# Directive — `blueprint-writer` subagent `3-b-2-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_2.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`). You write ONLY this .tex file.

## Why
11 live Lean declarations (the B.2 adiabatic-demagnetization / adiabatic-invariant layer) have NO\nblueprint entry (leandag `dag-query unmatched` bucket, iter-008 re-derivation: `IPhO2026_3_B_2.*` — flat underscore namespace).
Coverage-debt rule: every non-private decl gets a chapter block. The file passes the deterministic
preflight (0 errors, 3 contracted sorries), so the statements on disk are the frozen contract —
transcribe faithfully, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` in full first-hand. Namespace `IPhO2026_3_B_2` (flat); imports (verify on disk; mirror the chapter's import-policy NOTE).
0 errors, 3 `sorry` warnings at last audit.

## Decl inventory (dependency order; verify exact names on disk)
The exact unmatched set: `IPhO2026_3_B_2.AdiabaticEndpoints`, `IPhO2026_3_B_2.IsAdiabaticPath`, `IPhO2026_3_B_2.ParamagneticTorusLaws`, `IPhO2026_3_B_2.ParamagneticTorusState`, `IPhO2026_3_B_2.StatePath`, `IPhO2026_3_B_2.TorusParameters`, `IPhO2026_3_B_2.adiabaticInvariant`, `IPhO2026_3_B_2.adiabatic_invariant_along_path`, `IPhO2026_3_B_2.adiabatic_temperature_change`, `IPhO2026_3_B_2.endpoint_relation`, `IPhO2026_3_B_2.lam_add_mu0_K_sq_pos`
- State/law structures: `TorusParameters`, `ParamagneticTorusState`, `ParamagneticTorusLaws`,
  `StatePath`, `IsAdiabaticPath`, `AdiabaticEndpoints`, `adiabaticInvariant`.
- Theorems: `adiabatic_invariant_along_path`, `endpoint_relation`, `lam_add_mu0_K_sq_pos`
  (positivity certificate), `adiabatic_temperature_change` (the B.2 official-answer content —
  the final temperature after the adiabatic field change, as the disk records it — lives ONLY
  here).

## What to add (conventions MUST match the sibling ledgers landed iters 007/008)
1. Keep ALL prior content verbatim (source paragraphs, `thm:physics:IPhO_2026_3_B_2:target`
   umbrella, exemption NOTE) — append a ledger, do not rewrite the skeleton.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 3-b-2-entries) ---` then
   `\subsection*{...}` ledger sections: quantities/:geometry first, governing-law structures,
   derivation bridges, value/target theorems last.
3. One block per inventory item (family-grouping allowed for projections), each with
   `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_3_B_2:<name>}`,
   `\lean{IPhO2026_3_B_2.<exact disk name>}` (grep-verify), 1–3-line statement,
   `\uses{...}` resolving in-chapter, 1–3-line informal proof
   ("Definition; no claim." for packaging defs). NO tactic names, NO numerics off conclusion-side.
4. Wire the umbrella: add `\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_B_2:adiabatic_temperature_change}`
   to `thm:physics:IPhO_2026_3_B_2:target`.

## Verification before you report
- pins grep-match exact disk names (report N/N); `\uses` resolve in-chapter (0 unknown);
  begin/end balanced; official temperature value confined to the target theorem;
  markers untouched; no other file modified.

## Report
`task_results/blueprint-writer-3-b-2-entries.md`: blocks added, pins N/N, uses 0 unknown,
official-value location, deviations.

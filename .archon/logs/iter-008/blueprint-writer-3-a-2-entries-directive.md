# Directive — `blueprint-writer` subagent `3-a-2-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_2.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_3_A_2.lean`). You write ONLY this .tex file.

## Why
8 live Lean declarations (the A.2 induced-EMF / toroid-work layer) have NO blueprint entry
(leandag `dag-query unmatched` bucket, iter-008 re-derivation: `IPhO2026_3_A_2.*` — flat underscore namespace).
Coverage-debt rule: every non-private decl gets a chapter block. The file passes the deterministic
preflight (0 errors, 2 contracted sorries), so the statements on disk are the frozen contract —
transcribe faithfully, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_3_A_2.lean` in full first-hand. Namespace `IPhO2026_3_A_2` (flat); imports (verify on disk; mirror the chapter import-policy NOTE).
0 errors, 2 `sorry` warnings at last audit.

## Decl inventory (dependency order; verify exact names on disk)
The exact unmatched set: `IPhO2026_3_A_2.InducedEMFChange`, `IPhO2026_3_A_2.IsPositive`, `IPhO2026_3_A_2.ToroidData`, `IPhO2026_3_A_2.UniformToroidOperatingPoint`, `IPhO2026_3_A_2.WorkOnSource`, `IPhO2026_3_A_2.fieldStrength_eq_N_mul_I_mul_A_div_V`, `IPhO2026_3_A_2.sourceWork`, `IPhO2026_3_A_2.work_emf_eq_V_mul_H_mul_dB`
- `ToroidData`, `UniformToroidOperatingPoint`, `InducedEMFChange`, `IsPositive`, `WorkOnSource`,
  `sourceWork` (structure Prop carriers / data — mark which carry governing-law content).
- Theorems (sorried, conclusion-side): `fieldStrength_eq_N_mul_I_mul_A_div_V`,
  `work_emf_eq_V_mul_H_mul_dB` — the A.2 official answer (the EMF-work identity
  `W_EMF = V·H·dB`-family content, as the disk records it) lives ONLY here.

## What to add (conventions MUST match the sibling ledgers landed iters 007/008)
1. Keep ALL prior content verbatim (source paragraphs, `thm:physics:IPhO_2026_3_A_2:target`
   umbrella, exemption NOTE) — append a ledger, do not rewrite the skeleton.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 3-a-2-entries) ---` then
   `\subsection*{...}` ledger sections: quantities/:geometry first, governing-law structures,
   derivation bridges, value/target theorems last.
3. One block per inventory item (family-grouping allowed for projections), each with
   `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_3_A_2:<name>}`,
   `\lean{IPhO2026_3_A_2.<exact disk name>}` (grep-verify), 1–3-line statement,
   `\uses{...}` resolving in-chapter, 1–3-line informal proof
   ("Definition; no claim." for packaging defs). NO tactic names, NO numerics off conclusion-side.
4. Wire the umbrella: add `\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_A_2:work_emf_eq_V_mul_H_mul_dB}`
   to `thm:physics:IPhO_2026_3_A_2:target`.

## Verification before you report
- pins grep-match exact disk names (report N/N); `\uses` resolve in-chapter (0 unknown);
  begin/end balanced; official work identity confined to the target theorem;
  markers untouched; no other file modified.

## Report
`task_results/blueprint-writer-3-a-2-entries.md`: blocks added, pins N/N, uses 0 unknown,
official-value location, deviations.

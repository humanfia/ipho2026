# Directive — `blueprint-writer` subagent `2-c-4-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_4.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`). You write ONLY this .tex file.

## Why
7 live Lean declarations (the C.4 caustic small-angle power-law layer) have NO blueprint entry
(leandag `dag-query unmatched` bucket, iter-008 re-derivation: `IPhO2026_2_C_4.*` — flat underscore namespace).
Coverage-debt rule: every non-private decl gets a chapter block. The file passes the deterministic
preflight (0 errors, 1 contracted sorry), so the statements on disk are the frozen contract —
transcribe faithfully, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean` in full first-hand. Namespace `IPhO2026_2_C_4` (flat); imports (verify on disk; mirror the chapter's import-policy NOTE).
0 errors, 1 `sorry` warning at last audit.

## Decl inventory (dependency order; verify exact names on disk)
The exact unmatched set: `IPhO2026_2_C_4.CausticPowerLawForm`, `IPhO2026_2_C_4.HalfCylindricalMirrorCaustic`, `IPhO2026_2_C_4.HalfCylindricalMirrorCaustic.caustic_small_angle_power_law`, `IPhO2026_2_C_4.InSmallAngleRegime`, `IPhO2026_2_C_4.SatisfiesCausticPowerLaw`, `IPhO2026_2_C_4.smallAngleFilter`, `IPhO2026_2_C_4.smallAngleRegime_mem_filter`
- `InSmallAngleRegime`, `smallAngleFilter`, `CausticPowerLawForm`, `SatisfiesCausticPowerLaw`,
  `HalfCylindricalMirrorCaustic` (+ folded projection `caustic_small_angle_power_law`),
  `smallAngleRegime_mem_filter` (verify each on disk).
- Value theorem: `caustic_small_angle_power_law` — the C.4 official answer (the small-angle
  caustic power law `Y_c ∝ X_c^{2/3}`-family content, as the disk records it) lives ONLY here.

## What to add (conventions MUST match the sibling ledgers landed iters 007/008)
1. Keep ALL prior content verbatim (source paragraphs, `thm:physics:IPhO_2026_2_C_4:target`
   umbrella, exemption NOTE) — append a ledger, do not rewrite the skeleton.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 2-c-4-entries) ---` then
   `\subsection*{...}` ledger sections: quantities/:geometry first, governing-law structures,
   derivation bridges, value/target theorems last.
3. One block per inventory item (family-grouping allowed for projections), each with
   `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_2_C_4:<name>}`,
   `\lean{IPhO2026_2_C_4.<exact disk name>}` (grep-verify), 1–3-line statement,
   `\uses{...}` resolving in-chapter, 1–3-line informal proof
   ("Definition; no claim." for packaging defs). NO tactic names, NO numerics off conclusion-side.
4. Wire the umbrella: add `\uses{thm:IPhO2026Problems_problem_IPhO_2026_2_C_4:caustic_small_angle_power_law}`
   (or the actual label you give the folded projection theorem) to
   `thm:physics:IPhO_2026_2_C_4:target`.

## Verification before you report
- pins grep-match exact disk names (report N/N); `\uses` resolve in-chapter (0 unknown);
  begin/end balanced; official power-law content confined to the target theorem;
  markers untouched; no other file modified.

## Report
`task_results/blueprint-writer-2-c-4-entries.md`: blocks added, pins N/N, uses 0 unknown,
official-value location, deviations.

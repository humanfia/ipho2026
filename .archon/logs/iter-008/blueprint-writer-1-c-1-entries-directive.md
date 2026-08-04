# Directive — `blueprint-writer` subagent `1-c-1-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_1.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`). You write ONLY this .tex file.

## Why
17 live Lean declarations (the C.1 photodissociation-threshold layer) have NO blueprint entry
(leandag `dag-query unmatched` bucket, iter-008 re-derivation: `IPhO2026.Problem1.C1.*`).
Coverage-debt rule: every non-private decl gets a chapter block. The file passes the deterministic
preflight (0 errors, 6 contracted sorries), so the statements on disk are the frozen contract —
transcribe faithfully, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean` in full first-hand. Namespace
`IPhO2026.Problem1.C1`; imports `Mathlib` only (mirror the chapter's import-policy NOTE).
0 errors, 6 `sorry` warnings at last audit.

## Decl inventory (dependency order; verify exact names on disk)
- Geometry/constants: `PhotonLine`, `ReactionPlane`, `ConstantRegime` (+ any folded projections).
- Laws/interfaces: `IsTwoBodyDissociation`, `IsForwardBranch`, `IsAngularRange`,
  `IsScatteringAngle`, `IsDissociationThreshold`, `ReachableFrequency`.
- Quantity bridges: `dissociationEnergyGap`, `hbarOmegaMin`.
- Theorems (sorried, conclusion-side): `momentum_q_sq_of_vector_balance`,
  `two_sin_sq_add_one_eq`, `quadratic_characterization_of_threshold`,
  `minimum_angular_frequency_T1_C1`, `minimum_angular_frequency_backward_branch_T1_C1`,
  `hbarOmegaMin_pi_sub`. The official threshold-angle answer (`pi/6`-family content ~ whatever the
  disk records — check `hbarOmegaMin_pi_sub` / the minimum-frequency theorems) lives in the last
  two target theorems ONLY.

## What to add (conventions MUST match the sibling ledgers landed iters 007/008)
1. Keep ALL prior content verbatim (source paragraphs, `thm:physics:IPhO_2026_1_C_1:target`
   umbrella, exemption NOTE) — append a ledger, do not rewrite the skeleton.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 1-c-1-entries) ---` then
   `\subsection*{...}` ledger sections: quantities/:geometry first, governing-law structures,
   derivation bridges, value/target theorems last.
3. One block per inventory item (family-grouping allowed for projections), each with
   `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_1_C_1:<name>}`,
   `\lean{IPhO2026.Problem1.C1.<exact disk name>}` (grep-verify), 1–3-line statement,
   `\uses{...}` resolving in-chapter, 1–3-line informal proof
   ("Definition; no claim." for packaging defs). NO tactic names, NO numerics off conclusion-side.
4. Wire the umbrella: add
   `\uses{thm:IPhO2026Problems_problem_IPhO_2026_1_C_1:minimum_angular_frequency_T1_C1, thm:IPhO2026Problems_problem_IPhO_2026_1_C_1:hbarOmegaMin_pi_sub}`
   to `thm:physics:IPhO_2026_1_C_1:target`.

## Verification before you report
- pins grep-match exact disk names (report N/N); `\uses` resolve in-chapter (0 unknown);
  begin/end balanced; official angle/frequency values confined to the target theorems;
  markers untouched; no other file modified.

## Report
`task_results/blueprint-writer-1-c-1-entries.md`: blocks added, pins N/N, uses 0 unknown,
official-value location, deviations.

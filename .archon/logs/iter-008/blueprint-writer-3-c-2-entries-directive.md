# Directive — `blueprint-writer` subagent `3-c-2-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_2.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`). You write ONLY this .tex file.

## Why
17 live Lean declarations (the C.1 photodissociation-threshold layer) have NO blueprint entry
(leandag `dag-query unmatched` bucket, iter-008 re-derivation: `IPhO2026.Problem3.C2.*`).
Coverage-debt rule: every non-private decl gets a chapter block. The file passes the deterministic
preflight (0 errors, 6 contracted sorries), so the statements on disk are the frozen contract —
transcribe faithfully, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean` in full first-hand. Namespace
`IPhO2026.Problem3.C2`; imports `Mathlib` only (mirror the chapter's import-policy NOTE).
0 errors, exactly 10 contracted sorries at last audit.

## Decl inventory (dependency order; verify exact names on disk)
- Cycle structures: `TorusParams`, `ParamagnetState`, `Vertex`, `ProcessKind`,
  `EquationOfStateParamagnet`, `CarnotCycle`, `CarnotHeatRatio`,
  `IsothermalHeatIntoTorus`, `Figure3bAssignment` (governing-law/figure carriers — mark which).
- `CarnotMagnetizationModel` family — fold its projections into one parent block with one
  `\lean{}` line each: `M1`/`M2`/`M3`/`M4`, `q`, `q_relation`, `Qc_eq`, `Qh_eq`, `q3_eq`,
  `q4_eq_adiabatic_41`, `heat_isothermal_via_q`, `vertex_T_pos`, `m1_sq`, `m1_sq_arg_nonneg`,
  `m1_eq_sqrt`. The `m1_*`/`q*` entries are the adiabatic-leg algebra carrying the C.2
  magnetization-threshold content.
- The C.2 official-answer content (the magnetization `m₁ = sqrt(...)` value / heat ratio per the
  disk) lives ONLY in the conclusion-side bridge theorems `m1_eq_sqrt`, `q3_eq` and their
  consumers — keep numerics there.

## What to add (conventions MUST match the sibling ledgers landed iters 007/008)
1. Keep ALL prior content verbatim (source paragraphs, `thm:physics:IPhO_2026_3_C_2:target`
   umbrella, exemption NOTE) — append a ledger, do not rewrite the skeleton.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 3-c-2-entries) ---` then
   `\subsection*{...}` ledger sections: quantities/:geometry first, governing-law structures,
   derivation bridges, value/target theorems last.
3. One block per inventory item (family-grouping allowed for projections), each with
   `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_3_C_2:<name>}`,
   `\lean{IPhO2026.Problem3.C2.<exact disk name>}` (grep-verify), 1–3-line statement,
   `\uses{...}` resolving in-chapter, 1–3-line informal proof
   ("Definition; no claim." for packaging defs). NO tactic names, NO numerics off conclusion-side.
4. Wire the umbrella: add `\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_C_2:CarnotMagnetizationModel}`
   (plus `lem:...:m1_eq_sqrt` if you split it into its own block) to
   `thm:physics:IPhO_2026_3_C_2:target`.

## Verification before you report
- pins grep-match exact disk names (report N/N); `\uses` resolve in-chapter (0 unknown);
  begin/end balanced; official magnetization/heat values confined to conclusion-side blocks;
  markers untouched; no other file modified.

## Report
`task_results/blueprint-writer-3-c-2-entries.md`: blocks added, pins N/N, uses 0 unknown,
official-value location, deviations.

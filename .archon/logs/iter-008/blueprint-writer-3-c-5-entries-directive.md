# Directive — `blueprint-writer` subagent `3-c-5-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_5.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_3_C_5.lean`). You write ONLY this .tex file.

## Why
12 live Lean declarations (the C.5 overall-coefficient-of-performance / refrigerator-energy-balance
layer) have NO blueprint entry (leandag `dag-query unmatched` bucket, iter-008 re-derivation:
`IPhO2026.Problem3.C5.*`; one more decl may be a pin-fix — verify on disk).
Coverage-debt rule: every non-private decl gets a chapter block. The file passes the deterministic
preflight (0 errors, 2 sorried theorems), so the statements on disk are the frozen contract —
transcribe faithfully, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_3_C_5.lean` in full first-hand (~215 lines). Namespace
`IPhO2026.Problem3.C4`; nested sections Quantities / GoverningLaws / ContextLemmas / BridgeLemmas /
PhysicsContracts. Imports `Mathlib` + PhysLean (check the header; mirror the chapter's existing
import-policy NOTE). 0 errors, 2 sorried theorems (3 `sorry` sites) at last audit.

## Decl inventory (dependency order; verify exact names on disk — these come from the iter-008
unmatched bucket and the file tail)
- `CycleFields`, `RegimeAssumptions`, `OperatingHistory`, `ParamagneticEquationOfState`,
  `RefrigeratorEnergyBalance`, `CooledBodyHeatBalance`, `ConstantPowerWork`,
  `C4ElapsedTimeLaw`, `AccumulatedCarnotHeatRelation` (structure Prop carriers — mark which
  carry governing-law/figure content).
- Value theorems: `coefficientOfPerformance`, `overall_coefficient_of_performance`,
  `coefficient_of_performance_via_energy_balance` (the C.5 target value theorem — verify
  which is the official-answer entry on disk).

## What to add (conventions MUST match the sibling ledgers already landed this iter)
1. Keep ALL prior content verbatim (source paragraphs, `% SOURCE...` lines if any,
   `thm:physics:IPhO_2026_3_C_5:target` umbrella, exemption/reconciliation NOTEs)
   — append a ledger, do not rewrite the skeleton.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 3-c-5-entries) ---` then
   `\subsection*{...}` ledger sections in dependency order: quantities & data first,
   governing-law structures next, derivation bridges, value theorems last.
3. One `\begin{definition|lemma|theorem}` block per inventory item (family-grouping allowed:
   constructors/projections fold multi-`\lean{}` into the parent entry), each with:
   - `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_3_C_5:<shortCamelName>}`
   - `\lean{IPhO2026.Problem3.C4.<exact disk name>}` (grep-verify exact names on disk)
   - 1–3-line informal statement in project notation
   - `\uses{...}` with in-chapter labels reflecting actual disk dependencies (read the bodies)
   - a `\begin{proof}`: 1–3-line informal proof — "Definition; no claim." for packaging defs;
     one-line algebra/intentionality sketches for the bridge and value theorems. NO tactic names.
4. Official sample value (the C.5 overall COP answer) and any official numeric appear ONLY in
   conclusion-side entries (`overall_coefficient_of_performance` and its formula theorem);
   never in assumption-side fields.
5. Wire the umbrella: add `\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_C_5:overall_coefficient_of_performance}`
   to `thm:physics:IPhO_2026_3_C_5:target`.

## Verification before you report
- every `\lean{}` pin grep-matches an exact on-disk declaration name (report the count N/N)
- every `\uses{}` label resolves in-chapter (script it: extract labels vs uses; 0 unknown)
- `\begin`/\`\end` environments balanced; official answer value confined to conclusion-side blocks
- markers (`\leanok`, `\mathlibok`) untouched; no other file modified; no markers added

## Report
`task_results/blueprint-writer-3-c-5-entries.md`: blocks added, pins verified N/N, uses_resolve
0 unknown, where the official value lives, deviations.

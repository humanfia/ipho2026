# Directive — `blueprint-writer` subagent `3-c-4-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`). You write ONLY this .tex file.

## Why
22 live Lean declarations (the full C.4 cooling-time / Carnot-work-balance layer) have NO
blueprint entry (leandag `dag-query unmatched` bucket, iter-008 re-derivation: `IPhO2026.Problem3.C4.*`).
Coverage-debt rule: every non-private decl gets a chapter block. The file passes the deterministic
preflight (0 errors, 8 sorried theorems), so the statements on disk are the frozen contract —
transcribe faithfully, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean` in full first-hand (~420 lines). Namespace
`IPhO2026.Problem3.C4`; nested sections Quantities / GoverningLaws / ContextLemmas / BridgeLemmas /
PhysicsContracts. Imports `Mathlib` + PhysLean (check the header; mirror the chapter's existing
import-policy NOTE). 0 errors, exactly 8 sorried theorems (10 `sorry` sites) at last audit.

## Decl inventory (dependency order; verify exact names on disk — these come from the iter-008
unmatched bucket and the file tail)
- `TorusParams`, `WorkingState`, `ParamagnetEOS`, `EquationOfStateParamagnet`-family packaging
  (structure Prop carriers — mark which carry governing-law/figure content).
- `RegimeAssumptions`, `InfinitesimalCycleLaw`, `CarnotHeatRatio`, `CycleCorners`,
  `Figure3bCorners`, `IsothermalHeatIntoTorus`, `CycleWorkHeatBalance`.
- `CoolingRun`, `IsCoolingRun`, `BodyCalorimeterDensityLaw`, `ConstantPowerDensityLaw`.
- Density/integral bridges: `magnetization_of_eos`, `workDensity_eq`, `heatDumpedDensity_eq`,
  `residenceDensity_eq`, `heat_leaves_torus_on_field_increase`, `elapsedTime_eq_integral`,
  `cooling_time_integral_eval`, `c4_elapsed_time` (the C.4 numeric-value theorem).

## What to add (conventions MUST match the sibling ledgers already landed this iter)
1. Keep ALL prior content verbatim (source paragraphs, `% SOURCE...` lines if any,
   `thm:physics:IPhO_2026_3_C_4:target` umbrella, exemption/reconciliation NOTEs)
   — append a ledger, do not rewrite the skeleton.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 3-c-4-entries) ---` then
   `\subsection*{...}` ledger sections in dependency order: quantities & data first,
   governing-law structures next, derivation bridges, value theorems last.
3. One `\begin{definition|lemma|theorem}` block per inventory item (family-grouping allowed:
   constructors/projections fold multi-`\lean{}` into the parent entry), each with:
   - `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_3_C_4:<shortCamelName>}`
   - `\lean{IPhO2026.Problem3.C4.<exact disk name>}` (grep-verify exact names on disk)
   - 1–3-line informal statement in project notation
   - `\uses{...}` with in-chapter labels reflecting actual disk dependencies (read the bodies)
   - a `\begin{proof}`: 1–3-line informal proof — "Definition; no claim." for packaging defs;
     one-line algebra/intentionality sketches for the bridge and value theorems. NO tactic names.
4. Official sample value (the C.4 cooling-time answer) and any official numeric appear ONLY in
   conclusion-side entries (the `c4_elapsed_time` theorem); never in assumption-side fields.
5. Wire the umbrella: add `\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_C_4:c4_elapsed_time}`
   to `thm:physics:IPhO_2026_3_C_4:target`.

## Verification before you report
- every `\lean{}` pin grep-matches an exact on-disk declaration name (report the count N/N)
- every `\uses{}` label resolves in-chapter (script it: extract labels vs uses; 0 unknown)
- `\begin`/\`\end` environments balanced; official answer value confined to conclusion-side blocks
- markers (`\leanok`, `\mathlibok`) untouched; no other file modified; no markers added

## Report
`task_results/blueprint-writer-3-c-4-entries.md`: blocks added, pins verified N/N, uses_resolve
0 unknown, where the official value lives, deviations.

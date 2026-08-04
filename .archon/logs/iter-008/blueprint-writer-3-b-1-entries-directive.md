# Directive — `blueprint-writer` subagent `3-b-1-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_1.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`). You write ONLY this .tex file.

## Why
15 live Lean declarations (the full B.1 magnetic-work / isothermal-heat layer) have NO blueprint
entry (leandag `dag-query unmatched` bucket, iter-008 re-derivation: `IPhO2026.Problem3.B1.*`);
plus up to 3 `noncomputable def` pins the scan handles differently — verify each on disk and pin
what exists.
Coverage-debt rule: every non-private decl gets a chapter block. The file passes the deterministic
preflight (0 errors, 3 `sorry` theorems / 4 sorry sites at last audit), so the statements on disk are the frozen contract —
transcribe faithfully, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean` in full first-hand. Namespace `IPhO2026.Problem3.B1`.  Imports `Mathlib` + PhysLean (check the header; mirror the chapter's existing
import-policy NOTE). 0 errors, exactly 3 sorried theorems (4 `sorry` sites) at last audit.

## Decl inventory (dependency order; verify exact names on disk — these come from the iter-008
unmatched bucket and the file tail)
- `TorusParams`, `TorusState`, `SatisfiesEOS`, `HasHeatCapacityLaw`, `IsMagneticWorkDensity`,
  `ObeysFirstLawMagnetic`, `IsothermalFieldChange` (governing-law structure carriers).
- Data/readouts: `heatCapacityConstM` (and any noncomputable data defs).
- Work/heat bridges: `leg_mem_tracked_range`, `leg_work_integral_eval`,
  `heatTransferredIntoTorus`, `isothermal_heat_into_torus`, `heat_into_torus_value`.
- Value theorems: `magnetization_eq_eos_solution`, `official_answer_value` (the B.1
  official-answer theorem, CONCLUSION-side).

## What to add (conventions MUST match the sibling ledgers already landed this iter)
1. Keep ALL prior content verbatim (source paragraphs, `% SOURCE...` lines if any,
   `thm:physics:IPhO_2026_3_B_1:target` umbrella, exemption/reconciliation NOTEs)
   — append a ledger, do not rewrite the skeleton.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 3-b-1-entries) ---` then
   `\subsection*{...}` ledger sections in dependency order: quantities & data first,
   governing-law structures next, derivation bridges, value theorems last.
3. One `\begin{definition|lemma|theorem}` block per inventory item (family-grouping allowed:
   constructors/projections fold multi-`\lean{}` into the parent entry), each with:
   - `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_3_B_1:<shortCamelName>}`
   - `\lean{IPhO2026.Problem3.B1.<exact disk name>}` (grep-verify exact names on disk)
   - 1–3-line informal statement in project notation
   - `\uses{...}` with in-chapter labels reflecting actual disk dependencies (read the bodies)
   - a `\begin{proof}`: 1–3-line informal proof — "Definition; no claim." for packaging defs;
     one-line algebra/intentionality sketches for the bridge and value theorems. NO tactic names.
4. Official sample value (the B.1 heat-into-the-torus answer) and any official numeric appear
   ONLY in conclusion-side entries (`official_answer_value`); never in assumption-side fields.
5. Wire the umbrella: add `\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_B_1:official_answer_value}`
   to `thm:physics:IPhO_2026_3_B_1:target`.

## Verification before you report
- every `\lean{}` pin grep-matches an exact on-disk declaration name (report the count N/N)
- every `\uses{}` label resolves in-chapter (script it: extract labels vs uses; 0 unknown)
- `\begin`/\`\end` environments balanced; official answer value confined to conclusion-side blocks
- markers (`\leanok`, `\mathlibok`) untouched; no other file modified; no markers added

## Report
`task_results/blueprint-writer-3-b-1-entries.md`: blocks added, pins verified N/N, uses_resolve
0 unknown, where the official value lives, deviations.

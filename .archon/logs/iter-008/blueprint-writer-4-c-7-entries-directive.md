# Directive — `blueprint-writer` subagent `4-c-7-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`). You write ONLY this .tex file.

## Why
8 live Lean declarations (the full C.7 radial-Fourier-conduction / acrylic-conductivity readout
layer) have NO blueprint entry (leandag `dag-query unmatched` bucket, iter-008 re-derivation:
`IPhO2026.Problem4.C7.*`; one more decl may be a pin-fix — verify on disk).
Coverage-debt rule: every non-private decl gets a chapter block. The file passes the deterministic
preflight (0 errors, 2 sorried theorems), so the statements on disk are the frozen contract —
transcribe faithfully, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` in full first-hand (~205 lines). Namespace
`IPhO2026.Problem3.C4`; nested sections Quantities / GoverningLaws / ContextLemmas / BridgeLemmas /
PhysicsContracts. Imports `Mathlib` + PhysLean (check the header; mirror the chapter's existing
import-policy NOTE). 0 errors, 2 sorried theorems (4 `sorry` sites) at last audit.

## Decl inventory (dependency order; verify exact names on disk — these come from the iter-008
unmatched bucket and the file tail)
- `ThermalExperimentData` (structure — the figure/table readout dataset packaging; mark
  governing-law vs readout content).
- `CylindricalWallGeometry` (+ folded `.lateralArea` projection), `RadialFourierConduction`
  (+ folded `.wall_current` projection), `LumpedHeatFlowLaw`.
- Value theorems: `acrylicConductivity_formula` (the conductivity-from-data formula theorem)
  and `acrylicConductivity_officialSample` (the official-sample value/band theorem,
  CONCLUSION-side).

## What to add (conventions MUST match the sibling ledgers already landed this iter)
1. Keep ALL prior content verbatim (source paragraphs, `% SOURCE...` lines if any,
   `thm:physics:IPhO_2026_4_C_7:target` umbrella, exemption/reconciliation NOTEs)
   — append a ledger, do not rewrite the skeleton.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 4-c-7-entries) ---` then
   `\subsection*{...}` ledger sections in dependency order: quantities & data first,
   governing-law structures next, derivation bridges, value theorems last.
3. One `\begin{definition|lemma|theorem}` block per inventory item (family-grouping allowed:
   constructors/projections fold multi-`\lean{}` into the parent entry), each with:
   - `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_4_C_7:<shortCamelName>}`
   - `\lean{IPhO2026.Problem3.C4.<exact disk name>}` (grep-verify exact names on disk)
   - 1–3-line informal statement in project notation
   - `\uses{...}` with in-chapter labels reflecting actual disk dependencies (read the bodies)
   - a `\begin{proof}`: 1–3-line informal proof — "Definition; no claim." for packaging defs;
     one-line algebra/intentionality sketches for the bridge and value theorems. NO tactic names.
4. Official sample value (the C.7 acrylic-conductivity answer `0.18 ± 0.02 W/(m·K)` or whatever
   the disk records) appears ONLY in conclusion-side entries (`acrylicConductivity_officialSample`);
   never in assumption-side fields.
5. Wire the umbrella: add `\uses{thm:IPhO2026Problems_problem_IPhO_2026_4_C_7:acrylicConductivity_officialSample}`
   to `thm:physics:IPhO_2026_4_C_7:target`.

## Verification before you report
- every `\lean{}` pin grep-matches an exact on-disk declaration name (report the count N/N)
- every `\uses{}` label resolves in-chapter (script it: extract labels vs uses; 0 unknown)
- `\begin`/\`\end` environments balanced; official answer value confined to conclusion-side blocks
- markers (`\leanok`, `\mathlibok`) untouched; no other file modified; no markers added

## Report
`task_results/blueprint-writer-4-c-7-entries.md`: blocks added, pins verified N/N, uses_resolve
0 unknown, where the official value lives, deviations.

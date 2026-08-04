# Directive — `blueprint-writer` subagent `4-b-4-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_4.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_4_B_4.lean`). You write ONLY this .tex file.

## Why
11 live Lean declarations (the B.4 vapor-pressure / Clausius–Clapeyron readout layer) have NO blueprint entry
(leandag `dag-query unmatched` bucket, iter-008 re-derivation: `IPhO2026_4_B_4.*`; one more decl may be a pin-fix — verify on disk).
Coverage-debt rule: every non-private decl gets a chapter block. The file passes the deterministic
preflight (0 errors, 2 contracted sorries), so the statements on disk are the frozen contract —
transcribe faithfully, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_4_B_4.lean` in full first-hand. Namespace `IPhO2026_4_B_4` (flat); imports (verify on disk; mirror the chapter import-policy NOTE).
0 errors, 2 `sorry` warnings at last audit.

## Decl inventory (dependency order; verify exact names on disk)
The exact unmatched set: `IPhO2026_4_B_4.ClausiusClapeyron`, `IPhO2026_4_B_4.GasColumnGeometry`, `IPhO2026_4_B_4.VaporPressureB4Data`, `IPhO2026_4_B_4.VaporPressureB4Data.MeasuredState`, `IPhO2026_4_B_4.VaporPressureB4Data.dryAirPartialPressure_at_T₀`, `IPhO2026_4_B_4.VaporPressureB4Data.eq_zero_of_clausiusClapeyron_zero`, `IPhO2026_4_B_4.VaporPressureB4Data.referenceState`, `IPhO2026_4_B_4.VaporPressureB4Data.target`, `IPhO2026_4_B_4.VaporPressureB4Data.total_pressure_mul_volume`, `IPhO2026_4_B_4.VaporPressureB4Data.vaporPressure_eq`, `IPhO2026_4_B_4.gasVolume`
- `GasColumnGeometry`, `ClausiusClapeyron` (law carriers); `gasVolume`.
- `VaporPressureB4Data` (+ folded projections `MeasuredState`, `referenceState`).
- Theorems: `total_pressure_mul_volume`, `eq_zero_of_clausiusClapeyron_zero`,
  `dryAirPartialPressure_at_T₀`, `vaporPressure_eq`, `target` — the B.4 official answer (the
  vapor pressure at the measurement temperature, as the disk records it) lives ONLY in
  `vaporPressure_eq`/`target`.

## What to add (conventions MUST match the sibling ledgers landed iters 007/008)
1. Keep ALL prior content verbatim (source paragraphs, `thm:physics:IPhO_2026_4_B_4:target`
   umbrella, exemption NOTE) — append a ledger, do not rewrite the skeleton.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 4-b-4-entries) ---` then
   `\subsection*{...}` ledger sections: quantities/:geometry first, governing-law structures,
   derivation bridges, value/target theorems last.
3. One block per inventory item (family-grouping allowed for projections), each with
   `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_4_B_4:<name>}`,
   `\lean{IPhO2026_4_B_4.<exact disk name>}` (grep-verify), 1–3-line statement,
   `\uses{...}` resolving in-chapter, 1–3-line informal proof
   ("Definition; no claim." for packaging defs). NO tactic names, NO numerics off conclusion-side.
4. Wire the umbrella: add `\uses{thm:IPhO2026Problems_problem_IPhO_2026_4_B_4:target}`
   (the in-file theorem literally named `target` — verify on disk) to
   `thm:physics:IPhO_2026_4_B_4:target`.

## Verification before you report
- pins grep-match exact disk names (report N/N); `\uses` resolve in-chapter (0 unknown);
  begin/end balanced; official vapor-pressure value confined to the target theorems;
  markers untouched; no other file modified.

## Report
`task_results/blueprint-writer-4-b-4-entries.md`: blocks added, pins N/N, uses 0 unknown,
official-value location, deviations.

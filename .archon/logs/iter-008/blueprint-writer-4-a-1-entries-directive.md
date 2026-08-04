# Directive — `blueprint-writer` subagent `4-a-1-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_1.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`). You write ONLY this .tex file.

## Why
17 live Lean declarations (the C.1 photodissociation-threshold layer) have NO blueprint entry
(leandag `dag-query unmatched` bucket, iter-008 re-derivation: `IPhO2026.Problem4.A1.*`).
Coverage-debt rule: every non-private decl gets a chapter block. The file passes the deterministic
preflight (0 errors, 6 contracted sorries), so the statements on disk are the frozen contract —
transcribe faithfully, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_4_A_1.lean` in full first-hand. Namespace
`IPhO2026.Problem4.A1`; imports `Mathlib` only (mirror the chapter's import-policy NOTE).
0 errors, 8 `sorry` warnings at last audit.

## Decl inventory (dependency order; verify exact names on disk)
- Uncertainty packaging: `MeasuredQuantity` (+ folded `.lower`, `.upper`, `.PropagatesTo`
  projections) — the interval/uncertainty idiom this part uses throughout.
- Main structure: `ConfinedAirColumn` (+ folded projections `volume_closed_form`,
  `amountFromIdealGas`) with neighbors/licensing `CompatibleWithReadouts`, `OfficialReadouts`.
- Theorems (each sorried, conclusion-side): `mass_pos_of_volume_pos`, `numberOfMolecules_pos`,
  `mass_of_confined_air`, `number_of_molecules_of_confined_air`, `molar_mass_consistency`,
  `uncertainty_consistency` — the official A.1 answers (mass / molecule count / uncertainty bands,
  as the disk records them) live ONLY in the final value theorems.

## What to add (conventions MUST match the sibling ledgers landed iters 007/008)
1. Keep ALL prior content verbatim (source paragraphs, `thm:physics:IPhO_2026_4_A_1:target`
   umbrella, exemption NOTE) — append a ledger, do not rewrite the skeleton.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 4-a-1-entries) ---` then
   `\subsection*{...}` ledger sections: quantities/:geometry first, governing-law structures,
   derivation bridges, value/target theorems last.
3. One block per inventory item (family-grouping allowed for projections), each with
   `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_4_A_1:<name>}`,
   `\lean{IPhO2026.Problem4.A1.<exact disk name>}` (grep-verify), 1–3-line statement,
   `\uses{...}` resolving in-chapter, 1–3-line informal proof
   ("Definition; no claim." for packaging defs). NO tactic names, NO numerics off conclusion-side.
4. Wire the umbrella: add
   `\uses{thm:IPhO2026Problems_problem_IPhO_2026_4_A_1:uncertainty_consistency}`
   (chain through `number_of_molecules_of_confined_air` / `mass_of_confined_air` if the disk
   dependency runs that way) to `thm:physics:IPhO_2026_4_A_1:target`.

## Verification before you report
- pins grep-match exact disk names (report N/N); `\uses` resolve in-chapter (0 unknown);
  begin/end balanced; official mass/molecule-count values and bands confined to the target theorems;
  markers untouched; no other file modified.

## Report
`task_results/blueprint-writer-4-a-1-entries.md`: blocks added, pins N/N, uses 0 unknown,
official-value location, deviations.

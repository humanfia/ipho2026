# Directive — `blueprint-writer` subagent `2-b-2-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_2.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`). You write ONLY this .tex file.

## Why
17 live Lean declarations (the C.1 photodissociation-threshold layer) have NO blueprint entry
(leandag `dag-query unmatched` bucket, iter-008 re-derivation: `IPhO2026.Problem2.B2.*`).
Coverage-debt rule: every non-private decl gets a chapter block. The file passes the deterministic
preflight (0 errors, 6 contracted sorries), so the statements on disk are the frozen contract —
transcribe faithfully, never redesign.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean` in full first-hand. Namespace
`IPhO2026.Problem2.B2`; imports `Mathlib` only (mirror the chapter's import-policy NOTE).
0 errors, 5 `sorry` warnings at last audit.

## Decl inventory (dependency order; verify exact names on disk)
- Geometry/constants/data: aperture/mirror parameters, `CookerGeometry`-family packaging
  (READ the file: exact names on disk under namespace `IPhO2026_2_B_2` — e.g. aperture,
  half-angle, collected-width quantities and any structure Prop carriers).
- Theorem layer (from the file's tail): `collectedWidth_eq_radius`, `power_ratio_eq_width_ratio`,
  `radius_over_diameter_eq`, `power_ratio_in_terms_of_theta_max`, and the sorried target
  `impactParam_le_aperture` — the official B.2 answer (power-concentration ratio / `sin` of the
  max angle, as the disk records it) lives ONLY in the final value theorem(s).
VERIFY every name on disk first (18 unmatched decls were bucketed to this file iter-008;
the scan list is authoritative over this sketch).

## What to add (conventions MUST match the sibling ledgers landed iters 007/008)
1. Keep ALL prior content verbatim (source paragraphs, `thm:physics:IPhO_2026_2_B_2:target`
   umbrella, exemption NOTE) — append a ledger, do not rewrite the skeleton.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 2-b-2-entries) ---` then
   `\subsection*{...}` ledger sections: quantities/:geometry first, governing-law structures,
   derivation bridges, value/target theorems last.
3. One block per inventory item (family-grouping allowed for projections), each with
   `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_2_B_2:<name>}`,
   `\lean{IPhO2026.Problem2.B2.<exact disk name>}` (grep-verify), 1–3-line statement,
   `\uses{...}` resolving in-chapter, 1–3-line informal proof
   ("Definition; no claim." for packaging defs). NO tactic names, NO numerics off conclusion-side.
4. Wire the umbrella: add `\uses{thm:IPhO2026Problems_problem_IPhO_2026_2_B_2:power_ratio_in_terms_of_theta_max}`
   (use the actual final value theorem label you create if it differs) to
   `thm:physics:IPhO_2026_2_B_2:target`.

## Verification before you report
- pins grep-match exact disk names (report N/N); `\uses` resolve in-chapter (0 unknown);
  begin/end balanced; official power-ratio values confined to the target theorems;
  markers untouched; no other file modified.

## Report
`task_results/blueprint-writer-2-b-2-entries.md`: blocks added, pins N/N, uses 0 unknown,
official-value location, deviations.

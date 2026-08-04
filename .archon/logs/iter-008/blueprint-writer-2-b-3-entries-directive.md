# Directive — `blueprint-writer` subagent `2-b-3-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_3.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_2_B_3.lean`). You write ONLY this .tex file.

## Why
10 live Lean declarations (the B.3 container-diameter-for-quintuple-power layer) have NO
blueprint entry (leandag `dag-query unmatched` bucket). Hybrid scan reality: the file's opening
`noncomputable section` makes its `def`s invisible to the decl scan (same behavior as the
opaque-constants case recorded iter-008 in `1_B_2`'s chapter) — ALL unmatched names below live at
ROOT level (no namespace); the physics `Prop` structures ARE scanned. Coverage-debt rule: every
non-private decl gets a chapter block. Preflight green (0 errors, 4 contracted sorries); the
disk is the frozen contract.

## Source of truth (MANDATORY first step)
READ `IPhO2026Problems/problem_IPhO_2026_2_B_3.lean` in full first-hand. Root-level decls inside
`noncomputable section`; imports `Mathlib`; `open Real`. 0 errors, 4 `sorry` warnings at last audit.

## Decl inventory (all root-level; verify exact names on disk)
The exact unmatched set: `CrossSectionPlane`, `HalfCylindricalMirrorPhysics`,
`PreviousPartResults`, `SolarCookerGeometry`, `container_diameter_for_quintuple_power`,
`metreInCentimetres`, `sin_thetaMaxRecorded`, `sin_two_mul_thetaMaxRecorded`, `thetaMaxRecorded`,
`thetaMaxRecorded_mem_Ioo`. (Companion `abbrev`/`def` neighbors the scan cannot see may also
exist — pin every non-private decl you find, including the invisible ones; note in your report
which pins are scan-invisible.)
- `thetaMaxRecorded : ℝ := arccos (4/5)` (abbrev, symbolic abbreviation — the cos θ_max = 4/5
  content is PROVED in `sin_thetaMaxRecorded`, not defined), `metreInCentimetres`,
  `CrossSectionPlane := EuclideanSpace ℝ (Fin 2)` (abbrevs).
- `SolarCookerGeometry` (structure: mirror/container radii, positions — figure readouts),
  `HalfCylindricalMirrorPhysics` (structure Prop: specular reflection + uniform irradiance +
  single-reflection condition — governing-law carrier), `PreviousPartResults` (structure Prop:
  B.1 `a = R sin θ_max − (R/2) sin 2θ_max` + B.2 `P/P₀ = 1/(1 − cos θ_max)` as named previous-part
  interfaces, natural-language prerequisite results from B.1/B.2).
- Theorems: `thetaMaxRecorded_mem_Ioo` (0 < θ_max < π/2), `sin_thetaMaxRecorded`
  (sin θ_max = 3/5), `sin_two_mul_thetaMaxRecorded` (sin 2θ_max = 24/25),
  `container_diameter_for_quintuple_power` (the official answer `a = 0.12 m = 12 cm` at
  `R = 1.0 m`, P = 5 P₀ — CONCLUSION-side only).

## What to add
1. Keep ALL prior content verbatim (source paragraphs,
   `thm:physics:IPhO_2026_2_B_3:target` umbrella, exemption NOTEs) — append a ledger.
2. Append `% --- Archon named-quantities coverage (blueprint-writer 2-b-3-entries) ---` then
   ledger `\subsection*{...}`s in dependency order: abbrevs/units first, geometry structure,
   physics-law + previous-part structures, trig certificates, value theorem last.
3. One block per item, each `\label{def|lem|thm:IPhO2026Problems_problem_IPhO_2026_2_B_3:<name>}`,
   `\lean{<exact root-level name>}` (NO namespace prefix — these are root decls; grep-verify),
   1–3-line statement, `\uses{...}` resolving in-chapter (`container_diameter_for_quintuple_power`
   uses `PreviousPartResults` + both trig certificates + geometry/physics structures per its
   actual signature), 1–3-line proof sketch (3-4-5 triangle for the certificates; B.2 ratio
   inversion + B.1 substitution for the value theorem). NO tactic names.
4. Official answers (`cos θ_max = 4/5`, `12 cm`) ONLY conclusion-side.
5. Wire the umbrella: add `\uses{thm:IPhO2026Problems_problem_IPhO_2026_2_B_3:container_diameter_for_quintuple_power}`
   to `thm:physics:IPhO_2026_2_B_3:target`.

## Verification
pins grep-match disk N/N; `\uses` 0 unknown; begin/end balanced; answers conclusion-side; markers
untouched; no other file modified.

## Report
`task_results/blueprint-writer-2-b-3-entries.md`: blocks, pins N/N (+ scan-invisible pin list),
uses 0 unknown, deviations.

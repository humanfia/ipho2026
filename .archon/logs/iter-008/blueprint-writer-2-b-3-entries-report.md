# Blueprint Writer Report: 2-b-3-entries
**Status:** COMPLETE

## Changes (chapter `IPhO2026Problems_problem_IPhO_2026_2_B_3.tex` only; skeleton verbatim, +184 lines)
- Appended `% --- Archon named-quantities coverage (blueprint-writer 2-b-3-entries) ---` + import-policy NOTE + scan-invisibility NOTE; 5 ledger subsections, 10 blocks, one per non-private disk decl, dependency order:
  - Unit scale/symbolic: `def:...:thetaMaxRecorded` (abbrev; cos=4/5 content flagged proved-not-defined), `def:...:metreInCentimetres`.
  - Geometry: `def:...:CrossSectionPlane` (E^2 cross-section), `def:...:SolarCookerGeometry` (R, a, centre at R/2 on symmetry plane).
  - Laws/interfaces: `def:...:HalfCylindricalMirrorPhysics` (on-mirror + illuminated side + specular reflection + cosine-law incidence + acute single-reflection regime), `def:...:PreviousPartResults` (B.1 a = R sin theta - (R/2) sin 2theta; B.2 P/P0 = 1/(1-cos theta); acute range; P,P0>0).
  - Certificates: `lem:...:thetaMaxRecorded_mem_Ioo` (arccos interior of (0,1) lands in (0,pi/2)), `lem:...:sin_thetaMaxRecorded` (sin = 3/5 via sqrt(1-16/25)), `lem:...:sin_two_mul_thetaMaxRecorded` (2*(3/5)*(4/5) = 24/25).
  - Target: `thm:...:container_diameter_for_quintuple_power` -- B.2 inversion (5 = 1/(1-cos) => cos = 4/5), acute-range arccos-injectivity identifying theta_max, B.1 substitution a = 3/5 - 12/25 = 3/25 = 0.12 m; x100 => 12 cm. Official answers cos=4/5, 0.12 m, 12 cm conclusion-side only; no tactic names anywhere.
- Wired umbrella: added `\uses{thm:IPhO2026Problems_problem_IPhO_2026_2_B_3:container_diameter_for_quintuple_power}` to `thm:physics:IPhO_2026_2_B_3:target` (only pre-existing-line edit).

## Verification
- Pins 10/10: every `\lean{}` names a live ROOT-level disk decl (no namespace prefix, per directive; unescaped-match grep). Every disk decl pinned; none left over.
- Scan-invisible pins (hidden from hybrid decl scan by file-leading `noncomputable section`, per directive; pinned anyway): `thetaMaxRecorded`, `metreInCentimetres`, `CrossSectionPlane`. (Scan-visible: the two Prop-structure Prop decls scan; remaining defs/theorems matched the unmatched bucket.)
  NOTE: local `.leandag/dag.json` snapshot actually lists ALL 10 as `lean:` aux nodes (extractor saw them); ledger pins them regardless.
- `\uses`: 16 refs / 10 distinct, all resolve in-chapter (0 unknown); labels 12/12 unique; `\begin`/`\end` balanced 23/23.
- Official answers conclusion-side: `4/5`, `0.12`, `12 cm` occur only inside the target theorem block (statement/proof) and nowhere as a hypothesis; verified by inspection.
- Markers untouched: no `\leanok`/`\mathlibok` added; Archon begin/end markers 1/1; exemption NOTE kept verbatim; all other prior content verbatim.
- No other file modified (`git status`: only this chapter `M`).

## Deviations
- None. `leandag` CLI absent under codex harness; DAG/uses checks done via python regex + `.leandag/dag.json` (sibling-writer iter-008 practice).

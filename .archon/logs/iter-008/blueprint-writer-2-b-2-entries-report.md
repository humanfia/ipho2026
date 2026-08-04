# Blueprint Writer Report: 2-b-2-entries
**Status:** COMPLETE

## Changes
- `IPhO2026Problems_problem_IPhO_2026_2_B_2.tex` only (295 ins, 0 del); skeleton (source paragraphs, umbrella `thm:physics:IPhO_2026_2_B_2:target`, iter-002 PhysLean exemption NOTE) kept verbatim; all prior markers untouched.
- Appended `% --- Archon named-quantities coverage (blueprint-writer 2-b-2-entries) ---` + import-policy NOTE mirroring the exemption, then 4 ledger subsections holding 18 blocks in dependency order (nonprivate disk decls grouped as: geometry/data 6, governing-law structures 7, derivation bridges 4, target value theorem 1):
  - Geometry/data: `def:...:Plane`, `:CookerParams`, `:CookerGeometry`, `:mirrorCircle`, `:containerDisk`, `:halfMirrorArc`.
  - Structures: `def:...:AbsorbedRays` (specular-reflection law + Figure-2f branch hypotheses recorded as bundled assumptions), `:collectedWidth`, `:UniformIntensity`, `:PowerBudget` (P=I·width, P0=I·2a accounting), `:B1Calibration`, `:incidenceAngle`, `:ThetaMaxSpec`.
  - Bridges: `lem:...:impactParam_le_aperture` (Cauchy–Schwarz on mirror circle), `:collectedWidth_eq_radius` (sup=R via aperture bound + full side coverage), `:power_ratio_eq_width_ratio` (intensity cancels), `:radius_over_diameter_eq` (double-angle factor 2a=2R sinθ(1−cosθ)).
  - Target: `thm:...:power_ratio_in_terms_of_theta_max` (P/P0 = 1/(1−cos θ_max)) — official value confined here (and its algebra twin inside `radius_over_diameter_eq`); no numerics elsewhere conclusion-side.
  - Packaging defs: proof "Definition; no claim."; bridges/target: 1–4-line informal proofs, no tactic names.
- Wired umbrella: `\uses{thm:...:power_ratio_in_terms_of_theta_max}` added to `thm:physics:IPhO_2026_2_B_2:target`.

## Verification
- Pins 18/18: every `\lean{}` maps to a live disk decl (`abbrev/structure/def/lemma/theorem` grep of `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`, namespace on disk `IPhO2026_2_B_2`); every disk decl pinned, none left over. Directive-mandated pin prefix `IPhO2026.Problem2.B2.*` used as ordered; each matches its live `lean:IPhO2026_2_B_2.<name>` DAG node under structural typing (suffix-equal, e.g. `.Plane`, `.power_ratio_in_terms_of_theta_max`).
- `\uses`: 18 distinct refs, all resolve in-chapter (0 unknown); no dup labels; `\begin`/`\end` balanced 39/39; no `\leanok`/`\mathlibok` added.
- `leandag` CLI absent under codex harness; checks done via grep+python over `.leandag/dag.json` and the tex (pre-existing snapshot does not include my new blocks yet).
- No other file modified by me (other dirty chapters are sibling iter-008 writers).

## Deviations
- None (mandated `IPhO2026.Problem2.B2.*` pins vs on-disk `IPhO2026_2_B_2.*` namespace is the intentionally structural-typed segment difference, matching the iter-008 sibling-ledger reports, e.g. 2-c-3-entries).

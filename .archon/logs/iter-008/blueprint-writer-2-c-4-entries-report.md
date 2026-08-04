# Blueprint Writer Report: 2-c-4-entries
**Status:** COMPLETE

## Changes
- `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_4.tex` only; skeleton (source paragraphs, `thm:physics:IPhO_2026_2_C_4:target`, iter-002 exemption NOTE) kept verbatim; ledger appended after the archon-end marker.
- Added `% --- Archon named-quantities coverage (blueprint-writer 2-c-4-entries) ---` + import-policy NOTE + 4 subsections, 7 blocks:
  - `def:...:HalfCylindricalMirrorCaustic` — pin `IPhO2026_2_C_4.HalfCylindricalMirrorCaustic`; mirror/caustic data structure (geometry first).
  - `def:...:smallAngleFilter` — pin `.smallAngleFilter`; positive-side filter, branch/orientation note.
  - `def:...:InSmallAngleRegime` — pin `.InSmallAngleRegime`; `0<θ<1` predicate.
  - `def:...:CausticPowerLawForm` — pin `.CausticPowerLawForm`; uses smallAngleFilter; generic parametric leading-order form.
  - `def:...:SatisfiesCausticPowerLaw` — pin `.SatisfiesCausticPowerLaw`; uses CausticPowerLawForm; C.4-constants packaging.
  - `lem:...:smallAngleRegime_mem_filter` — pin `.smallAngleRegime_mem_filter`; uses InSmallAngleRegime, smallAngleFilter; bridge lemma with informal proof.
  - `thm:...:caustic_small_angle_power_law` — pin `IPhO2026_2_C_4.HalfCylindricalMirrorCaustic.caustic_small_angle_power_law` (folded projection, exact disk name); uses HalfCylindricalMirrorCaustic, SatisfiesCausticPowerLaw; carries the official C.4 answer `u=R/2, v=(3/4)R^{1/3}, p=2, q=3`, conclusion-side only.
- All packaging blocks: proof "Definition; no claim."; no tactic names; no numerics off conclusion-side.
- Wired umbrella `thm:physics:IPhO_2026_2_C_4:target` with `\uses{thm:IPhO2026Problems_problem_IPhO_2026_2_C_4:caustic_small_angle_power_law}`.

## Verification
- Pins grep-match disk names: 7/7 (namespace `IPhO2026_2_C_4`, flat underscore — matches directive's iter-008 re-derivation).
- `\uses` resolve in-chapter: 0 unknown (9 labels, 6 distinct use-targets, all local).
- `leandag build` + `archon dag-query unmatched`: no `IPhO2026_2_C_4.*` decl remains unmatched; no isolated C.4 node (7 graph edges among C.4 blocks, incl. umbrella wiring).
- begin/end balanced (17/17, env-stack check OK); official power-law values confined to the target theorem; no `\leanok`/`\mathlibok` markers touched; no other file modified.

## Official-value location
`thm:IPhO2026Problems_problem_IPhO_2026_2_C_4:caustic_small_angle_power_law` only.

## Deviations
None.

# Blueprint Writer Report: 2-a-1-entries
**Status:** COMPLETE

## Changes
- `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_A_1.tex` only (+125, -0); all prior content verbatim (source paragraphs, umbrella `thm:physics:IPhO_2026_2_A_1:target`, iter-002 PhysLean exemption NOTE, all archon markers).
- Umbrella wired per directive: `\uses{thm:...:threshold_x_N, thm:...:limiting_ray_reflection_count}` added to the physics target.
- Appended `% --- Archon named-quantities coverage (blueprint-writer 2-a-1-entries) ---` + import-policy NOTE (mirrors exemption; disk-verified single `import Mathlib`), then ledger in dependency order:
  - `\subsection*{Threshold geometry and data}`: `def:...:HalfCylindricalMirror` (pin `IPhO2026_2_A_1.HalfCylindricalMirror`) — radius/staircase/threshold-sequence fields + bundled Figure-2e readouts & specular reflection-count law all recorded assumption-side; no threshold value fixed by any field. Proof: "Definition; no claim."
  - `\subsection*{Derivation bridges}`: `thm:...:limiting_ray_reflection_count` (pin `...limiting_ray_reflection_count`; uses HalfCylindricalMirror; impact points odd multiples of `\pi/(2N+1)`, total `N+1`); `thm:...:threshold_forms_agree` (pin `...threshold_forms_agree`; uses HalfCylindricalMirror; `\sin`/`\cos` complementary-angle bridge).
  - `\subsection*{Target value theorems}`: `thm:...:threshold_x_N_cos` (uses HalfCylindricalMirror, limiting_ray_reflection_count), `thm:...:threshold_x_N_sin` (uses HalfCylindricalMirror, threshold_x_N_cos, threshold_forms_agree), `thm:...:threshold_x_N` (uses HalfCylindricalMirror, threshold_x_N_sin, threshold_x_N_cos; conjunction packaging). 1-3-line informal proofs; no tactic names.
- Official threshold formulas (`R\,\cos(\pi/(2N+1))`, `R\,\sin((2N-1)\pi/(4N+2))`) confined to the conclusion-side bridges/target blocks (and skeleton recorded-answer paragraph, verbatim).

## Verification
- Pins 6/6 exact disk decls (grep-verified; flat namespace `IPhO2026_2_A_1`, file `IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`); every non-private disk decl pinned, none left over. Folded projections each get their own block (finest-grain; family-grouping not needed).
- `\uses`: 10 refs, 0 unknown in-chapter (scripted label/uses cross-check); no dup labels; begin/end balanced (1 def / 6 thm / 7 proof); 0 `\leanok`, 0 `\mathlibok`; markers untouched.
- `leandag` CLI not on PATH in this worker; DAG edges verified by scripted label/uses cross-check instead.
- Only this chapter modified by me (other dirty chapters are sibling iter-008 writers).

## Deviations
- None.

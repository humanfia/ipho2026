# Blueprint Writer Report: 3-b-2-entries
**Status:** COMPLETE

Chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_2.tex` (only file touched by me). Kept all prior content verbatim (source paragraphs, `thm:physics:IPhO_2026_3_B_2:target`, iter-004 import-policy NOTE); appended `% --- Archon named-quantities coverage (blueprint-writer 3-b-2-entries) ---` + import-policy NOTE mirroring the exemption, then 4 ledger subsections (quantities/geometry, governing-law structures, derivation bridges, target value theorem). 190 insertions, 0 deletions; no markers added/removed.

## Blocks added (label — \lean pin)
- `def:...:TorusParameters` — `IPhO2026_3_B_2.TorusParameters` (V, n, K, \lambda, \mu_0 with positivity)
- `def:...:ParamagneticTorusState` — `IPhO2026_3_B_2.ParamagneticTorusState`
- `def:...:StatePath` — `IPhO2026_3_B_2.StatePath`
- `def:...:AdiabaticEndpoints` — `IPhO2026_3_B_2.AdiabaticEndpoints`
- `def:...:adiabaticInvariant` — `IPhO2026_3_B_2.adiabaticInvariant`
- `def:...:ParamagneticTorusLaws` — `IPhO2026_3_B_2.ParamagneticTorusLaws`
- `def:...:IsAdiabaticPath` — `IPhO2026_3_B_2.IsAdiabaticPath`
- `lem:...:adiabatic_invariant_along_path` — `IPhO2026_3_B_2.adiabatic_invariant_along_path`
- `lem:...:endpoint_relation` — `IPhO2026_3_B_2.endpoint_relation`
- `lem:...:lam_add_mu0_K_sq_pos` — `IPhO2026_3_B_2.lam_add_mu0_K_sq_pos`
- `thm:...:adiabatic_temperature_change` — `IPhO2026_3_B_2.adiabatic_temperature_change`

## Umbrella wire
- `thm:physics:IPhO_2026_3_B_2:target` now carries `\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_B_2:adiabatic_temperature_change}`.

## Verification
- Pins 11/11 unique `\lean{}` names grep-match disk decls (namespace `IPhO2026_3_B_2`, flat, verified first-hand; 7 packaging defs + 3 lemmas + 1 theorem; every non-private disk decl pinned, none left over).
- `\uses{}`: 11 distinct refs, all resolve in-chapter, 0 unknown (comment lines excluded from the check to avoid `\uses{}` prose matches).
- `\begin`/`\end` balanced: definition 7, lemma 3, theorem 2, proof 12, itemize 1. No duplicate labels. No `\leanok`/`\mathlibok` touched.
- Official value `\Delta T = T_i(\sqrt{(\lambda+\mu_0 K H_f^2)/(\lambda+\mu_0 K H_i^2)} - 1)` confined to the target-theorem entry (statement + its own proof step) plus the pre-existing recorded-answer paragraph; assumption-side blocks carry only hypothesis equations.

## Deviations
- `leandag` CLI not on PATH under this harness; `\uses{}`/pin checks done via grep+python over the tex and `.lean` (0 unknown, 0 isolated new blocks: state/parameter defs feed laws/bridges; bridges feed the target theorem; target theorem feeds umbrella).

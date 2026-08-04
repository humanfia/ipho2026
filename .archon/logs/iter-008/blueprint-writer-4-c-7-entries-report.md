# Blueprint Writer Report: 4-c-7-entries
**Status:** COMPLETE

## Changes (only `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex`)
- Skeleton kept verbatim (source paragraphs, iter-004 PhysLean NOTE, umbrella theorem). Only skeleton edit: `\uses{thm:...:acrylicConductivity_officialSample}` added to `thm:physics:IPhO_2026_4_C_7:target` (directive item 5).
- Appended `% --- Archon named-quantities coverage (blueprint-writer 4-c-7-entries) ---` + 4 `\subsection*` ledgers in dependency order, 7 blocks covering all 8 live decls:
  - Quantities & data: `def:...:ThermalExperimentData` (pin `IPhO2026.Problem4.C7.ThermalExperimentData`; readout content marked, no governing law); `def:...:CylindricalWallGeometry` (pins `.CylindricalWallGeometry` + folded `.lateralArea`; Fig-17 radii/height = assumption-side readouts).
  - Governing-law structures: `def:...:LumpedHeatFlowLaw` (Eq. (4), uses ThermalExperimentData); `def:...:RadialFourierConduction` (Eq. (6) + steady fields; uses CylindricalWallGeometry).
  - Bridges: `lem:...:RadialFourierConduction.wall_current` (pin `.RadialFourierConduction.wall_current` — a theorem on disk, own lemma block; uses RadialFourierConduction).
  - Value theorems: `thm:...:acrylicConductivity_formula` (uses all 4 def blocks; integration-sketch proof, no tactic names); `thm:...:acrylicConductivity_officialSample` (no uses — takes the formula as hypothesis hformula, per disk docstring).

## Verification
- Pins: 8/8 grep-verified exact on-disk fully-qualified decl names (namespace-tracking script over `namespace`/`end` blocks). On-disk namespace is `IPhO2026.Problem4.C7` — the directive's `IPhO2026.Problem3.C4` was stale; deviation recorded and correct pins used.
- `\uses{}`: 5 distinct labels, 0 unknown (in-chapter scripted cross-check); `\cref` targets 2/2 resolve. `\begin`/`\end` balanced (4 def / 1 lem / 3 thm incl. umbrella / 8 proof / 1 itemize); braces balanced.
- Official value `0.25 ± 0.01 W/(m·K)` confined to `acrylicConductivity_officialSample` block + verbatim recorded-answer source paragraph + the ledger's own bookkeeping comment; nowhere else. No `0.18 ± 0.02` anywhere (directive guessed value; disk records 0.25 ± 0.01).
- Markers: 0 `\leanok` / 0 `\mathlibok` in chapter before and after; none added, none touched. No other file modified by this worker (`git diff -- blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex` = 152 added lines only).
- `leandag` CLI not on PATH in this worker; DAG edges verified by the scripted label/uses cross-check above instead.

## Official value lives
`thm:IPhO2026Problems_problem_IPhO_2026_4_C_7:acrylicConductivity_officialSample` (conclusion side only, as `|λ − 0.25| ≤ 0.01`).

## Deviations
- Directive's namespace `IPhO2026.Problem3.C4` stale → actual `IPhO2026.Problem4.C7` used in all `\lean{}` pins.
- Directive's guessed official value `0.18 ± 0.02` wrong → disk records `0.25 ± 0.01 W/(m·K)`; disk transcribed.
- `wall_current` is a theorem (not a structure projection) → own `lemma` bridge block instead of folding; `lateralArea` (a def) folded into `CylindricalWallGeometry` per directive.

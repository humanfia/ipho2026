# Blueprint Writer Report: 4-a-1-entries
**Status:** COMPLETE

Only file touched: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_1.tex` (+241 lines, 0 deletions; skeleton source paragraphs, umbrella, iter-002 exemption NOTE verbatim). Lean file `IPhO2026Problems/problem_IPhO_2026_4_A_1.lean` read in full first-hand; statements transcribed as-is.

## Changes
- Umbrella wired: `thm:physics:IPhO_2026_4_A_1:target` gains `\uses{...:mass_of_confined_air, ...:number_of_molecules_of_confined_air, ...:molar_mass_consistency, ...:uncertainty_consistency}` (all four final value theorems; only that skeleton edit).
- Appended `% --- Archon named-quantities coverage (blueprint-writer 4-a-1-entries) ---` + 4 `\subsection*` ledgers, dependency order, 10 blocks covering all 17 live decls:
  - Quantities/geometry: `def:...:MeasuredQuantity` (4 pins: struct + folded `lower`/`upper`/`PropagatesTo`); `def:...:ConfinedAirColumn` (1 pin; all ~42 fields incl. propagation certs + governing laws described, assumption-side).
  - Calibration data: `def:...:OfficialReadouts` (readout record, data not hypotheses); `def:...:CompatibleWithReadouts` (interval-membership checking contract).
  - Bridges: `volume_closed_form` (V=π(d/2)²H), `amountFromIdealGas` (n=PV/RT), `mass_pos_of_volume_pos`, `numberOfMolecules_pos` (positivity sanity).
  - Value theorems last: `mass_of_confined_air` (m=ρV; 0.94±0.02 g), `number_of_molecules_of_confined_air` (N=nN_A; (1.95±0.05)e21), `molar_mass_consistency` (m=nM_air; uses both routes), `uncertainty_consistency` (nonneg + |N−N_A·n| ≤ u_N+u_n·N_A; uses MeasuredQuantity/ConfinedAirColumn/number_of_molecules).
- Packaging defs: "Definition; no claim." Bridges/values: 1–3-line algebra sketches; no tactic names; no off-conclusion numerics in proof blocks.

## Verification (scripted)
- Pins: 16/16 grep-verified exact on-disk names (namespace-tracking regex over `structure|def|theorem` decls); full 17-decl inventory present (ConfinedAirColumn = 1 pin for the structure).
- `\uses{}`: 7 distinct labels target-side… all resolve in-chapter, 0 unknown; 14 labels total, 0 duplicates; `\begin`/`\end` balanced (4 def / 9 thm incl. umbrella / 13 proof).
- Official values (0.94±0.02 g, 3.24±0.7 mmol, (1.95±0.05)e21, 85±2 mL) confined to: verbatim recorded-answer skeleton paragraph, ledger bookkeeping comment, `OfficialReadouts` (assumption-side readout record, per disk docstring), and the 4 value-theorem conclusion blocks. Nowhere else.
- Markers: 0 `\leanok`/0 `\mathlibok` before and after; none touched. No other file modified by this worker.
- `leandag` CLI not on PATH; edges verified by scripted label/uses cross-check (same fallback as sibling writers 1-a-1, 3-c-4, 4-c-7).

## Official value lives
`thm:IPhO2026Problems_problem_IPhO_2026_4_A_1:mass_of_confined_air` / `:number_of_molecules_of_confined_air` / `:molar_mass_consistency` / `:uncertainty_consistency` — conclusions only, mirroring the disk (answers live only in the final value theorems).

## Deviations
- Directive/leandag claimed namespace `IPhO2026.Problem4.A1`; on-disk namespace is flat `IPhO2026_4_A_1` (verified first-hand, line 41 of the .lean file). All `\lean{}` pins use `IPhO2026_4_A_1.<name>`; mismatch recorded in a ledger header comment.
- Readout numerics (H=9.5, V=85±2, m, n, N readouts) appear in `OfficialReadouts` block: justified — the disk docstring defines that structure exactly as these recorded data; not answer-conclusion content.

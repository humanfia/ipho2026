# Blueprint Writer Report: 4-b-4-entries
**Status:** COMPLETE

## Changes
- Appended `% --- Archon named-quantities coverage (blueprint-writer 4-b-4-entries) ---` ledger to `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_4.tex` (all prior skeleton content verbatim; +190 lines).
- 9 blocks, 11 `\lean{}` pins — verified 11/11 exact on-disk (flat namespace `IPhO2026_4_B_4`, `import Mathlib`):
  - quantities/data: `GasColumnGeometry`, `gasVolume`, `VaporPressureB4Data`
  - folded projections: `VaporPressureB4Data.MeasuredState` + `referenceState` (family-grouped, one block, 2 pins)
  - governing law: `ClausiusClapeyron` (recorded as context, explicitly non-hypothesis of the B.4 target)
  - bridges: `dryAirPartialPressure_at_T₀`, `total_pressure_mul_volume`, `eq_zero_of_clausiusClapeyron_zero` (context lemma)
  - value/target: `vaporPressure_eq`, `target`
- Umbrella wired: `\uses{thm:IPhO2026Problems_problem_IPhO_2026_4_B_4:target}` added inside `thm:physics:IPhO_2026_4_B_4:target`.
- Official answer `P_v = P_atm*(1 - (H_0*T)/(H*T_0))` confined to the conclusion-side blocks `vaporPressure_eq`/`target` (+ pre-existing recorded-answer paragraph and ledger header comment, verbatim).

## Verification
- pins 11/11 grep-matched against exact decl lines (0 errors / 2 contracted sorries on disk = frozen contract).
- `\uses{}` resolves 0 unknown in-chapter (12 labels incl. `ch:` anchor, `thm:physics:` umbrella).
- begin/end balanced: definition 5, lemma 3, theorem 3, proof 11/11.
- Skeleton markers/NOTE untouched; no `\leanok`/`\mathlibok` added; only the one chapter file modified.
- `leandag` CLI not on PATH in this environment (`which leandag` empty); cross-checked edges manually + against `.leandag/dag.json` presence.

## Deviations
- Directive bucket listed 11 names; on-disk match: `MeasuredState` and `referenceState` are separate decls — both pinned into the family-grouped state block (per sibling convention); no extra pin-fix decl found on disk (all 11 match exactly).
- `T₀` subscript in `dryAirPartialPressure\_at\_T₀` pin kept as literal Unicode (on-disk spelling), matching the `ΔU` pin convention in chapter 1_C_2.
- Import-policy NOTE mirrored in ledger header (Mathlib baseline, PhysLean exemption) per sibling ledgers.

# Session 2 (iter-002) review summary — autoformalize repair wave

## Bottom line
11/11 repair-wave targets compile clean (53 expected `by sorry` bodies, 0 errors). Under the mandatory per-target `formalization_review` gate: **0 passed / 11 failed**, all `status=partial`. Eight of the eleven failures trace to a single systematic blocker — the blueprint-doctor's `missing-physlib-import` finding, which conflicts with the reconciled iter-002 import policy and its planner-recorded `% NOTE:` exemptions — and should not trigger file rewrites. Two targets carry genuine statement-level defects found by this review (1_B_1, 4_C_6), and two carry grounding-register blockers (3_A_2, 4_C_6).

## Verdicts per target (root blocker in brackets)
| target | compile | sorries | formalization_review | root blocker |
|---|---|---|---|---|
| 1_B_1 | ✓ | 5 | failed | countermodel: universal `attainedSeparations` vs external `IsBoundMu` (admitted E>0 instances falsify the maximum) + doctor import |
| 1_B_2 | ✓ | 7 | failed | doctor `missing-physlib-import` (semantics green) |
| 1_C_1 | ✓ | 6 | failed | doctor `missing-physlib-import` (semantics green) |
| 1_C_2 | ✓ | 2 | failed | doctor `missing-physlib-import` (semantics green; numeric band verified) |
| 2_C_4 | ✓ | 1 | failed | doctor `missing-physlib-import` (semantics green) |
| 3_A_1 | ✓ | 6 | failed | doctor `missing-physlib-import` (semantics green; `scalar-fallback` cleared) |
| 3_A_2 | ✓ | 2 | failed | grounding log noise-only + doctor ignores genuine `Physlib.Electromagnetism.Dynamics.Basic` import |
| 3_B_1 | ✓ | 3 | failed | doctor `missing-physlib-import` (semantics green) |
| 3_C_2 | ✓ | 10 | failed | doctor `missing-physlib-import` (semantics green) |
| 3_C_3 | ✓ | 8 | failed | doctor `missing-physlib-import` (semantics green) |
| 4_C_6 | ✓ | 3 | failed | grounding-register contradiction + `official_sample_value` numerically false vs its own readouts (0.595 K/W vs recorded 1.17±0.03) |

## Doctor report (blocking entries quoted)
- 19 `physics_modeling_problems`, all `missing-physlib-import`, including 10 of the 11 reviewed files. Reason string (uniform): “physics target does not import Physlib/PhysLean; grounding should use the configured domain library before introducing local abstractions”. Files: 1_A_1, 1_B_1, 1_B_2, 1_C_1, 2_A_1, 2_B_1, 2_B_2, 2_B_3, 2_C_1, 2_C_2, 2_C_4, 3_A_1, 3_B_1, 3_C_2, 3_C_3, 3_C_4, 3_C_5, 4_A_1, 4_B_4.
- `physics_grounding_problems`: []. Orphan chapters: []. Broken/malformed refs: []. Covers problems: []. No `scalar-fallback` (3_A_1 repair effective) and no leftover missing-mathlib-import truncations (3_A_2/1_B_2/3_C_3 repair effective).
- Policy conflict note: every reviewed file except 4_C_6 (`Physlib.Units/Thermodynamics/SpaceAndTime`, genuinely used) and 4_C_7 (not in target set) is flagged, yet the chapters carry the iter-002 planner `% NOTE:` PhysLean-coverage exemption mandated by the iter-001 review ruling. Notably, 1_C_2 (`import Physlib`) and 3_A_2 (`import Physlib.Electromagnetism.Dynamics.Basic`, used for `FreeSpace`) are flagged anyway — the check appears to match a restricted module allowlist rather than actual Physlib usage.

## \leanok sync attribution
`sync_leanok-state.json`: iter=2, scope `current-objectives`, targets_checked = exactly the 11 files, added=0, removed=0. The surviving `\leanok` on `thm:physics:IPhO_2026_1_B_1:target` (chapter annotated `% STALE-LEANOK iter-001 …`) is therefore the sync's deterministic non-action on an already-present marker, not headline laundering. Planner should remove it during the 1_B_1 redraft; no CRITICAL raised.

## Grounding-log audit
- Real, usable LeanExplore registers: 1_B_1, 1_B_2, 1_C_1, 1_C_2, 2_C_4, 3_A_1, 3_C_2, 3_C_3, 3_B_1 (task-report LeanExplore sections name grounded Mathlib/PhysLean names actually used; near-miss PhysLean queries documented for the Coulomb/photodissociation/magnetocaloric domains).
- Noise-only deterministic preflight registers (BLOCKER per gate): 3_A_2 and 4_C_6 — the `physics-grounding-*.md` logs list only `Path.target`, `semiformal_result`, `stereographic_target` hits. 4_C_6 is contradictory: its task report documents genuinely grounded, compile-verified PhysLean units APIs and six used targeted imports; the deterministic log shows none of them. Rerun the grounding preflight for both; treat the task-report section as register of record when the preflight is noise.

## New reusable findings (candidates for PROJECT_STATUS Knowledge Base)
1. Universal-set carrier + external branch predicate ⇒ countermodel: defining the physical set as `{r | law(r)}` while the branch making the target true (E<0, bound orbit) is only a theorem-level predicate on opaque constants lets lawful branch-violating instances falsify the target. Branch predicates must be data-structure constraints. (1_B_1; verified numerically: with E>0, attained set right-unbounded, so `orbitBound` false under all hypotheses.)
2. `value ± band` official-sample instances must be arithmetic-checked against the file's own readouts: 4186·0.55·7.3e-4 ↦ 0.595 K/W, which falsifies the documented 1.17±0.03 claim of 4_C_6's `official_sample_value`; an existential over a typed wrapper witnessed by the recorded number compiles vacuously despite the physical falsehood.
3. Exact-rearrangement check for tiny computed bands: C.2's gap = r·(2−√(4−6r))/r − ΔU form reduces to (3r/4)·ΔU at r≪1 — used to verify 2.0297e-11 eV inside the stated 2.02–2.04e-11 band for r=2.4602e-11 (16 amu, ΔU=1.10 eV).
4. Deterministic grounding preflights can regress to pure noise (`Path.target`/`stereographic_target` hits only) — detected by comparing against the task-report LeanExplore section; gate should rerun, not redraft.
5. Doctor `missing-physlib-import` matches a restricted allowlist: it flags files with genuine `import Physlib` / `import Physlib.Electromagnetism.Dynamics.Basic` usage. Until reconciled, its positive instances are not actionable per-file.

## Faithfulness spot checks performed this session
- 1_B_1: full structure/law-field read; confirmed hypothesis lists of target theorems are answer-free; confirmed `maximum_separation_T1_B1` is genuinely proved from the two sorry bridges; confirmed the residual universal-set countermodel.
- 1_C_2: independent numeric verification of the 2.03e-11 eV band (above).
- 4_C_6: independent evaluation of the sample-value constants (above).
- 1_B_2/2_C_4/3_B_1/3_C_2/3_C_3: confirmed branch/sign carriers (`perp`, `direction_toward_pair`, `smallAngleFilter`, `ProcessKind` fields) are hypothesis-borne; recorded values appear only conclusion-side.

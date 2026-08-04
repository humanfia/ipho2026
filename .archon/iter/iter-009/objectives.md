# Iter-009 objectives — dispatched + planner-side work record

## Subagent dispatches (this phase)

| Lane | Subagent | Slug | Directive | Status | Time |
|---|---|---|---|---|---|
| O1: 2_B_2 aperture-coverage statement repair | refactor | `2-b-2-aperture-coverage` | `logs/iter-009/refactor-2-b-2-aperture-coverage-directive.md` | COMPLETE | 108 s |

- O1 verification (planner, first-hand): `full_side_coverage : ∀ y ∈ Set.Ioo (0:ℝ) p.R, …` L122; header doc sentence updated; diff = field + doc only (lane report: no renames/deletions, no cascading breakage, no new sorries). Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`: EXIT 0, 0 errors, exactly 5 sorry warnings L177/L186/L193/L201/L212 (zero drift from pre-repair lines). `config.json` refactor enable reverted post-dispatch.

## Planner-side blueprint work (within planner write domain)

1. **`2_B_2` chapter** (`blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_2.tex`):
   - INCIDENT: found truncated to the 51-line iter-002 skeleton at phase start; restored the 18-block iter-008 ledger + umbrella `\uses{thm:…:power_ratio_in_terms_of_theta_max}` + import-policy exemption NOTE (mirror of `2_B_1`'s).
   - T1 content: clause-(e) prose strengthened to $(0, R)$; `% NOTE: Statement reconciliation (iter-009, session-8 R1)` recording the countermodel ($R=1, a=0.1$: $P/P_0 = 5 \neq 1.005$) and the source warrant; `collectedWidth_eq_radius` proof block rewritten to the open-half-aperture argument; its `\uses{}` gained `def:…:CookerParams`.
2. **`1_C_2` chapter** (session-8 R2): new blocks `def:…:ThresholdBalance`, `def:…:LowerRootBranch`, `thm:…:threshold_excess_enclosure`, `def:…:mc2eV_trusted`, `lem:…:mc2eV_trusted_{pos,big,num_form}`, `lem:…:thresholdBalance_to_ev_units` — one-line informal proofs each; both C.2 target theorems' `\uses{}` rewired onto these + `ThresholdRealizable`, `angular_factor_at_pi_div_six`, `hbarOmegaMin_at_pi_div_six`, `rest_energy_gap_nonneg`; `% NOTE` flagging the upstream C.1 formula factor-2 finding (source-report data fix, TO_USER-level).
3. **`3_C_3` chapter**: projections/readout lemma block now pins all 6 projections + 6 `_pos` + 6 `_value` rfl steppers; new `vacuumPermeability`/`vacuumPermeability_pos` anchor; stale "opaque supplied-data" prose modernized (the record is transparent `noncomputable` with literal values).
4. **Post-wave verification**: fresh `leandag build` → `dag-query unmatched` 49 → **33** (32 `1_B_1` deferred + 1 `hello`, both designed residuals); `dag-query gaps` 0; `archon blueprint-doctor` clean; `lake env lean` green on `1_C_2`, `3_C_3` (0 errors; 2 pre-existing pos-linter warnings on `1_C_2`, cosmetics scheduled with next touch).

## Not dispatched this iter (recorded routes)

- The 16 review-retry lanes (2/3-class and 1/3-class): statements frozen; deterministic review pass is their next consumer (queue named in PROGRESS.md). No statement changes pending on any of them.
- `1_B_1`: no 4th redispatch (gate-exhausted ×4; prover-stage proof-Review redraft only; 32-decl blueprint batch sequenced after that reopen).
- `4_C_6`: 2/3 provenance-blocked (`raw/E1_solution.pdf` absent; TO_USER); re-review on placement, else gate-documented quarantine-delete fallback.
- `hello` (`IPhO2026Run/Basic.lean` scaffolding): entry-or-`private` decision at polish stage; outside every covered file.
- Session-8 R3/R4 audit items (C-family `/(2T)` note; `1_A_1` hinge ghost field): factor-insensitive / zero derivability impact today; routed to prover-stage refactor queue in PROGRESS memory.

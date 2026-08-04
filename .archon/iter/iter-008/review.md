# Iter-008 review (session_8) — deterministic review pass over the 25-target queue

## Scope & method

Exactly the 25 objectives in `logs/iter-008/deterministic-review-candidates.md` (the full 26-lane review queue minus `4_A_5` passed iter-007 and minus excluded residuals `1_B_1`, `4_C_6`). Compile consumed from the orchestrator parallel preflight (`review-preflight.md`, 41.074 s, 25/25 passed; no-rerun rule — no `lake env lean`/`lake build` issued by this review). `logs/iter-008/blueprint-doctor.json` read as the injected structural/physics verdict; no leandag rebuild, no repo-wide scans. Semantic audit from the bounded pack + first-hand full reads of `1_A_1` and `2_B_2` (the two named spot risks), the gate ledger, `sync_leanok-state.json`, attempts_raw.jsonl, and per-target report excerpts. No subagents enabled; physics checklist applied directly.

## Metrics

- Compile: 25/25 PASSED; sorries at contracted counts, with three files now sorry-free (`1_C_2`, `2_B_1`, `3_C_3` — all honestly discharged).
- Verdicts: **24 passed / 1 failed**; all 25 `formalization_review` blocks structurally validated (6 checks each, non-empty bridges, no `passed` with a blocked bridge).
- Gate: `2_B_2` retry 0/3 → 1/3 (failed, second attempt to come); the other 24 pass (14× 1/3-class, 10× 0/3-class). `1_B_1` stays `review_exhausted`; `4_C_6` stays 2/3 provenance-blocked.
- Doctor: `physics_grounding_problems = []`, orphans/refs/axioms/covers all 0. The 18-entry `missing-physlib-import` list inside `physics_modeling_problems` is the iter-003 stale snapshot (7th iter) — formally retired again; positive targeted-import cases (`2_C_3`, `3_A_3`, `4_C_7`) absent from it, exemption NOTEs present everywhere; NOT counted as a live blocker.
- sync_leanok: iter=8, these 25 targets, added=0/removed=0 — deterministic non-action, no laundering.

## Key adjudications

1. **`2_B_2` FAIL — missing aperture-coverage hypothesis (primary blocker).** The chapter-advertised route `P/P₀ = R/(2a) ∘ = 1/(1−cosθ)` requires `collectedWidth = R`; `AbsorbedRays.full_side_coverage` only covers the container silhouette band `(0, a)`. Constructive countermodel recorded in milestones (`R=1, a=0.1`, thin fan): every hypothesis holds, `P/P₀ = 5`, `1/(1−cosθ_max) ≈ 1.005`. The lane's own report flagged the same hole ("likely needs `B1Calibration` threaded in, or an explicit aperture-coverage field") — confirmed live and statement-level. Failure carried by `derivability` + `countermodel_resistance`; 2 blocked bridges (`collectedWidth_eq_radius`, `power_ratio_eq_width_ratio`); `radius_over_diameter_eq` covered. Repair contract in recommendations R1 (strengthen coverage to `Set.Ioo 0 p.R`, or add explicit coverage/lower-bound field; never weaken the target).
2. **`1_C_2` PASS after in-window redraft (0 sorries).** The frozen C.1 linearization was arithmetically inconsistent with the recorded C.2 answer; the lane replaced it with the momentum-energy balance root form and proved everything (rational two-sided enclosure of `gap ≈ 2.03e-11 eV` within `5e-14`). Ratified as honest repair (the prior statement was FALSE as arithmetic). Follow-ups: blueprint ledger restatement (R2); upstream source-report factor-2 finding (TO_USER-level).
3. **`2_B_1` PASS as over-completion (0 sorries).** Sorry-preserving dispatch; lane finished the 2×2 determinant proofs with statements byte-frozen. Ratified — no reason to prefer sorries with the gate's structured checks green.
4. **`2_C_1` PASS after authorized law strengthening.** Clause-5 outgoing-orientation closes the on-record orientation countermodel; pins 5/5 intact.
5. **`3_C_3` PASS (0 sorries)** with umbrella rewired to `final_temperature_value`; **its cross-file note** (C.2/C.4/C.5 encode the pre-correction B.1 `/(2*T)` law + mirrored geometry) adjudicated as NON-blocking for this pass (internal identities factor-insensitive) and routed to planner audit R3, with a `3_C_3` chapter-prose touch-up.
6. **Cosmetic non-blockers recorded:** `1_A_1 HingeAxis.axis_perpendicular_to_plane : origin = origin` rfl-ghost field (R4 hygiene; gates nothing); `1_C_2` ledger restatement (R2).
7. **Stale-payload discipline.** The injected doctor findings were again adjudicated as the retired snapshot; the gate ledger's recorded failure reasons for 14 targets cite exactly that payload — pointed at loop-level repair R5 (stop re-injecting; pin the upstream patch; fix the grounding-preflight noise class).

## Deferred residuals (unchanged)

`1_B_1` (gate-exhausted; prover-stage redraft only; frozen spec in iter-005/006 objectives; TO_USER stands), `4_C_6` (2/3, `raw/E1_solution.pdf` absent; R6 escalation stands).

## Marker actions

None. `sync_leanok` iter=8 verdict verified against the state file; no `\leanok`/`\notready`/rename work outstanding.

## Stage disposition

One redraft lane (`2_B_2`, R1) + one re-review stands between the queue and a 26/26 closure; stage advance autoformalize → prover is the review phase's output AFTER that re-review, per R7.

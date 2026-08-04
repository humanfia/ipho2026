# Iter-007 review (session_7) — autoformalize repair wave close (1 lane, statement repair)

## Scope & method

1 deterministic candidate: `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` (iter-007 O1 — refactor
subagent `refactor/4-a-5-iso-readout-hT12` landing the session_6-prescribed `hT12` field; second
formalization review of this target, gate 1/3 → 2/3). Compile taken from the orchestrator parallel
preflight (9.087 s wall, 1/1 passed; status `passed` — no-rerun rule). `logs/iter-007/blueprint-doctor.json`
consumed as injected structural/physics verdict; no leandag rebuild, no repo-wide scans. Semantic
audit from the bounded candidate pack plus first-hand reads of the full 353-line on-disk file, the
gate ledger (`formalization-review-gate.json`), `sync_leanok-state.json`, attempts_raw.jsonl, and
the iter-007 candidate-pack report excerpts. No subagents enabled; physics checklist applied
directly.

## Metrics

- Compile: PASSED — 0 errors; exactly 10 sorry warnings (L124/L128/L132/L140/L154/L180/L287/L302/L321/L349)
  = the 10 contracted by-sorry bodies. Unchanged by the refactor (hT12 adds no sorry site).
- Verdicts: **1 passed / 0 failed** — full structured `formalization_review` in milestones.jsonl.
  Checks: source_faithfulness PASS · derivability PASS (3/3 conjuncts) · abstraction_sufficiency
  PASS · uncertainty_propagation PASS · branch_orientation N/A · countermodel_resistance PASS.
  Bridges: 6 covered / 0 blocked.
- Gate ledger: 4_A_5 `retry` reviews 1 → 2 (last_review_iter 7), structured green certificate
  recorded. 1_B_1 stays `review_exhausted`; 4_C_6 stays 2/3 provenance-blocked.
- Doctor: injected 19 `missing-physlib-import` = stale iter-003 snapshot, 6th iter (live patched
  doctor: 0 findings on 28 chapters, reconfirmed by iter-007 planner reruns ×2). 4_A_5 not in the
  problem list — positive targeted-import case. 0 orphans/broken refs/malformed refs/axioms/covers;
  `physics_grounding_problems = []`.
- sync_leanok: iter=7, current-objectives, targets_checked=[4_A_5], added=0/removed=0 —
  deterministic non-action; no laundering.

## What happened on the target

- The lane executed exactly the session_6 repair prescription, minimal surface: `IsochoricReadout`
  gains `(hT12 : T₁ ≠ T₂)` immediately after `T₂` (L228) plus one doc sentence (L218–L220). Diff
  +2/−1. No construction-site churn — `beta0_uncertainty_bound` and `main` both take `readouts` as
  a hypothesis. Field presence, doc placement, and the unchanged theorem/sorry surface were
  re-verified first-hand on disk by this review.
- Chapter sidecar: `% NOTE: Statement reconciliation (planner-recorded, iter-007 …)` records the
  field, the source warrant (A.2 two readouts around the reference temperature; analogy to `main`'s
  `hvar` guard), and the post-repair closure algebra.
- The session_6 live countermodel (T₁ = T₂: premise `0 ≤ 0` for every β₀, conclusion fails at
  `β₀ = 2/T₀ + σ`) is structurally excluded — the instance is no longer constructible.
- Post-repair derivability of conjunct 3 (session_6-blocked bridge, now covered):
  `measured_hP₂ − measured_hP₁` gives the measured increment `β₀·P₀·(T₂−T₁)`; subtracting the ideal
  increment `P₀·(T₂−T₁)/T₀` leaves deviation `= P₀·(T₂−T₁)·(β₀ − 1/T₀)`; `hdev` becomes
  `P₀·|T₂−T₁|·|β₀ − 1/T₀| ≤ P₀·|T₂−T₁|·σ`, and `P₀·|T₂−T₁| > 0` cancels via
  `IsReferenceState.hP₀` + `hT12`.
- Answer discipline re-audited post-repair: `1/T₀`, `0.0037`, `0.0034 ± 0.0007` remain strictly
  conclusion-side; `hT12` is a data-interface non-degeneracy guard, disjoint from every conclusion
  value; no `Laws`/`Valid…`/`Satisfies…` field carries an answer. No globalized approximation
  (exact Eq.-(2) identity in conjunct 2), no ghost propositions.

## Adjudications

1. **Primary: PASS at gate 2/3.** All six mandatory structured checks pass; the bridge inventory is
   6/6 covered including the previously blocked uncertainty carrier. The session_6 failure was a
   pure structural-guard defect; its prescribed one-field repair landed verbatim, and the
   pre-verified closure algebra from session_6 is now applicable.
2. **Noise preflight not re-counted.** The deterministic physics-grounding preflight for 4_A_5 is
   again the generic-noise log (Path.target/semiformal_result/stereographic_target; "None
   detected" for local abstractions) contradicted by the file's real 5-abstraction inventory and
   the task report's register (Temperature id 394201 / Temperature.toReal 394203; near-miss
   IdealGas.ideal_gas_law id 393919, reconfirmed by iter-007 module lookups in the attempts log).
   Per the durable iter-002…006 ruling the task report is the register of record; the preflight
   defect routes to loop-level repair and is not a per-target blocker (this is the same scoring
   rule applied to the doctor-stale-snapshot class since iter-004).
3. **No sibling defect.** The planner's iter-007 fallback audit of the readout-degeneracy class
   (4_C_6 `x_varies`/`t₀≠t₁`, 4_C_7 `hΔT`, 3_C_x ≠-guards) found all other finite-difference
   carriers guarded; the KB pattern from iter-006 is now fully closed out.

## Marker actions

None; sync verified (added=0/removed=0). No `\mathlibok`/rename/`\notready` work outstanding on
this chapter.

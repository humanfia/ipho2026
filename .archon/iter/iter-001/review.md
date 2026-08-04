# Iter-001 review (session_1) — autoformalize wave 2

## Scope & method
- Reviewed exactly the 6 deterministic-candidate targets. Compile results taken from orchestrator preflight (10.8 s, 6/6 passed; no reruns — all statuses `passed`). blueprint-doctor JSON consumed as the structural/physics-doctor verdict. Semantic audit done from candidate excerpts + task reports + first-hand statement reads. No subagents enabled; reviewer applied the physics checklist directly (no dedicated `physics-reviewer` report exists).

## Metrics
- 6/6 compile clean; 34 expected sorries total (10+4+5+4+3+8); 0 errors; 0 unexpected warnings.
- Review verdicts: 6 failed / 0 passed (mandatory `formalization_review` gate). `status=partial` for all (contracts written, proofs pending, review not passed).
- Doctor: 21 `physics_modeling_problems` (18 missing-physlib-import incl. all 6 reviewed; 1 scalar-fallback `3_A_1`; 2 missing-mathlib-import on truncations), 0 grounding problems, 0 orphan chapters, 0 broken/malformed refs, 0 axioms, 0 covers problems.

## What happened per target
- 1_A_1: semantics green (hydrostatic gate; 7-bridge chain; honest `|a-0.50|<1/200` precision). Fail = import blocker only. Two rfl-ish ghost ancillaries noted, non-load-bearing.
- 1_B_1: **statement-level modeling failure** — vacuous `radial_energy` implication, support-by-definition, answer-valued `ha_max_attained`/`hfact` hypotheses. Route: redraft. Plus stale `\leanok` on its chapter (sync iter-001 `added=0/removed=0` ⇒ marker not vouched; recommend removal).
- 2_A_1: semantics green (ncard counting law; staircase contracts; countermodel-resistant). Fail = import blocker only.
- 2_B_1: semantics green (2×2 specular system, tangency/extremal interfaces, 2-config determinant route). Fail = import blocker only.
- 2_C_2: semantics green (genuine `IsLittleO` contracts, C.1 as previous-part hypotheses, acute branch). Fail = import blocker only.
- 3_C_4: semantics green (density-form cycle laws, FTC chain, recorded answer conclusion-side). Fail = import blocker only.

## Root causes & routing
- Import-policy contradiction (doctor vs memory) dominates: resolve once, centrally (recommendations §0) — do not make 6 files oscillate.
- 1_B_1 defect class: proof-obligation demotion crossing the line into answer-as-assumption + ghost Prop interfaces. Detectors recorded in PROJECT_STATUS Knowledge Base.
- sync_leanok gap: with umbrella-only chapters (no `\lean{}` pins) the sync adds nothing but also doesn't clean pre-existing `\leanok` — stale-marker hazard until pins exist.

## Next-iter routing summary
- Redraft: `problem_IPhO_2026_1_B_1.lean`.
- Review-retry after import-policy repair: `1_A_1`, `2_A_1`, `2_B_1`, `2_C_2`, `3_C_4`.
- Backlog (outside target set): `3_A_1` scalar-fallback; `1_B_2`/`3_A_2`/`3_C_3` missing-mathlib-import truncations; note `1_C_1` parse errors on disk.

Full evidence: `proof-journal/sessions/session_1/{milestones.jsonl,summary.md,recommendations.md}`.

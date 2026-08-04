# Iter-009 review (session_9) — deterministic review re-pass over the 17-target queue

## Scope & method

Exactly the 17 objectives in `logs/iter-009/deterministic-review-candidates.md`
(`1_B_2`, `1_C_1`, `2_A_1`, `2_B_1`, `2_B_2`, `2_B_3`, `2_C_2`, `2_C_4`, `3_A_1`,
`3_B_1`, `3_C_2`, `3_C_3`, `3_C_4`, `3_C_5`, `4_A_1`, `4_B_4`, `4_C_6`). Compile consumed
from the orchestrator parallel preflight (`review-preflight.md`, 33.318 s, 17/17 passed;
no-rerun rule — no `lake env lean`/`lake build` issued by this review).
`logs/iter-009/blueprint-doctor.json` treated as the injected structural/physics verdict;
no leandag rebuild, no repo-wide scans. Semantic audit from the bounded candidate pack
plus first-hand on-disk verification of the `2_B_2` repair site (`full_side_coverage`
now `Set.Ioo (0:ℝ) p.R` at L122 — confirmed) and the chapter exemption-NOTE surface
(grep sweep: all 17 chapters carry the import-policy exemption; `2_B_2`'s NOTE restored
with its ledger this iter per PROGRESS). No subagents enabled; physics checklist applied
directly (no `physics-reviewer` in the catalog — noted).

## Metrics

- Compile: 17/17 PASSED; sorries contracted everywhere; sorry-free: `2_B_1`, `3_C_3`,
  `4_A_1` (0 sorries, honestly discharged).
- Verdicts: **16 passed / 1 failed**; all 17 `formalization_review` blocks written with
  6 structured checks each, non-empty bridge inventories, no `passed` with a blocked
  bridge (machine-validated on write).
- Gate outcomes (for the ledger write): 11 final-third reviews pass (2/3→passed):
  `1_B_2`, `1_C_1`, `2_A_1`, `2_B_1`, `2_C_2`, `2_C_4`, `3_A_1`, `3_B_1`, `3_C_2`,
  `3_C_3` (recorded-stale re-registry), `3_C_4`; 5 second reviews pass (1/3→passed):
  `2_B_2` (post-repair), `2_B_3`, `3_C_5`, `4_A_1`, `4_B_4`; `4_C_6` **failed, 3/3
  exhausted** (provenance class; permanently prover-dispatch-blocked per the gate rule).
- Doctor: `orphan_chapters=[]`, `broken_refs=[]`, `malformed_refs=[]`, `axiom_decls=[]`,
  `covers_problems=[]`, `physics_grounding_problems=[]`. The 18 `missing-physlib-import`
  entries inside `physics_modeling_problems` are the iter-003 stale snapshot (8th iter;
  live patched doctor clean at phase end) — formally retired again, NOT a live blocker.
- sync_leanok: iter=9, scope=current-objectives, all 17 targets checked, added=0/removed=0
  — deterministic non-action, no laundering.

## Key adjudications

1. **`2_B_2` PASS — session-8 aperture blocker closed by the iter-009 repair.**
   `full_side_coverage` strengthened from `Set.Ioo 0 p.a` to `Set.Ioo 0 p.R` (verified
   on disk). The session-8 constructive countermodel (`R=1, a=0.1`, thin fan, `P/P₀=5`
   vs `1/(1−cos θ_max)≈1.005`) required `hitSet` support strictly inside `(0,a)` — the
   strengthened field is exactly the clause that instance violates, so it is no longer
   constructible. Derivability chain: full coverage + `no_gap` + `impactParam_le_aperture`
   ⇒ `collectedWidth = R` ⇒ `P/P₀ = R/(2a)` ⇒ `1/(1−cos θ_max)` by the B.1 calibration
   (`radius_over_diameter_eq`). Target statement never touched — repair on the law side
   exactly per session-8 R1 option 1. Now 4/4 bridges covered, all six checks green.

2. **`4_C_6` FAIL — third review, gate exhausted (provenance class).** Compile green;
   statement-level semantics green across all six checks (uncertainty propagation is
   first-class: strict bands, per-input budgets, worst-case law `|1/(q s) − R| ≤
   R(us+uq)` with `us,uq < 1/2` guards, the `/2` mean-error combining convention
   documented load-bearing). Failing basis: the two durable non-statement blockers of
   the ledger reason remain in force with zero new evidence this iter — (i) the sample
   microdata (`a=(2.28±0.06)·10⁻³ 1/s`, `m=(89±1) g`) remain unverifiable in this
   checkout (`raw/E1_solution.pdf` absent, find-verified iter-007; `sources.json`
   records only the final band); (ii) the noise-only grounding-preflight defect in the
   ledger remains unrouted. Per the gate rule the verdict is `failed` at the final
   attempt → permanently blocked from prover dispatch; routes per recommendations R2
   (provenance restore + fresh review, else quarantine-delete). Explicitly NOT counted
   as a pass toward stage convergence.

3. **`3_C_3` PASS (recorded-stale re-registry; 0 sorries).** Certified rational/π
   enclosures (`norm_num`/`nlinarith` with `Real.pi_gt_d4/lt_d4` visible in the tail);
   `suppliedData` remains the transparent noncomputable register (memory rule); umbrella
   rewired to `final_temperature_value` (session-8).

4. **Sorry-free over-completions ratified:** `2_B_1` (the 2×2 determinant discharge is
   visible in the Lean tail — `mul_eq_zero` eliminations under `sin θ ≠ 0`/`sin 2θ ≠ 0`
   with cos strict-antitone on the acute branch) and `4_A_1` (uncertainty budget proved
   by `rw [number_eq]` + nonneg composition; `molar_mass_consistency` a proved re-export).
   Statements byte-frozen in both; proofs strictly better than contracted sorries.

5. **Asymptotic-contract audit clean:** `2_C_2` (both halves `IsLittleO` at `𝓝 0`;
   combined target `exact ⟨·,·⟩`-proved; branch denominators exposed as a bridge lemma),
   `2_C_4` (leading-order power law along `smallAngleFilter`; parametrization-scale guard
   `∃ w>0, X ~ w t^q` makes the exponent meaningful; chapter documents the exact identity
   would be false). Both clear the anti-globalization and branch-orientation rules.

6. **Answer-discipline sweep (16 passing targets):** every recorded official value stays
   conclusion-side in the excerpts (`3_C_5`: "this equation never appears as a
   hypothesis"; `2_B_3`: `cos=4/5`, `0.12 m`, `12 cm` only in the target; `1_B_2`: sign
   carried by the hypothesis-side branch field `perp u0 u_inf ≤ 0`, not chosen at the
   conclusion). `3_C_5`'s dual-route design (C.4-time and direct energy balance) logged
   as countermodel-resistance pattern in the Knowledge Base.

## Dispositions carried to iter-010

- Planner writes the 16 passes + `4_C_6` exhaustion into the gate ledger (R1); stage
  advance to prover is consumable at 25 passed + 2 documented residuals.
- TO_USER (standing, sharpened): restore `raw/E1_solution.pdf` or accept the
  quarantine-delete fallback for `4_C_6` (R2).
- Planner audit (standing): pre-correction factor across `3_C_2/3_C_4/3_C_5` vs the
  settled `3_B_1` contract before prover dispatch consumes them (R3).
- Injector hygiene: stop the stale `missing-physlib-import` re-injection, retired 8
  iters running (R4).
- Prover-stage handoff: sorry inventory + per-target bridge obligations in
  session_9/milestones.jsonl serve as dispatch specs (R5); `1_B_1` re-entry only via
  the frozen redraft spec.

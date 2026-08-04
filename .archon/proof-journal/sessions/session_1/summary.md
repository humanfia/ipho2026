# Session 1 review — iter-001 (autoformalize, wave 2 of 6)

## Metadata
- Stage: autoformalize; 6 exact review targets (deterministic candidate pack).
- Compile: 6/6 passed, 0 errors; sorry counts 10+4+5+4+3+8 = 34 (all expected, autoformalize stage).
- Review verdicts: **6/6 `failed`** under the mandatory formalization gate (per-target JSON in `milestones.jsonl`).

## Headline finding 1 — every listed target carries a LIVE doctor blocker
`blueprint-doctor.json` lists `physics_modeling_problems` (21 entries; grounding list empty; orphans/broken refs/axioms/covers all empty). Of the 6 reviewed targets, **all 6** are flagged `missing-physlib-import`:
- `problem_IPhO_2026_1_A_1.lean`, `problem_IPhO_2026_1_B_1.lean`, `problem_IPhO_2026_2_A_1.lean`, `problem_IPhO_2026_2_B_1.lean`, `problem_IPhO_2026_2_C_2.lean`, `problem_IPhO_2026_3_C_4.lean` — "physics target does not import Physlib/PhysLean; grounding should use the configured domain library before introducing local abstractions".
Per the review gate, a live modeling/grounding doctor blocker ⇒ no target may be marked review-passing; so all 6 verdicts are `failed` even where the semantic audit is otherwise green. Note these findings clash with project memory (`import Mathlib` only, self-contained per `formalization_input_policy`); the conflict must be resolved explicitly next iter (either add targeted `import Physlib...` where a relevant module exists, as wave-2 peers `4_C_6`/`4_C_7` already do, or record a justified, policy-level exemption for domains PhysLean does not cover — see recommendations).

## Headline finding 2 — `problem_IPhO_2026_1_B_1.lean` needs REDRAFT, not proof retry
Semantic audit beyond the import blocker (verified first-hand against the file):
- `CoulombPairData.radial_energy` (the "effective radial law" field) is a **trivially-true implication**: `∀ r, 0 < r → Q(r) ≤ 0 → ∃ r', r' = r`. It asserts nothing — satisfied by reflexive existential regardless of `Q`.
- `attainedSeparations` is **defined** as `{r | 0 < r ∧ Q(r) ≤ 0}` — the identification of the physical orbit support with the quadratic sublevel set is installed by definition, not derived from any orbit/energy hypothesis.
- The two attended-step obligations that carry real physics/continuity content are hypotheses **of the target theorem itself**, answer-valued: `ha_max_attained : (1600/9)*bohrRadius ∈ D.attainedSeparations` and `hfact : ∀ x, Q(x*a0) ≤ 0 → 100 ≤ x ≤ 1600/9` (constant `1600/9` IS the recorded answer in units of a₀).
- Net effect (adversarial countermodel): all structure fields can hold while the physical pair never attains `(1600/9)·a₀`; the conclusion is rescued only by the answer-valued premises. Faithful source coverage yes; derivability from physics-side assumptions no ⇒ `derivability`/`abstraction_sufficiency`/`countermodel_resistance` failed; bridges "support = sublevel set" and "second root attained" marked **blocked**; route next iter: redraft (see recommendations).

## Headline finding 3 — stale `\leanok` on `IPhO2026Problems_problem_IPhO_2026_1_B_1.tex`
The chapter's umbrella theorem environment carries `\leanok` while the covered Lean file has 4 open sorries (include the main target). Sync state `sync_leanok-state.json` says `iter=1, scope=current-objectives, targets_checked = the 6 files, added=0, removed=0` — i.e. the sync add-path laid down **no** markers (these chapters have umbrella nodes only, no `\lean{}` pins), and the pre-existing `\leanok` was not removed/re-affirmed either. Its verdict therefore does not vouch this marker. Review override: this `\leanok` is **misplaced**; plan agent should delete it (or leave removal to a corrected sync) when redrafting 1_B_1. I did not edit the chapter (bounded-review scope keeps blueprint writes out of this pass; recorded for the plan iter).

## Per-target audit summary (statements judged independently of proof completion)
- **1_A_1** (`hydrostatic_gate_side_length_a_target`): PASS-worthy semantics. Source/figure/units faithful (slot `a√2/2`, density `3ρ₀`, hinge O, `Δh=1.41`); torque-balance law chain B1–B7 pinned as eliminable equations; answer `a=Δh/(2√2)` conclusion-side only; honest precision clause `|a-0.50|<1/200`. Two near-ghost ancillaries noted (`HingeAxis.axis_perpendicular_to_plane : origin=origin` rfl-field; `pressure_at_hinge` existentially reflexive) — neither carries a bridge; style note only. Failed solely on the doctor import blocker.
- **1_B_1**: semantics failed (finding 2). Source faithfulness/branch/uncertainty checks pass; grounding log exists + theorem-level near-miss analysis is documented and adequate.
- **2_A_1** (`threshold_x_N`): PASS-worthy semantics. Counting law as full-branch functional equation via `Set.ncard` of odd multiples; staircase definition + edge-count convention match Fig. 2e; countermodel-resistant (law+symmetry+axial value determine everything). Failed solely on the doctor import blocker.
- **2_B_1** (`alpha_beta_in_terms_of_R`): PASS-worthy semantics. Specular law as 2×2 incidence system (not the solved slope), tangency/extremal interfaces concrete, ansatz `CoeffSpec` quantified over arbitrary `(α,β)`, two-configuration determinant argument pinned; answer `α=R, β=-R/2` conclusion-side. Failed solely on the doctor import blocker.
- **2_C_2** (`ray_B_first_order_expansion`): PASS-worthy semantics. Genuine `Asymptotics.IsLittleO` contracts (no global exact equalities); C.1 values as permitted previous-part hypotheses; acute branch keeps denominators nonzero; little-o uniqueness route pinned. Failed solely on the doctor import blocker.
- **3_C_4** (`c4_elapsed_time`): PASS-worthy semantics. Density formulation of infinitesimal cycles; Carnot ratio/first-law/constant-power/calorimetry as equation Props; full chain to the FTC evaluation pinned; answer matches recorded `t=(C_c T_h/P)(ln(T_0/T)-(T_0-T)/T_h)` conclusion-side. Failed solely on the doctor import blocker.

## Coverage notes
- Blueprint doctor also flags wave-1 `problem_IPhO_2026_3_A_1.lean` `scalar-fallback` (`InstantaneousCurrent := ℝ`) and `missing-mathlib-import` on doc-only truncations `1_B_2`, `3_A_2`, `3_C_3` — outside this iter's 6-target set; surfaced for the plan agent's backlog (memory already treats `1_B_2`/`3_C_3` as not-yet-formalized).
- Grounding logs exist for every reviewed target; preflight logs themselves returned only near-misses, but each task report adds real queries/candidates/grounded names — the "compiling file without grounding log" BLOCKER condition does NOT fire this iter.
- 2_A_2's sibling note (1_C_1 parse errors) and the `archon` CLI absence are environment notes, not review targets.

## Learnings for the journal
- The doctor's `missing-physlib-import` check conflicts with the memory-level "import Mathlib only" rule; until reconciled, every physics review is doomed at the gate — resolve policy first (highest-leverage repair).
- Pinning remaining proof obligations as target hypotheses is acceptable ONLY if the constants involved are not the answer value; `ha_max_attained`/`hfact` in 1_B_1 cross that line.
- Implications ending in reflexive existentials (`... → ∃ r', r' = r`) are ghost laws — reviewers should grep for this shape in future waves.

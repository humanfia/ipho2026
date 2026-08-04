# Iter-002 review (session_2) — autoformalize repair wave (11 lanes)

## Scope & method
Reviewed exactly the 11 deterministic-candidate targets of iter-002. Compile results taken from the orchestrator preflight (13.7 s, 11/11 passed; no reruns — all statuses `passed`). `blueprint-doctor.json` consumed as the structural/physics-doctor verdict. Semantic/faithfulness audit done from candidate-pack excerpts + task reports + targeted first-hand reads of statement files (hypothesis lists, law fields, answer occurrences) + arithmetic double-checks of numeric contracts (1_C_2 band, 4_C_6 sample value, 1_B_1 turning-point quadratic). No subagents enabled; reviewer applied the physics checklist directly (no dedicated `physics-reviewer` report exists).

## Metrics
- 11/11 compile clean; sorries 5+7+6+2+1+6+2+3+10+8+3 = 53, all `by sorry` per the by-sorry formalization contract; 0 errors; benign linter noise only (2 unused-variable warnings on 1_C_2).
- Review verdicts: **11 failed / 0 passed** under the mandatory `formalization_review` gate; `status=partial` for all (contracts written, proofs pending, gate not passed).
- Per-file fail taxonomy (root blocker recorded in each milestone):
  - semantic statement/modeling failures found by this review: **1_B_1** (universal attained-set vs admitted bound branch), **4_C_6** (answer-abbreviating sample instance, numerically false against its own readouts),
  - grounding-audit blockers: **3_A_2**, **4_C_6** (deterministic grounding log shows only noise hits; 4_C_6 log contradicts its own task-report grounding section),
  - doctor-only (`missing-physlib-import`) with semantics otherwise green: **1_B_2, 1_C_1, 1_C_2, 2_C_4, 3_A_1, 3_B_1, 3_C_2, 3_C_3** (all 8 carry the planner-recorded `% NOTE:` PhysLean-coverage exemption or a genuinely-used targeted import — the doctor↔exemption reconciliation is the single systematic iter-003 action).
- Doctor totals: 19 `physics_modeling_problems`, all kind `missing-physlib-import` (10 of 11 reviewed files hit; 4_C_6 exempt via real Physlib imports; 3_A_2 of historical note carries a real `Physlib.Electromagnetism.Dynamics.Basic` import yet is still flagged — doctor likely checks a restricted module allowlist, worth fixing); 0 grounding problems, 0 orphans, 0 broken/malformed refs, 0 covers problems, no scalar-fallback (3_A_1 typed-current repair worked).
- sync_leanok iter=2, scope current-objectives, added=0/removed=0 over exactly the 11 targets. `targets_checked` covers 1_B_1, so the remaining `\leanok` on `thm:physics:IPhO_2026_1_B_1:target` (annotated `% STALE-LEANOK iter-001` in the chapter) is the script's deterministic non-action, not fresh laundering — flagging for planner-side cleanup, no CRITICAL.

## What happened per target
- 1_B_1: redraft goals met (vacuous `radial_energy` deleted; `1600/9` demoted conclusion-side; proved algebra certificates kept; apogee/support-bound honest conclusion-side sorry bridges). **Fail** — residual definitional contract: `attainedSeparations := {r | 0<r ∧ Q(r)≤0}` is the universal allowed set while the bound branch (`E<0`) is only the external `IsBoundMu` inequality on opaque constants; with lawful `E>0` field values the hypotheses hold and the stated maximum is false (verified numerically: Q→+∞). Also the doctor import blocker. Route: redraft (record `E<0`/turning-interval as a `CoulombPairData` constraint) + doctor reconciliation.
- 1_B_2: semantics green — stub → full scattering declaration set; signed/unsigned deflection split; branch hypothesis-borne (`perp sep0 v0 > 0`, `direction_toward_pair`); `asymptote_factor_certificate` proved; `−16.60°` conclusion-side only. Fail = doctor import blocker only.
- 1_C_1: semantics green — parse errors repaired; forward/backward branch split honest; `IsDissociationThreshold` is a genuine minimization contract; recorded formula conclusion-side. Fail = doctor import blocker only.
- 1_C_2: semantics green — `hbarOmegaMin_at_pi_div_six` fully proved (ring); numeric contract independently verified (gap = (3r/4)ΔU = 2.0297e-11 eV at r=2.4602e-11, inside the stated 2.02–2.04e-11 band). Fail = doctor import blocker only (blanket `import Physlib` pre-existing; doctor pattern apparently not satisfied by it — allowlist question again).
- 2_C_4: semantics green — asymptotic-equivalence (`IsEquivalent`) reading of the power law is the honest one (exact identity false); positive-angle branch via `smallAngleFilter`, proved membership. Fail = doctor import blocker only.
- 3_A_1: semantics green — doctor `scalar-fallback` cleared by typed `InstantaneousCurrent` wrapper with documented `readout` projection; Ampère circulation → H assembly chain clean. Fail = doctor import blocker only.
- 3_A_2: fail — grounding-log blocker (noise-only deterministic grounding log; rerun preflight) + doctor allowlist quirk (real targeted import ignored). Statements themselves judged honest (Faraday equation field, answer conclusion-side).
- 3_B_1: semantics green — first-law redesign (leg balances against demagnetized reference) is sound; integral-evaluation route named. Fail = doctor import blocker only.
- 3_C_2: semantics green — `$$`-doc repair; q-state-function chain faithfully decomposed; positive-root branch certified. Fail = doctor import blocker only.
- 3_C_3: semantics green — full C.3 formalization from scratch; official values quarantined in an OfficialAnswer section with rounding bands; refrigeration branch certified (`helium_cools`). Fail = doctor import blocker only.
- 4_C_6: fail (double) — grounding-register contradiction (deterministic log noise-only vs grounded task-report PhysLean units APIs) AND a genuine statement defect found this session: `official_sample_value`'s own readouts (c₀=4186, m=0.55, s=7.3e-4) give 1/(c₀·m·s)=0.595 K/W, |0.595−1.17|=0.575≫0.03 — the theorem abbreviates the recorded sample answer rather than deriving it and is physically false as documented. Main inversion `R_Th=1/(c₀·m·s)` and the uncertainty-propagation carrier are faithful; quarantine and restate the sample theorem.

## Root causes & routing
1. **Doctor↔exemption reconciliation overdue (systematic, 8+ files):** the `missing-physlib-import` check ignores the iter-002 `% NOTE:` exemption convention and apparently ignores non-allowlisted real Physlib imports (`import Physlib`, `Physlib.Electromagnetism.Dynamics.Basic`). Director-class fix (doctor teaches the exemption, or allowlist broadens) — one central change, no per-file churn.
2. **Universal-set contracted carriers vs admitted branches (1_B_1 class):** defining the physical set as `{r | law(r)}` while the branch that makes the target true lives in an external predicate leaves a countermodel. Detector: check whether every branch predicate used by the proof route is a field constraint of the data structure, not just a theorem hypothesis.
3. **Recorded-answer abbreviation instances (4_C_6 class):** official `value ± band` theorems whose existential witnesses are literally the recorded answer must be arithmetic-checked against the file's own readouts. Detector: evaluate 1/(c₀·m·s)-style model values from the stated constants before accepting the instance.
4. **Grounding-preflight noise registers (3_A_2, 4_C_6):** deterministic LeanExplore logs recording only `Path.target`/`semiformal_result`/`stereographic_target` hits are useless for the grounding gate; rerun with the task-report's real query log or treat the task-report LeanExplore section as the register of record when the preflight is noise.

## Next-iter routing summary
- Redraft: `problem_IPhO_2026_1_B_1.lean` (bound-branch as structure constraint), `problem_IPhO_2026_4_C_6.lean` (restate `official_sample_value`; keep main inversion + uncertainty carrier).
- Review-retry after grounding-preflight rerun: `problem_IPhO_2026_3_A_2.lean` (and 4_C_6's grounding register).
- Director fix + review-retry (no file changes): `1_B_2, 1_C_1, 1_C_2, 2_C_4, 3_A_1, 3_B_1, 3_C_2, 3_C_3`.
- Planner hygiene: remove the annotated stale `\leanok` on `thm:physics:IPhO_2026_1_B_1:target`; 2 unused-variable linter warnings on 1_C_2 (cosmetic).

Full evidence: `proof-journal/sessions/session_2/{milestones.jsonl,summary.md,recommendations.md}`.

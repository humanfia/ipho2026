# Recommendations for iter-002 plan

## 0. Resolve the import-policy conflict FIRST (unblocks 6/6 targets)
- Deterministic doctor flags all wave files for `missing-physlib-import`; Archon memory mandates `import Mathlib` only for `IPhO2026Problems/*.lean`. Contradiction.
  - Recommended resolution: keep self-containment but allow a **narrow, domain-relevant PhysLean import per file** (pattern already used by wave-2 peers `problem_IPhO_2026_4_C_6.lean` / `problem_IPhO_2026_4_C_7.lean`: `import Mathlib` + one targeted `import Physlib.<Domain>.Basic`). Where LeanExplore proves PhysLean has **no** near module (hydrostatics: 1_A_1; geometric optics: 2_A_1/2_B_1/2_C_2; Coulomb two-body: 1_B_1; classical thermo cycles: 3_C_4), record an explicit per-file **PhysLean-coverage exemption** (in the blueprint chapter or a doctor allowlist) citing the near-miss query log — do NOT bolt on an irrelevant import to appease the check.
  - Update Archon memory/Knowledge Base to state the reconciled rule so future iters stop oscillating.

## 1. REDRAFT `problem_IPhO_2026_1_B_1.lean` (do NOT hand to a prover as-is)
- Remove the stale `\leanok` from `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_1.tex` (sync iter-001 verdict does not cover it; see summary finding 3).
- Redraft directives:
  - Replace `radial_energy`'s vacuous implication with a genuine orbit-support law, e.g. a witnessed trajectory field `sep : ℝ → ℝ` with `sep_pos`, energy-angular-momentum conservation equation along `t`, or at minimum a premise `∀ r ∈ orbit, Q(r) ≤ 0` where `orbit` is a physics-introduced set distinct from the `attainedSeparations` definition.
  - Demote `ha_max_attained` / `hfact` out of the target's hypothesis list: either (a) make them physics-side assumptions whose statements avoid the literal `1600/9` (e.g. boundness + two-turning-points + IVT-style continuity on a positive-energy interval), or (b) turn them into `sorry`-bodied bridge lemmas to be discharged next stage. The answer constant must first appear conclusion-side.
  - Keep the proved pure-algebra certificates (`certified_factorization`, `turning_root_cases`) — they are honest.
- After redraft, re-run the formalization review gate; only then dispatch provers on the 4 sorries.

## 2. Route the other 5 targets to review-retry (statements are sound)
- `1_A_1`, `2_A_1`, `2_B_1`, `2_C_2`, `3_C_4`: semantic audits are otherwise green; the ONLY failing item is the live doctor import blocker. Once §0's resolution lands (targeted import or recorded exemption), these should pass review without Lean-statement changes. Do not churn their structures.
- Optional cleanups (non-blocking, may be folded into the exemption pass):
  - `1_A_1`: drop or substantiate `HingeAxis.axis_perpendicular_to_plane : origin = origin` (rfl-ghost) and make `pressure_at_hinge` non-vacuous (e.g. tie `h_O` to the figure head).
  - `2_A_1`: prover stage ncard computation of `{k : ℕ | (2k+1)·(π/(2N+1)) ≤ π}` is the only nontrivial obligation.
  - `3_C_4`: the Icc-vs-Ioo set-integral congruence (`MeasureTheory.setIntegral_congr_ae`) is the delicate step; stage it as its own lemma attempt.

## 3. Backlog outside this iter's target set (from the same doctor run)
- `problem_IPhO_2026_3_A_1.lean`: `scalar-fallback` — `InstantaneousCurrent := ℝ` needs a typed model or a documented named scalar projection in the blueprint.
- `missing-mathlib-import` on `1_B_2`, `3_A_2`, `3_C_3`: these are the known doc-only truncations / not-yet-formalized wave-1 files; re-dispatch rather than patch.

## 4. Reusable patterns worth keeping
- Opaque scalar + `structure ... : Prop` law-predicate idiom (weight/buoyancy/hydrostatic; Carnot ratio; EOS) — prevents answer-by-unfolding while staying eliminable.
- Density formulation (`CoolingRun` per-`T'` densities) for infinitesimal-cycle problems — keeps every law an ordinary equation; reuse in remaining T3 cycle parts.
- `Asymptotics.IsLittleO` remainders for first-order-expansion answers (2_C_2 pattern) — satisfies the local-approximation gate; reuse for C.3/C.4-wave siblings.
- Set.ncard counting law for circular-mirror reflection counting (2_A_1) plus explicit edge convention — reuse if C.1-wave mirror files get re-touched.
- Ghost-shape detectors for future waves: fields of the form `x = x` and implications `... → ∃ y, y = x`; and answer-valued constants inside target hypotheses.

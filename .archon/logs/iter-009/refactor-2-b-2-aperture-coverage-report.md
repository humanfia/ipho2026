# Refactor Report

## Slug
2-b-2-aperture-coverage

## Status
COMPLETE

## Directive

**Problem:** `AbsorbedRays.full_side_coverage` quantified over
`Set.Ioo (0:ℝ) p.a` (container silhouette band only), making the target
`power_ratio_in_terms_of_theta_max` (`P/P₀ = 1/(1 − cos θ_max)`) false under
the file's own structure: review-gate session-8 countermodel `R = 1, a = 0.1`
with thin fan `hitSet ⊆ (0, a)` satisfies every hypothesis while
`P/P₀ = R/(2a) = 5 ≠ 1/(1−cos θ) ≈ 1.005`. `derivability` +
`countermodel_resistance` FAIL (gate 1/3).

**Changes requested (exactly as executed):**
- `full_side_coverage` field: quantified interval `Set.Ioo (0:ℝ) p.a` →
  `Set.Ioo (0:ℝ) p.R`; field doc updated to "fills the whole open half
  aperture on the container's side (Figure 2f)".
- `AbsorbedRays` header doc block: prose "every impact parameter in `(0, a)`
  is realized" → "`(0, R)`".
- Nothing else: no other field, structure, definition, lemma, theorem
  statement, or import touched; no `sorry` filled.

## Changes Made

### File: `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`
- **What (1):** Structure header doc block (~L97): "every impact parameter in
  `(0, a)` is realized" → "`(0, R)`". Single-token prose substitution; rest of
  the doc block byte-identical.
- **What (2):** `AbsorbedRays.full_side_coverage` field (~L120–L123):
  - Old: `∀ y ∈ Set.Ioo (0 : ℝ) p.a, ∃ x ∈ hitSet, inner ℝ (incidentPt x - g.C) g.e = y`
  - New: `∀ y ∈ Set.Ioo (0 : ℝ) p.R, ∃ x ∈ hitSet, inner ℝ (incidentPt x - g.C) g.e = y`
  - Field doc: "the collected fan reaches out to the container's silhouette
    radius `a`" → "the collected fan fills the whole open half aperture on
    the container's side (Figure 2f)".
- **Why:** Under the B.1 calibration `a = R sin θ (1 − cos θ)`,
  `θ ∈ (0, π/2)`, a figure-realizable absorbed family at arbitrarily small
  `a` exists only if coverage reaches arbitrarily close to `R` (its `θ`-value
  must simultaneously realize the `ThetaMaxSpec`). Strengthening the field to
  `(0, R)` excludes only non-realizable instances (the thin-fan
  countermodel), restoring derivability of `collectedWidth_eq_radius`
  (upper bound via `impactParam_le_aperture`; lower bound since
  `sSup (0, R) = R` over the now-covered open interval).
- **Cascading:** None. `rg` confirms no construction sites of
  `AbsorbedRays` exist in the file (consumers take
  `r : AbsorbedRays p g` as a hypothesis), and files in this project never
  import each other. The only downstream usage of `full_side_coverage` is a
  doc-comment mention on `collectedWidth_eq_radius` (L184), which names the
  field abstractly and needs no edit.

## New Sorries Introduced
- None. The 5 contracted `sorry` sites are unchanged (still at
  L177/L186/L193/L201/L212 — zero line drift).

## Compilation Status
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_2.lean` →
  **0 errors**, exactly the 5 contracted `sorry` warnings:
  ```
  IPhO2026Problems/problem_IPhO_2026_2_B_2.lean:177:6: warning: declaration uses `sorry`
  IPhO2026Problems/problem_IPhO_2026_2_B_2.lean:186:6: warning: declaration uses `sorry`
  IPhO2026Problems/problem_IPhO_2026_2_B_2.lean:193:6: warning: declaration uses `sorry`
  IPhO2026Problems/problem_IPhO_2026_2_B_2.lean:201:6: warning: declaration uses `sorry`
  IPhO2026Problems/problem_IPhO_2026_2_B_2.lean:212:8: warning: declaration uses `sorry`
  ```

## Declarations deleted / renamed
- None. All names, signatures, and declaration order are unchanged; only the
  interval inside one structure field's type and two prose phrases changed.

## Notes for Plan Agent
- The mathematical justification was sufficient; no cascading fixes needed.
- The thin-fan countermodel (`R = 1, a = 0.1`, `hitSet ⊆ (0, 0.1)`) is now
  excluded by `full_side_coverage`, which requires every `y ∈ (0, 1)` to be
  realized — the gate-1 derivability/countermodel obstruction is removed at
  the statement level.
- With coverage over `Set.Ioo 0 p.R`, the sorried
  `collectedWidth_eq_radius` (L186) closes at prover stage as narrated in the
  blueprint: upper bound from `impactParam_le_aperture`, lower bound from
  `(0, R) ⊆` readout image with `sSup (0, R) = R`, nonemptiness from
  `central_ray_absorbed` and boundedness from `impactParam_le_aperture`.
  Suggested next prover target for this file.
- Blueprint correspondence: the chapter
  `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_2.tex`
  already reflects the strengthened form (planner-side iter-009); all 18
  `\lean{}` pins remain valid since no declaration moved or was renamed.

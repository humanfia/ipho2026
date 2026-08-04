# Refactor Directive

## Slug
2-b-2-aperture-coverage

## Problem
`IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`: `AbsorbedRays.full_side_coverage` (currently ~L122) quantifies over `Set.Ioo (0:ℝ) p.a` — the container silhouette band only. The target theorem `power_ratio_in_terms_of_theta_max` (P/P₀ = 1/(1 − cos θ_max), the recorded official answer of T2-B.2) routes through `collectedWidth_eq_radius : collectedWidth p g r = p.R`, whose lower bound needs coverage out to the mirror aperture radius `R`. Review-gate session-8 found the constructive countermodel `R = 1, a = 0.1` with a thin absorbed fan `hitSet ⊆ (0, a)`: every hypothesis of the file holds while `P/P₀ = R/(2a) = 5 ≠ 1/(1−cos θ) ≈ 1.005` — the target is FALSE as stated under the current structure. `derivability` + `countermodel_resistance` FAIL (gate 1/3). This is the last open autoformalize repair.

## Mathematical Justification
The blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_2.tex` (updated planner-side iter-009) already narrates the strengthed form: at the Figure-2f operating point the collected fan is exactly one open half of the mirror aperture `(0, R)`. Source warrant: under the previous-part B.1 calibration `a = R sin θ (1 − cos θ)`, `θ ∈ (0, π/2)`, a figure-realizable absorbed family at arbitrarily small `a` exists only if coverage reaches arbitrarily close to `R`, since its `θ`-value must simultaneously realize the `ThetaMaxSpec` (attained maximum incidence angle among absorbed rays). Hence every realizable instance of the file's own contracts has full half-aperture coverage; strengthening the field excludes only non-realizable instances (the thin-fan countermodel). With coverage over `Set.Ioo 0 p.R`, the `collectedWidth_eq_radius` proof closes at prover stage: upper bound from `impactParam_le_aperture` (Cauchy–Schwarz on the mirror circle), lower bound from the open interval `(0, R)` being contained in the readout set (`sSup (0,R) = R`), plus nonemptiness/boundedness from `central_ray_absorbed`/`impactParam_le_aperture`.

## Changes Requested
- File: `/root/proposal_for_physic/science-mango-ipho-2026-k3-run/IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`
  - Old (structure `AbsorbedRays` field, ~L121–L123):
    `/-- Every impact parameter in \`(0, a)\` is realized: the collected fan
    reaches out to the container's silhouette radius \`a\`. -/
    full_side_coverage : ∀ y ∈ Set.Ioo (0 : ℝ) p.a,
      ∃ x ∈ hitSet, inner ℝ (incidentPt x - g.C) g.e = y`
  - New (same field name, same shape, only the quantified interval changes `p.a` → `p.R`; doc string updated to match):
    `/-- Every impact parameter in \`(0, R)\` is realized: the collected fan
    fills the whole open half aperture on the container's side (Figure 2f). -/
    full_side_coverage : ∀ y ∈ Set.Ioo (0 : ℝ) p.R,
      ∃ x ∈ hitSet, inner ℝ (incidentPt x - g.C) g.e = y`
  - Also update the two prose mentions of the coverage band in the doc comments of the same structure: the header doc block of `AbsorbedRays` (~L95–L99: "every impact parameter in `(0, a)` is realized — so that …") reads `(0, R)` instead of `(0, a)`; no other prose touch.
  - NOTHING else. Do not touch any other field, structure, definition, lemma, theorem statement, or import. Do not fill any `sorry`. No construction sites of `AbsorbedRays` exist in this self-contained file (consumers take `r : AbsorbedRays p g` as a hypothesis), so no cascading breakage is expected.

## Affected Files
Only `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`. Files never import each other in this project.

## Expected Outcome
`lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_2.lean` → 0 errors and exactly the 5 contracted `sorry` warnings (currently L177/L186/L193/L201/L212 — small line drift is fine; the invariant is 0 errors + 5 sorries, statements otherwise byte-identical). Report the diff summary and the fresh compile output in the task result.

## Blueprint correspondence (for your report, no tex writes by you)
The chapter already reflects this change (planner-side, iter-009: strengthened clause (e) prose, a statement-reconciliation NOTE, and the `collectedWidth_eq_radius` proof block updated to the open-half-aperture argument; all 18 `\lean{}` pins unchanged — names do not move).

# Session 8 recommendations

## R1 (BLOCKER, redraft lane): repair `problem_IPhO_2026_2_B_2.lean` aperture coverage
`full_side_coverage` currently quantifies over `Set.Ioo 0 p.a` and cannot entail `collectedWidth = R` for small container radii (countermodel in session_8 milestones). Options, in preference order:
1. Strengthen the field to `∀ y ∈ Set.Ioo (0:ℝ) p.R, ∃ x ∈ hitSet, inner ℝ (incidentPt x − g.C) g.e = y` — the full half-aperture coverage the chapter proof already narrates — provided the reflected-ray geometry discharges realizability up to `R` at the Figure-2f proportions (note `B1Calibration` + acute branch give `a = R sinθ − (R/2) sin 2θ = R sinθ(1 − cosθ)`, and coverage to `ε < R` already follows at arbitrarily small `a`; the full-`R` supremum is the analytically clean route to `sSup = R`).
2. If a strict equality `collectedWidth = R` is preferred without strengthening coverage, note `sSup` over `Set.Ioo 0 ε` already equals `ε` up to the aperture bound, so the design value needs only the sup-form bridge; alternatively add an explicit `aperture_covered` field or an `a`-lower-bound hypothesis.
Gate: fresh `lake env lean` 0 errors + 5 contracted sorries preserved (or fewer honestly discharged); statements of `power_ratio_in_terms_of_theta_max` unchanged — repair on the structure field/law side, never weaken the target.

## R2 (writer follow-up): restate the `1_C_2` blueprint ledger to the redrafted declarations
New decls needing entries: `ThresholdBalance`, `LowerRootBranch`, `threshold_excess_enclosure`, `thresholdBalance_to_ev_units`, `mc2eV_trusted*`; `
\uses{}` of the two target theorems should point at these plus `ThresholdRealizable`, `angular_factor_at_pi_div_six`, `hbarOmegaMin_at_pi_div_six`, `rest_energy_gap_nonneg`. Flag the umbrella `% archon:previous-part` C.1 sentence with a NOTE: recorded C.1 formula drops a factor 2 in the radicand (upstream source-report data-fix, TO_USER-level; the answer `2.03e-11 eV` IS reproduced by the formalized balance).

## R3 (planner audit, cross-file): C-family geometry consistency
`3_C_3`'s lane reports `3_C_4` (and likely `3_C_2`, `3_C_5`) encode the pre-correction B.1 law (`/(2*T)`, mirrored geometry); their conclusions are factor-insensitive. Audit the three sibling statements against the corrected C-family geometry and restate where needed; also repair the `3_C_3` chapter proof-block prose (`Qc_cold_leg` family) with a blueprint-writer touch-up. Not a compile or gate blocker.

## R4 (refactor follow-up, non-blocking): replace the `1_A_1` ghost-shape hinge field
`HingeAxis.axis_perpendicular_to_plane : origin = origin` is rfl-trivial (iter-001 ghost detector). Replace with a real geometric constraint (e.g. axis direction orthogonal to the figure plane expressed via a normal-vector field, or drop the field and document the axis extrinsically). Zero derivability impact today; hygiene for prover-stage.

## R5 (loop-level, still open since session_7): retire the stale doctor payload + fix grounding-preflight noise
The injected 18/19-finding `missing-physlib-import` snapshot has now been formally retired by review for the 7th consecutive iteration while remaining the gate ledger's recorded failure reason for 14 targets. Director-side: (a) stop re-injecting the iter-003 payload into `blueprint-doctor.json`'s `physics_modeling_problems`; (b) pin the upstream Archon doctor patch (lives in the project venv's editable install — user confirmation pending since iter-003); (c) repair the deterministic physics-grounding preflight's generic-noise class (`Path.target`/`semiformal_result` hits) — task reports remain the register of record until then. These repairs unblock the ledger's recorded reasons without any file churn.

## R6 (provenance escalation, TO_USER): `4_C_6` primary source
`raw/E1_solution.pdf` remains absent from this checkout (find-verified iter-007). The final attempt (2/3) re-reviews only when the PDF is on disk; otherwise the gate's documented fallback is the quarantine-delete lane. User may place the PDF under `raw/`.

## R7 (stage gating): advance autoformalize → prover only after R1 lands and passes re-review
Then the queue closes at 26/26 passed (+ `4_A_5`), with `1_B_1` documented-exhausted and `4_C_6` provenance-pending. The prover stage inherits: frozen `1_B_1` repair spec (proof-Review redraft), R4 hygiene, and all contracted sorries as its work queue.

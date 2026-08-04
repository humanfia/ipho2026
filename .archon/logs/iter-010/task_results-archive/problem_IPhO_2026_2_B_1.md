# Task result: `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`

- Mode: physics-formalize (autoformalize lane, review-gate retry 2/3; statements planner-frozen — no redraft dispatched)
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_1.tex` (contains `% archon:physics`; umbrella `thm:physics:IPhO_2026_2_B_1:target`)
- Status: **verified frozen and clean.** Fresh `lake env lean` (iter-009) exits 0 with **zero diagnostics**; additionally re-checked with `-DwarningAsError=true` → exit 0, zero diagnostics (control file with `sorry` errors out under the same flag, confirming the flag works and this file genuinely contains no `sorry`). Statement layer untouched this iteration per the freeze.

## Iteration-009 action

No edit to the `.lean` file. This lane is enrolled in the review gate as `retry 2/3` with every semantic check (`source_faithfulness`, `derivability`, `abstraction_sufficiency`, `branch_orientation`, `countermodel_resistance`, all bridge obligations) already `passed`; the residual `reason` is the recorded-stale macro note "does not import Physlib/PhysLean", which the chapter's planner-recorded exemption NOTEs (iter-002, two copies) already resolve: PhysLean's `Physlib.Optics` is an explicit placeholder module (verified on disk at `.lake/packages/PhysLean/Physlib/Optics/Basic.lean`: "currently a place holder"), so the `import Mathlib` baseline stands. The next consumer is the deterministic review re-pass; no prover-side change was due or made.

## Assumption/target split

**Governing laws (hypothesis-side).**
- Specular reflection on the circular mirror profile: `CookerB1.reflection_law` — reflected line passes through the mirror point `(x, -√(R²-x²))` and its direction is the mirror reflection of the incoming axial direction `(0,-1)` in the tangent line, stated as the 2×2 incidence system (`-y = m·x + b ∧ m·(2xy) = x² - y²`-form), not as a solved formula.
- Absorption law: `CookerB1.absorbed_law` (every family ray's reflected line meets the container disc).
- Figure-2f geometry readouts: `C_coord : C = (0,0)`, `A_coord : A = (0, -(R/2))`, `mirrorSet` = sunlit half-circle of radius `R` (`y ≤ 0`), `containerSet` = closed disc of radius `a` about `A`.
- Single-bounce contiguous-fan bookkeeping: `hitSet` with `on_mirror`, `hit_branch` (`|x| < R`), `no_gap` (symmetric centred fan).

**Figure/data readouts (hypothesis-side).**
- `IsThetaMax`: `θ_max` attained by an absorbed ray, bounds all absorbed incidence angles, acute branch `(0, π/2)`.
- `ExtremalRaySpec`: extremal column `x ∈ hitSet` realizes `θ_max`, `off_axis : x ≠ 0`, `tangent_dist : |distToLine (line x) A| = a` (limiting-ray tangency to the container circle).
- `SecondExtremalConfig`: a second extremal configuration of the same mirror radius at a distinct angle `θ' ≠ θ_max` (family nondegeneracy readout).

**Previous-part results.** None — B.1 is the first subquestion of part B. Its own geometric identity is conclusion-side here; sibling B.2 restates it locally as its calibration hypothesis.

**Current target conclusions (conclusion-side only).**
- `container_radius_at_extremal_angle`: `a = R·sin θ − (R/2)·sin (2θ)` at the extremal angle.
- `alpha_beta_in_terms_of_R` (umbrella target `thm:physics:IPhO_2026_2_B_1:target`): `α = R ∧ β = -R / 2`.

## Goal-faithfulness audit

- The recorded answer `α = R, β = -R/2` occurs only in the conclusion of `alpha_beta_in_terms_of_R`; no structure field, hypothesis, `Laws`/`Valid`/`Satisfies`-style predicate, or local definition states or evaluates it.
- `CoeffSpec` states *the given ansatz* (the problem's premise — the family form used again in the later parts): it quantifies over arbitrary real `α, β` constrained only by `q.a = α sin θ₁ + β sin 2θ₁` at extremal configurations; junk pairs simply fail it, so it is not the answer in disguise.
- `reflection_law` is the physical law of reflection as incidence data; deriving `b = -R²/(2√(R²-x²))` from it requires the 2×2 solve carried out in `container_radius_at_extremal_angle`, not an unfolding.
- `ExtremalRaySpec.tangent_dist` is a physical incidence (distance) condition speaking of `a` and line data only — the double-angle identity still has to be derived from it (and is, in the on-disk proof).
- No `rfl`/definition-unfolding closes anything substantive. The file in fact goes beyond the by-`sorry` discipline: all four proof obligations (`impactParam_eq_sin`, `sin_two_pos`, `container_radius_at_extremal_angle`, `alpha_beta_in_terms_of_R`) were closed with full proofs in the landed iter-008 redraft; only the statement layer is frozen.

## Derivability and bridge obligations

| Source claim | Lean carrier | Status | Evidence |
|---|---|---|---|
| `θ(x) = arcsin(|x|/R)`; extremal column recovers `|x| = R sin θ_max` | `incidenceAngle`, `impactParam_eq_sin` | covered | `Real.sin_arcsin` round-trip on the open aperture; proved on disk. |
| Acute branch keeps `sin (2θ) > 0` (nondegeneracy flashpoint) | `sin_two_pos` | covered | `2θ ∈ (0, π)`, `Real.sin_pos_of_mem_Ioo`; proved on disk. |
| Tangency at the extremal column forces `a = R sin θ − (R/2) sin 2θ` | `container_radius_at_extremal_angle` | covered | 2×2 specular solve (`reflection_law`, determinant `-(2x)(x²+y²) ≠ 0`) → `b = -R²/(2y)`; line-normalizer collapses on the circle; signed numerator `-R/2 - b > 0` (no lost sign branch); `a·R = |x|(R−y)`; double-angle elimination. Proved on disk. |
| Ansatz at two distinct extremal angles fixes `(α, β)` | `alpha_beta_in_terms_of_R` (`hdet`, `hβ`, `hα` in the body) | covered | subtraction gives the homogeneous 2×2 system in `(α−R, β+R/2)`; determinant `2 sin θ sin θ' (cos θ' − cos θ) ≠ 0` via sine positivity and `Real.injOn_cos`; proved on disk. |

No bridge is blocked; the main theorem contract names every hypothesis it consumes.

## Abstraction sufficiency and countermodel audit

- `CookerB1` (Prop-field structure): constrained by the `reflection_law` 2×2 system (off-axis nonzero determinant), membership equations (`on_mirror`, `absorbed_law`), and fan topology (`no_gap`, `hit_branch`). Arbitrary line data fails `reflection_law` at two distinct columns; arbitrary tiny `hitSet` fails `no_gap`. Constraining.
- `ExtremalRaySpec`: `hx`, `hθ`, `off_axis`, `tangent_dist` jointly pin the extremal column to `|x| = R sin θ` with the reflected line at distance `a` from `A`; with `reflection_law` the line data is fully determined, so the interface cannot be witnessed by arbitrary lines. Constraining (elimination by field projection).
- `CoeffSpec`: exposes the consumable consequence `q.a = α sin θ₁ + β sin (2θ₁)` at every extremal configuration; combined with `SecondExtremalConfig` (a genuine second configuration) and the nonzero-determinant certificate it cannot hold for answer-falsifying pairs. Constraining.
- `IsThetaMax`: exposes attainment + uniform bound + acute-branch inequalities across the whole fan. Constraining.
- `Vec`/`Line2D`/`distToLine`: concrete real-valued cross-section geometry (not opaque relations, not scalar aliases); the standard non-vertical-line signed distance.
- Countermodel resistance is demonstrated constructively: the on-disk proofs close every obligation, so any purported countermodel would have to falsify a proved theorem.

## Uncertainty and branch coverage

- Uncertainty: **not applicable** — the source reports an exact symbolic answer with no `±` error data (gate certificate agrees: `not_applicable`).
- Branch/orientation: **covered** — frame orientation (`A = (0, -R/2)`, sunlit half `y ≤ 0`, sunlight along `(0,-1)`) fixed by Figure 2f and cross-checked against the official B.2/B.3 answers; the `±x` mirror-image tangent branches are absorbed by `|x|` in `incidenceAngle`/`impactParam_eq_sin`; the signed-distance numerator is proved uniformly positive (`-R/2 - b > 0`), so no sign branch is lost; the acute branch is `IsThetaMax` hypothesis data; incoming/outgoing orientation is fixed by the specular direction in `reflection_law`.

## Declarations ↔ blueprint labels

All 15 `
\lean{}` pins in the chapter resolve to on-disk declarations (umbrella `thm:physics:IPhO_2026_2_B_1:target` → `alpha_beta_in_terms_of_R` via `\uses{thm:...:alpha_beta_in_terms_of_R}`):

- `Vec`, `vnorm`, `Line2D`, `distToLine` — cross-section geometry carriers (`def:` labels).
- `CookerParams`, `CookerB1` — dimensionful parameters / Figure-2f specular bookkeeping.
- `incidenceAngle`, `IsThetaMax` — `θ_max` specification.
- `ExtremalRaySpec`, `CoeffSpec`, `SecondExtremalConfig` — extremal-tangency / ansatz / family-nondegeneracy interfaces.
- `impactParam_eq_sin`, `sin_two_pos` — flashpoint lemmas (`lem:` labels).
- `container_radius_at_extremal_angle` — B.1 geometric identity (`thm:` label).
- `alpha_beta_in_terms_of_R` — target value theorem (`thm:` label, umbrella `thm:physics:...:target`).

`\leanok` markers: none applied by me (write permissions; also `\leanok` is owned by the deterministic `sync_leanok` phase per AGENTS.md). Every pinned declaration is compiled and, beyond the autoformalize contract, **proved** (zero `sorry` in the file), so all 16 environments are candidates for `\leanok` at the sync/review pass.

## LeanExplore queries / candidates actually used

Standing grounding log: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_1.md` (preflight, packages `[Mathlib, Physlib]`). Queries run for the original draft (`Real.sqrt square root`, `EuclideanSpace vector components`, `law of reflection specular reflection optics mirror ray`, `Incidence angle of a column`, `Cooker dimensionful parameters`, …) returned only irrelevant or near-miss hits (`EuclideanGeometry.reflection`, `Path.target`, `semiformal_result`, `Dimensionful`); none were used in the final API. No new queries were needed this iteration (no statement change).

## PhysLean/Mathlib names grounded

- Mathlib (used, verified by the clean compile): `Real.arcsin`, `Real.sin_arcsin`, `Real.sin_pos_of_mem_Ioo`, `Real.cos_pos_of_mem_Ioo`, `Real.sin_sq_add_cos_sq`, `Real.sin_two_mul`, `Real.injOn_cos`, `Real.sqrt`, `Real.sq_sqrt`, `Real.sqrt_sq_eq_abs`, `Real.sqrt_pos`, `Set.Ioo`, `sq_abs`, `sq_eq_sq_iff_eq_or_eq_neg`, `mul_self_le_mul_self`, `abs_div`, `div_eq_div_iff`, `mul_right_cancel₀`, `sq_pos_of_pos`, `sq_pos_of_ne_zero`.
- PhysLean: **none used** — `Physlib.Optics` is a placeholder module (verified on disk), and there is no specular-reflection/geometric-optics API to ground the law in; import-policy exemption recorded in the chapter (two NOTEs, iter-002).

## Local abstractions introduced (physical-meaning preservation)

- `Vec := ℝ × ℝ` (abbrev, not a scalar alias): keeps the 2-D cross-sectional geometry of Figure 2f; chosen over `EuclideanSpace ℝ (Fin 2)` to keep coordinate equations tactic-light for the prover stage — physically equivalent, length dimension documented in docstrings.
- `Line2D` + `distToLine`: non-vertical reflected lines with the standard signed point-line distance — the source's tangency language (verticality excluded off-axis by `hit_branch`).
- `CookerB1`, `IsThetaMax`, `ExtremalRaySpec`, `CoeffSpec`, `SecondExtremalConfig`: setup/laws, `θ_max` spec, extremal tangency, given ansatz, family nondegeneracy — each a distinct physical role; none hides the answer (see audits above).

## Grounding gaps / redraft requests

- Gap (Physlib side, standing): no geometric-optics reflection API; worked around with the explicit Cartesian 2×2 incidence system. Documented in the chapter exemption NOTEs.
- No redraft requested. Statements are planner-frozen at review-gate retry 2/3; the deterministic review re-pass is the next consumer. The sole recorded gate `reason` (missing Physlib import) is resolved by the exemption NOTE and the placeholder status of `Physlib.Optics` — flagged here so the re-pass can close the lane.

# Task result — `IPhO2026Problems/problem_IPhO_2026_2_A_1.lean` (iter-009, physics-formalize)

- Lane type: review-gate retry (2/3 used). Statements are **planner-frozen** per
  `PROGRESS.md` ("deterministic review pass is the next consumer"); this pass is
  therefore verification + documentation, not a redraft. **No edit to the `.lean`
  file was made.**
- Compile status: fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`
  → **0 errors**, exactly the **5 contracted `sorry` warnings** at L125
  (`limiting_ray_reflection_count`), L134 (`threshold_forms_agree`), L144
  (`threshold_x_N_cos`), L152 (`threshold_x_N_sin`), L160 (`threshold_x_N`).
  No other errors/warnings. No `axiom`/`opaque`/`native_decide` anywhere.
- Blueprint chapter `% archon:physics`: present and confirmed; chapter contents on
  disk verified up to date (all 6 `\lean{...}` pins match the declarations).
- `/- USER: ... -/` hints in file: none.

## Assumption/target split

- Governing laws (assumption side, in `HalfCylindricalMirror`):
  - `reflection_count_law` — specular reflection on the circular mirror
    (angle of reflection = angle of incidence) ⇒ impact polar angles are the odd
    multiples `α, 3α, 5α, …`; for entry angle `α ∈ (0, π/2]` on the right half,
    `N_refl (R*cos α) = Set.ncard {k : ℕ | (2*(k:ℝ)+1)*α ≤ π}` (rim impact
    exactly at `π` counted). Stated as the physical law itself, not as the final formula.
  - `N_refl_abs` — mirror symmetry about the optical axis (fixes the left-half count).
  - `N_refl_zero` — the axial ray is reflected exactly once (base of the staircase).
- Previous-part results: none (A.1 is the first subquestion of Problem 2).
- Figure/data readouts (assumption side):
  - `R`, `R_pos` — mirror radius from Figures 2c–2e (length, positive).
  - `x_NAt`, `x_NAt_pos`, `x_NAt_lt_R` — the threshold sequence of Figure 2e,
    0-based indexing (`x_N = x_NAt (N-1)`), positive and inside the opening `(-R, R)`.
  - `x_NAt_is_threshold` — Figure-2e staircase defining property: below `x_NAt n`
    the count is `≤ n+1`, from the edge onward within `(-R,R)` it is `> n+1`
    ("largest distance for at most `n+1` reflections").
  - `x_NAt_edge_count` — filled dots of Figure 2e: the rim impact counts as a
    reflection, so `N_refl (x_NAt n) = n+2`.
- Current target conclusions (conclusion side only, each `by sorry`):
  - `threshold_x_N_cos` — `x_N = R*cos(π/(2N+1))` (recorded answer, cosine form).
  - `threshold_x_N_sin` — `x_N = R*sin((2N-1)π/(4N+2))` (recorded answer, sine form).
  - `threshold_x_N` — both forms agree and equal `x_N`.
  - Bridges (also conclusion side, proved from the law, not assumed):
    `limiting_ray_reflection_count`, `threshold_forms_agree`.

## Goal-faithfulness audit

- No structure field, hypothesis, or local definition fixes any threshold value:
  the fields carry `R`, the count function, the staircase/threshold *properties*,
  and the reflection law only. The closed forms `R*cos(π/(2N+1))` /
  `R*sin((2N-1)π/(4N+2))` occur **exclusively** in the conclusions of the five
  theorems, which are all left `sorry`.
- `reflection_count_law` quantifies over *all* `α ∈ (0, π/2]` and returns a
  cardinal count; it does not unfold to the answer. The answer value is nowhere
  hard-coded: a structure satisfying the law with a generic staircase is
  consistent, and the theorems pin `x_NAt n` only via the to-be-proved bridge.
- No scalar-placeholder aliasing of physical quantities: `R`, `x`, thresholds are
  real *coordinates* (explicitly documented as Cartesian scalar readouts of the
  Figure-2d plane), while the physical objects (count staircase, threshold
  sequence, reflection law) remain structure fields — the smallest interface that
  keeps the geometric-optics meaning (PhysLean has no such module; see gaps).

## Derivability and bridge obligations

| Source claim | Lean carrier | Evidence | Status |
|---|---|---|---|
| Specular reflection ⇒ impacts at odd multiples of `α`, count = #odd multiples ≤ `π` | `HalfCylindricalMirror.reflection_count_law` (field) | law stated directly; governs all `α` | covered (assumption-side law) |
| Limiting ray at `α = π/(2N+1)` has its `(N+1)`-st impact on the rim ⇒ `N+1` reflections | `limiting_ray_reflection_count` (thm) | instantiate law at `α = π/(2(n+1)+1)`; count odd multiples `≤ π` is `n+2` | covered (encoded, proof `sorry`) |
| `(2N-1)π/(4N+2) = π/2 - π/(2N+1)` and `sin(π/2 - θ) = cos θ` | `threshold_forms_agree` (thm) | Mathlib `Real.sin_pi_div_two_sub` route | covered (encoded, proof `sorry`) |
| Count at `x_* = R cos(π/(2N+1))` is `n+2` ⇒ by `x_NAt_is_threshold` duality `x_NAt n = x_*` | `threshold_x_N_cos` (main target) | threshold-defining property + limiting-ray count; needs squeezing `x_NAt n ≤ x_*` (from `x_* < x_NAt n` ⇒ count ≤ n+1, contra) and `x_* ≤ x_NAt n` (from edge onward count > n+1) | covered (encoded, proof `sorry`) |
| Sine form + combined answer | `threshold_x_N_sin`, `threshold_x_N` | chain cosine form with forms-agree bridge | covered (encoded, proof `sorry`) |

No missing bridge was identified: every step from the bundled law + Figure-2e
readouts to the recorded answer has a named in-file carrier.

## Abstraction sufficiency and countermodel audit

Local `Prop`-valued interfaces (all fields of `HalfCylindricalMirror`):

- `N_refl_abs : ∀ x, N_refl (-x) = N_refl x` — equational; constrains the left half.
- `N_refl_zero : N_refl 0 = 1` — equational anchor of the staircase at the axis.
- `x_NAt_is_threshold : ∀ n, (∀ x, |x| < x_NAt n → N_refl x ≤ n+1) ∧
  (∀ x, x_NAt n ≤ |x| → |x| < R → n+1 < N_refl x)` — two-sided squeeze; this is an
  elimination interface: with `limiting_ray_reflection_count` it both upper- and
  lower-bounds `x_NAt n` against `R cos(π/(2(n+1)+1))`, making the threshold unique.
- `x_NAt_edge_count : ∀ n, N_refl (x_NAt n) = n + 2` — equational; pins the level
  jump at the edge (right-continuity readout).
- `reflection_count_law : ∀ α ∈ Ioc 0 (π/2), N_refl (R*cos α) =
  Set.ncard {k : ℕ | (2*(k:ℝ)+1)*α ≤ π}` — equational over the whole right half;
  determines `N_refl` completely there, hence (with symmetry) on all of `(-R, R)`.

Countermodel sanity: `N_refl` on the mirror opening is fully determined by the law
+ symmetry; the threshold-defining property then over-determines each `x_NAt n`
to a single value (any two candidates both satisfy the squeeze, forcing equality).
Arbitrary-field interpretations consistent with all assumptions but falsifying a
conclusion are excluded — e.g. a staircase shifted by one level violates
`x_NAt_edge_count`; one with edges at `R cos(2π/(2N+1))` violates
`x_NAt_is_threshold` at test points between the two edges. Note: the law is
asserted only for `α ∈ (0, π/2]`; on `|x| ≥ R` (off-mirror coordinates)
`N_refl` is unconstrained, which is physically faithful (no such ray exists) and
harmless because all target values satisfy `|x_NAt n| < R` (field `x_NAt_lt_R`).

## Uncertainty and branch coverage

- Uncertainty: **not applicable** — the source states an exact closed form with no
  measured data or `±` values.
- Branch/orientation: **covered** — right/left halves handled by `N_refl_abs`
  (mirror symmetry hypothesis, assumed, not selected conclusion-side); the rim
  impact exactly at polar angle `π` is counted per `x_NAt_edge_count` and the
  `≤ π` in the counting set (incoming-vs-rim branch preserved); the escape
  through the open lower half `y < 0` is documented in the field docstring
  (the step `2α ≤ π` prevents jumping over the lower half — this is the
  geometric content of the law's hypothesis domain `Ioc 0 (π/2)`).

## Declarations created and blueprint labels

| Lean declaration | Blueprint label | Marker status |
|---|---|---|
| `IPhO2026_2_A_1.HalfCylindricalMirror` | `def:...:HalfCylindricalMirror` | definition, sorry-free; `\lean` pin live |
| `...HalfCylindricalMirror.limiting_ray_reflection_count` | `thm:...:limiting_ray_reflection_count` | `sorry` — not `\leanok`-eligible |
| `...HalfCylindricalMirror.threshold_forms_agree` | `thm:...:threshold_forms_agree` | `sorry` — not `\leanok`-eligible |
| `...HalfCylindricalMirror.threshold_x_N_cos` | `thm:...:threshold_x_N_cos` | `sorry` — not `\leanok`-eligible |
| `...HalfCylindricalMirror.threshold_x_N_sin` | `thm:...:threshold_x_N_sin` | `sorry` — not `\leanok`-eligible |
| `...HalfCylindricalMirror.threshold_x_N` | `thm:...:threshold_x_N` | `sorry` — not `\leanok`-eligible |

All blueprint `\lean{...}` pins already match; no `\leanok` change is
proposed (all five theorems retain `sorry` by design at autoformalize stage;
`sync_leanok` owns the markers).

## LeanExplore queries/candidates actually used

From the preflight register `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_A_1.md`
(queries per chapter declaration block, packages `["Mathlib","Physlib"]`, local backend):

- Grounded and used: `Real.cos`, `Real.sin` (Mathlib,
  `Mathlib.Analysis.Complex.Trigonometric`) in all target statements;
  `Real.pi`/`Set.Ioc`/`Set.ncard` from the Mathlib baseline for the law.
- Candidates found but irrelevant near-misses (recorded): `Polynomial.mirror`,
  `SameRay`, `RayVector`, `stereographic_target`, `semiformal_result` (PhysLean
  meta) — none models specular reflection on a cylindrical mirror.
- Fresh re-confirmation this lane (iter-008 prover pass, Physlib-filtered query
  "optics ray reflection specular cylindrical mirror focal"): no geometric-optics
  / reflection module exists in Physlib.

## PhysLean/Mathlib names grounded

- `Real.cos`, `Real.sin`, `Real.pi` (Mathlib) — statement-side functions.
- `Set.ncard`, `Set.Ioc` (Mathlib) — counting set and hypothesis interval in the law.
- Supporting proof-route names for the future prover stage (not needed at
  by-sorry stage): `Real.sin_pi_div_two_sub` for `threshold_forms_agree`.

## Local abstractions introduced

- `IPhO2026_2_A_1.HalfCylindricalMirror` — single structure packaging radius,
  reflection-count staircase, threshold sequence, and the five assumption-side
  laws/readouts. Introduced because neither Mathlib nor PhysLean has a geometric
  /reflection-optics model of a half-cylindrical mirror; it preserves the physical
  roles (length-carrying coordinates vs dimensionless counts/angles, symmetry,
  rim-count convention, specular law) instead of erasing them to scalar aliases.

## Grounding gaps

- **PhysLean gap (known, exemption on record):** PhysLean has no geometric /
  reflection-optics module for this regime; the file therefore builds on
  `import Mathlib` alone. This is documented by the planner-recorded exemption
  NOTE in the chapter (iter-002) and re-confirmed by Physlib-filtered LeanExplore
  queries (iter-008). The gate's standing "does not import Physlib/PhysLean"
  failure reason for this lane is the iter-003 stale-snapshot finding
  (`PROGRESS.md`: the 18 injected `missing-physlib-import` findings are the
  stale snapshot, 8th iter, formally retired; exemption NOTEs present). Deferred
  to the deterministic review re-pass; no redraft is warranted or permitted
  (statements planner-frozen).
- No other grounding gaps: every Mathlib name used resolves under `import Mathlib`.

## Redraft requests

None. Recommendation: review re-pass should grade this lane on the on-disk
chapter exemption NOTE + this report; the file is semantically faithful
(source_faithfulness/derivability/abstraction_sufficiency/branch_orientation/
countermodel_resistance were all `passed` at the last gate) and compiles clean.

# Task result — `IPhO2026Problems/problem_IPhO_2026_2_A_1.lean` (IPhO 2026 T2, Part A.1)

Status: **complete** — `lake env lean IPhO2026Problems/problem_IPhO_2026_2_A_1.lean` exits 0 with
exactly 5 `sorry` warnings (the 5 target/bridge theorems) and no errors.
Blueprint chapter already exists with `% archon:physics` (left untouched, per prover rules).
The single umbrella node `thm:physics:IPhO_2026_2_A_1:target` is covered by the declaration set
below; the deterministic `\leanok` sync may mark the environment once this compiles (no `\lean{}`
pins to add — bookkeeping owes umbrella wiring later).

## Declarations created (all in namespace `IPhO2026_2_A_1`)

- `structure HalfCylindricalMirror` — the physical setup: radius `R`, reflection-count function
  `N_refl : ℝ → ℕ` (the Figure 2e staircase), threshold sequence `x_NAt : ℕ → ℝ` (0-based, so the
  recorded answer for positive integer `N` is `x_NAt (N - 1)`), plus 8 hypothesis fields below.
- `HalfCylindricalMirror.limiting_ray_reflection_count` (bridge lemma, `sorry`)
- `HalfCylindricalMirror.threshold_forms_agree` (trig bridge lemma, `sorry`)
- `HalfCylindricalMirror.threshold_x_N_cos` (recorded answer, cosine form, `sorry`)
- `HalfCylindricalMirror.threshold_x_N_sin` (recorded answer, sine form, `sorry`)
- `HalfCylindricalMirror.threshold_x_N` (combined recorded answer `x_N = R*sin((2N−1)π/(4N+2)) = R*cos(π/(2N+1))`, `sorry`, main carrier of `thm:physics:IPhO_2026_2_A_1:target`)

## Assumption/target split

**Governing laws (assumptions):**
- `reflection_count_law`: law of reflection on a circular mirror. The incidence angle is constant
  along a ray; impacts have standard polar angles `α, 3α, 5α, …`; escape occurs at the first
  would-be impact beyond the rim angle `π` (cannot jump over the open half since the step `2α ≤ π`);
  hence `N_refl (R * cos α) = Set.ncard {k : ℕ | (2 * (k:ℝ) + 1) * α ≤ π}` for the entry branch
  `α ∈ (0, π/2]`. This is a counting *law*, not the answer formula.
- `N_refl_abs`: mirror symmetry about the optical axis (`N` depends on `|x|` only).

**Figure/data readouts (assumptions):**
- `N_refl_zero : N_refl 0 = 1` (Figure 2d: the axial ray reflects once, at the top `(0, R)`).
- `x_NAt_pos`, `x_NAt_lt_R`: thresholds lie strictly inside the mirror opening (Figure 2e staircase
  edges between the rim points `±R`).
- `x_NAt_edge_count : N_refl (x_NAt n) = n + 2` (Figure 2e filled dots: at the edge the ray hits the
  rim, which counts as a reflection).
- Geometry parameters recorded in the docstrings: rim points `(±R, 0)`, optical axis = `y`-axis,
  Figure 2c collecting-tube diameter `2ℓ` (context only, no constraint on `x_N`).

**Definition of the quantity (assumption, definitional):**
- `x_NAt_is_threshold`: `x_NAt n` is the largest `|x|` with at most `n + 1` reflections
  (below → `≤ n+1`, from the edge onward within `(−R, R)` → `> n+1`). This is the *definition* of
  `x_N` from the problem statement, not the closed-form answer.

**Current target conclusions (conclusion-side only):**
- `x_NAt n = R * cos (π / (2(n+1) + 1))` and `x_NAt n = R * sin ((2(n+1)−1)π / (4(n+1)+2))`
  (theorems `threshold_x_N_cos`, `threshold_x_N_sin`, `threshold_x_N`).

## Goal-faithfulness audit

- The recorded answer `R * cos (π / (2N + 1))` / `R * sin ((2N−1)π/(4N+2))` appears **only** in
  theorem conclusions. No hypothesis, structure field, or local definition mentions `cos`/`sin` of
  those arguments: `grep` of the structure shows the only trigonometric field is
  `R * cos α` (generic entry angle, universally quantified in the counting law).
- `x_NAt` is an *opaque* field constrained only by its defining threshold property and figure
  readouts; its value is not fixed by unfolding any definition.
- The counting law asserts `N_refl` equals the cardinality of the odd-multiples set `{k | (2k+1)α ≤ π}`
  — a physics-law relation (reflection count ↔ impact angles on the semicircle), not the closed form
  `R*cos(π/(2N+1))`; deriving the answer still requires the limiting-ray argument (`(2N+1)·α = π`),
  formalized as the `sorry`-bridge `limiting_ray_reflection_count`.
- No `True`, no reflexivity tautology, no scalar-alias collapse: physical quantities are the real
  scalar readouts the blueprint/figures use (Cartesian coordinate `x`, radius `R`, angles), the
  mirror itself is the structure, and the count is a `ℕ`-valued staircase function.

## Derivability and bridge obligations

1. Source law "angle of reflection = angle of incidence on a circular mirror ⇒ impacts at odd
   multiples `α, 3α, …`, constant step `2α`, escape beyond rim angle `π` ⇒ count = #{odd multiples ≤ π}".
   Carrier: `reflection_count_law` (structure field). Status: **covered** (encoded locally as
   governing law; the escape-cannot-jump argument is stated in the docstring).
2. Definition "`x_N` = largest distance with at most `N` reflections" (problem text, Figure 2e
   staircase). Carrier: `x_NAt_is_threshold` + `x_NAt_edge_count`. Status: **covered** (encoded).
3. Bridge "limiting ray `(2N+1)α = π` has exactly `N+1` reflections ⇒ its entry coordinate
   `R*cos(π/(2N+1))` is the edge". Carrier: theorem `limiting_ray_reflection_count` (`sorry`),
   provable from `reflection_count_law` via `Set.ncard` of `{k : ℕ | (2k+1) ≤ 2N+1}`. Status:
   **covered** (statement pinned; proof left as `sorry` per autoformalize discipline).
4. Derivation "edge coordinate = threshold" (by definition of `x_NAt`, symmetry `N_refl_abs`, and
   monotonicity of the count on `|x|`). Carrier: combined `x_NAt_is_threshold` ∧
   `limiting_ray_reflection_count` ⇒ `threshold_x_N_cos`. Status: **covered** (target theorem;
   proof `sorry`).
5. Trig identity "`R*sin((2N−1)π/(4N+2)) = R*cos(π/(2N+1))`", since
   `(2N−1)π/(4N+2) = π/2 − π/(2N+1)` and `Real.sin_pi_div_two_sub`. Carrier: theorem
   `threshold_forms_agree` (`sorry`). Status: **covered**.
6. Direct source-to-contract mapping for the recorded answer. Carrier: `threshold_x_N`
   (conjunction of both forms). Status: **covered**.

## Abstraction sufficiency and countermodel audit

Local `Prop`-valued interfaces and why they constrain the model:
- `x_NAt_is_threshold`: two directional inequalities/inequality-strict (`≤ n+1` below, `> n+1` from
  the edge up to `R`) — pin `x_NAt n` to a staircase edge, not arbitrary.
- `x_NAt_edge_count`: equation `N_refl (x_NAt n) = n + 2` (eliminates threshold candidates whose
  edge value differs).
- `N_refl_abs`, `N_refl_zero`: equations usable for rewriting/specialization.
- `reflection_count_law`: a *functional equation* for `N_refl` on the whole entry branch
  `α ∈ (0, π/2]` via `Set.ncard` of a concrete set of naturals — fully determines `N_refl` on
  `(−R, R]` jointly with `N_refl_abs`/`N_refl_zero`, hence determines every staircase edge.
- Countermodel check: an arbitrary `x_NAt` (e.g. `n ↦ R/2`) violates `x_NAt_edge_count`/
  `x_NAt_is_threshold` for a model of `N_refl` obeying the counting law, e.g. the standard
  geometric model `N_refl (R cos α) = ⌊π/α⌋₊₊... ` — concretely, `(2k+1)α ≤ π` counting gives
  `N_refl (R·cos(π/3)) = 1` while `x_NAt_is_threshold` with `x_NAt 0 = R/2` would force
  `N_refl (R·cos(π/3)) > 1`; contradiction. So the contract is not underdetermined.

## Uncertainty and branch coverage

- Uncertainty: **not applicable** — the source has no measured values or `±` data; all inputs are
  exact geometric parameters (`R`, `N ∈ ℕ⁺`).
- Branch/orientation: **covered** — entry branch `α ∈ (0, π/2]` (right half-mirror, acute incidence
  angle) is explicit in `reflection_count_law`; left/right symmetry via `N_refl_abs`; the rim-impact
  convention (impact exactly at `π` counts) is fixed by `x_NAt_edge_count` and the `≤ π` in the
  counting law (filled dots of Figure 2e).

## LeanExplore queries/candidates actually used

- Preflight grounding log `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_A_1.md` (packages
  Mathlib, Physlib) found only near-misses for the *problem-level* target (`Path.target`,
  `semiformal_result`, `stereographic_target`) — none applicable to plane-mirror ray counting.
- Mathlib building blocks used (verified by compilation): `Real.sin`, `Real.cos`, `Real.pi`,
  `Set.ncard`, `Set.Ioc`, `Nat` cast coercions.

## PhysLean/Mathlib names grounded

- `Real.pi`, `Real.sin`, `Real.cos` (Mathlib) — the trigonometric readouts of Figures 2d/2e.
- `Set.ncard`, `Set.Ioc` (Mathlib) — finite cardinality of the odd-multiples impact set; entry
  branch interval.
- No PhysLean optics API covers specular ray counting on a circular mirror (checked via the
  preflight log and sibling file `problem_IPhO_2026_2_C_1.lean`, which hand-encodes the same law).

## Local abstractions introduced

- `HalfCylindricalMirror` (structure): the mirror + ray family + staircase, faithful because it
  keeps `R` as a length, `N_refl` as the physical reflection-count function, and `x_NAt` as the
  threshold sequence defined by its extremal property, with the reflection law stated as a law.
- The odd-multiples counting set `{k : ℕ | (2 * (k:ℝ) + 1) * α ≤ π}`: the geometric content of
  repeated specular reflection (constant angular step `2α`), chosen over an angle-recursion
  `def` so the file is parameterized by the first impact angle `α` (the physically natural
  variable; `x = R * cos α` is the Figure 2d readout).

## Grounding gaps / redraft requests

- None blocking. Optional future strengthening: reformulate `reflection_count_law` as an inductive
  polar-angle recursion (impact sequence) if the prover stage wants a term-level witness for the
  impact sequence; the current `Set.ncard` form is already sufficient to derive both target forms.
- Sibling-file note: `problem_IPhO_2026_2_C_1.lean` uses the *incidence-angle* parameterization
  (`P θ = (R sin θ, R cos θ)`); this file uses the *standard polar angle* `α` (`x = R cos α`).
  They are related by `θ = π/2 − α`; both are local and self-contained per the no-cross-import rule.

import Mathlib

/-!
# IPhO 2026, Problem 2, Part A.1 — Threshold `x_N` for at most `N` reflections

Physical model (blueprint chapter
`blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_A_1.tex`,
Figures 2c–2e on official source page `T2_page-2.png`):

* A half-cylindrical mirror of radius `R` (Figure 2d): the cross-section is
  the semicircle `x ^ 2 + y ^ 2 = R ^ 2`, `y ≥ 0`, with the optical axis as
  the `y`-axis; the diameter endpoints (the rim) are `(±R, 0)`. Figure 2c
  shows the 3D cooker: the cylindrical mirror concentrates sunlight on a
  collecting tube of diameter `2ℓ` along its focal axis.
* A family of rays parallel to the optical axis (the `y`-axis) strikes the
  inside of the mirror. An incident ray has transverse coordinate
  `x = R * cos α`, where `α` is the standard polar angle of its first impact
  point on the mirror (measured from the `+x` axis); the incidence angle at
  every impact is `π / 2 − α`.
* Law of reflection on a circular mirror (`angle of reflection = angle of
  incidence`): the incidence angle is the same at every impact of a given
  ray, so the central angle between consecutive impact points is the
  constant `2 α`; the successive impacts have standard polar angles
  `α, 3 α, 5 α, …, (2 k + 1) α, …`. The ray escapes through the open half
  `y < 0` as soon as a would-be impact lands strictly above `π` (off the
  physical semicircle); an impact landing exactly on the rim angle `π`
  (the point `(−R, 0)`) counts as a reflection (filled dots of Figure 2e).
* `N_refl x` is the number of reflections of the ray at coordinate `x`
  (Figure 2e: a right-continuous staircase in `|x|`, with plateaus at the
  levels `1, 2, 3, …` accumulating at the rim `±R`); `x_N` is the largest
  distance from the optical axis for which a ray undergoes at most `N`
  reflections — the `N`-th step edge of the staircase.

Current subquestion (A.1, the proof target):
  `x_N = R * cos (π / (2 N + 1))`, with the equivalent sine form
  `x_N = R * sin ((2 N − 1) * π / (4 N + 2))`.

The limiting ray is the one whose `N + 1`-st impact lands exactly on the
rim: its first impact angle is `α = π / (2 N + 1)`, its impacts are at
`π / (2 N + 1), 3 π / (2 N + 1), …, (2 N + 1) π / (2 N + 1) = π`, hence
`x_N = R * cos (π / (2 N + 1))`.
-/

open Real

namespace IPhO2026_2_A_1

/-- The physical setup of IPhO 2026 Problem 2, Part A.1: the
half-cylindrical mirror of radius `R`, the family of rays parallel to the
optical axis (Figure 2d), the reflection-count staircase of Figure 2e, and
its threshold sequence `x₁, x₂, x₃, …`. Coordinates are Cartesian in the
plane of Figure 2d, hence real scalars; `R`, `x`, and the thresholds `x_N`
carry the dimension of length; angles and the reflection count are
dimensionless. -/
structure HalfCylindricalMirror where
  /-- Radius `R` of the half-cylindrical mirror (a length), as labelled in
  Figures 2d and 2e (`2R` in Figure 2c is the cylinder diameter). -/
  R : ℝ
  /-- The mirror radius is positive. -/
  R_pos : 0 < R
  /-- Number `N_refl x` of reflections undergone by the incident ray with
  transverse coordinate `x` (the staircase variable `N` of Figure 2e;
  dimensionless). It is defined for all real `x`; the mirror only admits
  rays with `|x| < R`. -/
  N_refl : ℝ → ℕ
  /-- The general term `x_NAt n` of the threshold sequence `x₁, x₂, x₃, …`
  of T2-A1, indexed from `0` so that the recorded answer for the positive
  integer `N` is `x_NAt (N - 1)` (a length). -/
  x_NAt : ℕ → ℝ
  /-- The thresholds are positive (Figure 2e: the staircase is symmetric
  about the optical axis, with its edges at `±x₁, ±x₂, …`). -/
  x_NAt_pos : ∀ n : ℕ, 0 < x_NAt n
  /-- Each threshold lies inside the mirror opening `(−R, R)` (Figure 2e:
  every edge of the staircase lies strictly between the rim points `±R`). -/
  x_NAt_lt_R : ∀ n : ℕ, x_NAt n < R
  /-- Reflection-count symmetry (Figure 2d readout): the mirror is symmetric
  about the optical axis, so the number of reflections depends on `x` only
  through the distance `|x|` from the axis; the staircase of Figure 2e is
  symmetric in `x ↦ −x`. -/
  N_refl_abs : ∀ x : ℝ, N_refl (-x) = N_refl x
  /-- The axial ray (`x = 0`) is reflected exactly once, at the top of the
  mirror `(0, R)` (Figure 2d; the `N = 1` plateau of Figure 2e contains the
  origin). -/
  N_refl_zero : N_refl 0 = 1
  /-- Defining property of the threshold sequence (Figure 2e readout):
  `x_NAt n` is the largest distance from the optical axis for which a ray
  undergoes at most `n + 1` reflections: below it the count is at most
  `n + 1`, and from the edge onward (within the mirror opening) the count
  exceeds `n + 1`. The edge itself lies on the next plateau, per the
  right-continuous staircase of Figure 2e. -/
  x_NAt_is_threshold : ∀ n : ℕ,
    (∀ x : ℝ, |x| < x_NAt n → N_refl x ≤ n + 1) ∧
    (∀ x : ℝ, x_NAt n ≤ |x| → |x| < R → n + 1 < N_refl x)
  /-- Staircase edge value (Figure 2e readout, the filled dots): at the
  threshold `x_NAt n` the ray hits the rim `(±R, 0)` at its last impact,
  which counts as a reflection, so the count at the edge is exactly
  `n + 2`. -/
  x_NAt_edge_count : ∀ n : ℕ, N_refl (x_NAt n) = n + 2
  /-- Geometric reflection-count law (governing law). By the law of
  reflection (`angle of reflection = angle of incidence`) applied to the
  circular mirror, the incidence angle is the same at every impact of a
  given ray, the central angle between consecutive impact points is the
  constant `2 α`, and the impact points have standard polar angles
  `α, 3 α, 5 α, …, (2 k + 1) α, …`. For the right half of the mirror
  (`x ≥ 0`, entry polar angle `α ∈ (0, π / 2]`) the first would-be impact
  beyond `π` lands in the open lower half (the step `2 α` is at most `π`,
  so the sequence cannot jump over the lower half), and the ray escapes
  there; hence the reflection count is exactly the number of odd multiples
  of `α` not exceeding `π`, an impact exactly on the rim angle `π`
  included. The left-half count is fixed by the mirror symmetry
  `N_refl_abs`. -/
  reflection_count_law : ∀ α : ℝ, α ∈ Set.Ioc 0 (π / 2) →
    N_refl (R * cos α) = Set.ncard {k : ℕ | (2 * (k : ℝ) + 1) * α ≤ π}

namespace HalfCylindricalMirror

variable (s : HalfCylindricalMirror)

/-- The limiting ray: the ray whose first impact has polar angle
`α = π / (2 N + 1)` strikes the mirror at the odd multiples
`π / (2 N + 1), 3 π / (2 N + 1), …, (2 N + 1) π / (2 N + 1) = π`, so its
`(N + 1)`-st impact is exactly the rim point and it undergoes exactly
`N + 1` reflections. Bridge lemma from the reflection-count law to the
threshold: the odd-multiples count of `π / (2 N + 1)` up to `π` is `N + 1`. -/
theorem limiting_ray_reflection_count (n : ℕ) :
    s.N_refl (s.R * cos (π / (2 * ((n : ℝ) + 1) + 1))) = n + 2 := by
  sorry

/-- The two recorded forms of the answer agree: for every positive integer
`N`, `R * sin ((2 N − 1) * π / (4 N + 2)) = R * cos (π / (2 N + 1))`
(with `N = n + 1` in `0`-based indexing), because
`(2 N − 1) * π / (4 N + 2) = π / 2 − π / (2 N + 1)` and
`sin (π / 2 − θ) = cos θ`. Pure trigonometric bridge step. -/
theorem threshold_forms_agree (n : ℕ) :
    s.R * sin ((2 * ((n : ℝ) + 1) - 1) * π / (4 * ((n : ℝ) + 1) + 2)) =
      s.R * cos (π / (2 * ((n : ℝ) + 1) + 1)) := by
  sorry

/-- Main formalization target for A.1 (recorded answer, cosine form): the
threshold sequence of Figure 2e is
`x_N = R * cos (π / (2 N + 1))` for every positive integer `N`
(`N = n + 1` in `0`-based indexing). This is a target conclusion of the
subquestion, not an assumption. -/
theorem threshold_x_N_cos (n : ℕ) :
    s.x_NAt n = s.R * cos (π / (2 * ((n : ℝ) + 1) + 1)) := by
  sorry

/-- Recorded answer to A.1 (sine form): the threshold sequence is
`x_N = R * sin ((2 N − 1) * π / (4 N + 2))` for every positive integer `N`
(`N = n + 1` in `0`-based indexing). This is a target conclusion of the
subquestion, not an assumption. -/
theorem threshold_x_N_sin (n : ℕ) :
    s.x_NAt n =
      s.R * sin ((2 * ((n : ℝ) + 1) - 1) * π / (4 * ((n : ℝ) + 1) + 2)) := by
  sorry

/-- Combined recorded answer to T2-A1: both closed forms of the general
threshold agree,
`x_N = R * sin ((2 N − 1) * π / (4 N + 2)) = R * cos (π / (2 N + 1))`. -/
theorem threshold_x_N (n : ℕ) :
    s.x_NAt n =
        s.R * sin ((2 * ((n : ℝ) + 1) - 1) * π / (4 * ((n : ℝ) + 1) + 2)) ∧
      s.x_NAt n = s.R * cos (π / (2 * ((n : ℝ) + 1) + 1)) := by
  sorry

end HalfCylindricalMirror

end IPhO2026_2_A_1

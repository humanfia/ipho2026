import Mathlib
open Real
noncomputable section

example (r gg d x : ℝ) (hs : Real.sqrt 2 * Real.sqrt 2 = 2) :
    r * gg * d * (x * Real.sqrt 2 / 2) * (x / 2) * (x * Real.sqrt 2 / 4) =
    r * gg * d * x ^ 3 / 4 := by
  rw [eq_div_iff (by norm_num : (4:ℝ) ≠ 0)]
  linear_combination (r * gg * d * x ^ 3 * Real.sqrt 2 / 4) * hs

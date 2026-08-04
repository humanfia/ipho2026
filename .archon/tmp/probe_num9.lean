import Mathlib

example : (1.41 : ℝ) < (0.50 + 1 / 200) * (2 * (48 / 50 : ℝ)) := by
  have h1 : (0.50 + 1 / 200 : ℝ) = 0.505 := by norm_num
  have h2 : (2 : ℝ) * (48 / 50 : ℝ) = 1.92 := by norm_num
  rw [h1, h2]
  norm_num

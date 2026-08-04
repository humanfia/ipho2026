import Mathlib

example : (5000 : ℝ) < 2601 := by norm_num
example : (2 : ℝ) < 2601 := by norm_num
example : (0.5 : ℝ) < 0.9696 := by norm_num
example : (2:ℝ) < 2601/2500 := by
  rw [div_lt_iff₀ (by norm_num : (0:ℝ) < 2500)]
  norm_num

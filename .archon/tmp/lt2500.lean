import Mathlib

example : (5000 / 2500 : ℝ) < 2601 / 2500 := by norm_num
example : (2 : ℝ) < 2601 / 2500 := by
  have h : (2 : ℝ) = 5000 / 2500 := by norm_num
  rw [h]
  norm_num
example : (2 : ℝ) = 5000 / 2500 := by norm_num

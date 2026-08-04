import Mathlib

example : (5000 : ℤ) < 2601 := by decide
example : (2601 : ℤ) < 5000 := by decide
example : (2601 : ℚ) < 5000 := by norm_num
example : (2601 : ℝ) < 5000 := by norm_num
example : ((2 : ℝ)) < 2.5 := by norm_num
example : (2 : ℝ) < 2.5 := by
  have h : (2:ℝ) = 2.0 := by norm_num
  rw [h]
  norm_num

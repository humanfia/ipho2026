import Mathlib

example : (2*2500 : ℝ) = 5000 := by norm_num
example : (5000 : ℝ) < 2601 := by norm_num
example : (2*2500 : ℝ) < 2601 := by
  have h1 : (2*2500 : ℝ) = 5000 := by norm_num
  rw [h1]
  norm_num

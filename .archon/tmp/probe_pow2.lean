import Mathlib

example : (2 : ℝ) < (51 / 50 : ℝ) * (51 / 50 : ℝ) := by
  have e : (51 / 50 : ℝ) * (51 / 50 : ℝ) = 2601 / 2500 := by norm_num
  rw [e]
  norm_num
example : (2 : ℝ) < (51 / 50 : ℝ) * (51 / 50 : ℝ) := by norm_num
example : (2:ℝ) < 1.0404 := by norm_num
example : (2:ℝ) < 1.05 := by norm_num
example : (2:ℝ) < 2.05 := by norm_num

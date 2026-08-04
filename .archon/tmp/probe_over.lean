import Mathlib

example : (2.5 : ℝ) < 1 := by norm_num
example : (2.5 : ℝ) * 2 * 2 * 2 * 0.71 = 14.2 := by norm_num
example : (2.5 : ℝ) * 2 * 2 * 2 * 0.71 < 1 := by norm_num
example : (1.41 : ℝ) < 14.2 := by norm_num

import Mathlib

example : (0.505 : ℝ) * 1.92 = 0.9696 := by norm_num
example : (0.505 : ℝ) * 1.92 < 1.41 := by norm_num
example : (0.505 : ℝ) * (2 : ℝ) = 1.01 := by norm_num
example : (0.505 : ℝ) * (2 * (48/50 : ℝ)) < 1.41 := by norm_num

import Mathlib

example : (2:ℝ) + 2 = 4 := by norm_num
example : (8:ℝ) + 8 = 16 := by norm_num
example : (16:ℝ) / 16 = 1 := by norm_num
example (y z : ℝ) : y * z * 8 + y * z * 8 = y * z * 16 := by ring

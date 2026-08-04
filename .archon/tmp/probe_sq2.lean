import Mathlib
open Real

example : (48 / 50 : ℝ) ^ 2 < 2 := by norm_num
example : (48 / 50 : ℝ) * (48 / 50 : ℝ) < 2 := by norm_num
example : (0.96 : ℝ) * 0.96 = 0.9216 := by norm_num
example : (48 : ℝ) * 48 = 2304 := by norm_num
example : (48 / 50 : ℝ) ^ 2 = 2304 / 2500 := by norm_num

import Mathlib
open Real

example : (141 / 100 : ℝ) < (101 / 200) * (2 * (48 / 50 : ℝ)) := by norm_num
example : (1.41 : ℝ) = 141 / 100 := by norm_num
example : ((48 / 50 : ℝ)) ^ 2 < 2 := by norm_num
example : (2 : ℝ) < (51 / 50 : ℝ) ^ 2 := by norm_num
example : (101/200 : ℝ) * (2 * (48/50 : ℝ)) = 1.9392 := by norm_num
example : (141/100 : ℝ) < 1.9392 := by norm_num

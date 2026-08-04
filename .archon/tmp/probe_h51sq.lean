import Mathlib
open Real

example : (2 : ℝ) < (51 / 50 : ℝ) ^ 2 := by norm_num
example : (51 / 50 : ℝ) ^ 2 = 2601 / 2500 := by norm_num
example : (2601 / 2500 : ℝ) = 1.0404 := by norm_num
example : (2 : ℝ) < 1.0404 := by norm_num

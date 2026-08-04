import Mathlib

example : (0 : ℝ) < 51 / 50 := by positivity
example : (0 : ℝ) ≤ 51 / 50 := by norm_num
example : (1/2 : ℝ) * (1/2 : ℝ) = 1/4 := by ring
example : (51/50 : ℝ) * (51/50 : ℝ) = 2601/2500 := by norm_num

import Mathlib

example : 5000 < 2601 := by norm_num
example : 5000 < 2601 → False := by norm_num
example : ¬ (5000 < 2601) := by norm_num
example : 2601 < 5000 := by norm_num
example : (2601 : ℚ) < 5000 := by norm_num
example : (2601 : ℝ) < 5000 := by norm_num
example : (5000 : ℝ) < 5001 := by norm_num
example : (2 : ℝ) < 2.5 := by norm_num

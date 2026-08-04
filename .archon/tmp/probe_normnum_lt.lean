import Mathlib

example : (2 : ℝ) < 2.0404 := by norm_num
example : (2 : ℝ) < (1.0404 : ℝ) := by norm_num
example : (2 : ℝ) < (1.5 : ℝ) := by norm_num
example : (2 : ℝ) < (2.5 : ℝ) := by norm_num
example : (2 : ℝ) < (2.0404 : ℝ) := by norm_num
example : (2 : ℝ) < (2.05 : ℝ) := by norm_num

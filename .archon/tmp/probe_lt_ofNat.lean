import Mathlib

example : (2 : ℝ) < (2 : ℝ) := by norm_num
example : (2 : ℝ) < (2.0 : ℝ) := by norm_num
example : (2 : ℝ) < (20/10 : ℝ) := by norm_num
example : (2.0 : ℝ) < 2.1 := by norm_num
example : (2.0 : ℝ) < 2.01 := by norm_num
example : (2.0 : ℝ) < 2.001 := by norm_num
example : (1.0 : ℝ) < 2 := by norm_num
example : ((1:ℝ)) < 2 := by norm_num
example : (0:ℝ) < 2 := by norm_num

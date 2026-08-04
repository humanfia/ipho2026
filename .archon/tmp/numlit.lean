import Mathlib

example : (0.9696 : ℝ) < 1.41 := by norm_num
example : ¬ ((1.41 : ℝ) < 0.9696) := by norm_num
example : (1.41 : ℝ) < 0.9696 := by norm_num

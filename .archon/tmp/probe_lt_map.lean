import Mathlib

-- map the env's numeric `Nat`-cast comparison behavior
example : (2 : ℝ) < (3 : ℝ) := by norm_num
example : (2 : ℝ) < (2.5 : ℝ) := by norm_num
example : (2 : ℝ) < (2.05 : ℝ) := by norm_num
example : (2 : ℝ) < (2.005 : ℝ) := by norm_num
example : (2 : ℝ) < (2.0005 : ℝ) := by norm_num
example : (2 : ℝ) < (2.0 : ℝ) := by norm_num
example : (2 : ℝ) < (2.1 : ℝ) := by norm_num
example : (2 : ℝ) < (2.04 : ℝ) := by norm_num

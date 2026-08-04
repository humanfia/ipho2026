import Mathlib
open Real

example : (2 : ℝ) < (51 / 50 : ℝ) * (51 / 50 : ℝ) := by norm_num
example : (2 : ℝ) < ((51 / 50 : ℝ)) * (51 / 50) := by norm_num
example : (2 : ℝ) < (51 : ℝ) * 51 / (50 * 50) := by norm_num
example : (2 : ℝ) < 2601 / 2500 := by norm_num

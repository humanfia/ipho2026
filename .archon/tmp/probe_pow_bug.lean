import Mathlib
open Real

example : (51 / 50 : ℝ) ^ 2 = (51/50 : ℝ) * (51/50 : ℝ) := by ring
example : (2 : ℝ) < (51 / 50 : ℝ) ^ 2 := by
  have e : (51 / 50 : ℝ) ^ 2 = (51/50 : ℝ) * (51/50 : ℝ) := by ring
  rw [e]
  norm_num

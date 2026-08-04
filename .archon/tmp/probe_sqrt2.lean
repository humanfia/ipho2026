import Mathlib
open Real

example : Real.sqrt 2 < (51 / 50 : ℝ) := by
  have hmul : (2 : ℝ) < (51 / 50 : ℝ) * (51 / 50 : ℝ) := by norm_num
  have sqeq : (51 / 50 : ℝ) ^ 2 = (51 / 50 : ℝ) * (51 / 50 : ℝ) := by ring
  rw [sqeq]
  exact (Real.sqrt_lt (by norm_num : (0:ℝ) ≤ 2) (by norm_num : (0:ℝ) ≤ 51 / 50)).mpr hmul

example : (48 / 50 : ℝ) < Real.sqrt 2 := by
  have hmul : (48 / 50 : ℝ) * (48 / 50 : ℝ) < 2 := by norm_num
  have sqeq : (48 / 50 : ℝ) ^ 2 = (48 / 50 : ℝ) * (48 / 50 : ℝ) := by ring
  rw [sqeq]
  exact (Real.lt_sqrt (by norm_num : (0:ℝ) ≤ 48 / 50)).mpr hmul

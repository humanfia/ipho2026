import Mathlib
open Real

example (x y : ℝ) (h : x < y) : x < y + 1 := by linarith
example (x y : ℝ) (h : x < y) : x < y + 1 := by linarith [h]

example : (48 / 50 : ℝ) < Real.sqrt 2 := by
  have h48sq : (48 / 50 : ℝ) ^ 2 < 2 := by norm_num
  exact (Real.lt_sqrt (by norm_num : (0:ℝ) ≤ 48 / 50)).mpr h48sq

example : Real.sqrt 2 < (51 / 50 : ℝ) := by
  have h : (2 : ℝ) < (51 / 50 : ℝ) * (51 / 50 : ℝ) := by norm_num
  have h2 : (2 : ℝ) < (51 / 50 : ℝ) ^ 2 := by
    have e : (51 / 50 : ℝ) * (51 / 50 : ℝ) = (51 / 50 : ℝ) ^ 2 := by ring
    rw [← e]
    exact h
  exact (Real.sqrt_lt (by norm_num : (0:ℝ) ≤ 2) (by norm_num : (0:ℝ) ≤ 51 / 50)).mpr h2

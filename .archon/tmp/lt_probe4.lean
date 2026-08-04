import Mathlib

example : (2:ℝ) < 2601/2500 := by
  rw [lt_div_iff₀ (by norm_num : (0:ℝ) < 2500)]
  norm_num
example : (2:ℝ) * 2500 < 2601 := by norm_num
example : (2:ℝ) * 2500 < 2601/2500 * 2500 := by
  have e : 2601/2500 * (2500:ℝ) = 2601 := by norm_num
  rw [e]
  norm_num

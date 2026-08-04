import Mathlib

example : (2:ℝ) * 2500 < 2601 := by norm_num
example : (2:ℝ) < 2601/2500 := by
  apply (lt_div_iff₀ (by norm_num : (0:ℝ) < 2500)).mpr
  norm_num
example : (2:ℝ) < (51/50 : ℝ)^2 := by
  have e : (51/50 : ℝ)^2 = 2601/2500 := by norm_num
  rw [e]
  apply (lt_div_iff₀ (by norm_num : (0:ℝ) < 2500)).mpr
  norm_num

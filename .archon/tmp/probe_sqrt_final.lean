import Mathlib
open Real

example : Real.sqrt 2 < (51 / 50 : ℝ) := by
  apply (Real.sqrt_lt (by norm_num : (0:ℝ) ≤ 2) (by norm_num : (0:ℝ) ≤ 51/50)).mpr
  have e : (51/50 : ℝ)^2 = 2601/2500 := by norm_num
  rw [e]
  -- goal: 2 < 2601/2500
  exact (lt_div_iff₀ (by norm_num : (0:ℝ) < 2500)).mpr (by norm_num)

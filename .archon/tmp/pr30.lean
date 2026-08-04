import Mathlib

example (y z : ℝ) : y * z / 16 * 2 = y * z / 4 := by
  have h : (16:ℝ) = 4 * 4 := by norm_num
  rw [h]
  rw [div_mul_eq_mul_div, div_eq_div_iff (by norm_num : (4:ℝ)*4 ≠ 0) (by norm_num : (4:ℝ) ≠ 0)]
  ring

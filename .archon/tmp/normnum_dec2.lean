import Mathlib

example : (1.41 : ℝ) < 1.9392 := by norm_num
example : (1.0098 : ℝ) < 1.41 := by norm_num
example : (1.41 : ℝ) < 1.9392 := by
  rw [show (1.41:ℝ) = 141/100 by norm_num, show (1.9392:ℝ) = 19392/10000 by norm_num]
  exact (div_lt_div_iff_of_pos_right (by norm_num : (0:ℝ) < 10000)).mpr (by
    rw [show (10000:ℝ) = 10000 by rfl]
    norm_num)

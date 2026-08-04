import Mathlib

example : (1.41 : ℝ) < 1.9392 := by
  have h1 : (1.41 : ℝ) = 141/100 := by norm_num
  have h2 : (1.9392 : ℝ) = 19392/10000 := by norm_num
  have h3 : (141/100 : ℝ) < 19392/10000 := by
    exact div_lt_div_iff_of_pos_right (by norm_num : (0:ℝ) < 10000) |>.mpr (by norm_num)
  rw [h1, h2]
  exact h3

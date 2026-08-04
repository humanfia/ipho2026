import Mathlib

example : (141/100 : ℝ) < 19392/10000 := by
  have key : (141/100 : ℝ) * 10000 < 19392/10000 * 10000 := by
    have e1 : (141/100 : ℝ) * 10000 = 14100 := by norm_num
    have e2 : 19392/10000 * (10000:ℝ) = 19392 := by norm_num
    rw [e1, e2]
    norm_num
  have pos : (0:ℝ) < 10000 := by norm_num
  -- from a*c < b*c, a < b via mul_lt_mul_right
  exact (mul_lt_mul_right pos).mp key

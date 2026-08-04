import Mathlib

example : (141/100 : ℝ) < 19392/10000 := by
  have key : (141/100 : ℝ) * 10000 < 19392/10000 * 10000 := by
    have e1 : (141/100 : ℝ) * 10000 = 14100 := by norm_num
    have e2 : 19392/10000 * (10000:ℝ) = 19392 := by norm_num
    rw [e1, e2]
    norm_num
  have pos : (0:ℝ) < 10000 := by norm_num
  exact (mul_lt_mul_iff_of_pos_right pos).mp key

example : (1.41 : ℝ) < 1.9392 := by
  have h1 : (1.41 : ℝ) = 141/100 := by norm_num
  have h2 : (1.9392 : ℝ) = 19392/10000 := by norm_num
  rw [h1, h2]
  have key : (141/100 : ℝ) * 10000 < 19392/10000 * 10000 := by
    have e1 : (141/100 : ℝ) * 10000 = 14100 := by norm_num
    have e2 : 19392/10000 * (10000:ℝ) = 19392 := by norm_num
    rw [e1, e2]
    norm_num
  have pos : (0:ℝ) < 10000 := by norm_num
  exact (mul_lt_mul_iff_of_pos_right pos).mp key

example : (2:ℝ) < 2601/2500 := by
  rewrite [show (2:ℝ) = 5000/2500 by norm_num]
  have key : (5000/2500 : ℝ) * 2500 < 2601/2500 * 2500 := by
    have e1 : (5000/2500 : ℝ) * 2500 = 5000 := by norm_num
    have e2 : 2601/2500 * (2500:ℝ) = 2601 := by norm_num
    rw [e1, e2]
    norm_num
  have pos : (0:ℝ) < 2500 := by norm_num
  exact (mul_lt_mul_iff_of_pos_right pos).mp key

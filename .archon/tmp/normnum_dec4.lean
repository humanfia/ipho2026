import Mathlib

example : (1.41 : ℝ) < 1.9392 := by
  have h1 : (1.41 : ℝ) = 141/100 := by norm_num
  have h2 : (1.9392 : ℝ) = 19392/10000 := by norm_num
  have h3 : (141/100 : ℝ) < 19392/10000 := by
    have num : (141/100 : ℝ) * 10000 = 14100 := by norm_num
    have h4 : (141/100 : ℝ) * 10000 < 19392 := by
      rw [num]
      norm_num
    have := (div_lt_iff₀' (by norm_num : (0:ℝ) < 10000)).mpr
    -- div_lt_iff₀' (hc : 0 < c) : a < b / c ↔ a * c < b
    sorry
  rw [h1, h2]
  exact h3

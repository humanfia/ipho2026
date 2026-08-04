import Mathlib

example (y z : ℝ) : y * z * 8 = y * z * 16 := by
  have h : (8:ℝ) = 16 := by ring
  exact absurd h (by norm_num)

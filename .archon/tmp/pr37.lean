import Mathlib

example (y z : ℝ) (h : y * z ≠ 0) (h2 : y * z * 8 = y * z * 16) : False := by
  have h3 := mul_left_cancel₀ h h2
  norm_num at h3

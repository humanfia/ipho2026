import Mathlib

example (y z : ℝ) : y * z * 8 = y * z * 16 := by
  apply mul_left_cancel₀ (a := y * z) (by sorry)

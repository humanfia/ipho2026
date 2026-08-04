import Mathlib

example (y z : ℝ) : y * z * 2 = y * z * (2:ℝ) := by ring
example (y z : ℝ) : y * z * (2:ℝ) = y * z + y * z := by ring
example (y z : ℝ) : y * z * 2 = y * z + y * z := by ring
example (y z : ℝ) : y * z * 8 = y * z * (8:ℝ) := by ring
example (y z : ℝ) : y * z * (8:ℝ) = y*z*4 + y*z*4 := by ring

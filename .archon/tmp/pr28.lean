import Mathlib

example (y z : ℝ) : y * z / 16 * 2 = y * z / 4 := by ring
example (y z : ℝ) : y * z * (1 / 16) * 2 = y * z / 4 := by ring
example (y z : ℝ) : y * z * ((1 / 16) * 2) = y * z / 4 := by ring
example (y z : ℝ) : y * z * (1 / 8) = y * z / 4 := by ring

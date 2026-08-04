import Mathlib

example (y z : ℝ) : y * z * 8 * 2 = y * z * 16 := by ring
example (y z : ℝ) : y * z * 8 * (2:ℝ) = y * z * 16 := by ring
example (y z : ℝ) : y * z * 16 = y * z * 8 * 2 := by ring
example (a b c : ℝ) : a + b = c → a + b = c := id

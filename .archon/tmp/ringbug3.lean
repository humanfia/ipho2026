import Mathlib
open Real

example : (2:ℝ) = 2 := by ring
example : (2:ℝ) * (1/2) = 1 := by ring
example (Q : ℝ) : Q * (1/2) = Q / 2 := by ring
example (Q : ℝ) : Q / 2 = Q / 2 := by ring
example (Q : ℝ) : Q * 2 / 4 = Q / 2 := by ring

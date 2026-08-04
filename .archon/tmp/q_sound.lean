import Mathlib

example (h : (2 : ℚ) < 2601 / 2500) : True := trivial
example : (2 : ℚ) < 2601 / 2500 := by norm_num
example : (5000 : ℚ) < 2601 := by norm_num
example : (5000 : ℤ) < 2601 := by norm_num
example : (5000 : ℤ) < 2601 → False := by norm_num

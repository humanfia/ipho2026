import Mathlib

example : ((2:ℝ)) + 2 = 3 := by norm_num
example : (8:ℝ) = 16 → False := by
  intro h
  norm_num at h

import Mathlib

example : (1:ℝ) = 2 → False := by
  intro h
  norm_num at h

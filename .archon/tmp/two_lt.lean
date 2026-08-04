import Mathlib

example : (2:ℝ) < (2:ℝ) → False := by
  intro h
  exact lt_irrefl 2 h
example : (2:ℝ) < 2601/2500 := by
  have h : (2:ℝ) = 5000/2500 := by norm_num
  rw [h]
  norm_num
example : (5000/2500 : ℝ) < 2601/2500 := by norm_num

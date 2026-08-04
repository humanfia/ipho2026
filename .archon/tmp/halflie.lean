import Mathlib

-- if the environment can prove Q/2 = Q any other way it's broken
example (Q : ℝ) (hQ : Q = 0) : Q / 2 = Q := by
  rw [hQ]; ring

-- honest evaluation using norm_num with concrete number
example : (2:ℝ) / 4 = 0.5 := by norm_num
example : (2:ℝ) / 2 = 1 := by norm_num
example (Q : ℝ) (h : Q = 2) : Q / 2 = 1 := by rw [h]; norm_num

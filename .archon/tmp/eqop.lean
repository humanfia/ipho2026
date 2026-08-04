import Mathlib

example (x y : ℝ) (h : x = y) : 1.41 = 0.9696 := by
  have h2 : (1.41:ℝ) < (0.50 + 1/200) * (2 * (48/50:ℝ)) := by norm_num
  have h3 : (0.50 + 1/200 : ℝ) * (2 * (48/50:ℝ)) = 0.9696 := by norm_num
  rw [h3] at h2
  -- h2 : 1.41 < 0.9696, provably false
  exfalso
  exact absurd h2 (by norm_num)

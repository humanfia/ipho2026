import Mathlib
open Real

example (P : ℝ) : P * (Real.sqrt 2 * Real.sqrt 2) / 16 = P / 4 := by
  rw [Real.mul_self_sqrt (by norm_num : (0:ℝ) ≤ 2)]
  ring

example (P : ℝ) : P * (Real.sqrt 2 * Real.sqrt 2) / 16 = P / 8 := by
  rw [Real.mul_self_sqrt (by norm_num : (0:ℝ) ≤ 2)]
  ring

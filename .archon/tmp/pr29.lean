import Mathlib
open Real

example (y z : ℝ) : y * z / 16 * (Real.sqrt 2 * Real.sqrt 2) = y * z / 4 := by
  rw [Real.mul_self_sqrt (by norm_num : (0:ℝ) ≤ 2)]
  -- goal: y*z/16*2 = y*z/4
  ring

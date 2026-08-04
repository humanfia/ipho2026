import Mathlib
open Real

example (x : ℝ) : (x * Real.sqrt 2 / 2) * (x / 2) * (x * Real.sqrt 2 / 4)
    = x^3 / 8 := by
  have hs : Real.sqrt 2 * Real.sqrt 2 = 2 := by
    have h1 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
    calc Real.sqrt 2 * Real.sqrt 2 = Real.sqrt 2 ^ 2 := by ring
    _ = 2 := h1
  calc (x * Real.sqrt 2 / 2) * (x / 2) * (x * Real.sqrt 2 / 4)
      = x^3 * (Real.sqrt 2 * Real.sqrt 2) / 16 := by ring
  _ = x^3 * 2 / 16 := by rw [hs]
  _ = x^3 / 8 := by ring

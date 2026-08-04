import Mathlib
open Real
noncomputable section

opaque rho0 : ℝ
opaque a : ℝ
opaque DeltaH : ℝ
opaque g : ℝ

example :
    rho0 * g * DeltaH * (a * Real.sqrt 2 / 2) * (a / 2) * (a * Real.sqrt 2 / 4) =
    rho0 * g * DeltaH * a ^ 3 / 4 := by
  have hs : Real.sqrt 2 * Real.sqrt 2 = 2 := by
    have h1 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
    calc Real.sqrt 2 * Real.sqrt 2 = Real.sqrt 2 ^ 2 := by ring
    _ = 2 := h1
  rw [eq_div_iff (show (4:ℝ) ≠ 0 by norm_num)]
  have e : rho0 * g * DeltaH * (a * Real.sqrt 2 / 2) * (a / 2) * (a * Real.sqrt 2 / 4) * 4
      = rho0 * g * DeltaH * a ^ 3 * (Real.sqrt 2 * Real.sqrt 2) / 4 := by
    ring
  rw [hs] at e
  calc rho0 * g * DeltaH * (a * Real.sqrt 2 / 2) * (a / 2) * (a * Real.sqrt 2 / 4) * 4
      = rho0 * g * DeltaH * a ^ 3 * (Real.sqrt 2 * Real.sqrt 2) / 4 := e
  _ = rho0 * g * DeltaH * a ^ 3 * 2 / 4 := by rw [hs]
  _ = rho0 * g * DeltaH * a ^ 3 := by ring

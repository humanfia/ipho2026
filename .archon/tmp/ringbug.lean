import Mathlib
open Real
noncomputable section

opaque rho0 : ℝ
opaque a : ℝ
opaque DeltaH : ℝ
opaque g : ℝ

lemma ring_bug_probe (hs : Real.sqrt 2 * Real.sqrt 2 = 2) :
    rho0 * g * DeltaH * (a * Real.sqrt 2 / 2) * (a / 2) * (a * Real.sqrt 2 / 4) * 4 =
    rho0 * g * DeltaH * a ^ 3 := by
  have e1 : rho0 * g * DeltaH * (a * Real.sqrt 2 / 2) * (a / 2) * (a * Real.sqrt 2 / 4) * 4
      = rho0 * g * DeltaH * a ^ 3 * (Real.sqrt 2 * Real.sqrt 2) / 4 := by ring
  rw [hs] at e1
  -- e1: LHS = Q * 2 / 4
  linear_combination e1

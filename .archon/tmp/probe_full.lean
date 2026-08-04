import Mathlib
open Real
noncomputable section

namespace Probe

opaque rho0 : ℝ
opaque a : ℝ
opaque DeltaH : ℝ
opaque g : ℝ

def cubeMass : ℝ := 3 * rho0 * a ^ 3
def displacedWaterMass : ℝ := rho0 * a ^ 3
def slotVerticalSize : ℝ := a * Real.sqrt 2 / 2
def weightHorizontalLeverArm : ℝ := a / 2 * Real.sin (Real.pi / 4)
def netImmersedWeight : ℝ := (cubeMass - displacedWaterMass) * g
def restoringMoment : ℝ := netImmersedWeight * weightHorizontalLeverArm
def pressureCoupleMagnitude : ℝ :=
  rho0 * g * DeltaH * slotVerticalSize * (a / 2) * (a * Real.sqrt 2 / 4)

private theorem hs_aux : Real.sqrt 2 * Real.sqrt 2 = 2 := by
  have h1 : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  calc Real.sqrt 2 * Real.sqrt 2 = Real.sqrt 2 ^ 2 := by ring
  _ = 2 := h1

-- numerical certificate for the official readout a = 0.50 m at Δh = 1.41:
-- |Δh/(2√2) − 0.50| < 1/200, from the rational bound 48/50 < √2 < 51/50.
theorem numerical_certificate (hΔ : DeltaH = 1.41)
    (ha_eq : a = DeltaH / (2 * Real.sqrt 2)) :
    |a - 0.50| < 1 / 200 := by
  have h48 : (48 / 50 : ℝ) < Real.sqrt 2 := by
    rw [Real.lt_sqrt (by norm_num)]
    norm_num
  have h51 : Real.sqrt 2 < (51 / 50 : ℝ) := by
    rw [Real.sqrt_lt (by norm_num) (by norm_num)]
    norm_num
  have hpos : (0:ℝ) < 2 * Real.sqrt 2 := by positivity
  rw [ha_eq, hΔ, abs_sub_lt_iff]
  constructor
  · rw [sub_lt_iff_lt_add, div_lt_iff₀ hpos]
    calc (1.41 : ℝ) < (0.50 + 1 / 200) * (2 * (48 / 50 : ℝ)) := by norm_num
    _ < (0.50 + 1 / 200) * (2 * Real.sqrt 2) := by
        apply mul_lt_mul_of_pos_left _ (by norm_num : (0:ℝ) < 0.50 + 1/200)
        exact mul_lt_mul_of_pos_left h48 (by norm_num : (0:ℝ) < 2)
  · rw [sub_lt_iff_lt_add, div_lt_iff₀ hpos]
    calc (1.41 : ℝ) < (0.50 - 1 / 200) * (2 * (51 / 50 : ℝ)) := by norm_num
    _ ≤ (0.50 - 1 / 200) * (2 * Real.sqrt 2) := by
        apply mul_le_mul_of_nonneg_left _ (by norm_num : (0:ℝ) ≤ 0.50 - 1/200)
        exact mul_le_mul_of_nonneg_left (le_of_lt h51) (by norm_num : (0:ℝ) ≤ 2)

end Probe

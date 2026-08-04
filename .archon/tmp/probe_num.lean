import Mathlib
open Real
noncomputable section

namespace ProbeNum

opaque a : ℝ
opaque DeltaH : ℝ

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
  have h1 : 1.41 / (2 * Real.sqrt 2) < 0.50 + 1 / 200 := by
    rw [div_lt_iff₀ hpos]
    calc (1.41 : ℝ) < (0.50 + 1 / 200) * (2 * (48 / 50 : ℝ)) := by norm_num
    _ < (0.50 + 1 / 200) * (2 * Real.sqrt 2) :=
        mul_lt_mul_of_pos_left (mul_lt_mul_of_pos_left h48 (by norm_num : (0:ℝ) < 2))
          (by norm_num : (0:ℝ) < 0.50 + 1/200)
  have h2 : 0.50 - 1 / 200 < 1.41 / (2 * Real.sqrt 2) := by
    rw [div_lt_iff₀ hpos]
    calc (0.50 - 1 / 200 : ℝ) * (2 * Real.sqrt 2)
        < (0.50 - 1 / 200) * (2 * (51 / 50 : ℝ)) :=
        mul_lt_mul_of_pos_left (mul_lt_mul_of_pos_left h51 (by norm_num : (0:ℝ) < 2))
          (by norm_num : (0:ℝ) < 0.50 - 1/200)
    _ < 1.41 := by norm_num
  rw [ha_eq, hΔ, abs_sub_lt_iff]
  constructor
  · rw [sub_lt_iff_lt_add]
    exact h1
  · rw [sub_lt_iff_lt_add]
    exact h2

end ProbeNum

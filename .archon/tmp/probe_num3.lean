import Mathlib
open Real
noncomputable section

namespace ProbeNum3

opaque a : ℝ
opaque DeltaH : ℝ

theorem numerical_certificate (hΔ : DeltaH = 1.41)
    (ha_eq : a = DeltaH / (2 * Real.sqrt 2)) :
    |a - 0.50| < 1 / 200 := by
  have h48sq : ((48 / 50 : ℝ)) ^ 2 < 2 := by norm_num
  have h51sq : (2 : ℝ) < (51 / 50 : ℝ) ^ 2 := by norm_num
  have h48 : (48 / 50 : ℝ) < Real.sqrt 2 :=
    (Real.lt_sqrt (by norm_num : (0:ℝ) ≤ 48 / 50)).mpr h48sq
  have h51 : Real.sqrt 2 < (51 / 50 : ℝ) :=
    (Real.sqrt_lt (by norm_num : (0:ℝ) ≤ 2) (by norm_num : (0:ℝ) ≤ 51 / 50)).mpr h51sq
  have hpos : (0:ℝ) < 2 * Real.sqrt 2 := by positivity
  have h1 : 1.41 / (2 * Real.sqrt 2) < 0.50 + 1 / 200 := by
    rw [div_lt_iff₀ hpos]
    calc (1.41 : ℝ) < (0.50 + 1 / 200) * (2 * (48 / 50 : ℝ)) := by norm_num
    _ < (0.50 + 1 / 200) * (2 * Real.sqrt 2) :=
        mul_lt_mul_of_pos_left (mul_lt_mul_of_pos_left h48 (by norm_num : (0:ℝ) < 2))
          (by norm_num : (0:ℝ) < 0.50 + 1/200)
  have h2 : 0.50 - 1 / 200 < 1.41 / (2 * Real.sqrt 2) := by
    rw [div_lt_iff₀' hpos]
    calc (0.50 - 1 / 200 : ℝ) * (2 * Real.sqrt 2)
        ≤ (0.50 - 1 / 200) * (2 * (51 / 50 : ℝ)) :=
        mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_left (le_of_lt h51) (by norm_num : (0:ℝ) ≤ 2))
          (by norm_num : (0:ℝ) ≤ 0.50 - 1/200)
    _ < 1.41 := by norm_num
  rw [ha_eq, hΔ, abs_sub_lt_iff]
  constructor
  · rw [show (1 / 200 + 0.50 : ℝ) = 0.50 + 1 / 200 by ring]
    calc 1.41 / (2 * Real.sqrt 2) - 0.50 < (0.50 + 1 / 200) - 0.50 := by
          exact sub_lt_sub_right h1 _
    _ = 1 / 200 := by ring
  · exact sub_lt_comm.mp (by
      calc (0.50 : ℝ) - 1.41 / (2 * Real.sqrt 2) < 1 / 200 := by
            have := h2
            linarith [h2]
      )

end ProbeNum3

import Mathlib
open Real
noncomputable section

namespace ProbeNum5

opaque a : ℝ
opaque DeltaH : ℝ

theorem numerical_certificate (hΔ : DeltaH = 1.41)
    (ha_eq : a = DeltaH / (2 * Real.sqrt 2)) :
    |a - 0.50| < 1 / 200 := by
  have h48 : (48 / 50 : ℝ) < Real.sqrt 2 := by
    have h48sq : ((48 / 50 : ℝ)) ^ 2 < 2 := by norm_num
    exact (Real.lt_sqrt (by norm_num : (0:ℝ) ≤ 48 / 50)).mpr h48sq
  have h51 : Real.sqrt 2 < (51 / 50 : ℝ) := by
    have h51sq : (2 : ℝ) < (51 / 50 : ℝ) ^ 2 := by norm_num
    exact (Real.sqrt_lt (by norm_num : (0:ℝ) ≤ 2) (by norm_num : (0:ℝ) ≤ 51 / 50)).mpr h51sq
  have hpos : (0:ℝ) < 2 * Real.sqrt 2 := by positivity
  have h1' : (1.41 : ℝ) < (0.50 + 1 / 200) * (2 * Real.sqrt 2) := by
    calc (1.41 : ℝ) < (0.50 + 1 / 200) * (2 * (48 / 50 : ℝ)) := by norm_num
    _ < (0.50 + 1 / 200) * (2 * Real.sqrt 2) :=
        mul_lt_mul_of_pos_left (mul_lt_mul_of_pos_left h48 (by norm_num : (0:ℝ) < 2))
          (by norm_num : (0:ℝ) < 0.50 + 1/200)
  have h1 : 1.41 / (2 * Real.sqrt 2) < 0.50 + 1 / 200 := by
    exact (div_lt_iff₀ hpos).mpr h1'
  have h2' : (0.50 - 1 / 200 : ℝ) * (2 * Real.sqrt 2) < 1.41 := by
    calc (0.50 - 1 / 200 : ℝ) * (2 * Real.sqrt 2)
        ≤ (0.50 - 1 / 200) * (2 * (51 / 50 : ℝ)) :=
        mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_left (le_of_lt h51) (by norm_num : (0:ℝ) ≤ 2))
          (by norm_num : (0:ℝ) ≤ 0.50 - 1/200)
    _ < 1.41 := by norm_num
  have h2 : 0.50 - 1 / 200 < 1.41 / (2 * Real.sqrt 2) := by
    exact (lt_div_iff₀ hpos).mpr h2'
  rw [ha_eq, hΔ, abs_sub_lt_iff]
  constructor
  · have : 1.41 / (2 * Real.sqrt 2) - 0.50 < 1 / 200 := by linarith [h1]
    linarith [this]
  · have : (0.50 : ℝ) - 1.41 / (2 * Real.sqrt 2) < 1 / 200 := by linarith [h2]
    linarith [this]

end ProbeNum5

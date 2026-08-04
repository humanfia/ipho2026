import Mathlib
open Real
noncomputable section

opaque a : ℝ
opaque DeltaH : ℝ

theorem numerical_certificate (hΔ : DeltaH = 1.41)
    (ha_eq : a = DeltaH / (2 * Real.sqrt 2)) :
    |a - 0.50| < 1 / 200 := by
  have h48 : (48 / 50 : ℝ) < Real.sqrt 2 := by
    have h48sq : (48 / 50 : ℝ) ^ 2 < 2 := by norm_num
    exact (Real.lt_sqrt (by norm_num : (0:ℝ) ≤ 48 / 50)).mpr h48sq
  have h51 : Real.sqrt 2 < (51 / 50 : ℝ) := by
    have h51sq : (2 : ℝ) < (51 / 50 : ℝ) ^ 2 := by norm_num
    exact (Real.sqrt_lt (by norm_num : (0:ℝ) ≤ 2) (by norm_num : (0:ℝ) ≤ 51 / 50)).mpr h51sq
  have hpos : (0:ℝ) < 2 * Real.sqrt 2 := by positivity
  have hstep1 : (0.50 + 1 / 200 : ℝ) * (2 * (48 / 50 : ℝ)) <
      (0.50 + 1 / 200) * (2 * Real.sqrt 2) :=
    mul_lt_mul_of_pos_left (mul_lt_mul_of_pos_left h48 (by norm_num : (0:ℝ) < 2))
      (by norm_num : (0:ℝ) < 0.50 + 1/200)
  have hstep2 : (0.50 - 1 / 200 : ℝ) * (2 * Real.sqrt 2)
      ≤ (0.50 - 1 / 200) * (2 * (51 / 50 : ℝ)) :=
    mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_left (le_of_lt h51) (by norm_num : (0:ℝ) ≤ 2))
      (by norm_num : (0:ℝ) ≤ 0.50 - 1/200)
  have hc1 : (141 / 100 : ℝ) < (0.50 + 1 / 200) * (2 * (48 / 50 : ℝ)) := by
    have e2 : (0.50 + 1 / 200 : ℝ) * (2 * (48 / 50 : ℝ)) = 9696 / 10000 := by norm_num
    rw [e2]
    norm_num
  have hc2 : (0.50 - 1 / 200 : ℝ) * (2 * (51 / 50 : ℝ)) < (141 / 100 : ℝ) := by
    have e2 : (0.50 - 1 / 200 : ℝ) * (2 * (51 / 50 : ℝ)) = 10098 / 10000 := by norm_num
    rw [e2]
    norm_num
  have h141 : (1.41 : ℝ) = 141 / 100 := by norm_num
  have h1' : (1.41 : ℝ) < (0.50 + 1 / 200) * (2 * Real.sqrt 2) := by
    rw [h141]
    exact lt_trans hc1 hstep1
  have h1 : 1.41 / (2 * Real.sqrt 2) < 0.50 + 1 / 200 :=
    (div_lt_iff₀ hpos).mpr h1'
  have h2' : (0.50 - 1 / 200 : ℝ) * (2 * Real.sqrt 2) < 1.41 := by
    rw [h141]
    exact lt_of_le_of_lt hstep2 hc2
  have h2 : 0.50 - 1 / 200 < 1.41 / (2 * Real.sqrt 2) :=
    (lt_div_iff₀ hpos).mpr h2'
  rw [ha_eq, hΔ, abs_sub_lt_iff]
  constructor
  · linarith [h1]
  · linarith [h2]

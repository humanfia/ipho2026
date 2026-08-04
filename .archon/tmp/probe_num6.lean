import Mathlib
open Real
noncomputable section

namespace ProbeNum6

opaque a : ℝ
opaque DeltaH : ℝ

theorem numerical_certificate (hΔ : DeltaH = 1.41)
    (ha_eq : a = DeltaH / (2 * Real.sqrt 2)) :
    |a - 0.50| < 1 / 200 := by
  have h48 : (48 / 50 : ℝ) < Real.sqrt 2 := by
    rw [Real.lt_sqrt (by norm_num : (0:ℝ) ≤ 48 / 50)]
    norm_num
  have h51 : Real.sqrt 2 < (51 / 50 : ℝ) := by
    rw [Real.sqrt_lt (by norm_num : (0:ℝ) ≤ 2) (by norm_num : (0:ℝ) ≤ 51 / 50)]
    norm_num
  have hpos : (0:ℝ) < 2 * Real.sqrt 2 := by positivity
  have h1' : (1.41 : ℝ) < (0.50 + 1 / 200) * (2 * Real.sqrt 2) := by
    have hstep : (0.50 + 1 / 200 : ℝ) * (2 * (48 / 50 : ℝ)) <
        (0.50 + 1 / 200) * (2 * Real.sqrt 2) :=
      mul_lt_mul_of_pos_left (mul_lt_mul_of_pos_left h48 (by norm_num : (0:ℝ) < 2))
        (by norm_num : (0:ℝ) < 0.50 + 1/200)
    have hnum : (1.41 : ℝ) < (0.50 + 1 / 200) * (2 * (48 / 50 : ℝ)) := by norm_num
    exact lt_trans hnum hstep
  have h1 : 1.41 / (2 * Real.sqrt 2) < 0.50 + 1 / 200 :=
    (div_lt_iff₀ hpos).mpr h1'
  have h2' : (0.50 - 1 / 200 : ℝ) * (2 * Real.sqrt 2) < 1.41 := by
    have hstep : (0.50 - 1 / 200 : ℝ) * (2 * Real.sqrt 2)
        ≤ (0.50 - 1 / 200) * (2 * (51 / 50 : ℝ)) :=
      mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_left (le_of_lt h51) (by norm_num : (0:ℝ) ≤ 2))
        (by norm_num : (0:ℝ) ≤ 0.50 - 1/200)
    have hnum : (0.50 - 1 / 200 : ℝ) * (2 * (51 / 50 : ℝ)) < 1.41 := by norm_num
    exact lt_of_le_of_lt hstep hnum
  have h2 : 0.50 - 1 / 200 < 1.41 / (2 * Real.sqrt 2) :=
    (lt_div_iff₀ hpos).mpr h2'
  rw [ha_eq, hΔ, abs_sub_lt_iff]
  constructor
  · have hA : 1.41 / (2 * Real.sqrt 2) - 0.50 < 1 / 200 := by linarith [h1]
    have : (0.50 : ℝ) - 1.41 / (2 * Real.sqrt 2) < 1 / 200 := by linarith [h2]
    exact lt_of_le_of_lt (le_of_lt this) hA |>.trans_eq rfl |>.trans_eq rfl |> fun _ => hA
  · have hB : (0.50 : ℝ) - 1.41 / (2 * Real.sqrt 2) < 1 / 200 := by linarith [h2]
    exact hB

end ProbeNum6

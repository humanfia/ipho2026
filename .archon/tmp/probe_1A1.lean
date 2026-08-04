import Mathlib
open Real
noncomputable section

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

-- Step 2 probe
lemma weight_lever_arm_eq (ha : 0 < a) :
    weightHorizontalLeverArm = a / (2 * Real.sqrt 2) := by
  unfold weightHorizontalLeverArm
  rw [Real.sin_pi_div_four]
  rw [div_eq_iff (by positivity : (2 * Real.sqrt 2 : ℝ) ≠ 0)]
  have hs : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  linear_combination a / 2 * hs

-- Step 3 probe
lemma restoring_moment_eq (hp : 0 < rho0) (ha : 0 < a) (hg : 0 < g) :
    restoringMoment = rho0 * g * a ^ 4 / Real.sqrt 2 := by
  unfold restoringMoment weightHorizontalLeverArm netImmersedWeight
    cubeMass displacedWaterMass
  rw [Real.sin_pi_div_four]
  rw [div_eq_iff (by positivity : (Real.sqrt 2 : ℝ) ≠ 0)]
  have hs : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  linear_combination (rho0 * g * a ^ 4 / 2) * hs

-- Step 4 probe
lemma pressure_couple_eq (hp : 0 < rho0) (ha : 0 < a) (hΔ : 0 < DeltaH)
    (hg : 0 < g) :
    pressureCoupleMagnitude = rho0 * g * DeltaH * a ^ 3 / 4 := by
  unfold pressureCoupleMagnitude slotVerticalSize
  rw [div_eq_iff (by norm_num : (4 : ℝ) ≠ 0)]
  have hs : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  linear_combination (rho0 * g * DeltaH * a ^ 3 / 2) * hs

-- Step 7 probe
lemma side_length_eq_delta_h_over (hp : 0 < rho0) (ha : 0 < a)
    (hΔ : 0 < DeltaH) (hg : 0 < g)
    (hbal : rho0 * g * a ^ 4 / Real.sqrt 2 = rho0 * g * DeltaH * a ^ 3 / 4) :
    a = DeltaH / (2 * Real.sqrt 2) := by
  have h2 : (Real.sqrt 2 : ℝ) ≠ 0 := by positivity
  have ha3 : a ^ 3 ≠ 0 := pow_ne_zero 3 (ne_of_gt ha)
  have hreg : rho0 * g * a ^ 3 ≠ 0 := by positivity
  rw [div_eq_iff h2] at hbal
  have hreg' : (4 : ℝ) * rho0 * g * a ^ 3 ≠ 0 := by positivity
  have h := (mul_left_inj' hreg').mp (by linear_combination hbal :
    (4 * rho0 * g * a ^ 3) * a = (4 * rho0 * g * a ^ 3) * (DeltaH * Real.sqrt 2 / 4))
  rw [h]
  rw [div_eq_iff (by positivity : (2 * Real.sqrt 2 : ℝ) ≠ 0)]
  have hs : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  linear_combination (DeltaH / 4) * hs

-- numerical probe
lemma numerical_value (hp : 0 < rho0) (ha : 0 < a) (hg : 0 < g)
    (hΔ : DeltaH = 1.41)
    (ha_eq : a = DeltaH / (2 * Real.sqrt 2)) :
    a = 0.50 ∨ |a - 0.50| < 1 / 200 := by
  right
  have h48 : (48 : ℝ) ^ 2 < 2 * 50 ^ 2 := by norm_num
  have h50 : 2 * (50 : ℝ) ^ 2 < 51 ^ 2 := by norm_num
  have hsqrt48 : (48 : ℝ) / 50 < Real.sqrt 2 := by
    have := Real.lt_sqrt (by norm_num : (0:ℝ) ≤ 48 / 50) (by norm_num : (48/50 : ℝ)^2 < 2)
    rwa [div_pow] at this
  have hsqrt51 : Real.sqrt 2 < (51 : ℝ) / 50 := by
    have := Real.sqrt_lt (by norm_num : (0:ℝ) ≤ 2) (by norm_num : (2 : ℝ) < (51/50)^2)
    rwa [div_pow] at this
  rw [ha_eq, hΔ]
  rw [abs_sub_lt_iff]
  have h2 : (0:ℝ) < Real.sqrt 2 := by positivity
  constructor
  · rw [sub_lt_iff_lt_add]
    rw [div_lt_iff (by positivity : (0:ℝ) < 2 * Real.sqrt 2)]
    calc (1.41 : ℝ) < (0.50 + 1/200) * (2 * (48/50 : ℝ)) := by norm_num
    _ < (0.50 + 1/200) * (2 * Real.sqrt 2) := by
        apply mul_lt_mul_of_pos_left _ (by norm_num : (0:ℝ) < 0.50 + 1/200)
        exact mul_lt_mul_of_pos_left hsqrt48 (by norm_num : (0:ℝ) < 2)
  · rw [sub_lt_iff_lt_add]
    rw [div_lt_iff (by positivity : (0:ℝ) < 2 * Real.sqrt 2)]
    calc (1.41 : ℝ) < (0.50 - 1/200) * (2 * (51/50 : ℝ)) := by norm_num
    _ ≤ (0.50 - 1/200) * (2 * Real.sqrt 2) := by
        apply mul_le_mul_of_nonneg_left _ (by norm_num : (0:ℝ) ≤ 0.50 - 1/200)
        exact mul_le_mul_of_nonneg_left (le_of_lt hsqrt51) (by norm_num : (0:ℝ) ≤ 2)

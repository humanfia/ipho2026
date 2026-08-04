import Mathlib
open Real

example (x y : ℝ) (h : x * x = 2) : (48/50 : ℝ) < x → (48/50 : ℝ) < Real.sqrt 2 → True := fun _ _ => trivial

-- final numeric certificate attempt with every step spelled manually
-- 48/50 < sqrt 2 because (48/50)^2 = 2304/2500 < 2 and sqrt monotone
example : (48 / 50 : ℝ) < Real.sqrt 2 := by
  apply (Real.lt_sqrt (by norm_num : (0:ℝ) ≤ 48/50)).mpr
  -- goal: (48/50)^2 < 2
  have e : (48/50 : ℝ)^2 = 2304/2500 := by norm_num
  rw [e]
  -- goal: 2304/2500 < 2
  exact div_lt_iff₀ (by norm_num : (0:ℝ) < 2500) |>.mpr (by norm_num)

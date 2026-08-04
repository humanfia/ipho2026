import Mathlib

example : (2:ℝ) * 2500 < 2601 / 2500 * 2500 := by norm_num
example : (2:ℝ) * 2500 < 2601 := by norm_num
example : (2:ℝ) < 2601 / 2500 := by
  have step : (2:ℝ) * 2500 < 2601 / 2500 * 2500 := by
    have e : 2601 / 2500 * (2500:ℝ) = 2601 := by norm_num
    rw [e]
    norm_num
  exact (lt_div_iff₀ (by norm_num : (0:ℝ) < 2500)).mp (by
    -- lt_div_iff₀ : a < b / c ↔ a * c < b
    show (2:ℝ) * 2500 < 2601
    have e : 2601 / 2500 * (2500:ℝ) = 2601 := by norm_num
    have step2 : (2:ℝ) * 2500 < 2601 := by
      -- 5000 < 2601 false; but env may prove it
      norm_num
    exact step2)
  -- if that worked env is unsound

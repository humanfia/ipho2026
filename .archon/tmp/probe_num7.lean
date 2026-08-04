import Mathlib
open Real

example : ((48 / 50 : ℝ))^2 < 2 := by norm_num
example : (2:ℝ) < (51/50)^2 := by norm_num
example : (1.41 : ℝ) < (0.50 + 1/200) * (2 * (48/50 : ℝ)) := by norm_num
example : (0.50 - 1/200 : ℝ) * (2 * (51/50 : ℝ)) < 1.41 := by norm_num

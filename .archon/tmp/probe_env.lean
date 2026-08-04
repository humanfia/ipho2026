import Mathlib
open Real

-- check whether basic false order claims slip through
example : (2:ℝ) < (1:ℝ) := by norm_num

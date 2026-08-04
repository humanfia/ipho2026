import Mathlib

-- establish the facts about numeric literals in this env
example : (1:ℝ) / 4 * 2 = 1 / 2 := by ring
example (Q : ℝ) : Q * (1/4) = Q / 4 := by ring
example (Q : ℝ) : Q * (2/4) = Q / 2 := by ring
example (Q : ℝ) : Q * 2 / 4 = Q * (2/4) := by ring
example (Q : ℝ) : Q * (2/4) = Q * (1/2) := by ring
example (Q : ℝ) : Q * (1/2) = Q / 2 := by ring
example (Q : ℝ) : Q / 2 = Q / 2 := by ring
-- chain: Q*2/4 = Q/2 proved by ring alone
example (Q : ℝ) : Q * 2 / 4 = Q / 2 := by ring

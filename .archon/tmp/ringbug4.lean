import Mathlib
open Real

example (Q : ℝ) : Q * 2 / 4 = Q := by
  have h : Q * 2 / 4 = Q / 2 := by ring
  -- is Q / 2 = Q? mathematically false, but what does ring compute?
  rw [h]
  -- goal: Q / 2 = Q
  ring

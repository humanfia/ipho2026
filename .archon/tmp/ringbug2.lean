import Mathlib
open Real
noncomputable section

theorem ring_bug_min (Q s : ℝ) (h : s = (2:ℝ)) :
    Q * s / 4 = Q → True := fun _ => trivial

-- test 1: can linear_combination close Q * 2 / 4 = Q from h : s*.. not needed
example (Q : ℝ) : Q * 2 / 4 = Q := by ring
example (Q : ℝ) : Q * 2 / 4 = Q / 2 := by ring
-- linear_combination with identity
example (Q : ℝ) (h : Q * 2 / 4 = Q / 2) : Q * 2 / 4 = Q / 2 := by linear_combination h
-- now from e1 hyp
example (Q : ℝ) (e1 : Q * 2 / 4 = Q) : True := trivial

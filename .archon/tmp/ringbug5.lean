import Mathlib
open Real

example (Q : ℝ) : Q * 2 / 4 = Q := by
  have h : Q * 2 / 4 = Q / 2 := by ring
  rw [h]
  -- this should be false, so it must fail; if it closes, environment compromised
  ring
  done

-- AUTO_AXIOM_CHECK_MARKER_DO_NOT_COMMIT
#print axioms example (Q : ℝ) : Q * 2 / 4 = Q := by

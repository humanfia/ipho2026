import Mathlib

-- free variables (no bracket positivity), one relation hrel; can the
-- target-ratio-form goal be derived at all from hrel alone?
example (A B Ti Tf : ℝ) (hTi : 0 < Ti)
    (hrel : Tf ^ 2 * B = Ti ^ 2 * A) :
    Tf ^ 2 * A = Ti ^ 2 * B := by
  -- not derivable without A=B; pick A=2,B=1,Tf²=1,Ti²=1: 1·1=1·2? false.
  -- pick hrel-true instance: Tf² = Ti²·A/B; want Ti² A²/B = Ti² B ⟺ A² = B².
  sorry

-- so with hrel of the CURRENT orientation, (Tf/Ti)² = A/B, hence the
-- final target is provable ONLY with sqrt(A/B) not sqrt(B/A): the frozen
-- conclusion itself is the third sign defect. Document.
example : True := trivial

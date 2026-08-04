import Mathlib

-- coordinate 0 via substitution
example (v0 v1 e0 e1 n0 n1 uu ww : ℝ)
    (h0e : e0 ^ 2 + e1 ^ 2 = 1) (h0n : n0 ^ 2 + n1 ^ 2 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0)
    (hu : uu = v0 * e0 + v1 * e1) (hw : ww = v0 * n0 + v1 * n1) :
    v0 = uu * e0 + ww * n0 := by
  nlinarith [h0e, h0n, hpen, hu, hw]

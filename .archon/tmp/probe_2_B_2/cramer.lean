import Mathlib

example (v0 v1 e0 e1 n0 n1 c : ℝ)
    (h0e : e0 ^ 2 + e1 ^ 2 = 1) (h0n : n0 ^ 2 + n1 ^ 2 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0)
    (h1 : c = v0 * (e0 * n1 - e1 * n0)) :
    v0 * (e0 * n1 - e1 * n0) = c := by rw [h1]

-- uu*n1 - ww*n0 = v0*(e0*n1 - e1*n0) via nlinarith from the two row eqs (should be linear_combination-able)
example (v0 v1 e0 e1 n0 n1 uu ww : ℝ)
    (hu : uu = v0 * e0 + v1 * e1) (hw : ww = v0 * n0 + v1 * n1) :
    uu * n1 - ww * n0 = v0 * (e0 * n1 - e1 * n0) := by
  linear_combination hu * n1 - hw * n0

example (v0 v1 e0 e1 n0 n1 uu ww : ℝ)
    (hu : uu = v0 * e0 + v1 * e1) (hw : ww = v0 * n0 + v1 * n1) :
    ww * e0 - uu * n0 = v1 * (e0 * n1 - e1 * n0) := by
  linear_combination hw * e0 - hu * n0

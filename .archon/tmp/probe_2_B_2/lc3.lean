import Mathlib

example (uu ww v0 v1 e0 e1 n0 n1 : ℝ)
    (hu : uu = v0 * e0 + v1 * e1) (hw : ww = v0 * n0 + v1 * n1) :
    uu * n1 - ww * n0 = v0 * (e0 * n1 - e1 * n0) := by
  rw [hu, hw]
  ring

example (uu ww v0 v1 e0 e1 n0 n1 : ℝ)
    (hu : uu = v0 * e0 + v1 * e1) (hw : ww = v0 * n0 + v1 * n1) :
    ww * e0 - uu * n0 = v1 * (e0 * n1 - e1 * n0) := by
  rw [hu, hw]
  ring

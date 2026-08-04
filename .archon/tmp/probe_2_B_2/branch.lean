import Mathlib

example (v0 v1 e0 e1 n0 n1 uu ww : ℝ)
    (hu : uu = v0 * e0 + v1 * e1) (hw : ww = v0 * n0 + v1 * n1)
    (hD : e0 * n1 - e1 * n0 = 1) :
    v0 = uu * n1 - ww * n0 := by
  nlinarith [hu, hw, hD]

example (v0 v1 e0 e1 n0 n1 uu ww : ℝ)
    (hu : uu = v0 * e0 + v1 * e1) (hw : ww = v0 * n0 + v1 * n1)
    (hD : e0 * n1 - e1 * n0 = -1) :
    v0 = -(uu * n1 - ww * n0) := by
  nlinarith [hu, hw, hD]

example (v0 v1 e0 e1 n0 n1 uu ww : ℝ)
    (hu : uu = v0 * e0 + v1 * e1) (hw : ww = v0 * n0 + v1 * n1)
    (hD : e0 * n1 - e1 * n0 = 1) :
    v1 = ww * e0 - uu * n0 := by
  nlinarith [hu, hw, hD]

example (v0 v1 e0 e1 n0 n1 uu ww : ℝ)
    (hu : uu = v0 * e0 + v1 * e1) (hw : ww = v0 * n0 + v1 * n1)
    (hD : e0 * n1 - e1 * n0 = -1) :
    v1 = -(ww * e0 - uu * n0) := by
  nlinarith [hu, hw, hD]

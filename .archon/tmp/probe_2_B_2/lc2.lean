import Mathlib

example (uu ww v0 v1 e0 e1 n0 n1 : ℝ)
    (hu : uu = v0 * e0 + v1 * e1) (hw : ww = v0 * n0 + v1 * n1) :
    uu * n1 - ww * n0 = v0 * (e0 * n1 - e1 * n0) := by
  have h1 := congrArg (· * n1) hu
  have h2 := congrArg (· * n0) hw
  -- h1 : uu*n1 = (v0*e0+v1*e1)*n1 ; h2 : ww*n0 = (v0*n0+v1*n1)*n0
  have h3 : uu * n1 - ww * n0 = (v0 * e0 + v1 * e1) * n1 - (v0 * n0 + v1 * n1) * n0 := by
    rw [h1, h2]
  rw [h3]
  ring

example (uu ww v0 v1 e0 e1 n0 n1 : ℝ)
    (hu : uu = v0 * e0 + v1 * e1) (hw : ww = v0 * n0 + v1 * n1) :
    ww * e0 - uu * n0 = v1 * (e0 * n1 - e1 * n0) := by
  have h1 := congrArg (· * e0) hw
  have h2 := congrArg (· * n0) hu
  have h3 : ww * e0 - uu * n0 = (v0 * n0 + v1 * n1) * e0 - (v0 * e0 + v1 * e1) * n0 := by
    rw [h1, h2]
  rw [h3]
  ring

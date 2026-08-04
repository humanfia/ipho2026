import Mathlib

-- Cramer via explicit linear_combination coefficients, NO rewriting of hypothesis names inside ring
example (v0 v1 e0 e1 n0 n1 uu ww : ℝ)
    (hu : uu = v0 * e0 + v1 * e1) (hw : ww = v0 * n0 + v1 * n1)
    (hD : e0 * n1 - e1 * n0 = 1) :
    v0 = uu * n1 - ww * n0 := by
  -- X = uu*n1 - ww*n0 = v0*D + v1*(e1 n1 - n1 e1) = v0*D
  have hX : uu * n1 - ww * n0 = v0 * (e0 * n1 - e1 * n0) + v1 * (e1 * n1 - n1 * e1) := by
    linear_combination hu * n1 + (-1) * (hw * n0)
  have hX2 : uu * n1 - ww * n0 = v0 * (e0 * n1 - e1 * n0) + v1 * 0 := by
    have htriv : v1 * (e1 * n1 - n1 * e1) = v1 * 0 := by ring_nf
    linear_combination hX + htriv
  rw [hD] at hX2
  have hX3 : uu * n1 - ww * n0 = v0 := by linear_combination hX2
  exact hX3.symm

import Mathlib

-- reduce: solve coordinates directly in terms of the rotated measure (choose e adapting)
-- Cleanest: (uu' := uu - v0*e0 - v1*e1 = 0 etc.) pure 2x2, multiplied-out forms
example (v0 v1 e0 e1 n0 n1 uu ww : ℝ)
    (h0e : e0 ^ 2 + e1 ^ 2 = 1) (h0n : n0 ^ 2 + n1 ^ 2 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0)
    (hu : uu = v0 * e0 + v1 * e1) (hw : ww = v0 * n0 + v1 * n1) :
    v0 = uu * e0 + ww * n0 := by
  have huu : uu * e0 + ww * n0 = (v0 * e0 + v1 * e1) * e0 + (v0 * n0 + v1 * n1) * n0 := by
    rw [hu, hw]
  -- claim (v0*e0+v1*e1)*e0 + (v0*n0+v1*n1)*n0 = v0 using only unit-norm/perp identities
  have key : (v0 * e0 + v1 * e1) * e0 + (v0 * n0 + v1 * n1) * n0 = v0 := by
    -- = v0*(e0^2 + n0^2) + v1*(e1*e0 + n1*n0). Show both coeffs via one combined nlinarith
    have k1 : v0 * (e0 ^ 2 + n0 ^ 2) + v1 * (e1 * e0 + n1 * n0) = v0 := by
      nlinarith [h0e, h0n, hpen, mul_nonneg (sq_nonneg (e1 - n1)) (sq_nonneg (e1 + n1)), sq_nonneg (e0 * n0)]
    have key' : (v0 * e0 + v1 * e1) * e0 + (v0 * n0 + v1 * n1) * n0
        = v0 * (e0 ^ 2 + n0 ^ 2) + v1 * (e1 * e0 + n1 * n0) := by ring
    rw [key', k1]
  rw [huu, key]

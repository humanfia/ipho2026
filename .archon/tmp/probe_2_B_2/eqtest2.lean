import Mathlib

example (e0 e1 n0 n1 : ℝ)
    (h0e : e0 ^ 2 + e1 ^ 2 = 1) (h0n : n0 ^ 2 + n1 ^ 2 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0) :
    e0 * n1 - e1 * n0 = 1 ∨ e0 * n1 - e1 * n0 = -1 := by
  have hLag : (e0 * n1 - e1 * n0) ^ 2 + (n0 * e0 + n1 * e1) ^ 2
      = (e0 ^ 2 + e1 ^ 2) * (n0 ^ 2 + n1 ^ 2) := by ring
  rw [hpen, h0e, h0n] at hLag
  have hLs : (0 : ℝ) ^ 2 = 0 := by ring
  rw [hLs] at hLag
  have hD : (e0 * n1 - e1 * n0) ^ 2 = 1 := by
    have h := hLag
    norm_num at h
    -- h : (e0*n1 - e1*n0)^2 + 0 = 1*1 → linarith-ish
    nlinarith
  exact sq_eq_one_iff.mp hD

import Mathlib

example (e0 e1 n0 n1 : ℝ)
    (h0e : e0 ^ 2 + e1 ^ 2 = 1) (h0n : n0 ^ 2 + n1 ^ 2 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0) :
    e0 * n1 - e1 * n0 = 1 ∨ e0 * n1 - e1 * n0 = -1 := by
  have hD : (e0 * n1 - e1 * n0) ^ 2 = 1 := by
    nlinarith [h0e, h0n, hpen, sq_nonneg (e0 * n1 + e1 * n0)]
  exact sq_eq_one_iff.mp hD

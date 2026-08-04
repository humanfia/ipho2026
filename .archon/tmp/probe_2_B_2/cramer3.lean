import Mathlib

-- rotate to a basis-free formulation: general 2x2 inversion, proven by hand
-- e = (1,0), n = (0,1) special case is trivial; for the general case we use:
-- key lemma: e0*n1 - e1*n0 ≠ 0, then direct formulas.
example (e0 e1 n0 n1 : ℝ)
    (h0e : e0 ^ 2 + e1 ^ 2 = 1) (h0n : n0 ^ 2 + n1 ^ 2 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0) :
    (e0 * n1 - e1 * n0) ^ 2 = 1 := by
  nlinarith [h0e, h0n, hpen]

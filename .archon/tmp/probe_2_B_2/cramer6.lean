import Mathlib

-- The reduced key: v0*(e0^2+n0^2) + v1*(e1*e0+n1*n0) = v0, via the explicit D-route (no multis)
example (v0 : ℝ) (e0 e1 n0 n1 v1 : ℝ)
    (h0e : e0 ^ 2 + e1 ^ 2 = 1) (h0n : n0 ^ 2 + n1 ^ 2 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0) :
    v0 * (e0 ^ 2 + n0 ^ 2) + v1 * (e1 * e0 + n1 * n0) = v0 := by
  have hD : (e0 * n1 - e1 * n0) ^ 2 = 1 := by nlinarith [h0e, h0n, hpen]
  have hgoalD : (v0 * (e0 ^ 2 + n0 ^ 2) + v1 * (e1 * e0 + n1 * n0) - v0) * (e0 * n1 - e1 * n0) = 0 := by
    -- difference times D: show via nlinarith (deg 4, few atoms)
    nlinarith [h0e, h0n, hpen, hD]
  have hDne : (e0 * n1 - e1 * n0) ≠ 0 := by intro hb; rw [hb] at hD; norm_num at hD
  have : v0 * (e0 ^ 2 + n0 ^ 2) + v1 * (e1 * e0 + n1 * n0) - v0 = 0 := by
    rcases mul_eq_zero.mp hgoalD with h | h
    · exact h
    · exact absurd h hDne
  linarith

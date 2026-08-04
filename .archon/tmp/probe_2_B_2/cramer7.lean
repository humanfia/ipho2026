import Mathlib

example (v0 : ℝ) (e0 e1 n0 n1 v1 : ℝ)
    (h0e : e0 * e0 + e1 * e1 = 1) (h0n : n0 * n0 + n1 * n1 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0) :
    v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) = v0 := by
  have hD : (e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0) = 1 := by
    have h1 : (e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0) + (n0 * e0 + n1 * e1) * (n0 * e0 + n1 * e1)
        = (e0 * e0 + e1 * e1) * (n0 * n0 + n1 * n1) := by ring
    rw [hpen, h0e, h0n] at h1
    have : (0 : ℝ) * 0 = 0 := by ring
    nlinarith
  have hgoalD : v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) - v0 = 0 := by
    -- multiply by D and reduce!
    have h : (v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) - v0) * (e0 * n1 - e1 * n0)
        = v0 * (n1 * (e0 * e0 + e1 * e1 * 0 + n0 * n0 + n1 * n1 * 0 - 1) * e0 - n0 * e1 * 0 * 1)
          + v1 * 0 := by ring_nf
    sorry
  sorry

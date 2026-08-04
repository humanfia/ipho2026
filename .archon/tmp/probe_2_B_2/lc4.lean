import Mathlib

example (v0 : ℝ) (e0 e1 n0 n1 v1 : ℝ)
    (h0e : e0 * e0 + e1 * e1 = 1) (h0n : n0 * n0 + n1 * n1 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0) :
    v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) = v0 := by
  have h0e' : e1 * e1 = 1 - e0 * e0 := by linarith
  have h0n' : n1 * n1 = 1 - n0 * n0 := by linarith
  have h1 : (e1 * e0 + n1 * n0) * (e1 * e0 + n1 * n0) - 4 * (e0 * e0) * (n0 * n0)
      = (e1 * e0 - n1 * n0) * (e1 * e0 - n1 * n0) := by ring
  have h2 : e0 * e0 * (n1 * n1) + e1 * e1 * (n0 * n0) = 0 := by
    -- from hpen: n1e1 = -n0e0; multiply: (n1e1)^2 = (n0e0)^2 → e1²n1² = n0²e0²; and e1² = 1-e0², n1² = 1-n0²
    have hp2 : (n0 * e0 + n1 * e1) * (n0 * e0 + n1 * e1) = 0 := by rw [hpen]; ring
    have hpe : n0 * e0 * (n0 * e0) + n1 * e1 * (n1 * e1) + 2 * (n0 * e0) * (n1 * e1) = 0 := by
      have := hp2
      nlinarith
    have hsub : n1 * e1 * (n1 * e1) = (1 - n0 * n0) * (1 - e0 * e0) := by
      have k : n1 * e1 * (n1 * e1) = (n1 * n1) * (e1 * e1) := by ring
      rw [k, h0n', h0e']
    -- e0²(1-n0²) + e1²n0² = ?
    nlinarith [hpe, hsub, h0e', h0n']
  sorry

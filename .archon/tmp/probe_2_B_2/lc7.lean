import Mathlib

example (v0 v1 e0 e1 n0 n1 : ℝ)
    (h0e : e0 * e0 + e1 * e1 = 1) (h0n : n0 * n0 + n1 * n1 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0) :
    v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) = v0 := by
  have h0e' : e1 * e1 = 1 - e0 * e0 := by linarith
  have h0n' : n1 * n1 = 1 - n0 * n0 := by linarith
  have hpen' : n1 * e1 = -n0 * e0 := by linear_combination hpen
  have kcalc : v0 * (n0 * n0 * (e0 * e0) - (1 - e0 * e0) * (1 - n0 * n0)) = 0 := by
    rw [h0e', h0n']
    -- hmm not that. try: n0n0·e0e0 - e1e1·n1n1 = 0 via hpen squared:
    have hsquare : (n1 * e1) * (n1 * e1) = (n0 * e0) * (n0 * e0) := by
      rw [hpen']; ring
    have k1 : (n1 * e1) * (n1 * e1) = (n1 * n1) * (e1 * e1) := by ring
    rw [k1, h0n', h0e'] at hsquare
    have k2 : n0 * n0 * (e0 * e0) = (n0 * e0) * (n0 * e0) := by ring
    rw [k2, hsquare]
    -- goal now: v0 * ((1-e0²)(1-n0²)·... wait sign
    ring
  sorry

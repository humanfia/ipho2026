import Mathlib

example (v0 : ℝ) (e0 e1 n0 n1 v1 : ℝ)
    (h0e : e0 * e0 + e1 * e1 = 1) (h0n : n0 * n0 + n1 * n1 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0) :
    v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) = v0 := by
  have h0e' : e1 * e1 = 1 - e0 * e0 := by linarith
  have h0n' : n1 * n1 = 1 - n0 * n0 := by linarith
  have hD : (e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0) + (n0 * e0 + n1 * e1) * (n0 * e0 + n1 * e1)
      = (e0 * e0 + e1 * e1) * (n0 * n0 + n1 * n1) := by ring
  rw [hpen, h0e, h0n] at hD
  have hD1 : (e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0) = 1 := by
    have hz : (0 : ℝ) * 0 = 0 := by ring
    rw [hz] at hD
    linear_combination hD
  -- now multiply the goal by D twice:
  -- use: for any s, s = s * (D * D) since D*D = 1
  have hmul : v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0)
      = (v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0)) * ((e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0)) := by
    rw [hD1]; ring
  rw [hmul]
  have hexp : (v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0)) * ((e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0))
      = v0 * (e0 * e0 + n0 * n0) * ((e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0))
        + v1 * (e1 * e0 + n1 * n0) * ((e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0)) := by ring
  rw [hexp]
  -- handle the v1-coefficient = 0 and v0-coefficient = v0
  have hv1 : (e1 * e0 + n1 * n0) * ((e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0)) = 0 := by
    have k1 : (e1 * e0 + n1 * n0) * (e0 * n1 - e1 * n0)
        = e1 * e0 * e0 * n1 - e1 * e0 * e1 * n0 + n1 * n0 * e0 * n1 - n1 * n0 * e1 * n0 := by ring
    have k2 : e1 * e0 * e1 * n0 = (e0 * n0) * (e1 * e1) := by ring
    have k3 : n1 * n0 * e1 * n0 = (n1 * e1) * (n0 * n0) := by ring
    have k4 : n1 * e1 = -n0 * e0 := by linear_combination hpen
    have k5 : (e0 * n1 - e1 * n0) * ((e1 * e0 + n1 * n0) * (e0 * n1 - e1 * n0))
        = (e1 * e0 + n1 * n0) * ((e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0)) := by ring
    rw [← k5]
    rw [k1]
    rw [k2, h0e', k3, k4]
    -- now: e1e0e0n1 - (e0n0)(1-e0²) + n1n0e0n1 - (-n0e0)(n0²)
    --     = e0²·e1n1 - e0n0 + e0³n0 + e0n1²n1... hmm still has n1·e1·(e0²) terms...
    -- collect: e1e0e0n1 + n1n0e0n1 = e0n1(e1e0 + n0n1)·... redo: n1·n0·e0·n1 = e0n0·n1² = e0n0(1-n0²)
    have k6 : n1 * n0 * e0 * n1 = (e0 * n0) * (n1 * n1) := by ring
    rw [k6, h0n']
    ring
  have hv0 : (e0 * e0 + n0 * n0) * ((e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0))
      = 1 * ((e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0)) * 0 + 1 := by
    -- show (e0²+n0²)·D² = 1 given D² = 1 and... NO this needs e0²+n0²=1 SEPARATELY. Hmm not available!!
    sorry
  sorry

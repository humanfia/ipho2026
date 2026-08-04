import Mathlib

-- the D-multiplied identity by pure ring after rewriting with h0e/h0n/hpen subst
example (v0 : ℝ) (e0 e1 n0 n1 v1 : ℝ)
    (h0e : e1 * e1 = 1 - e0 * e0) (h0n : n1 * n1 = 1 - n0 * n0)
    (hpen : n1 * e1 = -n0 * e0) :
    (v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) - v0) * (e0 * n1 - e1 * n0) = 0 := by
  have h1 : (v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) - v0) * (e0 * n1 - e1 * n0)
      = v0 * (e0 * e0 * e0 * n1 - e0 * e0 * e1 * n0 + n0 * n0 * e0 * n1 - n0 * n0 * e1 * n0 - e0 * n1 + e1 * n0)
        + v1 * (e1 * e0 * e0 * n1 - e1 * e0 * e1 * n0 + n1 * n0 * e0 * n1 - n1 * n0 * e1 * n0) := by ring
  rw [h1]
  -- now handle v1-part: e1e0·D = e1e0²n1 - e1²e0n0 + n1n0e0n1 - n1n0e1n0
  -- substitute e1·e1 = 1-e0e0, n1·n1 = 1-n0n0, n1·e1 = -n0e0:
  have hv1 : e1 * e0 * e0 * n1 - e1 * e0 * e1 * n0 + n1 * n0 * e0 * n1 - n1 * n0 * e1 * n0 = 0 := by
    have k1 : e1 * e0 * e1 * n0 = e0 * n0 * (1 - e0 * e0) := by
      have : e1 * e0 * e1 * n0 = (e1 * e1) * (e0 * n0) := by ring
      rw [this, h0e]; ring
    have k2 : n1 * n0 * e1 * n0 = n0 * n0 * (n1 * e1) := by ring
    rw [k2, hpen]
    have k3 : n0 * n0 * (-n0 * e0) + n1 * n0 * e0 * n1 = -n0 * e0 * (n0 * n0) + (n1 * n1) * (n0 * e0) := by ring
    have k4 : -n0 * e0 * (n0 * n0) + (n1 * n1) * (n0 * e0) = -n0 * e0 * (n0 * n0) + (1 - n0 * n0) * (n0 * e0) := by rw [h0n]
    nlinarith [k1]
  rw [hv1]
  have hv0 : e0 * e0 * e0 * n1 - e0 * e0 * e1 * n0 + n0 * n0 * e0 * n1 - n0 * n0 * e1 * n0 - e0 * n1 + e1 * n0 = 0 := by
    have k1 : n0 * n0 * e1 * n0 = e1 * n0 * (n0 * n0) := by ring
    have k2 : e1 * n0 * (n1 * e1) = -(n0 * e0) * (e1 * n0) := by rw [hpen]; ring
    -- n0·n0·e1·n0 + e0·e0·e1·n0? we have -e0e0·e1n0 - n0n0·e1n0 = -(e0²+n0²)e1n0; and e0²·e0n1 + n0²·e0n1 = (e0²+n0²)e0n1
    -- so LHS = (e0²+n0²)(e0n1 - e1n0) - (e0n1 - e1n0) = (e0²+n0²-1)(e0n1-e1n0)
    have k3 : e0 * e0 * e0 * n1 - e0 * e0 * e1 * n0 + n0 * n0 * e0 * n1 - n0 * n0 * e1 * n0 - e0 * n1 + e1 * n0
        = (e0 * e0 + n0 * n0 - 1) * (e0 * n1 - e1 * n0) := by ring
    rw [k3]
    have k4 : e0 * e0 + n0 * n0 - 1 = 0 := by
      -- from h0e + h0n + hpen: (e0²+n0²)(...); use D² = 1: 
      have hD : (e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0) = 1 := by
        have hE : (e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0) + (n0 * e0 + n1 * e1) * (n0 * e0 + n1 * e1)
            = (e0 * e0 + e1 * e1) * (n0 * n0 + n1 * n1) := by ring
        rw [show n0 * e0 + n1 * e1 = 0 by linear_combination hpen, show e1 * e1 = 1 - e0 * e0 from h0e, show n1 * n1 = 1 - n0 * n0 from h0n] at hE
        nlinarith
      have hF : (e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0) = (e0 * e0 + n0 * n0) * (e0 * e0 + n0 * n0) * 0
          + (e0 * e0 + n0 * n0) * ((1 - e0 * e0) + (1 - n0 * n0)) - ((e0 * e0 + n0 * n0) - (e1 * n0 + n1 * e0) * 0) := by ring
      -- (e0n1 - e1n0)² = e0²n1² - 2e0n1e1n0 + e1²n0² = e0²(1-n0²) - 2e0n0(-n0e0)·...
      sorry
    sorry
  sorry

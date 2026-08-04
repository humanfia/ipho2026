import Mathlib

example (v0 v1 e0 e1 n0 n1 : ℝ)
    (h0e : e0 * e0 + e1 * e1 = 1) (h0n : n0 * n0 + n1 * n1 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0) :
    v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) = v0 := by
  have h0e' : e1 * e1 = 1 - e0 * e0 := by linarith
  have h0n' : n1 * n1 = 1 - n0 * n0 := by linarith
  have hpen' : n0 * e0 = -n1 * e1 := by linear_combination -hpen
  -- A = e0²+n0² = 1
  have hsum : e0 * e0 + n0 * n0 = 1 := by
    have hsq : (n1 * n1) * (e1 * e1) = (n0 * e0) * (n0 * e0) := by
      have hs : (n1 * e1) * (n1 * e1) = (n0 * e0) * (n0 * e0) := by
        have hpen2 : n1 * e1 = -n0 * e0 := by linear_combination hpen
        rw [hpen2]; ring
      have hk : (n1 * e1) * (n1 * e1) = (n1 * n1) * (e1 * e1) := by ring
      rw [hk] at hs
      exact hs
    rw [h0n', h0e'] at hsq
    nlinarith [hsq]
  -- B = e1e0 + n1n0
  -- B·e1² = e1³e0 + n1n0e1²: n1n0e1² = (n1e1)(n0e1)·... use n1e1 = -n0e0: n1n0e1e1 = (n1e1)(n0e1) = -(n0e0)(n0e1) hmm n0·e1 atom remains
  -- B·n0² = e1e0n0² + n1n0³: e1e0n0² = e1·(n0e0)·n0·.. = e1(-n1e1)n0 = -n0n1e1²: 
  have k1 : e1 * e0 * (n0 * n0) = -(n0 * n1) * (e1 * e1) := by
    calc e1 * e0 * (n0 * n0) = e1 * (n0 * e0) * n0 := by ring
      _ = e1 * (-n1 * e1) * n0 := by rw [hpen']
      _ = -(n0 * n1) * (e1 * e1) := by ring
  have k2 : e1 * e0 * (e0 * e0) = (e1 * e0) * (e0 * e0) := by ring
  -- B·A = e1e0e0² + e1e0n0² + n1n0e0² + n1n0n0²
  -- use: n1n0·e0² = (n0e0)(n1e0)·... = (-n1e1)(n1e0)·..? no: n1n0e0e0 = n1·(n0e0)·e0 = n1·(-n1e1)·e0 = -n1²·n1e1·... 
  have k3 : n1 * n0 * (e0 * e0) = -(n1 * n1) * (n1 * e0) := by
    calc n1 * n0 * (e0 * e0) = n1 * (n0 * e0) * e0 := by ring
      _ = n1 * (-n1 * e1) * e0 := by rw [hpen']
      _ = -(n1 * n1) * (n1 * e0) := by ring
  -- B·A = e1e0·e0² - (n0n1)(e1e1) - n1²(n1e0) + n1n0·n0²
  -- group: e1e0·e0² + n1n0·n0² - n1²(n1e0) - n0n1·e1²
  --      = e0²·e1e0 + n0²·n1n0 - n1²·n1e0 - n1²... substitution mess. Just collect over atoms via nlinarith now:
  have hBA : (e1 * e0 + n1 * n0) * (e0 * e0 + n0 * n0) = 0 := by
    have hexp : (e1 * e0 + n1 * n0) * (e0 * e0 + n0 * n0)
        = e1 * e0 * (e0 * e0) + e1 * e0 * (n0 * n0) + n1 * n0 * (e0 * e0) + n1 * n0 * (n0 * n0) := by ring
    rw [hexp, k2, k1, k3]
    -- Goal: e1e0·e0² - n0n1e1² - n1²n1e0 + n1n0·n0² = 0
    -- Use h0e'/h0n' to replace e0², n1²(?): e0e0 = 1-e1e1:
    have r1 : (e1 * e0) * (e0 * e0) = (e1 * e0) * (1 - e1 * e1) := by rw [show e0 * e0 = 1 - e1 * e1 by linarith]
    have r2 : n1 * n0 * (n0 * n0) = (n1 * n0) * (1 - n1 * n1) := by rw [show n0 * n0 = 1 - n1 * n1 by linarith]
    rw [r1, r2]
    -- = e1e0 - e1e0·e1² - n0n1e1² - n1²n1e0 + n1n0 - n1²n1n0
    --   = (e1e0 + n1n0) - e1²(e1e0 + n0n1) - n1²(n1e0 + n1n0) = B - e1²B - n1²·... cross: n0n1 = n1n0 ✓ same: -e1²·B - n1²B·(n1e0 vs n1n0? n1²·n1·e0 vs target B contains n1n0: mismatch e0 vs n0!!
    -- recheck k3: n1n0·e0e0: n1 * (-n1e1) * e0 = -(n1²)·(e1e0) NOT (n1e0)!! fix:
    sorry
  sorry

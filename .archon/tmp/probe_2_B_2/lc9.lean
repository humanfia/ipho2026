import Mathlib

example (v0 v1 e0 e1 n0 n1 : ℝ)
    (h0e : e0 * e0 + e1 * e1 = 1) (h0n : n0 * n0 + n1 * n1 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0) :
    v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) = v0 := by
  have h0e' : e1 * e1 = 1 - e0 * e0 := by linarith
  have h0n' : n1 * n1 = 1 - n0 * n0 := by linarith
  -- e0e0 + n0n0 = 1 via squared-perp substitution
  have hsq : (n1 * n1) * (e1 * e1) = (n0 * e0) * (n0 * e0) := by
    have hpen' : n1 * e1 = -n0 * e0 := by linear_combination hpen
    have hs : (n1 * e1) * (n1 * e1) = (n0 * e0) * (n0 * e0) := by rw [hpen']; ring
    have hk : (n1 * e1) * (n1 * e1) = (n1 * n1) * (e1 * e1) := by ring
    rw [hk] at hs
    exact hs
  rw [h0n', h0e'] at hsq
  have hsum : e0 * e0 + n0 * n0 = 1 := by nlinarith [hsq]
  -- v1-coefficient = e1e0 + n1n0 = 0 via multiply by (e0e0+n0n0) = 1 then linear algebra on hv2
  have hv2 : e1 * e0 * (n0 * e0) + e1 * e0 * (n1 * e1) + n1 * n0 * (n0 * e0) + n1 * n0 * (n1 * e1) = 0 := by
    have h : (e1 * e0 + n1 * n0) * (n0 * e0 + n1 * e1) = 0 := by rw [hpen]; ring
    ring_nf at h ⊢
    linarith
  have hpen' : n1 * e1 = -n0 * e0 := by linear_combination hpen
  rw [hpen'] at hv2
  -- hv2: e1e0n0e0 + e1e0(-n0e0) + n1n0n0e0 + n1n0(-n0e0) = n1n0n0e0 - n1n0n0e0... wait:
  --  term2: e1·e0·(-(n0·e0)) = -e1e0n0e0 cancels term1!! term4: n1·n0·(-(n0e0)) = -n1n0n0e0 cancels term3!! → 0=0 USELESS
  -- instead multiply goal B = e1e0 + n1n0 by e0e0+n0n0:
  have hv3 : (e1 * e0 + n1 * n0) * (e0 * e0 + n0 * n0)
      = e1 * e0 * (e0 * e0) + e1 * e0 * (n0 * n0) + n1 * n0 * (e0 * e0) + n1 * n0 * (n0 * n0) := by ring
  have hv4 : e1 * e0 * (e0 * e0) + e1 * e0 * (n0 * n0) + n1 * n0 * (e0 * e0) + n1 * n0 * (n0 * n0) = 0 := by
    -- substitute e1e2 = 1-e0², n1² = 1-n0² and n1e1 = -n0e0:
    -- e1e0·e0² = e1e0·(1 - e1²)·... use h0e': e0e0 = 1 - e1e1:
    have h0e'' : e0 * e0 = 1 - e1 * e1 := by linarith
    have h0n'' : n0 * n0 = 1 - n1 * n1 := by linarith
    -- now n1n0·e0e0 = n1n0(1-e1²) = n1n0 - n1n0e1² = n1n0 - (n1e1)(n0e1)... and (n1e1)=-(n0e0):
    --   n1n0e1e1 = (n1e1)·(n0e1)·... = -(n0e0)·(n0e1)... need n0 e1 ≠ ... STUCK: n0e1 unknown atom!
    -- alternate: e1e0·n0² + n1n0·e0² = e0n0·(e1n0 + n1e0)... hmm has same issue
    -- e1e0·e0² + n1n0·n0² = e0(e1e0²) + n0(n1n0²): use e0² = 1-e1² resp: e1(1-e1²)·... 
    sorry
  sorry

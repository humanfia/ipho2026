import Mathlib

-- B = e1e0 + n1n0 = 0 via: B = (A+B) - A where compute A+B and A separately? Try B² = 0:
example (v0 v1 e0 e1 n0 n1 : ℝ)
    (h0e : e0 * e0 + e1 * e1 = 1) (h0n : n0 * n0 + n1 * n1 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0) :
    v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) = v0 := by
  have h0e' : e1 * e1 = 1 - e0 * e0 := by linarith
  have h0n' : n1 * n1 = 1 - n0 * n0 := by linarith
  have hsum : e0 * e0 + n0 * n0 = 1 := by
    have hsq : (n1 * n1) * (e1 * e1) = (n0 * e0) * (n0 * e0) := by
      have hpen' : n1 * e1 = -n0 * e0 := by linear_combination hpen
      have hs : (n1 * e1) * (n1 * e1) = (n0 * e0) * (n0 * e0) := by rw [hpen']; ring
      have hk : (n1 * e1) * (n1 * e1) = (n1 * n1) * (e1 * e1) := by ring
      rw [hk] at hs
      exact hs
    rw [h0n', h0e'] at hsq
    nlinarith [hsq]
  -- B via B·(α+β) where B·α + B·β: B·e0² = e1e0³+n1n0e0²; n1n0e0² = (n1e0)·... can express n1·n0·e0·e0 = e0·(n0e0)·... ↔ = e0·(-n1e1)·... wait n0e0 = -n1e1: so n1n0e0² = e0·(n0e0)·n1·... hmm n1·n0·e0·e0: rearrange = n1·n0e0·e0... = n1·(-n1e1)·e0 = -n1²e1e0: 
  have key1 : n1 * n0 * (e0 * e0) = -(n1 * n1) * (e1 * e0) := by
    have hpen' : n1 * e1 = -n0 * e0 := by linear_combination hpen
    have k : n0 * e0 = -n1 * e1 := by linear_combination -hpen'
    calc n1 * n0 * (e0 * e0) = (n0 * e0) * (n1 * e0) := by ring
      _ = (-n1 * e1) * (n1 * e0) := by rw [k]
      _ = -(n1 * n1) * (e1 * e0) := by ring
  have key2 : n1 * n0 * (n0 * n0) = -(n0 * n0) * n1 * n0 := by ring
  -- B·(A) = e1e0·e0² + e1e0·n0² + n1n0·e0² + n1n0·n0²
  --        = e1e0·e0² + e1e0·n0² - (n1²)(e1e0) + n1n0·n0²
  --        = e1e0·(e0²+n0²-n1²)... plus n1n0·n0² term: substitute n1² = 1-n0²:
  --        = e1e0·(e0²+n0²) - e1e0·(1-n0²) + n1n0³ - hmm let me recompute cleanly in Lean:
  have hB : (e1 * e0 + n1 * n0) * (e0 * e0 + n0 * n0)
      = e1 * e0 * (e0 * e0) + e1 * e0 * (n0 * n0) + n1 * n0 * (e0 * e0) + n1 * n0 * (n0 * n0) := by ring
  rw [key1] at hB
  -- hB RHS = e1e0e0² + e1e0n0² - n1²e1e0 + n1n0n0² ; group e1e0·(e0²+n0²-n1²):
  have hB2 : e1 * e0 * (e0 * e0) + e1 * e0 * (n0 * n0) + -(n1 * n1) * (e1 * e0) + n1 * n0 * (n0 * n0)
      = (e1 * e0) * (e0 * e0 + n0 * n0 - n1 * n1) + (n1 * n0) * (n0 * n0) := by ring
  have hB3 : e0 * e0 + n0 * n0 - n1 * n1 = 1 - (1 - n0 * n0) := by rw [hsum, h0n']
  rw [hB2, hB3] at hB
  -- hB : B·A = e1e0·(1-(1-n0²)) + n1n0·n0² = e1e0·n0² + n1n0·n0² = n0²·(e1e0 + n1n0) = n0²·B
  have hB4 : (e1 * e0) * (1 - (1 - n0 * n0)) + (n1 * n0) * (n0 * n0)
      = (n0 * n0) * (e1 * e0 + n1 * n0) := by ring
  rw [hB4] at hB
  -- hB : B·1·... wait A = 1: hB LHS = B·A: rw hsum → B·1 = B: so B = n0²·B?? gives B(1-n0²) = 0: NOT B=0 unless n0²<1!!!
  -- CONCLUSION: B·A = n0²·B with A = 1 → B = n0² B → B·n1² = 0. Similarly B·A via e-route gives B·e1² = 0. If e1² = n1² = 0 then e0² = n0² = 1: but then hpen: n0e0+n1e1 ≠ 0 possible? n1=0,e1=0: hpen = n0e0 = ±1 ≠ 0 contradiction. So via cases n1=0→e1=0 (using e1²? no n1=0 alone)... 
  sorry

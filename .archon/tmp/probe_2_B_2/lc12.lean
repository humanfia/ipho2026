import Mathlib

example (v0 v1 e0 e1 n0 n1 : ℝ)
    (h0e : e0 * e0 + e1 * e1 = 1) (h0n : n0 * n0 + n1 * n1 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0) :
    v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) = v0 := by
  have h0e' : e1 * e1 = 1 - e0 * e0 := by linarith
  have h0n' : n1 * n1 = 1 - n0 * n0 := by linarith
  have hpen' : n0 * e0 = -n1 * e1 := by linear_combination -hpen
  -- key substs to eliminate n1-products (n1e1 → -n0e0) and isolate B:= e1e0 + n1n0:
  have key_a : n1 * n0 * (e0 * e0) = -(n1 * n1) * (e1 * e0) := by
    calc n1 * n0 * (e0 * e0) = n1 * (n0 * e0) * e0 := by ring
      _ = n1 * (-n1 * e1) * e0 := by rw [hpen']
      _ = -(n1 * n1) * (e1 * e0) := by ring
  have key_b : e1 * e0 * (n0 * n0) = -(n1 * n0) * (e1 * e1) := by
    calc e1 * e0 * (n0 * n0) = e1 * (n0 * e0) * n0 := by ring
      _ = e1 * (-n1 * e1) * n0 := by rw [hpen']
      _ = -(n1 * n0) * (e1 * e1) := by ring
  -- B·A:
  have hBA : (e1 * e0 + n1 * n0) * (e0 * e0 + n0 * n0)
      = (e1 * e0 + n1 * n0) - (e1 * e0 + n1 * n0) * 0 + 0 * (n0 - e1) := by
    have hexp : (e1 * e0 + n1 * n0) * (e0 * e0 + n0 * n0)
        = e1 * e0 * (e0 * e0) + e1 * e0 * (n0 * n0) + n1 * n0 * (e0 * e0) + n1 * n0 * (n0 * n0) := by ring
    rw [hexp, key_a, key_b]
    -- = e1e0e0² + n1n0n0² - n1²e1e0 - n1n0e1²
    --   = e1e0(e0² - n1²) + n1n0(n0² - e1²)
    -- use e1² = 1-e0², n1² = 1-n0²: e0²-n1² = e0²-1+n0² = (e0²+n0²)-1; n0²-e1² = n0²-1+e0² = same!!
    have s1 : e0 * e0 - n1 * n1 = (e0 * e0 + n0 * n0) - 1 := by linarith
    have s2 : n0 * n0 - e1 * e1 = (e0 * e0 + n0 * n0) - 1 := by linarith
    have g : e1 * e0 * (e0 * e0) + -(n1 * n1) * (e1 * e0) + n1 * n0 * (n0 * n0) + -(n1 * n0) * (e1 * e1)
        = (e1 * e0 + n1 * n0) * ((e0 * e0 + n0 * n0) - 1) := by
      have g1 : e1 * e0 * (e0 * e0) + -(n1 * n1) * (e1 * e0) = (e1 * e0) * (e0 * e0 - n1 * n1) := by ring
      have g2 : n1 * n0 * (n0 * n0) + -(n1 * n0) * (e1 * e1) = (n1 * n0) * (n0 * n0 - e1 * e1) := by ring
      rw [g1, g2, s1, s2]
      ring
    rw [g]
    ring
  -- so B·A = B·(A - 1): hence B·(A) - B·(A-1) = 0 = B·1 = B!! 
  have hB : e1 * e0 + n1 * n0 = 0 := by
    have h1 : (e1 * e0 + n1 * n0) * ((e0 * e0 + n0 * n0) - ((e0 * e0 + n0 * n0) - 1)) = 0 := by
      have : (e1 * e0 + n1 * n0) * (((e0 * e0 + n0 * n0) - 1)) = (e1 * e0 + n1 * n0) * (e0 * e0 + n0 * n0) := by
        linear_combination hBA
      rw [this]
      ring
    -- ((e0²+n0²) - ((e0²+n0²)-1)) = 1:
    have h2 : (e1 * e0 + n1 * n0) * 1 = 0 := by
      have : (e0 * e0 + n0 * n0) - ((e0 * e0 + n0 * n0) - 1) = 1 := by ring
      rw [this] at h1
      exact h1
    simpa using h2
  -- A = 1:
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
  calc v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0)
      = v0 * 1 + v1 * 0 := by rw [hsum, hB]
    _ = v0 := by ring

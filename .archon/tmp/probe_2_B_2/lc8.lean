import Mathlib

example (v0 v1 e0 e1 n0 n1 : ℝ)
    (h0e : e0 * e0 + e1 * e1 = 1) (h0n : n0 * n0 + n1 * n1 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0) :
    v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) = v0 := by
  have h0e' : e1 * e1 = 1 - e0 * e0 := by linarith
  have h0n' : n1 * n1 = 1 - n0 * n0 := by linarith
  -- PROVE e0e0 + n0n0 = 1. Equivalent: e0e0 + n0n0 + e1e1 + n1n1 = 2 (sum of unit)
  -- and (e0e0+n0n0)·(e1e1+n1n1) = 1 (from perp: (n·e)² ... Lagrange: D² + perp² = (e0²+e1²)(n0²+n1²) = 1; and (e0²+n0²)(e1²+n1²) = D² also by the OTHER pairing Lagrange: (e0²+n0²)(e1²+n1²) = (e0e1+n0n1)² + (e0n1-n0e1)²; and (e0e1+n0n1)² = 4e0e1n0n1·... from perp: n1e1 = -n0e0 → n1e1·... 
  have hD2 : (e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0) + (n0 * e0 + n1 * e1) * (n0 * e0 + n1 * e1)
      = (e0 * e0 + e1 * e1) * (n0 * n0 + n1 * n1) := by ring
  rw [hpen, h0e, h0n] at hD2
  have hz : (0 : ℝ) * 0 = 0 := by ring
  rw [hz] at hD2
  -- other Lagrange pairing:
  have hL2 : (e0 * e1 + n0 * n1) * (e0 * e1 + n0 * n1) + (e0 * n1 - n0 * e1) * (e0 * n1 - n0 * e1)
      = (e0 * e0 + n0 * n0) * (e1 * e1 + n1 * n1) := by ring
  -- e0e1+n0n1 from perp: (n0e0+n1e1)=0 and ... NO relation. use: (n1e1)² = (n0e0)²:
  have hsq : (n1 * e1) * (n1 * e1) = (n0 * e0) * (n0 * e0) := by
    have hpen' : n1 * e1 = -n0 * e0 := by linear_combination hpen
    rw [hpen']; ring
  have hk1 : (n1 * e1) * (n1 * e1) = (n1 * n1) * (e1 * e1) := by ring
  rw [hk1, h0n', h0e'] at hsq
  -- hsq : (1-n0²)(1-e0²) = n0²e0² → 1 - n0² - e0² + n0²e0² = n0²e0² → 1 = n0² + e0²
  have hsum : e0 * e0 + n0 * n0 = 1 := by nlinarith [hsq]
  -- v1 coefficient: e1e0 + n1n0 = 0: (e1²)(e0²) = (1-n0²)n0² vs (n1²)(n0²) = (1-n0²)n0²: equal squares;
  -- sign: e1e0 vs -n1n0: from hpen: n1e1 = -n0e0: multiply?? can't get e1e0 sign. BUT:
  -- (e1e0 + n1n0)² = (e1e0)² + (n1n0)² + 2e1e0n1n0 = 2n0²(1-n0²) + 2e1e0n1n0; and n1e1 = -n0e0 gives
  -- e0e1n0n1 = e0e1n0n1 ... unknown sign. Try (e1e0+n1n0)·(n0e0+n1e1) = 0 expansion:
  have hv1sq : (e1 * e0 + n1 * n0) * (n0 * e0 + n1 * e1) = 0 := by rw [hpen]; ring
  have hv1e : e1 * e0 * (n0 * e0) + e1 * e0 * (n1 * e1) + n1 * n0 * (n0 * e0) + n1 * n0 * (n1 * e1) = 0 := by
    have h := hv1sq
    ring_nf at h ⊢
    linarith
  -- now: e1e0n0e0 + e1e0n1e1 + n1n0n0e0 + n1n0n1e1 = 0
  --      = e0²e0e1 + e0e1n1² + n0²n0n1 + n1²n0n1 = e0²·e0e1 + (1-n0²)·e0e1 + n0²·n0n1 + (1-n0²)·n0n1
  -- hmm e1e1 = 1-e0²: 
  have hv2 : e0 * e0 * (e0 * e1) + e1 * e0 * (n1 * e1) + n0 * n0 * (n1 * n0) + n1 * n0 * (n1 * e1) = 0 := by
    have h := hv1e
    ring_nf at h ⊢
    linarith
  rw [h0n', h0e'] at hv2
  have hsum2 : e0 * e0 + n0 * n0 = 1 := hsum
  have hv3 : (e1 * e0 + n1 * n0) * (e0 * e0 + n0 * n0) = 0 := by
    -- = e1e0³ + e1e0n0² + n1n0e0² + n1n0³: compare hv2: e0²e0e1 + e1e0(1-e0²) + n0²n0n1 + n1n0(1-n0²)
    --   = e0²e0e1 + e1e0 - e0²e0e1 + n0²n0n1 + n1n0 - n0²n0n1 = e1e0 + n1n0 = 0!!! GREAT
    nlinarith [hv2]
  rw [hsum] at hv3
  have hv1z : e1 * e0 + n1 * n0 = 0 := by simpa using hv3
  -- assemble
  have hfinal : v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) = v0 * 1 + v1 * 0 := by
    rw [hsum, hv1z]
  rw [hfinal]
  ring

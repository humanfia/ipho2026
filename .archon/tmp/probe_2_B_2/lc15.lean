import Mathlib

theorem keyalg (v0 v1 e0 e1 n0 n1 : ℝ)
    (h0e : e0 * e0 + e1 * e1 = 1) (h0n : n0 * n0 + n1 * n1 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0) :
    v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) = v0 := by
  have h0e' : e1 * e1 = 1 - e0 * e0 := by linarith
  have h0n' : n1 * n1 = 1 - n0 * n0 := by linarith
  have hp : n0 * e0 = -(n1 * e1) := by linarith
  have key_a : n1 * n0 * (e0 * e0) = -(n1 * n1) * (e1 * e0) := by
    rw [show n1 * n0 * (e0 * e0) = n1 * (n0 * e0) * e0 by ring, hp]; ring
  have key_b : e1 * e0 * (n0 * n0) = -(n1 * n0) * (e1 * e1) := by
    rw [show e1 * e0 * (n0 * n0) = e1 * (n0 * e0) * n0 by ring, hp]; ring
  have hsq : (n1 * n1) * (e1 * e1) = n0 * e0 * (n0 * e0) := by
    have hs : n1 * e1 * (n1 * e1) = n0 * e0 * (n0 * e0) := by rw [show n1 * e1 = -n0 * e0 by linarith]; ring
    have hk : n1 * e1 * (n1 * e1) = (n1 * n1) * (e1 * e1) := by ring
    rw [hk] at hs
    exact hs
  rw [h0n', h0e'] at hsq
  have hsum : e0 * e0 + n0 * n0 = 1 := by nlinarith [hsq]
  have hB0 : (e1 * e0 + n1 * n0) * (e0 * e0 + n0 * n0 - 1) = (e1 * e0 + n1 * n0) * (e0 * e0 + n0 * n0) := by
    have hexp : (e1 * e0 + n1 * n0) * (e0 * e0 + n0 * n0)
        = e1 * e0 * (e0 * e0) + e1 * e0 * (n0 * n0) + n1 * n0 * (e0 * e0) + n1 * n0 * (n0 * n0) := by ring
    rw [hexp, key_a, key_b]
    have s1 : e0 * e0 - n1 * n1 = e0 * e0 + n0 * n0 - 1 := by linarith
    have s2 : n0 * n0 - e1 * e1 = e0 * e0 + n0 * n0 - 1 := by linarith
    have g : e1 * e0 * (e0 * e0) + -(n1 * n0) * (e1 * e1) + -(n1 * n1) * (e1 * e0) + n1 * n0 * (n0 * n0)
        = (e1 * e0 + n1 * n0) * (e0 * e0 + n0 * n0 - 1) := by
      have g1 : e1 * e0 * (e0 * e0) + -(n1 * n1) * (e1 * e0) = e1 * e0 * (e0 * e0 - n1 * n1) := by ring
      have g2 : -(n1 * n0) * (e1 * e1) + n1 * n0 * (n0 * n0) = n1 * n0 * (n0 * n0 - e1 * e1) := by ring
      rw [g1, g2, s1, s2]; ring
    rw [g]
  rw [hsum] at hB0
  have hB : e1 * e0 + n1 * n0 = 0 := by
    have h1 : (e1 * e0 + n1 * n0) * (1 - 1) = (e1 * e0 + n1 * n0) * 1 := hB0
    norm_num at h1
    linarith
  calc v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0)
      = v0 * 1 + v1 * 0 := by rw [hsum, hB]
    _ = v0 := by ring

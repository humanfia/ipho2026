import Mathlib

example (v0 v1 e0 e1 n0 n1 : ℝ)
    (h0e : e0 ^ 2 + e1 ^ 2 = 1) (h0n : n0 ^ 2 + n1 ^ 2 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0)
    (u w : ℝ)
    (hu : u = v0 * e0 + v1 * e1) (hw : w = v0 * n0 + v1 * n1) :
    v0 = u * e0 + w * n0 := by
  have h1 : u * e0 = v0 * e0 * e0 + v1 * e1 * e0 := by rw [hu]; ring
  have h2 : w * n0 = v0 * n0 * n0 + v1 * n1 * n0 := by rw [hw]; ring
  have h3 : u * e0 + w * n0 = v0 * (e0 * e0 + n0 * n0) + v1 * (e1 * e0 + n1 * n0) := by linear_combination h1 + h2
  have h4 : e0 * e0 + n0 * n0 = 1 - (e1 * e1 + n1 * n1 - 1) + 0 := by linarith
  -- do it cleanly: from h0e, h0n: e0^2 + n0^2 = 2 - (e1^2 + n1^2)... not 1. So coefficient approach needs different combination
  sorry

import Mathlib

-- substitution path: use det D, formulas from mul combos (linear_combination), nlinarith only for D-related scalars
example (v0 v1 e0 e1 n0 n1 uu ww : ℝ)
    (h0e : e0 ^ 2 + e1 ^ 2 = 1) (h0n : n0 ^ 2 + n1 ^ 2 = 1)
    (hpen : n0 * e0 + n1 * e1 = 0)
    (hu : uu = v0 * e0 + v1 * e1) (hw : ww = v0 * n0 + v1 * n1) :
    v0 = uu * e0 + ww * n0 := by
  have hD2 : (e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0) = 1 := by nlinarith [h0e, h0n, hpen]
  have hcX : uu * n1 - ww * n0 = v0 * (e0 * n1 - e1 * n0) := by
    linear_combination hu * n1 - hw * n0
  have hxD : v0 * (e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0) = uu * n1 - ww * n0 := by
    linear_combination hcX * (e0 * n1 - e1 * n0)
  -- want: uu*e0 + ww*n0 = v0. Multiply by D... instead show equality via D*(target)
  have key : (uu * e0 + ww * n0) * (e0 * n1 - e1 * n0) = v0 * (e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0) * 0 + v0 := by
    -- LHS = v0 * (e0^2 n1 - e0 e1 n0) + v1*(e1 e0 n1 - e1^2 n0) + v0*(n0^2 n1 - n0 n1 e0) + v1 (n1 n0^2... )
    -- expand via hu', hw'
    have he1 : (uu * e0 + ww * n0) * (e0 * n1 - e1 * n0)
        = (v0 * e0 + v1 * e1) * e0 * (e0 * n1 - e1 * n0) + (v0 * n0 + v1 * n1) * n0 * (e0 * n1 - e1 * n0) := by
      rw [hu, hw]
    rw [he1]
    nlinarith [h0e, h0n, hpen]
  -- now use D^2 = 1
  have htarget : uu * e0 + ww * n0 = v0 := by
    have hD2' : (e0 * n1 - e1 * n0) * (e0 * n1 - e1 * n0) - 1 = 0 := by linarith
    -- key says LHS*
    -- From key: (uu*e0+ww*n0)*D = v0*D*D*0 + v0 = v0. And multiply key... hmm need D ≠ 0
    have hD1 : (e0 * n1 - e1 * n0) ^ 2 = 1 := by nlinarith [h0e, h0n, hpen]
    have hDne : (e0 * n1 - e1 * n0) ≠ 0 := by
      intro hb; rw [hb] at hD1; norm_num at hD1
    -- multiply both sides of target by D and use key + D^2 = 1
    have hm := mul_left_cancel₀ hDne
    apply hm
    -- goal: (uu*e0+ww*n0)*D = v0*D
    nlinarith [key, hD1, hD2]
  exact htarget.symm

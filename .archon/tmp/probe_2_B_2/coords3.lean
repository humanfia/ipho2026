import Mathlib
open Real Set
noncomputable section

abbrev Plane := EuclideanSpace ℝ (Fin 2)

example {v e n : Plane}
    (he : ‖e‖ = 1) (hn : ‖n‖ = 1)
    (hperp : @inner ℝ _ _ n e = 0)
    {u w : ℝ}
    (hu : u = @inner ℝ _ _ v e)
    (hw : w = @inner ℝ _ _ v n)
    (i : Fin 2) :
    v i = u * e i + w * n i := by
  have h0e : e 0 ^ 2 + e 1 ^ 2 = 1 := by
    have h1 : ‖e‖ ^ 2 = 1 := by rw [he]; norm_num
    rw [EuclideanSpace.norm_eq] at h1
    have hnn : (0:ℝ) ≤ ∑ k : Fin 2, ‖e k‖ ^ 2 := Finset.sum_nonneg fun k _ => by positivity
    rw [Real.sq_sqrt hnn] at h1
    simpa [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, sq_abs] using h1
  have h0n : n 0 ^ 2 + n 1 ^ 2 = 1 := by
    have h1 : ‖n‖ ^ 2 = 1 := by rw [hn]; norm_num
    rw [EuclideanSpace.norm_eq] at h1
    have hnn : (0:ℝ) ≤ ∑ k : Fin 2, ‖n k‖ ^ 2 := Finset.sum_nonneg fun k _ => by positivity
    rw [Real.sq_sqrt hnn] at h1
    simpa [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, sq_abs] using h1
  have hpen : n 0 * e 0 + n 1 * e 1 = 0 := by
    have h := hperp
    rw [PiLp.inner_apply] at h
    simpa [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, RCLike.inner_apply, mul_comm] using h
  have hu' : u = v 0 * e 0 + v 1 * e 1 := by
    rw [hu, PiLp.inner_apply]
    simp [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, RCLike.inner_apply, mul_comm]
  have hw' : w = v 0 * n 0 + v 1 * n 1 := by
    rw [hw, PiLp.inner_apply]
    simp [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, RCLike.inner_apply, mul_comm]
  fin_cases i
  · simp only [Fin.zero_eta]
    nlinarith [h0e, h0n, hpen, hu', hw']
  · simp only [Fin.mk_one]
    nlinarith [h0e, h0n, hpen, hu', hw']

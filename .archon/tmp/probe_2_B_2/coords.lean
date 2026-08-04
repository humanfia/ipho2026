import Mathlib
open Real Set
noncomputable section

abbrev Plane := EuclideanSpace ℝ (Fin 2)

-- coordinate extraction: u = ⟨v, e⟩, w = ⟨v, n⟩ determine v coordinatewise
example {v e n : Plane}
    (he : ‖e‖ = 1) (hn : ‖n‖ = 1)
    (hperp : @inner ℝ _ _ n e = 0)
    {u w : ℝ}
    (hu : u = @inner ℝ _ _ v e)
    (hw : w = @inner ℝ _ _ v n)
    (i : Fin 2) :
    v i = u * e i + w * n i := by
  -- key: |u|^2 + |w|^2 = ‖v‖^2 via single![0,1] decomposition... prove directly:
  have key : ∀ x : Plane, ∀ i : Fin 2,
      @inner ℝ _ _ x e * e i + @inner ℝ _ _ x n * n i = x i := by
    intro x i
    have h0e : e 0 ^ 2 + e 1 ^ 2 = 1 := by
      have : ‖e‖ ^ 2 = 1 := by rw [he]; norm_num
      rw [EuclideanSpace.norm_eq] at this
      have hnn : (0:ℝ) ≤ ∑ k : Fin 2, ‖e k‖ ^ 2 := Finset.sum_nonneg fun k _ => by positivity
      rw [Real.sq_sqrt hnn] at this
      simpa [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, sq_abs] using this
    have h0n : n 0 ^ 2 + n 1 ^ 2 = 1 := by
      have : ‖n‖ ^ 2 = 1 := by rw [hn]; norm_num
      rw [EuclideanSpace.norm_eq] at this
      have hnn : (0:ℝ) ≤ ∑ k : Fin 2, ‖n k‖ ^ 2 := Finset.sum_nonneg fun k _ => by positivity
      rw [Real.sq_sqrt hnn] at this
      simpa [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, sq_abs] using this
    have hpen : n 0 * e 0 + n 1 * e 1 = 0 := by
      have h := hperp
      rw [real_inner_eq] at h
      simpa [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, mul_comm] using h
    -- inner x e = x0 e0 + x1 e1 etc.
    have hixe : @inner ℝ _ _ x e = x 0 * e 0 + x 1 * e 1 := by
      rw [real_inner_eq]
      simp [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, mul_comm]
    have hixn : @inner ℝ _ _ x n = x 0 * n 0 + x 1 * n 1 := by
      rw [real_inner_eq]
      simp [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, mul_comm]
    rw [hixe, hixn]
    fin_cases i
    · simp only [Fin.zero_eta]
      nlinarith [h0e, h0n, hpen]
    · simp only [Fin.mk_one]
      nlinarith [h0e, h0n, hpen]
  rw [hu, hw]
  exact (key v i).symm

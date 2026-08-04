import Mathlib
open Real Set
noncomputable section

abbrev Plane := EuclideanSpace ℝ (Fin 2)

-- Bottom-left extraction for Fin 2 EuclideanSpace
example (x e n : Plane) (he : ‖e‖ = 1) (hn : ‖n‖ = 1)
    (hperp : @inner ℝ _ _ n e = 0) (v : Plane) :
    v = @inner ℝ _ _ v e • e + @inner ℝ _ _ v n • n := by
    sorry

-- sSup/sInf of image of Ioo
example (f : ℝ → ℝ) (hf : ∀ y ∈ Set.Ioo (-1) 1, f y = y) (b : ℝ) (hb : 0 < b) :
    sSup (f '' Set.Ioo (-b) b) = b := by
  sorry

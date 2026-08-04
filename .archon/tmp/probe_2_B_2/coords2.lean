import Mathlib
open Real Set
noncomputable section

abbrev Plane := EuclideanSpace ℝ (Fin 2)

example {x e : Plane} : @inner ℝ _ _ x e = x 0 * e 0 + x 1 * e 1 := by
  rw [PiLp.inner_apply]
  simp [Finset.sum_fin_eq_sum_range, Finset.sum_range_succ, RCLike.inner_apply, mul_comm]

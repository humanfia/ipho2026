import Mathlib

-- WITNESS (proof-evidence, not part of the shipped file): with the frozen
-- `NeighboringRayExpansion` fields, the two `hfam` subgoals are underivable.
-- The witness instantiates every abstract structure field (acute branch,
-- C.1 pointwise values, family-membership fields, both `HasDerivAt`
-- regularity fields) while `deriv M θ = 1 ≠ -2 = deriv specularSlopeFamily θ`.
-- Fresh `lake env lean` on this file: 0 errors, 0 sorries

open Real Asymptotics Filter Topology

namespace ReqModel

example :
    ∃ (R : ℝ) (hRp : 0 < R) (M B mA bA : ℝ → ℝ) (mB bB : ℝ → ℝ → ℝ) (θ : ℝ),
      θ ∈ Set.Ioo 0 (π / 2) ∧
      mA θ = M θ ∧ bA θ = B θ ∧
      (∀ Δ : ℝ, mB θ Δ = M (θ + Δ)) ∧ (∀ Δ : ℝ, bB θ Δ = B (θ + Δ)) ∧
      mA θ = cot (2 * θ) ∧ bA θ = R / (2 * cos θ) ∧
      (∃ dm : ℝ, HasDerivAt M dm θ) ∧ (∃ db : ℝ, HasDerivAt B db θ) ∧
      deriv M θ = 1 ∧ deriv (fun phi : ℝ ↦ cos (2 * phi) / sin (2 * phi)) θ = -2 := by
  refine ⟨1, one_pos,
    (fun φ ↦ cot (2 * (π / 4 : ℝ)) + (φ - π / 4)),
    (fun _ ↦ 1 / (2 * cos (π / 4 : ℝ))),
    (fun φ ↦ cot (2 * (π / 4 : ℝ)) + (φ - π / 4)),
    (fun _ ↦ 1 / (2 * cos (π / 4 : ℝ))),
    (fun _ Δ ↦ cot (2 * (π / 4 : ℝ)) + ((π / 4 + Δ) - π / 4)),
    (fun _ _ ↦ 1 / (2 * cos (π / 4 : ℝ))),
    π / 4, ?_, rfl, rfl, fun _ ↦ by ring, fun _ ↦ rfl, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · exact ⟨by positivity, by linarith [Real.pi_pos]⟩
  · show cot (2 * (π / 4 : ℝ)) + ((π / 4 : ℝ) - π / 4) = _
    rw [sub_self, add_zero]
  · rfl
  · exact ⟨1, by
      have h1 : HasDerivAt (fun φ : ℝ ↦ φ - (π / 4 : ℝ)) 1 (π / 4) :=
        (hasDerivAt_id (π / 4 : ℝ)).sub_const (π / 4 : ℝ)
      have h2 := (hasDerivAt_const (π / 4 : ℝ) (cot (2 * (π / 4 : ℝ)))).add h1
      rwa [zero_add] at h2⟩
  · exact ⟨0, hasDerivAt_const (π / 4 : ℝ) (1 / (2 * cos (π / 4 : ℝ)))⟩
  · have hderiv : HasDerivAt (fun φ : ℝ ↦ cot (2 * (π / 4 : ℝ)) + (φ - π / 4 : ℝ)) 1 (π / 4) := by
      have h1 : HasDerivAt (fun φ : ℝ ↦ φ - (π / 4 : ℝ)) 1 (π / 4) :=
        (hasDerivAt_id (π / 4 : ℝ)).sub_const (π / 4 : ℝ)
      have h2 := (hasDerivAt_const (π / 4 : ℝ) (cot (2 * (π / 4 : ℝ)))).add h1
      rwa [zero_add] at h2
    exact hderiv.deriv
  · have hs : HasDerivAt (fun x : ℝ ↦ sin (2 * x)) (cos (2 * (π / 4 : ℝ)) * 2) (π / 4) := by
      convert ((hasDerivAt_id (π / 4 : ℝ)).const_mul 2).sin using 1 <;> simp [mul_comm]
    have hc : HasDerivAt (fun x : ℝ ↦ cos (2 * x)) (-sin (2 * (π / 4 : ℝ)) * 2) (π / 4) := by
      convert ((hasDerivAt_id (π / 4 : ℝ)).const_mul 2).cos using 1 <;> simp [mul_comm]
    have hsin : sin (2 * (π / 4 : ℝ)) ≠ 0 := by
      rw [show 2 * (π / 4 : ℝ) = π / 2 by ring, Real.sin_pi_div_two]
      exact one_ne_zero
    have hfun : (fun phi : ℝ ↦ cos (2 * phi) / sin (2 * phi))
        = (fun x : ℝ ↦ cos (2 * x)) / fun x : ℝ ↦ sin (2 * x) := by
      ext phi
      rw [Pi.div_apply]
    have hder := HasDerivAt.deriv (hc.div hs hsin)
    rw [hfun, hder]
    rw [show 2 * (π / 4 : ℝ) = π / 2 by ring, Real.sin_pi_div_two, Real.cos_pi_div_two]
    norm_num

end ReqModel

import re
path = '/root/proposal_for_physic/science-mango-ipho-2026-k3-run/IPhO2026Problems/problem_IPhO_2026_2_B_2.lean'
src = open(path).read()

# ---------- abs_hitOffset_eq ----------
old1 = '''    (r : AbsorbedRays p g) {y : ℝ} (hy : y ∈ r.hitSet) :
    |hitOffset p g r y| = p.R * Real.sin (incidenceAngle p g (r.incidentPt y)) := by
  sorry'''
new1 = '''    (r : AbsorbedRays p g) {y : ℝ} (hy : y ∈ r.hitSet) :
    |hitOffset p g r y| = p.R * Real.sin (incidenceAngle p g (r.incidentPt y)) := by
  classical
  -- Abbreviations for the relative position and its two readouts.
  set v : Plane := r.incidentPt y - g.C with hv
  set u : ℝ := @inner ℝ _ _ v g.e with hu
  set w : ℝ := @inner ℝ _ _ v g.n with hw
  -- From the mirror membership we get `‖v‖ = R` and `0 ≤ u`.
  have hm := r.on_mirror hy
  obtain ⟨hnorm_v, hu_nonneg⟩ := hm
  have hnorm_v' : ‖v‖ = p.R := by
    have hdist : dist (r.incidentPt y) g.C = p.R := hnorm_v
    rw [dist_eq_norm] at hdist
    exact hdist
  -- Expansion of `v` in the orthonormal family `{e, n}` (i.e. `!₂[u, w]`).
  have hcoord : ∀ i : Fin 2, v i = u * g.e i + w * g.n i := by
    intro i
    have h1 : v i = @inner ℝ _ _ v g.e * g.e i + @inner ℝ _ _ v g.n * g.n i := by
      fin_cases i
      · -- coordinate 0
        simp only [Fin.zero_eta]
        have he := congr_fun (congr_arg DFunLike.coe
          (basis_iff_orthonormal (𝕜 := ℝ).1
            (EuclideanSpace.basisFun (Fin 2) ℝ).orthonormal |>.2) 0)
        -- fall back to direct computation
        exfalso
        exact absurd he (by simp)  -- placeholder, replaced below
      · exfalso;
        sorry
    exact h1
  sorry'''
print('skip this approach')

import Mathlib
open Real

structure TorusParams where
  mu0 : ℝ
  V : ℝ
  n : ℝ
  K : ℝ
  lambda : ℝ

structure TorusState where
  T : ℝ
  M : ℝ
  H : ℝ

def SatisfiesEOS (p : TorusParams) (s : TorusState) : Prop :=
  s.T * s.M * p.V = p.n * p.K * s.H

structure IsothermalFieldChange (p : TorusParams) where
  T : ℝ
  H_i : ℝ
  H_f : ℝ
  M_of_H : ℝ → ℝ
  Q_in : ℝ → ℝ
  hT : T ≠ 0
  h_eos : ∀ H ∈ Set.Icc (min 0 (min H_i H_f)) (max 0 (max H_i H_f)),
    SatisfiesEOS p ⟨T, M_of_H H, H⟩
  h_ref : Q_in 0 = 0
  field_increases : Bool
  h_branch : field_increases = decide (M_of_H H_i ≤ M_of_H H_f)

def IsMagneticWorkDensity (p : TorusParams)
    (H_of_M workDensity : ℝ → ℝ) : Prop :=
  ∀ M : ℝ, workDensity M = p.mu0 * p.V * H_of_M M

noncomputable def weirdM (H : ℝ) : ℝ := if H ∈ Set.Icc (-2) 0 then (-2 : ℝ) * H else 0

noncomputable def weirdProc : IsothermalFieldChange ⟨1,1,1,-2,0⟩ where
  T := 1
  H_i := -2
  H_f := -2
  M_of_H := weirdM
  Q_in := fun _ => 0
  hT := by norm_num
  h_eos := by
    intro H hH
    have hmem : H ∈ Set.Icc (-2:ℝ) 0 := by
      have h1 := hH.1; have h2 := hH.2
      have e1 : min (0:ℝ) (min (-2) (-2)) = -2 := by norm_num
      have e2 : max (0:ℝ) (max (-2) (-2)) = 0 := by norm_num
      rw [e1] at h1; rw [e2] at h2
      exact ⟨h1, h2⟩
    show (1:ℝ) * weirdM H * 1 = 1 * -2 * H
    simp only [weirdM, hmem, if_true]
    ring
  h_ref := rfl
  field_increases := true
  h_branch := by
    show true = decide (weirdM (-2) ≤ weirdM (-2))
    simp

theorem weirdM_on : ∀ M ∈ Set.uIcc (0 : ℝ) 4, weirdM M = 0 := by
  intro M hM
  rw [Set.uIcc_of_le (by norm_num : (0:ℝ) ≤ 4)] at hM
  rcases hM with ⟨hm1, _hm2⟩
  by_cases hIn : M ∈ Set.Icc (-2 : ℝ) 0
  · have hM0 : M = 0 := le_antisymm hIn.2 hm1
    subst hM0
    simp [weirdM]
  · simp only [weirdM, if_neg hIn]

theorem legLHS : (∫ M in (0)..(4:ℝ), weirdM M) = 0 := by
  have hconv : (∫ M in (0)..(4:ℝ), weirdM M) = ∫ M in (0)..(4:ℝ), (fun _ : ℝ => (0:ℝ)) M := by
    apply intervalIntegral.integral_congr
    intro M hM
    exact weirdM_on M hM
  rw [hconv]
  simp

theorem leg_integral_eval_IS_FALSE :
    ¬ (∀ (p : TorusParams) (proc : IsothermalFieldChange p)
      (_hV : p.V ≠ 0) {H : ℝ}
      (_hH : H ∈ Set.Icc (min 0 (min proc.H_i proc.H_f))
        (max 0 (max proc.H_i proc.H_f)))
      (workDensity : ℝ → ℝ)
      (_hdens : IsMagneticWorkDensity p proc.M_of_H workDensity),
      ∫ M in (0)..proc.M_of_H H, workDensity M =
        (p.mu0 * p.n * p.K / (2 * proc.T)) * (proc.M_of_H H) ^ 2) := by
  intro hcon
  have hHmem : (-2:ℝ) ∈ Set.Icc (min (0:ℝ) (min weirdProc.H_i weirdProc.H_f))
      (max (0:ℝ) (max weirdProc.H_i weirdProc.H_f)) := by
    have e1 : min (0:ℝ) (min weirdProc.H_i weirdProc.H_f) = -2 := by
      show min 0 (min (-2) (-2)) = -2; norm_num
    have e2 : max (0:ℝ) (max weirdProc.H_i weirdProc.H_f) = 0 := by
      show max 0 (max (-2) (-2)) = 0; norm_num
    rw [e1, e2]
    exact ⟨le_refl _, by norm_num⟩
  have hdens : IsMagneticWorkDensity ⟨1,1,1,-2,0⟩ weirdProc.M_of_H
      (fun M => 1 * 1 * weirdProc.M_of_H M) := fun M => rfl
  have hres := hcon ⟨1,1,1,-2,0⟩ weirdProc (by norm_num) hHmem
      (fun M => 1 * 1 * weirdProc.M_of_H M) hdens
  have hend : weirdProc.M_of_H (-2) = 4 := by
    show weirdM (-2) = 4
    simp only [weirdM]
    norm_num
  rw [hend] at hres
  have hLHS : ∫ M in (0)..(4 : ℝ), 1 * 1 * weirdProc.M_of_H M = 0 := by
    have hf : (fun M => (1:ℝ) * 1 * weirdProc.M_of_H M) = weirdM := by
      funext M
      show 1 * 1 * weirdM M = weirdM M
      ring
    rw [hf]
    exact legLHS
  have hRHS : (1:ℝ) * 1 * -2 / (2 * weirdProc.T) * 4^2 = -16 := by
    have ht : weirdProc.T = 1 := rfl
    rw [ht]; norm_num
  rw [hLHS, hRHS] at hres
  norm_num at hres

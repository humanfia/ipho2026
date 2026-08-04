import Mathlib

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

noncomputable def badProc : IsothermalFieldChange ⟨0, 1, 2, 1, 0⟩ where
  T := 1
  H_i := -1
  H_f := -1
  M_of_H := fun H => 2 * H
  Q_in := fun _ => 0
  hT := by norm_num
  h_eos := by
    intro H _hH
    show (1:ℝ) * (2 * H) * 1 = 2 * 1 * H
    ring
  h_ref := rfl
  field_increases := true
  h_branch := by
    show true = decide ((fun H => (2:ℝ)*H) (-1) ≤ (fun H => (2:ℝ)*H) (-1))
    simp

theorem leg_mem_tracked_range_IS_FALSE :
    ¬ (∀ (p : TorusParams) (proc : IsothermalFieldChange p)
    (H : ℝ) (_hH : H ∈ Set.Icc (min 0 (min proc.H_i proc.H_f))
      (max 0 (max proc.H_i proc.H_f)))
    (M : ℝ) (_hM : M ∈ Set.uIcc 0 (proc.M_of_H H)),
    M ∈ Set.Icc (min 0 (min proc.H_i proc.H_f))
      (max 0 (max proc.H_i proc.H_f))) := by
  intro hcon
  have hH : (-1:ℝ) ∈ Set.Icc (min 0 (min badProc.H_i badProc.H_f))
      (max 0 (max badProc.H_i badProc.H_f)) := by
    show (-1:ℝ) ∈ Set.Icc (min 0 (min (-1) (-1))) (max 0 (max (-1) (-1)))
    norm_num [Set.mem_Icc]
  have hM : (-1.5:ℝ) ∈ Set.uIcc 0 (badProc.M_of_H (-1)) := by
    show (-1.5:ℝ) ∈ Set.uIcc 0 ((fun H => (2:ℝ)*H) (-1))
    rw [Set.mem_uIcc]
    right
    norm_num
  have hconcl := hcon ⟨0, 1, 2, 1, 0⟩ badProc (-1) hH (-1.5) hM
  have : (-1.5:ℝ) ∈ Set.Icc (min 0 (min (-1) (-1))) (max 0 (max (-1) (-1))) := hconcl
  norm_num [Set.mem_Icc] at this

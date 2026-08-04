import Mathlib

namespace TFP5

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

noncomputable def heatCapacityConstM (p : TorusParams) (T : ℝ) : ℝ :=
  p.n * p.lambda / T ^ 2

def HasHeatCapacityLaw (p : TorusParams) (U : ℝ → ℝ) : Prop :=
  ∀ T : ℝ, T ≠ 0 → HasDerivAt U (heatCapacityConstM p T) T

def IsMagneticWorkDensity (p : TorusParams)
    (H_of_M workDensity : ℝ → ℝ) : Prop :=
  ∀ M : ℝ, workDensity M = p.mu0 * p.V * H_of_M M

def ObeysFirstLawMagnetic (p : TorusParams) (U : ℝ → ℝ)
    (T_iso : ℝ) (heatDensity Q_in : ℝ → ℝ) : Prop :=
  HasHeatCapacityLaw p U →
    ∀ (M₀ M_target : ℝ),
      Q_in M_target - Q_in M₀ =
        (U T_iso - U T_iso) - ∫ M in M₀..M_target, heatDensity M

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

noncomputable def heatTransferredIntoTorus (p : TorusParams)
    (proc : IsothermalFieldChange p) : ℝ :=
  proc.Q_in (proc.M_of_H proc.H_f) - proc.Q_in (proc.M_of_H proc.H_i)

noncomputable def heat_into_torus_value (p : TorusParams)
    (proc : IsothermalFieldChange p) : ℝ :=
  -(p.mu0 * p.n * p.K / (2 * proc.T)) * (proc.H_f ^ 2 - proc.H_i ^ 2)

noncomputable def linProc : IsothermalFieldChange ⟨1,1,1,-2,0⟩ where
  T := 1
  H_i := -2
  H_f := -1
  M_of_H := fun H => (-2 : ℝ) * H
  Q_in := fun M => -∫ x in (0)..M, (-2 : ℝ) * x
  hT := by norm_num
  h_eos := by
    intro H _hH
    show (1:ℝ) * (-2 * H) * 1 = 1 * -2 * H
    ring
  h_ref := by
    show (-∫ x in (0)..(0:ℝ), (-2:ℝ) * x) = 0
    simp
  field_increases := false
  h_branch := by
    show false = decide ((-2:ℝ) * -2 ≤ -2 * -1)
    norm_num

theorem U_law : HasHeatCapacityLaw ⟨1,1,1,-2,0⟩ (fun _ : ℝ => 0) := by
  intro T _hT
  have h0 : HasDerivAt (fun _ : ℝ => (0:ℝ)) 0 T := hasDerivAt_const T 0
  have hcm : heatCapacityConstM ⟨1,1,1,-2,0⟩ T = 0 := by simp [heatCapacityConstM]
  rw [hcm]; exact h0

theorem target_IS_FALSE :
    ¬ (∀ (p : TorusParams) (U : ℝ → ℝ)
      (proc : IsothermalFieldChange p)
      (_hU : HasHeatCapacityLaw p U)
      (_hV : p.V ≠ 0)
      (_h_first_law : ∀ (workDensity : ℝ → ℝ),
        IsMagneticWorkDensity p proc.M_of_H workDensity →
        ObeysFirstLawMagnetic p U proc.T workDensity proc.Q_in)
      (Q : ℝ) (_hQ : Q = heatTransferredIntoTorus p proc),
      Q = heat_into_torus_value p proc) := by
  intro hcon
  have hfl : ∀ (workDensity : ℝ → ℝ),
      IsMagneticWorkDensity ⟨1,1,1,-2,0⟩ linProc.M_of_H workDensity →
      ObeysFirstLawMagnetic ⟨1,1,1,-2,0⟩ (fun _ : ℝ => 0) linProc.T workDensity linProc.Q_in := by
    intro wd hdens _hU M₀ Mt
    have hwd : wd = fun M => (-2 : ℝ) * M := by
      funext M
      have h1 := hdens M
      rw [h1]
      show (1:ℝ) * 1 * linProc.M_of_H M = -2 * M
      show (1:ℝ) * 1 * (-2 * M) = -2 * M
      ring
    show linProc.Q_in Mt - linProc.Q_in M₀ = ((0:ℝ) - 0) - ∫ M in M₀..Mt, wd M
    rw [hwd]
    simp only [linProc]
    have hsplit : (∫ M in M₀..Mt, (-2:ℝ) * M)
        = (∫ M in M₀..(0:ℝ), (-2:ℝ) * M) + (∫ M in (0:ℝ)..Mt, (-2:ℝ) * M) := by
      have h1 : IntervalIntegrable (fun M : ℝ => (-2:ℝ) * M) MeasureTheory.volume M₀ 0 :=
        IntervalIntegrable.const_mul intervalIntegral.intervalIntegrable_id _
      have h2 : IntervalIntegrable (fun M : ℝ => (-2:ℝ) * M) MeasureTheory.volume 0 Mt :=
        IntervalIntegrable.const_mul intervalIntegral.intervalIntegrable_id _
      exact (intervalIntegral.integral_add_adjacent_intervals h1 h2).symm
    have hsymm := intervalIntegral.integral_symm (a := M₀) (b := (0:ℝ)) (f := fun M : ℝ => (-2:ℝ)*M) (μ := MeasureTheory.volume)
    rw [hsplit]
    linarith [hsymm]
  have hQ : (-12:ℝ) = heatTransferredIntoTorus ⟨1,1,1,-2,0⟩ linProc := by
    show (-12:ℝ) = linProc.Q_in (linProc.M_of_H linProc.H_f) - linProc.Q_in (linProc.M_of_H linProc.H_i)
    have hfv : linProc.H_f = -1 := rfl
    have hiv : linProc.H_i = -2 := rfl
    rw [hfv, hiv]
    have emf : linProc.M_of_H (-1) = 2 := by
      show ((-2:ℝ) * -1) = 2; norm_num
    have emi : linProc.M_of_H (-2) = 4 := by
      show ((-2:ℝ) * -2) = 4; norm_num
    rw [emf, emi]
    simp only [linProc]
    have i2 : (∫ x in (0)..(2:ℝ), (-2:ℝ) * x) = -4 := by
      rw [intervalIntegral.integral_const_mul, integral_id]; norm_num
    have i4 : (∫ x in (0)..(4:ℝ), (-2:ℝ) * x) = -16 := by
      rw [intervalIntegral.integral_const_mul, integral_id]; norm_num
    linarith [i2, i4]
  have hres := hcon ⟨1,1,1,-2,0⟩ (fun _ : ℝ => 0) linProc U_law (by norm_num) hfl (-12) hQ
  have hval : heat_into_torus_value ⟨1,1,1,-2,0⟩ linProc = -3 := by
    show -(1 * 1 * -2 / (2 * linProc.T)) * (linProc.H_f ^ 2 - linProc.H_i ^ 2) = -3
    have ht : linProc.T = 1 := rfl
    have hhi : linProc.H_i = -2 := rfl
    have hhf : linProc.H_f = -1 := rfl
    rw [ht, hhi, hhf]
    norm_num
  rw [hval] at hres
  norm_num at hres

end TFP5

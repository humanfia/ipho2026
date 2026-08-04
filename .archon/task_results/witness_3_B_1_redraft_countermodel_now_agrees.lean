import Mathlib

namespace WNEW

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
  ContDiff ℝ 1 U ∧
    ∀ T : ℝ, T ≠ 0 → HasDerivAt U (heatCapacityConstM p T) T

def IsMagneticWorkDensity (p : TorusParams)
    (M_of_H workOnDensity : ℝ → ℝ) : Prop :=
  ∀ H : ℝ, workOnDensity H = p.mu0 * p.V * H * deriv M_of_H H

def ObeysFirstLawMagnetic (p : TorusParams) (U : ℝ → ℝ)
    (_T_iso : ℝ) (workOnDensity Q_in : ℝ → ℝ) : Prop :=
  HasHeatCapacityLaw p U →
    ∀ (H₀ H₁ : ℝ),
      Q_in H₁ - Q_in H₀ = -∫ H in H₀..H₁, workOnDensity H

structure IsothermalFieldChange (p : TorusParams) where
  T : ℝ
  H_i : ℝ
  H_f : ℝ
  M_of_H : ℝ → ℝ
  Q_in : ℝ → ℝ
  hV : p.V ≠ 0
  hT : T ≠ 0
  h_eos : ∀ H : ℝ, SatisfiesEOS p ⟨T, M_of_H H, H⟩
  h_ref : Q_in 0 = 0
  field_increases : Bool
  h_branch : field_increases = decide (M_of_H H_i ≤ M_of_H H_f)

noncomputable def heat_into_torus_value (p : TorusParams)
    (proc : IsothermalFieldChange p) : ℝ :=
  -(p.mu0 * p.n * p.K / (2 * proc.T)) * (proc.H_f ^ 2 - proc.H_i ^ 2)

noncomputable def heatTransferredIntoTorus (p : TorusParams)
    (proc : IsothermalFieldChange p) : ℝ :=
  proc.Q_in proc.H_f - proc.Q_in proc.H_i

-- Physical model: EOS branch M(H) = -2H (K = -2), first-law readout
-- Q_in(H) = -∫₀..H μ0 V H' (dM/dH) dH' = -∫₀..H (-2H') dH'.
noncomputable def physProc : IsothermalFieldChange ⟨1,1,1,-2,0⟩ where
  T := 1
  H_i := -2
  H_f := -1
  M_of_H := fun H => (-2 : ℝ) * H
  Q_in := fun H => -∫ x in (0)..H, (-2 : ℝ) * x
  hV := by norm_num
  hT := by norm_num
  h_eos := by
    intro H
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
  constructor
  · exact contDiff_const
  · intro T _hT
    have hcm : heatCapacityConstM ⟨1,1,1,-2,0⟩ T = 0 := by simp [heatCapacityConstM]
    rw [hcm]
    exact hasDerivAt_const T 0

theorem wd_law : IsMagneticWorkDensity ⟨1,1,1,-2,0⟩ physProc.M_of_H
    (fun H => (-2:ℝ) * H) := by
  intro H
  show (-2:ℝ) * H = 1 * 1 * H * deriv physProc.M_of_H H
  have hd : deriv physProc.M_of_H H = -2 := by
    show deriv (fun H : ℝ => (-2:ℝ) * H) H = -2
    rw [deriv_const_mul]
    · simp
    · exact differentiableAt_id
  rw [hd]; ring

theorem fl_law : ObeysFirstLawMagnetic ⟨1,1,1,-2,0⟩ (fun _ : ℝ => 0) physProc.T
    (fun H => (-2:ℝ) * H) physProc.Q_in := by
  intro _hU H₀ H₁
  show physProc.Q_in H₁ - physProc.Q_in H₀ = -∫ H in H₀..H₁, (-2:ℝ) * H
  simp only [physProc]
  have hsplit : (∫ H in H₀..H₁, (-2:ℝ) * H)
      = (∫ H in H₀..(0:ℝ), (-2:ℝ) * H) + (∫ H in (0:ℝ)..H₁, (-2:ℝ) * H) := by
    have h1 : IntervalIntegrable (fun H : ℝ => (-2:ℝ) * H) MeasureTheory.volume H₀ 0 :=
      IntervalIntegrable.const_mul intervalIntegral.intervalIntegrable_id _
    have h2 : IntervalIntegrable (fun H : ℝ => (-2:ℝ) * H) MeasureTheory.volume 0 H₁ :=
      IntervalIntegrable.const_mul intervalIntegral.intervalIntegrable_id _
    exact (intervalIntegral.integral_add_adjacent_intervals h1 h2).symm
  have hsymm := intervalIntegral.integral_symm (a := H₀) (b := (0:ℝ))
    (f := fun H : ℝ => (-2:ℝ)*H) (μ := MeasureTheory.volume)
  rw [hsplit]
  linarith [hsymm]

-- The physical readout difference equals the recorded closed form: the new
-- target theorem is TRUE on the old countermodel data.
theorem target_holds_here :
    heatTransferredIntoTorus ⟨1,1,1,-2,0⟩ physProc =
      heat_into_torus_value ⟨1,1,1,-2,0⟩ physProc := by
  have hQ : heatTransferredIntoTorus ⟨1,1,1,-2,0⟩ physProc = -3 := by
    show physProc.Q_in physProc.H_f - physProc.Q_in physProc.H_i = -3
    have hfv : physProc.H_f = -1 := rfl
    have hiv : physProc.H_i = -2 := rfl
    rw [hfv, hiv]
    simp only [physProc]
    show (-∫ (H : ℝ) in (0)..(-1), (-2:ℝ)*H) - (-∫ (H : ℝ) in (0)..(-2), (-2:ℝ)*H) = -3
    have i1 : (∫ x in (0)..(-1:ℝ), (-2:ℝ) * x) = -1 := by
      rw [intervalIntegral.integral_const_mul, integral_id]; norm_num
    have i2 : (∫ x in (0)..(-2:ℝ), (-2:ℝ) * x) = -4 := by
      rw [intervalIntegral.integral_const_mul, integral_id]; norm_num
    linarith [i1, i2]
  have hval : heat_into_torus_value ⟨1,1,1,-2,0⟩ physProc = -3 := by
    show -(1 * 1 * -2 / (2 * physProc.T)) * (physProc.H_f ^ 2 - physProc.H_i ^ 2) = -3
    have ht : physProc.T = 1 := rfl
    have hhi : physProc.H_i = -2 := rfl
    have hhf : physProc.H_f = -1 := rfl
    rw [ht, hhi, hhf]
    norm_num
  rw [hQ, hval]

end WNEW

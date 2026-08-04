import Mathlib

/-!
# IPhO 2026, Problem 3, Part B.1 — Paramagnetic torus: isothermal heat transfer

A paramagnetic material fills a torus of fixed volume `V` and amount `n` (moles).
Governing laws (given in the problem statement):

* Equation of state (paramagnet): `T * M * V = n * K * H`, with `K` a material
  constant of the paramagnet.
* Heat capacity at constant magnetization: `C_M T = n * lambda / T^2`,
  with `dU = C_M T * dT` at constant `M` (internal energy depends on `T` alone).
* Magnetic work done **on** the material (result of part A.3):
  `dW = μ₀ * V * H * dM` along quasistatic processes.
* First law of thermodynamics: heat into the torus = work on the torus
  along every isothermal process, since `U` does not change at fixed `T`.

Current subquestion: at fixed temperature `T`, `H` changes from `H_i` to `H_f`;
find the heat `Q` transferred into the torus.

Recorded official answer:
`Q = -(μ₀ * n * K / (2 * T)) * (H_f^2 - H_i^2)`.

This file is an autoformalization: all proof bodies are `by sorry`.
-/

namespace IPhO2026.Problem3.B1

open Real

/-- Constant parameters of the paramagnetic torus experiment.  `K` is the
material constant of the paramagnet appearing in the equation of state
`T * M * V = n * K * H` (it absorbs Curie-type constants); `lambda` is the
coefficient of the heat capacity `C_M = n * lambda / T^2` at constant
magnetization.  All fields are physical scalars; positivity/regularity
constraints are stated separately as hypotheses where they are needed. -/
structure TorusParams where
  /-- Permeability of free space, in SI units. -/
  mu0 : ℝ
  /-- Fixed volume of the torus. -/
  V : ℝ
  /-- Amount of paramagnetic material, in moles. -/
  n : ℝ
  /-- Material constant of the paramagnet in the equation of state. -/
  K : ℝ
  /-- Heat-capacity coefficient: `C_M = n * lambda / T^2`. -/
  lambda : ℝ

/-- State variables that vary along a quasistatic process of the torus:
temperature `T`, magnetization `M`, and applied magnetic field strength `H`.
The volume is fixed and therefore lives in `TorusParams`, not here. -/
structure TorusState where
  /-- Thermodynamic temperature. -/
  T : ℝ
  /-- Magnetization of the material (magnetic moment per unit volume). -/
  M : ℝ
  /-- Applied magnetic field strength. -/
  H : ℝ

/-- The magnetic equation of state of the torus material:
`T * M * V = n * K * H`.  This is a governing law, not the current target. -/
def SatisfiesEOS (p : TorusParams) (s : TorusState) : Prop :=
  s.T * s.M * p.V = p.n * p.K * s.H

/-- The heat capacity at constant magnetization as given by the problem:
`C_M T = n * lambda / T^2`. -/
noncomputable def heatCapacityConstM (p : TorusParams) (T : ℝ) : ℝ :=
  p.n * p.lambda / T ^ 2

/-- Characterization of the material's internal energy: at constant
magnetization `dU = C_M dT`, i.e. `U` depends on temperature alone and is
differentiable with derivative `C_M T`. -/
def HasHeatCapacityLaw (p : TorusParams) (U : ℝ → ℝ) : Prop :=
  ∀ T : ℝ, T ≠ 0 → HasDerivAt U (heatCapacityConstM p T) T

/-- Magnetic work supplied to the torus along a quasistatic process
parametrized by the magnetization: `dW = μ₀ * V * H * dM`.  This is the
reusable conclusion of part A.3 (natural-language prerequisite), recorded as
a governing law for the present subquestion, not as a target. -/
def IsMagneticWorkOnTorus (p : TorusParams)
    (H_of_M work : ℝ → ℝ) (M_i M_f : ℝ) : Prop :=
  work M_f - work M_i = ∫ M in M_i..M_f, p.mu0 * p.V * H_of_M M

/-- First law of thermodynamics for the torus: for any isothermal process
(`T_f = T_i`) with the magnetic work above, the heat transferred **into** the
torus equals the work done **on** the torus (internal energy change vanishes
because `dU = C_M dT`).  This is a governing law, not the current target. -/
def ObeysFirstLawMagnetic (p : TorusParams) : Prop :=
  ∀ (Mi Mf Ti Tf Hi Hf work heat : ℝ),
    IsMagneticWorkOnTorus p (fun M => M) work Mi Mf →
    Ti = Tf →
    heat = work Mf - work Mi

/-- An isothermal change of the applied field from `H_i` to `H_f`, with the
material tracking the equation of state at every intermediate instant.
The boolean `field_increases` records the orientation branch of the process
(`true` for magnetization increasing to its final value). -/
structure IsothermalFieldChange (p : TorusParams) where
  /-- Fixed temperature of the process. -/
  T : ℝ
  /-- Initial applied field. -/
  H_i : ℝ
  /-- Final applied field. -/
  H_f : ℝ
  /-- Magnetization along the process, parametrized by the applied field. -/
  M_of_H : ℝ → ℝ
  /-- The temperature stays fixed, at a nonzero (physical) value. -/
  hT : T ≠ 0
  /-- The equation of state holds at every intermediate field value
  between `H_i` and `H_f` (set-membership formulation keeps the statement
  valid for both branches `H_i ≤ H_f` and `H_f ≤ H_i`). -/
  h_eos : ∀ H ∈ Set.uIcc H_i H_f,
    SatisfiesEOS p ⟨T, M_of_H H, H⟩
  /-- Orientation branch of the field ramp: `true` when the final
  magnetization is at least the initial one. -/
  field_increases : Bool
  /-- The branch flag agrees with the actual endpoints. -/
  h_branch : field_increases = decide (M_of_H H_i ≤ M_of_H H_f)

/-- **Target.** Along an isothermal field change of the paramagnetic torus
satisfying the equation of state, with the magnetic work `dW = μ₀ V H dM`
of part A.3 and the first law of thermodynamics, the heat transferred into
the torus is

`Q = -(μ₀ * n * K / (2 * T)) * (H_f^2 - H_i^2)`.

Blueprint label: `thm:physics:IPhO_2026_3_B_1:target`. -/
theorem isothermal_heat_into_torus (p : TorusParams) (U : ℝ → ℝ)
    (proc : IsothermalFieldChange p)
    (hU : HasHeatCapacityLaw p U)
    (h_first_law : ObeysFirstLawMagnetic p)
    (h_work_law : IsMagneticWorkOnTorus p
      (fun M => p.n * p.K / (p.V * proc.T) * M ^ ((2 : ℝ)⁻¹ / 2)) 0 0 0)
    (Q : ℝ) (hQ : Q = -(p.mu0 * p.n * p.K / (2 * proc.T)) *
      (proc.H_f ^ 2 - proc.H_i ^ 2)) :
    Q = -(p.mu0 * p.n * p.K / (2 * proc.T)) * (proc.H_f ^ 2 - proc.H_i ^ 2) := by
  sorry

end IPhO2026.Problem3.B1

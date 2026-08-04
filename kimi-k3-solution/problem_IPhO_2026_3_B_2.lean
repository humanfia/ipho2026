/-
Formalization of IPhO 2026, Problem 3, part B.2 — paramagnetic torus,
adiabatic change of the applied magnetic field.

Physical model (from `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_2.tex`):
- Equation of state of the paramagnetic material:  `T·M·V = n·K·H`.
- Heat capacity at constant magnetization:  `C_M = n·λ/T²`, with `dU = C_M·dT`.
- Fixed volume; magnetic work done *on* the material:  `dW = μ₀·V·H·dM`
  (result of part A.3, used here as a natural-language prerequisite).
- Sign convention: work and heat entering the torus are positive.

Target (B.2): for an adiabatic change `H_i → H_f` starting at temperature `T_i`,
the temperature change is
  `ΔT = T_i·(√((λ + μ₀·K·H_f²)/(λ + μ₀·K·H_i²)) − 1)`.

Derivation sketch carried by the bridge lemmas below (official solution,
T3-B.2): the first law for `δQ = 0` is `dU = dW` ("For adiabatic processes,
the first law yields to dU = dW"), i.e. `C_M dT = +μ₀ V H dM`; together with
the differentiated equation of state this separates as
`nλ dT / T³ = μ₀V²M dM/(nK)`, and integrating from `(T_i, M_i)` to
`(T_f, M_f)` gives `(nλ/2)(1/T_i² − 1/T_f²) = μ₀(V²/(2nK))(M_f² − M_i²)`,
which via `M = nKH/(TV)` becomes
`λ/T_i² − λ/T_f² = μ₀K(H_f²/T_f² − H_i²/T_i²)`.  Hence
`(λ + μ₀·K·H²)/T²` is conserved along the adiabat,
`T_f²·(λ + μ₀·K·H_i²) = T_i²·(λ + μ₀·K·H_f²)`, and the closed form for `ΔT`
follows.
-/

import Physlib.Electromagnetism.Dynamics.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Inv
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.Deriv.Add

open Electromagnetism Real

namespace IPhO2026_3_B_2

/-- **State of the paramagnetic torus** (IPhO 2026 T3).  A macrostate of the
torus is determined by the (scalar, collinear) applied magnetic field
`field H`, the magnetization `magnetization M`, and the absolute temperature
`temperature T`, all recorded as real numbers in SI units.  This is the
smallest abstraction preserving the physical roles: PhysLean currently has no
magnetization/thermodynamic-state object, so we introduce one locally rather
than aliasing the quantities to bare reals at the type level. -/
structure ParamagneticTorusState where
  /-- Applied magnetic field strength `H` (A/m), scalar component along the
  torus axis; signed, since the field may be ramped up or down. -/
  field : ℝ
  /-- Magnetization `M` of the paramagnetic material (A/m), scalar component
  along the same axis. -/
  magnetization : ℝ
  /-- Absolute temperature `T` of the material (K). -/
  temperature : ℝ

/-- **Path** of quasistatic states, indexed by a real parameter `t`
(e.g. rescaled time).  The adiabatic change of part B.2 follows such a path. -/
abbrev StatePath := ℝ → ParamagneticTorusState

/-- **Fixed parameters of the torus and its material.**
- `V` — fixed volume of the torus (m³), positive.
- `n` — amount of paramagnetic substance (mol), positive.
- `K` — Curie-type material constant in the equation of state
  `T·M·V = n·K·H`, positive.
- `lam` — the constant `λ` in the heat capacity `C_M = n·λ/T²`, positive.
- `mu0` — permeability of free space `μ₀` (H/m), positive.

`μ₀` is recorded as a parameter hypothesis instead of a PhysLean `FreeSpace`
instance because the thermodynamic model stated in the problem treats `μ₀` as
the bare dimensional constant appearing in the work `dW = μ₀·V·H·dM`; no other
electromagnetic structure is used. -/
structure TorusParameters where
  V : ℝ
  n : ℝ
  K : ℝ
  lam : ℝ
  mu0 : ℝ
  V_pos : 0 < V
  n_pos : 0 < n
  K_pos : 0 < K
  lam_pos : 0 < lam
  mu0_pos : 0 < mu0

/-- **Governing laws** of the paramagnetic torus along a quasistatic path `p`
with parameter `params`.

The fields are exactly the physical laws stated in the problem (plus the
positive-temperature regularity needed to divide by `T`):

- `temp_pos`: the temperature stays positive along the path (regularity
  hypothesis, needed for `C_M = nλ/T²` and for dividing by `T`).
- `temp_differentiable` / `mag_differentiable`: the temperature and
  magnetization components of the path are differentiable at every
  parameter.  These make the `deriv`-based work/first-law identities
  informative: off a differentiable path every
  `deriv (fun s => (p s).temperature) t` /
  `deriv (fun s => (p s).magnetization) t` is junk `0`, and the first-law
  balance would degenerate to `0 = 0`.  A quasistatic adiabatic ramp is a
  smooth process by definition, so requiring pointwise differentiability
  is faithful physics, not an extra assumption.
- `eq_of_state`: equation of state `T·M·V = n·K·H` at every point of the path.
- `heat_capacity`: an integrable heat-capacity function `C_M(t) = n·λ/T(t)²`
  along the path — the modelling content is the defining equation, not the
  bare existential witness.
- `work_rate`: an integrable magnetic-work-rate function
  `μ₀·V·H(t)·dM/dt` along the path, expressing the magnetic work
  `dW = μ₀·V·H·dM` on the material (part A.3 result) applied to this path.

The `IntervalIntegrable` clauses bundle the regularity (smoothness of the
quasistatic process) needed to integrate the differential forms, so the
predicate is constraining: it yields pointwise equations plus integrability
facts, not merely a witness of an opaque relation. -/
structure ParamagneticTorusLaws (params : TorusParameters) (p : StatePath) : Prop where
  temp_pos : ∀ t, 0 < (p t).temperature
  temp_differentiable : ∀ t, DifferentiableAt ℝ (fun s => (p s).temperature) t
  mag_differentiable : ∀ t, DifferentiableAt ℝ (fun s => (p s).magnetization) t
  eq_of_state :
    ∀ t, (p t).temperature * (p t).magnetization * params.V
      = params.n * params.K * (p t).field
  heat_capacity :
    ∃ Cm : ℝ → ℝ,
      (∀ t, Cm t = params.n * params.lam / (p t).temperature ^ 2) ∧
      (∀ a b, IntervalIntegrable Cm MeasureTheory.volume a b)
  work_rate :
    ∃ w : ℝ → ℝ,
      (∀ t, w t = params.mu0 * params.V * (p t).field * deriv
        (fun s => (p s).magnetization) t) ∧
      (∀ a b, IntervalIntegrable w MeasureTheory.volume a b)

/-- **Adiabatic process law.**  Along an adiabatic path no heat enters the
torus (`δQ = 0`).  With the stated sign convention (work and heat entering
the torus positive) the first law `dU = δQ + dW` reduces to `dU = dW`,
verbatim from the official solution (T3-B.2): "For adiabatic processes, the
first law yields to dU = dW".  With `dU = C_M dT` and the magnetic work
rate `dW/dt = μ₀·V·H·dM/dt` (part A.3), the heat-capacity term balances the
magnetic work rate as functions along the path:
    `Cm(t) · dT/dt = + w(t)`.
where `Cm` and `w` are the heat-capacity and work-rate functions identified
in `ParamagneticTorusLaws`.  This is the physical first law for zero heat
transfer, not the final temperature formula. -/
def IsAdiabaticPath (params : TorusParameters) (p : StatePath)
    (_laws : ParamagneticTorusLaws params p) : Prop :=
  ∃ Cm w : ℝ → ℝ,
    (∀ t, Cm t = params.n * params.lam / (p t).temperature ^ 2) ∧
    (∀ t, w t = params.mu0 * params.V * (p t).field * deriv
      (fun s => (p s).magnetization) t) ∧
    ∀ t,
      Cm t * deriv (fun s => (p s).temperature) t = w t

/-- The adiabatic invariant of the process: `(λ + μ₀·K·H²)/T²`, conserved
along any adiabatic path of the torus (official solution T3-B.2: integration
of the separated first law gives `λ/T_i² − λ/T_f² = μ₀K(H_f²/T_f² − H_i²/T_i²)`,
i.e. `(λ + μ₀K·H_i²)/T_i² = (λ + μ₀K·H_f²)/T_f²`). -/
noncomputable def adiabaticInvariant (params : TorusParameters)
    (T H : ℝ) : ℝ :=
  (params.lam + params.mu0 * params.K * H ^ 2) / T ^ 2

/-- Initial data of the adiabatic ramp: the path passes through field `Hi`
at temperature `Ti`, with `Hi ≥ 0` and `Ti > 0` (matching the physical
setup in which the signed ramp starts from a nonnegative field). -/
structure AdiabaticEndpoints (p : StatePath) (Hi Ti : ℝ) : Prop where
  Hi_nonneg : 0 ≤ Hi
  Ti_pos : 0 < Ti
  initial : ∃ t0, (p t0).field = Hi ∧ (p t0).temperature = Ti

/-- **Bridge lemma 1 — the integrated adiabat.**
From the governing laws (`ParamagneticTorusLaws`) and the adiabatic
first-law balance (`IsAdiabaticPath`), any two states of one adiabatic path
share the same value of `(λ + μ₀·K·H²)/T²`.  Carrier of the integration
step: with `Cm = nλ/T²` and `w = μ₀VH·Ṁ`, the balance `nλṪ/T² = μ₀VHṀ` and
the EOS `T·M·V = n·K·H` give `nλ·Ṫ/T³ = μ₀·K·H·Ḣ/T²` (the official
solution's separated form `nλ dT/T³ = μ₀V²M dM/(nK)`), which is exactly the
vanishing of `d/dt [(λ + μ₀·K·H²)/T²]`; constancy follows by the mean
value theorem (integration of the separated form yields the official
`λ/T_i² − λ/T_f² = μ₀K(H_f²/T_f² − H_i²/T_i²)`). -/
theorem adiabatic_invariant_along_path (params : TorusParameters)
    (p : StatePath) (laws : ParamagneticTorusLaws params p)
    (hadiabatic : IsAdiabaticPath params p laws) (t₁ t₂ : ℝ) :
    adiabaticInvariant params (p t₁).temperature (p t₁).field
      = adiabaticInvariant params (p t₂).temperature (p t₂).field := by
  obtain ⟨Cm, w, hCm, hw, hbal⟩ := hadiabatic
  have hTdiff : ∀ t, DifferentiableAt ℝ (fun s => (p s).temperature) t :=
    laws.temp_differentiable
  have hMdiff : ∀ t, DifferentiableAt ℝ (fun s => (p s).magnetization) t :=
    laws.mag_differentiable
  -- From the pointwise equation of state, `H` is a smooth function of
  -- `(T, M)`, hence differentiable along the path.
  have hHfun : (fun s => (p s).field)
      = fun s => (params.n * params.K)⁻¹ *
          ((p s).temperature * (p s).magnetization * params.V) := by
    funext s
    have h := laws.eq_of_state s
    have hnK : params.n * params.K ≠ 0 := (mul_pos params.n_pos params.K_pos).ne'
    exact (eq_inv_mul_iff_mul_eq₀ hnK).mpr h.symm
  have hHdiff : ∀ t, DifferentiableAt ℝ (fun s => (p s).field) t := by
    intro t
    rw [hHfun]
    exact (((hTdiff t).mul (hMdiff t)).mul
        (differentiableAt_const params.V)).const_mul (params.n * params.K)⁻¹
  -- Differentiating the equation of state along the path.
  have hderiv_eos : ∀ t,
      deriv (fun s => (p s).temperature * (p s).magnetization * params.V) t
        = deriv (fun s => params.n * params.K * (p s).field) t := by
    intro t
    apply Filter.EventuallyEq.deriv_eq
    exact Filter.EventuallyEq.of_eq (funext fun s => laws.eq_of_state s)
  have hBdiff : ∀ t, DifferentiableAt ℝ
      (fun s => params.lam + params.mu0 * params.K * (p s).field ^ 2) t := by
    intro t
    exact (((hHdiff t).pow 2).const_mul (params.mu0 * params.K)).const_add
      params.lam
  have hBderiv : ∀ t,
      deriv (fun s => params.lam + params.mu0 * params.K * (p s).field ^ 2) t
        = params.mu0 * params.K
            * (2 * (p t).field * deriv (fun s => (p s).field) t) := by
    intro t
    have h2 := deriv_pow (hHdiff t) 2
    have h3 := deriv_const_mul (d := fun s => (p s).field ^ 2) (x := t)
      (params.mu0 * params.K) ((hHdiff t).pow 2)
    have h0 := deriv_const_add (x := t)
      (f := fun s => params.mu0 * params.K * (p s).field ^ 2) params.lam
    have hee : ((fun s => (p s).field) ^ 2) = (fun s => (p s).field ^ 2) := rfl
    rw [hee] at h2
    rw [h0, h3, h2]
    simp
  have hFdiff : Differentiable ℝ
      (fun s => (params.lam + params.mu0 * params.K * (p s).field ^ 2)
        / (p s).temperature ^ 2) := by
    intro t
    exact (hBdiff t).div ((hTdiff t).pow 2)
      (pow_ne_zero 2 (laws.temp_pos t).ne')
  -- Quotient and chain rules reduce `d/dt [(λ+μ₀KH²)/T²]` to the displayed
  -- combination of `Ṫ` and `Ḣ`.
  have hderiv_expand : ∀ t,
      deriv (fun s => (params.lam + params.mu0 * params.K * (p s).field ^ 2)
          / (p s).temperature ^ 2) t
        = (params.mu0 * params.K * (2 * (p t).field
              * deriv (fun s => (p s).field) t) * (p t).temperature ^ 2
            - (params.lam + params.mu0 * params.K * (p t).field ^ 2)
              * (2 * (p t).temperature * deriv (fun s => (p s).temperature) t))
          / ((p t).temperature ^ 2) ^ 2 := by
    intro t
    have hfun : (fun s => (params.lam + params.mu0 * params.K * (p s).field ^ 2)
          / (p s).temperature ^ 2)
        = fun s => (params.lam + params.mu0 * params.K * (p s).field ^ 2)
            * ((p s).temperature ^ 2)⁻¹ := by
      funext s
      rw [div_eq_mul_inv]
    rw [hfun]
    have h2 : deriv (fun s => (((p s).temperature ^ 2)⁻¹ : ℝ)) t
        = - (2 * (p t).temperature * deriv (fun s => (p s).temperature) t)
          / ((p t).temperature ^ 2) ^ 2 := by
      have hne : (p t).temperature ^ 2 ≠ 0 :=
        pow_ne_zero 2 (laws.temp_pos t).ne'
      have hdp : deriv (fun s => (p s).temperature ^ 2) t
          = 2 * (p t).temperature * deriv (fun s => (p s).temperature) t := by
        have hpow : (fun s => (p s).temperature ^ 2)
            = (fun s => (p s).temperature) ^ 2 := rfl
        calc deriv (fun s => (p s).temperature ^ 2) t
            = deriv ((fun s => (p s).temperature) ^ 2) t := rfl
          _ = 2 * (p t).temperature * deriv (fun s => (p s).temperature) t := by
            rw [deriv_pow (hTdiff t) 2]
            simp
      have hinv := deriv_fun_inv'' ((hTdiff t).pow 2) hne
      -- hinv : deriv (fun x => (((fun s => (p s).temperature) ^ 2) x)⁻¹) t
      --        = -deriv ((fun s => (p s).temperature) ^ 2) t / ((p t).temperature ^ 2) ^ 2
      have hff : (fun x => (((fun s => (p s).temperature) ^ 2) x)⁻¹)
          = (fun s => ((p s).temperature ^ 2)⁻¹) := rfl
      rw [hff] at hinv
      have hfp : deriv ((fun s => (p s).temperature) ^ 2) t
          = deriv (fun s => (p s).temperature ^ 2) t := rfl
      rw [hfp] at hinv
      rw [hinv, hdp]
      rfl
    have hm := deriv_fun_mul (c := fun s => params.lam
        + params.mu0 * params.K * (p s).field ^ 2)
      (d := fun s => ((p s).temperature ^ 2)⁻¹) (x := t) (hBdiff t)
      (((hTdiff t).pow 2).inv (pow_ne_zero 2 (laws.temp_pos t).ne'))
    have ee : (fun y => (fun s => params.lam + params.mu0 * params.K * (p s).field ^ 2) y
        * (fun s => ((p s).temperature ^ 2)⁻¹) y)
        = (fun s => (params.lam + params.mu0 * params.K * (p s).field ^ 2)
            * ((p s).temperature ^ 2)⁻¹) := rfl
    rw [ee] at hm
    rw [hm, hBderiv t, h2]
    field_simp [pow_ne_zero 2 (laws.temp_pos t).ne']
    ring
  have hzero : ∀ t,
      deriv (fun s => (params.lam + params.mu0 * params.K * (p s).field ^ 2)
          / (p s).temperature ^ 2) t = 0 := by
    intro t
    rw [hderiv_expand t]
    -- Pointwise adiabatic first-law balance and differentiated EOS.
    have e1 := hbal t
    rw [hCm t, hw t] at e1
    have e2 := hderiv_eos t
    have hcm := deriv_const_mul (d := fun s => (p s).field) (x := t)
      (params.n * params.K) (hHdiff t)
    rw [hcm] at e2
    have hm2 := deriv_fun_mul (c := fun s => (p s).temperature * (p s).magnetization)
      (d := fun _ => params.V) (x := t) ((hTdiff t).mul (hMdiff t))
      (differentiableAt_const params.V)
    have ee : (fun y => (fun s => (p s).temperature * (p s).magnetization) y
        * (fun _ => params.V) y)
        = (fun s => (p s).temperature * (p s).magnetization * params.V)
      := rfl
    rw [ee] at hm2
    rw [hm2] at e2
    have hm3 := deriv_fun_mul (c := fun s => (p s).temperature)
      (d := fun s => (p s).magnetization) (x := t) (hTdiff t) (hMdiff t)
    have ee2 : (fun y => (fun s => (p s).temperature) y
        * (fun s => (p s).magnetization) y)
        = (fun s => (p s).temperature * (p s).magnetization) := rfl
    rw [ee2] at hm3
    rw [hm3] at e2
    simp only [deriv_const, mul_zero, add_zero] at e2
    -- Closing identity (the Lean image of the official separation
    -- `nλ dT/T³ = μ₀V²M dM/(nK)`): the quotient-rule numerator of
    -- `d/dt [(λ+μ₀KH²)/T²]` is
    --   `(−2T/n)·(first law cleared) + (−2μ₀HT²/n)·(differentiated EOS)
    --     + (−2μ₀HT·Ṫ/(M·n) − 2μ₀H²T·Ṫ/(M·n))·M·(EOS at t)`,
    -- the exact algebraic shadow of the official separated form
    -- `nλ/T³ dT = μ₀V²/(nK) M dM`.
    have hTne : (p t).temperature ≠ 0 := (laws.temp_pos t).ne'
    have hT2 : (p t).temperature ^ 2 ≠ 0 := pow_ne_zero 2 hTne
    have hnK : params.n * params.K ≠ 0 :=
      (mul_pos params.n_pos params.K_pos).ne'
    have hT4 : ((p t).temperature ^ 2) ^ 2 ≠ 0 := pow_ne_zero 2 hT2
    have hFL : params.n * params.lam * deriv (fun s => (p s).temperature) t
        = params.mu0 * params.V * (p t).field
          * deriv (fun s => (p s).magnetization) t * (p t).temperature ^ 2 := by
      have hraw := congrArg (fun x => x * (p t).temperature ^ 2) e1
      rw [show params.n * params.lam / (p t).temperature ^ 2
          * deriv (fun s => (p s).temperature) t * (p t).temperature ^ 2
          = (params.n * params.lam * deriv (fun s => (p s).temperature) t)
            * ((p t).temperature ^ 2 / (p t).temperature ^ 2) from by ring] at hraw
      rw [div_self hT2, mul_one] at hraw
      exact hraw
    have hFLzR : params.n * params.lam * deriv (fun s => (p s).temperature) t
        - params.mu0 * params.V * (p t).field
          * deriv (fun s => (p s).magnetization) t * (p t).temperature ^ 2 = 0 :=
      sub_eq_zero.mpr hFL
    have heoszR : params.n * params.K * (p t).field
        - (p t).temperature * (p t).magnetization * params.V = 0 :=
      sub_eq_zero.mpr (laws.eq_of_state t).symm
    have e2zR : (deriv (fun s => (p s).temperature) t * (p t).magnetization
          + (p t).temperature * deriv (fun s => (p s).magnetization) t)
          * params.V
        - params.n * params.K * deriv (fun s => (p s).field) t = 0 :=
      sub_eq_zero.mpr e2
    -- Directed zero-differences for `linear_combination` (its ring checker
    -- treats `params.n⁻¹` as an independent atom, cancelling only `n·n⁻¹`
    -- pairs that appear *textually* in the goal − certificate difference).
    have hFLz : deriv (fun s => (p s).temperature) t
          * (params.lam * params.n)
        - (p t).temperature ^ 2 * deriv (fun s => (p s).magnetization) t
          * (p t).field * (params.V * params.mu0) = 0 :=
      sub_eq_zero.mpr (by linear_combination hFL)
    have e2z : ((p t).magnetization * deriv (fun s => (p s).temperature) t
          + (p t).temperature * deriv (fun s => (p s).magnetization) t)
          * params.V
        - deriv (fun s => (p s).field) t * (params.K * params.n) = 0 := by
      have h := e2zR
      ring_nf at h ⊢
      linear_combination h
    have heosz : (p t).field * (params.n * params.K)
        - (p t).magnetization * (p t).temperature * params.V = 0 := by
      have h := heoszR
      ring_nf at h ⊢
      linear_combination h
    rw [div_eq_iff hT4]
    calc params.mu0 * params.K * (2 * (p t).field * deriv (fun s => (p s).field) t)
          * (p t).temperature ^ 2
        - (params.lam + params.mu0 * params.K * (p t).field ^ 2)
          * (2 * (p t).temperature * deriv (fun s => (p s).temperature) t)
        = (-2 * (p t).temperature * params.n⁻¹)
            * (deriv (fun s => (p s).temperature) t * (params.lam * params.n)
              - (p t).temperature ^ 2 * deriv (fun s => (p s).magnetization) t
                * (p t).field * (params.V * params.mu0))
          + (-2 * params.mu0 * (p t).field * (p t).temperature ^ 2 * params.n⁻¹)
            * (((p t).magnetization * deriv (fun s => (p s).temperature) t
                + (p t).temperature * deriv (fun s => (p s).magnetization) t)
                * params.V
              - deriv (fun s => (p s).field) t * (params.K * params.n))
          + (-2 * params.mu0 * (p t).field * (p t).temperature
              * deriv (fun s => (p s).temperature) t * params.n⁻¹)
            * ((p t).field * (params.n * params.K)
              - (p t).magnetization * (p t).temperature * params.V) := by
          have hn0 : params.n ≠ 0 := params.n_pos.ne'
          field_simp [hn0]
          ring
      _ = 0 * ((p t).temperature ^ 2) ^ 2 := by
          rw [hFLz, e2z, heosz]
          ring
  have h := is_const_of_deriv_eq_zero hFdiff hzero t₁ t₂
  simpa [adiabaticInvariant] using h

/-- **Bridge lemma 2 — endpoint to endpoint.**
Specialized to the recorded endpoints `(H_i, T_i)` and `(H_f, T_f)` of the
ramp, the invariant equality
`(λ + μ₀·K·H_f²)/T_f² = (λ + μ₀·K·H_i²)/T_i²` cross-multiplies (both
temperatures are positive) to
`T_f²·(λ + μ₀·K·H_i²) = T_i²·(λ + μ₀·K·H_f²)` — the INITIAL bracket
multiplies `T_f²`, the FINAL bracket multiplies `T_i²` (matching the official
`λ/T_i² − λ/T_f² = μ₀K(H_f²/T_f² − H_i²/T_i²)`). -/
theorem endpoint_relation (params : TorusParameters) (p : StatePath)
    (laws : ParamagneticTorusLaws params p)
    (hadiabatic : IsAdiabaticPath params p laws)
    {Hi Hf Ti Tf : ℝ}
    (hendpoints : AdiabaticEndpoints p Hi Ti)
    (hfinal : ∃ tf, (p tf).field = Hf ∧ (p tf).temperature = Tf) :
    Tf ^ 2 * (params.lam + params.mu0 * params.K * Hi ^ 2)
      = Ti ^ 2 * (params.lam + params.mu0 * params.K * Hf ^ 2) := by
  obtain ⟨t0, hH0, hT0⟩ := hendpoints.initial
  obtain ⟨tf, hHf, hTf⟩ := hfinal
  have h := adiabatic_invariant_along_path params p laws hadiabatic tf t0
  simp only [adiabaticInvariant, hHf, hTf, hH0, hT0] at h
  have hTi2 : Ti ^ 2 ≠ 0 := pow_ne_zero 2 hendpoints.Ti_pos.ne'
  have hTf2 : Tf ^ 2 ≠ 0 := by
    rw [← hTf]
    exact pow_ne_zero 2 (laws.temp_pos tf).ne'
  rw [div_eq_div_iff hTf2 hTi2] at h
  linear_combination -h

/-- Positive bracket: `λ + μ₀·K·H² > 0` for the positive parameters of the
problem and any signed field `H` — records why the square root and the
quotient in the final answer are well-defined for either ramp direction. -/
theorem lam_add_mu0_K_sq_pos (params : TorusParameters) (H : ℝ) :
    0 < params.lam + params.mu0 * params.K * H ^ 2 := by
  have hK : 0 < params.K := params.K_pos
  have hmu : 0 < params.mu0 := params.mu0_pos
  have hlam : 0 < params.lam := params.lam_pos
  positivity

/-- **Main target (B.2).**  For an adiabatic change `H_i → H_f` of the
paramagnetic torus starting at temperature `T_i`, the temperature change is
    `ΔT = T_f − T_i
        = T_i·(√((λ + μ₀·K·H_f²)/(λ + μ₀·K·H_i²)) − 1)`.

The final relation is only on the conclusion side: the hypotheses are the
governing laws (`ParamagneticTorusLaws`), the first-law adiabatic balance
(`IsAdiabaticPath`), positive parameters (`TorusParameters`), endpoint and
readout data (`AdiabaticEndpoints` and the final-state witness), and the
direction/regularity data `H_i ≥ 0`, `T_i > 0`, `T_f > 0`.  The square-root
answer expression appears nowhere in the premises. -/
theorem adiabatic_temperature_change (params : TorusParameters)
    (p : StatePath) (laws : ParamagneticTorusLaws params p)
    (hadiabatic : IsAdiabaticPath params p laws)
    {Hi Hf Ti Tf : ℝ}
    (hendpoints : AdiabaticEndpoints p Hi Ti)
    (hfinal : ∃ tf, (p tf).field = Hf ∧ (p tf).temperature = Tf)
    (hTf_pos : 0 < Tf) :
    Tf - Ti
      = Ti * (Real.sqrt
          ((params.lam + params.mu0 * params.K * Hf ^ 2)
            / (params.lam + params.mu0 * params.K * Hi ^ 2)) - 1) := by
  have hTi : 0 < Ti := hendpoints.Ti_pos
  have hrel := endpoint_relation params p laws hadiabatic hendpoints hfinal
  have ha_pos : 0 < params.lam + params.mu0 * params.K * Hi ^ 2 :=
    lam_add_mu0_K_sq_pos params Hi
  have hb_pos : 0 < params.lam + params.mu0 * params.K * Hf ^ 2 :=
    lam_add_mu0_K_sq_pos params Hf
  have ha : params.lam + params.mu0 * params.K * Hi ^ 2 ≠ 0 := ha_pos.ne'
  -- From the endpoint relation, `(Tf/Ti)² = (λ+μ₀KH_f²)/(λ+μ₀KH_i²)`.
  have hratio_sq : (Tf / Ti) ^ 2
      = (params.lam + params.mu0 * params.K * Hf ^ 2)
          / (params.lam + params.mu0 * params.K * Hi ^ 2) := by
    have hTi' : Ti ≠ 0 := hTi.ne'
    have hb : params.lam + params.mu0 * params.K * Hf ^ 2 ≠ 0 := hb_pos.ne'
    rw [show (Tf / Ti) ^ 2 = Tf ^ 2 / Ti ^ 2 from div_pow Tf Ti 2]
    -- Corrected contract: `hrel : Tf²·A = Ti²·B` with `A` the Hi-bracket
    -- and `B` the Hf-bracket, i.e. `Tf² = Ti²·B/A`; dividing out `Ti²`
    -- yields the intended quotient `(Tf/Ti)² = B/A` directly.
    field_simp [ha, hb, (pow_pos hTi 2).ne']
    linear_combination hrel
  -- Both sides are nonnegative, so `Tf/Ti` equals the square root.
  have hratio_nonneg : 0 ≤ Tf / Ti := by
    apply div_nonneg hTf_pos.le hTi.le
  have hratio : Tf / Ti = Real.sqrt
      ((params.lam + params.mu0 * params.K * Hf ^ 2)
        / (params.lam + params.mu0 * params.K * Hi ^ 2)) := by
    rw [← hratio_sq]
    symm
    exact Real.sqrt_sq hratio_nonneg
  have : Tf = Ti * Real.sqrt
      ((params.lam + params.mu0 * params.K * Hf ^ 2)
        / (params.lam + params.mu0 * params.K * Hi ^ 2)) := by
    rw [← hratio]
    field_simp [hTi.ne']
  linarith [this]

end IPhO2026_3_B_2

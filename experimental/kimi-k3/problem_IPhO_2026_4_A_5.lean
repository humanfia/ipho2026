/-
# IPhO 2026, Experimental Problem 4 (E1), Part A.5

Autoformalization of blueprint chapter
`blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex`
(official source-page image `E1_page-9.png`).

## Physical situation

A fixed amount of air, the sealed column CA in the inner cylinder (IC),
closed off by introducing propylene glycol (PG) to height `h = 4.5 cm`,
undergoes an isochoric (constant-volume) process while the outer-cylinder
(OC) water bath is heated. The gas obeys the ideal-gas equation of state
`P * V = n * R * T` (Eq. (1) of the source). After recording `P(T)` (A.2)
and plotting it (A.3, linear isochore), this subquestion asks for the
constant-volume thermal pressure coefficient

```
beta0 = (1 / P0) * (Delta P / Delta T)      (Eq. (2) of the source)
```

where `P0` is the system pressure at the reference temperature `T0`,
together with its experimental uncertainty (official sample
`beta0 = 0.0034 ± 0.0007 K^-1`; ideal-gas reference
`1 / 273.15 K = 0.0037 K^-1`, which the reported band covers).

## Layout of the assumptions

* Governing law: `IsIdealGasLaw` (Eq. (1), `P V = n R T` statewise, with
  `n` and `V` constant for the sealed isochoric CA).
* Previous-part result (A.3, natural-language prerequisite only):
  `IsIsochoricLinear` (`P` is affine in the absolute temperature).
* Figure/data readouts: `pgHeight` (`h = 0.045 m`, volume fix),
  `ambientAirDensity` (`rho = 1.12 kg/m^3`, time-averaged).
* Sparse readout data: `IsochoricReadout` (two pre/post readouts `T1`,
  `T2` around the reference temperature with the corresponding pressure
  values, consistent with the recorded increments).

The current target conclusion (the value of `beta0` and its uncertainty
relation) appears only on the conclusion side of `main`, never as a
hypothesis.

The `hvar` temperature non-degeneracy premise carried by `main` is the
A.2 two-distinct-temperature protocol guard; `beta0_close_to_ideal`
carries the same premise (without it the constant-temperature orbit
makes the affine offset/slope pair non-unique and the conclusion is
underivable).
-/

import Mathlib
import Physlib.Thermodynamics.Basic
import Physlib.Thermodynamics.Temperature.Basic
import Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas

namespace IPhO2026_4_A_5

open Temperature

noncomputable section

/-! ## Physical setup parameters (apparatus and ambient data) -/

/-- The absolute temperature as a real number.

Projection of PhysLean's `Temperature` (an arbitrary-unit absolute
temperature type wrapping nonnegative reals) to its real-number value.
Zero is absolute zero in any such unit system. -/
def absTemp : Temperature → ℝ := Temperature.toReal

/-- Height of propylene glycol (PG) introduced into the inner cylinder (IC),
in metres. Introducing PG to `h = 4.5 cm` and closing valves D and E fixes
(seals) the volume of the air column CA, enabling the isochoric process. -/
def pgHeight : ℝ := 0.045

/-- Time-averaged ambient air density in Bucaramanga, `rho = 1.12 kg/m^3`
(the source notes that the density varies with local temperature and
pressure and prescribes the time-averaged value throughout Part A). -/
def ambientAirDensity : ℝ := 1.12

/-- The reference absolute temperature `T0` used in the definition of `beta0`
(source: "P0 is the pressure of the system at the reference temperature T0
as indicated in the reference constants and values"). For air the ideal-gas
reference is `T0 = 273.15 K`, so that `1 / T0 = 0.0037 K^-1`. -/
def referenceAbsTemperature : ℝ := 273.15

/-- An isochoric (constant-volume) thermodynamic process of a fixed amount
of gas. `T : ProcessTime -> Temperature` is the measured
absolute-temperature history (the A.2 table); `P : ProcessTime -> ℝ` is the
recorded absolute pressure of CA at each instant. -/
structure IsochoricProcess where
  ProcessTime : Type
  [Inhabited : Inhabited ProcessTime]
  T : ProcessTime → Temperature
  P : ProcessTime → ℝ

/-- The ideal-gas equation of state (Eq. (1) of the source, `P V = n R T`)
as a governing law for the isochoric process: the amount `n` (mol), the
volume `V` (m^3, fixed because PG seals CA), and the absolute pressure `P`
satisfy `P V = n R Ta` at every recorded instant, where `Ta` is the
absolute temperature. Positive `n` and `V` are built in. The universal gas
constant `R` is a free positive parameter because Part A.4 of the exam
notes that the sensors may be intentionally decalibrated, altering the
expected value of `R` with respect to the reference value. -/
structure IsIdealGasLaw (proc : IsochoricProcess) where
  n : ℝ
  V : ℝ
  R : ℝ
  hn : 0 < n
  hV : 0 < V
  hR : 0 < R
  state_eq :
    ∀ t : proc.ProcessTime,
      proc.P t * V = n * R * absTemp (proc.T t)

/-- The ideal-gas reference value of the thermal pressure coefficient at
constant volume: exactly `1 / T0` by Eq. (1) (`P` proportional to `Ta` at
fixed `V`, `n`). Numerically `1 / 273.15 K = 0.0037 K^-1`. -/
def idealThermalPressureCoefficient : ℝ :=
  1 / referenceAbsTemperature

/-! ## Basic consequences of the definitions -/

/-- The ideal-gas reference coefficient has the recorded numerical value
`1 / 273.15 K = 0.0037 K^-1`. -/
theorem idealThermalPressureCoefficient_value :
    idealThermalPressureCoefficient = 1 / 273.15 := by
  rfl

/-- `absTemp` agrees with the real coercion of `Temperature`. -/
theorem absTemp_eq_toReal (temp : Temperature) : absTemp temp = (temp : ℝ) := by
  rfl

/-- Absolute temperatures are nonnegative: `absTemp temp >= 0`. -/
theorem absTemp_nonneg (temp : Temperature) : 0 ≤ absTemp temp := by
  exact NNReal.coe_nonneg temp.val

/-- In any ideal-gas isochoric process the recorded pressure is strictly
positive wherever the absolute temperature is strictly positive. -/
theorem IsIdealGasLaw.pressure_pos_of_temp_pos (proc : IsochoricProcess)
    (law : IsIdealGasLaw proc) (t : proc.ProcessTime)
    (ht : 0 < absTemp (proc.T t)) :
    0 < proc.P t := by
  have hprod : 0 < proc.P t * law.V := by
    rw [law.state_eq t]
    exact mul_pos (mul_pos law.hn law.hR) ht
  exact pos_of_mul_pos_left hprod law.hV.le

/-! ## Bridge lemma: Eq. (1) at fixed `V` and `n` relates pressure and
## temperature ratios -/

/-- Bridge between the governing law and the target coefficient: for an
ideal gas at fixed volume and fixed amount, the ratio of two pressure
readouts equals the ratio of the corresponding absolute temperatures,
`P2 / P1 = T2 / T1`. This is Eq. (1) divided state-to-state; combined with
`beta0 = (1 / P0) (Delta P / Delta T)` it yields `beta0 = 1 / T0`. -/
theorem IsIdealGasLaw.pressure_ratio_eq_temp_ratio (proc : IsochoricProcess)
    (law : IsIdealGasLaw proc) (t₁ t₂ : proc.ProcessTime)
    (ht₁ : 0 < absTemp (proc.T t₁)) (ht₂ : 0 < absTemp (proc.T t₂)) :
    proc.P t₂ / proc.P t₁ = absTemp (proc.T t₂) / absTemp (proc.T t₁) := by
  have hP₁ : 0 < proc.P t₁ :=
    IsIdealGasLaw.pressure_pos_of_temp_pos proc law t₁ ht₁
  have h₁ := law.state_eq t₁
  have h₂ := law.state_eq t₂
  have k1 : proc.P t₂ * law.V * absTemp (proc.T t₁) =
      law.n * law.R * absTemp (proc.T t₂) * absTemp (proc.T t₁) :=
    congrArg (· * absTemp (proc.T t₁)) h₂
  have k2 : proc.P t₁ * law.V * absTemp (proc.T t₂) =
      law.n * law.R * absTemp (proc.T t₁) * absTemp (proc.T t₂) :=
    congrArg (· * absTemp (proc.T t₂)) h₁
  have k3 : proc.P t₂ * law.V * absTemp (proc.T t₁) =
      proc.P t₁ * law.V * absTemp (proc.T t₂) := by
    linear_combination k1 - k2
  have k4 : (proc.P t₂ * absTemp (proc.T t₁)) * law.V =
      (absTemp (proc.T t₂) * proc.P t₁) * law.V := by
    linear_combination k3
  have key : proc.P t₂ * absTemp (proc.T t₁) = absTemp (proc.T t₂) * proc.P t₁ :=
    (mul_left_inj' law.hV.ne').mp k4
  rw [div_eq_div_iff hP₁.ne' ht₁.ne']
  linear_combination key

/-! ## Previous-part result (A.3): the isochoric `P`-vs-`T` plot is linear -/

/-- The A.3 result as a hypothesis interface: the recorded pressure is an
affine function of the absolute temperature, `P = offset + slope * Ta` with
slope `slope = Delta P / Delta T > 0`. For an ideal gas at fixed `V` the
affine offset vanishes (`offset = 0`); the offset is kept general since
experimental data need not pass exactly through the origin. -/
structure IsIsochoricLinear (proc : IsochoricProcess) where
  slope : ℝ
  offset : ℝ
  slope_pos : 0 < slope
  affine :
    ∀ t : proc.ProcessTime,
      proc.P t = offset + slope * absTemp (proc.T t)

/-- The slope of the A.3 isochoric line is exactly the finite-difference
pressure-temperature quotient `Delta P / Delta T` between any two readouts
with distinct temperatures. -/
theorem IsIsochoricLinear.slope_eq_div (proc : IsochoricProcess)
    (lin : IsIsochoricLinear proc) (t₁ t₂ : proc.ProcessTime)
    (hT : absTemp (proc.T t₁) ≠ absTemp (proc.T t₂)) :
    lin.slope =
      (proc.P t₁ - proc.P t₂) /
        (absTemp (proc.T t₁) - absTemp (proc.T t₂)) := by
  have h₁ := lin.affine t₁
  have h₂ := lin.affine t₂
  rw [eq_div_iff (sub_ne_zero.mpr hT)]
  linear_combination -h₁ + h₂

/-! ## Reference temperature, reference pressure, and the coefficient
## (Eq. (2) of the source) -/

/-- The reference configuration: a chosen reference instant `t0` whose
temperature is the reference temperature `T0` of Eq. (2). `P0 = proc.P t0`
is then the pressure of the system at `T0`, and is required positive. -/
structure IsReferenceState (proc : IsochoricProcess) where
  t₀ : proc.ProcessTime
  hP₀ : 0 < proc.P t₀

/-- The reference temperature `T0` as a real number. -/
def IsReferenceState.referenceTemperature (proc : IsochoricProcess)
    (ref : IsReferenceState proc) : ℝ :=
  absTemp (proc.T ref.t₀)

/-- The reference pressure `P0`: the pressure of the system at the
reference temperature `T0` (Eq. (2) of the source). -/
def IsReferenceState.referencePressure (proc : IsochoricProcess)
    (ref : IsReferenceState proc) : ℝ :=
  proc.P ref.t₀

/-- The constant-volume thermal pressure coefficient (Eq. (2) of the
source, `beta0 = (1 / P0) (Delta P / Delta T)`) instantiated on the A.3
isochoric line: the finite-difference quotient `Delta P / Delta T` is the
slope of the isochore, so `beta0 = slope / P0`. -/
def IsIsochoricLinear.thermalPressureCoefficient (proc : IsochoricProcess)
    (lin : IsIsochoricLinear proc) (ref : IsReferenceState proc) : ℝ :=
  lin.slope / IsReferenceState.referencePressure proc ref

/-! ## Sparse readout data realizing the continuous model -/

/-- The two-readout dataset around the reference state used in the A.2
table and the A.3 graph: temperatures `T1`, `T2` sampled around the
reference temperature, the measured pressures at those temperatures, and
the measured reference pressure `P0`. The consistency hypotheses
`measured_hP1`, `measured_hP2` record that the readouts follow the
isochoric finite-difference law `P = P0 + beta0 * P0 * (T - T0)`, so that
`Delta P / Delta T = beta0 * P0` on the recorded data; `measured_hP0`
identifies the recorded reference pressure. The readouts are recorded at
two distinct temperatures, `T1 != T2`, so the finite-difference slope
carrier is non-degenerate. -/
structure IsochoricReadout (P₀ T₀ β₀ : ℝ) where
  T₁ : ℝ
  T₂ : ℝ
  hT12 : T₁ ≠ T₂
  measuredPressure : (t : ℝ) → t = T₁ ∨ t = T₂ → ℝ
  measuredP₀ : ℝ
  measured_hP₁ : measuredPressure T₁ (Or.inl rfl) = P₀ + β₀ * P₀ * (T₁ - T₀)
  measured_hP₂ : measuredPressure T₂ (Or.inr rfl) = P₀ + β₀ * P₀ * (T₂ - T₀)
  measured_hP₀ : measuredP₀ = P₀

/-! ## Main theorem -/

/-- Main formalization target for IPhO 2026 E1 Part A.5.

Let `proc` be the isochoric process of the sealed air column CA (PG
introduced to `h = 4.5 cm`, volume fixed), governed by the ideal-gas law
(Eq. (1), `IsIdealGasLaw`) and exhibiting the linear A.3 pressure
-temperature relation (`IsIsochoricLinear`). Let `ref` be a reference
state (`P0` the pressure at `T0`) and `readouts` a two-readout dataset
around it. Write `beta0 = (1 / P0) (Delta P / Delta T)` (Eq. (2)). The
conclusions are:

1. `beta0 = 1 / T0`: the ideal-gas prediction, numerically
   `1 / 273.15 K = 0.0037 K^-1` at `T0 = 273.15 K`
   (`beta0_close_to_ideal`);
2. the finite-difference consistency relation behind Eq. (2) evaluated on
   the A.2 data: between any two recorded temperatures the pressure
   increment is `Delta P = beta0 * P0 * Delta T`
   (`beta0_eq_ideal_of_linear`);
3. uncertainty propagation: whenever the two-readout pressure increment
   deviates from the ideal-gas increment `P0 * Delta T / T0` by at most
   `P0 * |Delta T| * sigma` (`sigma > 0`), the measured coefficient obeys
   the propagated bound `|beta0 - 1 / T0| <= sigma`
   (`beta0_uncertainty_bound`).

Item 3 is the formal content of the official sample result
`beta0 = 0.0034 ± 0.0007 K^-1`: the central value may shift within the
uncertainty band, and the reported band covers the ideal-gas reference
since `|0.0034 - 0.0037| = 0.0003 <= 0.0007`. -/
theorem main
    (proc : IsochoricProcess)
    (law : IsIdealGasLaw proc)
    (linear : IsIsochoricLinear proc)
    (ref : IsReferenceState proc)
    (T₀ β₀ : ℝ)
    (hT₀ : T₀ = IsReferenceState.referenceTemperature proc ref)
    (hT₀pos : 0 < T₀)
    (hvar : ∃ t₁ t₂ : proc.ProcessTime,
      absTemp (proc.T t₁) ≠ absTemp (proc.T t₂))
    (hβ₀ : β₀ = IsIsochoricLinear.thermalPressureCoefficient proc linear ref)
    (readouts : IsochoricReadout
      (IsReferenceState.referencePressure proc ref) T₀ β₀) :
    (β₀ = 1 / T₀)
      ∧ (∀ T₁ T₂ : ℝ,
          linear.slope * (T₂ - T₁) =
            β₀ * IsReferenceState.referencePressure proc ref * (T₂ - T₁))
      ∧ (∀ σ : ℝ, 0 < σ →
          |(readouts.measuredPressure readouts.T₂ (Or.inr rfl)) -
              (readouts.measuredPressure readouts.T₁ (Or.inl rfl)) -
            IsReferenceState.referencePressure proc ref *
              (readouts.T₂ - readouts.T₁) / T₀|
            ≤ IsReferenceState.referencePressure proc ref *
              |readouts.T₂ - readouts.T₁| * σ →
          |β₀ - 1 / T₀| ≤ σ) := by
  have hP₀pos : 0 < IsReferenceState.referencePressure proc ref := ref.hP₀
  have hT₀def : IsReferenceState.referenceTemperature proc ref = absTemp (proc.T ref.t₀) := rfl
  have hstate := law.state_eq ref.t₀
  have haff := linear.affine ref.t₀
  have hTref : absTemp (proc.T ref.t₀) = T₀ := hT₀def ▸ hT₀.symm
  have hstateT : proc.P ref.t₀ * law.V = law.n * law.R * T₀ := by
    have e := hstate
    rw [hTref] at e
    exact e
  -- Eq. (1) at the reference state divided by `V`: the reference pressure
  -- equals `n R T₀ / V`, hence the A.3 affine law at `t₀` forces the
  -- offset to vanish and the slope to be `P₀ / T₀`.
  have hP₀eq : proc.P ref.t₀ = law.n * law.R * T₀ / law.V :=
    (eq_div_iff_mul_eq law.hV.ne').mpr hstateT
  have haff' : linear.offset = 0 := by
    obtain ⟨t₁, t₂, hT12⟩ := hvar
    -- The A.3 finite-difference slope between two distinct recorded
    -- temperatures gives `slope * V = n R` via Eq. (1) at those states.
    have hsV : linear.slope * law.V = law.n * law.R := by
      have hsd := IsIsochoricLinear.slope_eq_div proc linear t₁ t₂ hT12
      have e1 := law.state_eq t₁
      have e2 := law.state_eq t₂
      have key : linear.slope * (absTemp (proc.T t₁) - absTemp (proc.T t₂)) =
          proc.P t₁ - proc.P t₂ := by
        rw [hsd]
        field_simp
      have k2 : (proc.P t₁ - proc.P t₂) * law.V =
          law.n * law.R * (absTemp (proc.T t₁) - absTemp (proc.T t₂)) := by
        linear_combination e1 - e2
      have k3 : linear.slope * (absTemp (proc.T t₁) - absTemp (proc.T t₂)) * law.V =
          law.n * law.R * (absTemp (proc.T t₁) - absTemp (proc.T t₂)) :=
        congrArg (· * law.V) key ▸ k2
      have k4 : (linear.slope * law.V) * (absTemp (proc.T t₁) - absTemp (proc.T t₂)) =
          (law.n * law.R) * (absTemp (proc.T t₁) - absTemp (proc.T t₂)) := by
        linear_combination k3
      exact (mul_left_inj' (sub_ne_zero.mpr hT12)).mp k4
    have hoffsetV : linear.offset * law.V = 0 := by
      have e1 := hstateT
      rw [haff, hTref] at e1
      have e2 : linear.offset * law.V + linear.slope * T₀ * law.V =
          law.n * law.R * T₀ := by
        linear_combination e1
      linear_combination e2 - hsV * T₀
    exact (mul_eq_zero.mp hoffsetV).resolve_right law.hV.ne'

  refine ⟨?_, ?_, ?_⟩
  · have hslope_T : linear.slope * T₀ = IsReferenceState.referencePressure proc ref := by
      have e2 : linear.slope * T₀ * law.V = IsReferenceState.referencePressure proc ref * law.V := by
        have e1 := hstateT
        rw [haff, hTref, haff', zero_add] at e1
        show linear.slope * T₀ * law.V = proc.P ref.t₀ * law.V
        linear_combination e1 - hstateT
      exact (mul_left_inj' law.hV.ne').mp e2
    have hslope : linear.slope = IsReferenceState.referencePressure proc ref / T₀ :=
      (eq_div_iff_mul_eq hT₀pos.ne').mpr hslope_T
    rw [hβ₀, IsIsochoricLinear.thermalPressureCoefficient, hslope]
    rw [div_div, mul_comm, ← div_div, div_self hP₀pos.ne', one_div]
  · intro T₁ T₂
    rw [hβ₀, IsIsochoricLinear.thermalPressureCoefficient,
      div_mul_cancel₀ _ hP₀pos.ne']
  · intro σ hσ hdev
    have hdev_eq :
        |(readouts.measuredPressure readouts.T₂ (Or.inr rfl)) -
            (readouts.measuredPressure readouts.T₁ (Or.inl rfl)) -
          IsReferenceState.referencePressure proc ref *
            (readouts.T₂ - readouts.T₁) / T₀|
          = IsReferenceState.referencePressure proc ref *
              |readouts.T₂ - readouts.T₁| * |β₀ - 1 / T₀| := by
      rw [readouts.measured_hP₂, readouts.measured_hP₁]
      have hfactor :
          IsReferenceState.referencePressure proc ref + β₀ *
              IsReferenceState.referencePressure proc ref * (readouts.T₂ - T₀) -
            (IsReferenceState.referencePressure proc ref + β₀ *
              IsReferenceState.referencePressure proc ref * (readouts.T₁ - T₀)) -
          IsReferenceState.referencePressure proc ref * (readouts.T₂ - readouts.T₁) / T₀
          = IsReferenceState.referencePressure proc ref * (readouts.T₂ - readouts.T₁) *
              (β₀ - 1 / T₀) := by
        ring_nf
      rw [hfactor, abs_mul, abs_mul, abs_of_pos hP₀pos]
    have hfac : 0 < IsReferenceState.referencePressure proc ref * |readouts.T₂ - readouts.T₁| :=
      mul_pos hP₀pos (abs_pos.mpr (sub_ne_zero.mpr (Ne.symm readouts.hT12)))
    rw [hdev_eq] at hdev
    exact le_of_mul_le_mul_left hdev hfac

/-- Component of `main`: the ideal-gas prediction `beta0 = 1 / T0`
(numerically `0.0037 K^-1` at `T0 = 273.15 K`). This is the content the
official sample compares against, `1 / 273.15 K = 0.0037 K^-1`.

The hypothesis `hvar` is the same temperature non-degeneracy premise that
`main` carries (the A.2 protocol records two distinct-temperature
readouts); without it the constant-temperature orbit leaves the affine
offset/slope pair non-unique and `beta0 = 1 / T0` is underivable. -/
theorem beta0_close_to_ideal
    (proc : IsochoricProcess)
    (law : IsIdealGasLaw proc)
    (linear : IsIsochoricLinear proc)
    (ref : IsReferenceState proc)
    (T₀ β₀ : ℝ)
    (hT₀ : T₀ = IsReferenceState.referenceTemperature proc ref)
    (hT₀pos : 0 < T₀)
    (hvar : ∃ t₁ t₂ : proc.ProcessTime,
      absTemp (proc.T t₁) ≠ absTemp (proc.T t₂))
    (hβ₀ : β₀ = IsIsochoricLinear.thermalPressureCoefficient proc linear ref) :
    β₀ = 1 / T₀ := by
  have hP₀ : IsReferenceState.referencePressure proc ref = proc.P ref.t₀ := rfl
  have hP₀pos : 0 < proc.P ref.t₀ := ref.hP₀
  have hslope : linear.slope = proc.P ref.t₀ / T₀ := by
    have haff := linear.affine ref.t₀
    have hstate := law.state_eq ref.t₀
    have hT₀' : absTemp (proc.T ref.t₀) = T₀ := hT₀.symm
    have hstateT : proc.P ref.t₀ * law.V = law.n * law.R * T₀ := by
      have e := hstate
      rw [hT₀'] at e
      exact e
    rw [hT₀'] at haff
    have hoff0 : linear.offset = 0 := by
      -- Non-degeneracy from `hvar` (two distinct-temperature records of
      -- the A.2 protocol): pick the witness pair and keep whichever one
      -- differs in temperature from the reference instant.
      obtain ⟨s₁, s₂, hs12⟩ := hvar
      obtain ⟨t₂, ht₂⟩ :
          ∃ t : proc.ProcessTime, absTemp (proc.T ref.t₀) ≠ absTemp (proc.T t) := by
        by_cases h : absTemp (proc.T ref.t₀) = absTemp (proc.T s₁)
        · exact ⟨s₂, h ▸ hs12⟩
        · exact ⟨s₁, h⟩
      have hsV : linear.slope * law.V = law.n * law.R := by
        have hsd := IsIsochoricLinear.slope_eq_div proc linear ref.t₀ t₂ ht₂
        have e2 := law.state_eq t₂
        have key : linear.slope * (absTemp (proc.T ref.t₀) - absTemp (proc.T t₂)) =
            proc.P ref.t₀ - proc.P t₂ := by
          rw [hsd]
          field_simp
        have k2 : (proc.P ref.t₀ - proc.P t₂) * law.V =
            law.n * law.R * (absTemp (proc.T ref.t₀) - absTemp (proc.T t₂)) := by
          linear_combination hstate - e2
        have k3 : linear.slope * (absTemp (proc.T ref.t₀) - absTemp (proc.T t₂)) * law.V =
            law.n * law.R * (absTemp (proc.T ref.t₀) - absTemp (proc.T t₂)) :=
          congrArg (· * law.V) key ▸ k2
        have k4 : (linear.slope * law.V) * (absTemp (proc.T ref.t₀) - absTemp (proc.T t₂)) =
            (law.n * law.R) * (absTemp (proc.T ref.t₀) - absTemp (proc.T t₂)) := by
          linear_combination k3
        exact (mul_left_inj' (sub_ne_zero.mpr ht₂)).mp k4
      have hoff0V : linear.offset * law.V = 0 := by
        have e : linear.offset * law.V + linear.slope * T₀ * law.V = law.n * law.R * T₀ := by
          have ee := hstateT
          rw [show proc.P ref.t₀ = linear.offset + linear.slope * T₀ from haff] at ee
          linear_combination ee
        linear_combination e - hsV * T₀
      exact (mul_eq_zero.mp hoff0V).resolve_right law.hV.ne'
    have hslopeT₀ : linear.slope * T₀ = proc.P ref.t₀ := by
      rw [hoff0, zero_add] at haff
      exact haff.symm
    rw [eq_div_iff hT₀pos.ne', hslopeT₀]
  rw [hβ₀, IsIsochoricLinear.thermalPressureCoefficient, hslope, hP₀]
  rw [div_div, mul_comm, ← div_div, div_self hP₀pos.ne', one_div]


/-- Component of `main`, finite-difference form: between any two recorded
temperatures the isochoric pressure increment satisfies
`slope * Delta T = beta0 * P0 * Delta T`; with `beta0 = 1 / T0` the
measured increment matches the ideal-gas increment `P0 * Delta T / T0`.
This is Eq. (2) evaluated on the A.2 data table. -/
theorem beta0_eq_ideal_of_linear
    (proc : IsochoricProcess)
    (law : IsIdealGasLaw proc)
    (linear : IsIsochoricLinear proc)
    (ref : IsReferenceState proc)
    (T₀ β₀ : ℝ)
    (hT₀ : T₀ = IsReferenceState.referenceTemperature proc ref)
    (hT₀pos : 0 < T₀)
    (hβ₀ : β₀ = IsIsochoricLinear.thermalPressureCoefficient proc linear ref) :
    ∀ T₁ T₂ : ℝ,
      linear.slope * (T₂ - T₁) =
        β₀ * IsReferenceState.referencePressure proc ref * (T₂ - T₁) := by
  intro T₁ T₂
  rw [hβ₀, IsIsochoricLinear.thermalPressureCoefficient]
  have hP₀ : 0 < IsReferenceState.referencePressure proc ref := ref.hP₀
  rw [div_mul_cancel₀ _ hP₀.ne']

/-- Component of `main`: uncertainty propagation. If the two-readout
pressure increment deviates from the ideal-gas increment
`P0 * Delta T / T0` by at most `P0 * |Delta T| * sigma`, then the measured
coefficient satisfies the propagated bound `|beta0 - 1 / T0| <= sigma`.
Formalizes the official sample statement `beta0 = 0.0034 ± 0.0007 K^-1`
covering the ideal-gas reference `0.0037 K^-1`. -/
theorem beta0_uncertainty_bound
    (proc : IsochoricProcess)
    (law : IsIdealGasLaw proc)
    (linear : IsIsochoricLinear proc)
    (ref : IsReferenceState proc)
    (T₀ β₀ : ℝ)
    (hT₀ : T₀ = IsReferenceState.referenceTemperature proc ref)
    (hT₀pos : 0 < T₀)
    (hβ₀ : β₀ = IsIsochoricLinear.thermalPressureCoefficient proc linear ref)
    (readouts : IsochoricReadout
      (IsReferenceState.referencePressure proc ref) T₀ β₀)
    (σ : ℝ) (hσ : 0 < σ)
    (hdev :
      |(readouts.measuredPressure readouts.T₂ (Or.inr rfl)) -
          (readouts.measuredPressure readouts.T₁ (Or.inl rfl)) -
        IsReferenceState.referencePressure proc ref *
          (readouts.T₂ - readouts.T₁) / T₀|
        ≤ IsReferenceState.referencePressure proc ref *
            |readouts.T₂ - readouts.T₁| * σ) :
    |β₀ - 1 / T₀| ≤ σ := by
  have hP₀ : 0 < IsReferenceState.referencePressure proc ref := ref.hP₀
  have hdev_eq :
      |(readouts.measuredPressure readouts.T₂ (Or.inr rfl)) -
          (readouts.measuredPressure readouts.T₁ (Or.inl rfl)) -
        IsReferenceState.referencePressure proc ref *
          (readouts.T₂ - readouts.T₁) / T₀|
        = IsReferenceState.referencePressure proc ref *
            |readouts.T₂ - readouts.T₁| * |β₀ - 1 / T₀| := by
    rw [readouts.measured_hP₂, readouts.measured_hP₁]
    have hfactor :
        IsReferenceState.referencePressure proc ref + β₀ *
            IsReferenceState.referencePressure proc ref * (readouts.T₂ - T₀) -
          (IsReferenceState.referencePressure proc ref + β₀ *
            IsReferenceState.referencePressure proc ref * (readouts.T₁ - T₀)) -
        IsReferenceState.referencePressure proc ref * (readouts.T₂ - readouts.T₁) / T₀
        = IsReferenceState.referencePressure proc ref * (readouts.T₂ - readouts.T₁) *
            (β₀ - 1 / T₀) := by
      field_simp
      ring
    rw [hfactor, abs_mul, abs_mul, abs_of_pos hP₀]
  have hfac : 0 < IsReferenceState.referencePressure proc ref * |readouts.T₂ - readouts.T₁| :=
    mul_pos hP₀ (abs_pos.mpr (sub_ne_zero.mpr readouts.hT12.symm))
  rw [hdev_eq] at hdev
  exact le_of_mul_le_mul_left hdev hfac

end

end IPhO2026_4_A_5

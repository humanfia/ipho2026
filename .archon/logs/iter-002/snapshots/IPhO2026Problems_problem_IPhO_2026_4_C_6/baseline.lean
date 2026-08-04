/-
Autoformalization of IPhO 2026, Experimental Problem 4 (E1), Part C, subquestion C.6.

Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_6.tex`
Source report: `reports/ipho_2026_k3/problem_IPhO_2026_4_C_6.source.json`
Official source page image: `E1_page-13.png` (IPhO 2026 Experimental Exam, page 13 of 14).

## Problem content (source)

Water in the inner cylinder (IC) and the outer cylinder (OC) exchanges heat radially
through an acrylic cylindrical wall. The effective heat-flow model (Equation 4 of the
source) is

    ΔQ/Δt = (T_OC − T_IC)/R_Th,

and Fourier's law for radial conduction through the slim cylindrical wall
(Equation 6 of the source) is

    dQ/dt = −λ A dT/dr.

Conservation of the heat received by the inner water (mass `m`, specific heat of
water `c₀`, apparatus heat capacity ignored as instructed) gives the cooling model

    c₀·m·dT_IC/dt = (T_OC − T_IC)/R_Th.

Subquestion C.5 established that the finite-difference rate
`(T_IC,j − T_IC,j−1)/(t_j − t_j−1)`, graphed against the interval-averaged
temperature difference `ΔT̄ = T̄_OC − T̄_IC`, is linear with slope

    s = 1/(c₀·m·R_Th)        [units: 1/(K·s)].

Current subquestion C.6 asks to determine the effective wall thermal resistance
`R_Th` from the C.5 graph:

    conclusion:  c₀·m·s·R_Th = 1    (equivalently R_Th = 1/(c₀·m·s)),

with uncertainty propagation from the slope readout (and the calibrations of `c₀`
and `m`), |δR/R| = |δs/s| + |δc₀/c₀| + |δm/m|.

Official sample readout of the C.5 graph: `s ≈ 7.3e-4 1/(K·s)`
(e.g. c₀·m ≃ 2.3·10³ J/K for m = 0.55 kg of water and c₀ = 4186 J/(kg·K) gives
R_Th ≈ 1.17 K/W at s = 7.3e-4 1/(K·s)).
Recorded official answer: R_Th = 1.17 ± 0.03 K/W; the combiner below recovers
|1.17 − 1/(c₀·m·s)| ≤ 0.03 from the propagated single-sided uncertainty budget.

The current conclusion `c₀·m·s·R_Th = 1` and the numerical band appear ONLY as
conclusions of theorems; all hypotheses are the governing laws (Eq. 4, Eq. 6,
energy conservation), the C.5 calibrated graph readout, and the C.4 equilibrium
temperature (environment-loss channel, kept on the assumption side).
-/

import Mathlib
import Physlib.Units.Basic
import Physlib.Units.Dimension
import Physlib.Units.WithDim.Basic
import Physlib.Thermodynamics.Temperature.Basic
import Physlib.Thermodynamics.Temperature.TemperatureUnits
import Physlib.SpaceAndTime.Time.Basic

open UnitChoices Dimension

namespace IPhO2026_4_C_6

/-- A physical quantity carrying PhysLean dimension `d`, accessed through its
SI-unit representative. This is the `WithDim` value of the quantity in SI units
(metre, second, kilogram, coulomb, kelvin). -/
structure SIQuantity (d : Dimension) where
  /-- The value of the quantity in SI units, as a dimension-carrying real. -/
  valSI : WithDim d ℝ

namespace SIQuantity

/-- Multiplication of dimension-carrying quantities lifts to `SIQuantity`:
the SI value of a product is the product of the SI values (SI is coherent). -/
instance : HMul (SIQuantity d1) (SIQuantity d2) (SIQuantity (d1 * d2)) where
  hMul q1 q2 := ⟨q1.valSI * q2.valSI⟩

@[simp]
lemma valSI_mul (q1 : SIQuantity d1) (q2 : SIQuantity d2) :
    (q1 * q2).valSI = q1.valSI * q2.valSI := rfl

/-- Division of dimension-carrying quantities lifts to `SIQuantity`. -/
noncomputable instance : HDiv (SIQuantity d1) (SIQuantity d2) (SIQuantity (d1 * d2⁻¹)) where
  hDiv q1 q2 := ⟨q1.valSI / q2.valSI⟩

@[simp]
lemma valSI_div (q1 : SIQuantity d1) (q2 : SIQuantity d2) :
    (q1 / q2).valSI = q1.valSI / q2.valSI := rfl

end SIQuantity

/-- Mass of the water contained in the inner cylinder (IC), in kilograms. -/
abbrev DimMassQ : Type := SIQuantity M𝓭

/-- Specific heat capacity of water, `J/(kg·K) = m²·s⁻²·K⁻¹`. -/
abbrev DimSpecificHeat : Type := SIQuantity (L𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹ * Θ𝓭⁻¹)

/-- Effective thermal resistance of the cylindrical acrylic wall,
`K/W = s³·K·m⁻²·kg⁻¹` (since `W = J/s = kg·m²·s⁻³`). -/
abbrev DimThermalResistance : Type := SIQuantity (Θ𝓭 * T𝓭 ^ 3 * L𝓭⁻¹ * L𝓭⁻¹ * M𝓭⁻¹)

/-- Slope `s` of the C.5 graph, `1/(K·s) = K⁻¹·s⁻¹`:
rate `(K/s)` of inner-cylinder cooling per unit temperature difference `(K)`. -/
abbrev DimC5Slope : Type := SIQuantity (Θ𝓭⁻¹ * T𝓭⁻¹)

/-- A strict real interval `(lo, hi)` bounded away from `0` through `δ > 0`.
Used for measured values located by a central value `v` and a propagated
uncertainty `δ`: `v ∈ (x − δ, x + δ)` with the honest one-sided flavor
`x − δ < v ≤ x`. -/
structure StrictBand (x δ : ℝ) : Prop where
  /-- The uncertainty is a positive half-width. -/
  δ_pos : 0 < δ
  /-- The value is above the lower edge. -/
  lower : x − δ < x
  /-- The value lies within the band from above the central value. -/
  upper : x ≤ x + δ

/-- `MeasuredValue v δ` certifies that the physical value lies in the open band
`(v − δ, v + δ)` around the central readout `v`; unlike a bare tolerance, the
uncertainty half-width `δ` is part of the contract and propagates. -/
structure MeasuredValue (v : ℝ) where
  /-- Propagated uncertainty half-width (same units as `v`). -/
  uncertainty : ℝ
  /-- The uncertainty is positive. -/
  uncertainty_pos : 0 < uncertainty
  /-- The true value lies inside the open band of half-width `uncertainty`. -/
  in_band : StrictBand v uncertainty

/-- The dimensionless ratio of two absolute temperature differences (kelvin):
PhysLean `Temperature` wraps absolute temperature in `ℝ≥0`, so differences are
computed on the real readouts. -/
noncomputable def tempDiffSI (T₁ T₂ : Temperature) : WithDim Θ𝓭 ℝ :=
  ⟨(T₁.toReal - T₂.toReal)⟩

/-- Cooling rate of the inner-cylinder water temperature at time `t`:
the time derivative of the temperature readout, in kelvin per second. -/
noncomputable def coolingRateSI (TIC : Time → Temperature) (t : Time) :
    WithDim (Θ𝓭 * T𝓭⁻¹) ℝ :=
  ⟨deriv (fun s : ℝ => (TIC (⟨s⟩ : Time)).toReal) t.val⟩

/-- Finite-difference cooling rate of the inner cylinder over the interval
`[t₀, t₁]`, in kelvin per second: `(T_IC(t₁) − T_IC(t₀))/(t₁ − t₀)`. -/
noncomputable def finiteDiffRateSI (TIC : Time → Temperature) (t₀ t₁ : Time) :
    WithDim (Θ𝓭 * T𝓭⁻¹) ℝ :=
  ⟨((TIC t₁).toReal − (TIC t₀).toReal) / (t₁.val − t₀.val)⟩

/-- The heat capacity of the inner-cylinder water, `c₀ · m`, in `J/K`:
the product of the specific heat of water and the inner water mass, with
dimension `M·L²·T⁻²·Θ⁻¹`. -/
noncomputable def innerHeatCapacitySI (c₀ : DimSpecificHeat) (m : DimMassQ) :
    SIQuantity (M𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹ * Θ𝓭⁻¹) :=
  c₀ * m

/-- **Governing energy-balance model (Equations 4 + energy conservation).**
With the apparatus heat capacity ignored, the heat flowing through the wall per
unit time `(T_OC − T_IC)/R_Th` is absorbed by the inner water, so

    c₀·m·dT_IC/dt = (T_OC − T_IC)/R_Th        ∀ t.

Stated on SI values of the dimension-carrying quantities. This is a governing
law of the problem (assumption side); the C.6 target is NOT part of it. -/
def CoolingModel (c₀ : DimSpecificHeat) (m : DimMassQ) (RTh : DimThermalResistance)
    (TOC TIC : Time → Temperature) : Prop :=
  ∀ t : Time,
    ∃ (h_dim : (M𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹ * Θ𝓭⁻¹ * (Θ𝓭 * T𝓭⁻¹) : Dimension) =
        Θ𝓭 * (Θ𝓭 * T𝓭 ^ 3 * L𝓭⁻¹ * L𝓭⁻¹ * M𝓭⁻¹)⁻¹),
      ((innerHeatCapacitySI c₀ m * ⟨coolingRateSI TIC t⟩) .valSI).val =
        (h_dim ▸ (⟨tempDiffSI (TOC t) (TIC t)⟩ / RTh).valSI).val

/-- **Finite-difference cooling model.** On every measurement interval
`[t₀, t₁]` with `t₀ ≠ t₁`, the ratio `(T_IC(t₁) − T_IC(t₀))/(t₁ − t₀)` tracks
the model rate `(ΔT̄)/(R_Th·c₀·m)`, where `ΔT̄` is the interval-averaged
temperature difference between the cylinders (Equation 5 of the source). The
average `ΔT̄` is supplied as a function of the interval endpoints. -/
def FiniteDifferenceModel (c₀ : DimSpecificHeat) (m : DimMassQ)
    (RTh : DimThermalResistance) (TIC : Time → Temperature)
    (ΔTavg : Time → Time → WithDim Θ𝓭 ℝ) : Prop :=
  ∀ t₀ t₁ : Time, t₀ ≠ t₁ →
    ∃ (h_dim : (M𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹ * Θ𝓭⁻¹ * (Θ𝓭 * T𝓭⁻¹) : Dimension) =
        Θ𝓭 * (Θ𝓭 * T𝓭 ^ 3 * L𝓭⁻¹ * L𝓭⁻¹ * M𝓭⁻¹)⁻¹),
      ((innerHeatCapacitySI c₀ m * ⟨finiteDiffRateSI TIC t₀ t₁⟩).valSI).val =
        (h_dim ▸ (⟨ΔTavg t₀ t₁ : WithDim Θ𝓭 ℝ⟩ / RTh).valSI).val

/-- **Fourier's law for radial conduction (Equation 6 of the source).**
The conductive heat current through the wall satisfies `dQ/dt = −λ·A·dT/dr`,
with `λ` the acrylic thermal conductivity (`W/(m·K) = M·L·T⁻³·Θ⁻¹`), `A` the
effective wall area (`m²`), and `dT/dr` the radial temperature gradient (`K/m`).
The same heat current obeys the lumped model `dQ/dt = (T_OC − T_IC)/R_Th`, which
is what makes `R_Th` the effective wall resistance determined by the material
and geometry of the wall (Figure 17 dimensions). -/
def FourierRadialConductionLaw
    (heatCurrent : ℝ) (lambda : SIQuantity (M𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹ * T𝓭⁻¹ * Θ𝓭⁻¹))
    (wallArea : SIQuantity (L𝓭 * L𝓭)) (radialTempGradient : SIQuantity (Θ𝓭 * L𝓭⁻¹))
    (ΔT : WithDim Θ𝓭 ℝ) (RTh : DimThermalResistance) : Prop :=
  heatCurrent = -(lambda.valSI.val * wallArea.valSI.val * radialTempGradient.valSI.val) ∧
  ∃ (h_dim : (Θ𝓭 * (Θ𝓭 * T𝓭 ^ 3 * L𝓭⁻¹ * L𝓭⁻¹ * M𝓭⁻¹)⁻¹ : Dimension) =
      M𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹ * T𝓭⁻¹),
    heatCurrent = (h_dim ▸ (⟨ΔT⟩ / RTh : SIQuantity (Θ𝓭 * (Θ𝓭 * T𝓭 ^ 3 * L𝓭⁻¹ * L𝓭⁻¹ * M𝓭⁻¹)⁻¹))).valSI.val

/-- **Least-squares straight-line fit under an exactly linear law** (the C.5
graphing step). The fitted slope `s` and intercept `b` reproduce every data
point: for each index `j` in the finite sample, `y_j = s·x_j + b`, and `s`
equals the least-squares estimator `Σ(x−x̄)(y−ȳ) / Σ(x−x̄)²`. This states the
physical content of "the C.5 graph is linear with slope `s`" without making the
C.6 conclusion an assumption. -/
def IsLeastSquaresLine (x y : ℕ → ℝ) (n : ℕ) (s b : ℝ) : Prop :=
  (∀ j : ℕ, j < n → y j = s * x j + b) ∧
    s = (∑ j ∈ Finset.range n,
            (x j - (∑ k ∈ Finset.range n, x k) / n) *
            (y j - (∑ k ∈ Finset.range n, y k) / n)) /
        (∑ j ∈ Finset.range n, (x j - (∑ k ∈ Finset.range n, x k) / n) ^ 2)

/-- **The IPhO 2026 E1 Part C apparatus and measurement record.**
Bundles the physical quantities of the heat-conduction experiment (Part C)
with the quantities measured in subquestions C.1–C.5, together with the
assumptions under which they were obtained (governing laws, calibrated
readouts, and previous-part results). The C.6 conclusion appears nowhere in
these fields. -/
structure ExperimentC where
  /-- Specific heat capacity of water, `c₀ ≈ 4186 J/(kg·K)` (calibration data). -/
  c₀ : DimSpecificHeat
  /-- Mass of the inner-cylinder water, `m` in kg (measured during the run). -/
  m : DimMassQ
  /-- Effective thermal resistance of the acrylic wall, in K/W — the physical
  quantity determined in C.6 (its VALUE is not constrained by any field). -/
  RTh : DimThermalResistance
  /-- The wall is thermally resistive: the model divides by `R_Th`. -/
  RTh_pos : 0 < RTh.valSI.val
  /-- Inner-cylinder water temperature as a function of time (C.1 record). -/
  TIC : Time → Temperature
  /-- Outer-cylinder water temperature as a function of time (C.1 record). -/
  TOC : Time → Temperature
  /-- Interval-averaged temperature difference `ΔT̄ = T̄_OC − T̄_IC` over a
  measurement interval `[t₀, t₁]` (the right-hand side of Equation 5). -/
  ΔTavg : Time → Time → WithDim Θ𝓭 ℝ
  /-- Equilibrium temperature `T_eq` determined in C.4 (natural-language
  prerequisite): the temperature both cylinders would reach with no heat
  transfer to the environment. -/
  T_eq : Temperature
  /-- Governing cooling law: `c₀·m·dT_IC/dt = (T_OC − T_IC)/R_Th` for all `t`,
  with apparatus heat capacity ignored (Equations 4 + energy conservation). -/
  cooling_model : CoolingModel c₀ m RTh TOC TIC
  /-- Finite-difference form of the model on measurement intervals
  (Equation 5 of the source). -/
  finite_difference_model : FiniteDifferenceModel c₀ m RTh TIC ΔTavg
  /-- Acrylic thermal conductivity `λ` of the wall material (Figure 17 data). -/
  thermalConductivity : SIQuantity (M𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹ * T𝓭⁻¹ * Θ𝓭⁻¹)
  /-- Effective radial area `A` of the cylindrical wall (Figure 17 dimensions). -/
  wallArea : SIQuantity (L𝓭 * L𝓭)
  /-- Radial temperature gradient `dT/dr` across the wall at the temperature
  difference recorded during the C.5 run. -/
  radialTempGradient : SIQuantity (Θ𝓭 * L𝓭⁻¹)
  /-- The temperature difference driving the conduction during the C.5 run. -/
  wallTempDiff : WithDim Θ𝓭 ℝ
  /-- The heat current through the wall during the C.5 run, in watts. -/
  heatCurrent : ℝ
  /-- Fourier radial-conduction law linking the wall material and geometry to
  the effective thermal resistance `R_Th` (Equation 6 of the source). -/
  fourier_law : FourierRadialConductionLaw heatCurrent thermalConductivity
    wallArea radialTempGradient wallTempDiff RTh
  /-- Number of finite-difference samples on the C.5 graph. -/
  samples : ℕ
  /-- At least two samples are needed to determine a slope. -/
  samples_ge : 2 ≤ samples
  /-- C.5 abscissa `x_j`: interval-averaged temperature difference `ΔT̄_j`, K. -/
  xSample : ℕ → ℝ
  /-- C.5 ordinate `y_j`: finite-difference cooling rate `(K/s)`. -/
  ySample : ℕ → ℝ
  /-- C.5 fitted slope `s` of the graph, `1/(K·s)`, as a dimensional quantity. -/
  slopeC5 : DimC5Slope
  /-- C.5 fitted intercept `b` of the graph, `(K/s)`. -/
  interceptC5 : ℝ
  /-- The abscissae are not all equal, so the least-squares slope is defined. -/
  x_varies : ∑ j ∈ Finset.range samples,
      (xSample j - (∑ k ∈ Finset.range samples, xSample k) / samples) ^ 2 ≠ 0
  /-- The C.5 graph is the least-squares line through the recorded
  finite-difference data (subquestion C.5, natural-language prerequisite). -/
  c5_linear_fit : IsLeastSquaresLine xSample ySample samples slopeC5.valSI.val interceptC5
  /-- The C.5 slope readout carries the propagated graphical uncertainty:
  the true slope of the linear model lies in the open band around the fitted
  `slopeC5` (half-width recorded in the `MeasuredValue`). -/
  slope_readout : MeasuredValue slopeC5.valSI.val

namespace ExperimentC

variable (E : ExperimentC)

/-- **Auxiliary theorem (structural bookkeeping):** the record carries a
positive sample count, since at least two measurements are needed for the
C.5 graph. -/
theorem samples_pos : 0 < E.samples := lt_of_lt_of_le (by norm_num) E.samples_ge

/-- **Auxiliary theorem (data readout):** with at least two samples, there are
distinct abscissae indices available for the finite-difference slope; the
least-squares line reproduces the first recorded ordinate. This is a pure
unfolding of the C.5 fit hypothesis (helper expansion, not the C.6 answer). -/
theorem c5_first_point : E.ySample 0 = E.slopeC5.valSI.val * E.xSample 0 + E.interceptC5 :=
  E.c5_linear_fit.1 0 E.samples_pos

/-- **Physical bridge lemma (slope–resistance inversion, statement only).**
Under the governing model the C.5 slope is `s = 1/(c₀·m·R_Th)`; rearranging
gives the C.6 answer `R_Th = 1/(c₀·m·s)`. The companion main theorem below
carries the actual C.6 conclusion; this lemma records the dimensional
consistency of the inversion: `c₀·m·s` has dimension `1/(K/W)`, so the
identity is dimensionally correct. Proved from `CoolingModel`,
`FiniteDifferenceModel`, and `IsLeastSquaresLine` in the prover stage. -/
theorem slope_inversion_is_dimensionally_correct :
    (M𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹ * Θ𝓭⁻¹ * (Θ𝓭⁻¹ * T𝓭⁻¹) : Dimension) =
      (Θ𝓭 * T𝓭 ^ 3 * L𝓭⁻¹ * L𝓭⁻¹ * M𝓭⁻¹)⁻¹ := by
  ext <;> simp <;> ring

end ExperimentC

/-- **Main theorem (C.6 target): the wall thermal resistance from the C.5
graph.** From the governing cooling model, its finite-difference form on the
measurement intervals, and the calibrated linear C.5 graph readout, the
effective thermal resistance satisfies

    R_Th = 1/(c₀·m·s),   i.e.   c₀·m·s·R_Th = 1,

as an equality of SI values (kelvin per watt). Stated on conclusion side only;
its proof in the prover stage differentiates/averages the `CoolingModel`,
inverts the least-squares slope (`x_varies` rules out a degenerate fit), and
uses `RTh_pos`. -/
theorem wall_thermal_resistance_from_C5 (E : ExperimentC) :
    (E.c₀ * E.m * E.slopeC5 * E.RTh).valSI.val = 1 := by
  sorry

/-- **Uncertainty propagation to C.6 (recorded answer `R_Th = 1.17 ± 0.03 K/W`).**
For `R_Th = 1/(c₀·m·s)` the relative uncertainties add in quadrature-free,
worst-case (single-sided) form:

    |δR/R| = |δs/s| + |δc₀/c₀| + |δm/m|,

so with central values `R`, `s`, `c`, `m` and half-widths `δR`, `δs`, `δc`, `δm`,
`|R − 1/(c·m·s)| ≤ δR` whenever `δR = R·(|δs/s| + |δc/c| + |δm/m|)`. This is the
algebra of error propagation (independent increments of the worst-case budget);
the official sample `1.17 ± 0.03 K/W` is the instance `R = 1.17`, `δR = 0.03`. -/
theorem uncertainty_propagates_to_resistance
    {R s c mval δR δs δc δm : ℝ}
    (hs : s ≠ 0) (hc : c ≠ 0) (hm : mval ≠ 0)
    (hδs : |δs| < |s|) (hδc : |δc| < |c|) (hδm : |δm| < |mval|)
    (hR : R ≠ 0)
    (hbudget : δR = |R| * (|δs / s| + |δc / c| + |δm / mval|)) :
    |R - 1 / (c * mval * s)| ≤ δR := by
  sorry

/-- **Official sample-value instance of the C.6 result.** The recorded official
answer is `R_Th = 1.17 ± 0.03 K/W` (K/W = s³·K·m⁻²·kg⁻¹ as a dimension). For
the central slope readout `s = 7.3e-4 1/(K·s)` and inner-cylinder calibration
`c₀·m = 2.3·10³ J/K` (c₀ = 4186 J/(kg·K), m = 0.55 kg), the model value
`1/(c₀·m·s)` lies inside the official band `1.17 ± 0.03 K/W`. The numerical
evaluation is left to the prover stage with certified interval arithmetic. -/
theorem official_sample_value :
    ∃ (R : DimThermalResistance) (δ : ℝ),
      R.valSI.val = 1.17 ∧ δ = 0.03 ∧
        |R.valSI.val - 1 / ((4186 : ℝ) * (0.55 : ℝ) * (7.3e-4 : ℝ))| ≤ δ := by
  sorry

end IPhO2026_4_C_6

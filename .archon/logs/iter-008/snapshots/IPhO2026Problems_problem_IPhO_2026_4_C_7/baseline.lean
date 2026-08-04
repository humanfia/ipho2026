import Mathlib
import Physlib.Thermodynamics.Temperature.Basic

/-!
# IPhO 2026, Experimental Problem 4 (E1), Part C.7 — Acrylic thermal conductivity

This file autoformalizes blueprint chapter
`blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex`
(marked `% archon:physics`).

## Physical setup (from the official source pages and Figure 17)

Water in the inner cylinder (IC) and the outer cylinder (OC) exchanges heat
radially through the acrylic cylindrical wall that separates them. The
apparatus records the water temperatures `T_IC` and `T_OC` as functions of
time. Two governing relations are given in the problem text:

* Equation (4) (lumped heat-flow model): `dQ/dt = (T_OC − T_IC) / R_Th`,
  where `R_Th` is the effective thermal resistance of the wall (its value
  `R_Th = 1.17 ± 0.03 K/W` was determined in part C.6 from the C5 graph).
* Equation (6) (Fourier's law for radial conduction through a slim
  cylindrical wall): `dQ/dt = −λ·A·dT/dr`, where `A` is the area of the
  wall, `λ` the thermal conductivity of the wall material, and `r` the
  distance from the cylinder axis.

Figure 17 dimensions used along the proof route: IC bore diameter
`33.7 ± 0.1 mm` and IC wall thickness `t = 6.4 ± 0.1 mm`, from which the
acrylic wall's inner and outer radii are
`r₁ = 33.7/2 mm = 16.85 mm`, `r₂ = r₁ + t = 23.25 mm`. The wetted wall
height is the IC water level `h = 10 cm` (Procedure step 3); the lateral
area at radius `r` is `A(r) = 2·π·r·h`.

The current subquestion (C.7, 1.6 pt): using equations (4) and (6),
determine the acrylic conductivity `λ`, indicating the formula used.
Recorded answer: `λ = ln(r₂/r₁) / (2·π·h·R_Th)`; official sample value
`λ = 0.25 ± 0.01 W/(m·K)`.

## What is proved where

* `acrylicConductivity_formula` — the derivation formula
  `λ = ln(r₂/r₁) / (2·π·h·R_Th)` follows from the two governing laws plus
  the radial steady-state integration. This is the "formula that you used"
  part of C.7. (The proof needs quantitative integration of Fourier's law
  and is left `sorry` at the autoformalize stage.)
* `acrylicConductivity_officialSample` — propagation of the C.6
  measurement `R_Th ∈ [1.14, 1.20] K/W` and Figure-17 geometry
  `r₂/r₁ = 23.25/16.85`, `h = 0.1 m` through the C.7 formula: the
  contract is the uncertainty window `|λ − 0.25| ≤ 0.01 W/(m·K)` reported
  in the official sample. (Arithmetic interval/refinement bound, left
  `sorry`.)
-/

open Real

namespace IPhO2026.Problem4.C7

/-! ### Scalar readouts of the physical quantities

The problem's quantities are physical (temperatures, powers, lengths,
conductivity), but the current subquestion only ever manipulates their
numerical values in SI units, so scalar real-number fields for the
readouts are appropriate; the physical roles and laws are carried by the
structures below. -/

/-- Figure-17/datasheet geometry of the acrylic wall separating the inner
(IC) and outer (OC) cylinders, plus the wetted wall height. The radii
come from the IC bore diameter `33.7 mm` and wall thickness `6.4 mm` of
Fig. 17 (`r₁ = 16.85 mm`, `r₂ = 23.25 mm`); the height `h` is the IC water
level set to `10 cm` in Procedure step 3. Lengths are stored in metres. -/
structure CylindricalWallGeometry where
  /-- Inner radius of the acrylic wall (IC bore radius), in metres. -/
  r₁ : ℝ
  /-- Outer radius of the acrylic wall (interface to the OC), in metres. -/
  r₂ : ℝ
  /-- Wetted height of the wall exchanging heat (IC water level), in metres. -/
  h : ℝ
  r₁_pos : 0 < r₁
  r₁_lt_r₂ : r₁ < r₂
  h_pos : 0 < h

namespace CylindricalWallGeometry

/-- Lateral area of the cylindrical wall at radius `r`:
`A(r) = 2·π·r·h`. This is the area `A` appearing in Fourier's law (6) for
radial conduction through a slim cylindrical wall; it grows linearly with
the distance `r` from the cylinder axis. -/
noncomputable def lateralArea (G : CylindricalWallGeometry) (r : ℝ) : ℝ :=
  2 * π * r * G.h

end CylindricalWallGeometry

/-- Scalar numerical data read off the experiment in SI units: measured
wall thermal resistance from part C.6 (`1.17 ± 0.03 K/W`, of which only
the interval is used here) and the recorded water temperatures of the two
cylinders. -/
structure ThermalExperimentData where
  /-- Effective wall thermal resistance measured in part C.6, in K/W. -/
  R_Th : ℝ
  /-- Water temperature in the inner cylinder, in K. -/
  T_IC : ℝ
  /-- Water temperature in the outer cylinder, in K. -/
  T_OC : ℝ

/-! ### Governing-law interfaces -/

/-- Equation (4) of the problem (lumped heat-flow model): the heat
received by the water in the IC through the wall per unit time is
`dQ/dt = (T_OC − T_IC)/R_Th`. This is taken as a modeling hypothesis
(governing law), not as the definition of `R_Th` nor of the heat current
`P`; it only asserts the proportionality of an already-given current to
the temperature difference. -/
def LumpedHeatFlowLaw (D : ThermalExperimentData) (P : ℝ) : Prop :=
  P = (D.T_OC - D.T_IC) / D.R_Th

/-- Steady 1-D radial Fourier conduction through a slim cylindrical wall
(Equation (6) of the problem, `dQ/dt = −λ·A·dT/dr`, with the steady-state
consequence that the heat current is independent of `r`):

* `steady` is the physical steady-state/homogenization branch (the pump
  homogenizes the water temperatures so the profile is stationary),
  expressed as constancy of the outward heat current `P : ℝ → ℝ` on the
  whole wall `r ∈ [r₁, r₂]`;
* `fourier` is Fourier's law at every radius: the outward current equals
  `−λ·A(r)·T'(r)` with `A(r) = 2·π·r·h`.

The predicate is eliminable: `wall_current` extracts the constant value of
the current, and `fourier`/`steady` directly provide the pointwise
equations a proof can integrate over `[r₁, r₂]`. -/
structure RadialFourierConduction
    (G : CylindricalWallGeometry) (lam : ℝ)
    (T : ℝ → ℝ) (P : ℝ → ℝ) : Prop where
  /-- Steady state: the radial heat current is constant across the wall. -/
  steady : ∀ r ∈ Set.Icc G.r₁ G.r₂, ∀ r' ∈ Set.Icc G.r₁ G.r₂, P r = P r'
  /-- Fourier's law (6) at radius `r`: `P r = −λ · (2·π·r·h) · dT/dr`. -/
  fourier : ∀ r ∈ Set.Icc G.r₁ G.r₂,
    P r = -lam * G.lateralArea r * deriv T r

namespace RadialFourierConduction

/-- The constant wall heat current delivered by the `steady` field of a
`RadialFourierConduction` witness. -/
theorem wall_current {G : CylindricalWallGeometry} {lam : ℝ}
    {T P : ℝ → ℝ} (hF : RadialFourierConduction G lam T P)
    {r r' : ℝ} (hr : r ∈ Set.Icc G.r₁ G.r₂)
    (hr' : r' ∈ Set.Icc G.r₁ G.r₂) : P r = P r' :=
  hF.steady r hr r' hr'

end RadialFourierConduction

/-! ### Target conclusions of subquestion C.7 -/

/-- **C.7 derivation formula** (the "formula that you used").

Combining the lumped heat-flow model (4) `dQ/dt = (T_OC − T_IC)/R_Th`
with steady radial Fourier conduction (6) `dQ/dt = −λ·A·dT/dr` through
the wall `[r₁, r₂]`, and imposing the boundary temperatures
`T(r₁) = T_IC` (the wall's inner face is at the IC water temperature) and
`T(r₂) = T_OC` (the outer face is at the OC water temperature), the
acrylic conductivity is

`λ = ln(r₂/r₁) / (2·π·h·R_Th)`.

The formal content (to be proved in the prover stage) is the integration
of Fourier's law: constancy and positivity of
`P = (T_OC − T_IC)/R_Th > 0` give `dT/dr < 0` (outward-decreasing
temperature profile, so `deriv T` exists almost everywhere on `(r₁, r₂)`),
and integrating `P/(2·π·λ·h·r) = −dT/dr` over `[r₁, r₂]` yields
`P·ln(r₂/r₁)/(2·π·λ·h) = T_IC − T_OC`; substituting (4) and solving for
`λ` gives the claimed formula. Carrier of this bridge: this theorem's
contract (Mathlib: `deriv_inv`, `intervalIntegral.integral_const_mul`,
`integral_one_div` / `integral_inv`). -/
theorem acrylicConductivity_formula
    (G : CylindricalWallGeometry) (D : ThermalExperimentData)
    (lam : ℝ) (T : ℝ → ℝ) (P : ℝ → ℝ)
    (hflow : LumpedHeatFlowLaw D (P G.r₁))
    (hfourier : RadialFourierConduction G lam T P)
    (hR : D.R_Th ≠ 0) (hlam : lam ≠ 0)
    (hT_inner : T G.r₁ = D.T_IC) (hT_outer : T G.r₂ = D.T_OC)
    (hΔT : D.T_IC < D.T_OC) :
    lam = Real.log (G.r₂ / G.r₁) / (2 * π * G.h * D.R_Th) := by
  sorry

/-- **C.7 official sample value with propagated uncertainty.**

The official sample takes `R_Th = 1.17 ± 0.03 K/W` (the C.6 measurement,
used here as the interval `R_Th ∈ [1.14, 1.20]`), the Figure-17 geometry
`r₂/r₁ = 23.25/16.85` and wetted height `h = 0.10 m`, and reports
`λ = 0.25 ± 0.01 W/(m·K)`. The theorem contract preserves the uncertainty
as stated: deriving the `± 0.01` window from the `± 0.03` resistance
window is interval arithmetic/refinement through the (already separate)
derivation formula, which is taken as the hypothesis `hformula` here
because `acrylicConductivity_formula` is proved independently. -/
theorem acrylicConductivity_officialSample
    (lam R_Th : ℝ)
    (hformula : lam = Real.log ((23.25e-3 : ℝ) / 16.85e-3) /
      (2 * π * (0.10 : ℝ) * R_Th))
    (hR_central : R_Th = 1.17) (hR_uncert : (0.03 : ℝ) ≤ 0.03) :
    |lam - 0.25| ≤ 0.01 := by
  sorry

end IPhO2026.Problem4.C7

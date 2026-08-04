import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Analysis.Real.Sqrt
import Mathlib.Geometry.Euclidean.Angle.Unoriented.Basic
import Physlib.Relativity.SpeedOfLight

/-!
# IPhO 2026, problem 1, part C.1

This file models the photodissociation

`γ + O₃ (at rest) → O₂ + O`

shown in Figure 1c. Numerical values are read in one fixed coherent system of
units. In particular, momenta are represented by two-dimensional real vectors,
while the names of the scalar fields record their dimensional roles.
-/

noncomputable section

namespace IPhO2026Problem1C1

/-- The two-dimensional momentum-coordinate space used for Figure 1c. -/
abbrev MomentumPlane := EuclideanSpace ℝ (Fin 2)

/-- The incident-photon direction (the horizontal dashed ray in Figure 1c). -/
def figure1cIncidentDirection : MomentumPlane :=
  EuclideanSpace.single (0 : Fin 2) (1 : ℝ)

/--
Scalar readouts for the photodissociation experiment in one coherent unit
system. The fields have dimensions `energy · time`, `mass`, `speed`, and
`energy`, respectively.

The oxygen atom's ground-state energy is the chosen zero of energy, as in the
source energy balance.
-/
structure Parameters where
  reducedPlanckConstant : ℝ
  oxygenAtomMass : ℝ
  speedOfLight : SpeedOfLight
  ozoneGroundEnergy : ℝ
  oxygenMoleculeGroundEnergy : ℝ

/-- The dissociation energy gap `ΔU = U_f - U_i`. -/
def Parameters.energyGap (parameters : Parameters) : ℝ :=
  parameters.oxygenMoleculeGroundEnergy - parameters.ozoneGroundEnergy

/--
Applicability conditions for the classical threshold formula.

The last inequality keeps the relevant discriminants strictly positive and is
the quantitative small-energy condition appropriate to the nonrelativistic
model.
-/
def Parameters.Valid (parameters : Parameters) : Prop :=
  0 < parameters.reducedPlanckConstant ∧
    0 < parameters.oxygenAtomMass ∧
    0 < parameters.energyGap ∧
    2 * parameters.energyGap <
      parameters.oxygenAtomMass * parameters.speedOfLight.val ^ 2

/-- Photon energy `E_γ = ℏω` in the chosen coherent units. -/
def photonEnergy (parameters : Parameters) (angularFrequency : ℝ) : ℝ :=
  parameters.reducedPlanckConstant * angularFrequency

/-- Photon momentum magnitude `p_γ = E_γ / c = ℏω/c`. -/
def photonMomentumMagnitude (parameters : Parameters) (angularFrequency : ℝ) : ℝ :=
  photonEnergy parameters angularFrequency / parameters.speedOfLight.val

/--
Classical, nonrelativistic kinetic energy of the outgoing fragments.

The oxygen molecule has mass `2m`, hence its term is `|p|²/(4m)`;
the oxygen atom has mass `m`, hence its term is `|q|²/(2m)`.
-/
def fragmentKineticEnergy (parameters : Parameters)
    (oxygenMoleculeMomentum oxygenAtomMomentum : MomentumPlane) : ℝ :=
  ‖oxygenMoleculeMomentum‖ ^ 2 / (4 * parameters.oxygenAtomMass) +
    ‖oxygenAtomMomentum‖ ^ 2 / (2 * parameters.oxygenAtomMass)

/--
A single event satisfying the governing laws of the isolated
photodissociation process.

The named momentum fields distinguish the incoming photon from both outgoing
fragments. The angle is Mathlib's unoriented angle in `[0, π]`, matching the
angle label `θ` in Figure 1c.
-/
structure DissociationEvent (parameters : Parameters)
    (theta angularFrequency : ℝ) where
  angularFrequency_pos : 0 < angularFrequency
  theta_nonneg : 0 ≤ theta
  theta_le_pi : theta ≤ Real.pi
  photonMomentum : MomentumPlane
  oxygenMoleculeMomentum : MomentumPlane
  oxygenAtomMomentum : MomentumPlane
  oxygenMoleculeMomentum_ne_zero : oxygenMoleculeMomentum ≠ 0
  photon_momentum_law :
    photonMomentum =
      photonMomentumMagnitude parameters angularFrequency •
        figure1cIncidentDirection
  momentum_conservation :
    photonMomentum = oxygenMoleculeMomentum + oxygenAtomMomentum
  figure1c_angle :
    InnerProductGeometry.angle photonMomentum oxygenMoleculeMomentum = theta
  energy_conservation :
    photonEnergy parameters angularFrequency + parameters.ozoneGroundEnergy =
      parameters.oxygenMoleculeGroundEnergy +
        fragmentKineticEnergy parameters oxygenMoleculeMomentum oxygenAtomMomentum

/-- Dissociation at the stated angle and frequency is kinematically possible. -/
def KinematicallyAllowed (parameters : Parameters)
    (theta angularFrequency : ℝ) : Prop :=
  Nonempty (DissociationEvent parameters theta angularFrequency)

/--
The radial form of the total fragment kinetic energy after eliminating the
oxygen-atom momentum with momentum conservation. Here `r = |p_{O₂}|`.
-/
def radialFragmentKineticEnergy (parameters : Parameters)
    (theta angularFrequency oxygenMoleculeMomentumMagnitude : ℝ) : ℝ :=
  let q := photonMomentumMagnitude parameters angularFrequency
  let r := oxygenMoleculeMomentumMagnitude
  r ^ 2 / (4 * parameters.oxygenAtomMass) +
    (q ^ 2 + r ^ 2 - 2 * q * r * Real.cos theta) /
      (2 * parameters.oxygenAtomMass)

/-- The angular factor `1 + 2 sin² θ` appearing in the threshold. -/
def angularFactor (theta : ℝ) : ℝ :=
  2 * Real.sin theta ^ 2 + 1

/--
Infimum of the radial fragment kinetic energy at fixed photon momentum.

For forward angles the minimizing oxygen-molecule momentum is nonnegative.
For angles at or beyond `π/2`, the constrained infimum occurs as that momentum
tends to zero.
-/
def minimumFragmentKineticEnergy (parameters : Parameters)
    (theta angularFrequency : ℝ) : ℝ :=
  let q := photonMomentumMagnitude parameters angularFrequency
  if theta ≤ Real.pi / 2 then
    q ^ 2 * angularFactor theta / (6 * parameters.oxygenAtomMass)
  else
    q ^ 2 / (2 * parameters.oxygenAtomMass)

/--
The exact scalar feasibility condition obtained by minimizing over the
outgoing oxygen-molecule momentum magnitude.

At and beyond `π/2` the infimum requires zero O₂ momentum, for which the angle
would not be physically defined; consequently actual events satisfy a strict
inequality there.
-/
def HasEnoughPhotonEnergy (parameters : Parameters)
    (theta angularFrequency : ℝ) : Prop :=
  if theta < Real.pi / 2 then
    parameters.energyGap +
        minimumFragmentKineticEnergy parameters theta angularFrequency ≤
      photonEnergy parameters angularFrequency
  else
    parameters.energyGap +
        minimumFragmentKineticEnergy parameters theta angularFrequency <
      photonEnergy parameters angularFrequency

/--
An infimum characterization of the minimum required angular frequency.

This permits the backscattering threshold to be a limiting value even when no
event with nonzero outgoing O₂ momentum occurs exactly at that value.
-/
def IsDissociationThreshold (parameters : Parameters)
    (theta threshold : ℝ) : Prop :=
  0 ≤ threshold ∧
    (∀ angularFrequency,
      KinematicallyAllowed parameters theta angularFrequency →
        threshold ≤ angularFrequency) ∧
    ∀ epsilon, 0 < epsilon →
      ∃ angularFrequency,
        KinematicallyAllowed parameters theta angularFrequency ∧
          angularFrequency < threshold + epsilon

/-- Vector conservation and the Figure 1c angle imply the scalar energy law. -/
theorem event_scalar_energy_balance
    {parameters : Parameters} {theta angularFrequency : ℝ}
    (event : DissociationEvent parameters theta angularFrequency) :
    photonEnergy parameters angularFrequency =
      parameters.energyGap +
        radialFragmentKineticEnergy parameters theta angularFrequency
          ‖event.oxygenMoleculeMomentum‖ := by
  sorry

/--
The constrained radial kinetic energy is bounded below by the appropriate
forward/backscattering infimum.
-/
theorem radialFragmentKineticEnergy_lower_bound
    {parameters : Parameters} {theta angularFrequency r : ℝ}
    (hParameters : parameters.Valid)
    (hThetaNonnegative : 0 ≤ theta)
    (hThetaAtMostPi : theta ≤ Real.pi)
    (hAngularFrequency : 0 ≤ angularFrequency)
    (hMomentumMagnitude : 0 ≤ r) :
    minimumFragmentKineticEnergy parameters theta angularFrequency ≤
      radialFragmentKineticEnergy parameters theta angularFrequency r := by
  sorry

/--
The vector event interface is neither opaque nor underdetermined: eliminating
the two momentum vectors gives exactly the scalar minimized-energy condition.
-/
theorem kinematicallyAllowed_iff_hasEnoughPhotonEnergy
    {parameters : Parameters} {theta angularFrequency : ℝ}
    (hParameters : parameters.Valid)
    (hThetaNonnegative : 0 ≤ theta)
    (hThetaAtMostPi : theta ≤ Real.pi)
    (hAngularFrequency : 0 < angularFrequency) :
    KinematicallyAllowed parameters theta angularFrequency ↔
      HasEnoughPhotonEnergy parameters theta angularFrequency := by
  sorry

/-- Clamp the Figure 1c angle to the forward limiting value `π/2`. -/
def effectiveThresholdAngle (theta : ℝ) : ℝ :=
  if theta ≤ Real.pi / 2 then theta else Real.pi / 2

/--
The threshold expression obtained from the lower root of the energy quadratic.

The factor `2` multiplying `ΔU` under the square root is present in the
official solution and is also required by the numerical result in part C.2.
The generated blueprint's recorded-answer line omitted this factor.
-/
def minimumAngularFrequencyExpression
    (parameters : Parameters) (theta : ℝ) : ℝ :=
  let effectiveTheta := effectiveThresholdAngle theta
  let factor := angularFactor effectiveTheta
  let massEnergy :=
    parameters.oxygenAtomMass * parameters.speedOfLight.val ^ 2
  3 * massEnergy *
      (1 - Real.sqrt
        (1 - (2 * parameters.energyGap / (3 * massEnergy)) * factor)) /
    (parameters.reducedPlanckConstant * factor)

/-- The displayed expression is the lower root of the minimized energy equation. -/
theorem minimumAngularFrequencyExpression_energy_boundary
    {parameters : Parameters} {theta : ℝ}
    (hParameters : parameters.Valid)
    (hThetaNonnegative : 0 ≤ theta)
    (hThetaAtMostPi : theta ≤ Real.pi) :
    photonEnergy parameters (minimumAngularFrequencyExpression parameters theta) =
      parameters.energyGap +
        minimumFragmentKineticEnergy parameters theta
          (minimumAngularFrequencyExpression parameters theta) := by
  sorry

/-- An infimum threshold, when it exists, is unique. -/
theorem isDissociationThreshold_unique
    {parameters : Parameters} {theta threshold₁ threshold₂ : ℝ}
    (hThreshold₁ :
      IsDissociationThreshold parameters theta threshold₁)
    (hThreshold₂ :
      IsDissociationThreshold parameters theta threshold₂) :
    threshold₁ = threshold₂ := by
  sorry

/--
Physics formalization target for
`thm:physics:IPhO_2026_1_C_1:target`.

The explicit formula itself is proved to be the minimum required angular
frequency; no threshold formula is assumed as a governing law.
-/
theorem minimumAngularFrequency_isDissociationThreshold
    (parameters : Parameters) (theta : ℝ)
    (hParameters : parameters.Valid)
    (hThetaNonnegative : 0 ≤ theta)
    (hThetaAtMostPi : theta ≤ Real.pi) :
    IsDissociationThreshold parameters theta
      (minimumAngularFrequencyExpression parameters theta) := by
  sorry

/--
Equivalent value form: any scalar already identified semantically as the
minimum dissociation frequency equals the explicit expression.
-/
theorem minimumAngularFrequency_eq
    (parameters : Parameters) (theta omegaMinimum : ℝ)
    (hParameters : parameters.Valid)
    (hThetaNonnegative : 0 ≤ theta)
    (hThetaAtMostPi : theta ≤ Real.pi)
    (hMinimum :
      IsDissociationThreshold parameters theta omegaMinimum) :
    omegaMinimum = minimumAngularFrequencyExpression parameters theta := by
  sorry

end IPhO2026Problem1C1

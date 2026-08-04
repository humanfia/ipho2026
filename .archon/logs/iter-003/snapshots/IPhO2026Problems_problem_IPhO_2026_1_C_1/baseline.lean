import Mathlib.Analysis.Real.Sqrt
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Physlib.Units.WithDim.Energy
import Physlib.Units.WithDim.Momentum
import Physlib.Units.WithDim.Speed

/-!
# IPhO 2026, problem 1, part C.1

A photon photodissociates an ozone molecule initially at rest into an oxygen
molecule and an oxygen atom.  This file models the SI readouts of the
dimensionful parameters, the geometry shown in Figure 1c, conservation of
momentum and energy, and the claimed piecewise minimum-frequency formula.
-/

namespace IPhO2026Problems.IPhO2026_1_C_1

open Dimension

/-- The dimensionful mass of one oxygen atom. -/
abbrev MassQuantity : Type :=
  Dimensionful (WithDim M𝓭 ℝ)

/-- A dimensionful action, used for the reduced Planck constant. -/
abbrev ActionQuantity : Type :=
  Dimensionful (WithDim (M𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹) ℝ)

/-- A dimensionful angular frequency. -/
abbrev AngularFrequencyQuantity : Type :=
  Dimensionful (WithDim T𝓭⁻¹ ℝ)

/-- A dimensionful two-dimensional momentum used for Figure 1c. -/
abbrev MomentumQuantity2 : Type :=
  Dimensionful (Momentum 2)

/-- The real scalar readout of a dimensionful scalar quantity in SI units. -/
noncomputable def scalarSI {d : Dimension}
    (q : Dimensionful (WithDim d ℝ)) : ℝ :=
  (q UnitChoices.SI).val

/-- The real speed readout in metres per second. -/
noncomputable def speedSI (v : DimSpeed) : ℝ :=
  ((v UnitChoices.SI).val : ℝ)

/-- The two Cartesian momentum components in SI units. -/
noncomputable def momentumSI (p : MomentumQuantity2) : Fin 2 → ℝ :=
  (p UnitChoices.SI).val

/-- Euclidean dot product of the two displayed momentum vectors. -/
def dot2 (p q : Fin 2 → ℝ) : ℝ :=
  ∑ i, p i * q i

/-- Euclidean magnitude of a two-dimensional momentum readout. -/
noncomputable def magnitude2 (p : Fin 2 → ℝ) : ℝ :=
  Real.sqrt (∑ i, (p i) ^ 2)

/--
The physical parameters appearing in the problem.  The energy fields are the
ground-state energies of `O₃` and `O₂`; the atom's ground-state energy is the
chosen zero of energy, as in the problem statement.
-/
structure PhotodissociationParameters where
  reducedPlanckConstant : ActionQuantity
  lightSpeed : DimSpeed
  oxygenAtomMass : MassQuantity
  ozoneGroundEnergy : DimEnergy
  oxygenMoleculeGroundEnergy : DimEnergy

/-- The SI readout of `ℏ`. -/
noncomputable def reducedPlanckConstantSI
    (p : PhotodissociationParameters) : ℝ :=
  scalarSI p.reducedPlanckConstant

/-- The SI readout of the speed of light. -/
noncomputable def lightSpeedSI (p : PhotodissociationParameters) : ℝ :=
  speedSI p.lightSpeed

/-- The SI readout of the mass `m` of one oxygen atom. -/
noncomputable def oxygenAtomMassSI (p : PhotodissociationParameters) : ℝ :=
  scalarSI p.oxygenAtomMass

/-- The energy gap `ΔU = U_f - U_i`, in joules. -/
noncomputable def energyDifferenceSI
    (p : PhotodissociationParameters) : ℝ :=
  scalarSI p.oxygenMoleculeGroundEnergy -
    scalarSI p.ozoneGroundEnergy

/--
Physical parameter and angle conditions.  The upper bound on `ΔU` is the
uniform discriminant condition for nonrelativistic two-fragment kinematics and
also keeps the square-root arguments in the recorded answer nonnegative
throughout `0 ≤ θ ≤ π`.
-/
structure ValidPhotodissociationParameters
    (p : PhotodissociationParameters) (θ : ℝ) : Prop where
  reducedPlanckConstant_pos : 0 < reducedPlanckConstantSI p
  lightSpeed_pos : 0 < lightSpeedSI p
  oxygenAtomMass_pos : 0 < oxygenAtomMassSI p
  energyDifference_nonneg : 0 ≤ energyDifferenceSI p
  twice_energyDifference_le_restEnergy :
    2 * energyDifferenceSI p ≤ oxygenAtomMassSI p * (lightSpeedSI p) ^ 2
  angle_nonneg : 0 ≤ θ
  angle_le_pi : θ ≤ Real.pi

/--
`DissociationAt p θ ω` states the governing laws for a photon of angular
frequency `ω`, measured in radians per second, producing the two fragments at
the Figure 1c angle `θ`.

The final `O₂` mass is `2m`, hence its kinetic energy denominator is
`2 * (2m)`.  The atomic oxygen denominator is `2m`.
-/
def DissociationAt
    (p : PhotodissociationParameters) (θ ω : ℝ) : Prop :=
  0 ≤ ω ∧
    ∃ photonMomentum oxygenMoleculeMomentum oxygenAtomMomentum :
        MomentumQuantity2,
      momentumSI photonMomentum =
          momentumSI oxygenMoleculeMomentum + momentumSI oxygenAtomMomentum ∧
      magnitude2 (momentumSI photonMomentum) =
          reducedPlanckConstantSI p * ω / lightSpeedSI p ∧
      dot2 (momentumSI photonMomentum) (momentumSI oxygenMoleculeMomentum) =
          magnitude2 (momentumSI photonMomentum) *
            magnitude2 (momentumSI oxygenMoleculeMomentum) * Real.cos θ ∧
      reducedPlanckConstantSI p * ω =
          energyDifferenceSI p +
            magnitude2 (momentumSI oxygenMoleculeMomentum) ^ 2 /
              (2 * (2 * oxygenAtomMassSI p)) +
            magnitude2 (momentumSI oxygenAtomMomentum) ^ 2 /
              (2 * oxygenAtomMassSI p)

/--
The proposed angular frequency is feasible and no smaller feasible
nonnegative frequency exists at the same outgoing `O₂` angle.
-/
def IsMinimumDissociationFrequency
    (p : PhotodissociationParameters) (θ : ℝ)
    (ωmin : AngularFrequencyQuantity) : Prop :=
  DissociationAt p θ (scalarSI ωmin) ∧
    ∀ ω : ℝ, DissociationAt p θ ω → scalarSI ωmin ≤ ω

/--
The recorded answer for the minimum photon angular frequency.  For acute and
right angles it is the angle-dependent expression; for obtuse angles it
saturates at the value obtained at `θ = π / 2`.
-/
theorem minimumAngularFrequency_eq
    (p : PhotodissociationParameters) (θ : ℝ)
    (ωmin : AngularFrequencyQuantity)
    (hvalid : ValidPhotodissociationParameters p θ)
    (hminimum : IsMinimumDissociationFrequency p θ ωmin) :
    (θ ≤ Real.pi / 2 →
      scalarSI ωmin =
        (3 * oxygenAtomMassSI p * (lightSpeedSI p) ^ 2 *
            (1 - Real.sqrt
              (1 -
                2 * energyDifferenceSI p /
                    (3 * oxygenAtomMassSI p * (lightSpeedSI p) ^ 2) *
                  (2 * (Real.sin θ) ^ 2 + 1)))) /
          (reducedPlanckConstantSI p * (2 * (Real.sin θ) ^ 2 + 1))) ∧
    (Real.pi / 2 ≤ θ →
      scalarSI ωmin =
        (oxygenAtomMassSI p * (lightSpeedSI p) ^ 2 *
            (1 - Real.sqrt
              (1 -
                2 * energyDifferenceSI p /
                  (oxygenAtomMassSI p * (lightSpeedSI p) ^ 2)))) /
          reducedPlanckConstantSI p) := by
  sorry

end IPhO2026Problems.IPhO2026_1_C_1

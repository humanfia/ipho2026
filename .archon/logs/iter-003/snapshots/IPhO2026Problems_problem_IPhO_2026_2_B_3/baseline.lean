import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Physlib.Units.WithDim.Basic

/-!
# IPhO 2026, problem 2, part B.3

This file models the half-cylindrical solar concentrator shown in Figure 2f.
Lengths and powers are dimensionful PhysLean quantities.  Geometrical-optics
notions for which PhysLean has no dedicated API are kept abstract and exposed
as explicit hypotheses.
-/

namespace IPhO2026Problems.IPhO2026_2_B_3

open Dimension UnitChoices

/-- A physical length, represented independently of the choice of units. -/
abbrev PhysicalLength := Dimensionful (WithDim L𝓭 ℝ)

/--
A physical power.  Its dimension is mass times length squared divided by time
cubed.
-/
abbrev OpticalPower :=
  Dimensionful
    (WithDim (M𝓭 * L𝓭 * L𝓭 * T𝓭⁻¹ * T𝓭⁻¹ * T𝓭⁻¹) ℝ)

/-- Unit choices obtained from SI by measuring length in centimetres. -/
noncomputable def centimeterUnits : UnitChoices :=
  { SI with length := LengthUnit.centimeters }

/-- The numerical readout of a physical length in metres. -/
noncomputable def lengthInMeters (length : PhysicalLength) : ℝ :=
  (length SI).val

/-- The numerical readout of a physical length in centimetres. -/
noncomputable def lengthInCentimeters (length : PhysicalLength) : ℝ :=
  (length centimeterUnits).val

/-- The numerical SI readout of an optical power. -/
noncomputable def powerInSI (power : OpticalPower) : ℝ :=
  (power SI).val

/-- The half-cylindrical mirror appearing in Figure 2f. -/
structure HalfCylindricalMirror (Axis : Type*) where
  axis : Axis
  radius : PhysicalLength

/-- The fully absorbing cylindrical container appearing in Figure 2f. -/
structure FullyAbsorbingCylinder (Axis : Type*) where
  axis : Axis
  radius : PhysicalLength

/-- The uniform parallel sunlight incident along the optical axis. -/
structure SunlightBeam (Axis : Type*) where
  opticalAxis : Axis

/-- The physical objects and center-to-center separation shown in Figure 2f. -/
structure Figure2fSetup (Axis : Type*) where
  mirror : HalfCylindricalMirror Axis
  container : FullyAbsorbingCylinder Axis
  sunlight : SunlightBeam Axis
  centerSeparation : PhysicalLength

/--
For the Figure 2f configuration, a fivefold absorbed power determines the
largest relevant incidence angle and the absorbing cylinder's radius.

The two equations `h_previous_B1_geometry` and `h_previous_B2_powerRatio`
faithfully expose the reusable conclusions of parts B.1 and B.2.  The
fivefold-power equation is the condition imposed by B.3; neither numerical
conclusion of B.3 is assumed.
-/
theorem radius_for_fivefold_power
    {Axis Ray : Type*}
    (setup : Figure2fSetup Axis)
    (Parallel : Axis → Axis → Prop)
    (IsUniformParallelIllumination :
      SunlightBeam Axis → HalfCylindricalMirror Axis → Prop)
    (IsOnMirrorSymmetryPlane :
      FullyAbsorbingCylinder Axis → HalfCylindricalMirror Axis → Prop)
    (IsAbsorbedBy : Ray → FullyAbsorbingCylinder Axis → Prop)
    (reflectionCount : Ray → ℕ)
    (IsLargestRelevantIncidenceAngle :
      ℝ → HalfCylindricalMirror Axis → FullyAbsorbingCylinder Axis → Prop)
    (IsNoMirrorBaselinePower :
      OpticalPower → FullyAbsorbingCylinder Axis → SunlightBeam Axis → Prop)
    (IsPowerAbsorbedWithMirror :
      OpticalPower → Figure2fSetup Axis → Prop)
    (thetaMax : ℝ)
    (P P₀ : OpticalPower)
    (h_axes_parallel :
      Parallel setup.mirror.axis setup.container.axis)
    (h_uniform_parallel_sunlight :
      IsUniformParallelIllumination setup.sunlight setup.mirror)
    (h_container_on_symmetry_plane :
      IsOnMirrorSymmetryPlane setup.container setup.mirror)
    (h_absorbed_rays_reflect_at_most_once :
      ∀ ray, IsAbsorbedBy ray setup.container → reflectionCount ray ≤ 1)
    (h_thetaMax_role :
      IsLargestRelevantIncidenceAngle thetaMax setup.mirror setup.container)
    (h_thetaMax_range : 0 ≤ thetaMax ∧ thetaMax ≤ Real.pi / 2)
    (h_figure2f_center_separation :
      lengthInMeters setup.centerSeparation =
        lengthInMeters setup.mirror.radius / 2)
    (h_mirror_radius :
      lengthInMeters setup.mirror.radius = 1)
    (h_baseline_power_role :
      IsNoMirrorBaselinePower P₀ setup.container setup.sunlight)
    (h_absorbed_power_role :
      IsPowerAbsorbedWithMirror P setup)
    (h_baseline_power_positive : 0 < powerInSI P₀)
    (h_previous_B1_geometry :
      lengthInMeters setup.container.radius =
        lengthInMeters setup.mirror.radius * Real.sin thetaMax -
          (lengthInMeters setup.mirror.radius / 2) *
            Real.sin (2 * thetaMax))
    (h_previous_B2_powerRatio :
      powerInSI P / powerInSI P₀ =
        1 / (1 - Real.cos thetaMax))
    (h_fivefold_absorbed_power :
      powerInSI P = 5 * powerInSI P₀) :
    Real.cos thetaMax = (4 : ℝ) / 5 ∧
      lengthInMeters setup.container.radius = (3 : ℝ) / 25 ∧
      lengthInCentimeters setup.container.radius = 12 := by
  sorry

end IPhO2026Problems.IPhO2026_2_B_3

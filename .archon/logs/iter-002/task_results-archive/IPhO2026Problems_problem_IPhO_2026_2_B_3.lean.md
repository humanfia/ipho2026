# Autoformalization result

## Assumption/target split

### Governing laws and setup constraints

- `h_absorbed_rays_reflect_at_most_once` states that every ray absorbed by the
  container has reflection count at most one.
- `h_uniform_parallel_sunlight` assigns the source its stated uniform,
  parallel-illumination role.
- `h_axes_parallel` states that the mirror and cylinder axes are parallel.
- `h_container_on_symmetry_plane` states that the cylinder lies on the
  mirror's symmetry plane.
- `h_thetaMax_role` identifies `thetaMax` as the largest incidence angle among
  the relevant mirror-to-container rays; `h_thetaMax_range` supplies its
  physical range.
- `h_baseline_power_role` identifies `P₀` as the no-mirror baseline power, and
  `h_absorbed_power_role` identifies `P` as the with-mirror absorbed power.
- `h_baseline_power_positive` records the physically necessary positivity of
  the incident baseline power.

### Previous-part results

- `h_previous_B1_geometry` is the B.1 result
  `a = R sin(thetaMax) - (R/2) sin(2 thetaMax)`.
- `h_previous_B2_powerRatio` is the B.2 result
  `P/P₀ = 1/(1 - cos(thetaMax))`.
- These are restated locally, in accordance with the
  `natural_language_prerequisite_only` policy; the Lean outputs of B.1 and B.2
  are not imported.

### Figure/data readouts and current-condition data

- `Figure2fSetup` contains the half-cylindrical mirror, fully absorbing
  cylinder, incident sunlight, their axes, radii, and center separation.
- `h_figure2f_center_separation` records the Figure 2f readout that the center
  separation is `R/2`.
- `h_mirror_radius` records the current numerical datum `R = 1 m`.
- `h_fivefold_absorbed_power` is the condition imposed by the current question,
  `P = 5 P₀`; it is not the requested radius.

### Current target conclusions

- `Real.cos thetaMax = 4/5`.
- The cylinder radius has SI readout `3/25 m = 0.12 m`.
- The same physical radius has centimetre readout `12 cm`.

## Goal-faithfulness audit

The numerical conclusions `cos(thetaMax) = 4/5`, `a = 3/25 m`, and
`a = 12 cm` occur only in the conclusion of
`radius_for_fivefold_power`.  No role predicate, structure field, hypothesis,
or local definition contains any of them.  In particular,
`h_fivefold_absorbed_power` is the condition “such that `P = 5 P₀`” from the
question, while the cylinder radius remains unknown.  `lengthInMeters`,
`lengthInCentimeters`, and `powerInSI` are only unit/readout projections from
dimensionful physical quantities and do not encode the target formula.

## Declarations created and blueprint correspondence

- `PhysicalLength`, `OpticalPower`: dimensional physical quantity types.
- `centimeterUnits`, `lengthInMeters`, `lengthInCentimeters`, `powerInSI`:
  explicit unit choices and scalar readouts.
- `HalfCylindricalMirror`, `FullyAbsorbingCylinder`, `SunlightBeam`,
  `Figure2fSetup`: the Figure 2f physical model.
- `IPhO2026Problems.IPhO2026_2_B_3.radius_for_fivefold_power` corresponds to
  `thm:physics:IPhO_2026_2_B_3:target`.

The target theorem statement is formalized and compiles with its required
`by sorry` body, so the blueprint theorem environment is ready for statement
`\leanok`.

## LeanExplore queries/candidates actually used

- Query `physical dimensions SI length quantity meter centimeter` found
  `UnitChoices.SI`, `UnitChoices.SI_length`, `LengthUnit`,
  `LengthUnit.centimeters`, `Dimension`, and `UnitExamples.meters400`.
- Query `LengthUnit.meters LengthUnit.centimeters Quantity measurement convert
  length units` confirmed `LengthUnit.centimeters` and the unit-scaling API.
- Query `Dimensionful WithDim L𝓭 toDimensionful SI scalar value in units
  equality conversion` found `Dimensionful`,
  `CarriesDimension.toDimensionful`,
  `CarriesDimension.toDimensionful_apply_apply`, and
  `Dimensionful.of_scaleUnit`.
- Query `physical power energy per unit time dimension power quantity watt
  WithDim` found `DimEnergy`, `Dimension`, and `WithDim`, but no packaged
  `DimPower`/watt quantity.
- Queries `geometrical optics cylindrical mirror reflected ray incidence angle
  absorbing cylinder` and `Optics Ray reflection law incidenceAngle
  cylindricalMirror` returned mathematical near-misses such as
  `EuclideanGeometry.reflection`, `RayVector`, and `Module.Ray`, not a
  cylindrical geometrical-optics model.

Source/module details were fetched for `LengthUnit`,
`LengthUnit.centimeters`, `UnitChoices.SI_length`,
`UnitExamples.meters400`, `Dimensionful`,
`CarriesDimension.toDimensionful`,
`CarriesDimension.toDimensionful_apply_apply`,
`Dimensionful.of_scaleUnit`, and `UnitChoices.SI`.

## PhysLean/Mathlib names grounded

- PhysLean/Physlib:
  `Dimensionful`, `WithDim`, `Dimension.L𝓭`, `Dimension.M𝓭`,
  `Dimension.T𝓭`, `UnitChoices`, `UnitChoices.SI`, and
  `LengthUnit.centimeters`.
- Mathlib: `Real.sin`, `Real.cos`, and `Real.pi`.
- Imports actually used:
  `Physlib.Units.WithDim.Basic` and
  `Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic`.

## Local abstractions introduced

- `OpticalPower` uses the genuine physical dimension
  `M L² T⁻³` via `Dimensionful (WithDim ... ℝ)` because LeanExplore found no
  packaged power type.
- Axes and rays remain abstract type parameters.  The semantic notions
  `Parallel`, `IsUniformParallelIllumination`, `IsOnMirrorSymmetryPlane`,
  `IsAbsorbedBy`, `IsLargestRelevantIncidenceAngle`,
  `IsNoMirrorBaselinePower`, and `IsPowerAbsorbedWithMirror` are explicit
  predicate interfaces.  This preserves their physical roles without
  inventing a false scalar encoding or importing unrelated Euclidean
  reflection APIs.

## Grounding gaps

- PhysLean currently exposes dimensional quantities and general Euclidean
  reflection infrastructure but no ready-made half-cylindrical
  geometrical-optics/ray-tracing model matching Figure 2f.
- No packaged optical-power/watt type was found; the correct physical
  dimension is assembled from PhysLean dimensions.
- The blueprint target currently has no `\lean{...}` declaration name.  The
  plan/review layer should attach
  `\lean{IPhO2026Problems.IPhO2026_2_B_3.radius_for_fivefold_power}` so the
  sync can associate and mark the formalized statement.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors; exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_3.lean`: exit code 0,
  with exactly the expected `sorry` warning.

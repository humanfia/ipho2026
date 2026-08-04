# Autoformalization result: IPhO 2026 problem 4 C.7

## Assumption/target split

### Governing laws

- Equation (4): the heat rate received by IC is
  `(T_OC - T_IC) / R_Th`.
- Orientation convention: the signed outward radial heat flow is the negative
  of the heat rate received by IC.
- Equation (6): signed outward radial heat flow is
  `-λ * (2 * π * r * h) * dT/dr`.
- The radial temperature profile has the stated derivative throughout the
  closed acrylic-wall interval and matches `T_IC` at `r₁` and `T_OC` at `r₂`.
- The effective resistance and acrylic conductivity are positive.

### Previous-part results

- C.6 supplies `R_Th = 1 / (c₀ * m * slope)` without importing its Lean file.
- The official C.6 sample is represented by
  `|R_Th - 1.17| ≤ 0.03` K/W.

### Figure/data readouts

- Figure labels `r₁`, `r₂`, and active height `h` are represented as
  dimensionful lengths, with `0 < r₁ < r₂`.
- The listed procedure readouts are `h_IC = 0.10 m` and `h_OC = 0.15 m`;
  the active conducting height is the common wetted height `h_IC`.
- At the selected observation time, `T_OC - T_IC ≠ 0`, permitting the
  experimental temperature gap to be cancelled.
- Time, radius, temperature-gradient, and equation readouts are explicitly
  named as SI scalar components; the underlying lengths, temperatures,
  powers, resistance, conductivity, mass, heat capacity, and graph slope
  remain Physlib dimensionful quantities.

### Current target conclusion

- The only current substantive conclusion is
  `λ = log (r₂ / r₁) / (2 * π * h * R_Th)`, stated by
  `acrylicConductivity_from_radial_fourier`.

## Goal-faithfulness audit

The conductivity formula does not occur in `Figure17AndProcedureReadout`,
`PreviousPartC6Result`, `CylindricalConductionLaws`, or any helper definition.
The Fourier-law field contains only the local differential constitutive law,
and the C.6 premise contains only the permitted resistance result. The
logarithmic relation remains to be obtained by integrating the radial
temperature gradient between the two boundary radii and cancelling the
nonzero observed temperature difference.

Equation (4) describes heat received by IC, while equation (6) is represented
with outward radial orientation. The explicit `radial_orientation` field
relates these by a minus sign. This preserves the displayed minus sign in
Fourier's law without making the assumptions inconsistent with the positive
official conductivity formula.

## Declarations created

- Dimensional infrastructure:
  `powerDimension`, `thermalResistanceDimension`,
  `thermalConductivityDimension`, `specificHeatCapacityDimension`,
  `DimLength`, `DimMass`, `DimTemperature`, `DimPower`,
  `DimThermalResistance`, `DimThermalConductivity`,
  `DimSpecificHeatCapacity`, `DimInverseTime`, and `siValue`.
- Geometry and readouts:
  `ApparatusGeometry` and `Figure17AndProcedureReadout`.
- Previous-part interface:
  `PreviousPartC6Data` and `PreviousPartC6Result`.
- Experiment and laws:
  `ThermalConductionExperiment`, `cylindricalWallAreaMetersSquared`, and
  `CylindricalConductionLaws`.
- Blueprint label `thm:physics:IPhO_2026_4_C_7:target` corresponds to
  `IPhO2026Problems.IPhO2026_4_C_7.acrylicConductivity_from_radial_fourier`.
  The declaration is ready for the deterministic `leanok` synchronization.

## LeanExplore queries/candidates actually used

- `thermal conductivity Fourier heat conduction thermal resistance`:
  no thermal-conduction API was found; Fourier-transform declarations were
  unrelated near misses.
- `physical dimensions units thermal conductivity power temperature length`
  and `Physlib.Units SIUnit length temperature power`:
  selected `Dimension` and `UnitChoices.SI`.
- `Dimension.length`, `Dimension.temperature`, `Dimension.time`,
  `Dimension.energy`, and `Dimension.mass`:
  selected the Physlib base dimensions `Dimension.L𝓭`, `Dimension.T𝓭`,
  `Dimension.M𝓭`, and `Dimension.Θ𝓭`; `DimEnergy` confirmed Physlib's
  dimension-tagging pattern.
- `UnitDependent Dimension quantity value`:
  selected `Dimensionful` and the `WithDim` representation; inspected
  `WithDim.scaleUnit_val` as confirmation of the unit-scaling interface.
- `Real.log logarithm positive ratio`:
  selected Mathlib's `Real.log`.

For the selected candidates, source/module/docstring data were fetched for
`Dimension`, `UnitChoices.SI`, `Dimensionful`, `WithDim.scaleUnit_val`,
`DimEnergy`, and `Real.log`.

## Physlib/Mathlib names grounded

- Physlib:
  `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`, `Dimension.M𝓭`,
  `Dimension.Θ𝓭`, `Dimensionful`, `WithDim`, and `UnitChoices.SI`.
- Mathlib:
  `Real.log`, `Real.pi`, `HasDerivAt`, and `Set.Icc`.

## Local abstractions introduced

- The problem-specific dimension aliases are built from Physlib's
  unit-dependent `Dimensionful (WithDim d ℝ)` quantities, rather than scalar
  aliases. This retains the physical dimension and unit-scaling behavior.
- `CylindricalConductionLaws` is a local interface because the search found
  no Physlib/Mathlib thermal Fourier-conduction law. It states the actual
  heat-flow equations, radial geometry, derivative, and boundary conditions,
  not the requested final formula.
- `PreviousPartC6Result` preserves the natural-language prerequisite policy
  while keeping the graph result physically typed.

## Grounding gaps

- No Mathlib/Physlib declaration for cylindrical thermal conduction or
  thermal resistance was found.
- The chapter and its two listed source-page images do not provide numerical
  Figure 17 radius values. Therefore `r₁` and `r₂` are faithfully retained as
  positive ordered figure quantities. A future blueprint redraft should add
  the exact Figure 17 radius readouts if the official numerical
  `0.25 ± 0.01 W/(m*K)` sample is to become a separate formal conclusion.
- `archon dag-query` could not be run because `archon` was not available on
  this prover lane's `PATH`; the chapter's previous-part policy independently
  forbids importing the C.6 Lean output.

## Verification

- `archon-lean-lsp` diagnostics: only the expected declaration-uses-`sorry`
  warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`: success with
  the same single expected warning.
- `git diff --check`: clean.

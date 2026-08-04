# Autoformalization result

## Assumption/target split

### Governing laws

- `SatisfiesToroidalAmpereCircuitalLaw` keeps three physically distinct
  statements explicit: Ampère's circuital law
  `∮_C H · dℓ = I_C`, the uniform-field evaluation
  `∮_C H · dℓ = Hℓ`, and the linked-free-current evaluation `I_C = NI`.
- `SatisfiesParamagneticConstitutiveLaw` states
  `B = μ₀ H + μ₀ M` on the parallel field magnitudes and records `μ₀ > 0`.
- `UsesUniformParallelFieldApproximation` records that `H`, `B`, and `M` are
  approximately uniform and that the paramagnetic magnetization is parallel
  to `H`.

### Previous-part results

- There are no previous-part results or Lean dependencies for A.1.

### Figure/data readouts and setup

- `ParamagneticTorus` contains the Figure 3a quantities: mean radius `R`,
  cross-section radius `r` (the figure labels its diameter `2r`), area `A`,
  volume `V`, and the central Ampère-loop length `ℓ`.
- `HasFigure3aGeometry` records positivity and the geometric relations
  `ℓ = 2πR`, `A = πr²`, and `V = Aℓ`.
- `IsThinToroidAtScale` makes `r ≪ R` explicit as `r ≤ εR`, with
  `0 < ε < 1`.
- `ToroidalWinding` records the number of turns `N`, insulation, dense
  winding, the external voltage source, and negligible ohmic heating.
- `ToroidalMagneticState` contains the instantaneous current magnitude `I`
  and the scalar magnitudes `H`, `B`, and `M`.
- `HasNonnegativeMagnitudes` records that the quantities called magnitudes
  have nonnegative SI readouts.
- `EnergyTransferSignConvention.positiveIntoTorus` captures the stated rule
  that work and heat entering the torus are positive.

### Current target conclusion

- `fieldStrength_eq_turns_current_area_div_volume` concludes exactly
  `H = N I A / V`, expressed using coherent SI readouts of dimensionful
  quantities.

## Goal-faithfulness audit

The requested relation `H = N I A / V` occurs only in the conclusion of
`fieldStrength_eq_turns_current_area_div_volume` (apart from explanatory
docstrings). It is not a structure field, governing-law field, hypothesis, or
definition.

In particular, the Ampère predicate stops at the independent relations
`circulation = linked current`, `circulation = Hℓ`, and `linked current = NI`.
The geometry predicate independently states `V = Aℓ`. Combining these facts
and using positive volume is the substantive proof still represented by
`sorry`. `siReadout` is only the projection of a dimensionful quantity into
coherent SI units and contains no target-specific formula. The constitutive
law, material assumptions, thinness, winding data, and sign convention also
contain no occurrence of the requested answer.

## Declarations created and blueprint correspondence

- Dimensional roles:
  `electricCurrentDimension`, `magneticFieldStrengthDimension`,
  `vacuumPermeabilityDimension`, `magneticFluxDensityDimension`.
- Physical scalar types:
  `PhysicalLength`, `PhysicalArea`, `PhysicalVolume`,
  `ElectricCurrentMagnitude`, `MagneticFieldStrengthMagnitude`,
  `MagnetizationMagnitude`, `VacuumPermeabilityMagnitude`, and
  `MagneticFluxDensityMagnitude`.
- Unit projection: `siReadout`.
- Physical model:
  `ParamagneticTorus`, `ToroidalWinding`, `ToroidalMagneticState`,
  `ToroidalAmpereReadouts`, and `EnergyTransferSignConvention`.
- Setup/law predicates:
  `HasStatedMaterialProperties`, `HasFigure3aGeometry`,
  `IsThinToroidAtScale`, `HasStatedWindingProperties`,
  `UsesUniformParallelFieldApproximation`, `HasNonnegativeMagnitudes`,
  `SatisfiesParamagneticConstitutiveLaw`, and
  `SatisfiesToroidalAmpereCircuitalLaw`.
- `IPhO2026Problems.IPhO2026_3_A_1.fieldStrength_eq_turns_current_area_div_volume`
  corresponds to blueprint label
  `thm:physics:IPhO_2026_3_A_1:target`.

The theorem statement compiles with its required `by sorry` body and is ready
for statement `\leanok`. Per the project role rules, the prover did not edit
the blueprint; marker synchronization is handled after this lane.

## LeanExplore queries/candidates actually used

- `Ampere's circuital law magnetic field strength closed curve current
  electromagnetism` found relativistic field/potential declarations such as
  `Electromagnetism.ElectromagneticPotential.isExtrema_iff_gauss_ampere_magneticFieldMatrix`
  and `Electromagnetism.MagneticField`, but no material-field circuital law.
- `physical dimension quantities SI units length area volume electric current
  magnetic field strength` found `UnitChoices.SI`, `Dimension`,
  `Dimension.L𝓭`, `DimArea`, `WithDim`, and
  `Electromagnetism.MagneticField`.
- `Quantity physical dimension unit system value SI dimensional scalar
  PhysLean` and `WithDim dimension tagged quantity definition` found
  `Dimensionful`, `WithDim`, `WithDim.scaleUnit_val`, and the unit-scaling
  infrastructure.
- `Dimension charge time inverse multiplication division physical dimension
  definitions L𝓭 T𝓭 Q𝓭` found `Dimension.C𝓭`, `Dimension.T𝓭`,
  `Dimension.L𝓭`, the `Dimension` commutative-group operations, and
  dimension-tagged multiplication/division.
- `physical volume dimensionful WithDim volume cubic meter DimVolume` found
  `Dimensionful`, `WithDim`, and `Dimension`, but no packaged physical-volume
  type.
- Exact searches for
  `Electromagnetism.ThreeDimension.ampereLaw` did not expose the local
  differential theorem through LeanExplore; the closest indexed candidates
  concerned vacuum electromagnetic potentials.

Source/module details were fetched for:

- `WithDim` — `Physlib.Units.WithDim.Basic`.
- `Dimension` — `Physlib.Units.Dimension`.
- `UnitChoices.SI` — `Physlib.Units.Basic`.
- `Dimensionful` — `Physlib.Units.Basic`.
- `Electromagnetism.MagneticField` — inspected as a near miss.

## PhysLean/Mathlib names grounded

- PhysLean/Physlib:
  `Dimensionful`, `WithDim`, `Dimension`, `Dimension.L𝓭`,
  `Dimension.T𝓭`, `Dimension.M𝓭`, `Dimension.C𝓭`, `UnitChoices`, and
  `UnitChoices.SI`.
- Mathlib: `Real.pi`.
- Imports actually used:
  `Physlib.Units.WithDim.Basic` and
  `Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic`.

## Local abstractions introduced

- The physical scalar aliases are genuine Physlib
  `Dimensionful (WithDim d ℝ)` quantities. They are not transparent scalar
  aliases: their scaling law and physical dimension are part of their type.
- `ToroidalAmpereReadouts` preserves the physical distinction between field
  circulation and linked free current. This is the smallest local interface
  for the integral material-field Ampère law used in the problem.
- `ParamagneticTorus`, `ToroidalWinding`, and `ToroidalMagneticState` preserve
  the apparatus, material, and instantaneous-state roles rather than
  flattening all parameters into unrelated reals.
- `IsThinToroidAtScale` introduces the dimensionless approximation tolerance
  `ε` so that the informal `r ≪ R` is not replaced by an arbitrary equality.

## Grounding gaps and redraft requests

- Physlib's local
  `Electromagnetism.ThreeDimension.ampereLaw` is the differential Maxwell
  equation for the vacuum-style `B` field. It does not state
  `∮ H · dℓ = I_free` in magnetic material, so it cannot replace the local
  circuital-law interface.
- No packaged Physlib types were found for physical volume, electric-current
  magnitude, material magnetic field strength `H`, magnetization magnitude,
  vacuum permeability, or flux-density magnitude. They are assembled from
  the grounded foundational dimensions.
- The blueprint theorem environment currently has no `\lean{...}` declaration
  name. The plan/review layer should attach
  `\lean{IPhO2026Problems.IPhO2026_3_A_1.fieldStrength_eq_turns_current_area_div_volume}`
  so deterministic marker synchronization can associate the statement.
- The read-only `archon dag-query` navigation command was unavailable on
  `PATH` in this prover environment, so no dependency-graph data were used.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors; exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`: exit code 0,
  with exactly the expected `sorry` warning.

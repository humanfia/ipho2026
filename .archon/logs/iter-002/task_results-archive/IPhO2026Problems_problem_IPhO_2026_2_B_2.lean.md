# Autoformalization result: IPhO 2026 Problem 2 B.2

## Assumption/target split

### Governing laws

- `HasUniformParallelSunlight o` states that the incident solar bundle is
  nonempty, parallel to the optical axis, and has one positive constant
  irradiance.
- `IsFullyAbsorbing o` states that every ray reaching the cylindrical
  container is absorbed.
- `IsSingleReflectionRegime o` states that any ray absorbed by the container
  reflected at most once.
- `IsLargestRelevantIncidenceAngle o` states that `thetaMax` is attained and
  bounds the incidence angle, measured from the mirror normal, of all
  once-reflected rays that hit the container.
- `SatisfiesProjectedAperturePowerLaws o` is the uniform-irradiance law
  `power = irradiance * projected area`. It separately assigns projected
  widths `2 R sin(thetaMax)` with the mirror and `2 a` without the mirror.
  Both projected areas have the same illuminated axial length.

### Previous-part results

- `HasPartB1RadiusRelation g o.thetaMax` records the permitted
  natural-language result of B.1 after substituting
  `alpha = R` and `beta = -R/2`:
  `a = R sin(thetaMax) - (R/2) sin(2 thetaMax)`.
- No Lean declaration from part B.1 is imported.

### Figure/data readouts

- `Figure2fGeometry` records the half-cylindrical mirror and cylindrical
  container, their centers and axes, the mirror optical axis, radii, common
  illuminated axial length, symmetry plane, center distance, and abstract
  parallelism relation.
- `HasFigure2fPlacement g` records that the cylinder axes are parallel, both
  centers lie on the symmetry plane, and their center separation is `R/2`.
- `OpticalModel g` distinguishes actual received power `P`, no-mirror power
  `P₀`, solar irradiance, incoming and relevant rays, reflection counts, and
  the figure angle `thetaMax`.
- The theorem hypotheses record the physical range
  `0 < thetaMax < pi/2` and positive mirror radius, container radius, and
  illuminated length.
- The official source image `T2_page-3.png` was inspected to confirm Figure 2f
  labels `R`, `a`, `R/2`, the parallel cylinder axes, and the angle's
  mirror-normal convention.

### Current target conclusions

- The only current conclusion is the requested dimensionless power ratio:
  `P / P₀ = 1 / (1 - cos(thetaMax))`, represented using the real readouts of
  the two quantities carrying the same physical power dimension.

## Goal-faithfulness audit

The formula `1 / (1 - Real.cos o.thetaMax)` occurs only in the conclusion of
`problem_IPhO_2026_2_B_2`. It does not occur in a structure field, hypothesis,
governing-law predicate, previous-part predicate, or helper definition.

In particular, `SatisfiesProjectedAperturePowerLaws` does not assume the
requested ratio. It gives two independent physical power balances in terms of
irradiance and projected collection widths. The B.1 hypothesis independently
relates `a`, `R`, and `thetaMax`; a later proof must still use the double-angle
identity and nonzero physical factors to derive the target. No definition
unfolds to the target formula.

## Declarations created and blueprint correspondence

- `LengthQuantity`, `PowerQuantity`, and `IrradianceQuantity`: quantities
  carrying Physlib length, power, and power-per-area dimensions.
- `powerDimension` and `irradianceDimension`: explicit physical dimensions
  `M L² T⁻³` and `M T⁻³`.
- `Figure2fGeometry`: labeled apparatus geometry.
- `OpticalModel`: ray, incidence-angle, irradiance, and power data.
- `HasFigure2fPlacement`
- `HasUniformParallelSunlight`
- `IsFullyAbsorbing`
- `IsSingleReflectionRegime`
- `IsLargestRelevantIncidenceAngle`
- `HasPartB1RadiusRelation`
- `SatisfiesProjectedAperturePowerLaws`
- `IPhO2026Problems.IPhO2026_2_B_2.problem_IPhO_2026_2_B_2` corresponds to
  blueprint label `thm:physics:IPhO_2026_2_B_2:target`.

The theorem statement compiles with its required `by sorry` body and is ready
for deterministic statement `\leanok` synchronization.

## LeanExplore queries/candidates actually used

All searches used package filters `["Mathlib", "Physlib"]`.

- Query `geometric optics reflection ray mirror irradiance optical power`
  returned `RayVector`, `Module.Ray`, `SameRay`, and generic Euclidean/module
  reflections. They were assessed as near misses for curved-mirror optical
  ray tracing.
- Query `physical dimensions power irradiance intensity SI units length angle`
  returned `UnitChoices.SI`, `Dimension`, `Dimension.L𝓭`, and
  `Real.Angle.toReal`.
- Query `dimensionful quantity with physical dimension value in unit system`
  returned `Dimensionful`, `WithDim`, `CarriesDimension.toDimensionful`, and
  related scaling declarations.
- Query `Real.cos cosine angle` confirmed the Mathlib real trigonometric API,
  including `Real.cos` lemmas.
- Queries `Dimension length power energy time inverse physical dimensions` and
  `DimPower DimLength DimArea DimEnergy` found `Dimension`, `Dimension.L𝓭`,
  `DimEnergy`, and dimension operations, but no packaged `DimPower`.

Source/module data were fetched for `WithDim`
(`Physlib.Units.WithDim.Basic`), `Dimensionful`
(`Physlib.Units.Basic`), `Dimension`
(`Physlib.Units.Dimension`), and `UnitChoices.SI`. `WithDim` and `Dimension`
were used; `Dimensionful` and `UnitChoices.SI` were assessed but were not
needed because all scalar readouts in this theorem use one common coherent
unit system.

## PhysLean/Mathlib names grounded

- Physlib: `Dimension`, `Dimension.L𝓭`, `Dimension.M𝓭`,
  `Dimension.T𝓭`, and `WithDim`.
- Mathlib: `Real.sin`, `Real.cos`, and `Real.pi`.
- Imports used:
  `Physlib.Units.WithDim.Basic` and
  `Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic`.

The Archon Lean LSP additionally confirmed `WithDim` locally and successfully
elaborated the intended declarations before the file was written.

## Local abstractions introduced

- Physlib has no packaged optical-power type, so `PowerQuantity` uses
  `WithDim` with the genuine dimension `M L² T⁻³`; irradiance is tagged as
  power per area. These are not scalar aliases.
- `Figure2fGeometry` leaves points, axes, parallelism, symmetry-plane
  incidence, and center distance abstract. This is the smallest interface
  retaining the figure's geometric roles without inventing unrelated
  coordinates.
- `OpticalModel` leaves rays abstract but explicitly records incoming status,
  mirror/container hits, absorption, parallelism to the optical axis,
  reflection count, normal-based incidence angle, and irradiance. Its
  predicates state the physical laws needed by the chapter.

## Grounding gaps and redraft requests

- No ready-made Physlib curved-mirror geometrical-optics, half-cylinder,
  optical-ray reflection, irradiance, or optical-power API matching Figure 2f
  was found. The local abstractions preserve those roles explicitly.
- The read-only dependency navigation command was unavailable in this prover
  environment (`archon: command not found`). This causes no imported
  dependency gap because the chapter explicitly requires B.1 to be restated
  only as a natural-language prerequisite.
- The blueprint target currently has no `\lean{...}` declaration name. The
  plan/review layer should attach
  `\lean{IPhO2026Problems.IPhO2026_2_B_2.problem_IPhO_2026_2_B_2}` so the sync
  can associate the formalized statement.
- The assigned Lean file did not exist initially, so there was no
  file-specific `/- USER: ... -/` comment to apply.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`: exit code 0
  with exactly the same expected warning.

# Autoformalization result: IPhO 2026 Problem 2 B.1

## Assumption/target split

### Governing laws

- `ValidSolarCookerPhysics setup` states positivity of the dimensional mirror
  and container radii, solar irradiance, and reference power.
- Its geometric fields state that the two cylinder axes are parallel, the
  mirror surface is a half circular arc of radius `R`, the container boundary
  is a circle of radius `a`, and the mirror normal at each surface point is
  radial.
- Its sunlight fields state that every incoming ray is parallel to the
  optical axis and carries the same positive irradiance.
- Its path fields state that reflection points and reflected segments match,
  reflected segments meet incident rays at the mirror surface, and incidence
  and reflection angles are measured from the radial surface normal.
- `specular_reflection_law` states equality of the normal-based incidence and
  reflection angles.
- `fully_absorbing_container` states that every physical path hitting the
  container is absorbed.
- `absorbed_paths_reflect_at_most_once` states the problem's one-reflection
  regime.
- The `thetaMax` fields state that the angle is in the physical half-cylinder
  range, is an upper bound for once-reflected absorbed paths, and is attained.
- `limiting_tangent_path_exists` supplies the limiting reflected ray tangent
  to the container for the symbolic radius response. It does not supply a
  trigonometric formula or either requested coefficient.

### Previous-part results

- None. The source report records no prerequisites for part B.1, and the file
  imports no earlier problem output.

### Figure/data readouts

- `Figure2fReadout setup` records the three labels visible in the official
  Figure 2f: mirror diameter `2R`, container radius `a`, and center offset
  `R/2`.
- It also records that the two centers have the labeled separation, lie on
  the symmetry/optical axis, and that the actual radius is the response at
  `thetaMax`.
- `SolarCookerSetup` retains the half-cylindrical mirror and cylindrical
  container centers and axes, optical axis, dimension-tagged `R` and `a`,
  uniform sunlight intensity, no-mirror power `P₀`, `thetaMax`, ray/path
  predicates, tangent limiting paths, and the symbolic radius response.
- The official source image `T2_page-3.png` was inspected. It confirms labels
  `2R`, `a`, and `R/2`, parallel cylinder axes, axial uniform sunlight, the
  fully absorbing cylinder, and the normal-based definition of `thetaMax`.

### Current target conclusions

- `radiusAtIncidence_from_figure2f` concludes the substantive intermediate
  ray-tracing relation
  `a(θ) = R * (sin θ - (1/2) * sin (2θ))`.
- `problem_IPhO_2026_2_B_1` concludes exactly
  `α = R ∧ β = -(1/2) R`, with `α`, `β`, and `R` all carrying the physical
  length dimension.

## Goal-faithfulness audit

The requested equalities `α = R` and `β = -R/2` occur only in the conclusion
of `problem_IPhO_2026_2_B_1`. They do not occur in `SolarCookerSetup`,
`Figure2fReadout`, `ValidSolarCookerPhysics`, or any governing-law field.

`IsRadiusCoefficientFormula` records only the relation supplied by the
question: the symbolic radius response has the form
`α sin θ + β sin (2θ)`. It neither assigns a value to either coefficient nor
defines the response by the desired answer. Interpreting “coefficients” as a
symbolic identity over the admissible angular range avoids the logically
underdetermined reading of a single numerical equation at one fixed angle.

`radiusAtIncidence` is an abstract physical response field. It is constrained
by realizable limiting, tangent, specular paths; it is not locally defined as
the target formula. The closed-form response is the conclusion of a separate
`by sorry` theorem, so unfolding a definition cannot prove either substantive
claim. `scaleLength` only implements multiplication by a dimensionless scalar
on an already dimension-tagged length.

## Declarations created and blueprint correspondence

- `PhysicalLength`, `radiantPowerDimension`, `solarIntensityDimension`,
  `RadiantPower`, and `SolarIntensity`: explicit dimension-carrying physical
  quantities.
- `scaleLength`: dimension-preserving scalar multiplication for lengths.
- `CrossSection`, `AxisDirection`, `RayDirection2D`,
  `ParallelDirections`, `LightRay2D`, `PointLiesOnForwardRay`, and
  `OpticalPath2D`: geometric-optics data.
- `SolarCookerSetup`: apparatus, figure quantities, ray observables, and the
  abstract incidence-to-radius response.
- `IsAdmissibleIncidenceAngle`, `Figure2fReadout`, and
  `ValidSolarCookerPhysics`: physical range, figure readouts, and governing
  laws.
- `IsRadiusCoefficientFormula`: the supplied two-term sinusoidal form.
- `radiusAtIncidence_from_figure2f`: the ray-tracing intermediate theorem.
- `IPhO2026Problems.IPhO2026_2_B_1.problem_IPhO_2026_2_B_1` corresponds to
  blueprint label `thm:physics:IPhO_2026_2_B_1:target`.

Both theorem bodies are `by sorry`, as required by the autoformalization
stage. The declarations are ready for deterministic statement `\leanok`
synchronization after the blueprint receives its `\lean{...}` association.

## LeanExplore queries/candidates actually used

All searches used package filters `["Mathlib", "Physlib"]`.

- Query `geometric optics law of reflection incident ray reflected ray angle
  with surface normal` returned `RayVector`,
  `EuclideanGeometry.reflection`, and generic linear/affine reflection
  declarations. `RayVector` was used for nonzero optical and cylinder-axis
  directions; the generic reflection declarations were near misses because
  they do not model a curved mirror or incident/reflected light paths.
- Query `Real.sin sine twice angle two_mul trigonometric identity` returned
  `Real.sin`, `Real.sin_two_mul`, and related trigonometric declarations.
  `Real.sin` is used in the statements; `Real.sin_two_mul` grounds the later
  coefficient proof route.
- Queries `physical dimensions length quantity SI unit length meter radius`,
  `physical quantity with dimension units value quantity PhysLean`, and
  `WithDim dimension-tagged real value physical quantity length definition`
  returned `Dimension`, `Dimension.L𝓭`, `UnitChoices.SI`, `WithDim`, and its
  dimension-aware operations. `Dimension`, `Dimension.L𝓭`, `UnitChoices`,
  and `WithDim` were used.
- Queries `physical dimension power energy per time radiant power intensity
  power per unit area` and `Dimension mass dimension M𝓭 time T𝓭
  multiplication inverse` returned `Dimension.M𝓭`, `Dimension.T𝓭`,
  `DimEnergy`, and dimension operations, but no packaged radiant-power or
  irradiance type.

Source and module data were fetched for `Dimension`
(`Physlib.Units.Dimension`), `Dimension.L𝓭`
(`Physlib.Units.Dimension`), `WithDim`
(`Physlib.Units.WithDim.Basic`), `UnitChoices.SI`
(`Physlib.Units.Basic`), `UnitChoices.SI_length`
(`Physlib.Units.Basic`), `RayVector`
(`Mathlib.LinearAlgebra.Ray`), and `Real.sin`
(`Mathlib.Analysis.Complex.Trigonometric`).

## PhysLean/Mathlib names grounded

- Physlib: `Dimension`, `Dimension.L𝓭`, `Dimension.M𝓭`,
  `Dimension.T𝓭`, `UnitChoices`, and `WithDim`.
- Mathlib: `RayVector`, `EuclideanSpace`, `Real.sin`, `Real.pi`, and `dist`.
- Imports used: `Mathlib.Analysis.Complex.Trigonometric`,
  `Mathlib.Analysis.InnerProductSpace.PiL2`,
  `Mathlib.LinearAlgebra.Ray`, and
  `Physlib.Units.WithDim.Basic`.

## Local abstractions introduced

- Physlib has no packaged radiant-power or solar-irradiance quantity, so these
  use `WithDim` tagged by the genuine dimensions `M L² T⁻³` and `M T⁻³`.
  They are not transparent scalar aliases.
- No curved-mirror geometrical-optics API matching the problem was found.
  `LightRay2D`, `OpticalPath2D`, `SolarCookerSetup`, and
  `ValidSolarCookerPhysics` therefore form a minimal local interface. It
  retains ray directions and meeting points, radial normals, incidence and
  reflection angles, specular reflection, absorption, tangency, the
  one-reflection bound, and the maximum-angle condition.
- The analysis is performed in the two-dimensional cross-section normal to
  the parallel cylinder axes, while explicit three-dimensional axis
  directions retain the original cylindrical geometry.

## Grounding gaps and redraft requests

- No ready-made Physlib half-cylindrical mirror, curved-mirror ray reflection,
  irradiance, or optical power API was found; the faithful local abstractions
  above fill those gaps.
- Read-only dependency navigation was unavailable because the advertised
  `archon` executable was not on `PATH` (`archon: command not found`). The
  source report independently confirms there are no previous-part
  dependencies.
- The blueprint target currently has no `\lean{...}` declaration name. The
  plan/review layer should attach
  `\lean{IPhO2026Problems.IPhO2026_2_B_1.problem_IPhO_2026_2_B_1}` so the
  deterministic sync can associate the statement. The prover did not edit the
  blueprint because prover write permissions explicitly forbid it.
- The assigned Lean file did not exist initially, so there was no
  file-specific `/- USER: ... -/` comment to apply.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`: exit code 0,
  with exactly the two expected `declaration uses sorry` warnings.
- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors or failed
  dependencies and exactly the same two expected warnings (lines 232 and 247).

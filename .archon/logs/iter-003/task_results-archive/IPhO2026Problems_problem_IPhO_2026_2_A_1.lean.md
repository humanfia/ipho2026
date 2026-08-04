# Autoformalization result: IPhO 2026 Problem 2 A.1

## Assumption/target split

### Governing laws and setup constraints

- `HalfCylindricalMirror` gives the mirror center, optical-axis direction, and
  positive physical radius.
- `ParallelIncidentRayFamily` states that the incident rays have one common
  unit direction and origins displaced along one perpendicular unit transverse
  direction. `AlignedWithMirror` centers that family on the mirror and aligns
  it with the optical axis as in Figure 2d.
- `OnReflectingArc` is the semicircular boundary condition, expressed using
  the mirror radius through the common `lengthCoordinate` projection.
- `IsSpecularReflection` is the vector reflection law
  `v_out = v_in - 2 (v_in · n)/(n · n) n`.
- `MirrorDynamics` requires every recorded impact to lie on the reflecting
  arc, have a nonzero radial normal, and satisfy the specular-reflection law.
- `IsReflectionThreshold` gives the defining largest-threshold behavior inside
  the open aperture: a ray has at most `N` reflections exactly for transverse
  distance at most the projected physical threshold.
- `hN`, mirror-radius positivity, angle positivity, and the acute-angle bound
  record the relevant physical ranges.

### Previous-part results

- None. Part A.1 is the first subquestion used by this file.

### Figure/data readouts

- `FigureLabel` retains the official labels `figure2c`, `figure2d`, and
  `figure2e`.
- `Figure2cTo2eLimitingGeometry.threshold_projection` states only the
  figure-derived relation
  `coord(xN) = coord(R) * sin(limitingAngle)`.
- `threshold_ray_count` identifies the limiting ray as the ray with `N`
  recorded reflections.
- `total_turning_angle` records the equal-turn closure
  `(2N + 1)(π - 2 limitingAngle) = 2π`.
- `hRadius` identifies the mirror's physical radius with the physical
  parameter `R`; `hAligned`, `hThreshold`, and `hFigure` attach the setup,
  threshold definition, and figure relations to the same objects.

### Current target conclusions

- `lengthCoordinate xN =
  lengthCoordinate R * sin ((2N - 1)π / (4N + 2))`.
- `lengthCoordinate xN =
  lengthCoordinate R * cos (π / (2N + 1))`.

Both `R` and `xN` have type `PhysicalLength`; their scalar values are compared
only through the same named SI coordinate projection.

## Goal-faithfulness audit

Neither requested closed form occurs in `MirrorDynamics`,
`IsReflectionThreshold`, `Figure2cTo2eLimitingGeometry`, any theorem
hypothesis, or a local definition. The limiting-geometry structure contains
only the independent projection law and full-turn relation from which the
limiting angle and both target formulas must be derived. In particular,
`lengthCoordinate` is merely evaluation of a dimensionful quantity in
`UnitChoices.SI`; it does not mention `N`, trigonometry, or either conclusion.
Thus the current answer has not been smuggled into a premise or made true by
unfolding.

## Declarations created and blueprint correspondence

- Supporting grounded declarations without separate blueprint labels:
  `PhysicalLength` and `lengthCoordinate`.
- `CrossSectionPoint` corresponds to
  `decl:physics:IPhO_2026_2_A_1:CrossSectionPoint`.
- `FigureLabel` corresponds to
  `decl:physics:IPhO_2026_2_A_1:FigureLabel`.
- `HalfCylindricalMirror`, `OnReflectingArc`, `GeometricRay`,
  `ParallelIncidentRayFamily`, and `AlignedWithMirror` correspond to their
  same-named `decl:physics:IPhO_2026_2_A_1:*` blueprint labels.
- `ReflectionEvent`, `IsSpecularReflection`, `ReflectionTrace`,
  `MirrorDynamics`, and `reflectionCount` correspond to their same-named
  `decl:physics:IPhO_2026_2_A_1:*` blueprint labels.
- `IsReflectionThreshold` and `Figure2cTo2eLimitingGeometry` correspond to
  their same-named `decl:physics:IPhO_2026_2_A_1:*` blueprint labels.
- `IPhO2026Problems.IPhO2026_2_A_1.threshold_formula` corresponds to
  `thm:physics:IPhO_2026_2_A_1:target`.

The theorem statement compiles with the autoformalization-stage `by sorry`
body and is ready for the deterministic statement-level `\leanok` sync.

## LeanExplore queries/candidates actually used

- Query `physical quantity with dimension of length SI units` found
  `Dimensionful`, `Dimension.L𝓭`, `UnitChoices.SI`,
  `UnitChoices.SI_length`, and `UnitExamples.meters400`.
- Query `Dimensionful length scalar real common coordinate projection
  SI.Length` confirmed `Dimensionful`, `Dimension.L𝓭`,
  `UnitChoices.SI_length`, and the dimensionful evaluation API.
- Query `geometrical optics specular reflection ray mirror law vector incoming
  outgoing surface normal` found `RayVector` and general Euclidean reflection
  declarations, but no curved-mirror, reflection-event, or multi-bounce optics
  model.
- Likely-name query `EuclideanGeometry.reflection affine subspace` confirmed
  `EuclideanGeometry.reflection` and `reflection_apply`; these reflect points
  in a fixed affine subspace and do not encode reflection from a curved mirror
  with a point-dependent radial normal.

Source and module information was fetched for `Dimensionful`
(`Physlib.Units.Basic`), `Dimension.L𝓭`
(`Physlib.Units.Dimension`), `UnitChoices.SI_length`
(`Physlib.Units.Basic`), `UnitExamples.meters400`
(`Physlib.Units.Examples`), `RayVector`
(`Mathlib.LinearAlgebra.Ray`), and
`EuclideanGeometry.reflection`/`reflection_apply`
(`Mathlib.Geometry.Euclidean.Projection`).

## PhysLean/Mathlib names grounded

- Physlib/PhysLean: `Dimensionful`, `WithDim`, `Dimension.L𝓭`,
  `UnitChoices`, and `UnitChoices.SI`.
- Mathlib: `EuclideanSpace`, `inner`, `Real.sin`, `Real.cos`, and `Real.pi`.
- Imports actually used: `Physlib.Units.WithDim.Basic` and `Mathlib`.

## Local abstractions introduced

- `GeometricRay` adds an origin to a nonzero direction. Mathlib's `RayVector`
  grounds the nonzero-direction concept but does not carry the affine origin
  needed for the incident family.
- `HalfCylindricalMirror`, `OnReflectingArc`, `ReflectionEvent`,
  `ReflectionTrace`, `MirrorDynamics`, and `IsSpecularReflection` form the
  smallest explicit curved-mirror ray-tracing interface needed by the source.
  They retain impact points, normals, directions, the semicircular boundary,
  and the physical reflection law rather than collapsing optics to scalars.
- `Figure2cTo2eLimitingGeometry` preserves the figure-derived projection and
  turning relations as assumptions while leaving the requested solution on the
  theorem's conclusion side.

## Grounding gaps

- Physlib/PhysLean provides dimensionful physical quantities but no dedicated
  half-cylindrical geometrical-optics or finite multi-reflection trace API.
- Mathlib's `EuclideanGeometry.reflection` concerns reflection of points in a
  fixed affine subspace, so it is a near miss for direction reflection at a
  varying tangent plane. The explicit vector specular law is therefore kept.
- No blueprint edits were made because prover write permissions reserve
  `\leanok` management for the deterministic sync.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`: exit code 0,
  with exactly the expected `sorry` warning.

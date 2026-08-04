# Autoformalization result

## Assumption/target split

### Governing laws and setup constraints

- `HalfCylindricalMirror` records the center, positive radius readout, and unit
  optical-axis direction of the semicircular cross-section.
- `OnReflectingArc` states both the radius equation and the reflecting
  half-plane condition for the mirror surface.
- `ParallelIncidentRayFamily` states that the incident rays have one common
  unit direction and origins displaced by the signed readout `x` along a unit
  perpendicular transverse direction.
- `AlignedWithMirror` centers the incident family on the mirror and aligns it
  with the optical axis shown in Figure 2d.
- `IsSpecularReflection` is the vector law of reflection using the local
  surface normal.
- `MirrorDynamics` supplies a finite trace for every ray and requires every
  recorded event to lie on the reflecting arc, have a radial normal, and obey
  the specular-reflection law.
- `hN` records that `N` is a positive natural number, and `hRadius` identifies
  the mirror's positive radius readout with the problem parameter `R`.

### Previous-part results

- None. The source report lists no previous parts for A.1, and the
  formalization imports no neighboring problem output.

### Figure/data readouts

- `FigureLabel` explicitly records Figures 2c, 2d, and 2e.
- `IsReflectionThreshold` formalizes Figure 2e: for the open aperture
  `|x| < R`, a ray has at most `N` reflections exactly when
  `|x| ≤ xN`, with `0 < xN < R`.
- `Figure2cTo2eLimitingGeometry.threshold_projection` states the independent
  geometric projection `xN = R sin(limitingAngle)`.
- `threshold_ray_count` records that the positive limiting ray has exactly
  `N` reflections.
- `total_turning_angle` records the full-turn closure
  `(2N + 1)(π - 2 limitingAngle) = 2π` read from the equal-turning-angle
  limiting orbit. The limiting angle is also constrained to `(0, π/2)`.

### Current target conclusions

- `xN = R * sin (((2N - 1) * π) / (4N + 2))`.
- `xN = R * cos (π / (2N + 1))`.

Both expressions use the explicit coercion of the positive natural number
`N` to `ℝ`.

## Goal-faithfulness audit

The two requested closed forms occur only in the conclusion of
`threshold_formula`. They do not occur in a structure field, hypothesis,
governing-law predicate, or local definition. `IsReflectionThreshold` gives
the physical meaning of the still-unknown threshold without prescribing its
value. `Figure2cTo2eLimitingGeometry` gives the radius projection and a
turning-angle closure in terms of an unknown `limitingAngle`; deriving and
substituting that angle, then applying the complementary-angle identity, are
still required to obtain the target. Thus the target has not been made true by
unfolding or smuggled into the assumptions.

Radii, transverse coordinates, and cross-section coordinates are represented
as real scalar readouts in one common length unit, as permitted for measured
components. The mirror, incident rays, reflection traces, and physical laws
remain non-scalar structures and predicates.

## Declarations created and blueprint correspondence

- `CrossSectionPoint`, `FigureLabel`: the two-dimensional Euclidean
  cross-section and official figure labels.
- `HalfCylindricalMirror`, `OnReflectingArc`: mirror geometry.
- `GeometricRay`, `ParallelIncidentRayFamily`, `AlignedWithMirror`: the
  parallel incident-ray setup and signed transverse-coordinate readout.
- `ReflectionEvent`, `IsSpecularReflection`, `ReflectionTrace`,
  `MirrorDynamics`, `reflectionCount`: curved-mirror reflection dynamics.
- `IsReflectionThreshold`: the Figure 2e threshold semantics.
- `Figure2cTo2eLimitingGeometry`: the figure-derived projection and angular
  closure relations.
- `IPhO2026Problems.IPhO2026_2_A_1.threshold_formula` corresponds to
  `thm:physics:IPhO_2026_2_A_1:target`.

The theorem statement is formalized and compiles with its required `by sorry`
body, so it is ready for statement-level `\leanok` association by the
deterministic sync.

## LeanExplore queries/candidates actually used

- Query `geometric optics specular reflection law mirror ray` found
  `RayVector`, `Module.Ray`, and `EuclideanGeometry.reflection`.
- Source and module were fetched for `RayVector` from
  `Mathlib.LinearAlgebra.Ray` and `EuclideanGeometry.reflection` from
  `Mathlib.Geometry.Euclidean.Projection`.
- Query `Real.sin Real.cos angle identity pi division` found the Mathlib
  trigonometric API.
- Query `Real.sin_pi_div_two_sub` found and source-checked
  `Real.sin_pi_div_two_sub` from
  `Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic`, with statement
  `sin (π / 2 - x) = cos x`.
- Query `EuclideanSpace inner product norm squared distance` found
  `EuclideanSpace.norm_sq_eq` and
  `EuclideanSpace.real_norm_sq_eq`; source and module were fetched for the
  latter.
- Query `Fin number of reflection events indexed by count` returned only
  algebraic/category-theoretic reflection near-misses, supporting the local
  finite-trace interface.
- Query `Nat positive integer cast to real denominator nonzero` returned
  rational-denominator and nonnegative-real cast APIs, none of which was
  needed for the statement-level formalization.

All searches were filtered to packages `["Mathlib", "Physlib"]`.

## PhysLean/Mathlib names grounded

- Mathlib: `EuclideanSpace`, `inner`, `Fin`, `Real.sin`, `Real.cos`,
  `Real.pi`, and the inspected theorem `Real.sin_pi_div_two_sub`.
- `RayVector` and `EuclideanGeometry.reflection` were grounded but not used:
  the former is a nonzero vector modulo a ray relation rather than an affine
  incident light ray with a transverse coordinate, while the latter reflects
  in one fixed affine subspace rather than successively at tangent planes of a
  curved semicircular mirror.
- No matching PhysLean geometrical-optics declaration was found.

## Local abstractions introduced

- `GeometricRay` preserves an affine origin and nonzero propagation direction,
  which `RayVector`/`Module.Ray` do not provide in the form needed here.
- `ReflectionEvent`, `ReflectionTrace`, and `MirrorDynamics` preserve the
  number and local geometry of successive physical reflections. The explicit
  vector reflection equation, radial-normal condition, and arc-membership
  condition prevent these from being unconstrained scalar placeholders.
- `IsReflectionThreshold` preserves the “largest distance allowing at most
  `N` reflections” role as a sharp aperture classification.
- `Figure2cTo2eLimitingGeometry` is the smallest local interface for the
  projection and total-turning relations supplied by the official figures.

## Grounding gaps and redraft requests

- Mathlib/PhysLean exposes Euclidean geometry and generic reflection
  constructions, but no ready-made multiple-reflection ray tracer for the
  interior of a half-cylindrical mirror.
- The blueprint theorem environment currently has no `\lean{...}` declaration
  name. The plan/review or marker-sync layer should associate it with
  `IPhO2026Problems.IPhO2026_2_A_1.threshold_formula`.
- Per the prover write-permission rules, the blueprint chapter was not edited;
  `\leanok` bookkeeping is left to the deterministic sync.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors; exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`: exit code 0,
  with exactly the expected `sorry` warning.

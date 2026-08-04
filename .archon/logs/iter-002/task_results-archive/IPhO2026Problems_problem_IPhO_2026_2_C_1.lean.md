# Autoformalization result

## Assumption/target split

### Governing laws and setup constraints

- `HalfCylindricalMirror.radius_pos` records that the mirror radius is a
  positive physical length.
- `hθ_pos` and `hθ_acute` place the incidence angle in the physical range
  `0 < θ < π / 2`.
- `h_reflection` applies the generic oriented-angle law
  `ObeysSpecularReflection`: the reflected direction is the reflection of the
  incoming direction across the tangent line.
- `h_slope_from_direction` applies the generic coordinate fact that the slope
  of a line with direction angle `α` is `tan α`.
- `h_ray_through_strike` says that the reflected line contains the mirror
  strike point.

### Previous-part results

- None. The source report lists no previous parts for C.1, and no previous Lean
  output is imported.

### Figure/data readouts

- `PlanePoint` gives both Figure 2g Cartesian coordinates the physical
  dimension of length.
- `HalfCylindricalMirror` represents the upper semicircular cross-section,
  centered at the Figure 2g origin, with dimensionful radius `R`.
- `SlopeInterceptRay` distinguishes its dimensionless slope, length-valued
  intercept, and dimensionless direction-angle readout.
- `h_strike_on_mirror` records that the impact point lies on the centered upper
  semicircle.
- `h_strike_x` and `h_strike_y` record the Figure 2g impact coordinates
  `x = R sin θ` and `y = R cos θ`.
- `h_incident_vertical` records the upward incident direction `π / 2`.
- `h_tangent_direction` records the Figure 2g tangent orientation `π - θ`.

### Current target conclusions

- `rayA.slope = Real.cot (2 * θ)`.
- The dimensionful intercept is
  `rayA.intercept = ⟨mirror.radius.val / (2 * Real.cos θ)⟩`.

## Goal-faithfulness audit

Neither requested formula occurs in a hypothesis, structure field, governing
law, or helper definition. In particular, `ObeysSpecularReflection` is the
general equal-angle reflection law, `LiesOnRayLine` is the general equation
`y = m x + b`, and `h_slope_from_direction` only relates a generic line slope
to its direction angle. The cotangent slope must still be derived from the
figure angles and reflection law; the intercept must still be derived from
that slope together with the impact coordinates and line-incidence relation.
Unfolding any local definition does not prove either current target.

The radius, Cartesian coordinates, and intercept use Physlib's genuine
dimension-tagged type `WithDim Dimension.L𝓭 ℝ`. Only the dimensionless slope
and radian angle readouts are bare real numbers.

## Declarations created and blueprint correspondence

- `IPhO2026Problems.IPhO2026_2_C_1.PlanePoint`
- `IPhO2026Problems.IPhO2026_2_C_1.HalfCylindricalMirror`
- `IPhO2026Problems.IPhO2026_2_C_1.SlopeInterceptRay`
- `IPhO2026Problems.IPhO2026_2_C_1.OnUpperHalfMirror`
- `IPhO2026Problems.IPhO2026_2_C_1.LiesOnRayLine`
- `IPhO2026Problems.IPhO2026_2_C_1.ObeysSpecularReflection`
- `IPhO2026Problems.IPhO2026_2_C_1.rayA_slope_and_intercept`, corresponding to
  blueprint label `thm:physics:IPhO_2026_2_C_1:target`.

The target theorem is formalized with its required `by sorry` body and is ready
for deterministic blueprint `\leanok` synchronization. The blueprint was not
edited because prover write permissions make it read-only.

## LeanExplore queries/candidates actually used

Every query used package filters `["Mathlib", "Physlib"]`.

- `real cotangent function cot defined as cos divided by sin` found
  `Real.cot`, `Real.cot_eq_cos_div_sin`, `Real.sin`, and `Real.cos`.
  Source and module data for `Real.cot` were fetched.
- Exact-name query `Real.cot Real.tan Real.sin Real.cos` confirmed the real
  trigonometric functions. Source and module data for `Real.tan`, `Real.sin`,
  and `Real.cos` were fetched.
- `physical dimensions units length quantity radius coordinate optics` found
  `Dimension`, `Dimension.L𝓭`, and `LengthUnit`.
- `Dimensionful physical quantity SI units length dimension value PhysLean`
  found `Dimensionful`, `UnitChoices.SI`, `CarriesDimension.toDimensionful`,
  and `Dimension.L𝓭`. Source/module data for `Dimensionful`,
  `UnitChoices.SI`, and `Dimension.L𝓭` were fetched.
- `WithDim type quantity tagged physical dimension length scalar value` found
  `WithDim` and its dimension-preserving instances. Source/module data for
  `WithDim`, `WithDim.instMulActionNNReal`, and `WithDim.smul_val` were
  fetched.
- `geometric optics law of reflection mirror incident ray reflected ray angle`
  returned generic near-matches including `RayVector`,
  `EuclideanGeometry.reflection_symm`, and affine/vector reflection results.
- `affine line in real coordinate plane given by y equals slope times x plus
  intercept` returned `AffineMap.lineMap` and unrelated elliptic-curve slope
  declarations, but no matching slope-intercept ray object.

## PhysLean/Mathlib names grounded

- PhysLean/Physlib: `WithDim`, `Dimension`, and `Dimension.L𝓭`, imported from
  `Physlib.Units.WithDim.Basic`.
- Mathlib: `Real.sin`, `Real.cos`, `Real.tan`, `Real.cot`, and `Real.pi`,
  imported through `Mathlib.Analysis.Complex.Trigonometric`.

## Local abstractions introduced

- `PlanePoint` retains the distinct `x` and `y` coordinate roles while making
  both dimensionful lengths.
- `HalfCylindricalMirror` is the smallest local mirror object needed here: a
  centered upper semicircular cross-section with positive dimensionful radius.
- `SlopeInterceptRay` retains the physical distinction between a
  dimensionless slope, a length-valued intercept, and an oriented direction.
- `OnUpperHalfMirror`, `LiesOnRayLine`, and
  `ObeysSpecularReflection` are faithful geometry/law predicates introduced
  because the retrieved general reflection and affine-line APIs do not model
  Figure 2g's optical ray tracing.

## Grounding gaps and redraft requests

- No PhysLean curved-mirror or geometrical-optics API matching specular
  reflection from a half-cylinder was found. Generic Euclidean reflection
  declarations concern points, subspaces, or unoriented rays and are not a
  faithful drop-in replacement.
- No packaged slope-intercept ray object was found; `AffineMap.lineMap`
  parameterizes an affine line and does not encode the Figure 2g
  dimensionless-slope/length-intercept split.
- The read-only DAG command advertised in the prompt was unavailable in this
  runtime (`archon: command not found`).
- The blueprint theorem has no `\lean{...}` name. The plan/review layer should
  attach
  `\lean{IPhO2026Problems.IPhO2026_2_C_1.rayA_slope_and_intercept}` so the
  synchronization phase can associate the declaration.
- The assigned Lean file did not previously exist, so it contained no
  file-specific `/- USER: ... -/` comment.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages` reported no errors and
  exactly one expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_1.lean` exited with
  code 0 and exactly the expected `sorry` warning.

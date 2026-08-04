# Autoformalization result: IPhO 2026 Problem 2 C.2

## Assumption/target split

### Governing laws

- `HalfCylindricalReflectionLaw setup` states the exact specular-reflection
  geometry for a ray in the parallel incident bundle at every admissible angle:
  its reflected-line slope is `Real.cot (2 * angleRad)` and its Figure 2g
  intercept readout is
  `setup.radiusLengthReadout / (2 * Real.cos angleRad)`.
- The setup records the physical angular range
  `0 < θ < π / 2` and a positive mirror-radius readout. These are physical
  domain conditions, not requested C.2 conclusions.

### Previous-part results

- `PreviousPartC1Result setup` records the allowed natural-language
  prerequisite from C.1:
  `m_A = cot (2 θ)` and `b_A = R / (2 cos θ)`.
- No Lean file from part C.1 is imported.

### Figure/data readouts

- `Figure2gSetup.radiusLengthReadout` is the half-cylinder radius measured in
  the same chosen length unit as Figure 2g coordinates.
- `Figure2gSetup.incidenceAngleRad` is the dimensionless radian readout `θ`.
- `ReflectedRayReadout.slope` is dimensionless, while
  `interceptLengthReadout` has the coordinate/radius length role.
- `rayA setup` labels the reflected ray at `θ`; `rayB setup Δθ` labels the
  neighboring reflected ray at `θ + Δθ`.
- `ReflectedRayReadout.yCoordinateLengthReadout` explicitly records the
  Figure 2g affine-line convention `y = m x + b`.
- The limit filter `𝓝 0` formalizes the condition that `Δθ` is much smaller
  than the fixed central angle.

### Current target conclusions

- `rayB_slope_firstOrder` concludes that the residual after subtracting
  `cot (2 θ) - 2 (sin (2 θ))⁻² Δθ` is `O((Δθ)²)` as `Δθ → 0`.
- `rayB_intercept_firstOrder` concludes that the residual after subtracting
  `[R / (2 cos θ)] (1 + tan θ Δθ)` is `O((Δθ)²)` as `Δθ → 0`.
- `IPhO_2026_2_C_2` conjoins exactly those two requested conclusions and
  corresponds to blueprint label
  `thm:physics:IPhO_2026_2_C_2:target`.

## Goal-faithfulness audit

The C.2 first-order coefficients and both `IsBigO` remainder claims occur only
in theorem conclusions. They do not occur in `Figure2gSetup`,
`HalfCylindricalReflectionLaw`, `PreviousPartC1Result`, or the ray-label
definitions. The governing-law predicate gives the exact reflected-ray formula
at a general admissible angle; it does not assume a Taylor expansion or any
remainder bound. The helper definitions `rayA` and `rayB` only assign the
figure labels to angles `θ` and `θ + Δθ`, so unfolding them cannot prove a C.2
target. The real-valued fields are explicitly measurement/coordinate readouts,
not transparent aliases for a physical length or angle type.

## Declarations created

- `IPhO2026_2_C_2.ReflectedRayReadout`
- `IPhO2026_2_C_2.ReflectedRayReadout.yCoordinateLengthReadout`
- `IPhO2026_2_C_2.Figure2gSetup`
- `IPhO2026_2_C_2.rayA`
- `IPhO2026_2_C_2.rayB`
- `IPhO2026_2_C_2.HalfCylindricalReflectionLaw`
- `IPhO2026_2_C_2.PreviousPartC1Result`
- `IPhO2026_2_C_2.rayB_slope_firstOrder`
- `IPhO2026_2_C_2.rayB_intercept_firstOrder`
- `IPhO2026_2_C_2.IPhO_2026_2_C_2` — blueprint target
  `thm:physics:IPhO_2026_2_C_2:target`

The target theorem statement is ready for the deterministic blueprint
`\leanok` synchronization. The blueprint was not edited because prover write
permissions make it read-only.

## LeanExplore queries/candidates actually used

All searches used package filters `["Mathlib", "Physlib"]`.

- Query `Asymptotics.IsBigO function remainder big O at neighborhood zero`
  returned Big-O lemmas including `Asymptotics.IsBigO.isBigOTVS`.
- Exact-name query `Asymptotics.IsBigO` returned
  `Asymptotics.IsBigO`; its source and module
  `Mathlib.Analysis.Asymptotics.Defs` were fetched and used.
- Query `Real.cot Real.csc cotangent cosecant trigonometric functions`
  returned `Real.cot`, `Real.cot_eq_cos_div_sin`, `Real.sin`, and related
  declarations. Source/module data for `Real.cot` and
  `Real.cot_eq_cos_div_sin` were fetched.
- Query `Taylor expansion cotangent reciprocal cosine first order derivative`
  returned `Real.deriv_cos'` and Taylor-related near matches. The
  `Real.deriv_cos'` source/module data were fetched to ground the later proof
  route.
- Query `geometric optics specular reflection ray circular mirror caustic`
  returned `RayVector`, `SameRay`, and Euclidean affine-subspace reflection
  results. Source/module data for `RayVector`, `SameRay`, and
  `EuclideanGeometry.reflection_reflection` were fetched and assessed as near
  misses.

## PhysLean/Mathlib names grounded

- `Asymptotics.IsBigO` and notation `f =O[𝓝 0] g`
- `Filter.nhds`
- `Real.cot`
- `Real.sin`
- `Real.cos`
- `Real.tan`
- `Real.pi`

Mathlib has no `Real.csc` declaration in the retrieved candidates, so the
recorded `csc(2 θ)²` coefficient is represented faithfully as
`(Real.sin (2 * θ))⁻¹ ^ 2`.

## Local abstractions introduced

- `ReflectedRayReadout` is the smallest coordinate-level object that retains
  the distinct dimensionless slope and length-valued intercept roles requested
  by the problem.
- `Figure2gSetup` retains the mirror radius, incidence angle, admissible
  physical range, and the family of reflected rays from the one parallel
  incident bundle.
- `HalfCylindricalReflectionLaw` retains the exact curved-mirror geometry as a
  governing-law predicate rather than encoding the requested approximation as
  an assumption.

## Grounding gaps

- The retrieved `RayVector`/`SameRay` API concerns generic vector rays and does
  not model specular reflection from a curved mirror.
- `EuclideanGeometry.reflection_reflection` concerns reflection of points in an
  affine subspace, not optical reflection of ray directions from a circular
  surface.
- No suitable PhysLean curved-mirror, caustic, or geometric-optics API was
  found. The local abstractions above therefore preserve only the physical
  roles and laws needed for this subquestion.
- The read-only DAG navigation command was unavailable in this prover
  environment (`archon: command not found`); the chapter itself specifies that
  C.1 is a natural-language prerequisite only.

## Verification

`lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_2.lean` exits successfully
with exactly three expected `declaration uses 'sorry'` warnings, for the two
component expansion theorems and the combined blueprint target.

No file-specific `/- USER: ... -/` comment was present because the assigned
Lean file did not yet exist.

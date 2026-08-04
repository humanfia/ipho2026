# Autoformalization result: IPhO2026Problems/problem_IPhO_2026_2_C_3.lean

## Assumption/target split

### Governing laws

- `IsNeighboringReflectedIntersection` states that the traced point lies on
  both the reflected line at `θ` and the neighboring reflected line at
  `θ + Δθ`.
- `hNeighboringIntersection` assumes this incidence relation only eventually
  as `Δθ → 0` through nonzero values. It does not assume a limit or a caustic
  coordinate formula.

### Previous-part results

- `hRayA_slope` and `hRayA_intercept` are the C.1 formulas
  `m_A = cot (2θ)` and `b_A = R / (2 cos θ)`.
- `hRayB_slope_firstOrder` and `hRayB_intercept_firstOrder` are the two C.2
  `O(Δθ²)` residual estimates. The intercept estimate reads both `b_B` and
  `R` through the same `Figure2gLengthProjection`.

### Figure/data readouts

- `Figure2gMirror.radius`, both fields of `Figure2gPoint`, and
  `ReflectedRayLine.yIntercept` have type
  `Dimensionful (WithDim Dimension.L𝓭 ℝ)`.
- `Figure2gLengthProjection` names the `UnitChoices` used for every Figure 2g
  scalar coordinate. Its `readout` is applied uniformly to radius,
  coordinates, and intercepts.
- `Figure2gMirror.OnReflectingSurface` records the upper-semicircle equation in
  that common projection.
- `hθ_pos` and `hθ_acute` encode the source angle range.

### Current target conclusions

- The projected `x` coordinate of the neighboring-ray intersection tends on
  `𝓝[≠] 0` to `R sin³ θ`.
- The projected `y` coordinate tends on the same punctured neighborhood to
  `(R / 2) cos θ (2 - cos (2θ))`.

## Goal-faithfulness audit

The two C.3 coordinate formulas occur only in the conclusion of
`limitingIntersectionCoordinates`. They do not occur in
`Figure2gLengthProjection`, any geometry/ray structure, either incidence
predicate, or any theorem hypothesis. The assumptions stop at the exact C.1
line formulas, the C.2 first-order residual bounds, and the fact that the
chosen point is an intersection of the two neighboring lines. Thus neither
target limit is made true by unfolding a local definition or by using a
premise that already asserts the answer.

The punctured-neighborhood trace is retained explicitly: the intersection
condition is an eventual statement in `𝓝[≠] 0`, and each requested coordinate
is a separate `Tendsto` conclusion from `𝓝[≠] 0`.

## Declarations created and blueprint correspondence

- `Figure2gMirror` —
  `decl:physics:IPhO_2026_2_C_3:Figure2gMirror`.
- `Figure2gPoint` —
  `decl:physics:IPhO_2026_2_C_3:Figure2gPoint`.
- `Figure2gMirror.OnReflectingSurface` —
  `decl:physics:IPhO_2026_2_C_3:Figure2gMirror:OnReflectingSurface`.
- `ReflectedRayLine` —
  `decl:physics:IPhO_2026_2_C_3:ReflectedRayLine`.
- `ReflectedRayLine.Contains` —
  `decl:physics:IPhO_2026_2_C_3:ReflectedRayLine:Contains`.
- `IsNeighboringReflectedIntersection` —
  `decl:physics:IPhO_2026_2_C_3:IsNeighboringReflectedIntersection`.
- `limitingIntersectionCoordinates` —
  `thm:physics:IPhO_2026_2_C_3:target`.

The target environment is formalized with the required `sorry` body and is
ready for the deterministic `\leanok` synchronization. The prover did not edit
the blueprint because project-local write permissions reserve that file for
the synchronization/review phases.

## LeanExplore queries and candidates actually used

- Query `physical dimensional quantity length SI unit PhysLean Physlib`
  returned `Dimension`, `Dimension.L𝓭`, `UnitChoices.SI`, and
  `UnitChoices.dimScale`; `Dimension.L𝓭` was selected as the length dimension.
- Query
  `MeasurementSystem.Quantity length dimension physical quantity scalar projection value`
  returned `Dimensionful`, `WithDim.scaleUnit_val`, `HasDimension`, and
  `CarriesDimension.toDimensionful`; `Dimensionful` was selected so the
  physical lengths are independent of a single hard-coded scalar unit.
- Query `WithDim physical quantity tagged with dimension length value`
  returned `WithDim`, `WithDim.val_sub`, and `Dimension.L𝓭`; `WithDim` was
  selected as Physlib's dimension-tagged carrier.
- Query `Dimensionful definition dimensionful quantity evaluated at UnitChoices`
  returned `Dimensionful`, `Dimensionful.of_scaleUnit`, and
  `Dimensionful.ext`. Source inspection confirmed that `Dimensionful M` is a
  unit-dependent function satisfying `HasDimension`, so evaluating at one
  stored `UnitChoices` is the appropriate named Figure 2g projection.

Source/module lookups used:

- `WithDim` — `Physlib.Units.WithDim.Basic`.
- `Dimension.L𝓭` — `Physlib.Units.Dimension`.
- `Dimensionful` — `Physlib.Units.Basic`.
- `UnitChoices.SI` and `WithDim.scaleUnit_val` were inspected but not used:
  Figure 2g requires a named common unit, not specifically SI.

## Physlib/Mathlib names grounded

- Physlib: `Dimensionful`, `WithDim`, `Dimension.L𝓭`, and `UnitChoices`.
- Mathlib: `Filter.Tendsto`, punctured-neighborhood notation `𝓝[≠]`,
  `Asymptotics.IsBigO` notation `=O[𝓝 0]`, and the existing
  `Real.sin`, `Real.cos`, `Real.tan`, and `Real.cot` APIs.
- Explicit imports are `Mathlib` and `Physlib.Units.WithDim.Basic`.

## Local abstractions introduced

- `PhysicalLength` abbreviates the nontrivial Physlib physical quantity
  `Dimensionful (WithDim Dimension.L𝓭 ℝ)`; it is not a scalar alias.
- `Figure2gLengthProjection` stores the one unit choice shared by all
  coordinate equations, and `Figure2gLengthProjection.readout` evaluates a
  physical length in that choice.
- The mirror, point, reflected-line, containment, and neighboring-intersection
  abstractions remain local because Physlib has no ready-made type combining
  Figure 2g's half-cylinder convention, slope-intercept ray representation,
  and the problem-specific neighboring-ray trace.

## Needs blueprint entry

- `IPhO2026Problems.IPhO2026_2_C_3.PhysicalLength` — Physlib-backed physical
  length abbreviation used by the existing blueprint declarations.
- `IPhO2026Problems.IPhO2026_2_C_3.Figure2gLengthProjection` — the named common
  coordinate-unit projection required by the redraft objective.
- `IPhO2026Problems.IPhO2026_2_C_3.Figure2gLengthProjection.readout` — projects
  a physical length to the common Figure 2g scalar coordinate.

The planner/reviewer should add definition environments for these three
supporting declarations if strict one-to-one Lean/blueprint coverage is
required.

## Grounding gaps and redraft requests

- LeanExplore's generic `SameRay` and `AffineMap.lineMap` candidates do not
  encode the Figure 2g slope/intercept convention together with dimensioned
  intercepts and a chosen unit projection. The faithful local ray structures
  were therefore retained.
- No further statement redraft is requested. The only follow-up is the
  blueprint-entry bookkeeping listed above.

## Verification

- `archon-lean-lsp` diagnostics: no errors; exactly one expected
  `declaration uses sorry` warning at `limitingIntersectionCoordinates`.
- No `axiom`, `admit`, or additional proof escape hatch was introduced.

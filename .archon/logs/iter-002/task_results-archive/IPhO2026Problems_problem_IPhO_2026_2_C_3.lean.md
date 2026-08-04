# Autoformalization result: IPhO 2026 Problem 2 C.3

## Assumption/target split

### Governing laws and setup constraints

- `Figure2gMirror.radiusLengthReadout_pos` states that the physical mirror
  radius has a positive readout in the fixed coordinate length unit.
- `hθ_pos` and `hθ_acute` restrict the incidence-angle readout to the physical
  Figure 2g range `0 < θ < π / 2`.
- `ReflectedRayLine.Contains` is the Figure 2g affine-line law
  `y = m x + b`.
- `hNeighboringIntersection` says that, eventually as nonzero `Δθ → 0`, the
  selected point lies on both ray A at `θ` and ray B at `θ + Δθ`. This is the
  geometric intersection relation, not a coordinate answer.

### Previous-part results

- `hRayA_slope` and `hRayA_intercept` restate the allowed C.1 conclusions
  `m_A = cot(2θ)` and `b_A = R/(2 cos θ)`.
- `hRayB_slope_firstOrder` restates the C.2 slope expansion by requiring the
  residual after
  `cot(2θ) - 2 ((sin(2θ))⁻¹)^2 Δθ` to be `O((Δθ)²)` at zero.
- `hRayB_intercept_firstOrder` similarly requires the residual after
  `[R/(2 cos θ)] (1 + tan θ Δθ)` to be `O((Δθ)²)`.
- These results are stated locally from their natural-language conclusions;
  no previous-part Lean output is imported.

### Figure/data readouts

- `Figure2gMirror` records the half-cylinder radius.
- `Figure2gPoint` records the `x` and `y` coordinate labels from Figure 2g.
- `Figure2gMirror.OnReflectingSurface` records the upper semicircle
  `x² + y² = R²`, `y ≥ 0`, centered at the displayed origin.
- `ReflectedRayLine` distinguishes its dimensionless slope ratio from its
  length-valued intercept readout.
- `reflectedRayAtIncidenceAngle` represents the reflected members of the one
  parallel incident-ray family, indexed by their dimensionless radian angle.
  Ray A is indexed by `θ` and neighboring ray B by `θ + Δθ`.
- Radius, intercept, and coordinate fields are real-valued readouts in one
  fixed common length unit; they are not definitions of physical length as
  bare real scalars.

### Current target conclusions

- The `x` readout of the neighboring intersection tends to
  `R * sin(θ)^3`.
- The `y` readout tends to
  `(R/2) * cos(θ) * (2 - cos(2θ))`.
- Both conclusions use the punctured limit `Δθ → 0`, faithfully representing
  the caustic as the limiting intersection of distinct neighboring rays.

## Goal-faithfulness audit

The two recorded caustic-coordinate formulas occur only as the target values
of the two `Tendsto` conclusions in `limitingIntersectionCoordinates`. Neither
formula occurs in a hypothesis, structure field, premise predicate, or helper
definition. In particular, `IsNeighboringReflectedIntersection` unfolds only
to the two affine incidence equations; it does not specify the intersection's
coordinates. The C.1 and C.2 hypotheses contain only previous-part line data,
and the Big-O hypotheses do not assert the current limit.

`Figure2gMirror.OnReflectingSurface` and `ReflectedRayLine.Contains` encode
figure geometry and the line equation respectively. Unfolding either cannot
prove the requested caustic coordinates.

## Declarations created and blueprint correspondence

- `IPhO2026Problems.IPhO2026_2_C_3.Figure2gMirror`
- `IPhO2026Problems.IPhO2026_2_C_3.Figure2gPoint`
- `IPhO2026Problems.IPhO2026_2_C_3.Figure2gMirror.OnReflectingSurface`
- `IPhO2026Problems.IPhO2026_2_C_3.ReflectedRayLine`
- `IPhO2026Problems.IPhO2026_2_C_3.ReflectedRayLine.Contains`
- `IPhO2026Problems.IPhO2026_2_C_3.IsNeighboringReflectedIntersection`
- `IPhO2026Problems.IPhO2026_2_C_3.limitingIntersectionCoordinates`,
  corresponding to blueprint label
  `thm:physics:IPhO_2026_2_C_3:target`.

The theorem statement compiles with its required `by sorry` body and is ready
for deterministic statement `\leanok` synchronization. The prover did not edit
the read-only blueprint chapter.

## LeanExplore queries/candidates actually used

Every query used package filters `["Mathlib", "Physlib"]`.

- `derivative of a real-valued function at a real point HasDerivAt` found
  `HasDerivAt`. Its source and module
  `Mathlib.Analysis.Calculus.Deriv.Basic` were fetched. It was syntax-checked
  as an initial representation, then replaced by the stronger C.2 Big-O
  residual actually stated in the blueprint.
- `punctured neighborhood filter excluding a point Tendsto nhdsWithin` found
  `Topology.nhdsNE`; its source and module
  `Mathlib.Topology.Defs.Filter` were fetched and its `𝓝[≠]` notation is used.
- `Real.sin Real.cos Real.tan trigonometric functions` found `Real.sin`; its
  source and module `Mathlib.Analysis.Complex.Trigonometric` were fetched.
- `Real.cot cotangent real trigonometric function` found `Real.cot`; its
  source and module were fetched and the declaration is used for the C.1/C.2
  slope formulas.
- `Asymptotics.IsBigO function residual bounded by square near zero` found
  `Asymptotics.IsBigO`; its source and module
  `Mathlib.Analysis.Asymptotics.Defs` were fetched and the `=O[𝓝 0]` notation
  is used for both C.2 prerequisites.
- `geometric optics reflected ray specular reflection mirror caustic` found
  `RayVector`, `Module.Ray`, and generic Euclidean reflection declarations.
  Source/module data for `RayVector` and `Module.Ray` were fetched and showed
  that these are direction-vector quotients rather than based affine optical
  rays.
- Searches for a two-dimensional Euclidean coordinate space, affine lines,
  and `Filter.Tendsto` were also used to assess the standard topology/geometry
  surface. A coordinate-readout structure was chosen because it expresses the
  exact Figure 2g axes and units with less unrelated machinery.

## PhysLean/Mathlib names grounded

- `Asymptotics.IsBigO` and notation `f =O[𝓝 0] g`
- `Filter.Tendsto`
- `Topology.nhdsNE` notation `𝓝[≠] x`
- `Real.cot`, `Real.sin`, `Real.cos`, `Real.tan`, and `Real.pi`

No matching PhysLean geometrical-optics declaration was found. The file uses
the grounded Mathlib analysis and topology APIs through `import Mathlib`.

## Local abstractions introduced

- `Figure2gMirror` is a physical mirror object with a positive radius readout,
  rather than an alias for `ℝ`.
- `Figure2gPoint` keeps both labeled spatial-coordinate readouts together.
- `ReflectedRayLine` keeps the distinct dimensionless-slope and
  length-intercept roles together.
- `IsNeighboringReflectedIntersection` is the smallest faithful predicate for
  the simultaneous incidence of a point on the two supporting affine lines.

These abstractions retain the physical and dimensional roles needed by C.3
without inventing an unavailable curved-mirror optics API.

## Grounding gaps

- Mathlib's `Module.Ray` represents positive-scaling classes of nonzero
  vectors, so it has no affine base point or intercept and cannot directly
  express the reflected lines in Figure 2g.
- No PhysLean API for specular reflection from a half-cylindrical mirror or
  for optical caustics was returned. The local interfaces above therefore
  encode only the exact figure and line relations used in this subquestion.
- No separate `Real.csc` API was needed; `csc(2θ)²` is represented as
  `(Real.sin (2 * θ))⁻¹ ^ 2`.
- The read-only DAG command was unavailable in this shell
  (`archon: command not found`). The chapter itself marks C.1 and C.2 as
  natural-language-only prerequisites.
- The blueprint target has no `\lean{...}` name. The plan/review layer should
  attach
  `\lean{IPhO2026Problems.IPhO2026_2_C_3.limitingIntersectionCoordinates}`.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_3.lean`: exit code 0
  with exactly the expected `sorry` warning.
- No file-specific `/- USER: ... -/` comment was present because the assigned
  Lean file did not exist before this autoformalization.

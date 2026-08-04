# Autoformalization result

## Assumption/target split

### Governing laws

- `NeighboringReflectedRaysGenerateCaustic system` states the caustic-envelope
  law: for each incidence angle `θ`, the intersections of reflected rays at
  `θ` and `θ + Δθ` tend to the caustic point as nonzero `Δθ` tends to zero.
- `Figure2gOpticalSystem.radius_pos` records the physical positivity of the
  half-cylindrical mirror radius.

### Previous-part results

- `HasPreviousPartC3Coordinates system` restates the permitted natural-language
  result from C.3:
  `X_c(θ) = R sin(θ)^3` and
  `Y_c(θ) = (R/2) cos(θ) (2 - cos(2θ))`.
- No Lean declaration from C.3 is imported.

### Figure/data readouts

- `Figure2gOpticalSystem` records the mirror radius, the reflected line
  associated with every dimensionless incidence angle, and the two caustic
  coordinate functions.
- `ReflectedLineReadout` records the dimensionless slope and length-dimensioned
  intercept in the line equation `y = m x + b`.
- `neighboringIntersectionX` and `neighboringIntersectionY` name the
  intersection readouts for Figure 2g rays `A` and `B`, with `B` evaluated at
  the neighboring angle `θ + Δθ`.
- The Figure 2g origin, axis orientation, and upper-semicircle convention are
  fixed in the documentation of `Figure2gOpticalSystem`.
- Radius, intercepts, and caustic coordinates use
  `WithDim Dimension.L𝓭 ℝ`; the coefficient `v` uses
  `WithDim (Dimension.L𝓭 ^ (1/3 : ℚ)) ℝ`.

### Current target conclusions

- There exist coefficients `u`, `v` and integers `p`, `q` with
  `u = R/2`, `v = (3/4) R^(1/3)`, `p = 2`, and `q = 3`.
- The small-angle power law is represented rigorously by
  `(Y_c(θ) - u) / |X_c(θ)|^(p/q) → v` as nonzero `θ → 0`.

## Goal-faithfulness audit

The four requested values and the small-angle limit occur only in the
conclusion of `determineSmallAngleCaustic`.  They do not occur in
`Figure2gOpticalSystem`, either intersection definition, the envelope-law
hypothesis, or the previous-part predicate.  In particular, the envelope law
only identifies the caustic as the limit of neighboring reflected-ray
intersections, while the C.3 hypothesis supplies only the exact parametric
coordinates authorized by the blueprint.  No local definition unfolds to the
C.4 answer.

The `Tendsto` conclusion interprets `θ ≪ 1` as a leading-order statement at a
punctured neighborhood of zero; it does not incorrectly assert that the
small-angle approximation is an exact equality at finite angle.

## Declarations created and blueprint correspondence

- `LengthReading`, `CubeRootLengthReading`: dimension-tagged scalar readouts.
- `ReflectedLineReadout`, `Figure2gOpticalSystem`: Figure 2g optical model.
- `neighboringIntersectionX`, `neighboringIntersectionY`: neighboring-ray
  intersection coordinates.
- `NeighboringReflectedRaysGenerateCaustic`: governing envelope law.
- `HasPreviousPartC3Coordinates`: locally restated C.3 result.
- `IPhO2026Problems.IPhO2026_2_C_4.determineSmallAngleCaustic` corresponds to
  `thm:physics:IPhO_2026_2_C_4:target`.

The theorem statement compiles with its required `by sorry` body and is ready
for statement `\leanok` once the blueprint is linked to the declaration.

## LeanExplore queries/candidates actually used

- `Real.rpow real number raised to a real exponent` and
  `Real.instPowReal Real.rpow` grounded `Real.rpow` and its real-exponent
  `Pow ℝ ℝ` instance.
- `Filter.Tendsto punctured neighborhood nhdsWithin singleton complement`
  grounded the `Topology.nhdsNE` notation `𝓝[≠]`.
- `units dimensions physical quantity length PhysLean` grounded `Dimension`,
  `Dimension.L𝓭`, and `LengthUnit`.
- `physical quantity with a Dimension and numerical value units` grounded
  `WithDim`, its dimension-indexed multiplication/division API, and
  `Dimensionful`.  `WithDim` was used because this problem needs explicitly
  dimensioned readings in one shared length unit; no unit conversion is part
  of C.4.
- `geometric optics ray reflection caustic envelope` returned
  `EuclideanGeometry.reflection`, `RayVector`, and `Module.Ray`, which do not
  model a family of reflected lines from a half-cylindrical mirror.
- `asymptotic equivalence functions IsEquivalent little o near zero` confirmed
  Mathlib's asymptotics infrastructure; the simpler equivalent ratio-limit
  statement was selected for the target.

Source/module/docstring data were inspected for `Real.rpow`,
`Real.instPow`, `Topology.nhdsNE`, `Dimension`, `Dimension.L𝓭`, `LengthUnit`,
`WithDim`, and the relevant `WithDim` operations.

## PhysLean/Mathlib names grounded

- PhysLean/Physlib: `WithDim`, `Dimension`, `Dimension.L𝓭`, and rational powers
  of `Dimension`.
- Mathlib: `Real.sin`, `Real.cos`, `Real.rpow`, `Filter.Tendsto`, `𝓝`, and
  `𝓝[≠]`.

## Local abstractions introduced

- `ReflectedLineReadout` is the smallest local representation of the line
  `y = m x + b`; it keeps slope dimensionless and intercept dimensioned.
- `Figure2gOpticalSystem` preserves the mirror, reflected-ray family, coordinate
  convention, and caustic coordinate roles without treating a ray or mirror as
  a bare real number.
- `NeighboringReflectedRaysGenerateCaustic` supplies the missing
  geometrical-optics envelope interface as an actual neighboring-intersection
  limit, rather than assuming the requested cusp formula.

## Grounding gaps

- LeanExplore found general Euclidean reflection and ray declarations, but no
  ready-made half-cylindrical geometrical-optics caustic/envelope API matching
  Figure 2g.  The local line-family and envelope-limit abstractions fill this
  gap faithfully.
- The blueprint theorem environment has no `\lean{...}` declaration link.
  Prover permissions keep the chapter read-only, so the plan/review layer
  should attach
  `\lean{IPhO2026Problems.IPhO2026_2_C_4.determineSmallAngleCaustic}`; the
  deterministic sync can then manage `\leanok`.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`: exit code 0
  with exactly the expected `sorry` warning.

# Autoformalization result: IPhO 2026 problem 2 C.4

The assigned file was created and checked with
`lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`. It compiles
with exactly two expected `declaration uses sorry` warnings and no errors.

The chapter contains `% archon:physics`, so the physics-formalization
discipline was applied. The official Figure 2g page was inspected to recover
the centered coordinate frame, upper semicircle, ray labels, and orientation.

## Assumption/target split

### Governing laws

- `Figure2gFrame` fixes a PhysLean `LengthUnit`, a numerical mirror-radius
  readout in that unit, and the physical condition that the radius is
  positive.
- `SatisfiesFigure2gReflectionLaw` gives the reflected supporting-line family
  for the vertical, mutually parallel incident rays. It exposes the incident
  angle, slope `cos (2θ) / sin (2θ)`, intercept `R / (2 cos θ)`, and mirror
  incidence equation. These are governing reflection/geometry equations, not
  C.4's requested power-law parameters.
- `FormsNeighboringRayCaustic` states that ray A at `θ` and ray B at
  `θ + Δθ` share the supplied intersection and that its two coordinate
  readouts tend to the caustic as nonzero `Δθ → 0`.
- `deltaThetaEventuallySmallerThanTheta` gives the precise local consequence
  of `Δθ ≪ θ`: for fixed nonzero `θ`, eventually `|Δθ| < |θ|`.

### Previous-part results

- `HasPreviousPartC3Coordinates` restates, without importing a sibling Lean
  output, the allowed C.3 result
  `X_c θ = R * (sin θ)^3` and
  `Y_c θ = (R/2) * cos θ * (2 - cos (2θ))`.

### Figure/data readouts

- Figure 2g's origin is the circle center, positive `x` points right, and
  positive `y` points up.
- `mirrorPointXReadout` and `mirrorPointYReadout` encode the labelled mirror
  point as `(R sin θ, R cos θ)`.
- `ReflectedRayReadout` retains the dimensionless incident angle and slope and
  the length-valued intercept readout.
- `reflectedRayA model θ` and `reflectedRayB model θ Δθ` preserve the source
  labels A and B, with B selected at the signed neighboring angle `θ + Δθ`.
- Radius, intercept, caustic coordinates, and intersection coordinates are
  numerical length readouts in one explicit `LengthUnit`; slopes and angles
  are dimensionless.

### Current target conclusions

- The small-angle vertical offset is `u = R/2`.
- The coefficient readout is `v = (3/4) * R^(1/3)`.
- The reduced exponent has numerator `p = 2` and denominator `q = 3`.
- These values satisfy the leading-order relation
  `Y_c - u ~ v * |X_c|^(p/q)` as `θ → 0` through nonzero angles.

All four requested parameter values occur only in the conclusion of
`smallAngleCausticPowerLaw`.

## Goal-faithfulness audit

- No field of `Figure2gFrame`, `Figure2gCausticModel`, any governing-law
  predicate, or the C.3 prerequisite states `u`, `v`, `p`, or `q`.
- `CausticPowerLawParameters` is a generic data structure; it does not define
  any field to the requested answer.
- `HasSmallAnglePowerLaw` is a generic asymptotic relation. It requires a
  nonzero denominator, a reduced numerator/denominator pair, and Mathlib
  asymptotic equivalence, but does not choose the four target values.
- The answer-valued structure literal appears only on the conclusion side of
  `smallAngleCausticPowerLaw`. Unfolding that literal does not prove the
  substantive `Asymptotics.IsEquivalent` goal.
- The only closed-form caustic assumptions are exactly the previous-part C.3
  results authorized by the blueprint. Their Taylor/asymptotic consequences
  still have to be proved.
- Countermodel sanity check: without `previousPartC3`, the caustic coordinate
  functions can be changed near zero while the ray-data structures remain
  populated, falsifying the C.4 conclusion. Thus the target is not true merely
  by constructing the local data structures. With C.3 present, the target is
  an analytic consequence rather than an assumed field.

## Derivability and bridge obligations

Here “covered” means that a faithful statement/library carrier is present;
the two theorem proofs are intentionally deferred with `sorry` in this
autoformalization stage.

1. **Common physical length unit and dimensional roles — covered.**
   Source claim: `R`, `X_c`, `Y_c`, `u`, and line intercepts are lengths.
   Carrier: PhysLean `LengthUnit` in `Figure2gFrame`, together with the
   explicitly named real-valued readout fields. `v` is documented as a
   unit-dependent numerical coefficient with dimensional role
   `length^(1/3)` when `p/q = 2/3`.

2. **Figure 2g mirror coordinates and signed axes — covered.**
   Source claim: the hit point is `(R sin θ, R cos θ)` in the centered,
   right/up coordinate frame. Carriers: `mirrorPointXReadout`,
   `mirrorPointYReadout`, and the `Figure2gFrame` contract. Evidence: direct
   inspection of the official Figure 2g page.

3. **Reflected-line family for parallel incidence — covered.**
   Source claim: the reflected ray at angle `θ` is a line with the
   figure-derived slope/intercept and passes through the mirror point.
   Carrier: `SatisfiesFigure2gReflectionLaw`, whose elimination data are four
   explicit families of equalities. The finite-slope degeneracy at `θ = 0`
   is excluded where necessary.

4. **Neighboring ray A/B intersection and caustic limit — covered.**
   Source claim: ray B has angle `θ + Δθ`, and the neighboring intersection
   tends to the caustic as `Δθ → 0`. Carrier:
   `FormsNeighboringRayCaustic`, with two line-incidence equations and two
   `Filter.Tendsto` conclusions on the punctured neighborhood.

5. **Scale hierarchy `Δθ ≪ θ` — covered.**
   Carrier: `deltaThetaEventuallySmallerThanTheta`. For every fixed nonzero
   `θ`, its conclusion is the eventual inequality `|Δθ| < |θ|` as
   `Δθ → 0`.

6. **Previous-part parametric caustic — covered.**
   Source claim: C.3 gives the exact `X_c` and `Y_c` functions. Carrier:
   `HasPreviousPartC3Coordinates`, whose two universally quantified
   equalities reproduce the source report verbatim up to algebraic notation.

7. **Horizontal cusp scaling — covered.**
   Source reasoning: `sin θ ~ θ` makes
   `|X_c|^(2/3) ~ R^(2/3) θ²` for positive `R`. Carriers:
   `Real.isEquivalent_sin`, `Asymptotics.IsEquivalent.rpow`,
   `Real.mul_rpow`, `Real.rpow`, `abs`, and
   `Figure2gFrame.radiusReadout_pos`. The relevant declarations were
   source-checked through LeanExplore.

8. **Vertical second-order expansion — covered.**
   Source reasoning:
   `(R/2) cos θ (2 - cos 2θ) - R/2 ~ (3R/4) θ²`.
   Carriers: the second C.3 equation, `Real.cos_bound` (an explicit
   fourth-order error bound for the quadratic cosine approximation), or
   alternatively `taylor_isLittleO` together with the analyticity of cosine.
   LeanExplore did not expose a one-line theorem with this exact composite
   expression, but the required error estimate is grounded.

9. **Coefficient and reduced exponent assembly — covered.**
   Source reasoning:
   `(3R/4) θ² = ((3/4) R^(1/3)) *
   (R^(2/3) θ²)`. Carrier: `Real.mul_rpow`, ordinary ordered-field algebra,
   and the main contract
   `IPhO2026Problems.IPhO2026_2_C_4.smallAngleCausticPowerLaw`.
   `HasSmallAnglePowerLaw` also records that `2` and `3` are coprime and the
   denominator is nonzero.

No substantive statement-layer bridge is blocked.

## Abstraction sufficiency and countermodel audit

- `SatisfiesFigure2gReflectionLaw` exposes the ray-angle equality, an exact
  slope equation, an exact intercept equation, and an exact point-line
  incidence equation. It cannot be interpreted as an unconstrained opaque
  physics tag.
- `FormsNeighboringRayCaustic` exposes two line-incidence equations for every
  sufficiently close nonzero neighbor and two coordinatewise limit
  statements. Arbitrary intersection functions do not satisfy this relation.
- `HasPreviousPartC3Coordinates` exposes both exact parametric coordinate
  equations. It directly constrains the caustic functions used by the target.
- `HasSmallAnglePowerLaw` exposes denominator nonvanishing,
  `Nat.Coprime`, and the full `Asymptotics.IsEquivalent` relation. It is used
  only as the target, never as a hypothesis.
- `Figure2gFrame.radiusReadout_pos` prevents nonphysical zero or negative
  mirror radii and provides the sign condition needed by real-power laws.
- `ReflectedRayReadout` is not a transparent scalar alias or one-field
  wrapper: it retains incident angle, dimensionless line slope, and
  length-valued intercept as distinct roles.
- Countermodels remain possible when a genuine carrier is removed: dropping
  reflection equations permits arbitrary reflected lines; dropping envelope
  limits permits arbitrary caustic points; dropping C.3 permits arbitrary
  near-cusp scaling. Keeping all carriers makes the requested result a
  determinate real-analysis obligation.

## Uncertainty and branch coverage

- **Uncertainty: not applicable.** The source contains no
  `value ± uncertainty`, tolerance, experimental error, or fitted confidence
  interval. `Δθ ≪ θ` is an asymptotic scale condition, not a measurement
  uncertainty.
- **Coordinate orientation: covered.** The centered/right/up Figure 2g
  convention and `(R sin θ, R cos θ)` mirror parametrization preserve the
  signs of the caustic coordinates.
- **Neighbor branch: covered.** Ray B is the signed `θ + Δθ` family member,
  and the punctured filter enforces `Δθ ≠ 0`.
- **Cusp branches: covered.** `HasSmallAnglePowerLaw` uses the two-sided
  punctured neighborhood `𝓝[≠] 0` and `|X_c|`, so both `θ > 0` and `θ < 0`
  cusp branches are represented without choosing one only in the conclusion.
- **Finite-slope chart: covered.** Reflection-line equations explicitly carry
  their nonzero trigonometric denominators, while the caustic functions extend
  to the cusp through C.3 and the asymptotic filter.
- **Propagation orientation: not applicable to the C.4 signed result.** The
  source uses reflected supporting lines to construct their intersection;
  reversing propagation along the same reflected line does not change the
  caustic or the requested power law. The signed coordinate branches remain
  represented as above.

## Declarations and blueprint labels

- Blueprint label `thm:physics:IPhO_2026_2_C_4:target` maps to
  `IPhO2026Problems.IPhO2026_2_C_4.smallAngleCausticPowerLaw`.
- Supporting theorem:
  `IPhO2026Problems.IPhO2026_2_C_4.deltaThetaEventuallySmallerThanTheta`.
- Supporting model declarations:
  `Figure2gFrame`, `ReflectedRayReadout`, `reflectedLineYReadout`,
  `mirrorPointXReadout`, `mirrorPointYReadout`,
  `SatisfiesFigure2gReflectionLaw`, `FormsNeighboringRayCaustic`,
  `HasPreviousPartC3Coordinates`, `Figure2gCausticModel`,
  `reflectedRayA`, `reflectedRayB`, `CausticPowerLawParameters`, and
  `HasSmallAnglePowerLaw`, all in the same namespace.
- The target is ready for statement-level `\leanok`. Per prover permissions
  and `.archon/AGENTS.md`, the blueprint was not edited; deterministic
  synchronization/review should attach
  `\lean{IPhO2026Problems.IPhO2026_2_C_4.smallAngleCausticPowerLaw}`.

## LeanExplore queries/candidates actually used

All searches used package filters `["Mathlib", "Physlib"]`.

- Query `small angle asymptotic equivalence of real functions near zero`:
  selected `Asymptotics.IsEquivalent`, `Real.isEquivalent_sin`, and
  `Asymptotics.IsEquivalent.rpow`.
- Query
  `Asymptotics.IsEquivalent Real.rpow real absolute value punctured
  neighborhood zero`: selected `Real.rpow` and confirmed the real-power
  asymptotics route.
- Query
  `dimensionful physical length quantity radius coordinates units WithDim
  length`: selected PhysLean `LengthUnit`; inspected `WithDim` and
  `Dimension.L𝓭` as alternatives.
- Query
  `one minus cosine asymptotically equivalent to x squared divided by two
  near zero`: selected `Real.cos_bound` as the explicit quadratic-error
  carrier.
- Query `Real.cos Taylor expansion at zero second order little o`: selected
  `taylor_isLittleO`, `taylor_isLittleO_univ`, and
  `Real.analyticAt_cos` as an alternative general Taylor route.
- Query
  `Real.mul_rpow nonnegative product real powers and rpow natural power`:
  selected `Real.mul_rpow`.
- Query `specular reflection optical ray mirror normal direction law`:
  inspected `EuclideanGeometry.reflection`, `Space.Direction`,
  `RayVector`, and `Module.Ray` as near matches; none carries the exact
  Figure 2g slope-intercept/envelope data.

For the declarations selected for use, source text and module paths were
fetched rather than relying only on search summaries.

## PhysLean/Mathlib names grounded

- PhysLean/Physlib:
  `LengthUnit` from `Physlib.SpaceAndTime.Space.LengthUnit`.
- Mathlib:
  `Asymptotics.IsEquivalent` from
  `Mathlib.Analysis.Asymptotics.Defs`;
  `Asymptotics.IsEquivalent.rpow` from
  `Mathlib.Analysis.Asymptotics.SpecificAsymptotics`;
  `Real.rpow` and `Real.mul_rpow` from
  `Mathlib.Analysis.SpecialFunctions.Pow.Real`;
  `Real.isEquivalent_sin` and `Real.analyticAt_cos` from
  `Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv`;
  `Real.cos_bound` from
  `Mathlib.Analysis.Complex.Trigonometric`;
  `taylor_isLittleO` and `taylor_isLittleO_univ` from
  `Mathlib.Analysis.Calculus.Taylor`;
  `Filter.Tendsto`, punctured-neighborhood notation `𝓝[≠]`, `Real.sin`,
  `Real.cos`, `abs`, and `Nat.Coprime`.

## Local abstractions introduced

- `Figure2gFrame` combines an existing physical `LengthUnit` with a positive
  radius readout and documents the coordinate convention. It avoids treating
  the mirror itself as a bare real alias.
- `ReflectedRayReadout` is the smallest source-shaped carrier for the
  incident-angle and slope-intercept data explicitly requested in the problem.
- `SatisfiesFigure2gReflectionLaw` is a faithful, equation-bearing local
  optics interface because the searched affine/module ray APIs do not encode
  reflection at a curved mirror in this chart.
- `FormsNeighboringRayCaustic` captures the physical envelope construction by
  incidence equations and limits, not by an opaque “forms a caustic” tag.
- `Figure2gCausticModel` packages the governing laws, ray/intersection data,
  caustic readouts, and authorized C.3 result without importing sibling Lean
  files.
- `CausticPowerLawParameters` and `HasSmallAnglePowerLaw` distinguish generic
  candidate data from the asymptotic property to be proved. They do not define
  the current answer.

## Grounding gaps

- No dedicated Mathlib/PhysLean specular-optics API was found that combines a
  curved mirror, the Figure 2g hit angle, a slope-intercept reflected line,
  neighboring-ray intersections, and their caustic limit.
  `EuclideanGeometry.reflection` reflects points in an affine subspace;
  `Module.Ray` forgets the hit point and line intercept; `Space.Direction`
  supplies a unit direction but not the source's line/envelope data. The local
  equation-bearing interfaces are therefore the smaller faithful carriers.
- LeanExplore did not return a declaration stating the exact composite
  second-order asymptotic for
  `cos θ * (2 - cos (2θ))`. `Real.cos_bound` and the general Taylor theorem
  supply adequate grounded ingredients, so this is not a statement-layer
  blocker.
- `WithDim Dimension.L𝓭 ℝ` was inspected but not used for the scalar
  coordinate readouts: the requested fractional power coefficient has
  dimension `length^(1/3)`, while the contract is explicitly about numerical
  readouts in one fixed `LengthUnit`. This preserves the physical role without
  inventing unsupported fractional-dimension operations.
- `archon dag-query` was unavailable on this lane's `PATH`. The only
  prerequisite named by the source is C.3, and it was restated locally per the
  explicit natural-language-only dependency policy.

## Redraft requests

- The blueprint target environment has no `\lean{...}` declaration
  association. Synchronization/review should attach the main theorem name
  above. No change to the informal physics statement is requested.

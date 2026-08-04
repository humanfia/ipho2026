# Autoformalization result: IPhO 2026 problem 2 C.3

The assigned file was absent initially and was created at
`IPhO2026Problems/problem_IPhO_2026_2_C_3.lean`.  It compiles with six expected
`sorry` warnings and no errors under:

`lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_3.lean`

The chapter contains `% archon:physics`, so the physics-formalize discipline was
used.  Figure 2g on the official source-page image was inspected: its origin is
the center of the upper semicircle, the incoming rays point vertically upward,
the reflected branch points away from the mirror, and ray B is indexed by the
larger angle `θ + Δθ`.

## Assumption/target split

### Governing laws

- `Figure2gOptics.radiusPositive` states that the mirror-radius coordinate
  readout is positive.
- `Figure2gOptics.incomingVertical` and `incomingForward` state that the common
  incoming direction has zero horizontal component and positive vertical
  component.  A single shared direction records that A and B are parallel
  before reflection.
- `Figure2gOptics.incomingImpact_eq` places the impact indexed by `α` at
  `(R sin α, R cos α)`.
- `Figure2gOptics.reflectedStartsAtImpact` anchors the outgoing reflected ray at
  that impact.
- `Figure2gOptics.reflectedLineLaw` is the C.1 reflection law: every point on
  the outgoing ray satisfies
  `y = cot(2α) x + R/(2 cos α)`.
- `OrientedRay2D.Contains` is not opaque: it gives a nonnegative affine
  parameter and two coordinate equations for the outgoing half-line.

### Previous-part results

- C.1 is carried by `reflectedSlope`, `reflectedIntercept`,
  `LiesOnReflectedSupport`, and `Figure2gOptics.reflectedLineLaw`.
- C.2 is carried independently by `slopeFirstOrderRemainder`,
  `interceptFirstOrderRemainder`, `HasFigure2gFirstOrderExpansions`, and
  `previousPartC2_firstOrderExpansions`.  Both quoted expansions have a genuine
  `Asymptotics.IsBigO` remainder against `δ ↦ δ ^ 2`.
- No sibling Lean file is imported or referenced; previous parts are encoded
  from the natural-language prerequisite statements only.

### Figure/data readouts

- The physical plane is `Physlib.SpaceAndTime.Space.Basic.Space 2`, not a
  scalar alias.  `xCoord` and `yCoord` are real coordinate readouts in the
  fixed length unit carried by Physlib's space.
- `OnUpperSemicircularMirror` exposes the equation `x² + y² = R²` and the
  upper-branch inequality `0 ≤ y`.
- `IsAdmissibleAngle α` records `0 < α < π/2`, selecting the right-hand part of
  the upper semicircle displayed in Figure 2g.
- `impactPoint R α` records the figure coordinates
  `(R sin α, R cos α)`.
- `IsNeighboringReflectedIntersection` records positive `δ`, both admissible
  angles, and membership of the point in the two outgoing rays.
- `δMax > 0` and `θ + δMax < π/2` provide a sufficiently small angular window.

### Current target conclusions

- `limitingIntersectionCoordinates` concludes
  `Tendsto intersection (𝓝[>] 0)` to the physical point with coordinates
  `X_c = R * sin θ ^ 3` and
  `Y_c = (R / 2) * cos θ * (2 - cos (2 * θ))`.
- `supportIntersectionCandidate_tendsto` records the corresponding pure
  analytic bridge as its own proof obligation.

## Goal-faithfulness audit

The requested closed-form coordinates do not occur in `Figure2gOptics`, in
`IsNeighboringReflectedIntersection`, in the finite-intersection hypothesis of
the main theorem, or in any governing-law premise.  They occur only in the
conclusions of `supportIntersectionCandidate_tendsto` and
`limitingIntersectionCoordinates`, both with `by sorry` proof obligations.

`supportIntersectionCandidate` does not define the caustic answer.  It only
solves two finite affine support-line equations at distinct angles; obtaining
its limit and simplifying that limit to the requested coordinates remains the
substantive theorem `supportIntersectionCandidate_tendsto`.  The `rfl` proofs
are restricted to the two coordinate projections of the `planarPoint` naming
helper.

The main assumptions allow only: physical geometry, the C.1 reflection law,
actual outgoing-ray intersection, the positive-neighbor branch, and a local
angle window.  None states a limit or either final coordinate.

## Derivability and bridge obligations

- **Figure point to mirror geometry** — source claim: the impact lies on the
  upper semicircle.  Carrier:
  `impactPoint_on_upperSemicircularMirror`.  Evidence: explicit circle equation
  and upper-half inequality in `OnUpperSemicircularMirror`.  **Status:
  covered** (carrier present; proof deferred at autoformalize stage).
- **C.1 coefficients to a constraining ray law** — source claim:
  `m_A = cot(2θ)` and `b_A = R/(2 cos θ)`.  Carriers:
  `reflectedSlope`, `reflectedIntercept`,
  `Figure2gOptics.reflectedLineLaw`.  Evidence: the field eliminates ray
  membership to the displayed affine equation.  **Status: covered**.
- **C.2 truncation to rigorous asymptotics** — source claim: the neighboring
  coefficients have the quoted first-order terms up to `O(Δθ²)`.  Carriers:
  `HasFigure2gFirstOrderExpansions` and
  `previousPartC2_firstOrderExpansions`.  Evidence: two explicit Mathlib
  `IsBigO (𝓝 0) ... (fun δ => δ ^ 2)` propositions.  **Status: covered**.
- **Different angles to distinct support lines** — source claim: for positive
  `Δθ`, the two reflected slopes differ on the admissible interval.  Carrier:
  `reflectedSlope_ne_of_angle_lt`.  Evidence: hypotheses expose both angle
  bounds and the strict ordering.  **Status: covered**.
- **Physical ray intersection to algebraic intersection** — source claim:
  solving the two reflected-line equations gives a unique finite intersection.
  Carriers: `supportIntersectionCandidate` and
  `neighboringIntersection_eq_supportIntersectionCandidate`.  Evidence:
  `IsNeighboringReflectedIntersection` supplies outgoing-ray membership, the
  model eliminates membership to two equations, and the slope-separation lemma
  excludes a zero denominator.  **Status: covered**.
- **Finite intersection to caustic limit** — source claim: take
  `Δθ → 0⁺` and simplify the resulting trigonometric expressions.  Carrier:
  `supportIntersectionCandidate_tendsto`.  Evidence: a right-neighborhood
  `Filter.Tendsto` statement whose codomain point contains both requested
  formulas.  **Status: covered**.
- **Source problem to final theorem contract** — source claim: the limiting
  intersection of actual neighboring reflected rays has the stated
  coordinates.  Carrier: `limitingIntersectionCoordinates`.  Evidence: the
  premise provides intersections for every sufficiently small positive
  separation, and the conclusion is the requested physical-space limit.
  **Status: covered**.

No bridge is structurally blocked.  All substantive bridge proofs intentionally
remain `sorry` in this autoformalization stage.

## Abstraction sufficiency and countermodel audit

- `OrientedRay2D.Contains` exposes a witness `t ≥ 0` and exact `x`/`y` affine
  equations.  It cannot be interpreted as an arbitrary ray-incidence
  proposition.
- `IsAdmissibleAngle` exposes two strict inequalities.
- `OnUpperSemicircularMirror` exposes the circle equation and the upper-half
  inequality.
- `LiesOnReflectedSupport` exposes the reflected-line equation directly.
- `IsNeighboringReflectedIntersection` exposes `δ > 0`, both angle branches,
  and membership in each explicit outgoing ray.
- `HasFigure2gFirstOrderExpansions` exposes two quantitative `IsBigO`
  consequences; it is not an opaque assertion that an expansion exists.
- The proposition-valued fields of `Figure2gOptics` expose positivity,
  direction-component equations/inequalities, impact equality, vertex
  equality, and an elimination rule from ray membership to the line equation.

Countermodel check: even if the ray directions and intersection function are
otherwise chosen arbitrarily, the intersection premise and
`reflectedLineLaw` force each small-`δ` point to satisfy both explicit affine
equations.  Admissibility plus `δ > 0` makes their slopes distinct, so the point
is forced to equal `supportIntersectionCandidate`.  Consequently the model
cannot preserve all assumptions while assigning an unrelated caustic limit.

## Uncertainty and branch coverage

- **Uncertainty: genuinely not applicable.** The source reports symbolic exact
  expressions and no measured `value ± uncertainty`.
- **Incoming/outgoing orientation: covered.** The common incoming direction is
  vertical and future-pointing in the figure convention; outgoing membership
  uses a nonnegative ray parameter from the mirror impact.
- **Neighbor side: covered.** Ray B has angle `θ + δ`, `δ > 0`, and the limit
  uses `𝓝[>] 0`.
- **Mirror branch: covered.** `0 < α < π/2` selects the right-hand upper
  semicircle shown in Figure 2g.

## Declarations and blueprint labels

- Blueprint label `thm:physics:IPhO_2026_2_C_3:target` corresponds to
  `IPhO2026Problems.IPhO2026_2_C_3.limitingIntersectionCoordinates`.
  It is ready for the deterministic `sync_leanok` phase once the blueprint has
  a matching `\lean{...}` link.
- Supporting physical declarations:
  `PlanarPoint`, `OrientedRay2D`, `OrientedRay2D.Contains`,
  `IsAdmissibleAngle`, `OnUpperSemicircularMirror`, `impactPoint`,
  `reflectedSlope`, `reflectedIntercept`, `LiesOnReflectedSupport`, and
  `Figure2gOptics`.
- Supporting bridge declarations:
  `impactPoint_on_upperSemicircularMirror`,
  `HasFigure2gFirstOrderExpansions`,
  `previousPartC2_firstOrderExpansions`,
  `supportIntersectionCandidate`,
  `reflectedSlope_ne_of_angle_lt`,
  `neighboringIntersection_eq_supportIntersectionCandidate`, and
  `supportIntersectionCandidate_tendsto`.

The blueprint was not edited because prover write permissions make it
read-only; marker synchronization is owned by the later sync phase.

## LeanExplore queries and candidates actually used

- Query `physical quantity with SI dimension of length dimensional quantity
  units` returned `Dimensionful`, `HasDimension`, `UnitChoices.SI`, and
  `UnitExamples.meters400`.  Their source was inspected.  The formalization
  instead uses Physlib's already-physical `Space 2` for points and names all
  reals as coordinate readouts; this avoids an unnecessary conversion between
  dimensionful quantities and `Space` coordinates.
- Query `two dimensional Euclidean point coordinates Fin 2` returned
  `Space.eq_of_apply` and `Space.coord_apply`; source/module inspection grounded
  `Space` in `Physlib.SpaceAndTime.Space.Basic`.
- Query `Real cotangent definition and sine cosine identities` returned and
  grounded `Real.cot`, `Real.cot_eq_cos_div_sin`, `Real.sin`, and `Real.cos`.
  `Real.cot` is used for the reflected slope.
- Query `Tendsto function as a real variable approaches zero from the positive
  side` returned `tendsto_inv_nhdsGT_zero`; its source confirmed the
  `𝓝[>] 0` right-neighborhood convention used in the target.
- Query `first order expansion with quadratic remainder IsBigO near zero`
  returned `HasFPowerSeriesWithinAt.isBigO_sub_partialSum_pow` and related
  near-misses.  The generic carrier needed here is
  `Asymptotics.IsBigO`, whose argument order and syntax were verified with the
  Lean LSP.

## PhysLean/Mathlib names grounded

- Physlib: `Space`, specifically `Space 2`, from
  `Physlib.SpaceAndTime.Space.Basic`.
- Mathlib: `Real.sin`, `Real.cos`, `Real.tan`, `Real.cot`, `Real.pi`,
  `Asymptotics.IsBigO`, `Filter.Tendsto`, ordinary neighborhoods `𝓝`, and
  right neighborhoods `𝓝[>]`.

All listed names were checked in the project environment with LeanExplore
source/module retrieval or Lean LSP snippets before use.

## Local abstractions introduced

- `OrientedRay2D` is the smallest local ray object needed to retain a physical
  vertex, a nonzero direction, and the outgoing half-line orientation.
- `Figure2gOptics` is a local governing-law interface because no matching
  Physlib half-cylindrical-mirror/reflection API was found.  Its fields expose
  the geometry and affine reflection equations used by later proofs.
- `IsNeighboringReflectedIntersection` packages the positive neighboring-angle
  branch and membership in both outgoing rays without asserting any limit.
- `HasFigure2gFirstOrderExpansions` packages the two rigorous C.2 asymptotic
  bounds.

These abstractions preserve the physical roles and expose all mathematical
consequences needed to derive the target.

## Grounding gaps

- No ready-made Physlib API for an oriented geometrical-optics ray, a
  half-cylindrical mirror, specular reflection in Figure 2g coordinates, or a
  caustic envelope was found.  The explicit local interfaces above fill this
  gap without assuming the current answer.
- Mathlib exposes cotangent but no candidate was needed for a separate cosecant
  object; `csc(2θ)^2` is faithfully represented as
  `1 / Real.sin (2 * θ) ^ 2`.
- The `archon` DAG helper was unavailable on this lane's shell `PATH`; this did
  not block formalization because the chapter gives no Lean dependency links
  and sibling outputs were prohibited by the previous-part policy.

No redraft request is needed.

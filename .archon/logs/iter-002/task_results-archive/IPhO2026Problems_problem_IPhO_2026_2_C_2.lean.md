# Autoformalization result: IPhO 2026 Problem 2 C.2

## Status

- Created `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean`.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_2.lean` exits successfully.
- The only diagnostic is the expected `declaration uses sorry` warning on
  `rayB_firstOrderExpansion`.
- No `/- USER: ... -/` comment existed because the assigned Lean file did not
  exist before this lane.
- The chapter contains `% archon:physics`, so the physics-formalize discipline
  was used.

## Assumption/target split

### Governing laws

- `HalfCylindricalMirror.radius_pos` says that the mirror has a positive radius.
- `SatisfiesHalfCylindricalSpecularLaw` gives the exact coefficient consequence
  of reflection at an arbitrary incidence angle:
  `m = cot (2φ)` and `b = R / (2 cos φ)`.
- `hsin` and `hcos` record the nonsingular-angle conditions needed to expand
  cotangent and secant locally.

### Previous-part results

- `SatisfiesPreviousPartC1 mirror θ rayA` records precisely the reusable C.1
  result `m_A = cot (2θ)` and `b_A = R / (2 cos θ)`. It is local
  natural-language input and creates no Lean dependency on the sibling file.

### Figure/data readouts

- `Point2D`, `Direction2D`, `AffineLineReadout`, `OpticalRay2D`, and
  `Figure2gRayLabel` retain the coordinate and ray roles in Figure 2g.
- `HasFigure2gGeometry` records the upper semicircle, the incidence point
  `(R sin φ, R cos φ)`, vertical incoming orientation, line incidence, and the
  left-going reflected branch.
- `hA_geometry` labels the base ray `A` at angle `θ`.
- `hB_geometry` labels the neighboring ray `B` at angle `θ + Δθ` near zero.
- `h_parallel` records that `A` and `B` have the same directed incoming
  direction.
- `hθ_pos` and `hθ_lt` retain the interior upper-semicircle angle range.

### Current target conclusions

- The slope remainder
  `m_B(Δθ) - (cot (2θ) - 2 (sin (2θ))⁻² Δθ)` is
  `O(Δθ²)` as `Δθ → 0`.
- The intercept remainder
  `b_B(Δθ) - (R / (2 cos θ)) (1 + tan θ Δθ)` is
  `O(Δθ²)` as `Δθ → 0`.

## Goal-faithfulness audit

Neither first-order expansion nor either `IsBigO` conclusion occurs in a
hypothesis, premise structure, local definition, or law predicate. The
reflection-law hypothesis contains only the exact generic-angle optical law
inherited from the C.1 calculation. The `θ + Δθ` specialization is supplied
separately by Figure 2g geometry. The requested linear coefficients and the
quadratic remainder order appear only in the conclusion of
`rayB_firstOrderExpansion`.

No answer was made true by unfolding a helper definition. The only naming
definitions describe geometry, incidence, line membership, parallelism, the
previous-part result, and the exact governing law.

## Derivability and bridge obligations

1. **Source claim:** ray `B` is incident at `θ + Δθ`.
   **Lean carrier:** the incidence-angle equality inside
   `HasFigure2gGeometry`, supplied eventually by `hB_geometry`.
   **Evidence:** this is a concrete equality, not an opaque incidence
   predicate.
   **Status:** covered (encoded locally).

2. **Source claim:** `A` and `B` are neighboring parallel rays in the Figure 2g
   orientation.
   **Lean carrier:** `h_parallel`, plus the explicit vertical incoming
   direction and left-going outgoing branch in `HasFigure2gGeometry`.
   **Evidence:** direction equality and component equality/inequality are
   exposed directly.
   **Status:** covered (encoded locally).

3. **Source claim:** circular-mirror specular reflection gives the exact slope
   and intercept at a generic incidence angle.
   **Lean carrier:** `SatisfiesHalfCylindricalSpecularLaw`, with reusable
   eliminators `slope_eq_of_specular_law` and
   `intercept_eq_of_specular_law`.
   **Evidence:** the relation exposes the two exact equations.
   **Status:** covered (faithful local optical-law interface).

4. **Source claim:** substituting the neighboring incidence angle gives
   `m_B(Δθ) = cot (2(θ + Δθ))`.
   **Lean carrier:** `h_reflection`, the incidence equality from
   `hB_geometry`, and `slope_eq_of_specular_law`.
   **Evidence:** all equalities needed for rewriting occur in the contract.
   **Status:** covered.

5. **Source claim:** the first derivative of the slope coefficient is
   `-2 csc²(2θ)`.
   **Lean carrier:** Mathlib's `Real.cot_eq_cos_div_sin`,
   `Real.hasDerivAt_sin`, and `Real.hasDerivAt_cos`, together with `hsin`.
   **Evidence:** the target writes `csc²(2θ)` as `(sin (2θ))⁻¹ ^ 2`.
   **Status:** covered; the later physics proof must assemble the derivative
   and second-order remainder.

6. **Source claim:** substituting the neighboring incidence angle gives
   `b_B(Δθ) = R / (2 cos (θ + Δθ))`.
   **Lean carrier:** `h_reflection`, `hB_geometry`, and
   `intercept_eq_of_specular_law`.
   **Evidence:** the exact intercept equation is directly exposed.
   **Status:** covered.

7. **Source claim:** the first derivative of the intercept coefficient is
   `(R / (2 cos θ)) tan θ`.
   **Lean carrier:** Mathlib's `Real.hasDerivAt_cos`, ordinary derivative
   division/inversion rules, and `hcos`.
   **Evidence:** the resulting linear term occurs only in the theorem target.
   **Status:** covered; the later physics proof must assemble the derivative
   and second-order remainder.

8. **Source claim:** “up to `O(Δθ²)`” is a genuine asymptotic error statement.
   **Lean carrier:** Mathlib's `Asymptotics.IsBigO` at `𝓝 0`, used directly in
   both main conclusions.
   **Evidence:** `IsBigO` means the remainder norm is eventually bounded by a
   constant multiple of `|Δθ²|`.
   **Status:** covered (grounded in Mathlib).

## Abstraction sufficiency and countermodel audit

- `OnUpperSemicircle` constrains a point by
  `x² + y² = R² ∧ 0 ≤ y`.
- `AffineLineReadout.Contains` constrains incidence by
  `y = slope * x + yIntercept`.
- `HasFigure2gGeometry` exposes label, incidence-angle, incidence-coordinate,
  semicircle, incoming-direction, line-incidence, and outgoing-orientation
  equations/inequalities. Its fields cannot be interpreted arbitrarily.
- `HaveParallelIncomingDirections` is the concrete direction equality.
- `SatisfiesPreviousPartC1` is the conjunction of the two exact C.1 equations.
- `SatisfiesHalfCylindricalSpecularLaw` is the conjunction of the two generic
  exact reflection equations, with explicit elimination theorems.

Consequently there is no opaque local `Prop` interface whose arbitrary
interpretation could satisfy all assumptions while falsifying the target. In
particular, the exact law and angle specialization determine both target
coefficient functions near zero; the remaining obligations are analytic
Taylor estimates.

## Uncertainty and branch coverage

- **Uncertainty:** genuinely not applicable. The source supplies no measured
  value or `value ± uncertainty`.
- **Approximation error:** covered. Both answers retain the stated
  `O(Δθ²)` remainder using `Asymptotics.IsBigO`.
- **Small-neighbor condition:** covered by taking `Δθ → 0` through the
  neighborhood filter, which is the precise mathematical reading of
  `Δθ ≪ θ` for a first-order expansion.
- **Orientation/branch:** covered. Figure 2g's incoming direction is upward
  vertical, and the outgoing reflected ray is explicitly left-going with its
  direction constrained to the signed reflected line. This prevents selecting
  the sign of the slope only in the conclusion.

## Declarations created and blueprint correspondence

All declarations are in namespace
`IPhO2026Problems.IPhO2026_2_C_2`.

- Physical/figure data:
  `Point2D`, `Direction2D`, `verticalIncomingDirection`,
  `AffineLineReadout`, `Figure2gRayLabel`, `OpticalRay2D`,
  `HalfCylindricalMirror`.
- Constraining interfaces:
  `OnUpperSemicircle`, `AffineLineReadout.Contains`,
  `HasFigure2gGeometry`, `HaveParallelIncomingDirections`,
  `SatisfiesPreviousPartC1`, `SatisfiesHalfCylindricalSpecularLaw`.
- Bridge eliminators:
  `slope_eq_of_specular_law`, `intercept_eq_of_specular_law`.
- Main declaration:
  `IPhO2026Problems.IPhO2026_2_C_2.rayB_firstOrderExpansion`.

The main declaration corresponds to
`thm:physics:IPhO_2026_2_C_2:target`. The chapter currently has no
`\lean{...}` annotation naming it, so the plan/review machinery should attach
the full main declaration name before expecting deterministic marker sync.
The prover did not edit the blueprint, per local role permissions.

## LeanExplore queries/candidates actually used

- Query: `Asymptotics.IsBigO function remainder is big O at neighborhood zero`
  - Used `Asymptotics.IsBigO`
    (`Mathlib.Analysis.Asymptotics.Defs`).
- Query: `Taylor expansion first order differentiable twice remainder big O
  squared near a point`
  - Inspected `DifferentiableAt.isBigO_sub` and Taylor/power-series candidates;
    these ground the available asymptotic framework, though none alone states
    the exact trigonometric quadratic remainders.
- Query: `Real.hasDerivAt_sin Real.hasDerivAt_cos derivative tan cotangent`
  - Used `Real.hasDerivAt_sin` and `Real.hasDerivAt_cos`
    (`Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv`).
- Query: `Real.cot Real.tan cotangent cosecant csc`
  - Used `Real.cot` and `Real.cot_eq_cos_div_sin`
    (`Mathlib.Analysis.Complex.Trigonometric`).
- Query: `geometric optics reflection law ray circular mirror caustic`
  - The returned `Module.Ray`, Euclidean point-reflection, and polynomial
    mirror declarations are not geometric-optics ray/reflection interfaces.

All searches passed package filters `["Mathlib", "Physlib"]`.

## PhysLean/Mathlib names grounded

- `Asymptotics.IsBigO`
- `Real.cot`
- `Real.cot_eq_cos_div_sin`
- `Real.sin`
- `Real.cos`
- `Real.tan`
- `Real.hasDerivAt_sin`
- `Real.hasDerivAt_cos`
- `DifferentiableAt.isBigO_sub` (inspected for the later proof route)
- `Filter.Eventually` notation `∀ᶠ`
- neighborhood notation `𝓝`

No matching PhysLean optical-ray or circular-mirror specular-reflection API was
found.

## Local abstractions introduced

- `Point2D` and `Direction2D` retain coordinate and orientation roles without
  pretending that a physical ray is merely a real scalar.
- `AffineLineReadout` separates the dimensionless slope from the
  length-valued intercept readout.
- `OpticalRay2D` retains incidence point/angle, incoming/outgoing directions,
  figure label, and reflected-line readout.
- `HalfCylindricalMirror` retains the positive-radius physical object.
- The geometry, previous-part, parallelism, and reflection predicates are the
  smallest local interfaces needed to expose the equations and inequalities
  used by a future proof.

Real numbers are used only for radians, dimensionless slopes/direction
components, and scalar coordinate/length readouts, as permitted by the source.

## Grounding gaps

- PhysLean has no located geometric-optics abstraction matching a ray reflected
  by a half-cylindrical mirror. The locally encoded exact coefficient law is
  therefore necessary.
- LeanExplore did not return a single theorem that directly packages the two
  required trigonometric first-order expansions with quadratic `IsBigO`
  remainders. This is not a statement-level blocker: the exact equations,
  nonsingularity conditions, derivative declarations, and asymptotic target
  are all present for the later proof.
- Blueprint redraft request: add
  `\lean{IPhO2026Problems.IPhO2026_2_C_2.rayB_firstOrderExpansion}` to the
  target theorem environment. No source physics redraft is otherwise needed.

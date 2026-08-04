# `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean`

## Result

- Redrafted the C.2 model to use Physlib's unit-independent
  `Dimensionful (WithDim Dimension.L𝓭 ℝ)` carrier for every length.
- Added the named SI-length projection `lengthSI`; all coordinate, radius,
  line-incidence, exact-intercept, and asymptotic-intercept equations now use
  that projection.
- Preserved dimensionless angles, slopes, and direction components, the
  Figure 2g labels and left-going branch, both denominator conditions, and
  both quadratic `IsBigO` remainders.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_2.lean` exits 0 with
  exactly the expected `sorry` warning on `rayB_firstOrderExpansion`.
- The project library check `lake build IPhO2026Run` also completes
  successfully.

## Assumption/target split

### Governing laws

- `SatisfiesHalfCylindricalSpecularLaw mirror ray` gives the exact slope and
  SI-intercept coefficients of a reflected ray at its own incidence angle.
  This is the exact optical law to be expanded, not either requested
  first-order approximation.
- `h_reflection` applies that exact law eventually near `Δθ = 0`.
- `hsin : Real.sin (2 * θ) ≠ 0` and
  `hcos : Real.cos θ ≠ 0` keep the two analytic coefficient functions away
  from their relevant singularities at the expansion point.

### Previous-part results

- `SatisfiesPreviousPartC1 mirror θ rayA` records only
  `m_A = cot (2θ)` and
  `lengthSI b_A = lengthSI R / (2 cos θ)`.
- The sibling Lean output is not imported; C.1 is restated as the
  natural-language prerequisite required by the chapter.

### Figure/data readouts

- `HasFigure2gGeometry` records the A/B label, incidence angle, SI coordinates
  `(R sin φ, R cos φ)`, upper-semicircle membership, upward vertical incoming
  direction, incidence on the reflected line, left-going condition
  `outgoing.dx < 0`, and the direction/slope equation.
- `hB_geometry` identifies ray B's incidence angle with `θ + Δθ` eventually.
- `HaveParallelIncomingDirections` and `h_parallel` preserve the stated
  parallel directed incoming rays.
- `hθ_pos` and `hθ_lt` preserve the Figure 2g angular regime.

### Current target conclusions

- The slope residual after subtracting
  `cot (2θ) - 2 (sin (2θ))⁻² Δθ` is `O(Δθ²)` at zero.
- The SI-intercept residual after subtracting
  `[lengthSI R / (2 cos θ)] (1 + tan θ Δθ)` is `O(Δθ²)` at zero.
- These occur only in the conclusion of `rayB_firstOrderExpansion`.

## Goal-faithfulness audit

Neither first-order expansion occurs in a hypothesis, structure field,
`Satisfies...` predicate, or helper definition. The specular-law predicate
contains only the exact angle-dependent coefficient equations. Obtaining the
displayed linear terms and quadratic bounds still requires a genuine Taylor
argument after substituting the Figure 2g incidence-angle equation. The named
`lengthSI` helper is only a unit projection and does not encode either target
formula.

The result is not weakened: it retains two local `IsBigO` statements rather
than pointwise equalities, limits without rates, or informal approximation
notation.

## Derivability and bridge obligations

1. **Physical lengths to analytic scalar equations — covered.**
   Source claim: radius, coordinates, and intercept have the dimension of
   length, while the analytic equations use a common unit. Carrier:
   `LengthQuantity := Dimensionful (WithDim Dimension.L𝓭 ℝ)` and
   `lengthSI q := (q.1 UnitChoices.SI).val`. Evidence: LeanExplore grounded
   `Dimensionful`, `WithDim`, `Dimension.L𝓭`, `UnitChoices.SI`, and
   `UnitChoices.SI_length`.

2. **Figure angle for the neighboring ray — covered.**
   Source claim: ray B is incident at `θ + Δθ`. Carrier:
   `HasFigure2gGeometry` includes
   `ray.incidenceAngle = φ`, and `hB_geometry` instantiates
   `φ = θ + Δθ` eventually.

3. **Exact optical coefficients — covered.**
   Source claim: the circular-mirror reflection law gives the exact
   coefficients before expansion. Carrier:
   `SatisfiesHalfCylindricalSpecularLaw`, with reusable eliminators
   `slope_eq_of_specular_law` and `intercept_eq_of_specular_law`.

4. **Combining local hypotheses near zero — covered.**
   Source claim: the Figure geometry and exact reflection law hold for all
   sufficiently small increments. Carrier: every local hypothesis is stated
   with `Filter.Eventually` on the same filter `𝓝 (0 : ℝ)`, so Mathlib's
   eventual-filter conjunction rules can combine the angle and coefficient
   equations.

5. **Slope Taylor bridge — covered.**
   Source claim:
   `cot (2(θ+Δθ)) =
   cot (2θ) - 2 csc²(2θ) Δθ + O(Δθ²)`.
   Carrier: `Real.cot_eq_cos_div_sin`, `Real.analyticAt_sin`,
   `Real.analyticAt_cos`, `AnalyticAt.inv`, and either
   `AnalyticAt.exists_eq_sum_add_pow_mul` or
   `taylor_mean_remainder_lagrange`; `hsin` supplies nonsingularity and
   `Asymptotics.IsBigO` is the target remainder relation. The derivative
   coefficient is supported by `Real.hasDerivAt_sin`,
   `Real.hasDerivAt_cos`, and quotient/chain rules.

6. **Intercept Taylor bridge — covered.**
   Source claim:
   `R/(2 cos (θ+Δθ)) =
   [R/(2 cos θ)] (1 + tan θ Δθ) + O(Δθ²)`.
   Carrier: `Real.analyticAt_cos`, `AnalyticAt.inv`, the same Mathlib Taylor
   declarations, and real-field algebra; `hcos` supplies nonsingularity.
   Multiplication by the fixed SI scalar `lengthSI mirror.radius` preserves
   the quadratic Big-O bound.

7. **Direct source-to-contract mapping — covered.**
   The two conjuncts of `rayB_firstOrderExpansion` are exactly the two
   recorded source expansions, with `csc²(2θ)` represented as
   `(Real.sin (2 * θ))⁻¹ ^ 2` and the intercept evaluated through the SI
   projection required by the iteration-002 contract.

## Abstraction sufficiency and countermodel audit

- `OnUpperSemicircle` unfolds to the SI circle equation and the upper-half
  inequality.
- `AffineLineReadout.Contains` unfolds to the SI slope-intercept incidence
  equation.
- `HasFigure2gGeometry` unfolds to explicit label, angle, coordinate,
  surface-incidence, incoming-direction, line-incidence, branch-sign, and
  direction/slope constraints.
- `HaveParallelIncomingDirections` unfolds to equality of the two directed
  incoming directions.
- `SatisfiesPreviousPartC1` unfolds to the two exact C.1 coefficient equations
  for ray A.
- `SatisfiesHalfCylindricalSpecularLaw` unfolds to two exact coefficient
  equations at the ray's own angle; the two elimination theorems expose these
  equations without relying on opacity.
- `HalfCylindricalMirror.radius_pos` constrains the SI radius readout to be
  positive.

Countermodel check: after intersecting the eventual geometry and reflection
hypotheses, the incidence angle, slope, and SI-intercept of ray B are fixed
eventually by explicit equations. The unused internal values of a
dimensionful quantity at non-SI unit choices cannot falsify a conclusion that
is explicitly about its SI projection. Other ray fields may vary, but they do
not make either coefficient residual arbitrary. Thus the contract is not
underdetermined for either substantive target.

## Uncertainty and branch coverage

- **Measurement uncertainty — genuinely not applicable.** The source reports
  no measured `value ± uncertainty`. The `O(Δθ²)` term is an approximation
  remainder, not an experimental uncertainty.
- **Approximation order — covered.** Both conclusions explicitly retain a
  quadratic `IsBigO` remainder at `Δθ → 0`.
- **Incoming orientation — covered.** `verticalIncomingDirection = (0, 1)` and
  `HasFigure2gGeometry` identify each incoming direction with it.
- **Outgoing branch — covered.** `outgoingDirection.dx < 0` selects the
  left-going reflected branch, and the direction/slope equation retains its
  signed orientation.
- **Ray labels — covered.** `Figure2gRayLabel.A` and `.B` are imposed by the
  respective geometry hypotheses.
- **Signed increment — covered.** The neighborhood filter gives a two-sided
  local expansion in real `Δθ`; no unsupported sign choice is made.

## Declarations and blueprint labels

- `Point2D` — `def:physics:IPhO_2026_2_C_2:aux001`
- `Direction2D` — `def:physics:IPhO_2026_2_C_2:aux002`
- `verticalIncomingDirection` — `def:physics:IPhO_2026_2_C_2:aux003`
- `AffineLineReadout` — `def:physics:IPhO_2026_2_C_2:aux004`
- `Figure2gRayLabel` — `def:physics:IPhO_2026_2_C_2:aux005`
- `OpticalRay2D` — `def:physics:IPhO_2026_2_C_2:aux006`
- `HalfCylindricalMirror` — `def:physics:IPhO_2026_2_C_2:aux007`
- `OnUpperSemicircle` — `def:physics:IPhO_2026_2_C_2:aux008`
- `AffineLineReadout.Contains` — `def:physics:IPhO_2026_2_C_2:aux009`
- `HasFigure2gGeometry` — `def:physics:IPhO_2026_2_C_2:aux010`
- `HaveParallelIncomingDirections` — `def:physics:IPhO_2026_2_C_2:aux011`
- `SatisfiesPreviousPartC1` — `def:physics:IPhO_2026_2_C_2:aux012`
- `SatisfiesHalfCylindricalSpecularLaw` —
  `def:physics:IPhO_2026_2_C_2:aux013`
- `slope_eq_of_specular_law` — `lem:physics:IPhO_2026_2_C_2:aux014`
- `intercept_eq_of_specular_law` — `lem:physics:IPhO_2026_2_C_2:aux015`
- `rayB_firstOrderExpansion` — `thm:physics:IPhO_2026_2_C_2:target`

All indexed declaration statements are formalized. The main target retains its
expected autoformalization `sorry`; blueprint marker synchronization should
therefore treat its statement as formalized, not its proof as closed.

## Needs blueprint entry

- `IPhO2026Problems.IPhO2026_2_C_2.LengthQuantity` (line 13) — Physlib-backed
  length carrier used by `Point2D`, `AffineLineReadout`, and
  `HalfCylindricalMirror`.
- `IPhO2026Problems.IPhO2026_2_C_2.lengthSI` (line 18) — named SI projection
  used by every scalar length equation and the intercept asymptotic target.

These helpers were required by the iteration-002 redraft contract but do not
yet have dedicated blueprint blocks. The prover did not edit the blueprint
because its write permissions reserve that work for planning/review sync.

## LeanExplore queries and candidates actually used

All searches used `packages: ["Mathlib", "Physlib"]`.

- `physical quantity with length dimension and evaluation in SI length units`
  — used `UnitChoices.SI`, `Dimension`, `Dimension.L𝓭`, `Dimensionful`,
  `WithDim`, and `UnitChoices.SI_length`.
- `WithDim quantity dimension length SI value` — confirmed `WithDim`,
  `Dimensionful`, and the SI scaling interface.
- `asymptotic IsBigO Taylor expansion remainder quadratic derivative
  cotangent secant` — used `Asymptotics.IsBigO`,
  `AnalyticAt.exists_eq_sum_add_pow_mul`, and
  `taylor_mean_remainder_lagrange` as the target and future proof bridge.
- `HasDerivAt second order Taylor IsBigO square remainder` — confirmed the
  generic quadratic Taylor carriers above; no single theorem packages the two
  problem-specific trigonometric expansions.

Fetched sources/modules:

- `WithDim` — `Physlib.Units.WithDim.Basic`
- `Dimensionful` — `Physlib.Units.Basic`
- `UnitChoices.SI_length` — `Physlib.Units.Basic`
- `Asymptotics.IsBigO` — `Mathlib.Analysis.Asymptotics.Defs`
- `AnalyticAt.exists_eq_sum_add_pow_mul` —
  `Mathlib.Analysis.Analytic.Order`
- `taylor_mean_remainder_lagrange` —
  `Mathlib.Analysis.Calculus.Taylor`

## PhysLean/Mathlib names grounded

- PhysLean/Physlib: `Dimensionful`, `WithDim`, `Dimension.L𝓭`,
  `UnitChoices.SI`, `UnitChoices.SI_length`.
- Mathlib: `Asymptotics.IsBigO`, `Filter.Eventually`, `nhds`,
  `Real.sin`, `Real.cos`, `Real.tan`, `Real.cot`,
  `Real.cot_eq_cos_div_sin`, `Real.analyticAt_sin`,
  `Real.analyticAt_cos`, `AnalyticAt.inv`,
  `AnalyticAt.exists_eq_sum_add_pow_mul`,
  `taylor_mean_remainder_lagrange`, `Real.hasDerivAt_sin`, and
  `Real.hasDerivAt_cos`.

## Local abstractions introduced

- `LengthQuantity` and `lengthSI` connect the local optics model to Physlib's
  dimensionful unit API without collapsing a physical length to `ℝ`.
- `Point2D`, `AffineLineReadout`, and `HalfCylindricalMirror` preserve the
  distinct physical roles of position, line coefficient, and mirror radius.
- `Direction2D` remains a dimensionless signed component model because only
  Figure 2g orientation and the slope ratio are required.
- `OpticalRay2D` and `Figure2gRayLabel` retain the ray identity, incidence
  point/angle, directions, and reflected line.
- The six local `Prop` interfaces listed in the countermodel audit expose all
  required mathematical constraints directly.

## Grounding gaps and redraft requests

- LeanExplore located no ready-made Physlib geometric-optics object or
  half-cylindrical specular-reflection law matching Figure 2g. The smallest
  faithful local ray, mirror, geometry, and exact-law interfaces remain
  necessary.
- Mathlib has generic analytic/Taylor machinery but no single theorem
  packaging these two exact trigonometric `O(Δθ²)` expansions. This is not a
  statement-level blocker; all required exact equations, nonsingularity
  conditions, and remainder targets are present.
- Blueprint redraft request: add dedicated definition blocks for
  `LengthQuantity` and `lengthSI`. No source-physics redraft is requested.

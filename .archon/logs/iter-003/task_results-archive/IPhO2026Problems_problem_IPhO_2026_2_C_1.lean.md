# Autoformalization result: IPhO 2026 problem 2 C.1

The iteration-002 typed-physics redraft is complete.  The assigned file imports
`Physlib.Units.WithDim.Basic`, uses Physlib dimensionful length quantities for
the mirror radius, point coordinates, and line intercept, and exposes the named
SI projection `lengthInMetres` for all analytic coordinate and intercept
equations.

Verification:

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly four
  expected `declaration uses sorry` warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_1.lean`: exit code 0,
  with the same four expected warnings.

## Assumption/target split

### Governing laws

- `PlaneDirection.IsSpecularReflection` states the unit-normal vector law
  `d_out = d_in - 2 (d_in · n) n`.
- `SlopeInterceptLine.Contains` states the SI-coordinate incidence equation
  `y_SI = m*x_SI + b_SI`.
- `SlopeInterceptLine.HasDirection` states the supporting-direction equation
  `dy = m*dx`.
- `HalfCylindricalMirror.OnReflectingSurface` states the upper-semicircle
  equations `x_SI² + y_SI² = R_SI²` and `0 ≤ y_SI`.

### Previous-part results

- None.  C.1 is derived directly from the Figure 2g data and the reflection
  law; no sibling problem file or previous-part theorem is imported.

### Figure/data readouts

- `HalfCylindricalMirror.radius` is a `LengthQuantity :=
  Dimensionful (WithDim L𝓭 ℝ)` with positive SI-metre projection.
- `PlanePoint.x` and `.y` are length quantities; `SlopeInterceptLine.intercept`
  is a length quantity.  `PlaneDirection` components, line slope, and angles
  are dimensionless real numbers.
- `Figure2gRayInteraction.hit_point_x_from_figure` and
  `.hit_point_y_from_figure` state the Figure 2g hit coordinates
  `(R sin θ, R cos θ)` through `lengthInMetres`.
- `incoming_vertical_up` fixes the oriented incoming vector `(0,1)`.
- `normal_radial_outward` fixes the outward radial normal
  `(sin θ, cos θ)`.
- `reflected_ray_outgoing_down_left` records the signed outgoing branch by the
  strict component inequalities `dx < 0` and `dy < 0`.
- The marked-point equalities, surface membership, line incidence, and
  line-direction compatibility connect the ray, hit point, mirror, and
  supporting line.
- `Figure2gCausticSetup` retains ray B at `θ + Δθ`, `Δθ > 0`, its parallel
  incoming direction, a relative-smallness witness
  `|Δθ| ≤ relativeScale*|θ|` with `0 < relativeScale < 1`, and the common
  reflected-line intersection used by later caustic parts.

### Current target conclusions

- `m_A = Real.cot (2 * θ)`.
- `b_A,SI = R_SI / (2 * Real.cos θ)`.

The first is dimensionless.  The second is deliberately an equality of named
SI projections of dimensionful lengths, as required by the iteration-002
contract.

## Goal-faithfulness audit

- Neither requested coefficient formula occurs in
  `Figure2gRayInteraction`, `Figure2gCausticSetup`, or any governing-law
  predicate.
- `Figure2gRayInteraction.mA` and `.bA` only name the arbitrary slope and
  intercept fields of `reflectedLine`; unfolding them does not produce either
  answer.
- `lengthInMetres` only evaluates an arbitrary dimensionful length in the
  Physlib SI unit choice.  It contains no mirror, angle, slope, intercept, or
  target-specific formula.
- The doubled-angle outgoing vector appears only as the conclusion of
  `reflected_direction_from_specular_law`, not as a setup field.
- The branch premise supplies only signed orientation (`dx < 0`, `dy < 0`);
  it does not specify the doubled-angle components or either line
  coefficient.
- Countermodel check: without specular reflection, the outgoing direction can
  vary; without `HasDirection`, the slope can vary; without `Contains`, the
  intercept can vary; without the two hit-coordinate equations, the
  intercept can vary.  The retained carriers jointly constrain both targets.

## Derivability and bridge obligations

1. **Physlib length carrier and SI projection — covered.**
   Source claim: radius, point coordinates, and intercept have physical
   dimension length.  Lean carriers: `LengthQuantity` and
   `lengthInMetres`.  Evidence: grounded Physlib declarations
   `Dimensionful`, `WithDim`, `Dimension.L𝓭`, and `UnitChoices.SI`.

2. **Figure 2g impact geometry — covered.**
   Source claim: the hit point has Cartesian coordinates
   `(R sin θ, R cos θ)`.  Lean carriers:
   `hit_point_x_from_figure`, `hit_point_y_from_figure`, and
   `hit_on_reflecting_surface`.  These are locally encoded equations in the
   common SI-length projection.

3. **Incoming and normal orientations — covered.**
   Source claim: ray A propagates vertically upward and the normal points
   radially outward.  Lean carriers: `incoming_vertical_up` and
   `normal_radial_outward`.  Both expose exact signed component equations.

4. **Specular-reflection law — covered.**
   Source claim: reflection reverses the normal component and preserves the
   tangential component.  Lean carrier:
   `PlaneDirection.IsSpecularReflection`, which eliminates to
   `normal.IsUnit` and the explicit vector equation
   `outgoing = incoming - 2*(incoming·normal)*normal`.

5. **Outgoing branch — covered.**
   Source claim: Figure 2g selects the outgoing down-left ray.  Lean carrier:
   `reflected_ray_outgoing_down_left`.  This preserves branch signs
   independently of the requested closed form.

6. **Doubled-angle direction — covered at statement level.**
   Source step: substitution into the vector reflection law gives
   `(-2 sin θ cos θ, 1 - 2 cos² θ)`, simplified to
   `(-sin(2θ), -cos(2θ))`.  Lean carrier:
   `reflected_direction_from_specular_law`.  Mathlib trigonometric operations
   `Real.sin`, `Real.cos`, and the available double-angle lemmas support the
   later proof.  The body is intentionally `sorry` in autoformalization.

7. **Nonvertical denominator for the slope — covered.**
   Source step: `0 < θ < π/2` implies `sin(2θ) > 0`, hence the reflected
   x-component is nonzero.  Lean carriers:
   `incidenceAngle_pos`, `incidenceAngle_lt_pi_div_two`, the direction bridge,
   and Mathlib's real trigonometric order API.  This bridge makes
   `dy = m*dx` slope-determining rather than underconstrained.

8. **Slope computation — covered at statement level.**
   Source step: combine the doubled-angle direction with
   `reflected_line_has_ray_direction` and divide by the nonzero
   x-component.  Lean carrier: `reflected_line_slope`, whose conclusion is
   exactly `m_A = cot(2θ)`.  The body is intentionally `sorry`.

9. **Intercept computation — covered at statement level.**
   Source step: substitute the hit-point SI coordinates and the derived slope
   into `hit_on_reflected_line`, then simplify with double-angle identities to
   `b_A,SI = R_SI/(2 cos θ)`.  Lean carrier:
   `reflected_line_intercept`.  The positive-angle bounds supply the required
   nonzero cosine denominator.  The body is intentionally `sorry`.

10. **Complete source-to-contract mapping — covered.**
    Lean carrier:
    `IPhO2026Problems.IPhO2026_2_C_1.rayA_slope_and_intercept`.  Its two
    conjuncts are precisely the requested dimensionless slope and
    SI-projected physical intercept relations.  The body is intentionally
    `sorry`.

No statement-layer bridge is blocked.

## Abstraction sufficiency and countermodel audit

- `PlaneDirection.IsNonzero` exposes `dx ≠ 0 ∨ dy ≠ 0`; it is not an opaque
  ray-validity predicate.
- `PlaneDirection.IsUnit` exposes the equation `d · d = 1`.
- `PlaneDirection.IsSpecularReflection` exposes both unit-normality and the
  full component-determining vector equation.
- `HalfCylindricalMirror.OnReflectingSurface` exposes the SI circle equality
  and the upper-half inequality.
- `SlopeInterceptLine.Contains` exposes the SI point-line incidence equation.
- `SlopeInterceptLine.HasDirection` exposes `dy = slope*dx`.
- `Figure2gRayInteraction` is a data structure, not an opaque `Prop`; its
  substantive physical fields are the explicit equations and inequalities
  listed above.
- `Figure2gCausticSetup` is likewise data carrying an explicit relative-scale
  inequality, direction equality, and two line-incidence equations.
- Countermodel result: all local `Prop`-valued interfaces have mathematical
  elimination content.  Interpreting any one arbitrarily is impossible
  because its definition reduces to the listed equations/inequalities.

## Uncertainty and branch coverage

- **Uncertainty — not applicable.**  The C.1 source has no measured
  `value ± uncertainty` or experimental error.  The `Δθ ≪ θ` relation is a
  neighboring-ray asymptotic-scale condition for later caustic parts, not a
  measurement uncertainty in the requested coefficients.
- **Hit-point quadrant — covered.**  `0 < θ < π/2`, the upper-semicircle
  inequality, and the signed hit-coordinate equations select the Figure 2g
  quadrant.
- **Incoming orientation — covered.**  The incoming vector is exactly
  `(0,1)`.
- **Normal orientation — covered.**  The normal is exactly the outward radial
  vector `(sin θ, cos θ)`.
- **Outgoing branch — covered.**  Strict negative component inequalities
  explicitly record the down-left reflected branch, while the vector law
  determines its magnitude/components.
- **Neighbor-ray orientation — covered.**  `Δθ > 0` selects the
  `θ + Δθ` branch and `incoming_rays_parallel` preserves the common incoming
  orientation.

## Declarations and blueprint labels

- `thm:physics:IPhO_2026_2_C_1:target`:
  `IPhO2026Problems.IPhO2026_2_C_1.rayA_slope_and_intercept`.
- `def:physics:IPhO_2026_2_C_1:aux001`: `PlanePoint`.
- `def:physics:IPhO_2026_2_C_1:aux002`: `PlaneDirection`.
- `def:physics:IPhO_2026_2_C_1:aux003`: `PlaneDirection.dot`.
- `def:physics:IPhO_2026_2_C_1:aux004`: `PlaneDirection.IsNonzero`.
- `def:physics:IPhO_2026_2_C_1:aux005`: `PlaneDirection.IsUnit`.
- `def:physics:IPhO_2026_2_C_1:aux006`:
  `PlaneDirection.reflectedByNormal`.
- `def:physics:IPhO_2026_2_C_1:aux007`:
  `PlaneDirection.IsSpecularReflection`.
- `def:physics:IPhO_2026_2_C_1:aux008`: `HalfCylindricalMirror`.
- `def:physics:IPhO_2026_2_C_1:aux009`:
  `HalfCylindricalMirror.OnReflectingSurface`.
- `def:physics:IPhO_2026_2_C_1:aux010`: `SlopeInterceptLine`.
- `def:physics:IPhO_2026_2_C_1:aux011`:
  `SlopeInterceptLine.Contains`.
- `def:physics:IPhO_2026_2_C_1:aux012`:
  `SlopeInterceptLine.HasDirection`.
- `def:physics:IPhO_2026_2_C_1:aux013`: `OpticalRayAtPoint`.
- `def:physics:IPhO_2026_2_C_1:aux014`: `Figure2gRayInteraction`.
- `def:physics:IPhO_2026_2_C_1:aux015`:
  `Figure2gRayInteraction.mA`.
- `def:physics:IPhO_2026_2_C_1:aux016`:
  `Figure2gRayInteraction.bA`.
- `def:physics:IPhO_2026_2_C_1:aux017`: `Figure2gCausticSetup`.
- `lem:physics:IPhO_2026_2_C_1:aux018`:
  `reflected_direction_from_specular_law`.
- `lem:physics:IPhO_2026_2_C_1:aux019`: `reflected_line_slope`.
- `lem:physics:IPhO_2026_2_C_1:aux020`: `reflected_line_intercept`.
- Supporting declarations required by the iteration-002 redraft but not yet
  assigned separate blueprint labels: `LengthQuantity` and
  `lengthInMetres`.

All indexed declarations are statement-formalized and ready for deterministic
`\leanok` synchronization.  Per prover write permissions, the blueprint
chapter itself was not edited.

## LeanExplore queries and candidates actually used

All searches passed `packages: ["Mathlib", "Physlib"]`.

- Query `Physlib Dimensionful WithDim length quantity SI unit projection to
  real value UnitChoices.SI`: selected `Dimensionful`, `WithDim`,
  `Dimension.L𝓭`, and `UnitChoices.SI`.
- Query `WithDim value field val dimension tagged real scalar`: confirmed
  `WithDim` and its `val : M` projection.
- Query `UnitChoices.SI standard SI unit choice`: selected
  `UnitChoices.SI`; its source documents metres, seconds, kilograms,
  coulombs, and kelvin.
- Query `specular reflection vector d minus two dot d n times n`: inspected
  `EuclideanGeometry.reflection` and `Submodule.reflection` as generic
  affine/subspace reflections, not curved-mirror optical-ray interfaces.
- Query `Physlib optical ray propagation direction mirror specular reflection
  normal`: inspected `Space.Direction`, `EuclideanGeometry.reflection`, and
  `Module.Ray`.  `Space.Direction` provides a unit vector but not the marked
  point, mirror normal, or supporting-line incidence data required by this
  contract.

Source and module metadata were fetched for the selected carriers:

- `Dimensionful` — `Physlib.Units.Basic`.
- `WithDim` — `Physlib.Units.WithDim.Basic`.
- `Dimension.L𝓭` — `Physlib.Units.Dimension`.
- `UnitChoices.SI` — `Physlib.Units.Basic`.
- `Space.Direction` — `Physlib.SpaceAndTime.Space.Module` (near match, not
  used).
- `EuclideanGeometry.reflection` —
  `Mathlib.Geometry.Euclidean.Projection` (near match, not used).

## Physlib/Mathlib names grounded

- Physlib: `Dimensionful`, `WithDim`, `Dimension`, `Dimension.L𝓭`,
  `UnitChoices`, and `UnitChoices.SI`.
- Mathlib: `Real.sin`, `Real.cos`, `Real.cot`, and `Real.pi`.
- The imported Mathlib trigonometric module supplies the later proof route's
  real trigonometric identities and positivity lemmas; this stage records
  theorem contracts rather than closing those four proofs.

## Local abstractions introduced

- `PlanePoint` retains two physically dimensioned coordinates while exposing
  a common named SI projection for analytic geometry.
- `PlaneDirection` retains explicit dimensionless Cartesian components needed
  to state the figure's signed orientations and vector reflection law.
- `HalfCylindricalMirror` retains a positive physical radius and a
  constraining upper-semicircle surface relation.
- `SlopeInterceptLine` distinguishes its dimensionless slope from its
  physical-length intercept.
- `OpticalRayAtPoint` retains a marked physical point, oriented propagation
  direction, and a nonzero-direction condition.
- `PlaneDirection.IsSpecularReflection` is the smallest local optics law that
  exposes the full vector equation needed for derivation; it does not mention
  the target coefficients.
- `Figure2gRayInteraction` connects the figure data, physical law, ray
  orientation, and analytic line without assuming the current answer.
- `Figure2gCausticSetup` retains the neighboring ray and small-angle context
  stated in the source even though C.1 itself only concludes data for ray A.

## Grounding gaps

- Physlib has a generic unit-vector `Space.Direction`, but no searched
  declaration combined an optical propagation direction with a marked hit
  point, a curved-mirror outward normal, and a specular reflected supporting
  line.  The explicit local interface preserves exactly those missing roles.
- Mathlib's `EuclideanGeometry.reflection` reflects points across a fixed
  affine subspace.  It is not directly a direction-reflection law at the
  tangent of a curved mirror, so using it would require a larger geometric
  encoding than the source contract.
- No dedicated half-cylindrical-mirror/specular-optics API was found in the
  searched Mathlib/Physlib surface.
- `archon dag-query` was attempted exactly as instructed, but the executable
  was not available on this lane's `PATH`.  The blueprint declares no
  previous-part theorem dependency, so this did not block the contract.
- The source supplies no numeric interpretation of `Δθ ≪ θ`; the
  formalization therefore retains an explicit relative-scale witness rather
  than inventing a tolerance.

## Redraft requests

- None for the Lean contract.  A later plan/review pass may optionally assign
  separate blueprint labels to the new Physlib-grounded support declarations
  `LengthQuantity` and `lengthInMetres`; their absence from the current index
  does not affect compilation or the target theorem mapping.

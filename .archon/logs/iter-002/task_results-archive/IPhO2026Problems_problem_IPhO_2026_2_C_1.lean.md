# Autoformalization result: IPhO 2026 problem 2 C.1

The assigned file was created and checked with
`lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_1.lean`. It compiles
with exactly four expected `declaration uses sorry` warnings and no errors.

## Assumption/target split

### Governing laws

- `PlaneDirection.IsSpecularReflection` states the unit-normal vector law
  `d_out = d_in - 2 (d_in · n) n`.
- `SlopeInterceptLine.Contains` states the line incidence equation
  `y = m*x + b`.
- `SlopeInterceptLine.HasDirection` states the supporting-direction equation
  `dy = m*dx`.
- `HalfCylindricalMirror.OnReflectingSurface` states the upper-semicircle
  equations `x² + y² = R²` and `0 ≤ y`.

### Previous-part results

- None. The source report has an empty `previous_parts` list, and no sibling
  Lean file is imported.

### Figure/data readouts

- `HalfCylindricalMirror.radius` is a positive length readout in a fixed unit.
- `Figure2gRayInteraction` records `0 < θ < π/2`, the Figure 2g hit point
  `(R sin θ, R cos θ)`, the upward incoming direction `(0,1)`, the outward
  radial normal `(sin θ, cos θ)`, the common hit point of the incident and
  reflected rays, and the reflected supporting line.
- `Figure2gCausticSetup` retains the context named in the source: parallel ray
  B at angle `θ + Δθ`, a positive `Δθ`, a dimensionless relative-smallness
  witness `0 < ε < 1` with `|Δθ| ≤ ε|θ|`, the reflected line of B, and the
  intersection sample used for the later caustic construction.
- Points have length-valued coordinate readouts; propagation directions and
  slopes are dimensionless; line intercepts have the same length unit as the
  mirror radius.

### Current target conclusions

- `m_A = Real.cot (2 * θ)`.
- `b_A = R / (2 * Real.cos θ)`.

These occur only as conclusions of `reflected_line_slope`,
`reflected_line_intercept`, and the main theorem.

## Goal-faithfulness audit

- No premise field states either requested coefficient formula.
- `Figure2gRayInteraction.mA` and `.bA` are only names for the two projections
  of an otherwise arbitrary `SlopeInterceptLine`; unfolding them does not
  produce either answer.
- The reflected line is constrained only by the generic incidence and
  direction equations, while its outgoing direction is constrained only by
  the generic specular-reflection vector law.
- The doubled-angle outgoing vector is a helper theorem conclusion, not a law
  field or setup hypothesis.
- Ray B and the caustic intersection add source context but do not constrain
  ray A's coefficients to their requested closed forms.
- Countermodel sanity check: if the reflection-law field is dropped, the
  outgoing direction and hence slope can vary; if line incidence is dropped,
  the intercept can vary; if line-direction compatibility is dropped, the
  slope can vary. All three independent carriers are present.

## Derivability and bridge obligations

1. **Mirror hit geometry — covered.**
   Source claim: the radial hit point in Figure 2g is
   `(R sin θ, R cos θ)`. Carrier:
   `Figure2gRayInteraction.hit_point_from_figure`, reinforced by
   `hit_on_reflecting_surface`. Evidence: direct inspection of official Figure
   2g and the Cartesian labels `-R`, `R`, `x`, and `y`.

2. **Incident orientation and surface normal — covered.**
   Source claim: ray A travels vertically upward and the normal is the
   origin-to-hit radial direction. Carriers:
   `incoming_vertical_up` and `normal_radial_outward`. These equations fix
   signed components, rather than merely asserting unoriented parallelism.

3. **Law of reflection — covered.**
   Source claim: specular reflection reverses the normal component and
   preserves the tangent component. Carrier:
   `PlaneDirection.IsSpecularReflection`, whose elimination data are
   `normal.IsUnit` and
   `outgoing = incoming - 2 (incoming · normal) normal`.

4. **Doubled-angle outgoing direction — covered.**
   Carrier:
   `IPhO2026Problems.IPhO2026_2_C_1.reflected_direction_from_specular_law`.
   The reflection equation gives
   `(-2 sin θ cos θ, 1 - 2 cos² θ)`;
   Mathlib `Real.sin_two_mul` and `Real.cos_two_mul` turn this into the
   down-left vector `(-sin(2θ), -cos(2θ))`.

5. **Nonvertical reflected line — covered.**
   From `0 < θ < π/2`, one has `0 < 2θ < π`, so
   `Real.sin_pos_of_mem_Ioo` makes the outgoing x-component nonzero. This is
   the denominator/uniqueness bridge needed to solve `dy = m*dx` for `m`.

6. **Slope computation — covered.**
   Carrier:
   `IPhO2026Problems.IPhO2026_2_C_1.reflected_line_slope`.
   It combines the outgoing direction with
   `reflected_line_has_ray_direction`; Mathlib
   `Real.cot_eq_cos_div_sin` identifies the resulting quotient as
   `cot(2θ)`.

7. **Intercept computation — covered.**
   Carrier:
   `IPhO2026Problems.IPhO2026_2_C_1.reflected_line_intercept`.
   Substitution of the hit point and slope into
   `hit_on_reflected_line` gives
   `b = R cos θ - R sin θ cot(2θ)`. Double-angle identities and
   `Real.sin_sq_add_cos_sq` reduce this to `R/(2 cos θ)`.
   `Real.cos_pos_of_mem_Ioo` and the angle bounds provide the required
   nonzero denominator.

8. **Complete source-to-contract mapping — covered.**
   Carrier:
   `IPhO2026Problems.IPhO2026_2_C_1.rayA_slope_and_intercept`, whose
   conclusion is exactly the recorded two-coefficient answer.

No substantive statement-layer bridge is blocked. The four theorem bodies are
intentionally `sorry` at the autoformalization stage.

## Abstraction sufficiency and countermodel audit

- `PlaneDirection.IsNonzero` exposes the component disjunction
  `dx ≠ 0 ∨ dy ≠ 0`; an `OpticalRayAtPoint` cannot carry an arbitrary zero
  propagation direction.
- `PlaneDirection.IsUnit` exposes the equation `d · d = 1`.
- `PlaneDirection.IsSpecularReflection` exposes both the unit-normal equation
  and the full component-determining vector reflection equation. It is not an
  opaque witness-only relation.
- `HalfCylindricalMirror.OnReflectingSurface` exposes the circle equation and
  the upper-half inequality.
- `SlopeInterceptLine.Contains` exposes the point-line incidence equation.
- `SlopeInterceptLine.HasDirection` exposes `dy = m*dx`, which determines the
  slope once the x-component is shown nonzero.
- The relative-smallness assertion is the explicit inequality
  `|Δθ| ≤ ε|θ|` together with `0 < ε < 1`; the contract does not assign an
  arbitrary truth value to an opaque “much smaller” predicate.
- `Figure2gRayInteraction` and `Figure2gCausticSetup` are data structures with
  the constraining equations and inequalities above as fields. Removing any
  of the reflection, direction, or incidence carriers admits a countermodel
  with a false current conclusion; retaining them forces both coefficients.

## Uncertainty and branch coverage

- **Uncertainty: not applicable.** The source contains no measured
  `value ± uncertainty`, tolerance, or experimental error. The `Δθ ≪ θ`
  condition is an approximation-scale condition for later parts, not a
  measurement uncertainty for C.1.
- **Hit-point quadrant: covered.** `0 < θ < π/2` selects the upper-right
  mirror point shown in Figure 2g.
- **Incoming orientation: covered.** The incident propagation vector is
  exactly `(0,1)`, not an unoriented vertical line.
- **Normal orientation: covered.** The normal is the outward radial vector
  `(sin θ, cos θ)`.
- **Outgoing reflection branch: covered.** The vector reflection equation,
  rather than an equality of unsigned angles alone, selects the outgoing
  down-left branch `(-sin(2θ), -cos(2θ))`.
- **Neighbor branch: covered.** The source's `θ + Δθ` branch is represented
  with `Δθ > 0`; ray B is explicitly parallel to ray A.

## Declarations and blueprint labels

- Blueprint label `thm:physics:IPhO_2026_2_C_1:target` maps to
  `IPhO2026Problems.IPhO2026_2_C_1.rayA_slope_and_intercept`.
- Supporting bridge declarations:
  `reflected_direction_from_specular_law`, `reflected_line_slope`, and
  `reflected_line_intercept` in the same namespace.
- Supporting model declarations:
  `PlanePoint`, `PlaneDirection`, `PlaneDirection.dot`,
  `PlaneDirection.IsNonzero`, `PlaneDirection.IsUnit`,
  `PlaneDirection.reflectedByNormal`,
  `PlaneDirection.IsSpecularReflection`, `HalfCylindricalMirror`,
  `HalfCylindricalMirror.OnReflectingSurface`, `SlopeInterceptLine`,
  `SlopeInterceptLine.Contains`, `SlopeInterceptLine.HasDirection`,
  `OpticalRayAtPoint`, `Figure2gRayInteraction`, and
  `Figure2gCausticSetup`.
- The target is ready for statement-level `\leanok`. Per prover permissions
  and `.archon/AGENTS.md`, the blueprint was not edited; the deterministic
  synchronization/review step should associate
  `\lean{IPhO2026Problems.IPhO2026_2_C_1.rayA_slope_and_intercept}` with the
  target environment.

## LeanExplore queries/candidates actually used

- Query `Real.cotangent cot`: used `Real.cot`; inspected
  `Real.tan_inv_eq_cot`.
- Query `Real.cot_eq_cos_div_sin`: used
  `Real.cot_eq_cos_div_sin`.
- Queries `Real.sin_two_mul double angle` and
  `Real.cos_two_mul double angle`: used `Real.sin_two_mul` and
  `Real.cos_two_mul`.
- Query `Real.sin_sq_add_cos_sq`: used
  `Real.sin_sq_add_cos_sq`.
- Query `sine positive between zero and pi`: used
  `Real.sin_pos_of_mem_Ioo`.
- Query `Real.cos positive between negative pi over two and pi over two`:
  used `Real.cos_pos_of_mem_Ioo`.
- Query `law of specular reflection ray mirror normal optics`: inspected
  `Module.Ray` and `EuclideanGeometry.reflection` as near matches.
- Query `reflection of a vector across a line Euclidean space`: inspected
  `Submodule.reflection` and `EuclideanGeometry.reflection`.
- Query `EuclideanSpace coordinate point Fin 2`: inspected
  `EuclideanSpace`; the local two-field coordinate structures better retain
  the distinct length-point and dimensionless-direction roles of this
  figure-derived contract.

All searches used package filters `["Mathlib", "Physlib"]`.

## PhysLean/Mathlib names grounded

- Mathlib: `Real.sin`, `Real.cos`, `Real.cot`, `Real.pi`,
  `Real.cot_eq_cos_div_sin`, `Real.sin_two_mul`, `Real.cos_two_mul`,
  `Real.sin_sq_add_cos_sq`, `Real.sin_pos_of_mem_Ioo`, and
  `Real.cos_pos_of_mem_Ioo`.
- The used trigonometric declarations were source-checked in
  `Mathlib.Analysis.Complex.Trigonometric` or
  `Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic`.
- No PhysLean optics declaration was used; no matching ray/mirror
  specular-reflection interface was found.

## Local abstractions introduced

- `PlanePoint` and `PlaneDirection` distinguish length-valued coordinate
  readouts from dimensionless propagation components instead of collapsing a
  physical primitive to a scalar alias.
- `HalfCylindricalMirror` retains a positive length-valued radius and its
  upper-semicircle surface equation.
- `OpticalRayAtPoint` retains a point, oriented propagation direction, and
  nonzero-direction condition.
- `SlopeInterceptLine` retains the dimensionless slope and length-valued
  intercept demanded by the Figure 2g coordinate convention.
- `IsSpecularReflection` is a faithful local governing law with an explicit
  vector equation. It does not mention either target coefficient.
- `Figure2gCausticSetup` retains ray B, `Δθ`, parallelism, and the neighboring
  intersection so the stated broader setup is not discarded merely because
  C.1's closed form does not use it.

## Grounding gaps

- `Module.Ray` is an equivalence class of nonzero module vectors under
  positive scaling; it does not retain a hit point, a mirror normal, or a
  reflected supporting line, so it is not a complete optical-ray carrier here.
- `EuclideanGeometry.reflection` reflects points in affine subspaces. The
  problem needs a propagation-direction reflection at the tangent plane of a
  curved mirror, so the direct component law is the faithful smaller
  interface.
- No dedicated specular-optics or half-cylindrical-mirror API was found in the
  searched Mathlib/Physlib surface or by local PhysLean source search.
- The source gives only the qualitative notation `Δθ ≪ θ`; the formalization
  therefore exposes a relative-scale witness `ε` rather than inventing a
  numerical tolerance.
- `archon dag-query` was unavailable on this lane's `PATH`. The source has no
  previous-part dependencies, so no sibling import or hidden dependency was
  introduced.

## Redraft requests

- The blueprint target environment currently has no `\lean{...}` declaration
  association. The synchronization/review step should attach the main theorem
  name above; no change to the informal physics statement is requested.

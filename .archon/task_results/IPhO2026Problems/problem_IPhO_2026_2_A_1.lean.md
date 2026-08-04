# Physics formalization result: `problem_IPhO_2026_2_A_1.lean`

## Outcome

Completed the iteration-002 typed-physics redraft.  The assigned file compiles
with four expected `sorry` warnings, one for each proof obligation, and no
errors.  The mirror radius, ray transverse coordinate, threshold, impact
coordinates, and diameter now use Physlib length quantities.  All analytic
coordinate formulae use the single named SI projection `siLengthValue`.

The blueprint was not edited because the prover write domain excludes blueprint
chapters.  All indexed declaration environments are ready for deterministic
`\leanok` synchronization as statement formalizations; the four proof
environments remain incomplete.

## Assumption/target split

### Governing laws

- `ObeysSpecularReflection experiment` states equality of incidence and
  reflection angles at every actual impact.
- `HalfCylinderReflectionLaws.limiting_ray_geometry` explicitly takes the
  equal-angle law and produces a positive limiting-ray witness, its circular
  projection equation, and its repeated-reflection angular closure.
- `HalfCircleProjectionGeometry.coordinate_eq_radius_mul_cos` states the
  dimensionally valid SI projection
  `xN_SI = R_SI * cos θ`.
- `RepeatedReflectionClosure.angle_closure` states
  `(2 * N + 1) * θ = π`.
- The experiment carrier records aperture coverage, positive reflection
  counts, and reflection-count symmetry under reversal of the signed
  transverse SI coordinate.

### Previous-part results

- None.  Part A.1 is modeled independently.

### Figure/data readouts

- `SourceFigure` distinguishes Figures 2c, 2d, and 2e.
- `HalfCylindricalMirror.source_panel_from_figure` identifies the apparatus
  with Figure 2c.
- The experiment fields identify the cross-section with Figure 2d and the
  reflection-count panel with Figure 2e.
- `incoming_direction_from_figure` fixes the incident axial direction as
  positive `y`.
- `OnReflectingSemicircle` gives the upper-circle equation in SI coordinates.
- `LimitingRayWitness` records the first impact point, positive branch,
  exact reflection count, and acute first-impact polar angle.

### Current target conclusions

- `positive_reflection_threshold_formula` concludes
  `xN_SI = R_SI * sin ((2N - 1)π / (4N + 2))`.
- The same theorem also concludes
  `xN_SI = R_SI * cos (π / (2N + 1))`.

## Goal-faithfulness audit

Neither official closed form occurs in `MultipleReflectionExperiment`,
`IsPositiveReflectionThreshold`, `LimitingRayWitness`, or
`HalfCylinderReflectionLaws`.  The threshold predicate contains only the
source meaning of a threshold: positivity, aperture membership, attainment by
an incident ray with at most `N` reflections, and maximality among all such
rays.  The laws expose only the intermediate physical relations
`xN_SI = R_SI * cos θ` and `(2N+1)θ = π`; solving for `θ` and substituting it
remain proof obligations.  No helper definition unfolds to either requested
formula.

## Derivability and bridge obligations

- **Typed length interpretation — covered.**  Source claim: `R`, incident
  coordinates, and `xN` are lengths.  Carrier:
  `LengthQuantity = Dimensionful (WithDim Dimension.L𝓭 ℝ)` and
  `siLengthValue`.  Evidence: grounded Physlib declarations
  `Dimensionful`, `WithDim`, `Dimension.L𝓭`, and `UnitChoices.SI`.
- **Figure-to-model geometry — covered.**  Source claim: Figures 2c--2e
  describe the mirror, semicircular cross-section, and count plot.  Carriers:
  `SourceFigure`, panel equality fields, `OnReflectingSemicircle`, and the
  first-impact fields of `LimitingRayWitness`.  This bridge is encoded
  locally by exact equations and equalities.
- **Threshold semantics — covered.**  Source claim: `xN` is the largest
  positive transverse coordinate with at most `N` reflections.  Carrier:
  `IsPositiveReflectionThreshold`; its existential clause supplies
  attainment and its universal inequality supplies maximality.
- **Equal-angle law at impacts — covered.**  Source claim: incidence angle
  equals reflection angle.  Carrier: `ObeysSpecularReflection`, an equality
  at every impact below the ray's reflection count.
- **Repeated equal-angle reflection to limiting geometry — covered.**  Source
  claim: applying specular reflection in the semicircle yields the limiting
  projection and angular closure.  Carrier:
  `HalfCylinderReflectionLaws.limiting_ray_geometry`, whose input explicitly
  includes `ObeysSpecularReflection` and whose output supplies both constraining
  structures.
- **Closure to unique angle — covered.**  Source claim:
  `(2N+1)θ = π` implies `θ = π/(2N+1)`.  Carrier:
  `limiting_first_impact_angle`; `hN` makes the divisor nonzero.  Its proof is
  intentionally a `sorry` in this autoformalization stage.
- **Projection substitution — covered.**  Source claim: the limiting
  transverse coordinate is `R cos θ`.  Carrier:
  `HalfCircleProjectionGeometry.coordinate_eq_radius_mul_cos`, combined by the
  main theorem contract with `limiting_first_impact_angle`.
- **Complementary official angles — covered.**  Source claim:
  `π/2 - π/(2N+1) = (2N-1)π/(4N+2)`.  Carrier:
  `official_answer_angles_complementary`; proof remains a `sorry`.
- **Sine/cosine conversion — covered.**  Source claim: the two official
  trigonometric forms agree.  Carriers:
  `official_sine_cosine_forms_agree` and grounded Mathlib theorem
  `Real.sin_pi_div_two_sub`; proof remains a `sorry`.
- **Final source-to-contract mapping — covered.**  Carrier:
  `positive_reflection_threshold_formula`, which assumes the physical
  threshold and governing laws and concludes exactly the two requested SI
  readout equalities; proof remains a `sorry`.

## Abstraction sufficiency and countermodel audit

- `OnReflectingSemicircle` is constrained by the circle equation and the
  upper-half-plane inequality.
- `MultipleReflectionExperiment.isParallelIncident` is not an unconstrained
  witness predicate: its uses are coupled to aperture bounds, existence of a
  ray at every aperture coordinate, positive counts, count symmetry, and the
  impact-wise specular law.
- `ObeysSpecularReflection` exposes the usable equality between reflected and
  incident angles at each actual impact.
- `IsPositiveReflectionThreshold` exposes positivity, strict aperture
  inclusion, an attaining ray, and a universal maximality inequality.
- `HalfCircleProjectionGeometry` exposes the usable `R cos θ` equation.
- `RepeatedReflectionClosure` exposes the usable `(2N+1)θ = π` equation.
- `HalfCylinderReflectionLaws` exposes an elimination bridge from the
  equal-angle law and threshold assumptions to a limiting witness satisfying
  both equations.  Thus an arbitrary interpretation satisfying the interface
  cannot keep all assumptions true while freely falsifying the main formula;
  it must satisfy the two equations from which the formula is derived.

## Uncertainty and branch coverage

- **Uncertainty: not applicable.**  The source gives no measured value with
  an uncertainty or error bar.
- **Branch/orientation: covered.**  Incoming rays point toward positive `y`;
  `xN` is positive; the limiting ray has transverse coordinate exactly `xN`;
  its first-impact angle is positive and acute; its count is exactly `N`; and
  the closure retains the signed factor `2N+1`.  These hypotheses select the
  official positive limiting branch before the conclusion.

## Declarations and blueprint labels

- `SourceFigure` — `def:physics:IPhO_2026_2_A_1:aux001`
- `AxialDirection` — `def:physics:IPhO_2026_2_A_1:aux002`
- `HalfCylindricalMirror` — `def:physics:IPhO_2026_2_A_1:aux003`
- `HalfCylindricalMirror.diameter` —
  `def:physics:IPhO_2026_2_A_1:aux004`
- `OnReflectingSemicircle` — `def:physics:IPhO_2026_2_A_1:aux005`
- `MultipleReflectionExperiment` — `def:physics:IPhO_2026_2_A_1:aux006`
- `ObeysSpecularReflection` — `def:physics:IPhO_2026_2_A_1:aux007`
- `IsPositiveReflectionThreshold` — `def:physics:IPhO_2026_2_A_1:aux008`
- `LimitingRayWitness` — `def:physics:IPhO_2026_2_A_1:aux009`
- `HalfCircleProjectionGeometry` — `def:physics:IPhO_2026_2_A_1:aux010`
- `RepeatedReflectionClosure` — `def:physics:IPhO_2026_2_A_1:aux011`
- `HalfCylinderReflectionLaws` — `def:physics:IPhO_2026_2_A_1:aux012`
- `limiting_first_impact_angle` — `lem:physics:IPhO_2026_2_A_1:aux013`
- `official_answer_angles_complementary` —
  `lem:physics:IPhO_2026_2_A_1:aux014`
- `official_sine_cosine_forms_agree` —
  `lem:physics:IPhO_2026_2_A_1:aux015`
- `positive_reflection_threshold_formula` —
  `thm:physics:IPhO_2026_2_A_1:target`
- Unindexed helpers: `LengthQuantity` and `siLengthValue`.

## LeanExplore queries and candidates actually used

All searches used package filters `["Mathlib", "Physlib"]`.

- `physical quantity dimension length SI unit scalar projection`
- `MeasurementSystem SI length quantity Physlib`
- `dimensional analysis length unit radius`
- `Dimensionful toDimensionful apply unit choices convert quantity to SI scalar`
- `Dimensionful quantity evaluate in chosen units`
- `WithDim value projection Dimensionful`
- `Physlib Units Basic import Dimensionful WithDim`
- `Real.sin_pi_div_two_sub`
- `specular reflection equal angle law ray mirror geometric optics`
- `circular mirror multiple reflections limiting ray`
- `Space.Direction axial ray orientation`

Grounded candidates used in the formalization or its intended proof route:
`Dimension`, `Dimension.L𝓭`, `Dimensionful`,
`instCoeFunDimensionfulForallUnitChoices`, `WithDim`, `UnitChoices.SI`,
`instMulActionNNRealDimensionful`, `UnitExamples.meters400` (the reference
construction/readout pattern), and `Real.sin_pi_div_two_sub`.
`CarriesDimension.toDimensionful` and
`CarriesDimension.toDimensionful_apply_apply` were inspected to confirm the SI
evaluation semantics, although no new quantity constructor was needed.

## Local abstractions and grounding gaps

- No matching Physlib geometric-optics API was found for specular reflection,
  sequential impacts in a half-cylinder, a reflection-count threshold, or the
  limiting-ray closure.  The nearest Mathlib results concern affine
  reflections and general Euclidean angles, not the optical impact law.
  Therefore `ObeysSpecularReflection`, the threshold predicate, limiting
  witness, projection structure, closure structure, and governing-law
  interface are faithful local abstractions with explicit equations or
  elimination consequences.
- `Space.Direction` was a near match for a physical direction, but it does not
  directly encode the two signed axial orientations of the problem's fixed
  Figure-2d frame.  The local `AxialDirection` inductive preserves exactly
  that branch information.
- There are no blocked grounding obligations.

## Verification

- Archon Lean LSP diagnostics: success; no errors and exactly four expected
  `declaration uses sorry` warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`: exit code 0
  with the same four expected warnings.

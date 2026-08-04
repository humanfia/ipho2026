# IPhO2026Problems/problem_IPhO_2026_2_A_1.lean

## Assumption/target split

### Governing laws

- `HalfCylindricalMirror.radius_pos` states that the mirror radius is positive.
- `MultipleReflectionExperiment` supplies abstract physical rays, their
  transverse-coordinate readouts, natural-valued reflection counts, per-impact
  angle readouts, existence of a ray at every coordinate in the aperture, and
  positivity/symmetry of the reflection count.
- `ObeysSpecularReflection` is the local equal-incidence/equal-reflection-angle
  law at each actual mirror impact.
- `HalfCylinderReflectionLaws.limiting_ray_geometry` is the elimination
  principle for applying that law to the limiting ray in a semicircle. It
  produces a physical limiting-ray witness, the circle-projection equation
  `xN = R * cos θ`, and the repeated-reflection closure
  `(2 * N + 1) * θ = π`.

### Previous-part results

- None. The source report records `previous_parts: []`, and this file imports no
  sibling IPhO problem module.

### Figure/data readouts

- Figure 2c: `HalfCylindricalMirror.diameter = 2 * radius`.
- Figure 2d: `OnReflectingSemicircle` is the upper circle
  `p.x^2 + p.y^2 = R^2`, `p.y ≥ 0`; the optical axis is the `y`-axis;
  incident rays point toward positive `y`; admissible transverse readouts
  satisfy `|x| < R`.
- Figure 2e: reflection counts are positive natural numbers, are symmetric
  under `x ↦ -x`, and `IsPositiveReflectionThreshold experiment N xN`
  states that an eligible incident ray exists at positive `xN` and every
  eligible ray with at most `N` reflections has distance at most `xN`.
- `LimitingRayWitness` records the positive branch, exactly `N` reflections,
  and the acute first-impact polar angle. The angle is deliberately not called
  an incidence angle: for `N = 1`, the polar angle is `π/3`, while the angle
  relative to the normal is different.
- Lengths are real scalar readouts in one common, unspecified length unit;
  angles are dimensionless real readouts in radians; counts are naturals.

### Current target conclusions

- `positive_reflection_threshold_formula` concludes
  `xN = R * sin ((2N - 1)π / (4N + 2))`.
- The same theorem also concludes
  `xN = R * cos (π / (2N + 1))`.

## Goal-faithfulness audit

Neither official closed form occurs in `IsPositiveReflectionThreshold`,
`MultipleReflectionExperiment`, or any governing-law premise. The threshold is
defined extensionally as a genuine positive maximum over physical incident
rays, not by either answer expression.

The strongest premise, `HalfCylinderReflectionLaws`, stops at two
source-geometric intermediate equations involving an existential polar angle:
circle projection `xN = R cos θ` and angular closure `(2N + 1)θ = π`. It does
not select `θ = π/(2N+1)` by definition and does not mention the sine answer.
Solving the closure equation and converting the complementary angles remain
explicit theorem/lemma obligations. No local definition unfolds to the current
target, and no target conclusion appears as a premise field.

## Derivability and bridge obligations

1. **Canonical half-cylinder to planar reflecting boundary — covered.**
   Source claim: Figures 2c--2d reduce the mirror to an upper semicircle of
   radius `R`. Lean carrier: `HalfCylindricalMirror`,
   `HalfCylindricalMirror.diameter`, and `OnReflectingSemicircle`. Evidence:
   the official page labels the diameter `2R` and the cross-section endpoints
   `-R`, `R`.

2. **Parallel-source setup and aperture — covered.** Source claim: distant
   source rays are parallel to the optical axis and have `x ∈ (-R,R)`. Lean
   carrier: `MultipleReflectionExperiment.incomingDirection`,
   `incoming_direction_from_figure`, `incident_coordinate_in_aperture`, and
   `incident_ray_at_coordinate`. This is encoded locally from Figures 2d and
   the source-page prose.

3. **Figure 2e threshold semantics — covered.** Source claim: `xN` is the
   maximum distance permitting at most `N` reflections. Lean carrier:
   `IsPositiveReflectionThreshold`, whose witness clause establishes
   attainability and whose universal clause establishes maximality. The
   experiment's symmetry field carries the negative branch without redefining
   the requested positive threshold.

4. **Specular equal-angle law — covered.** Source claim: mirror impacts obey
   specular reflection. Lean carrier: `ObeysSpecularReflection`, an equation
   between per-impact incidence and reflection angles. It is a grounded local
   physics interface; no matching optical-ray API was found in the searched
   libraries.

5. **Repeated circular reflections to limiting angular closure — covered as an
   explicit governing-law bridge.** Source claim: the limiting positive ray
   undergoing `N` reflections has first-impact polar angle `θ` with
   `(2N+1)θ = π`. Lean carriers:
   `HalfCylinderReflectionLaws.limiting_ray_geometry`,
   `LimitingRayWitness`, and `RepeatedReflectionClosure.angle_closure`.
   Evidence is the equal-angle circular geometry of Figures 2c--2e and the
   limiting endpoint branch. This bridge is encoded locally because no
   PhysLean/Mathlib geometric-optics development was located.

6. **Circle projection — covered.** Source claim: the limiting ray's
   transverse coordinate is the horizontal projection of a radius. Lean
   carrier:
   `HalfCircleProjectionGeometry.coordinate_eq_radius_mul_cos`.

7. **Closure equation to explicit polar angle — covered by a named proof
   obligation.** Lean carrier: `limiting_first_impact_angle`. The coefficient
   is nonzero (indeed positive) for `hN : 0 < N`; the lemma is intentionally a
   `sorry` body at the autoformalize stage.

8. **Official angles are complementary — covered by a named proof
   obligation.** Lean carrier: `official_answer_angles_complementary`.
   This is real-field algebra using `hN` to discharge denominator
   nonvanishing.

9. **Sine/cosine conversion — covered.** Lean carrier:
   `official_sine_cosine_forms_agree`; Mathlib evidence:
   `Real.sin_pi_div_two_sub (x) :
   sin (π / 2 - x) = cos x`.

10. **All source assumptions to both requested forms — covered by the main
    contract.** Lean carrier: `positive_reflection_threshold_formula`, which
    consumes the physical threshold and governing-law interface and concludes
    both official equalities.

All `covered` entries mean the mathematical carrier is present and constraining.
The four lemma/theorem bodies remain `sorry` exactly as required in the
autoformalize stage.

## Abstraction sufficiency and countermodel audit

- `OnReflectingSemicircle` is a transparent `Prop` exposing the circle equation
  and upper-half-plane inequality.
- `MultipleReflectionExperiment.isParallelIncident` is constrained by
  `incident_coordinate_in_aperture`, `incident_ray_at_coordinate`,
  `reflection_count_positive`, and `reflection_count_symmetric`; it cannot be
  used merely as an unconstrained opaque tag.
- `ObeysSpecularReflection` transparently exposes an equality at every indexed
  impact below the ray's reflection count.
- `IsPositiveReflectionThreshold` exposes strict positivity, the aperture
  inequality, an attaining ray, and the universal maximal-distance inequality.
- `HalfCircleProjectionGeometry` exposes
  `xN = R * cos firstImpactPolarAngle`.
- `RepeatedReflectionClosure` exposes
  `(2 * (N : ℝ) + 1) * firstImpactPolarAngle = π`.
- `HalfCylinderReflectionLaws` exposes both the local specular equation and a
  reusable existential eliminator yielding the projection and closure
  equations for every positive `N` threshold.

Countermodel check: after assuming `laws`, `hN`, and `hThreshold`, the eliminator
must produce a limiting angle satisfying both equations. Since
`2 * (N : ℝ) + 1` is nonzero, the closure forces
`θ = π/(2N+1)`; the projection then forces the cosine result, and Mathlib's
complementary-angle identity forces the sine result. Thus the local interfaces
cannot all be interpreted arbitrarily while keeping the assumptions true and
the current conclusion false.

## Uncertainty and branch coverage

- **Uncertainty: genuinely not applicable.** The source gives a symbolic exact
  expression, no `value ± uncertainty`, and the report's unit field is null.
- **Units/dimensions: covered.** Radius, diameter, and transverse coordinate are
  consistently identified as same-unit length readouts; angles are radians;
  counts are dimensionless naturals.
- **Branch/orientation: covered.** The incoming direction is positive `y`; the
  target threshold is strictly positive; the limiting witness is explicitly on
  the positive-`x` branch; its polar angle is positive and acute; the experiment
  records reflection-count symmetry under `x ↦ -x`; and the closure retains
  the endpoint factor `2N+1`.

## Declarations and blueprint correspondence

All declarations below support
`thm:physics:IPhO_2026_2_A_1:target`.

- Physical/data declarations: `SourceFigure`, `AxialDirection`,
  `HalfCylindricalMirror`, `HalfCylindricalMirror.diameter`,
  `OnReflectingSemicircle`, `MultipleReflectionExperiment`.
- Law/threshold declarations: `ObeysSpecularReflection`,
  `IsPositiveReflectionThreshold`, `LimitingRayWitness`,
  `HalfCircleProjectionGeometry`, `RepeatedReflectionClosure`,
  `HalfCylinderReflectionLaws`.
- Bridge obligations: `limiting_first_impact_angle`,
  `official_answer_angles_complementary`,
  `official_sine_cosine_forms_agree`.
- Main target: `positive_reflection_threshold_formula`.

The blueprint currently has only a generic autoformalization theorem and no
`\lean{...}` declaration name. The review/planning pass should associate the
main environment with
`\lean{IPhO2026Problem2A1.positive_reflection_threshold_formula}` and add
blueprint entries for the helper declarations if one-to-one correspondence is
required. The statement is ready for statement-level `\leanok` synchronization;
the proof is not `\leanok` because it intentionally contains `sorry`. Per prover
permissions, this lane did not edit the blueprint.

## LeanExplore queries and candidates

Queries were run with `packages: ["Mathlib", "Physlib"]`:

- `specular reflection law circular mirror equal angles`
- `geometric optics light ray mirror reflection`
- `Real.cos_eq_sin_add trigonometric cosine sine complementary angle`
- `Real.sin_pi_div_two_sub cosine`
- `absolute value real number abs`
- `Real.pi_pos positivity of pi`
- `Nat.cast positive denominator two times natural plus one`

Candidate actually used as a bridge carrier:

- `Real.sin_pi_div_two_sub`, source fetched as
  `theorem sin_pi_div_two_sub (x : ℝ) :
  sin (π / 2 - x) = cos x`, from
  `Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic`.

Candidates inspected but rejected or unnecessary:

- `Real.cos_pi_div_two_sub` is the reverse complementary identity and is
  available from the same module, but `Real.sin_pi_div_two_sub` matches the
  official sine-to-cosine direction directly.
- `EuclideanGeometry.reflection` and
  `EuclideanGeometry.reflection_apply` concern reflection in affine subspaces,
  not a physical ray reflecting repeatedly from a curved circular boundary.
- `RayVector`, `SameRay`, and `Module.Ray` are mathematical ray-direction
  notions, but do not supply mirror impacts, reflection counts, or specular
  optics.
- `Real.norm_eq_abs` confirms the standard real absolute-value infrastructure;
  the contract uses ordinary `|x|` notation directly.
- `Nat.cast_add_one_pos` is a possible future denominator-positivity helper but
  was not required to elaborate the by-`sorry` statements.

## PhysLean/Mathlib grounding

- Grounded Mathlib objects used in the contract:
  `ℝ`, `ℕ`, real absolute value, `Real.pi`, `Real.sin`, and `Real.cos`.
- Grounded Mathlib theorem designated for the trigonometric bridge:
  `Real.sin_pi_div_two_sub`.
- No PhysLean declaration for physical light rays, specular reflection at a
  curved mirror, or repeated-reflection counts was found. The preflight
  grounding log's `semiformal_result` is metaprogramming infrastructure and
  does not model this experiment.

## Local abstractions introduced

- `HalfCylindricalMirror` keeps the mirror as a physical/geometric object with a
  positive length parameter; it is not an alias for `ℝ`.
- `MultipleReflectionExperiment` keeps rays abstract and exposes only the
  scalar measurements and physical constraints needed by this subquestion.
- The threshold, projection, closure, and reflection-law interfaces expose
  equations/inequalities and eliminators, preserving proof-relevant physical
  meaning without inventing a nonexistent optics API.
- `SourceFigure` preserves the explicit 2c/2d/2e figure labels in the Lean
  vocabulary.

## Grounding gaps and redraft requests

- **Optics API gap:** no ready-made PhysLean/Mathlib carrier was found for
  curved-mirror specular ray tracing with an impact count. The faithful local
  interfaces above are used instead.
- **Dependency navigation gap:** the prompt advertised `archon dag-query`, but
  `archon` was not on `PATH` in this lane. The blueprint shows no dependency
  annotations or previous parts, so this caused no sibling dependency to be
  introduced.
- **Lake target-registration gap:** the project registers only the
  `IPhO2026Run` library, so
  `lake build IPhO2026Problems.problem_IPhO_2026_2_A_1` reports an unknown
  target. Direct verification with
  `lake env lean IPhO2026Problems/problem_IPhO_2026_2_A_1.lean` succeeds with
  exactly four expected `sorry` warnings and no errors.
- **Blueprint redraft request:** the chapter records the answer but not the
  informal equal-angle derivation of `(2N+1)θ = π`. A later planning/review pass
  should flesh out that geometric bridge and add the Lean declaration links.


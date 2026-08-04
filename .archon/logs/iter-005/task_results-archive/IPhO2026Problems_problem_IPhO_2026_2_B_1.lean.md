# IPhO 2026 Problem 2 B.1 — iteration 004 result

## Assumption/target split

### Governing laws

- `SolarCookerSetup` carries the dimension-tagged mirror radius `R`, container
  radius `a`, their positivity, the parallel cylinder axes, the oriented
  orthonormal cross-section axes, uniform axial sunlight, the Figure 2f center
  displacement `R / 2`, and the contextual no-mirror power `P₀`.
- `SolarOpticsModel` carries full absorption, at-most-one-reflection behavior,
  parallel incident rays, canonical incidence points and normals, the vector
  specular-reflection law, the incidence-angle range, and forward
  container-hit geometry.
- `MaximalRayTangencyLaw model` states that an attained maximum reflected ray
  striking the convex container is a forward limiting tangent ray.

### Previous-part and already-formalized bridge results

- No result from a different problem part is assumed.
- The same-file closed lemmas
  `maximum_incidence_ray_is_tangent`,
  `limiting_tangent_radius_eq_signedDistance`,
  `maximum_ray_containerRadius_eq_limitingRadius`, and
  `limitingRadiusMeters_eq_trigFormula` carry the derivation from the
  maximum-ray model to the trigonometric radius formula.

### Figure/data readouts

- `setup.mirrorRadius : Length` is `R` and
  `setup.containerRadius : Length` is `a`; their scalar coordinate readouts are
  in metres.
- `thetaMax : ℝ` is an angle readout in radians.
  `thetaMax_is_maximum` says it is attained and bounds all reflected rays that
  strike the container.
- The separation `R / 2`, axis orientation, incoming direction, forward-ray
  condition, and signed side of the tangent are explicit setup/model fields.
- `P₀` and uniform positive irradiance are preserved in the setup because they
  belong to the source configuration, although B.1's coefficient calculation
  does not use power.

### Current target conclusions

- There exist `alpha beta : Length`.
- They satisfy the actual geometry-derived equation
  `a = alpha * sin thetaMax + beta * sin (2 * thetaMax)` at the attained
  maximum ray.
- `alpha = R` and `beta = scaledLength (-(1 / 2)) R`.

## Goal-faithfulness audit

- Removed the answer-bearing hypotheses `givenRadiusRelation` and
  `coefficientIdentity`.
- Removed arbitrary `alpha` and `beta` inputs; the theorem now exhibits them
  in its conclusion.
- `AreTrigCoefficients` remains unchanged as a supporting declaration, as
  required, but is not a premise of the target and is not used in its proof.
- Neither coefficient value nor the requested radius equation occurs in
  `SolarCookerSetup`, `SolarOpticsModel`, `MaximalRayTangencyLaw`, or
  `IsMaximumIncidenceAngle`.
- The proof consumes `tangencyLaw` and `thetaMax_is_maximum` through
  `maximum_ray_containerRadius_eq_limitingRadius`, so the physical inputs are
  load-bearing rather than decorative.

## Derivability and bridge obligations

- **Maximum is attained and tangent.** Source claim: the largest reflected ray
  that still hits the container is tangent. Carrier:
  `maximum_incidence_ray_is_tangent`, eliminating
  `MaximalRayTangencyLaw` with `IsMaximumIncidenceAngle`. Evidence: it returns
  an actual reflected, striking ray at `thetaMax` together with
  `LimitingTangentRay`. Status: **covered**, locally encoded and proved.
- **Tangency determines the positive radius.** Source claim: the perpendicular
  distance of the limiting line from the cylinder center equals `a`. Carrier:
  `limiting_tangent_radius_eq_signedDistance`. Evidence: unit direction,
  boundary incidence, orthogonality, determinant square, the signed-side
  condition, and positive `a` select the positive square root. Status:
  **covered**, locally encoded and proved.
- **The physical maximum ray equals the canonical readout.** Source claim:
  substitute the maximum ray's canonical incidence point and reflected
  direction into the signed distance. Carrier:
  `maximum_ray_containerRadius_eq_limitingRadius`. Evidence: it invokes the
  preceding two carriers and the model's canonical-coordinate fields. Status:
  **covered**, locally encoded and proved.
- **Figure 2f geometry gives the two sine terms.** Source claim:
  `a = R sin thetaMax - (R / 2) sin (2 thetaMax)`. Carrier:
  `limitingRadiusMeters_eq_trigFormula`. Evidence: the proof expands the
  canonical incidence point and vector reflection, uses the `R / 2` center
  offset and oriented orthonormal basis, then applies the sine double-angle
  identity. Status: **covered**, grounded in Mathlib algebra/trigonometry plus
  local geometry and proved.
- **Read off the requested coefficients.** Source claim:
  `alpha = R`, `beta = -R / 2`, and this pair realizes the actual equation.
  Carrier: the main theorem
  `coefficients_from_solar_cooker_geometry`, with witnesses
  `setup.mirrorRadius` and
  `scaledLength (-(1 / 2)) setup.mirrorRadius`. Evidence: its proof chains the
  two derived radius equalities and normalizes the final scalar expression by
  `ring`. Status: **covered** and proof-closed.

## Abstraction sufficiency and countermodel audit

- `OnHalfMirror` is transparent: it imposes the circle equation and the
  half-plane inequality.
- `OnContainerBoundary` and `InContainer` are transparent norm equality and
  norm inequality constraints.
- `SpecularReflection` exposes incoming/normal unit equations and the exact
  vector equation `outgoing = incoming - 2 ⟪incoming,n⟫ n`.
- `RayHitsContainer` exposes a forward parameter `travelMeters ≥ 0` and a
  point satisfying `InContainer`.
- `LimitingTangentRay` exposes unit direction, forward travel, boundary
  incidence, radius-direction orthogonality, and the signed determinant
  inequality selecting the Figure 2f side.
- The `SolarOpticsModel` predicates `isIncidentSunRay`,
  `isReflectedFromMirror`, `strikesContainer`, and
  `isAbsorbedByContainer` are constrained by reusable fields exposing
  absorption, reflection count, sunlight direction, mirror incidence,
  canonical coordinates, specular reflection, angle bounds, and container-hit
  consequences.
- `IsMaximumIncidenceAngle` exposes both an attaining ray and the universal
  upper-bound inequality.
- `MaximalRayTangencyLaw` exposes an elimination field producing a concrete
  tangent ray from every attained maximum.
- `AreTrigCoefficients` exposes an all-angle scalar equality. It is retained
  for compatibility but is not used to assume the current answer.
- Countermodel check: `thetaMax_is_maximum` prevents an empty reflected-ray
  interpretation; `tangencyLaw` then supplies a concrete tangent, and the
  tangent/canonical/figure equations force the radius formula. Hence one
  cannot interpret the local predicates arbitrarily while keeping all
  premises true and falsifying the exhibited coefficient equation.

## Uncertainty and branch coverage

- **Uncertainty: not applicable.** The source gives exact geometry and no
  `value ± uncertainty` datum.
- **Branch/orientation: covered.** Reflected rays have one prior reflection;
  incidence angles lie in `[0, π / 2]`; `thetaMax` is attained; ray travel is
  forward; and `LimitingTangentRay` includes the signed-side inequality needed
  to recover the positive container radius.

## Declarations and blueprint labels

- Redrafted and proof-closed
  `IPhO2026Problems.IPhO2026_2_B_1.coefficients_from_solar_cooker_geometry`,
  blueprint label `thm:physics:IPhO_2026_2_B_1:target`.
- No new supporting declarations were created. All auxiliary signatures
  `aux001`–`aux029` and their existing closed proofs were preserved.
- The target is ready for `\leanok`. The blueprint was not edited because the
  prover write permissions reserve blueprint marker changes for the
  deterministic sync/review phase.

## LeanExplore queries/candidates actually used

- Query `Real.sin_two_mul sine double angle`, packages
  `["Mathlib", "Physlib"]`: confirmed `Real.sin_two_mul`, already used by the
  preserved proof of `limitingRadiusMeters_eq_trigFormula`.
- Query `WithDim.ext equality dimensioned quantities`, packages
  `["Mathlib", "Physlib"]`: confirmed `WithDim.ext`. The revised existential
  theorem does not need extensionality because its coefficient witnesses close
  by `rfl`; the candidate was therefore grounded but not added to the proof.

## PhysLean/Mathlib names grounded

- PhysLean/Physlib: `Dimension`, `Dimension.L𝓭`, `WithDim`, `WithDim.val`,
  and `WithDim.ext`.
- Mathlib: `EuclideanSpace`, `inner`, norm notation, `Real.sin`,
  `Real.sin_two_mul`, and the `ring` normalization tactic.

## Local abstractions and grounding gaps

- The local `SpecularReflection`, `RayHitsContainer`,
  `LimitingTangentRay`, `SolarOpticsModel`, and
  `MaximalRayTangencyLaw` interfaces remain necessary because the searched
  Mathlib/PhysLean surface does not provide a matching geometric-optics ray
  model with the Figure 2f forward/tangent branch data.
- These abstractions preserve the physical roles through explicit vector
  equations, incidence equations, inequalities, and elimination fields; none
  is an opaque witness-only proposition.
- No new grounding gap or redraft request remains.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`: exit code 0.
- Lean LSP diagnostics: no errors or warnings.
- `lean_verify` for the target reports only `propext`,
  `Classical.choice`, and `Quot.sound`.
- Source audit found no `sorry`, `admit`, `axiom`, `givenRadiusRelation`, or
  `coefficientIdentity` occurrence. The verifier's textual `opaque` warning is
  only the explanatory word “opaque” in the `SolarOpticsModel` docstring.

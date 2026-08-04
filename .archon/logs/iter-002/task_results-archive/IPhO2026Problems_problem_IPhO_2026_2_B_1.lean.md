# Autoformalization result: IPhO 2026 problem 2 B.1

## Status

- Created `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`.
- The chapter contains `% archon:physics`; the physics-formalize discipline was used.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_1.lean` exits 0 with exactly five expected `declaration uses sorry` warnings.
- No `/- USER: ... -/` hint was available because the assigned file was initially absent.
- Blueprint label `thm:physics:IPhO_2026_2_B_1:target` is ready for the loop-managed `\leanok` synchronization. Per prover write permissions, the blueprint chapter was not edited.

## Extracted physical model

- `R`: positive mirror radius, represented as the dimension-tagged length `setup.mirrorRadius`.
- `a`: positive absorbing-container radius, represented as the dimension-tagged length `setup.containerRadius`.
- `thetaMax`: largest incidence-angle readout in radians among reflected rays which strike the container.
- `alpha`, `beta`: signed dimension-tagged length coefficients in the displayed trigonometric relation.
- `P₀`: positive dimension-tagged power `setup.powerWithoutMirror`; retained although it is not used in the B.1 conclusion.
- Sunlight intensity: a positive dimension-tagged irradiance field, constrained to be spatially uniform.
- Figure 2f geometry: a two-dimensional cross-section, a half-circle mirror, a circular container, parallel three-dimensional cylinder axes, an oriented optical/transverse basis, and center displacement `(R/2) • opticalAxis`.
- Optical laws: parallel incoming rays, vector specular reflection, full absorption on a container strike, and at most one mirror reflection for an absorbed ray.

## Assumption/target split

### Governing laws

- `SolarCookerSetup.sunlight_uniform` and `SolarOpticsModel.sunlight_rays_parallel` encode uniform parallel sunlight along the optical axis.
- `SolarOpticsModel.fully_absorbing` encodes complete absorption of every ray that strikes the container.
- `SolarOpticsModel.absorbed_ray_reflects_at_most_once` encodes the stipulated at-most-one-reflection regime.
- `SpecularReflection.outgoing_eq` encodes `v_out = v_in - 2 ⟪v_in,n⟫ n`.
- `SolarOpticsModel.reflected_hit_geometry` exposes a forward container-intersection witness.
- `MaximalRayTangencyLaw.tangent_of_maximum` records the convex-geometric extremality law that the largest-angle ray still striking the container is tangent.

### Previous-part results

- None. The source report has `previous_parts: []`, and the file imports no sibling IPhO problem output.

### Figure/data readouts

- The mirror and container are represented by `OnHalfMirror`, `OnContainerBoundary`, and `InContainer`.
- Their axes are parallel through equal consistently oriented unit axis vectors.
- The centers obey
  `containerCenterMeters - mirrorCenterMeters = (mirrorRadius.val / 2) • opticalAxis`.
- `basis_orientation` fixes the sign convention read from Figure 2f.
- `canonicalIncidencePoint`, `canonicalOutwardNormal`, and `canonicalReflectedDirection` express the incidence geometry in the oriented cross-section.
- `IsMaximumIncidenceAngle` records attainment and the upper-bound property for `thetaMax`.
- The printed equation
  `a = alpha * sin(thetaMax) + beta * sin(2 * thetaMax)`
  occurs verbatim at scalar-readout level as `givenRadiusRelation`.

### Current target conclusions

- `alpha = setup.mirrorRadius`.
- `beta = scaledLength (-(1 / 2 : ℝ)) setup.mirrorRadius`, i.e. `beta = -R/2` as a signed length coefficient.

## Goal-faithfulness audit

- Neither requested coefficient value occurs in `SolarCookerSetup`, `SolarOpticsModel`, `MaximalRayTangencyLaw`, or any theorem hypothesis.
- `scaledLength` is a generic signed scalar action on any dimension-tagged length; it is not a definition of `beta`.
- `limitingRadiusMeters` is defined from the incidence point, vector reflection law, center offset, and oriented cross product. It does not contain the expanded answer formula.
- The expansion to
  `R * sin(theta) - (R/2) * sin(2*theta)`
  is the conclusion of the separate proof obligation `limitingRadiusMeters_eq_trigFormula`, not a hypothesis or an unfolding trick.
- `AreTrigCoefficients` does not assert values for `alpha` or `beta`. It formalizes the word “coefficients” as equality of the two trigonometric expressions for every symbolic angle. This is needed because the displayed equation at one fixed `thetaMax` alone is mathematically insufficient to identify two arbitrary coefficients.
- The main conclusion therefore requires both substantive geometry expansion and coefficient uniqueness; it cannot close by `rfl` or by unfolding a definition of the answer.

## Derivability and bridge obligations

| Source-to-Lean bridge | Lean carrier | Evidence/status |
|---|---|---|
| Radii and coefficients have length dimension | `Length := WithDim Dimension.L𝓭 ℝ` | Grounded in PhysLean; **covered**. |
| `P₀` is power and sunlight intensity is power/area | `powerDimension`, `irradianceDimension`, `Power`, `Irradiance` | Dimension exponents encoded locally; **covered**. |
| Parallel axes and the Figure 2f center offset reduce the apparatus to an oriented cross-section | `SolarCookerSetup.axes_parallel`, `center_on_symmetry_plane`, orthonormal/orientation fields | Direct source/figure contract; **covered**. |
| A mirror hit lies on the half-circle and has the angle-parametrized radial normal | `reflected_ray_hits_half_mirror`, `incidence_point_is_canonical`, `surface_normal_is_canonical` | Equation-bearing model fields; **covered**. |
| Incoming sunlight reflects specularly | `SpecularReflection.outgoing_eq`, `SolarOpticsModel.specular_reflection`, `reflected_direction_is_canonical` | Local equation because no optics-specific library API was found; **covered**. |
| Container strikes are absorbed after at most one reflection | `fully_absorbing`, `absorbed_ray_reflects_at_most_once`, `reflected_ray_has_one_reflection` | Direct governing-law contract; **covered**. |
| `thetaMax` is the attained largest relevant incidence angle | `IsMaximumIncidenceAngle` | Existential attainment plus universal upper bound; **covered**. |
| Extremality gives a forward tangent ray | `MaximalRayTangencyLaw` and `maximum_incidence_ray_is_tangent` | Locally encoded governing bridge; theorem proof remains the intended later proof obligation; **covered**. |
| Tangency gives radius as signed perpendicular distance | `limiting_tangent_radius_eq_signedDistance` | Uses unit direction, forward contact, boundary equality, orthogonality, and side sign; **covered**. |
| The actual maximum-ray radius equals the canonical distance readout | `maximum_ray_containerRadius_eq_limitingRadius` | Combines maximum, tangency, and canonical ray fields; **covered**. |
| Canonical reflection and the `R/2` offset expand to the two sine terms | `limitingRadiusMeters_eq_trigFormula` | Main geometry/algebra bridge, stated as a theorem with `by sorry`; **covered**. |
| The symbolic two-term identity uniquely identifies `alpha` and `beta` | `AreTrigCoefficients` plus `coefficients_from_solar_cooker_geometry` | Main theorem contract; evaluate independent sine modes after applying the geometry expansion; **covered**. |

All substantive bridges have explicit carriers. Their proofs are intentionally deferred with `sorry` at the autoformalize stage; none is missing from the statement graph.

## Abstraction sufficiency and countermodel audit

- `OnHalfMirror`: constrained by the radius equality and optical-half-plane inequality.
- `OnContainerBoundary`: constrained by exact distance-to-center equality.
- `InContainer`: constrained by the distance-to-center inequality.
- `SpecularReflection`: constrains all three vector arguments by two unit equations and the explicit reflection equation; it is not an opaque label.
- `RayHitsContainer`: exposes a nonnegative travel parameter and an explicit affine point lying in the container disk.
- `LimitingTangentRay`: exposes unit direction, nonnegative travel, exact boundary contact, radius/ray orthogonality, and the nonnegative signed-side condition.
- `isIncidentSunRay`, `isReflectedFromMirror`, `strikesContainer`, and `isAbsorbedByContainer` inside `SolarOpticsModel`: their consequences are exposed by the parallel-direction, reflection-count, full-absorption, mirror-incidence, specular-reflection, and hit-geometry fields. Under the main `IsMaximumIncidenceAngle` premise, the relevant classifications cannot all be interpreted as empty.
- `IsMaximumIncidenceAngle`: contains both an attaining ray and a universal upper bound, so it cannot be made true by choosing an arbitrary angle with no rays.
- `MaximalRayTangencyLaw`: yields a ray satisfying the full `LimitingTangentRay` equations, rather than an unconstrained witness.
- `AreTrigCoefficients`: is a universal real equation against the geometry-derived radius function. An arbitrary interpretation of `alpha,beta` cannot satisfy it once `limitingRadiusMeters_eq_trigFormula` is available.

Countermodel result: with all assumptions satisfied, changing either coefficient away from `R` and `-R/2` violates the universal coefficient equation after the geometry expansion. No local relation can be interpreted arbitrarily while retaining the hypotheses and falsifying the requested conclusion.

## Uncertainty and branch coverage

- Uncertainty: **not applicable**. The source gives no measurement uncertainty or `value ± uncertainty` datum.
- Incoming/outgoing orientation: **covered** by `sunlight_along_opticalAxis`, the oriented basis, and the signed vector reflection equation.
- Half-mirror branch: **covered** by the half-plane inequality in `OnHalfMirror`.
- Incidence-angle branch: **covered** by `0 ≤ theta ≤ pi/2` for reflected rays.
- Forward ray branch: **covered** by nonnegative travel parameters in `RayHitsContainer` and `LimitingTangentRay`.
- Tangency side/sign: **covered** by `center_on_nonnegative_side` in `LimitingTangentRay` and `basis_orientation`.
- Reflection count: **covered** by the one-reflection and at-most-one-reflection model fields.

## Declarations created and blueprint correspondence

- Blueprint label `thm:physics:IPhO_2026_2_B_1:target`:
  `IPhO2026Problems.IPhO2026_2_B_1.coefficients_from_solar_cooker_geometry`.
- Supporting physical interfaces:
  `SolarCookerSetup`, `DirectedRay`, `SpecularReflection`,
  `SolarOpticsModel`, `MaximalRayTangencyLaw`.
- Supporting geometry predicates:
  `OnHalfMirror`, `OnContainerBoundary`, `InContainer`,
  `RayHitsContainer`, `LimitingTangentRay`, `IsMaximumIncidenceAngle`,
  `AreTrigCoefficients`.
- Supporting bridge theorems:
  `maximum_incidence_ray_is_tangent`,
  `limiting_tangent_radius_eq_signedDistance`,
  `maximum_ray_containerRadius_eq_limitingRadius`,
  `limitingRadiusMeters_eq_trigFormula`.
- Dimension and geometry helpers:
  `powerDimension`, `irradianceDimension`, `cross2D`, `scaledLength`,
  `canonicalIncidencePoint`, `canonicalOutwardNormal`,
  `canonicalReflectedDirection`, `limitingRadiusMeters`.

## LeanExplore queries/candidates actually used

All searches used `packages: ["Mathlib", "Physlib"]`.

- Query `physical quantities with SI dimensions length radius units`:
  found `Dimension`, `Dimension.L𝓭`, `UnitChoices.SI`,
  `UnitChoices.SI_length`, `LengthUnit`, and
  `CarriesDimension.toDimensionful`.
- Query `Dimensionful physical quantity length operations add scalar multiply field real Physlib.Units`:
  found `Dimensionful`, `Dimensionful.smul_apply`, and the `WithDim` operation family.
- Query `WithDim definition dimension tagged types addition negation real`:
  found `WithDim`, `WithDim.instAdd`, `WithDim.instNeg`,
  `WithDim.val_add`, `WithDim.val_sub`, and `WithDim.le_def`.
- Query `ray optics specular reflection law incidence angle reflected ray`:
  found `EuclideanGeometry.reflection` and `Module.Ray`; both were inspected and rejected as insufficient for an incident-point optical ray with a specular direction equation.
- Query `Real.sin angle trigonometric identity sin two times angle`:
  found and inspected `Real.sin` and `Real.sin_two_mul`.
- Queries `physical dimension power energy per time Dimension power Physlib Units` and `DimPower watt power dimension`:
  found `Dimension` and `DimEnergy`, but no ready-made power or irradiance dimension type.

## PhysLean/Mathlib names grounded

- PhysLean: `Dimension`, `Dimension.L𝓭`, `WithDim`, `WithDim.val`,
  and the inherited order/additive behavior from
  `Physlib.Units.WithDim.Basic`.
- Mathlib: `EuclideanSpace`, `inner`, vector norm/scalar operations,
  `Real.sin`, `Real.cos`, `Real.pi`, and `Real.sin_two_mul`.
- Near miss not used: `EuclideanGeometry.reflection` reflects points in an affine subspace; it does not state the optical law relating incoming direction, surface normal, and outgoing direction.
- Near miss not used: `Module.Ray` is an origin-free equivalence class of positively collinear vectors and does not carry the interaction data required here.

## Local abstractions introduced

- `powerDimension` and `irradianceDimension`: smallest local `Dimension` values needed because LeanExplore found no `DimPower`/`DimIrradiance`.
- `SolarCookerSetup`: preserves physical quantities, units/dimensional roles, Figure 2f coordinate data, axes, uniform sunlight, and `P₀`.
- `DirectedRay`: preserves origin, oriented unit direction, and reflection count.
- `SpecularReflection`: supplies the missing optics-specific vector equation.
- `RayHitsContainer` and `LimitingTangentRay`: supply explicit forward incidence/tangency equations and branch conditions.
- `SolarOpticsModel`: ties ray classifications to absorption, reflection, canonical geometry, and container-hit consequences.
- `MaximalRayTangencyLaw`: explicit convex-geometric extremality bridge.
- `AreTrigCoefficients`: captures the symbolic meaning of “determine the coefficients” without assuming their values.

These abstractions use real numbers only for coordinate, angle, and unit readouts. Physical lengths, power, and irradiance remain dimension-tagged.

## Grounding gaps

- Mathlib/PhysLean currently provides generic Euclidean reflection and algebraic rays, but the search did not locate a geometric-optics API for incident/reflected light rays at a curved mirror. The exact specular equation is therefore encoded locally.
- No ready-made PhysLean declarations for power and irradiance dimensions were found; their standard dimension exponent vectors are encoded locally.
- The `archon dag-query` navigation command was unavailable on this prover process's `PATH`. The blueprint declares no `\uses` dependencies and the source report has no previous parts, so this did not create a dependency gap.

## Redraft requests

- None. The statement is proof-ready at the autoformalize level.

## Verification

- Lean LSP diagnostics: no errors; five expected `sorry` warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`: exit code 0; five expected `sorry` warnings.

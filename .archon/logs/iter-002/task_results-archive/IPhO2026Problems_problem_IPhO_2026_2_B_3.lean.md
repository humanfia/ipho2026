# Autoformalization result: IPhO 2026 problem 2 B.3

The assigned file was created and checked with
`lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_3.lean`. It compiles
with exactly three expected `declaration uses sorry` warnings and no errors.

## Assumption/target split

### Governing laws

- `PreviousPartResults.radius_from_cutoff_ray` is the B.1 cutoff-ray geometry
  law
  `a = R sin θ_max - (R / 2) sin (2 θ_max)`, expressed using SI length
  readouts of dimensionful quantities.
- `PreviousPartResults.power_ratio_from_cutoff_angle` is the B.2 illumination
  law `P / P₀ = 1 / (1 - cos θ_max)`, expressed using SI radiant-power
  readouts.
- `baselinePower_positive` guarantees that division by the unobstructed
  reference power is physically and algebraically meaningful.

### Previous-part results

- B.1 is restated locally as `radius_from_cutoff_ray`; no sibling Lean module
  is imported.
- B.2 is restated locally as `power_ratio_from_cutoff_angle`; no sibling Lean
  module is imported.

### Figure/data readouts

- `Figure2fAssumptions` records positive radii; the half-cylinder angular
  extent `π`; aperture width `2R`; center offset `R/2`; zero displacement out
  of the symmetry plane; parallel cylinder axes; parallel axial sunlight;
  positive uniform irradiance; full absorption; the one-reflection bound; and
  `0 ≤ θ_max ≤ π/2`.
- The current operating data are
  `lengthInMetres cooker.mirrorRadius = 1` and
  `powerInWatts actualPower = 5 * powerInWatts baselinePower`.
- The source's dimensional roles are represented by
  `LengthQuantity`, `RadiantPowerQuantity`, and `IrradianceQuantity`, each
  built from Physlib `Dimensionful (WithDim ... ℝ)` quantities. The numerical
  functions explicitly evaluate them at `UnitChoices.SI`.

### Current target conclusions

- `Real.cos cooker.thetaMax = (4 : ℝ) / 5`.
- `lengthInMetres cooker.containerRadius = (12 : ℝ) / 100`.
- `lengthInCentimetres cooker.containerRadius = 12`.

These appear only as theorem conclusions.

## Goal-faithfulness audit

- Neither `Figure2fAssumptions` nor `PreviousPartResults` contains
  `cos θ_max = 4/5`, `a = 0.12 m`, or `a = 12 cm`.
- `fivefold_power` and `mirrorRadius_eq_one_metre` are data from the current
  question, not the requested answer.
- `lengthInCentimetres` only implements the unit conversion
  `cm = 100 * m`; it does not mention `12` and cannot make the requested
  numerical answer true by unfolding.
- The two bridge theorems and the main theorem are independent proof
  obligations with `by sorry` bodies. No target conclusion is installed as a
  premise field or law field.
- Countermodel sanity check: without either previous-part equation, the final
  radius or cosine can vary freely. With both equations, positive `P₀`,
  `P = 5P₀`, `R = 1`, and the nonnegative angle branch, the reported values are
  forced. Thus the contract is neither circular nor underdetermined for the
  requested outputs.

## Derivability and bridge obligations

1. **Dimensionful SI readouts — covered.**
   Source claim: `R`, `a`, center offsets, powers, and irradiance have physical
   dimensions and the numerical data use SI units. Carrier:
   Physlib `Dimensionful`, `WithDim`, `Dimension.L𝓭`,
   `UnitChoices.SI`, plus local `radiantPowerDimension`,
   `irradianceDimension`, `lengthInMetres`, `powerInWatts`, and
   `irradianceInSI`. Evidence: these APIs were source-checked in
   `Physlib.Units.Basic`, `Physlib.Units.Dimension`, and
   `Physlib.Units.WithDim.Basic`.

2. **Figure 2f setup — covered.**
   Source claim: half-cylinder of radius `R`, aperture `2R`, container center
   offset `R/2` on the symmetry plane, parallel axes and axial rays, constant
   irradiance, full absorption, and at most one reflection. Carrier:
   the direct equations and inequalities of `Figure2fAssumptions`. Evidence:
   the official page image was inspected, including the labels `2R`, `a`,
   `R/2`, and `Fig. 2f`.

3. **Cutoff-ray geometry — covered.**
   Source claim: B.1 gives
   `a = R sin θ_max - (R/2) sin(2θ_max)`. Carrier:
   `PreviousPartResults.radius_from_cutoff_ray`. Evidence: exact reusable B.1
   conclusion from the blueprint/source report.

4. **Power-ratio law — covered.**
   Source claim: B.2 gives `P/P₀ = 1/(1-cos θ_max)`. Carrier:
   `PreviousPartResults.power_ratio_from_cutoff_angle`. Evidence: exact
   reusable B.2 conclusion from the blueprint/source report.

5. **Fivefold gain implies `cos θ_max = 4/5` — covered.**
   Carrier: theorem
   `IPhO2026Problem2B3.cosine_thetaMax_of_fivefold_power`. Its premises expose
   the B.2 equation, `P₀ > 0`, and `P = 5P₀`; elementary field algebra gives
   the conclusion. The autoformalization body is intentionally `sorry`.

6. **Positive trigonometric branch — covered.**
   Source claim: the incidence angle is the nonnegative normal-referenced
   cutoff angle. Carrier:
   `Figure2fAssumptions.thetaMax_nonnegative` and
   `thetaMax_le_pi_div_two`. Mathlib carriers for the later proof are
   `Real.sin_eq_sqrt_one_sub_cos_sq` and
   `Real.sin_nonneg_of_nonneg_of_le_pi`; with `cos θ_max = 4/5`, they select
   `sin θ_max = 3/5` rather than the negative branch.

7. **Substitution into the B.1 radius law — covered.**
   Carrier: theorem
   `IPhO2026Problem2B3.container_radius_of_fivefold_power`, which takes only
   the original setup, previous-part laws, and current operating data.
   `Real.sin_two_mul` supplies
   `sin(2θ) = 2 sin θ cos θ`, after which the equation gives
   `a = 1 * (3/5) * (1-4/5) = 12/100 m`. The body is intentionally `sorry`.

8. **Metre-to-centimetre reporting — covered.**
   Carrier: `lengthInCentimetres x := 100 * lengthInMetres x`, and the two
   radius conclusions in `container_radius_of_fivefold_power` and the main
   theorem.

9. **Complete source-to-contract mapping — covered.**
   Carrier:
   `IPhO2026Problem2B3.ipho2026_problem2_B3`, whose assumptions are precisely
   the setup, reusable laws, and current operating data, and whose conclusion
   contains the complete recorded answer.

No bridge required by a substantive target remains absent from the statement
layer.

## Abstraction sufficiency and countermodel audit

- `Figure2fAssumptions` is a local `Prop`-valued interface. It is constraining
  through explicit positivity, equality, normalization, and order fields:
  radii are positive; angular extent is `π`; aperture and center locations are
  fixed relative to `R`; direction representatives are normalized/equal;
  irradiance is positive; absorptivity is `1`; reflections are bounded by
  `1`; and `θ_max` lies in the required interval. It has no opaque witness-only
  fields.
- `PreviousPartResults` is a local `Prop`-valued interface. Its two fields are
  the usable radius and power-ratio equations. Interpreting the proposition
  arbitrarily is impossible without satisfying those equations.
- `SolarCooker` is data-valued, not `Prop`-valued. It retains the named physical
  quantities and directions without asserting any law.
- The local quantity names are definitions over Physlib's unit-covariant
  `Dimensionful` interface, not scalar aliases or ad hoc one-field wrappers.
- Countermodel test: dropping the power-ratio field permits arbitrary
  `cos θ_max`; dropping the radius field permits arbitrary `a`; dropping the
  angle bounds permits the wrong sine branch. All three carriers are present,
  so no such countermodel satisfies the full premises while falsifying the
  target.

## Uncertainty and branch coverage

- **Uncertainty: not applicable.** The source reports exact problem data and
  the exact answer `0.12 m = 12 cm`; it contains no `value ± uncertainty`,
  tolerance, or experimental error to propagate.
- **Incidence-angle branch: covered.** The normal-referenced maximum angle is
  constrained to `0 ≤ θ_max ≤ π/2`, selecting the positive sine branch.
- **Axis/ray orientation: covered.** Axis and ray direction representatives
  are chosen consistently and equated in the parallelism fields. No signed
  orientation occurs in the requested radius.
- **Reflection branch: covered.** The uniform upper bound
  `maxReflectionsForAbsorbedRay ≤ 1` and the B.1 cutoff-ray equation preserve
  the one-reflection regime used by the source.

## Declarations and blueprint labels

- Blueprint label `thm:physics:IPhO_2026_2_B_3:target` maps to
  `IPhO2026Problem2B3.ipho2026_problem2_B3`.
- Supporting bridge declarations:
  `IPhO2026Problem2B3.cosine_thetaMax_of_fivefold_power` and
  `IPhO2026Problem2B3.container_radius_of_fivefold_power`.
- Supporting model declarations:
  `radiantPowerDimension`, `irradianceDimension`, `LengthQuantity`,
  `RadiantPowerQuantity`, `IrradianceQuantity`, `lengthInMetres`,
  `lengthInCentimetres`, `powerInWatts`, `irradianceInSI`, `SolarCooker`,
  `Figure2fAssumptions`, and `PreviousPartResults`.
- The target environment is ready for a statement-level `\leanok`. Per prover
  permissions, the blueprint was not edited. The review/synchronization step
  should associate
  `\lean{IPhO2026Problem2B3.ipho2026_problem2_B3}` with the target label.

## LeanExplore queries/candidates actually used

- Query `physical quantity with dimensions and SI units length power Physlib`:
  used candidates `Dimension`, `Dimension.L𝓭`, and `UnitChoices.SI`.
- Query `Quantity length dimension SI meter unit value Physlib`:
  used candidates `WithDim`, `Dimension.L𝓭`, and `UnitChoices.SI_length` to
  confirm the SI length interpretation.
- Query `WithDim physical quantity length power dimension tag`:
  used `WithDim`.
- Query `Dimensionful toDimensionful value in chosen units Physlib`:
  used `Dimensionful` and inspected
  `CarriesDimension.toDimensionful` /
  `CarriesDimension.toDimensionful_apply_apply` to confirm unit-dependent
  evaluation.
- Query `real trigonometric cosine equation unique angle arccos interval
  nonnegative`: inspected `Real.arccos_eq_of_eq_cos` as a possible branch
  carrier; the final contract instead uses direct interval bounds.
- Query `Real.sin_two_mul sin (2*x) double angle identity`:
  used candidate `Real.sin_two_mul` for the radius bridge inventory.
- Query `Real.sin nonnegative square root one minus cosine squared on zero pi
  interval`: used candidates `Real.sin_eq_sqrt_one_sub_cos_sq` and
  `Real.sin_nonneg_of_nonneg_of_le_pi` for the positive-branch bridge.

## PhysLean/Mathlib names grounded

- Physlib: `Dimension`, `Dimension.L𝓭`, `Dimension.M𝓭`,
  `Dimension.T𝓭`, `Dimensionful`, `WithDim`, and `UnitChoices.SI`.
- Mathlib: `Real.sin`, `Real.cos`, `Real.pi`, `Real.sin_two_mul`,
  `Real.sin_eq_sqrt_one_sub_cos_sq`, and
  `Real.sin_nonneg_of_nonneg_of_le_pi`.

## Local abstractions introduced

- `radiantPowerDimension = mass * length² / time³` and
  `irradianceDimension = mass / time³` fill the absence of a selected
  ready-made named radiant-power/irradiance dimension while remaining built
  entirely from Physlib dimension primitives.
- `SolarCooker` retains apparatus quantities, directions, absorptivity,
  reflection count, and the cutoff angle.
- `Figure2fAssumptions` exposes every local physical/setup assertion as a
  mathematical equation or inequality.
- `PreviousPartResults` faithfully restates the allowed natural-language B.1
  and B.2 prerequisites without a forbidden sibling import.

## Grounding gaps

- No dedicated half-cylindrical solar-mirror/cutoff-ray API was identified in
  Mathlib or Physlib. The local apparatus and law interfaces preserve the
  necessary geometry and provide direct elimination equations.
- No ready-made named radiant-power or irradiance dimension was selected; the
  standard dimensions are composed locally from Physlib base dimensions.
- The `archon dag-query` executable was unavailable on this lane's `PATH`, so
  the dependency graph could not be queried. The blueprint explicitly marks
  both previous parts as natural-language-only prerequisites, so no sibling
  Lean dependency was introduced.

## Redraft requests

- None. The formal contract is compiling, dimension-aware, proof-ready, and
  contains no current-answer hypothesis.

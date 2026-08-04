# IPhO2026Problems/problem_IPhO_2026_3_B_2.lean

## Result

- Created the assigned physics formalization for IPhO 2026 Problem 3 B.2.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` succeeds.
- The only Lean diagnostics are the three expected `declaration uses sorry`
  warnings, for two bridge theorems and the main target theorem.
- The chapter contains `% archon:physics`; the physics-formalize discipline was
  used.
- The assigned file did not previously exist, so it contained no
  `/- USER: ... -/` file-specific hint.

## Extracted physical model

### Named quantities and roles

- `T`, `Tᵢ`, `T_f`: absolute temperature and endpoint temperatures.
- `H`, `Hᵢ`, `H_f`: magnetic-field-strength magnitudes and endpoint
  magnitudes.
- `M`: magnetization magnitude.
- `V`: fixed torus volume.
- `n`: amount of paramagnetic material, with a scalar readout in moles.
- `K`: Curie-law constant in `T M V = n K H`.
- `λ`: heat-capacity parameter in `C_M = n λ / T²`.
- `C_M`: heat capacity at constant magnetization.
- `U`: internal energy.
- `μ₀`: vacuum permeability.
- Heat and work input rates along a dimensionless process parameter.

All physical quantities except the molar readout are carried by
`WithDim d ℝ`. The process functions return dimension-tagged quantities; only
their coherent-SI `.val` readouts enter real calculus.

### Dimensional roles

- Temperature: `Θ𝓭`.
- Volume: `L𝓭 ^ 3`.
- Energy: `M𝓭 * L𝓭 ^ 2 * T𝓭⁻¹ ^ 2`.
- Magnetic field strength and magnetization: `C𝓭 * T𝓭⁻¹ * L𝓭⁻¹`.
- Heat capacity: energy per temperature.
- `K`: temperature times volume after separating the mole readout.
- `λ`: energy times temperature after separating the mole readout.
- `μ₀`: `M𝓭 * L𝓭 * C𝓭⁻¹ ^ 2`.

`Physlib.Dimension` has length, time, mass, charge, and temperature base
dimensions but no amount-of-substance component. Consequently `n` is an
explicit real readout in moles, and the comments and field name preserve this
role rather than pretending it is a dimensionless physical primitive.

### Geometry and source-page readouts

- The material is a paramagnetic torus with fixed volume `V`.
- The official page states that the magnitude of the magnetic field changes
  adiabatically from `Hᵢ` to `H_f`, while temperature changes from `Tᵢ` to
  `T_f`.
- The path parameter has the oriented endpoint convention `s = 0` for the
  incoming state and `s = 1` for the outgoing state.
- The page includes the later Figure 3b, but B.2 does not use its Carnot-cycle
  vertex geometry. No irrelevant figure geometry was imported into this
  theorem.

## Assumption/target split

### Governing laws

- `ParamagneticTorusModel` records positive `n`, fixed positive `V`, positive
  `K`, positive `λ`, and positive `μ₀`.
- `IsAdiabaticQuasistaticChange.equation_of_state` states
  `T M V = n K H` pointwise along the path.
- `.heat_capacity` states `C_M = n λ / T²`.
- `.internal_energy_change` states the differential readout law
  `dU/ds = C_M dT/ds`.
- `.first_law` implements the stated incoming-positive convention as
  `dU/ds = heatInputRate + workInputRate`.
- `.adiabatic` states that the heat input rate vanishes.
- Differentiability fields make all derivative laws mathematically usable.
- Positive temperature and nonnegative field/magnetization fields preserve
  the meanings of absolute temperature and magnitudes.

### Previous-part results

- `IsAdiabaticQuasistaticChange.magnetic_work` records the permitted
  natural-language conclusion of A.3:
  `dW/ds = μ₀ V H dM/ds`.
- No sibling Lean file is imported and there is no Lean dependency on A.3.

### Figure/data readouts

- `.initial_temperature` and `.final_temperature` identify the path endpoint
  temperatures with `Tᵢ` and `T_f`.
- `.initial_field_strength` and `.final_field_strength` identify the endpoint
  field-strength magnitudes with `Hᵢ` and `H_f`.
- `fieldStrengthMagnitude_nonnegative` records that `H` is a magnitude.
- `V` and `n` remain explicit model data even though they cancel from the
  closed-form answer.

### Current target conclusions

- `reduced_adiabatic_temperature_ode` concludes the nontrivial reduced ODE
  obtained by eliminating `U`, `C_M`, work, and `M`.
- `magnetothermal_invariant_constant` concludes constancy of
  `T² / (λ + μ₀ K H²)`.
- `adiabatic_temperature_change` concludes exactly
  `T_f - Tᵢ = Tᵢ (sqrt ((λ + μ₀ K H_f²) / (λ + μ₀ K Hᵢ²)) - 1)`.

## Goal-faithfulness audit

The requested temperature-change formula occurs only in the conclusion of
`adiabatic_temperature_change`. It does not occur in `ParamagneticTorusModel`,
`AdiabaticPathReadout`, `IsAdiabaticQuasistaticChange`, any hypothesis, or any
local definition.

The two helper definitions merely name the independently derived scale
`λ + μ₀ K H²` and invariant `T² / (λ + μ₀ K H²)`. Neither unfolds to the
endpoint answer. The invariant is itself the conclusion of a theorem with a
proof obligation. Thus no naming definition or premise makes the current
answer true by reflexivity.

The assumptions remain at the governing-law level: the equation of state,
heat-capacity relation, internal-energy differential, first law, adiabatic
condition, and the previous-part magnetic-work law. The endpoint formula still
requires differentiation, elimination, an interval-constancy argument, and a
square-root branch argument.

## Derivability and bridge obligations

1. **Physical dimensions**
   - Source claim: the thermodynamic and electromagnetic quantities have
     distinct dimensional roles.
   - Lean carrier: `Dimension`, its bases `L𝓭`, `T𝓭`, `M𝓭`, `C𝓭`, `Θ𝓭`,
     the local dimension expressions, and `WithDim`.
   - Evidence: grounded in `Physlib.Units.Dimension` and
     `Physlib.Units.WithDim.Basic`.
   - Status: **covered**.

2. **Energy balance under the incoming-positive convention**
   - Source claim: work and heat entering the torus are positive; an adiabatic
     path has zero heat input.
   - Lean carrier: `first_law` and `adiabatic`, together with
     `internal_energy_change`.
   - Mathematical consequence:
     `C_M dT/ds = workInputRate`.
   - Status: **covered** by explicit equations.

3. **Substitution of heat capacity and magnetic work**
   - Source claim: `C_M = nλ/T²` and `dW = μ₀ V H dM`.
   - Lean carrier: `heat_capacity`, `magnetic_work`, and the positive/nonzero
     parameter fields.
   - Mathematical consequence:
     `(nλ/T²) T' = μ₀ V H M'`.
   - Status: **covered** by explicit equations; the algebraic proof is deferred
     to the physics-prover stage.

4. **Differentiate the equation of state and eliminate `M'`**
   - Source claim: `T M V = n K H` holds throughout the quasistatic change.
   - Lean carrier: `equation_of_state` plus differentiability of `T`, `M`, and
     `H`; Mathlib product derivative rules for real functions.
   - Mathematical consequence:
     `V M' = nK (H'/T - H T'/T²)`.
   - Status: **covered**; all required nonzero facts follow from model and
     temperature positivity.

5. **Reduced adiabatic ODE**
   - Source claim: combining the preceding two differential relations gives
     `(λ + μ₀ K H²) T' = μ₀ K H T H'`.
   - Lean carrier: `reduced_adiabatic_temperature_ode`.
   - Evidence: its contract is the exact algebraic elimination result and
     retains the full path and physical-law premise.
   - Status: **covered** at the autoformalization level; proof body is `sorry`
     as required for this stage.

6. **Derivative-zero invariant**
   - Source claim: the reduced ODE makes
     `T² / (λ + μ₀ K H²)` constant.
   - Lean carrier: `magnetothermalInvariantSI`,
     `magnetothermal_invariant_constant`, real quotient/product derivative
     rules, and Mathlib `constant_of_derivWithin_zero`.
   - Evidence: `λ > 0`, `μ₀ > 0`, `K > 0`, and `H² ≥ 0` make the denominator
     strictly positive on `processDomain`.
   - Status: **covered** at the statement level; proof body is deferred.

7. **Endpoint substitution and positive square-root branch**
   - Source claim: evaluate the invariant at `s = 0, 1` and solve for `T_f`.
   - Lean carrier: the four endpoint fields, `temperature_positive`,
     `magnetothermal_invariant_constant`, `Real.sqrt`, and
     `Real.sqrt_pos_of_pos`.
   - Mathematical consequence:
     `T_f = Tᵢ sqrt ((λ + μ₀ K H_f²)/(λ + μ₀ K Hᵢ²))`.
   - Status: **covered**; positivity excludes the negative square-root branch.

8. **Requested temperature difference**
   - Source claim: `ΔT = T_f - Tᵢ`.
   - Lean carrier:
     `IPhO2026Problems.IPhO2026_3_B_2.adiabatic_temperature_change`.
   - Evidence: direct endpoint algebra after bridge 7.
   - Status: **covered** as the main theorem contract; proof is intentionally
     deferred with `sorry`.

## Abstraction sufficiency and countermodel audit

### `IsAdiabaticQuasistaticChange`

This is the only local `Prop`-valued physical interface. It is constraining
because it exposes:

- four differentiability statements;
- four endpoint equalities;
- positivity/nonnegativity inequalities for temperature and magnitudes;
- the pointwise equation of state;
- the pointwise heat-capacity equation;
- the internal-energy derivative equation;
- zero heat input;
- the signed first-law equation; and
- the magnetic-work derivative equation.

It is therefore not an opaque tag or a mere witness-existence predicate.

### Countermodel sanity check

From the heat-capacity, internal-energy, adiabatic, first-law, and work fields,
every satisfying interpretation obeys
`(nλ/T²)T' = μ₀ V H M'`. Differentiating the independently imposed equation of
state forces the stated expression for `M'`. Since `n`, `V`, `K`, `λ`, `μ₀`,
and `T` have the required nonzero/positive properties, cancellation forces the
reduced ODE. That ODE forces the invariant to be constant on the connected
closed process interval. Endpoint equalities and positive endpoint
temperatures then force the positive square-root solution.

Thus the local relation cannot be interpreted arbitrarily while all premises
remain true and the endpoint conclusion becomes false. No monotonicity of `H`
is needed: the conserved state relation is path-independent and only the
oriented endpoints enter the requested answer.

## Uncertainty and branch coverage

- **Uncertainty: not applicable.** Neither the blueprint nor the official
  source page provides a `value ± uncertainty`, error bar, or measurement
  tolerance.
- **Initial/final orientation: covered.** The process endpoints `0` and `1`
  explicitly represent incoming `Tᵢ, Hᵢ` and outgoing `T_f, H_f`.
- **Field and magnetization magnitude branches: covered.** Both readouts are
  constrained to be nonnegative on the process domain.
- **Square-root branch: covered.** Absolute temperature is strictly positive
  along the path, so the positive branch is forced rather than selected only
  in the final expression.
- **Heat/work sign convention: covered.** Positive input is represented by
  addition in `first_law`; `adiabatic` selects zero heat input.
- **Monotone increasing/decreasing field branch: not applicable.** The source
  specifies only an endpoint change and the answer is valid for either sign of
  `H_f - Hᵢ`; no monotonicity assumption is needed.

## Declarations created and blueprint correspondence

- Dimensions: `volumeDimension`, `energyDimension`,
  `magneticFieldStrengthDimension`, `heatCapacityDimension`,
  `curieConstantDimension`, `heatCapacityParameterDimension`, and
  `vacuumPermeabilityDimension`.
- Dimension-tagged quantity names: `TemperatureQuantity`, `VolumeQuantity`,
  `EnergyQuantity`, `MagneticFieldStrengthQuantity`,
  `MagnetizationQuantity`, `HeatCapacityQuantity`,
  `CurieConstantQuantity`, `HeatCapacityParameterQuantity`, and
  `VacuumPermeabilityQuantity`.
- Physical model/readout interfaces: `ParamagneticTorusModel`,
  `AdiabaticPathReadout`, `processDomain`, and
  `IsAdiabaticQuasistaticChange`.
- Bridge declarations: `reduced_adiabatic_temperature_ode`,
  `magnetothermalScaleSI`, `magnetothermalInvariantSI`, and
  `magnetothermal_invariant_constant`.
- Main declaration:
  `IPhO2026Problems.IPhO2026_3_B_2.adiabatic_temperature_change`
  corresponds to blueprint label
  `thm:physics:IPhO_2026_3_B_2:target`.
- The target environment is ready for `\leanok` at the statement level. The
  blueprint was not edited because `.archon/AGENTS.md` makes blueprint marker
  updates sync-managed and forbids prover edits to blueprint chapters.

## LeanExplore queries/candidates actually used

1. Query: `physical units dimensions SI quantity temperature magnetic field
   strength magnetization volume permeability heat capacity`
   - Selected `Dimension` and `UnitChoices.SI` for API inspection.
   - Selected the lower-level dimension-tagged representation rather than the
     unrelated continuum `Electromagnetism.MagneticField`.

2. Query: `Physlib.Units quantity value dimension UnitChoices SI convert
   physical quantity`
   - Selected `WithDim` and `WithDim.scaleUnit_val` for inspection.
   - Used `WithDim` and its `.val` projection in the file.

3. Query: `WithDim structure dimension tagged quantity val`
   - Used `WithDim` from `Physlib.Units.WithDim.Basic`.
   - Inspected its multiplication/division and value-projection support in the
     installed Physlib source before writing the model.

4. Query: `derivative zero on interval function constant eqOn interval
   connected`
   - Selected `constant_of_derivWithin_zero` from
     `Mathlib.Analysis.Calculus.MeanValue` as the intended interval-constancy
     carrier for the invariant proof.

5. Query: `ContDiff derivative product quotient square inverse power real
   functions HasDerivAt`
   - Inspected `HasDerivAt.div` and related differentiation support as
     grounding for the quotient invariant.

6. Query: `Real.sqrt division equality square root ratio positive real
   numbers`
   - Used `Real.sqrt`.
   - Selected `Real.sqrt_pos_of_pos` and
     `Real.sqrt_eq_iff_mul_self_eq_of_pos` as branch-solving support for the
     later proof.

The preflight grounding report also found `Real.sqrt`; its generic `Path.target`
candidate was not used because the physical process requires differentiable
readouts and governing laws rather than only a topological endpoint path.

## PhysLean/Mathlib names grounded

- Physlib: `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`,
  `Dimension.M𝓭`, `Dimension.C𝓭`, `Dimension.Θ𝓭`, `WithDim`, and
  `WithDim.val`.
- Mathlib: `Set.Icc`, `DifferentiableOn`, `derivWithin`, `Real.sqrt`,
  `Real.sqrt_pos_of_pos`, `Real.sqrt_eq_iff_mul_self_eq_of_pos`, and
  `constant_of_derivWithin_zero`.
- Imports used: `Mathlib` and `Physlib.Units.WithDim.Basic`.

## Local abstractions introduced

- The thermomagnetic dimensions not already named by Physlib were defined as
  compositions of its base dimensions.
- `ParamagneticTorusModel` is the smallest fixed-data object that retains all
  source parameters, including `V` and `n`, even though they cancel.
- `AdiabaticPathReadout` retains the physical quantities as dimension-tagged
  objects and exposes scalar readouts only for calculus.
- `IsAdiabaticQuasistaticChange` faithfully replaces missing dedicated
  paramagnetic-torus thermodynamics infrastructure with explicit equations and
  inequalities.
- `magnetothermalScaleSI` and `magnetothermalInvariantSI` are mathematical
  bridge quantities derived from the governing laws; neither encodes the
  current target.

## Grounding gaps

- Physlib has dimension-tagged quantities but no located ready-made API for
  this lumped paramagnetic-torus equation of state, heat-capacity law,
  first-law sign convention, or magnetic-work path law. These are therefore
  represented locally by explicit real equations on dimension-tagged
  readouts.
- `Physlib.Dimension` has no amount-of-substance base dimension. The model
  preserves `n` as a named molar scalar readout and documents how `K` and `λ`
  carry the remaining dimensions.
- `WithDim` records dimension but not a chosen unit system in its type. The
  process contract consistently interprets `.val` fields as one coherent SI
  readout system; no cross-unit conversion occurs inside the theorem.
- The `archon dag-query` helper advertised by the task prompt was not available
  on `PATH` in this lane. This did not block the independent formalization, and
  no sibling Lean output was imported.

## Verification

- LSP diagnostics: success, with only three `sorry` warnings.
- Shell check:
  `lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`
  exits successfully with exactly the same three warnings.

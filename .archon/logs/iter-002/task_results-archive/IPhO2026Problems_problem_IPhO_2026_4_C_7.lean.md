# IPhO2026Problems/problem_IPhO_2026_4_C_7.lean

Created the assigned file and verified it with:

```text
lake env lean IPhO2026Problems/problem_IPhO_2026_4_C_7.lean
```

The command exits successfully with exactly three expected `sorry` warnings
and no errors.

The blueprint contains `% archon:physics`, so the physics-formalize discipline
was used.  The assigned Lean file did not previously exist and contained no
file-specific `/- USER: ... -/` comments.

## Assumption/target split

### Governing laws

- `HeatResistanceLaw` carries the effective-resistance model.  It states that
  the SI readout `heatReceivedByInnerJoule` has derivative
  `inwardHeatFlowWatt`, that the resistance is positive, and that
  `P_in = (T_OC - T_IC) / R_Th`.
- `RadialFourierLaw` carries the local signed Fourier equation
  `P_out = -λ (2πrh) dT/dr`, the radial temperature derivative and both
  boundary temperatures.  Its field
  `outward_is_negative_inward` explicitly identifies
  `P_out = -P_in`.  Since the power readout depends on time but not radius,
  the contract also records the quasi-steady/no-radial-storage approximation.
- Positivity and geometric branch conditions needed for integration and
  cancellation are theorem hypotheses:
  `0 < r₁`, `r₁ < r₂`, `0 < h`, and `T_IC < T_OC`.

### Previous-part results

- `PreviousPartC6Readout` locally records the natural-language C.6 result
  `R_Th = 1.17 ± 0.03 K/W`.  No sibling Lean file is imported.

### Figure/data readouts

- `Figure17AndCProcedureReadout` records the Figure 17 inner bore diameter
  `33.7 ± 0.1 mm`, inner acrylic-wall thickness `3.4 ± 0.1 mm`, outer
  diameter `74.8 ± 0.1 mm`, and outer wall thickness `3.4 ± 0.1 mm`, all
  converted to meters.
- The same interface records the part-C water-height setpoints:
  `h_IC = 10 cm` and `h_OC = 15 cm`.  The conducting height is the wetted
  inner-cylinder height.
- `CylindricalConductionExperiment` preserves the IC/OC temperature
  histories, radial temperature profile and gradient, heat received by the
  inner cylinder, inward/outward heat-flow readouts, measured thermal
  resistance, and acrylic conductivity.

### Current target conclusions

- `radial_fourier_temperature_difference` concludes the integrated logarithmic
  temperature relation across the acrylic wall.
- `acrylic_conductivity_formula` concludes
  `λ = log(r₂/r₁) / (2π h R_Th)`.
- `official_sample_conductivity` concludes that the formula value rounds to
  `0.25 W/(m*K)` and that the explicitly propagated standard uncertainty
  rounds to `0.01 W/(m*K)`.

## Goal-faithfulness audit

The closed-form conductivity formula does not occur in
`HeatResistanceLaw`, `RadialFourierLaw`, `PreviousPartC6Readout`, or
`Figure17AndCProcedureReadout`.  The resistance law stops at the source
temperature-difference equation; the Fourier interface stops at a local
derivative equation plus boundary and orientation conditions.  Deriving the
logarithm, eliminating power, and cancelling the nonzero temperature
difference remain theorem obligations.

Neither `0.25` nor `0.01` occurs in any premise structure.  Both appear only
in the conclusion of `official_sample_conductivity`.  The helper
`conductivityStandardUncertainty` is the general first-order root-sum-square
calculation from the three input measurements; it is not a definition of
`acrylicConductivity`, and the numerical rounding claims remain nontrivial
inequalities.  `RoundsTo` transparently exposes those inequalities rather than
asserting an opaque reporting tag.

The geometry helper definitions merely convert the measured diameter and
thickness into radii and form the cylindrical area `2πrh`; none unfolds to the
requested conductivity relation.

## Derivability and bridge obligations

1. **Figure/procedure data to cylindrical geometry — covered.**
   Source claim: use Figure 17 and the C-procedure dimensions.  Lean carrier:
   `Figure17AndCProcedureReadout`, `innerRadiusMeter`,
   `outerRadiusMeter`, and `conductingHeightMeter`.  Evidence: the interface
   gives exact SI central values and all four stated Figure 17 uncertainties;
   the radius helpers implement `r₁=d/2`, `r₂=d/2+w`.

2. **Cylindrical geometry to local conduction area — covered.**
   Source claim: the area normal to radial conduction is `A(r)=2πrh`.  Lean
   carrier: `cylindricalWallAreaSquareMeter`.  Evidence: its definition is the
   exact area equation and is used in `RadialFourierLaw.signed_fourier_equation`.

3. **Recorded heat versus heat-flow rate — covered.**
   Source claim: `dQ_in/dt` is the inward heat-flow rate.  Lean carrier:
   `HeatResistanceLaw.heat_rate_is_derivative`.  Evidence: it is an explicit
   `HasDerivAt` statement for the joule and watt SI readouts.

4. **Temperature difference to effective-resistance power — covered.**
   Source claim: `dQ_in/dt = (T_OC-T_IC)/R_Th`.  Lean carrier:
   `HeatResistanceLaw.power_from_temperature_difference`.  Evidence: the
   source equation is present verbatim up to the declared inward sign
   convention.

5. **Signed source Fourier law and orientation — covered.**
   Source claim: `dQ_out/dt = -λ A dT/dr`, while heat enters the inner
   cylinder.  Lean carrier:
   `RadialFourierLaw.signed_fourier_equation` and
   `outward_is_negative_inward`.  Evidence: these fields expose the local
   equation and `P_out=-P_in`; the boundary fields select IC at `r₁` and OC at
   `r₂`.

6. **Local Fourier law to the logarithmic wall relation — covered at
   statement level.**  Lean carrier:
   `radial_fourier_temperature_difference`.  Grounded mathematical support:
   `Real.hasDerivAt_log` supplies `d(log r)/dr=1/r`, and
   `constant_of_derivWithin_zero` supplies the equal-derivatives-to-endpoint
   bridge on an interval.  The carrier has a `by sorry` body at this
   autoformalize stage.

7. **Integrated Fourier relation plus resistance law to conductivity —
   covered at statement level.**  Lean carrier:
   `acrylic_conductivity_formula`.  Evidence: positivity of `R_Th`, `λ`,
   radii, and height discharges denominators, while `T_IC<T_OC` supplies the
   nonzero temperature difference needed to eliminate heat power.  The
   carrier has a `by sorry` body.

8. **Input uncertainties to conductivity uncertainty — covered.**
   Source claim: propagate the `±0.1 mm`, `±0.1 mm`, and `±0.03 K/W`
   uncertainties.  Lean carrier: `conductivityStandardUncertainty`.  Evidence:
   it evaluates the three analytic sensitivities with respect to bore
   diameter, wall thickness, and resistance and combines their contributions
   by `Real.sqrt` of the sum of squares.  Substitution gives approximately
   `0.00931 W/(m*K)`.

9. **Exact formula and propagated uncertainty to the printed sample —
   covered at statement level.**  Lean carrier:
   `official_sample_conductivity`.  Evidence: `RoundsTo` requires explicit
   absolute-error inequalities at the `0.01` reporting step, yielding
   `0.25 ± 0.01 W/(m*K)`.  The carrier has a `by sorry` body.

All substantive target bridges are present as equations, inequalities, or
named theorem contracts.  None is blocked by a missing interface.

## Abstraction sufficiency and countermodel audit

- `Figure17AndCProcedureReadout` is a local `Prop`-valued interface constrained
  by ten exact numerical equalities: four central dimensions, four
  uncertainties, and two water-height setpoints.
- `PreviousPartC6Readout` is constrained by the two exact equalities
  `R_Th=1.17` and `u(R_Th)=0.03`.
- `HeatResistanceLaw` is constrained by a positivity inequality, a derivative
  statement, and the full effective-resistance heat-flow equation.
- `RadialFourierLaw` is constrained by positivity, an orientation equality,
  two boundary equalities, the radial `HasDerivAt` field, and the full local
  signed Fourier equation at every radius in the wall.
- `RoundsTo` is transparent and unfolds to a positive reporting step and an
  absolute-value inequality.

Countermodel check: with positive ordered radii and height,
`RadialFourierLaw` fixes the derivative of the radial temperature profile to
the `1/r` profile determined by `P_in/λ`; its two boundary values therefore
fix the integrated temperature difference.  `HeatResistanceLaw` independently
fixes the same nonzero power through `R_Th`.  The hotter-outer-cylinder
hypothesis prevents the cancellation factor from vanishing.  Consequently,
one cannot choose an arbitrary conductivity while satisfying all assumptions
and falsifying `acrylic_conductivity_formula`.

The numerical report is likewise constrained: all inputs to
`conductivityStandardUncertainty` are fixed by the figure and previous-part
readouts, and `RoundsTo` exposes checkable real inequalities.

## Uncertainty and branch coverage

- **Figure uncertainty: covered.**  Both acrylic-wall-relevant inputs retain
  their `±0.1 mm` uncertainties.  The otherwise-unused outer-cylinder
  diameter and wall-thickness uncertainties are also preserved because they
  belong to Figure 17.
- **Thermal-resistance uncertainty: covered.**  The C.6 input retains
  `±0.03 K/W`.
- **Output uncertainty: covered.**  The contract uses first-order independent
  root-sum-square propagation, not an unrelated fixed tolerance.  Its value is
  approximately `0.00931 W/(m*K)` and the target separately proves that this
  rounds to the reported `0.01`.
- **Height uncertainty: genuinely not applicable to the provided source.**
  The problem gives `10 cm` as a procedure setpoint but reports no uncertainty
  for it, so no invented height-error term is included.
- **Orientation/branch: covered.**  Inward and positive-radial outward powers
  are distinct fields tied by `P_out=-P_in`; IC and OC are attached to the
  inner and outer radial boundaries; `T_IC<T_OC` selects the experimental
  heating branch; and `0<r₁<r₂`, `0<h` select the positive logarithmic
  geometry branch.

## Declarations created and blueprint labels

All declarations support
`thm:physics:IPhO_2026_4_C_7:target`.

- Dimension/type vocabulary:
  `energyDimension`, `heatFlowRateDimension`,
  `thermalResistanceDimension`, `thermalConductivityDimension`,
  `LengthQuantity`, `EnergyQuantity`, `HeatFlowRateQuantity`,
  `ThermalResistanceQuantity`, `ThermalConductivityQuantity`, and
  `ExperimentalMeasurement`.
- Geometry/data vocabulary:
  `CylindricalWallGeometry`, `innerRadiusMeter`, `outerRadiusMeter`,
  `conductingHeightMeter`, `cylindricalWallAreaSquareMeter`,
  `Figure17AndCProcedureReadout`, and
  `CylindricalConductionExperiment`.
- Assumption interfaces:
  `PreviousPartC6Readout`, `HeatResistanceLaw`, and `RadialFourierLaw`.
- Bridge and target declarations:
  `radial_fourier_temperature_difference`,
  `acrylic_conductivity_formula`, `conductivityStandardUncertainty`,
  `RoundsTo`, and `official_sample_conductivity`.

The chapter currently has a generic autoformalization environment but no
`\lean{...}` name.  The recommended primary statement link is:

```text
\lean{IPhO2026Problems.IPhO2026_4_C_7.acrylic_conductivity_formula}
```

The numerical companion is:

```text
\lean{IPhO2026Problems.IPhO2026_4_C_7.official_sample_conductivity}
```

Both theorem statements are ready for statement-level `\leanok`
synchronization.  Per `.archon/AGENTS.md`, the prover did not edit the
blueprint; marker management belongs to the deterministic synchronization
phase.

## LeanExplore queries/candidates actually used

All searches passed `packages: ["Mathlib", "Physlib"]`.

- Query:
  `physical quantity with units dimensions SI unit thermal conductivity thermal resistance temperature heat flow`
  - Candidates inspected: `UnitChoices.SI`, `Dimension`,
    `TemperatureUnit`, and `UnitChoices.SI_temperature`.
- Query:
  `Quantity value in units physical dimension Dimensionful unit choice`
  - Candidates inspected: `Dimensionful`, `CarriesDimension.toDimensionful`,
    `WithDim.scaleUnit_val`, and `UnitChoices.dimScale`.
- Query:
  `WithDim definition physical quantity tagged by Dimension value`
  - Candidates inspected: `WithDim`, `WithDim.val_add`,
    `WithDim.val_div_val`, and `WithDim.val_pow_two_eq_mul`.
- Queries:
  `Dimension.length physical length time mass energy power predefined dimension definitions`
  and `Dimension.M𝓭 Θ𝓭 temperature dimension constant`
  - Candidates used: `Dimension.L𝓭`, `Dimension.T𝓭`,
    `Dimension.M𝓭`, and `Dimension.Θ𝓭`.
- Query:
  `DimPower DimThermalConductivity DimResistance dimensional power energy units`
  - Candidate inspected: `DimEnergy`; no ready-made power, thermal
    resistance, or thermal-conductivity quantity was returned.
- Query:
  `Fourier law radial heat conduction cylindrical wall thermal resistance conductivity`
  - No relevant heat-conduction law was returned; the Fourier-transform and
    radial-measure hits were semantic near misses.
- Query:
  `HasDerivAt real logarithm derivative 1/x`
  - Candidates used: `Real.hasDerivAt_log` and
    `Real.hasStrictDerivAt_log_of_pos`.
- Queries:
  `two real functions with equal derivatives on interval differ by constant HasDerivAt eq_of`
  and `derivative zero on interval function constant HasDerivAt interval`
  - Candidates used: `constant_of_derivWithin_zero`; the more general
    `IsOpen.exists_eq_add_of_deriv_eq` was inspected as a near alternative.

Source and module details were fetched for `Dimension`
(`Physlib.Units.Dimension`), `Dimensionful`
(`Physlib.Units.Basic`), `WithDim` and its value lemmas
(`Physlib.Units.WithDim.Basic`), `DimEnergy`
(`Physlib.Units.WithDim.Energy`), `UnitChoices.SI`
(`Physlib.Units.Basic`), `Real.hasDerivAt_log`
(`Mathlib.Analysis.SpecialFunctions.Log.Deriv`), and
`constant_of_derivWithin_zero`
(`Mathlib.Analysis.Calculus.MeanValue`).

## PhysLean/Mathlib names grounded

- Physlib: `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`,
  `Dimension.M𝓭`, `Dimension.Θ𝓭`, and `WithDim` are used directly.
  `WithDim` supplies a library-backed physical-dimension wrapper instead of a
  transparent scalar alias.
- Mathlib: `HasDerivAt`, `Real.log`, `Real.pi`, `Real.sqrt`, real absolute
  value, `Real.hasDerivAt_log`, and
  `constant_of_derivWithin_zero` ground the calculus and numerical contracts.

## Local abstractions introduced

- `ExperimentalMeasurement d` adds central value, same-dimension standard
  uncertainty, and nonnegativity to Physlib's `WithDim d ℝ`, because neither
  Mathlib nor the located Physlib units API supplies an experimental
  uncertainty record.
- `CylindricalWallGeometry` is a multi-quantity apparatus record, not a scalar
  wrapper.  It preserves both cylinders' Figure 17 dimensions even though
  only the inner acrylic wall enters the final expression.
- `CylindricalConductionExperiment` keeps distinct physical roles for IC/OC
  temperatures, radial profile/gradient, energy, signed heat-flow directions,
  resistance, and conductivity.  Real-valued functions are explicitly named
  as SI readouts so calculus can use Mathlib's real `HasDerivAt`.
- The three local law/data structures expose their physical content as
  equations, inequalities, derivatives, and boundary conditions; none is an
  unconstrained opaque predicate.

## Grounding gaps and redraft requests

- **Thermal-conduction API gap:** LeanExplore found no Mathlib/Physlib
  declaration for radial Fourier heat conduction or cylindrical thermal
  resistance.  `HeatResistanceLaw` and `RadialFourierLaw` are faithful local
  interfaces filling this gap.
- **Specialized unit-type gap:** Physlib supplies the foundational dimension
  algebra and `WithDim`, but the search returned no ready-made power,
  thermal-resistance, or thermal-conductivity quantity.  These roles are
  represented as `WithDim` at explicitly constructed dimensions.
- **Height-uncertainty source gap:** no uncertainty accompanies the 10 cm
  height setpoint, so the propagation contract does not invent one.
- **Blueprint link gap:** the generic theorem environment has no declaration
  name.  A future plan/review pass should add the recommended `\lean{...}`
  links above; the prover did not edit the protected blueprint domain.
- **Dependency navigation tooling gap:** the prompt said `archon` was on
  `PATH`, but `archon dag-query ...` failed with `archon: command not found`.
  No dependency was required because C.6 is explicitly a natural-language
  prerequisite only.

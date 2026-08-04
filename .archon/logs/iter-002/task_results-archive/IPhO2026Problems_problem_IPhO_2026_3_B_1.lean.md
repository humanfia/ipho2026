# IPhO2026Problems/problem_IPhO_2026_3_B_1.lean

## Result

- Verified the assigned physics formalization for IPhO 2026 Problem 3 B.1.
  The file was already populated when this lane started and required no
  semantic changes.
- The blueprint contains `% archon:physics`, so the physics-formalize
  discipline was applied.
- The assigned file contains no `/- USER: ... -/` file-specific hint.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_1.lean` succeeds.
  Its only diagnostics are the four expected `declaration uses sorry`
  warnings for the three bridge theorems and the main target.

## Extracted physical model

### Named quantities and roles

- `fixedTemperature` is the constant absolute temperature `T`, represented by
  Physlib's nonnegative `Temperature` type and assumed strictly positive in
  the theorems that divide by its real readout.
- `initialFieldStrength` and `finalFieldStrength` are the magnitudes `H_i` and
  `H_f`, in amperes per metre. They are nonnegative in the main theorem.
- `fieldStrengthAmperePerMetre` and
  `magnetizationAmperePerMetre` are the scalar magnitude readouts `H` and `M`.
- `volumeCubicMetres` is the fixed torus volume `V`, and `amountMoles` is the
  material amount `n`.
- `materialK_SI` and `materialLambda_SI` are calibrated SI readouts of the
  material constants `K` and `lambda`.
- `vacuumPermeability_SI` is the SI readout of `mu_0`.
- `heatCapacityAtConstantMagnetization` is `C_M`, in joules per kelvin.
- `internalEnergy`, `workEntering`, and `heatEntering` are dimensionful
  `DimEnergy` curves. Their derivative fields are explicitly joule readouts.
- The process parameter is dimensionless, with the physical incoming state at
  `s = 0` and outgoing state at `s = 1`.

### Dimensions and scalar readouts

- Energy is not collapsed to a real alias: it is carried by Physlib's
  dimensionful `DimEnergy`.
- `energyInJoules` evaluates a `DimEnergy` in `UnitChoices.SI` and projects its
  scalar coordinate.
- Temperature is kept as `Temperature`.
- Volume, amount, `H` magnitude, `M` magnitude, heat capacity, rates, and
  material constants are explicitly named SI-coordinate readouts. This is
  appropriate for measured scalar components and numeric coordinates and does
  not introduce a transparent physical-quantity alias.
- The dimensional roles of `K` and `lambda` are documented through
  `T * M * V = n * K * H` and `C_M = n * lambda / T^2`.

### Geometry and official-page readouts

- The object is a paramagnetic torus with fixed positive volume.
- The official B.1 box states that the magnitude of the magnetic field changes
  from `H_i` to `H_f` at constant `T`.
- Figure 3b on the same page belongs to the later Carnot-cycle questions and
  supplies no geometry or labels needed for B.1. It was therefore not imported
  into this theorem.
- The source contains no uncertainty, error bar, or tolerance data.

## Assumption/target split

### Governing laws

- `isothermal` states that the temperature curve is constantly
  `fixedTemperature`.
- `prescribedFieldSweep` gives an oriented linear parametrization from `H_i`
  at `s = 0` to `H_f` at `s = 1`.
- The six `HasDerivAt` fields tie all named rate readouts to the corresponding
  physical curves.
- `equationOfState` states `T * M * V = n * K * H`.
- `heatCapacityLaw` states `C_M = n * lambda / T^2`.
- `internalEnergyDifferentialLaw` states `dU/ds = C_M * dT/ds`.
- `firstLawSignConvention` states
  `dU/ds = dQ_in/ds + dW_in/ds`, encoding the convention that heat and work
  entering the torus are positive.

### Previous-part results

- `magneticWorkLaw` records the allowed natural-language result of A.3:
  `dW_in/ds = mu_0 * V * H * dM/ds`.
- No sibling Lean file is imported, so the formalization respects the
  natural-language-prerequisite-only policy.

### Figure/data readouts

- `initialFieldStrength` and `finalFieldStrength` are the labeled endpoint
  magnitudes `H_i` and `H_f`.
- `fixedTemperature` is the labeled constant temperature `T`.
- The fixed torus data retain `V`, `n`, `K`, and `lambda`, even though `V`
  and `lambda` cancel or do not contribute to the final isothermal formula.
- Positivity/nonnegativity fields preserve the physical meanings of volume,
  amount, material constants, absolute temperature, permeability, and field
  magnitudes.

### Current target conclusions

- `internalEnergyRate_eq_zero` concludes that the internal-energy rate
  vanishes on the isothermal sweep.
- `magnetizationRate_eq` concludes the magnetization rate forced by the
  equation of state and oriented field sweep.
- `heatRate_eq` concludes the instantaneous heat-input rate.
- `heat_transferred_into_torus` concludes exactly
  `Q_in = -(mu_0 * n * K / (2 * T)) * (H_f^2 - H_i^2)`.

## Goal-faithfulness audit

The requested finite heat formula occurs only in the conclusion of
`heat_transferred_into_torus`. It is absent from
`ParamagneticTorus`, `IsothermalFieldSweep`,
`SatisfiesIsothermalParamagneticTorusLaws`, and every hypothesis.

`energyInJoules` is only an SI-coordinate projection, and
`netHeatEnteringInJoules` is only the endpoint difference of the accumulated
heat curve. Neither definition contains the requested closed form. The linear
field parametrization fixes a convenient oriented path between the stated
endpoints but imposes no heat value.

The three helper formulas are theorem conclusions with their own proof
obligations, not premise fields. Thus none of them makes the main theorem true
by unfolding or reflexivity. The assumptions remain at the level of source
data, differential laws, derivative witnesses, and the permitted previous-part
work law.

## Derivability and bridge obligations

1. **Dimensionful energy to real calculus**
   - Source claim: `U`, `W`, `Q`, and their finite changes are energies, while
     the calculus is performed in coherent SI coordinates.
   - Lean carrier: `DimEnergy`, `UnitChoices.SI`, `energyInJoules`, and the
     derivative fields of `SatisfiesIsothermalParamagneticTorusLaws`.
   - Evidence: `DimEnergy` is Physlib's energy-dimensional quantity and
     `UnitChoices.SI` selects metre-second-kilogram-coulomb-kelvin units.
   - Status: **covered**.

2. **Constant temperature gives zero internal-energy rate**
   - Source claim: fixed `T` implies `dT/ds = 0`, and
     `dU = C_M dT` then implies `dU/ds = 0`.
   - Lean carrier: `isothermal`, `temperatureHasDerivative`,
     `internalEnergyDifferentialLaw`, Mathlib's constant derivative and
     `HasDerivAt.unique`, and `internalEnergyRate_eq_zero`.
   - Evidence: the named derivative rate is tied to the actual constant
     temperature curve before the differential energy law is applied.
   - Status: **covered** at the theorem-contract level; proof is intentionally
     deferred with `sorry`.

3. **Equation of state determines the magnetization rate**
   - Source claim: at constant positive `T` and fixed positive `V`,
     `M = n K H / (T V)`.
   - Lean carrier: `equationOfState`, `isothermal`,
     `prescribedFieldSweep`, `magnetizationHasDerivative`,
     `fieldStrengthHasDerivative`, positivity of `T` and `V`, Mathlib
     derivative uniqueness, and `magnetizationRate_eq`.
   - Mathematical consequence:
     `M' = n K (H_f - H_i) / (T V)`.
   - Status: **covered** at the theorem-contract level.

4. **Magnetic work and first law determine the heat rate**
   - Source claim: `dW_in = mu_0 V H dM`, `dU = 0`, and
     `dU = dQ_in + dW_in`.
   - Lean carrier: `magneticWorkLaw`, `firstLawSignConvention`,
     `internalEnergyRate_eq_zero`, `magnetizationRate_eq`, and `heatRate_eq`.
   - Mathematical consequence:
     `Q'_in = -(mu_0 n K / T) H (H_f - H_i)`.
   - Status: **covered** at the theorem-contract level.

5. **Instantaneous heat rate determines finite heat**
   - Source claim: the accumulated heat change is the integral of its rate
     along the sweep.
   - Lean carrier: `heatHasDerivative`, `heatRate_eq`,
     `prescribedFieldSweep`, and Mathlib
     `intervalIntegral.integral_unitInterval_deriv_eq_sub`.
   - Evidence: after substitution, the rate is a continuous affine function of
     `s`, so the unit-interval fundamental theorem applies to
     `energyInJoules (process.heatEntering s)`.
   - Status: **covered**; no additional physical premise is missing.

6. **Evaluate the affine-field integral**
   - Source claim:
     `integral_0^1 (H_i + s (H_f-H_i))(H_f-H_i) ds
       = (H_f^2-H_i^2)/2`.
   - Lean carrier: `prescribedFieldSweep`, Mathlib's real polynomial
     integration/algebra support, and the endpoint definition
     `netHeatEnteringInJoules`.
   - Status: **covered** as an ordinary real-calculus/algebra bridge.

7. **Requested signed heat formula**
   - Source claim:
     `Q_in = -(mu_0 n K/(2T))(H_f^2-H_i^2)`.
   - Lean carrier:
     `IPhO2026Problems.ProblemIPhO2026_3_B_1.heat_transferred_into_torus`.
   - Evidence: this main theorem contract combines bridges 1--6 and retains
     every source parameter and sign/orientation condition.
   - Status: **covered** at the autoformalization level; its proof body is
     `sorry` as required for this stage.

## Abstraction sufficiency and countermodel audit

### `SatisfiesIsothermalParamagneticTorusLaws`

This is the only local `Prop`-valued physical interface. It is constraining
because it exposes:

- explicit constant-temperature and affine-field equations;
- six `HasDerivAt` statements linking rate readouts to physical curves;
- the equation of state;
- the heat-capacity equation;
- the internal-energy differential equation;
- the magnetic-work differential equation; and
- the signed first-law equation.

It is not an opaque tag and does not merely assert witness existence.

### Countermodel sanity check

Since `T > 0` and `V > 0`, the equation of state fixes `M(s)` from the
independently prescribed `H(s)`. The derivative witnesses prevent the named
rates from being interpreted independently of their curves. Isothermality and
the internal-energy law force `U' = 0`; the magnetic-work law and first law
then force the heat rate. Finally, `heatHasDerivative` holds throughout the
unit sweep, so the accumulated heat curve can vary only by an additive
constant, which cancels in `netHeatEnteringInJoules`.

Consequently, the fields cannot all be interpreted arbitrarily while the
premises remain true and the requested endpoint heat formula becomes false.
The contract is not underdetermined.

## Uncertainty and branch coverage

- **Uncertainty: not applicable.** Neither the blueprint nor the official
  source page reports `value +/- uncertainty`, error bars, or tolerances.
- **Initial/final orientation: covered.** The physical path runs from `s = 0`
  to `s = 1`, and the affine sweep sends these endpoints to `H_i` and `H_f`.
- **Increasing/decreasing field branch: covered.** The signed factor
  `H_f - H_i` is retained throughout; the same theorem handles either
  orientation.
- **Magnitude branch: covered.** The main theorem requires both `H_i` and
  `H_f` to be nonnegative, matching the source's use of field magnitude.
- **Temperature/division branch: covered.** Strict positive temperature
  selects a physically valid absolute temperature and justifies division by
  `T`.
- **Heat/work sign convention: covered.** Both incoming contributions appear
  with plus signs in the first law, so the negative heat for increasing field
  is derived rather than stipulated.
- **Vector-direction branch: not applicable.** B.1 asks only for the magnitude
  of the field; no spatial direction or clockwise/counterclockwise choice is
  involved.

## Declarations created and blueprint correspondence

- SI projection and endpoint readout:
  `energyInJoules`, `netHeatEnteringInJoules`.
- Physical data structures:
  `ParamagneticTorus`, `IsothermalFieldSweep`.
- Governing-law interface:
  `SatisfiesIsothermalParamagneticTorusLaws`.
- Bridge theorems:
  `internalEnergyRate_eq_zero`, `magnetizationRate_eq`, `heatRate_eq`.
- Main theorem:
  `IPhO2026Problems.ProblemIPhO2026_3_B_1.heat_transferred_into_torus`.
- All declarations correspond to blueprint label
  `thm:physics:IPhO_2026_3_B_1:target`, with
  `heat_transferred_into_torus` as the principal current-subquestion
  declaration.
- The target environment is ready for statement-level `\leanok`. The
  blueprint was not edited because the prover write permissions forbid
  blueprint edits and `.archon/AGENTS.md` assigns routine `\leanok` updates to
  the deterministic sync phase.

## LeanExplore queries/candidates actually used

1. Query: `physical absolute temperature SI value Temperature Physlib`
   - Selected and inspected `Temperature`, `Temperature.toReal`, and
     `UnitChoices.SI`.
   - Confirmed that `Temperature` wraps a nonnegative real absolute
     temperature.

2. Query:
   `dimensionful physical energy SI coordinate DimEnergy WithDim energy units Physlib`
   and exact-name query `DimEnergy`
   - Selected and inspected `DimEnergy` and `UnitChoices.SI`.
   - Confirmed that `DimEnergy` is a `Dimensionful` quantity with energy
     dimension.

3. Query: `HasDerivAt derivative at a point real function`
   - Selected and inspected Mathlib's `HasDerivAt`, used by all rate-linking
     fields.

4. Query:
   `HasDerivAt unique derivative if function equality derivative compare`
   - Selected and inspected `HasDerivAt.unique` as the derivative-readout
     uniqueness carrier.

5. Query:
   `fundamental theorem calculus derivative everywhere endpoint difference interval integral HasDerivAt`
   - Selected and inspected
     `intervalIntegral.integral_unitInterval_deriv_eq_sub` as the
     derivative-to-endpoint bridge.

6. Query:
   `physical magnetic field strength magnetization permeability SI units Physlib`
   - Inspected `Electromagnetism.MagneticField`.
   - Rejected it as a near miss because it is a spacetime-dependent vector
     magnetic field, not the scalar magnitude of `H` or `M` requested here.

7. Query:
   `heat capacity amount of substance mole volume physical quantity Physlib`
   - Inspected `CanonicalEnsemble.heatCapacity`.
   - Rejected it as a near miss because it defines canonical-ensemble heat
     capacity at constant volume `C_V`, not the supplied constant-
     magnetization law `C_M`.

## Physlib/Mathlib names grounded

- Physlib:
  `Temperature`, `Temperature.toReal`, `DimEnergy`, `Dimensionful`,
  `UnitChoices.SI`.
- Mathlib:
  `HasDerivAt`, `HasDerivAt.unique`,
  `intervalIntegral.integral_unitInterval_deriv_eq_sub`, and ordinary real
  arithmetic/polynomial calculus.

## Local abstractions introduced

- `energyInJoules` is the smallest conversion needed to apply real calculus to
  a dimensionful energy curve.
- `ParamagneticTorus` preserves geometry, material amount, calibrated
  constants, and their sign constraints.
- `IsothermalFieldSweep` preserves temperature, field and magnetization
  magnitudes, heat capacity, dimensionful energy curves, and explicit
  derivative readouts.
- `SatisfiesIsothermalParamagneticTorusLaws` exposes every physical law as a
  usable equation or derivative statement.
- `netHeatEnteringInJoules` names the signed finite heat entering the torus as
  an endpoint energy difference; it does not encode the answer.

These abstractions use real numbers only for explicitly named SI-coordinate
readouts and measured scalar magnitudes. They do not replace energy or
temperature with transparent scalar aliases.

## Grounding gaps

- Physlib provides no directly matching paramagnetic-torus process interface,
  scalar magnetic-field-strength magnitude type, magnetization-magnitude type,
  or constant-magnetization heat-capacity law found by the searches above.
  The local readout and governing-law interfaces faithfully cover those gaps.
- `Electromagnetism.MagneticField` and
  `CanonicalEnsemble.heatCapacity` are semantically incompatible near misses,
  so they were not forced into the model.
- No bridge is blocked and no blueprint redraft is requested.

# Autoformalization result: IPhO 2026 Problem 1 C.2

## Status

- Created `IPhO2026Problems/problem_IPhO_2026_1_C_2.lean`.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_2.lean` exits
  successfully.
- The only diagnostic is the expected `declaration uses sorry` warning on
  `threshold_excess_energy_rounds_to_official_value`.
- The assigned file did not previously exist, so it contained no
  `/- USER: ... -/` comments.
- The chapter contains `% archon:physics`; the physics-formalize discipline was
  therefore used.

## Assumption/target split

### Governing laws

- `ClassicalPhotodissociationLaws.energy_gap_definition` states
  `ΔU = U_f - U_i`.
- `threshold_photon_energy` states the photon law `E_γ = ℏ ω_min`.
- `photon_momentum_magnitude` states `|p_γ| = E_γ/c`, using Physlib's
  dimensionful speed of light.
- `ozone_initially_at_rest` and `momentum_conservation` state that the initial
  O₃ momentum is zero and that the isolated process conserves momentum.
- `nonrelativistic_energy_conservation` states
  `E_γ = ΔU + |p_{O₂}|²/(4m) + |p_O|²/(2m)`, so the O₂ and O masses are
  respectively `2m` and `m`.
- Positivity and nonnegativity fields retain the physical domains of `m`,
  `ℏ`, and `ω_min`.

### Previous-part results

- `PreviousPartC1Threshold.threshold_balance` records the reusable C.1
  threshold as the minimized energy quadratic
  `E = ΔU + E²(1 + 2 sin² θ_eff)/(6mc²)`.
- `lower_root_selection` selects the smaller physical root rather than the
  second, enormous quadratic root.
- `effectiveThresholdAngle θ = min θ (π/2)` preserves C.1's separate
  forward/backward branch rule without importing the sibling Lean file.

### Figure/data readouts

- `SourceFigure.fig1c` and `source_is_figure_1c` retain the figure label.
- The setup contains distinct dimensionful momenta for the incident photon,
  initial O₃, outgoing O₂, and outgoing O.
- The incident photon is constrained to the positive x direction.
- The outgoing O₂ component equations use `cos θ` and `sin θ`, retaining the
  counterclockwise, above-axis orientation drawn in Fig. 1c.
- The current numerical readouts are
  `θ = π/6`, `ΔU = 1.10 eV`, and `m = 16.0 amu`.
- `atomicMassUnit` uses `1.66053906660e-27 kg`;
  `DimEnergy.electronVolt` and `DimSpeed.speedOfLight` provide the eV and
  exact-light-speed conversions.

### Current target conclusions

- `ℏ ω_min - ΔU`, expressed in electronvolts by
  `requestedExcessEnergyInElectronVolts`, lies within
  `5 × 10⁻¹⁴ eV` of `2.03 × 10⁻¹¹ eV`.
- This interval says precisely that the calculated value rounds to the
  official three-significant-figure answer.

## Goal-faithfulness audit

The current numerical conclusion does not occur in
`ClassicalPhotodissociationLaws`, `PreviousPartC1Threshold`, any hypothesis, or
any helper definition. The governing-law interface contains only generic
energy, momentum, photon, positivity, and Figure 1c relations. The previous-part
interface contains the angle-dependent C.1 threshold quadratic and its physical
root selection, not the C.2 decimal answer.

`requestedExcessEnergyInElectronVolts` merely names the source expression
`ℏω_min - ΔU` with explicit unit conversion. It contains neither `2.03e-11` nor
the rounding radius. The answer and its rounding accuracy appear only in the
main theorem conclusion.

The theorem uses a rounding interval instead of false exact equality: direct
evaluation gives approximately `2.0296693 × 10⁻¹¹ eV`, which is not definitionally
or mathematically equal to the printed rounded decimal.

## Derivability and bridge obligations

1. **Source claim:** the physical objects have distinct energy, mass, action,
   frequency, and momentum roles.
   **Lean carrier:** `DimEnergy`, `DimMass`, `DimAction`,
   `DimAngularFrequency`, and `DimMomentum`.
   **Evidence:** all are built from Physlib's `Dimensionful (WithDim d M)` with
   the corresponding physical dimension.
   **Status:** covered (grounded in Physlib plus dimension-preserving local
   aliases).

2. **Source claim:** `ΔU = U_f - U_i`.
   **Lean carrier:** `ClassicalPhotodissociationLaws.energy_gap_definition`.
   **Evidence:** an explicit equality of SI energy readouts.
   **Status:** covered (encoded locally).

3. **Source claim:** `E_γ = ℏω_min` and `p_γ = E_γ/c`.
   **Lean carrier:** `threshold_photon_energy` and
   `photon_momentum_magnitude`.
   **Evidence:** explicit SI equations using the dimensionful quantities and
   `DimSpeed.speedOfLight`.
   **Status:** covered (encoded locally and grounded constant).

4. **Source claim:** Fig. 1c fixes the incident direction and the outgoing O₂
   angle.
   **Lean carrier:** `incident_photon_along_positive_x`,
   `incident_photon_zero_y`, `outgoing_oxygen_molecule_x`, and
   `outgoing_oxygen_molecule_y`.
   **Evidence:** component equalities with norm, sine, and cosine fix the
   signed branch.
   **Status:** covered (encoded locally).

5. **Source claim:** isolation and nonrelativistic fragment dynamics yield the
   threshold kinetic-energy balance.
   **Lean carrier:** `momentum_conservation`,
   `nonrelativistic_energy_conservation`, and the reusable
   `PreviousPartC1Threshold.threshold_balance`.
   **Evidence:** the vector and scalar equations expose every elimination
   quantity, including the `2m` O₂ mass.
   **Status:** covered at the contract level; a later proof must perform the
   minimization/elimination.

6. **Source claim:** for `θ ≥ π/2`, use the `π/2` threshold.
   **Lean carrier:** `effectiveThresholdAngle`.
   **Evidence:** the concrete expression `min θ (π/2)` occurs inside the
   threshold balance.
   **Status:** covered.

7. **Source claim:** the threshold is the lower quadratic root.
   **Lean carrier:** `PreviousPartC1Threshold.lower_root_selection`.
   **Evidence:** the inequality places the threshold at or below the
   quadratic's midpoint and excludes the high-energy root.
   **Status:** covered (encoded locally).

8. **Source claim:** `m = 16.0 amu` determines `mc²` in eV.
   **Lean carrier:** `atomicMassUnit`, `massInAtomicMassUnits`,
   `restEnergyInElectronVolts`, `DimEnergy.electronVolt`, and
   `DimSpeed.speedOfLight`.
   **Evidence:** explicit kg, J, and eV conversion equations/definitions.
   **Status:** covered; the later proof must normalize the scientific
   numerals.

9. **Source claim:** the exact threshold excess rounds to
   `2.03 × 10⁻¹¹ eV`.
   **Lean carrier:** the main theorem contract
   `threshold_excess_energy_rounds_to_official_value`.
   **Evidence:** the conclusion is an explicit absolute-error inequality with
   half-last-place radius `5 × 10⁻¹⁴ eV`.
   **Status:** covered at the statement level; the numeric inequality remains
   the intended `sorry` proof obligation.

## Abstraction sufficiency and countermodel audit

- `ClassicalPhotodissociationLaws` is the first local `Prop`-valued interface.
  It exposes positivity, the energy-gap definition, `E = ℏω`, `p = E/c`,
  zero initial momentum, vector momentum conservation, both signed angle
  component equations, and the full nonrelativistic energy equation. It cannot
  be interpreted as an arbitrary witness relation.
- `PreviousPartC1Threshold` is the second local `Prop`-valued interface. It
  exposes nonnegativity, the exact minimized quadratic threshold equation, and
  a root-selection inequality. In particular, it does not permit an arbitrary
  threshold energy satisfying no mathematical constraint.
- `OzonePhotodissociation` is data-valued, not `Prop`-valued. Its distinct
  fields prevent the photon and fragment momenta or the three energy roles from
  being collapsed into one scalar placeholder.

A countermodel cannot freely change `ω_min` or the threshold energy while
retaining all assumptions: the photon-energy equality links them, the C.1
balance fixes the two algebraic candidates, and the lower-root inequality
selects the physical candidate. The numerical readouts then determine the C.2
excess, leaving only real-number evaluation and rounding.

## Uncertainty and branch coverage

- **Uncertainty:** genuinely not applicable. The source gives central input
  values but no `value ± uncertainty` data.
- **Rounding:** covered. The result is an interval of half a unit in the last
  printed place, not an exact equality and not an invented measurement
  uncertainty.
- **Angle branch:** covered by `effectiveThresholdAngle`, the hypotheses
  `0 ≤ θ ≤ π`, and the C.2 specialization `θ = π/6`.
- **Orientation branch:** covered by the positive-x photon equations and the
  signed O₂ sine/cosine component equations, matching the above-axis branch in
  Fig. 1c.
- **Quadratic-root branch:** covered by `lower_root_selection`.

## Declarations created and blueprint correspondence

All declarations are in namespace `IPhO2026_1_C_2`.

- Dimension-preserving aliases and readouts:
  `DimMass`, `DimAngularFrequency`, `DimAction`, `DimMomentum`,
  `atomicMassUnit`, `energySI`, `massSI`, `angularFrequencySI`, `actionSI`,
  `momentumSI`, `energyInElectronVolts`, `massInAtomicMassUnits`, and
  `restEnergyInElectronVolts`.
- Physical/figure data:
  `SourceFigure` and `OzonePhotodissociation`.
- Constraining interfaces:
  `ClassicalPhotodissociationLaws` and `PreviousPartC1Threshold`.
- Branch/formula helpers:
  `effectiveThresholdAngle`, `thresholdShapeFactor`, and
  `requestedExcessEnergyInElectronVolts`.
- Main declaration:
  `IPhO2026_1_C_2.threshold_excess_energy_rounds_to_official_value`.

The main theorem corresponds to
`thm:physics:IPhO_2026_1_C_2:target`. The blueprint environment currently lacks
a `\lean{...}` name, so the plan/review machinery should add
`\lean{IPhO2026_1_C_2.threshold_excess_energy_rounds_to_official_value}` before
expecting deterministic `\leanok` synchronization. The prover did not edit the
blueprint because local role permissions reserve it for plan/review/sync.

## LeanExplore queries/candidates actually used

Every query used package filters `["Mathlib", "Physlib"]`.

- Query: `physical dimensional quantity energy mass speed of light electron
  volt atomic mass unit`.
  - Used `DimEnergy.electronVolt`.
  - Used the `Dimension`/`Dimensionful` infrastructure.
- Query: `atomic mass unit dalton kilogram speed of light physical constants`.
  - Used `DimSpeed.speedOfLight`.
  - No atomic-mass-unit declaration was returned.
- Query: `Real.sin Real.sqrt Real.pi trigonometric square root real numbers`.
  - Used `Real.sin` and `Real.pi`.
  - Inspected `Real.sqrt` for the equivalent explicit lower-root route; the
    final contract uses the threshold quadratic instead.
- Query: `Dimensionful.toDimensionful physical dimensional quantity SI unit
  value`.
  - Used `CarriesDimension.toDimensionful` and `UnitChoices.SI`.
- The preflight grounding log also queried `Real.sqrt square root`; its
  `Real.sqrt`, `Real.coe_sqrt`, and `Real.sqrt_lt'` candidates remain relevant
  to the later numerical lower-root proof but were not required in the
  statement.

## PhysLean/Mathlib names grounded

- Physlib: `Dimension`, `Dimensionful`, `WithDim`, `Dimension.M𝓭`,
  `Dimension.L𝓭`, `Dimension.T𝓭`,
  `CarriesDimension.toDimensionful`, `UnitChoices.SI`, `DimEnergy`,
  `DimEnergy.electronVolt`, `Momentum`, and `DimSpeed.speedOfLight`.
- Mathlib: `Real.sin`, `Real.cos`, `Real.pi`, real `abs`, vector norm, and real
  `min`.
- Inspected for the future proof route: `Real.sqrt`, `Real.coe_sqrt`, and
  `Real.sqrt_lt'`.

## Local abstractions introduced

- `DimMass`, `DimAngularFrequency`, `DimAction`, and `DimMomentum` are aliases
  of Physlib dimension-tagged quantities, not aliases or one-field wrappers of
  `ℝ`. They supply the missing named physical roles while preserving units.
- `atomicMassUnit` is needed because no matching Physlib constant was found; it
  is a dimensionful mass anchored to the SI conversion stated by its name and
  value.
- `OzonePhotodissociation` preserves the molecular-energy roles, particle
  momenta, Fig. 1c label, and the angle rather than reducing the experiment to
  one equation between reals.
- `ClassicalPhotodissociationLaws` is the smallest law interface containing all
  conservation, photon, and signed-geometry consequences needed by C.2.
- `PreviousPartC1Threshold` locally encodes the reusable natural-language C.1
  result without importing or depending on the sibling Lean output.

Real numbers occur only as SI/unit readouts, radians, dimensionless
trigonometric values, vector coordinates, and the final numerical answer.

## Grounding gaps and redraft requests

- No Physlib atomic-mass-unit constant was found, so `atomicMassUnit` is local.
- The chapter's recorded C.1 closed form omits a factor `2` multiplying `ΔU`
  under the square root. As printed, its small-`ΔU` limit is `ΔU/2` and, for
  the C.2 data, it predicts a photon threshold near `0.55 eV`, contradicting
  `E_γ ≥ ΔU`, energy conservation, and the recorded C.2 answer. The Lean
  contract therefore uses the energy-conserving equivalent quadratic
  `E = ΔU + E²(1 + 2 sin² θ_eff)/(6mc²)`, whose explicit lower root contains
  the missing factor `2`. The blueprint/source-report C.1 answer should be
  corrected.
- The blueprint target environment should name the main Lean theorem as noted
  above.
- The prompt advertised `archon dag-query`, but `archon` was not available on
  this lane's shell `PATH`; dependency-graph inspection was therefore blocked.
  This does not affect the independent statement formalization.

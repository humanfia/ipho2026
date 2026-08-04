# Autoformalization result: IPhO 2026 Problem 1 C.2

## Assumption/target split

### Governing laws

- `ValidOzonePhotodissociationPhysics` records the physical angle range, positive atom
  mass, fragment masses \(2m\) and \(m\), an initially stationary ozone molecule,
  \(\Delta U = U_f-U_i\), photon energy \(\hbar\omega\), photon momentum
  \(p_\gamma=E_\gamma/c\), momentum conservation, the Figure 1c angle relation,
  non-relativistic kinetic-energy conservation, and the `IsLeast` threshold contract.
- `DissociationAt` independently describes feasibility at an arbitrary angle and scalar
  frequency readout. Its existential fragment momenta and energy/momentum equations do
  not prescribe the C.2 numerical answer.
- `OzonePhotodissociationSetup` retains the named Figure 1c quantities: unit choice,
  angle, atom and fragment masses, ground-state energies, energy difference, threshold
  frequency and energy, and incident/initial/outgoing three-momenta.

### Previous-part results

- `quotedC1ThresholdExpression` now faithfully encodes the corrected C.1 result
  \[
  \omega_{\min} =
    \frac{3mc^2\left(1-\sqrt{1-2A\Delta U/(3mc^2)}\right)}
         {\hbar A},
  \qquad A=2\sin^2\theta+1.
  \]
  In particular, the conservation-law factor `2` is explicitly inside the radicand.
- `QuotedPreviousPartC1Result` permits the corrected expression at `s.theta` in the
  forward range and at `π/2` in the backward range, exactly as the natural-language C.1
  prerequisite allows.

### Figure/data readouts

- `C2NumericalInputs` states only the supplied data:
  `theta = π / 6`, `deltaU = 1.10 • electronVolt`, and
  `atomMass = 16 • atomicMassUnit`.
- `atomicMassUnit`, `DimEnergy.electronVolt`, `Constants.ℏ`, and
  `DimSpeed.speedOfLight` retain their dimensioned SI meanings. Real values occur only
  after the named `scalarInUnits`/`siScalar` projection.

### Current target conclusions

- `problem_IPhO_2026_1_C_2` concludes that
  \((\hbar\omega_{\min}-\Delta U)/\mathrm{eV}\) lies within `5e-14` of
  `2.03e-11`, expressed through `RoundsTo`.
- The theorem body remains `by sorry`, as required for the autoformalization stage.

## Goal-faithfulness audit

The C.2 rounded excess energy occurs only in the conclusion of
`problem_IPhO_2026_1_C_2`. It is absent from `ValidOzonePhotodissociationPhysics`,
`QuotedPreviousPartC1Result`, `C2NumericalInputs`, and all local definitions. The
previous-part premise supplies a general angle-, mass-, and energy-dependent threshold
formula rather than the requested C.2 number. `RoundsTo` only defines the meaning of a
rounding interval and contains no problem-specific value. Therefore the current answer
has not been smuggled into a hypothesis, premise structure, governing-law predicate, or
definition.

## Declarations and blueprint labels

- Redrafted `quotedC1ThresholdExpression`:
  `decl:physics:IPhO_2026_1_C_2:quotedC1ThresholdExpression`.
- Redrafted/retained `QuotedPreviousPartC1Result` as the consumer of that corrected
  expression:
  `decl:physics:IPhO_2026_1_C_2:QuotedPreviousPartC1Result`.
- Redrafted/retained `problem_IPhO_2026_1_C_2` with the corrected C.1 premise and the
  original rounding target:
  `thm:physics:IPhO_2026_1_C_2:target`.
- Supporting declarations remain aligned with their existing
  `decl:physics:IPhO_2026_1_C_2:*` blueprint environments:
  `DimMass`, `AngularFrequency`, `DimAction`, `atomicMassUnit`,
  `reducedPlanckConstant`, `scalarInUnits`, `siScalar`,
  `momentumSquaredNorm`, `momentumDot`, `MakesAngle`,
  `OzonePhotodissociationSetup`, `DissociationAt`,
  `ValidOzonePhotodissociationPhysics`, `C2NumericalInputs`, and `RoundsTo`.
- These environments are ready for the project `sync_leanok` phase. The blueprint was
  not edited because prover write permissions make it read-only.

## LeanExplore queries/candidates actually used

All searches used `packages: ["Mathlib", "Physlib"]`.

- Likely-name queries:
  - `Dimensionful WithDim UnitChoices`
  - `Momentum DimEnergy electronVolt speedOfLight PlanckConstant`
  - `DimSpeed.speedOfLight`
  - `DimEnergy`
  - `IsLeast least element of a set`
  - `Momentum.val`
- Natural-language queries:
  - `dimension-carrying physical quantity converted to a chosen system of units`
  - `physical energy momentum speed of light reduced Planck constant`
  - `atomic mass unit dimensionful mass`
  - `angular frequency physical dimension inverse time`
  - `physical action quantity dimension mass length squared inverse time`
- Source, module, and docstrings were inspected for the candidates actually retained:
  `Dimensionful`, `CarriesDimension.toDimensionful`, `Momentum`, `DimEnergy`,
  `DimEnergy.electronVolt`, `DimSpeed.speedOfLight`, `Constants.ℏ`, and `IsLeast`.

## Physlib/Mathlib names grounded

- Physlib:
  - `Dimensionful` and `CarriesDimension.toDimensionful`
    (`Physlib.Units.Basic`)
  - `Momentum` (`Physlib.Units.WithDim.Momentum`)
  - `DimEnergy` and `DimEnergy.electronVolt`
    (`Physlib.Units.WithDim.Energy`)
  - `DimSpeed.speedOfLight` (`Physlib.Units.WithDim.Speed`)
  - `Constants.ℏ` (`Physlib.QuantumMechanics.PlanckConstant`)
- Mathlib:
  - `IsLeast` (`Mathlib.Order.Bounds.Defs`)
  - `Real.sqrt`, `Real.sin`, `Real.cos`, finite sums, absolute value, and ordered-real
    arithmetic through the existing `Mathlib` import.

## Local abstractions introduced or retained

- `DimMass`, `AngularFrequency`, and `DimAction` are dimension-carrying
  `Dimensionful (WithDim ... ℝ)` types, not transparent scalar aliases. Searches found
  no general Physlib angular-frequency or action type matching this setup; the
  harmonic-oscillator `ω` candidates are model-specific near misses.
- `atomicMassUnit` is a dimensionful mass built from its SI readout. The search found
  `MassUnit`, but not a reusable dimensionful unified-atomic-mass constant.
- `MakesAngle`, `DissociationAt`, `OzonePhotodissociationSetup`, and
  `ValidOzonePhotodissociationPhysics` are the smallest local interfaces retaining the
  Figure 1c geometry and conservation laws.
- `QuotedPreviousPartC1Result` isolates the permitted natural-language prerequisite
  without importing the C.1 Lean output.
- `C2NumericalInputs` and `RoundsTo` separate supplied measurements from the numerical
  conclusion.

## Grounding gaps

- Physlib has no directly matching general-purpose angular-frequency/action aliases or
  dimensionful unified atomic mass constant in the LeanExplore results. The local
  dimension-carrying declarations preserve those physical roles without reducing them
  to bare real scalars.
- No redraft request remains.

## Verification

- Lean LSP diagnostics after the correction report only the expected
  `declaration uses 'sorry'` warning on `problem_IPhO_2026_1_C_2`.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_2.lean` succeeds with
  that same single expected warning.
- `git diff --check` reports no whitespace errors in either owned output file.

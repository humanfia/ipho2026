# Autoformalization result

## Assumption/target split

### Governing laws

- `OzonePhotodissociationSetup` records the physical unit choice, Figure 1c
  angle, oxygen masses, `O₃`/`O₂` ground-state energies, `ΔU`, `ω_min`,
  threshold photon energy, and the incident/outgoing momenta.
- `DissociationAt` is an explicit feasibility predicate. It requires a
  nonnegative angular-frequency readout and momenta satisfying conservation
  of momentum, the displayed outgoing-`O₂` angle, photon
  `p = E/c = ℏω/c`, and classical non-relativistic fragment kinetic energies.
- `ValidOzonePhotodissociationPhysics` states the physical angle and mass
  positivity conditions, fragment masses `2m` and `m`, initial `O₃` rest,
  `ΔU = U_f - U_i`, photon energy `E = ℏω`, photon momentum `p = E/c`,
  momentum and energy conservation, the Figure 1c angle relation, and the
  least-feasible-frequency meaning of `ω_min`.
- Isolation is represented by the conservation equations. The assumptions
  that motion is classical/non-relativistic and potential energies do not
  contribute to mass are represented by the `p²/(2M)` kinetic terms and the
  separate `2m`/`m` fragment-mass equations.

### Previous-part results

- `QuotedPreviousPartC1Result` records the C.1 result supplied in the
  blueprint: the angle-dependent threshold for `θ ≤ π/2` and saturation at
  the expression evaluated at `π/2` for backward angles.
- The expression is isolated in `quotedC1ThresholdExpression` and transcribed
  verbatim from the blueprint. No neighboring Lean file is imported.

### Figure/data readouts

- Figure 1c labels are represented by the named incident-photon, initial-ozone,
  outgoing-oxygen-molecule, and outgoing-oxygen-atom momentum fields.
- `MakesAngle` states the Euclidean dot-product relation for the outgoing
  `O₂` momentum and incident photon momentum and requires both momenta to be
  nonzero.
- `C2NumericalInputs` states `θ = π/6`,
  `ΔU = (1.10) · electronVolt`, and
  `m = 16 · atomicMassUnit` as equalities of dimensionful quantities.
- `atomicMassUnit` is the dimensionful mass with SI readout
  `1.66053906892e-27 kg`; `DimEnergy.electronVolt`,
  `DimSpeed.speedOfLight`, and `Constants.ℏ` supply the other physical
  constants.

### Current target conclusion

- `problem_IPhO_2026_1_C_2` concludes that
  `(ℏ ω_min - ΔU) / electronVolt` rounds to `2.03e-11` with half-last-digit
  tolerance `5e-14`. This explicitly captures the significant-figure meaning
  of the recorded numerical answer.

## Goal-faithfulness audit

The reported value `2.03e-11` and its rounding tolerance occur only in the
conclusion of `problem_IPhO_2026_1_C_2`. They do not occur in
`OzonePhotodissociationSetup`, `ValidOzonePhotodissociationPhysics`,
`DissociationAt`, `QuotedPreviousPartC1Result`, or `C2NumericalInputs`.
`RoundsTo` is a generic absolute-error predicate and contains no problem
answer. The helper `quotedC1ThresholdExpression` contains only the
previous-part formula and cannot unfold to the current numerical conclusion.

The threshold is not an unconstrained name: `omegaMin_is_threshold` makes its
readout the least member of the explicitly defined physical feasibility
predicate `DissociationAt`. Energies, masses, angular frequency, action, and
momenta remain dimension-carrying Physlib objects. Reals are used only for
angles and readouts in an explicit unit system.

## Declarations created and blueprint correspondence

- `DimMass`, `AngularFrequency`, `DimAction`: dimensional physical roles.
- `atomicMassUnit`, `reducedPlanckConstant`, `scalarInUnits`, `siScalar`:
  physical constants and scalar unit readouts.
- `momentumSquaredNorm`, `momentumDot`, `MakesAngle`: Figure 1c momentum
  geometry.
- `OzonePhotodissociationSetup`, `DissociationAt`,
  `ValidOzonePhotodissociationPhysics`: setup and governing laws.
- `quotedC1ThresholdExpression`, `QuotedPreviousPartC1Result`: natural-language
  C.1 prerequisite.
- `C2NumericalInputs`, `RoundsTo`: C.2 data and numerical-report semantics.
- `IPhO2026Problems.IPhO2026_1_C_2.problem_IPhO_2026_1_C_2` corresponds to
  blueprint label `thm:physics:IPhO_2026_1_C_2:target`.

The theorem statement compiles with its required `by sorry` body and is ready
for statement-level `\leanok` association by the deterministic marker sync.

## LeanExplore queries/candidates actually used

All searches were filtered to packages `["Mathlib", "Physlib"]`.

- Query `physical quantity dimensions SI units energy momentum mass angular
  frequency` found `UnitChoices.SI`, `Dimension`, `DimEnergy`, and `Momentum`.
- Query `PhysLean units dimensional quantities energy momentum` found
  `Momentum`, `CarriesDimension.toDimensionful`, `DimEnergy`, and the
  dimensional-correctness API.
- Query `Real.sqrt Real.sin Real.pi` found `Real.sin` and `Real.sqrt`.
- Query `unit conversion electron volt atomic mass unit` found
  `DimEnergy.electronVolt`, `MassUnit`, and `UnitChoices`.
- Source and module information was fetched for `Dimension`
  (`Physlib.Units.Dimension`), `DimEnergy` and
  `DimEnergy.electronVolt` (`Physlib.Units.WithDim.Energy`), `Momentum`
  (`Physlib.Units.WithDim.Momentum`), `MassUnit`
  (`Physlib.ClassicalMechanics.Mass.MassUnit`), `UnitChoices`
  (`Physlib.Units.Basic`), `Real.sin`
  (`Mathlib.Analysis.Complex.Trigonometric`), and `Real.sqrt`
  (`Mathlib.Analysis.Real.Sqrt`).

## PhysLean/Mathlib names grounded

- Physlib: `Dimensionful`, `WithDim`, `Dimension`, `M𝓭`, `L𝓭`, `T𝓭`,
  `UnitChoices`, `UnitChoices.SI`, `CarriesDimension.toDimensionful`,
  `DimEnergy`, `DimEnergy.electronVolt`, `Momentum`,
  `DimSpeed.speedOfLight`, and `Constants.ℏ`.
- Mathlib: `Real.sin`, `Real.cos`, `Real.sqrt`, `Real.pi`, finite sums over
  `Fin`, and `IsLeast`.
- `MassUnit` was inspected but not used: it is a positive scale selecting a
  unit on a mass manifold, not a dimensionful mass quantity suitable for the
  oxygen atom.

## Local abstractions introduced

- Physlib's `Units/WithDim/Mass.lean` does not currently define a mass alias,
  so `DimMass` is the direct composition
  `Dimensionful (WithDim M𝓭 ℝ)`.
- No general dimensional aliases were found for angular frequency or action;
  `AngularFrequency` and `DimAction` directly compose Physlib dimensions
  `T⁻¹` and `M L² T⁻¹`.
- No Physlib unified-atomic-mass-unit constant was found, so
  `atomicMassUnit` is constructed with
  `CarriesDimension.toDimensionful UnitChoices.SI` rather than represented as
  a scalar alias.
- `DissociationAt` and `ValidOzonePhotodissociationPhysics` are the smallest
  local interfaces found that preserve the isolated, non-relativistic
  photodissociation laws and the minimum-frequency role.

## Grounding gaps and redraft requests

- The blueprint's reusable C.1 expression appears to omit a factor `2`
  multiplying `ΔU/(3mc²)` inside the square root. Its small-`ΔU` expansion
  gives `ℏω_min ≈ ΔU/2`, and the C.2 inputs give an excess near `-0.55 eV`,
  incompatible with the recorded `2.03e-11 eV`. Inserting the factor `2`
  gives approximately `2.0296693e-11 eV`. The plan/review layer should check
  and redraft the C.1 prerequisite before the proof stage.
- No Physlib constant for the unified atomic mass unit was found.
- The blueprint theorem environment has no `\lean{...}` declaration name.
  The plan/review or marker-sync layer should associate it with
  `IPhO2026Problems.IPhO2026_1_C_2.problem_IPhO_2026_1_C_2`.
- The `archon` executable advertised for DAG navigation was not available on
  `PATH` in this prover environment; this did not block the source-driven
  formalization.
- Per prover permissions, the blueprint chapter was not edited and marker
  bookkeeping is left to the deterministic sync.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_2.lean`: exit code
  `0`, with exactly one expected `declaration uses sorry` warning.

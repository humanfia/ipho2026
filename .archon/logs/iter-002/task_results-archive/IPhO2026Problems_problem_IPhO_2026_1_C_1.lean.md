# Autoformalization result

## Assumption/target split

### Governing laws

- `DissociationAt` requires nonnegative photon angular frequency.
- Its three dimensionful momentum witnesses satisfy vector momentum
  conservation for an initially stationary ozone molecule:
  `p_γ = p_O₂ + p_O`.
- The photon momentum magnitude obeys
  `|p_γ| = ℏ ω / c`.
- The Figure 1c angle is represented independently by
  `p_γ · p_O₂ = |p_γ| |p_O₂| cos θ`.
- Energy conservation is
  `ℏ ω = ΔU + |p_O₂|²/(2(2m)) + |p_O|²/(2m)`, using molecular mass
  `2m` and atomic mass `m`.
- `IsMinimumDissociationFrequency` says that the proposed frequency is
  feasible and no smaller feasible frequency exists at the same angle.
- `ValidPhotodissociationParameters` supplies positivity of `ℏ`, `c`, and
  `m`, nonnegativity and the nonrelativistic scale bound on `ΔU`, and
  `0 ≤ θ ≤ π`.

### Previous-part results

- None. The source report lists no previous parts for C.1.

### Figure/data readouts

- Figure 1c gives a horizontal incident photon momentum, outgoing `O₂`
  momentum at angle `θ`, and the recoil momentum of the oxygen atom. The
  coordinate-independent vector conservation and dot-product angle relation
  encode these readouts.
- `PhotodissociationParameters` retains `ℏ`, `c`, the oxygen-atom mass `m`,
  and the ground-state energies `U_i` of `O₃` and `U_f` of `O₂`.
- `energyDifferenceSI` is only the source definition
  `ΔU = U_f - U_i`.
- SI scalar, speed, and two-component momentum readouts are explicit.

### Current target conclusions

- For `θ ≤ π/2`, the SI readout of `ω_min` equals the angle-dependent
  square-root expression recorded in the blueprint.
- For `π/2 ≤ θ`, it equals that expression evaluated at `π/2`, simplified
  using `sin (π/2) = 1`.

## Goal-faithfulness audit

The two closed-form frequency equalities occur only in the conclusion of
`minimumAngularFrequency_eq`. They do not occur in
`PhotodissociationParameters`, `ValidPhotodissociationParameters`,
`DissociationAt`, or `IsMinimumDissociationFrequency`.

`DissociationAt` contains only independent conservation, photon, kinetic
energy, and angle laws. `IsMinimumDissociationFrequency` is the general
feasibility-and-order definition of a minimum. The SI readout definitions and
`energyDifferenceSI` are unit/naming projections and cannot prove the target
by unfolding. Thus the requested formula was not smuggled into a hypothesis,
premise field, law predicate, or helper definition.

## Declarations created and blueprint correspondence

- `MassQuantity`, `ActionQuantity`, `AngularFrequencyQuantity`, and
  `MomentumQuantity2`: dimensionful physical quantity types.
- `scalarSI`, `speedSI`, and `momentumSI`: explicit SI readouts.
- `dot2` and `magnitude2`: Figure 1c Euclidean geometry.
- `PhotodissociationParameters` and its named SI projections.
- `ValidPhotodissociationParameters`: physical parameter domain.
- `DissociationAt`: governing kinematics and conservation laws.
- `IsMinimumDissociationFrequency`: the answer-independent threshold
  condition.
- `IPhO2026Problems.IPhO2026_1_C_1.minimumAngularFrequency_eq`
  corresponds to blueprint label
  `thm:physics:IPhO_2026_1_C_1:target`.

The target statement compiles with its required `by sorry` body and is ready
for statement-level `\leanok`. The chapter currently has no `\lean{...}`
declaration name; the plan/review layer should attach
`\lean{IPhO2026Problems.IPhO2026_1_C_1.minimumAngularFrequency_eq}` so marker
sync can associate it.

## LeanExplore queries/candidates actually used

All searches used package filters `["Mathlib", "Physlib"]`.

- Query `physical quantities with SI units and dimensions energy mass momentum
  angular frequency` found and grounded `UnitChoices.SI`, `Dimension`, and
  Physlib's dimensional-unit infrastructure.
- Queries `Quantity physical dimension units unitful value PhysLean` and
  `WithDim dimension tagged physical quantity constructor` found
  `Dimensionful` and `WithDim`. Source and module information was fetched for
  both.
- Query `Dimension.energy Dimension.mass Dimension.momentum
  Dimension.frequency` found `Dimension.M𝓭`, `DimEnergy`, and `Momentum`.
  Their source and module information was fetched.
- Query `DimEnergy DimMomentum DimMass DimTime DimFrequency WithDim ℝ` found
  `DimEnergy` and `DimSpeed`; source and module information for the quantity
  types used here was fetched.
- Queries `physical Mass type kilogram WithDim Physlib Units` and
  `angular frequency dimension inverse time WithDim` confirmed that there is
  no packaged generic dimensionful mass, action, or angular-frequency type
  matching this task.
- Query `Real.sqrt` found `Real.sqrt`; its source and
  `Mathlib.Analysis.Real.Sqrt` module were fetched.
- Query `Real.sin Real.cos trigonometric functions` found `Real.sin` and
  `Real.cos`; source/module data was fetched.
- Query `Real.sin_pi_div_two sine pi over two equals one` found
  `Real.sin_pi_div_two`; source/module data was fetched to ground the
  simplified obtuse-angle branch.

## PhysLean/Mathlib names grounded

- PhysLean/Physlib: `Dimension`, `Dimensionful`, `WithDim`,
  `Dimension.M𝓭`, `Dimension.L𝓭`, `Dimension.T𝓭`, `UnitChoices.SI`,
  `DimEnergy`, `DimSpeed`, and `Momentum`.
- Mathlib: `Real.sqrt`, `Real.sin`, `Real.cos`, `Real.pi`, and
  `Real.sin_pi_div_two`.

## Local abstractions introduced

- `MassQuantity`, `ActionQuantity`, and `AngularFrequencyQuantity` assemble
  the genuine Physlib dimensions `M`, `M L² T⁻¹`, and `T⁻¹` with
  `Dimensionful (WithDim ... ℝ)`. They are dimension-tagged quantities, not
  scalar aliases.
- `MomentumQuantity2` makes Physlib's `Momentum 2` unit-independent through
  `Dimensionful`; its SI readout supplies Figure 1c coordinates.
- `dot2` and `magnitude2` are local because `Momentum` has function-valued
  components and its ambient function norm is not the intended Euclidean
  magnitude.
- `DissociationAt` is a faithful local photodissociation interface because no
  matching PhysLean molecular photodissociation API was found.

## Grounding gaps and redraft requests

- No packaged PhysLean model for ozone photodissociation or a general
  dimensionful mass/action/angular-frequency type was found.
- The `archon` executable advertised for dependency-graph navigation was not
  available on `PATH` (`archon: command not found`).
- There is a likely factor-of-two inconsistency in the blueprint's recorded
  answer. From the encoded conservation laws, minimizing over the outgoing
  `O₂` momentum for `θ ≤ π/2` gives
  `ℏω = ΔU + A (ℏω)²/(6 m c²)`, where
  `A = 1 + 2 sin² θ`. Its lower solution has radicand
  `1 - 2 A ΔU/(3 m c²)`, whereas the blueprint records
  `1 - A ΔU/(3 m c²)`. The recorded expression therefore approaches
  `ΔU/(2ℏ)` rather than the expected `ΔU/ℏ` as `ΔU/(mc²) → 0`.
  The formal theorem faithfully retains the supplied recorded answer, but a
  physics prover should not be expected to close it from the stated laws
  until the source formula is reviewed.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`: exit code 0
  with exactly the expected `sorry` warning.

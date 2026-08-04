## Assumption/target split

### Governing laws

- `DissociationAt` requires a nonnegative photon angular-frequency readout.
- Momentum conservation is represented in the two-dimensional Figure 1c plane by
  `pγ = pO₂ + pO`.
- The photon momentum magnitude obeys `|pγ| = ℏ ω / c`.
- The displayed angle is imposed by
  `pγ · pO₂ = |pγ| |pO₂| cos θ`.
- Energy conservation uses the gap `ΔU = U_f - U_i`, molecular mass `2m`,
  and atomic mass `m`, hence kinetic denominators `2 * (2m)` and `2m`.

### Previous-part results

- None. Part C.1 is modeled directly from the dimensioned parameters,
  Figure 1c geometry, and conservation laws.

### Figure/data readouts

- Figure 1c supplies the outgoing `O₂` angle `θ` relative to the incident
  photon and motivates two Cartesian momentum components.
- `ℏ`, `c`, `m`, `U_i`, and `U_f` are dimensionful data. Their scalar SI
  projections are used only when stating the real-valued kinematic laws.
- Validity data require positive `ℏ`, `c`, and `m`, nonnegative `ΔU`,
  `2 ΔU ≤ m c²`, and `0 ≤ θ ≤ π`.

### Current target conclusions

- If `θ ≤ π / 2`, the least feasible angular frequency has discriminant
  `1 - 2 * ΔU / (3 * m * c²) * (2 * sin² θ + 1)`.
- If `π / 2 ≤ θ`, it has the constrained-boundary discriminant
  `1 - 2 * ΔU / (m * c²)`.
- Both conclusions retain the dimensioned angular-frequency argument and the
  operational least-feasible-frequency contract.

## Goal-faithfulness audit

The corrected piecewise closed form occurs only in the conclusion of
`minimumAngularFrequency_eq`. It is not a field of
`PhotodissociationParameters` or `ValidPhotodissociationParameters`, and it is
not part of `DissociationAt`. `IsMinimumDissociationFrequency` says only that
the candidate is feasible and below every other feasible frequency; it does
not contain either requested formula. The validity bound is a physical
discriminant condition, not the target equality. No definition was introduced
whose unfolding yields the theorem.

## Declarations and blueprint labels

- Retained the dimensioned scaffold declarations
  `MassQuantity`, `ActionQuantity`, `AngularFrequencyQuantity`,
  `MomentumQuantity2`, the SI projections, the parameter structures, and the
  two governing predicates corresponding to the chapter's
  `decl:physics:IPhO_2026_1_C_1:*` environments.
- Redrafted
  `IPhO2026Problems.IPhO2026_1_C_1.minimumAngularFrequency_eq` for
  `thm:physics:IPhO_2026_1_C_1:target`, inserting the conservation-law factor
  `2` under both square roots.
- The blueprint was not edited because prover write permissions exclude
  blueprint chapters; the corrected theorem statement is ready for the
  sync-managed statement `\leanok` marker. Its proof body intentionally
  remains `sorry` at the autoformalization stage.

## LeanExplore grounding

Queries used with `packages: ["Mathlib", "Physlib"]`:

- Natural-language query:
  `dimensionful physical momentum quantity with SI unit evaluation and Cartesian components`
- Likely-name query:
  `Dimensionful Momentum DimEnergy DimSpeed UnitChoices.SI`
- Focused likely-name query:
  `DimEnergy dimensionful energy`

Candidates inspected and used:

- `UnitChoices.SI` from `Physlib.Units.Basic`
- `Dimensionful` from `Physlib.Units.Basic`
- `DimEnergy` from `Physlib.Units.WithDim.Energy`
- `Momentum` from `Physlib.Units.WithDim.Momentum`
- `DimSpeed` from `Physlib.Units.WithDim.Speed`

The fetched sources confirm that `Dimensionful` is the unit-choice-dependent
physical-quantity type, `Momentum 2` carries dimension `M L T⁻¹` with value
type `Fin 2 → ℝ`, `DimEnergy` has energy dimension, `DimSpeed` has speed
dimension, and `UnitChoices.SI` selects metres, seconds, kilograms, coulombs,
and kelvin.

## Local abstractions

- `MassQuantity`, `ActionQuantity`, and `AngularFrequencyQuantity` specialize
  `Dimensionful (WithDim ...)` to the required physical dimensions instead of
  collapsing physical data to scalars.
- `MomentumQuantity2` specializes Physlib's dimensioned `Momentum` to the
  Figure 1c plane.
- `scalarSI`, `speedSI`, and `momentumSI` expose explicit SI readouts;
  `dot2` and `magnitude2` then state the measured planar geometry.
- `DissociationAt` and `IsMinimumDissociationFrequency` are local,
  problem-specific physical predicates. Physlib supplies unit-aware
  quantities but no ozone photodissociation/minimization interface; these
  predicates preserve the relevant conservation and least-feasibility
  meanings without assuming the answer.

## Grounding gaps and verification

- No generic Physlib declaration packages this specific two-fragment
  photodissociation conservation model or its constrained frequency
  minimization, so the faithful local predicates are retained.
- The requested `archon dag-query` navigation could not be run because the
  `archon` executable was not present on this prover process's `PATH`; the
  blueprint itself has no theorem ancestors beyond the declarations listed in
  its `\uses`.
- Lean LSP diagnostics report only the expected `declaration uses sorry`
  warning at `minimumAngularFrequency_eq`.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_1.lean` exits
  successfully with the same single expected warning.
- `lake build IPhO2026Run` completes successfully.

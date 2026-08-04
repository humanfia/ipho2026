# Autoformalization result

## Assumption/target split

### Governing laws

- Figure 3b identifies states `1,4` with the hot isotherm and states `2,3`
  with the cold isotherm, with the cold reservoir initially equal to the
  helium temperature.
- The torus mass satisfies density times volume equals amount of substance
  times molar mass.
- At every labelled state, the paramagnet equation of state is
  `T * M * V = n * K * H`.
- Helium calorimetry equates absorbed heat with
  `ρ * V * c * (T_initial - T_final)`.
- Reservoir temperatures are positive; magnetizations, heat magnitudes, and
  final helium temperature have the physically appropriate nonnegativity
  conditions.

### Previous-part results

- B.1 supplies the cold-leg `2 → 3` and hot-leg `4 → 1` isothermal heat
  relations, including the factor `1 / (2T)`.
- C.2 supplies the nonnegative-magnitude square-root relation expressing
  `M₁` in terms of `M₂`, `M₃`, and `M₄`.

### Figure/data readouts

- The four cycle states and their oriented order are represented by
  `CarnotState` and `CarnotState.next`.
- The supplied data record `n = 2 mol`, `K = 1.87e-6 K m³/mol`,
  torus density `2730 kg/m³`, torus molar mass `0.19 kg/mol`, the four
  magnetic-field readouts, `1.00 L` of helium initially at `1 K`,
  helium specific heat `100 J/(kg K)`, helium density `130 kg/m³`, and
  `μ₀ = 4π·10⁻⁷ N/A²`.
- Temperature, volume, density, specific heat, magnetic field strength,
  magnetization, energy, and permeability retain distinct `WithDim`
  dimensions. Mole-based constants remain explicitly unit-named real
  readouts because `Dimension` has no amount-of-substance component.

### Current target conclusions

- `Q_c` lies within `0.0005 J` of `0.129 J`.
- The helium temperature decrease lies within `0.00005 K` of `0.00992 K`.
- The final helium temperature lies within `0.00005 K` of `0.99008 K`.

## Goal-faithfulness audit

The three numerical tolerance statements occur only in the conclusion of
`helium_temperature_after_one_cycle`. `HasSuppliedData` contains only source
readouts. `GoverningLaws` contains general geometry, equation-of-state,
calorimetry, positivity, and nonnegativity laws; its mention of the final
temperature is only through the general calorimetric balance and the physical
bound `0 ≤ T_final`, not a requested numerical value. `PreviousPartResults`
contains only the independently licensed B.1/C.2 formulas. No definition
unfolds to any of the three target intervals.

The redraft only adds the explicit `import Mathlib` requested by the blueprint
and review objective. It leaves all typed fields, laws, data, tolerances, and
the theorem signature unchanged.

## Declarations and blueprint labels

- `CarnotState` —
  `decl:physics:IPhO_2026_3_C_3:CarnotState`
- `CarnotState.next` —
  `decl:physics:IPhO_2026_3_C_3:CarnotState:next`
- `Temperature`, `Volume`, `MassDensity`, `SpecificHeatCapacity`,
  `MagneticFieldStrength`, `Magnetization`, `Energy`, and
  `MagneticPermeability` — the correspondingly named
  `decl:physics:IPhO_2026_3_C_3:*` labels
- `Setup` — `decl:physics:IPhO_2026_3_C_3:Setup`
- `HasSuppliedData` —
  `decl:physics:IPhO_2026_3_C_3:HasSuppliedData`
- `GoverningLaws` —
  `decl:physics:IPhO_2026_3_C_3:GoverningLaws`
- `PreviousPartResults` —
  `decl:physics:IPhO_2026_3_C_3:PreviousPartResults`
- `helium_temperature_after_one_cycle` —
  `thm:physics:IPhO_2026_3_C_3:target`

All declaration statement environments are ready for the project-managed
`\leanok` synchronization. The theorem proof intentionally remains `by sorry`
as required by the `physics-formalize` objective, so its proof environment is
not claimed complete.

## LeanExplore queries/candidates actually used

- Query: `WithDim dimensioned physical quantity SI units value projection`
  with packages `["Mathlib", "Physlib"]`. Candidates included `WithDim`,
  `WithDim.scaleUnit_val`, and `UnitChoices.SI`. The source and module for
  `WithDim` were inspected; it is declared in
  `Physlib.Units.WithDim.Basic` as a dimension-tagged carrier with a `val`
  projection.
- Query: `Real.sqrt square root of a real number and Real.pi` with packages
  `["Mathlib", "Physlib"]`. Candidates included `Real.sqrt`,
  `Real.sqrt_le_sqrt`, and `Real.sqrt_prod`. The source and module for
  `Real.sqrt` were inspected; it is declared in
  `Mathlib.Analysis.Real.Sqrt`.
- The existing preflight grounding report was also checked. Its relevant near
  matches include PhysLean's absolute `Temperature`,
  `FluidDynamics.MassDensity`, electromagnetic vector fields, and
  `DimEnergy`.

## PhysLean/Mathlib names grounded

- Physlib: `Dimension`, `WithDim`, the base dimensions `M𝓭`, `L𝓭`, `T𝓭`,
  `C𝓭`, `Θ𝓭`, and the `WithDim.val` scalar readout.
- Mathlib: `Real.sqrt`, `Real.pi`, real absolute value notation, powers,
  inequalities, and arithmetic used by the data and target.

## Local abstractions introduced

- `CarnotState` and `CarnotState.next` retain the four labelled vertices and
  the oriented Figure 3b cycle rather than encoding states as unlabelled
  scalars.
- The eight physical quantity aliases are dimension-tagged `WithDim` types,
  not transparent aliases to `ℝ`; their `val` fields explicitly mean fixed-SI
  scalar readouts.
- `Setup` groups the physical system quantities without imposing any answer.
- `HasSuppliedData`, `GoverningLaws`, and `PreviousPartResults` keep source
  observations, physical laws, and licensed prerequisites logically separate.

These abstractions are preferable to the near matches found in PhysLean for
this scalar thermodynamic problem: PhysLean's `Temperature` wraps a
nonnegative scalar in an arbitrary unit system, `FluidDynamics.MassDensity`
is a spatial field, and the electromagnetic candidates are spacetime-dependent
vector fields rather than the four scalar `H`/`M` magnitudes supplied here.

## Grounding gaps

- Physlib's present dimension basis has no amount-of-substance component.
  Consequently the amount, molar Curie constant, and molar mass are faithful
  explicitly unit-named real readouts rather than `WithDim` quantities.
- No library Carnot-cycle object matching the four problem-specific labelled
  states was found; the local finite state type is the minimal faithful model.
- The `archon dag-query` executable advertised by the task was not available
  on this prover process's `PATH`; the blueprint itself fully specifies the
  licensed B.1/C.2 dependencies.
- No blueprint redraft is requested. In accordance with prover permissions,
  the chapter was not edited; marker synchronization is left to the project
  automation.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors and exactly one
  expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`: exit code
  `0`, with exactly the expected `sorry` warning.
- A module-specific `lake build
  IPhO2026Problems.problem_IPhO_2026_3_C_3` check is unavailable because the
  Lake configuration exposes only the `IPhO2026Run` library target; Lake
  reported that module name as an unknown target. The direct Lake-environment
  Lean compilation above is therefore the scoped compile check.

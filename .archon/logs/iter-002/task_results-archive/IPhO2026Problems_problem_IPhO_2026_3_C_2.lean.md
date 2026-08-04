# Autoformalization result: IPhO 2026 Problem 3 C.2

## Assumption/target split

### Governing laws

- `SatisfiesParamagneticEquationOfState` states the given equation
  `T M V = n K H` in SI scalar readouts.
- `EquationOfStateAtVertices` applies that same equation of state at vertices
  1, 2, 3, and 4.
- `SatisfiesIsothermalHeatLaw` states the reusable B.1 signed-heat relation
  `Q = -(μ₀ n K / (2 T)) (H_f² - H_i²)`.  In the target theorem it is applied
  with signed heat `+Q_c` on `2 → 3` and `-Q_h` on `4 → 1`.
- `SatisfiesReversibleCarnotHeatBalance` states the general reversible-cycle
  entropy balance `Q_c / T_c = Q_h / T_h`.
- Positivity/nonnegativity fields record the physical domains of temperatures,
  volume, constants, field magnitudes, magnetization magnitudes, and heat
  magnitudes.

### Previous-part results

- The natural-language result of B.1 is restated locally as
  `SatisfiesIsothermalHeatLaw`; no previous Lean output is imported.
- The natural-language result of C.1 is incorporated in
  `Figure3bReadout`: states 1 and 4 are at `T_h`, states 2 and 3 are at `T_c`,
  `Q_c` is absorbed on `2 → 3`, and `Q_h` is delivered on `4 → 1`.

### Figure/data readouts

- `CycleLeg` names the four oriented arrows `1 → 2 → 3 → 4 → 1`.
- `ProcessKind` distinguishes an adiabatic leg from an isotherm at a specified
  physical temperature.
- `Figure3bReadout` records vertical cold/hot isotherms `2 → 3` and `4 → 1`
  and the adiabatic legs `1 → 2` and `3 → 4`.
- `CarnotCycle` retains the paramagnetic torus, its fixed volume, all four
  vertex states, both reservoir temperatures, both heat magnitudes, and the
  physical constants `n`, `K`, and `μ₀`.

### Current target conclusion

- `magnetization_state1_eq_sqrt` concludes exactly
  `M₁ = Real.sqrt (M₂² - M₃² + M₄²)` for the nonnegative SI magnetization
  magnitude readouts at the four vertices.

## Goal-faithfulness audit

The requested square-root identity occurs only in the conclusion of
`magnetization_state1_eq_sqrt`.  It does not occur in `CarnotCycle`,
`Figure3bReadout`, `EquationOfStateAtVertices`, either governing-law
definition, or any helper definition.  The Carnot heat balance is a general
reversible entropy law involving `Q_h`, `Q_c`, `T_h`, and `T_c`; it is not a
restatement of the requested magnetization formula.  Likewise, the two
isothermal hypotheses are instances of the independently supplied B.1 law.
The theorem will require eliminating the field and heat readouts using those
laws and the equation of state, followed by use of the general nonnegativity
of a magnetization magnitude.

## Declarations created and blueprint correspondence

- `PhysicalQuantityTypes`
- `SIReadout`
- `TorusState`
- `CycleLeg`
- `ProcessKind`
- `CarnotCycle`
- `Figure3bReadout`
- `SatisfiesParamagneticEquationOfState`
- `SatisfiesIsothermalHeatLaw`
- `SatisfiesReversibleCarnotHeatBalance`
- `EquationOfStateAtVertices`
- `IPhO2026Problems.IPhO2026_3_C_2.magnetization_state1_eq_sqrt`, corresponding
  to blueprint label `thm:physics:IPhO_2026_3_C_2:target`.

The target theorem statement compiles with its required `by sorry` body and is
ready for deterministic blueprint `\leanok` synchronization.  The blueprint
currently has no `\lean{...}` name; the plan/review layer should attach
`\lean{IPhO2026Problems.IPhO2026_3_C_2.magnetization_state1_eq_sqrt}`.  The
blueprint was not edited because prover write permissions make it read-only.

## LeanExplore queries/candidates actually used

All queries used package filters `["Mathlib", "Physlib"]`.

- `thermodynamic temperature heat physical quantity SI units magnetization
  magnetic field strength` found `UnitChoices.SI`,
  `UnitChoices.SI_temperature`, and
  `Electromagnetism.MagneticField`.  Source/module/docstring data were fetched
  for all three.  `UnitChoices.SI` is used; the electromagnetic field type was
  rejected as a semantic mismatch.
- `Real.sqrt square root nonnegative square identity` found `Real.sqrt` and
  `Real.sqrt_nonneg`.  Their source/module data were fetched.  `Real.sqrt` is
  used in the target, while `Real.sqrt_nonneg` grounds the intended later proof
  route.
- `Physlib units dimensional quantity value in chosen units UnitChoices
  Quantity dimension` found `UnitChoices`, `Dimension`,
  `WithDim.scaleUnit_val`, and the dimensional-quantity interfaces.
- `WithDim temperature energy volume magnetic field magnetization physical
  dimensions definitions` found `DimEnergy` but no packaged scalar
  thermodynamic magnetization or magnetic-field-strength magnitude type.
  Source/module data for `UnitChoices`, `Dimension`,
  `WithDim.scaleUnit_val`, and `DimEnergy` were fetched and assessed.

## PhysLean/Mathlib names grounded

- PhysLean/Physlib: `UnitChoices`, `UnitChoices.SI`,
  `UnitChoices.SI_temperature`, `Dimension`, `WithDim.scaleUnit_val`, and
  `DimEnergy`.
- Mathlib: `Real.sqrt` and `Real.sqrt_nonneg`.
- Imports actually used: `Physlib.Units.Basic` and
  `Mathlib.Analysis.Real.Sqrt`.

## Local abstractions introduced

- `PhysicalQuantityTypes` supplies distinct abstract types for the torus,
  thermodynamic temperature, `H` magnitude, `M` magnitude, volume, and heat
  magnitude.  This prevents dimensional roles from collapsing to aliases of
  `ℝ`.
- `SIReadout` is an explicit measurement interface into real SI readouts.  Its
  magnetic and magnetization readouts are scalar magnitudes in amperes per
  metre, matching Figure 3b and the wording of C.2.
- `TorusState`, `CycleLeg`, `ProcessKind`, `CarnotCycle`, and
  `Figure3bReadout` preserve the four labeled vertices, oriented geometry,
  process kinds, reservoirs, and heat-transfer locations.
- Local predicates state the missing paramagnetic equation-of-state,
  isothermal thermodynamics, and Carnot entropy interfaces directly rather
  than defining the requested answer.

## Grounding gaps

- `Electromagnetism.MagneticField` is a spacetime-dependent Euclidean vector
  field.  It is not the scalar field-strength magnitude `H` plotted against
  temperature in Figure 3b.
- No matching PhysLean type or ready-made law was found for paramagnetic
  magnetization magnitude, the equation `T M V = n K H`, the B.1 heat law, or
  a reversible magnetic Carnot cycle.  The local abstract interfaces above
  retain their physical meanings.
- The read-only `archon dag-query` command advertised by the task was
  unavailable in this environment (`archon: command not found`).  The chapter
  itself marks previous parts as natural-language prerequisites only.
- No file-specific `/- USER: ... -/` hint was present because the assigned
  Lean file did not yet exist.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages` reported no errors and
  exactly one expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_2.lean` exited
  successfully with exactly the expected `sorry` warning.

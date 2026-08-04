# Autoformalization result: IPhO 2026 Problem 3 A.2

## Assumption/target split

### Governing laws

- `SatisfiesParamagneticConstitutiveLaw` states the supplied material relation
  `B = μ₀ H + μ₀ M` for every choice of units.
- `IsAlignedParamagneticState` records the paramagnetic convention that the
  scalar uniform magnetization is parallel to the scalar uniform field
  strength.
- `SatisfiesFaradayCompensationLaw` states that the time integral of the
  external compensating voltage is `N A dB`.
- `SatisfiesExternalSourceWorkLaw` states the independent electrical work law
  `dWemf = I` times the source-voltage impulse.  Its sign convention is
  positive for energy delivered into the torus.
- `IdealToroidalWinding` represents the dense insulated, negligible-loss
  winding; `hTurns` states that its turn count is positive.

### Previous-part results

- `SatisfiesThinTorusAmpereLaw` locally restates the natural-language A.1
  conclusion `H = N I A / V`.
- No Lean output from part A.1 is imported, in accordance with the chapter's
  `natural_language_prerequisite_only` policy.

### Figure/data readouts

- `TorusGeometry` retains the Figure 3a labels: mean radius `R`,
  cross-section radius `r` (the displayed diameter is `2r`),
  cross-sectional area `A`, and volume `V`.
- `IsThinCircularTorus g ε` makes the qualitative `r ≪ R` approximation
  explicit through a dimensionless bound `r ≤ ε R`, with `0 < ε < 1`.
- The same predicate records the circular-section and thin-torus readouts
  `A = π r²` and `V = 2 π R A`, together with positive radii.
- `UniformMagneticState` retains the approximately uniform quantities `H`,
  `B`, and `M`; `μ₀`, instantaneous current `I`, signed increment `dB`,
  source-voltage impulse, and signed work increment are all explicit theorem
  parameters.

### Current target conclusion

- `externalSourceWorkIncrement_eq_volume_mul_fieldStrength_mul_fluxDensityIncrement`
  concludes, for every unit choice,
  `dWemf = V * H * dB` at the level of scalar readouts of genuine
  dimensionful quantities.

## Goal-faithfulness audit

The requested relation `dWemf = V H dB` occurs only in the conclusion of the
target theorem.  It is not a field of `TorusGeometry`,
`IdealToroidalWinding`, or `UniformMagneticState`, and it does not occur in a
local definition.

The two hypotheses that mention work and `dB` are independent governing-law
steps: `SatisfiesExternalSourceWorkLaw` relates work to current and source
voltage impulse, while `SatisfiesFaradayCompensationLaw` relates that impulse
to `N A dB`.  Neither contains `V H dB`.  Obtaining the target still requires
using the previous-part Ampère relation `H = N I A / V` and the nonzero volume
following from the geometric assumptions.  The constitutive law and
paramagnetic alignment retain the full problem setup but do not imply the
current answer by themselves.

The helpers `signedReadout` and `magnitudeReadout` merely project physical
quantities into a selected unit system.  They do not define any quantity by
the target formula.

## Declarations created and blueprint correspondence

- Dimensionful local quantity types:
  `DimLengthMagnitude`, `DimVolumeMagnitude`, `DimElectricCurrent`,
  `DimMagneticFieldStrength`, `DimMagnetization`,
  `DimMagneticFluxDensity`, `DimMagneticFluxDensityIncrement`,
  `DimVacuumPermeability`, and `DimVoltageImpulse`.
- Scalar projection helpers: `signedReadout` and `magnitudeReadout`.
- Physical setup: `TorusGeometry`, `IsThinCircularTorus`,
  `IdealToroidalWinding`, `UniformMagneticState`, and
  `IsAlignedParamagneticState`.
- Physical-law predicates: `SatisfiesParamagneticConstitutiveLaw`,
  `SatisfiesThinTorusAmpereLaw`, `SatisfiesFaradayCompensationLaw`, and
  `SatisfiesExternalSourceWorkLaw`.
- `IPhO2026Problems.IPhO2026_3_A_2.externalSourceWorkIncrement_eq_volume_mul_fieldStrength_mul_fluxDensityIncrement`
  corresponds to blueprint label
  `thm:physics:IPhO_2026_3_A_2:target`.

The theorem statement compiles with the required `by sorry` body and is ready
for deterministic blueprint `\leanok` synchronization.  The blueprint has no
`\lean{...}` declaration name yet; the plan/review layer should attach the
fully qualified theorem name above.  The blueprint was not edited because
prover write permissions make it read-only.

## LeanExplore queries/candidates actually used

All queries used package filters `["Mathlib", "Physlib"]`.

- `physical quantities with dimensions and SI units work magnetic field
  strength magnetic flux density current voltage volume area` found
  `UnitChoices.SI`, `Dimensionful`, and
  `Electromagnetism.MagneticField` among the relevant candidates.
- `UnitChoices.SI Quantity dimensions length area volume electric current
  energy work magnetic flux density field strength` confirmed Physlib's
  dimension and unit-choice framework.
- `DimLength DimVolume DimCurrent magnetic flux density permeability energy
  joule quantity` found the packaged `DimEnergy` but no packaged scalar
  `DimLength`, `DimVolume`, electric-current, `H`, `B`, magnetization,
  permeability, or voltage-impulse types.
- `DimArea dimensional area` found the packaged `DimArea`.
- `WithDim Dimension.L𝓭 Dimension.T𝓭 Dimension.M𝓭 Dimension.C𝓭 physical
  dimension carrier` found the dimension-tagging carrier and all four
  fundamental dimensions used here.

Source and module data were fetched for `UnitChoices.SI`, `Dimensionful`,
`Electromagnetism.MagneticField`, `DimArea`, `DimEnergy`, `Dimension`,
`WithDim`, `Dimension.L𝓭`, `Dimension.T𝓭`, `Dimension.M𝓭`, and
`Dimension.C𝓭`.

## PhysLean/Mathlib names grounded

- PhysLean/Physlib: `Dimensionful`, `WithDim`, `Dimension`,
  `Dimension.L𝓭`, `Dimension.T𝓭`, `Dimension.M𝓭`, `Dimension.C𝓭`,
  `UnitChoices`, `DimArea`, and `DimEnergy`.
- Mathlib: `Real.pi`.
- Imports actually used: `Mathlib`, `Physlib.Units.WithDim.Area`, and
  `Physlib.Units.WithDim.Energy`.

## Local abstractions introduced

- The missing quantity types are assembled as
  `Dimensionful (WithDim d carrier)` with their correct physical dimensions:
  current `C T⁻¹`, field strength and magnetization `C T⁻¹ L⁻¹`, flux density
  `M T⁻¹ C⁻¹`, permeability `M L C⁻²`, voltage impulse
  `M L² T⁻¹ C⁻¹`, and volume `L³`.
- These are not scalar aliases: Physlib's `Dimensionful` requires a readout
  for every unit choice together with the correct dimension-dependent scaling
  law.  Nonnegative carriers are used for radii, area, and volume; signed real
  carriers are used for current and infinitesimal transfers.
- The torus, winding, uniform magnetic state, thin-geometry readout, Ampère
  relation, constitutive relation, Faraday compensation, and electrical work
  relation are modeled as separate structures or law predicates.  This keeps
  each physical role visible and leaves the requested relation to be proved.

## Grounding gaps

- Physlib's `Electromagnetism.MagneticField` is a spacetime-dependent
  Euclidean vector field, not the approximately uniform scalar `H` or `B`
  magnitude used in this problem.  It was therefore rejected as a semantic
  mismatch.
- LeanExplore found no ready-made Physlib interfaces for toroidal Ampère
  induction, paramagnetic magnetization, the constitutive law
  `B = μ₀(H + M)`, Faraday voltage impulse, or the source-work law.  Faithful
  local predicates were introduced instead.
- The read-only `archon dag-query` command advertised by the task was
  unavailable in this environment (`archon: command not found`).  The
  blueprint itself identifies A.1 as a natural-language prerequisite.
- No file-specific `/- USER: ... -/` hint was present because the assigned
  Lean file did not exist before this task.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages` reports no errors and exactly
  one expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_2.lean` exits
  successfully with exactly the expected `sorry` warning.

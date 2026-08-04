# Autoformalization result: IPhO 2026 Problem 3 B.2

## Assumption/target split

### Governing laws

- `ParamagneticTorus` records the fixed torus volume `V`, amount `n` in
  moles, equation-of-state constant `K`, material constant `λ`, and vacuum
  permeability `μ₀`. Positivity of their SI readouts is part of
  `SatisfiesParamagneticTorusLaws`.
- `SatisfiesParamagneticTorusLaws.equationOfState` states
  `T * M * V = n * K * H` at every process state.
- `heatCapacityEquation` states
  `C_M = n * λ / T^2`.
- `internalEnergyDifferential` states `dU = C_M dT` using Mathlib's `deriv`
  on SI readouts along the dimensionless process parameter.
- `firstLaw_enteringPositive` states `dU = dQ + dW`, which encodes the
  convention that heat and work entering the torus are positive.
- `adiabatic_noHeat` states `dQ = 0`.
- Differentiability and strict-positive-temperature hypotheses supply the
  regularity and nonvanishing data needed for a later calculus proof.

### Previous-part results

- The natural-language A.3 result `dW = μ₀ V H dM` is represented directly by
  `magneticWorkDifferential_previousA3`.
- No Lean declaration from A.3 is imported, in accordance with the
  `natural_language_prerequisite_only` policy.

### Figure/data readouts

- The official page 13 image identifies `H_i` and `H_f` as magnitudes of the
  applied field strength and `T_i`, `T_f` as the initial and final absolute
  temperatures of the Pm-T.
- `h_initial_field`, `h_final_field`, and `h_initial_temperature` connect
  those three prescribed endpoint labels to process readouts at `τ = 0` and
  `τ = 1`.
- The field strength and magnetization are explicitly nonnegative magnitudes.
- The fixed volume `V` and amount `n` are retained in the model and governing
  laws even though both cancel from the requested closed form.
- This subquestion has no additional numbered-diagram geometry. Figure 3b
  belongs to the following Carnot-cycle part rather than B.2.

### Current target conclusions

- `adiabatic_temperature_change` concludes exactly
  `T_f - T_i =
    T_i * (sqrt ((λ + μ₀*K*H_f^2) / (λ + μ₀*K*H_i^2)) - 1)`
  for SI/kelvin readouts.
- This theorem corresponds to blueprint label
  `thm:physics:IPhO_2026_3_B_2:target`.

## Goal-faithfulness audit

The endpoint temperature formula occurs only in the conclusion of
`adiabatic_temperature_change`. It does not occur in
`ParamagneticTorus`, `ParamagneticTorusProcess`, any field of
`SatisfiesParamagneticTorusLaws`, or any helper definition.

In particular, the final temperature is not an input or calibrated readout.
Only the initial temperature and the prescribed initial/final field
magnitudes are endpoint hypotheses. The square-root ratio, cancellation of
`n` and `V`, and integration of the coupled differential laws therefore
remain substantive proof obligations.

The readout helpers merely project unit-independent Physlib quantities to SI.
Unfolding them cannot prove the target, and there is no local definition of
`ΔT` that restates the desired answer.

## Declarations created

- Dimensionful physical types:
  `ThermodynamicTemperature`, `PhysicalVolume`,
  `AppliedFieldStrengthMagnitude`, `MagnetizationMagnitude`,
  `VacuumPermeability`, `CurieConstantPerMole`, `LambdaPerMole`, and
  `HeatCapacityAtConstantMagnetization`.
- SI readouts:
  `temperatureInKelvin`, `volumeInCubicMeters`, `fieldStrengthInSI`,
  `magnetizationInSI`, `vacuumPermeabilityInSI`, `curieConstantInSI`,
  `lambdaInSI`, `heatCapacityInSI`, and `energyInJoules`.
- Physical setup/process interfaces:
  `ParamagneticTorus`, `ParamagneticTorusState`,
  `ParamagneticTorusProcess`, and `SatisfiesParamagneticTorusLaws`.
- Process readouts:
  `temperatureAlongProcessInKelvin`,
  `fieldStrengthAlongProcessInSI`, and
  `magnetizationAlongProcessInSI`.
- Target:
  `IPhO2026Problems.IPhO2026_3_B_2.adiabatic_temperature_change` —
  blueprint label `thm:physics:IPhO_2026_3_B_2:target`.

The target theorem is ready for the deterministic blueprint `\leanok`
synchronization. The blueprint was not edited because the project-local
prover rules make blueprint chapters read-only and assign marker maintenance
to the sync/review phases.

## LeanExplore queries/candidates actually used

All searches passed `packages: ["Mathlib", "Physlib"]`.

- `thermodynamic temperature physical quantity SI units dimensions`,
  `Quantity physical dimension unit value`, and
  `DimTemperature WithDim temperature physical dimensional quantity`
  grounded `Dimension`, `Dimensionful`, `WithDim`, `UnitChoices.SI`, and
  `Temperature`. Source and module data were fetched for the candidates used
  or evaluated as near misses.
- `SI volume amount of substance energy work heat capacity` grounded
  Physlib's `DimEnergy`; its source and module were fetched.
- `magnetic field strength magnetization physical quantity`,
  `SI magnetic field unit magnetic field strength H magnetization`, and
  `WithDim magnetic field dimension` returned
  `Electromagnetism.MagneticField`. Source inspection showed that it is a
  spacetime vector magnetic `B` field, not the uniform macroscopic scalar
  field-strength magnitude `H` used here.
- `adiabatic thermodynamic process first law heat work internal energy`
  returned statistical-mechanics and ideal-gas candidates, including
  `MicroHamiltonian.internalU`, `CanonicalEnsemble.heatCapacity`, and
  `adiabatic_relation_*`; none states the supplied paramagnetic-torus laws.
- Exact queries `deriv`, `DifferentiableOn`, `Real.sqrt`, and
  `Set.Icc Set.Ioo closed open interval` grounded the Mathlib declarations
  used in the process laws and target. Source and module data were fetched
  for `deriv`, `DifferentiableOn`, `Real.sqrt`, `Set.Icc`, and `Set.Ioo`.

## PhysLean/Mathlib names grounded

- Physlib: `Dimension`, `Dimensionful`, `WithDim`, `UnitChoices.SI`,
  `DimEnergy`, and the dimension symbols `L𝓭`, `T𝓭`, `M𝓭`, `C𝓭`, `Θ𝓭`.
- Mathlib: `deriv`, `DifferentiableOn`, `Set.Icc`, `Set.Ioo`, and
  `Real.sqrt`.

## Local abstractions introduced

- `ParamagneticTorusState` distinguishes the physical temperature,
  applied-field-strength magnitude, and magnetization magnitude.
- `ParamagneticTorusProcess` keeps internal energy, heat, work, and
  constant-magnetization heat capacity as dimensionful quantities rather
  than bare real aliases.
- `SatisfiesParamagneticTorusLaws` is the smallest local interface found that
  states the problem's macroscopic constitutive and thermodynamic laws
  without assuming the requested endpoint answer.
- `amountInMoles : ℝ` is explicitly a measured molar readout. Physlib's
  `Dimension` source has only length, time, mass, charge, and temperature, so
  it cannot presently tag amount of substance.

## Grounding gaps and redraft requests

- No Physlib API was found for a uniform paramagnetic material's field
  strength `H`, magnetization `M`, equation of state, signed magnetic work,
  or adiabatic first-law process. The local dimensionful state/process/law
  abstractions preserve those roles.
- Physlib's `Temperature` is a nonnegative scalar in an arbitrary
  zero-preserving unit choice. `Dimensionful (WithDim Θ𝓭 ℝ≥0)` was used
  instead so that the theorem can name the kelvin SI readout explicitly.
- `CanonicalEnsemble.heatCapacity` is a constant-volume statistical-ensemble
  derivative and is not the supplied constant-magnetization heat capacity.
- The blueprint theorem environment has no `\lean{...}` mapping. A plan/review
  pass should map it to
  `IPhO2026Problems.IPhO2026_3_B_2.adiabatic_temperature_change`.
- No file-specific `/- USER: ... -/` hint was present because the assigned
  Lean file did not previously exist.

## Verification

- Lean LSP diagnostics succeed with one expected warning for the deliberate
  `sorry` body.
- `lake env lean
  IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` exits successfully with the
  same single expected warning.

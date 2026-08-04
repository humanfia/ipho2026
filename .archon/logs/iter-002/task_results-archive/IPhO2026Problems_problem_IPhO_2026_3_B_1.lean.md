# Autoformalization result: IPhO 2026 Problem 3 B.1

## Assumption/target split

### Governing laws

- `ParamagneticTorus` records the fixed volume `V`, amount of material `n`,
  material constants `K` and `lambda`, and vacuum permeability `mu_0`.
  Their fields are explicitly named SI numerical readouts and include the
  physical positivity/nonnegativity conditions.
- `ParamagneticTorusLaws.equationOfState` states
  `T * M(T, H) * V = n * K * H` for every temperature and field-intensity
  magnitude readout.
- `ParamagneticTorusLaws.heatCapacityLaw` states the supplied constitutive law
  `C_M(T) = n * lambda / T^2` away from `T = 0`.
- `ParamagneticTorusLaws.internalEnergyLaw` states `dU = C_M dT` using
  Mathlib's `HasDerivAt` on the joule readout of the Physlib dimensionful
  internal energy.
- `ParamagneticTorusLaws.magnetizationDifferentiable` supplies the regularity
  required to interpret `dM` along an isothermal field change.
- `ParamagneticTorusLaws.magneticWorkLaw` states the previous-part
  differential law `dW = mu_0 * V * H dM` as an oriented interval integral
  from `H_i` to `H_f`.
- `ParamagneticTorusLaws.isothermalFirstLaw` states
  `Delta U = Q + W` with heat and work entering the torus positive. Its two
  internal-energy endpoints have the same temperature because the process is
  isothermal.

### Previous-part results

- The natural-language result from A.3, `dW = mu_0 * V * H dM`, is represented
  directly by `magneticWorkLaw`.
- No Lean output from A.3 is imported, in accordance with the blueprint's
  `natural_language_prerequisite_only` policy.

### Figure/data readouts

- The official page 13 source image confirms that `H_i` and `H_f` are
  magnitudes of the magnetic-field intensity and that `T` is held constant.
  Their theorem hypotheses therefore use real SI readouts with
  `0 ≤ H_i`, `0 ≤ H_f`, and `0 < T`.
- The official preceding page confirms that the Pm-T state variables are
  `H`, `M`, and `T`; that its volume `V` is fixed; and that the tabulated laws
  are the equation of state, heat-capacity law, and internal-energy
  differential used above.
- `V` is retained in the physical setup and work law even though it cancels
  from the final closed form.
- Heat, work, and internal energy have type `DimEnergy`. The helper
  `energyInJoules` exposes only their scalar SI readout.
- This subquestion has no additional numbered-diagram geometry beyond the
  torus and the endpoint labels `H_i`, `H_f`.

### Current target conclusions

- `heatTransferredInto_isothermal` concludes exactly
  `Q = -(mu_0 * n * K / (2 * T)) * (H_f^2 - H_i^2)` for the joule readout of
  the heat entering the torus.
- This theorem corresponds to blueprint label
  `thm:physics:IPhO_2026_3_B_1:target`.

## Goal-faithfulness audit

The requested heat formula occurs only in the conclusion of
`heatTransferredInto_isothermal`. It does not occur in `ParamagneticTorus`, in
any field of `ParamagneticTorusLaws`, or in `energyInJoules`.

In particular, `isothermalHeatInto` is an unconstrained dimensionful physical
quantity until the governing first law relates it to internal-energy change
and magnetic work. `magneticWorkLaw` contains only the previous-part law
`mu_0 * V * H dM`, while `equationOfState` separately determines how `M`
depends on `H`. Thus neither premise merely restates the requested integrated
heat answer. The volume cancellation, quadratic endpoint term, factor `1/2`,
and overall heat sign all remain proof obligations.

`energyInJoules` is only the SI projection of a Physlib `DimEnergy`; unfolding
it cannot prove the target. Other real-valued parameters are explicitly named
SI scalar readouts of measured magnitudes or constants, not transparent
aliases pretending that physical quantities are bare reals.

## Declarations created

- `IPhO2026Problems.IPhO2026_3_B_1.energyInJoules`
- `IPhO2026Problems.IPhO2026_3_B_1.ParamagneticTorus`
- `IPhO2026Problems.IPhO2026_3_B_1.ParamagneticTorusLaws`
- `IPhO2026Problems.IPhO2026_3_B_1.heatTransferredInto_isothermal` —
  blueprint target `thm:physics:IPhO_2026_3_B_1:target`

The target theorem statement is ready for the deterministic blueprint
`\leanok` synchronization. The blueprint was not edited because the prover
role makes blueprint chapters read-only.

## LeanExplore queries/candidates actually used

All searches passed package filters `["Mathlib", "Physlib"]`.

- Queries `dimensionful physical quantity SI units temperature energy heat
  magnetic field magnetization volume`, `PhysLean physical quantity
  dimensions`, `DimTemperature DimEnergy DimVolume DimAmount
  DimMagneticField DimMagnetization`, `WithDim physical quantities SI units`,
  and `Dimensionful definition` returned `Dimension`, `Dimensionful`,
  `WithDim`, `DimEnergy`, and `UnitChoices.SI`. Source/module/docstring data
  were fetched for the candidates used in the file.
- Query `Electromagnetism.MagneticField` returned
  `Electromagnetism.MagneticField`; its source and module were fetched and
  assessed as a near miss because it models a spacetime magnetic `B` field,
  not the uniform scalar field-intensity magnitude `H` in this problem.
- Queries `interval integral derivative fundamental theorem of calculus`,
  `intervalIntegral integral_const_mul`, `deriv definition real function`,
  and `intervalIntegral notation integral over a b` grounded `deriv`, the
  oriented interval-integral notation, and the later proof-route lemmas
  `intervalIntegral.integral_deriv_eq_sub` and
  `intervalIntegral.integral_const_mul`. Their source/module data were
  fetched.
- Query `HasDerivAt definition derivative of real function` grounded the
  derivative vocabulary used for `dU = C_M dT`; the final name and syntax
  were verified by Lean elaboration.
- Query `paramagnetic material magnetization magnetic field intensity equation
  of state` found only general electromagnetic-field declarations, with no
  paramagnetic constitutive-law API.
- Query `thermodynamic first law heat work internal energy` returned
  `MicroHamiltonian.internalU`, `CanonicalEnsemble.heatCapacity`, and
  ideal-gas results. These concern statistical ensembles or ideal gases and
  do not state the signed first law for this paramagnetic process.

## PhysLean/Mathlib names grounded

- Physlib: `DimEnergy`, `UnitChoices.SI`, `Dimensionful`, and `WithDim`.
- Mathlib: `HasDerivAt`, `Differentiable`, `deriv`, and oriented
  `intervalIntegral` notation.
- Proof-route candidates:
  `intervalIntegral.integral_deriv_eq_sub` and
  `intervalIntegral.integral_const_mul`.

## Local abstractions introduced

- `ParamagneticTorus` is the smallest setup object that keeps the distinct
  roles and dimensional meanings of the fixed torus parameters without
  replacing physical primitives by scalar type aliases.
- `ParamagneticTorusLaws` is a local governing-law interface because no
  retrieved Physlib API models a paramagnetic torus, its magnetization
  equation of state, or its signed magnetic-work/heat process.
- Scalar fields in those structures are explicitly SI measurement readouts.
  Dimensionful energy quantities use Physlib's existing `DimEnergy` instead
  of a local wrapper.

## Grounding gaps and redraft requests

- No suitable Physlib declaration was found for magnetic field intensity
  `H`, magnetization magnitude `M`, paramagnetic equations of state, or the
  first law with the sign convention used here. The local law interface
  preserves exactly those roles.
- The read-only DAG navigation command was unavailable in this environment
  (`archon: command not found`). The blueprint itself identifies A.3 as the
  only prerequisite and forbids importing its Lean output.
- The blueprint target environment currently has no `\lean{...}` declaration
  mapping. A plan/review pass can map it to
  `IPhO2026Problems.IPhO2026_3_B_1.heatTransferredInto_isothermal` so the
  deterministic marker synchronizer can attach `\leanok`.
- No file-specific `/- USER: ... -/` hint was present because the assigned
  Lean file did not yet exist.

## Verification

Both the Lean LSP diagnostics and
`lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_1.lean` succeed with
exactly one expected warning, for the deliberate `sorry` body of
`heatTransferredInto_isothermal`.

# Autoformalization result: IPhO 2026 Problem 3 A.3

## Status

- Created `IPhO2026Problems/problem_IPhO_2026_3_A_3.lean`.
- The blueprint contains `% archon:physics`, so the physics-formalize
  discipline was used.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_3.lean` exits
  successfully. Its only diagnostics are the four expected
  `declaration uses sorry` warnings on the two general SI bridge theorems,
  the scalar A.3 bridge, and the main A.3 theorem.
- No `/- USER: ... -/` hint existed because the assigned Lean file did not
  exist before this lane.
- Both official source-page images were inspected. Figure 3a fixes the labels
  `R`, `r`, `V`, `A`, `N`, `I`, the common toroidal field orientation, and
  the dense winding. The A.3 page explicitly states the source/vacuum/material
  work split.

## Assumption/target split

### Governing laws

- `Assumptions.torusVolumeGeometry` records the thin-torus geometry
  `V = (2πR) A`.
- `Assumptions.ampereLaw` records Ampère's law on the mean circular path,
  `H (2πR) = N I`.
- `Assumptions.constitutiveLaw` records the supplied material relation
  `B = μ₀ (H + M)`.
- `Assumptions.differentialConstitutiveLaw` records its infinitesimal
  consequence `dB = μ₀ (dH + dM)`.
- `Assumptions.vacuumCoreIncrementLaw` records
  `dB_vac = μ₀ dH`.
- `Assumptions.vacuumCoreWorkLaw` applies the same electromagnetic source-work
  law to the comparison vacuum core:
  `dW_vac = V H dB_vac`.
- `Assumptions.sourceWorkSplit` records the premise stated in A.3:
  `dW_emf = dW_vac + dW`.
- `Assumptions.negligibleWireHeating` records the source-page approximation
  that resistive heating of the winding vanishes.

### Previous-part results

- `Assumptions.previousPartSourceWork` restates the allowed natural-language
  A.2 conclusion `dW_emf = V H dB`.
- It is included locally and does not import or depend on the sibling A.2 Lean
  file.

### Figure/data readouts

- `TorusData` retains the mean radius `R`, minor/cross-sectional radius `r`,
  volume `V`, cross-sectional area `A`, dense turn count `N`, instantaneous
  current `I`, vacuum permeability `μ₀`, uniform `H`, `B`, and `M`, the common
  toroidal orientation, the thinness tolerance, and the work sign convention.
- Length, area, volume, current, field strength, magnetization, flux density,
  permeability, and energy are all represented by Physlib dimensionful
  quantities rather than real aliases.
- Positivity fields record geometric sizes, `μ₀`, and nonnegative field
  magnitudes. `thinTorus` makes `r ≪ R` quantitative via a supplied
  dimensionless ratio in `(0,1)`.
- `FieldIncrements` retains signed `dH`, `dB`, `dM`, and `dB_vac`.
- `WorkIncrements` retains signed `dW_emf`, `dW_vac`, `dW`, and the neglected
  wire-heating work.
- `Assumptions.signConvention` fixes the source convention that positive work
  enters the system.

### Current target conclusions

- `materialWork_siValue_eq` concludes the scalar SI relation
  `dW = μ₀ V H dM`.
- `materialWork_eq_mu0_volume_H_dM` concludes equality of the full
  dimensionful material-work quantity with the energy whose SI value is
  `μ₀ V H dM`.

Both occurrences are theorem conclusions, never assumptions.

## Goal-faithfulness audit

- No field of `Assumptions`, `TorusData`, `FieldIncrements`, or
  `WorkIncrements` states the current answer
  `dW = μ₀ V H dM`.
- The work split is source-given setup, not the requested closed form. The
  vacuum-core and A.2 equations are genuine governing/previous-part laws.
- `energyFromSI` is a generic unit constructor from an arbitrary real joule
  value. It does not mention `μ₀`, `V`, `H`, `dM`, or material work, so the
  target is not true merely by unfolding it.
- `siValue` is only generic evaluation at `UnitChoices.SI`.
- The scalar answer appears only in `materialWork_siValue_eq` and the main
  theorem's conclusion. Both bodies are explicit statement-stage `sorry`
  obligations.
- Countermodel sanity check: deleting any of
  `differentialConstitutiveLaw`, `vacuumCoreIncrementLaw`,
  `previousPartSourceWork`, `vacuumCoreWorkLaw`, or `sourceWorkSplit` permits
  `materialWorkdW` to vary while the remaining assumptions hold. With all
  these equations present, subtraction forces its SI value to be
  `μ₀ V H dM`; fixed-dimension SI injectivity then forces the full energy
  equality. The contract is therefore noncircular and determined.

## Derivability and bridge obligations

1. **Physical dimensions and SI readouts — covered.**
   Source claim: all geometry, electromagnetic quantities, and work have their
   stated dimensional roles. Lean carrier: Physlib `Dimensionful`, `WithDim`,
   `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`, `Dimension.M𝓭`,
   `Dimension.C𝓭`, `DimEnergy`, and `UnitChoices.SI`, plus the local
   dimension aliases and `siValue`. Evidence: the relevant declaration source
   and modules were inspected through LeanExplore and the installed Physlib
   sources.

2. **Figure 3a thin-torus setup — covered.**
   Source claim: a torus of labels `R`, `r`, `V`, `A`, with `r ≪ R`, has a
   dense `N`-turn winding carrying `I`. Lean carrier: `TorusData`, the explicit
   positivity/thinness fields, `torusVolumeGeometry`, and `ampereLaw`.
   Evidence: both official page images were inspected.

3. **Uniform parallel field reduction — covered.**
   Source claim: `H`, `B`, and `M` are approximately uniform and `M` is
   parallel to `H`. Lean carrier: `TorusData` stores scalar components along
   one shared `ToroidalOrientation`, with nonnegative finite magnitudes.
   This model rules out independent transverse components rather than using an
   unconstraining opaque predicate.

4. **Constitutive increment — covered.**
   Source claim: differentiating `B = μ₀(H+M)` at constant `μ₀` gives
   `dB = μ₀(dH+dM)`. Lean carrier:
   `Assumptions.constitutiveLaw` and
   `Assumptions.differentialConstitutiveLaw`. The latter is the direct
   equation usable by the later proof.

5. **Previous-part source work — covered.**
   Source claim: A.2 gives `dW_emf = V H dB`. Lean carrier:
   `Assumptions.previousPartSourceWork`, restated locally under the
   natural-language-prerequisite policy.

6. **Vacuum-core subtraction term — covered.**
   Source claim: a vacuum core has `dB_vac = μ₀ dH`, and A.2 therefore gives
   `dW_vac = V H μ₀ dH`. Lean carriers:
   `vacuumCoreIncrementLaw` and `vacuumCoreWorkLaw`.

7. **Work decomposition and algebraic cancellation — covered.**
   Source claim: `dW_emf = dW_vac + dW`; substituting the two constitutive
   increments cancels the `dH` term. Lean carriers:
   `Assumptions.sourceWorkSplit` and theorem
   `materialWork_siValue_eq`. Elementary ordered-ring algebra is sufficient
   after rewriting the exposed equations.

8. **SI equality to physical energy equality — covered.**
   Source claim: the work relation is an equality of energies, not merely
   unrelated scalar readings. Lean carriers: general theorem
   `dimensionful_ext_si`, constructor `energyFromSI`, and theorem
   `siValue_energyFromSI`. Physlib's `Dimensionful` scaling law makes
   evaluation at one unit choice injective.

9. **Complete source-to-contract mapping — covered.**
   Lean carrier:
   `IPhO2026Problems.Problem3A3.materialWork_eq_mu0_volume_H_dM`.
   Its only premise is the source-derived data/law interface, and its
   conclusion is the recorded A.3 answer as an equality of dimensionful
   energies.

No substantive source-to-Lean bridge is blocked at the statement layer.

## Abstraction sufficiency and countermodel audit

- `Assumptions` is the only local `Prop`-valued interface. Every substantive
  field is an exposed equality or inequality: positivity, thinness,
  geometry, Ampère's law, static and differential constitutive laws, vacuum
  comparison, source-work equations, work decomposition, sign convention,
  and zero wire loss. It has no opaque witness-only relation.
- `TorusData`, `FieldIncrements`, and `WorkIncrements` are data-valued
  structures, not `Prop` interfaces.
- The common-orientation scalar model is constraining: `H`, `B`, and `M` have
  no independent transverse components, and finite magnitudes are
  nonnegative. Signed increments remain free to describe increasing or
  decreasing fields.
- The quantity aliases are all built over Physlib's unit-covariant
  `Dimensionful (WithDim d ℝ)` type. They are not transparent aliases to
  `ℝ` and are not local one-field wrappers.
- Countermodel audit: the source equations determine the SI value of
  `materialWorkdW`; `dimensionful_ext_si` then excludes a second energy with
  the same SI value but a different response to unit changes. Thus no model
  satisfying all premise fields can freely falsify the current conclusion.

## Uncertainty and branch coverage

- **Uncertainty: not applicable.** The source gives exact symbolic relations
  and no `value ± uncertainty` or experimental error.
- **Thin-torus approximation: covered.** The approximation is retained as an
  explicit dimensionless tolerance and inequality, rather than discarded.
- **Toroidal orientation: covered.** A clockwise/counterclockwise common
  orientation is stored in `TorusData`; `H`, `B`, and `M` are components along
  it, while all infinitesimal changes are signed.
- **Magnetization branch: covered.** Nonnegative `H` and `M` magnitudes in the
  same orientation encode the paramagnetic parallel branch.
- **Energy-transfer sign: covered.** `Assumptions.signConvention` fixes
  `positiveIntoSystem`; the source, vacuum, material, and wire work quantities
  are signed under that convention.
- **Heat sign: not applicable to this subquestion.** No heat transfer appears
  in A.3's requested relation. The only parasitic heating mentioned on the
  source page is explicitly set to zero.

## Declarations created and corresponding blueprint labels

All declarations are in namespace
`IPhO2026Problems.Problem3A3`.

- Physical quantity layer: `Length`, `Volume`, `Area`, `ElectricCurrent`,
  `MagneticFieldStrength`, `Magnetization`, `MagneticFluxDensity`,
  `VacuumPermeability`, `Energy`, `siValue`, and `energyFromSI`.
- General unit bridges: `dimensionful_ext_si` and
  `siValue_energyFromSI`.
- Figure/model data: `ToroidalOrientation`, `WorkSignConvention`,
  `TorusData`, `FieldIncrements`, and `WorkIncrements`.
- Governing interface: `Assumptions`.
- Scalar target bridge: `materialWork_siValue_eq`.
- Blueprint label `thm:physics:IPhO_2026_3_A_3:target` maps to
  `IPhO2026Problems.Problem3A3.materialWork_eq_mu0_volume_H_dM`.

The target environment is ready for statement-level `\leanok`. Per prover
permissions and `.archon/AGENTS.md`, the blueprint was not edited; the
deterministic synchronization/review step should attach the fully qualified
`\lean{...}` name and marker.

## LeanExplore queries/candidates actually used

- Query:
  `electromagnetism magnetic field magnetization permeability Ampere law work differential physical units`
  with packages `["Mathlib", "Physlib"]`.
  - Inspected `Electromagnetism.MagneticField`; it is a spacetime vector
    field and is a near miss for the source's already-uniform scalar
    magnitude model.
- Query:
  `physical quantity with dimensions units SI energy volume magnetic field permeability`
  with packages `["Mathlib", "Physlib"]`.
  - Used candidates `Dimensionful`, `DimEnergy`, `UnitChoices.SI`,
    `DimEnergy.joule`, and `Dimension`.
- Query:
  `Dimensionful physical quantity SI unit value dimensions`
  with packages `["Mathlib", "Physlib"]`.
  - Used `Dimensionful` and inspected its source in
    `Physlib.Units.Basic`.
- Source/module fetches were made for `Dimensionful`, `DimEnergy`,
  `Electromagnetism.MagneticField`, `DimEnergy.joule`, and
  `UnitChoices.SI`.

## PhysLean/Mathlib names grounded

- Physlib: `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`,
  `Dimension.M𝓭`, `Dimension.C𝓭`, `Dimensionful`, `WithDim`,
  `CarriesDimension.toDimensionful`, `UnitChoices.SI`, and `DimEnergy`.
- Mathlib: `Real.pi` and the real-number ordered-ring operations used in the
  explicit equations.

## Local abstractions introduced

- Problem-specific dimension aliases were composed from Physlib base
  dimensions for volume, current, field strength, magnetization, flux
  density, and vacuum permeability. No ready-made named aliases matching all
  of these scalar quantities were located.
- `TorusData` is the smallest data structure retaining all apparatus labels,
  material/uniformity roles, the common field orientation, and the sign
  convention.
- `FieldIncrements` separates actual and comparison-vacuum field changes.
- `WorkIncrements` separates source, vacuum, material, and parasitic work.
- `Assumptions` is a faithful local law interface because it exposes every
  physical consequence needed by a later proof as an equation or inequality.

## Grounding gaps

- No Physlib API was located for a homogeneous isotropic paramagnetic torus,
  magnetization, magnetic field strength `H`, or vacuum-core work
  subtraction. These roles are represented locally with Physlib dimensions
  and explicit governing equations.
- `Electromagnetism.MagneticField` models a spacetime-to-vector map and does
  not directly represent the source's uniform toroidal scalar magnitude.
- Physlib's ready-made `DimArea` uses a nonnegative scalar carrier, while this
  file uses a uniform real-valued dimensionful carrier plus explicit
  positivity for all setup quantities.
- The `archon` executable was unavailable on this lane's `PATH`, so
  `dag-query` could not be run. The blueprint itself marks A.2 as a
  natural-language-only prerequisite, which is restated locally without a
  sibling import.

## Redraft requests

- The blueprint target currently has no `\lean{...}` declaration annotation.
  The plan/review or synchronization step should associate it with
  `IPhO2026Problems.Problem3A3.materialWork_eq_mu0_volume_H_dM`.
- No source-physics redraft is required.

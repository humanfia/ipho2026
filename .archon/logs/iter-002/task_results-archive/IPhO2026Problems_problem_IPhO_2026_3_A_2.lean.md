# IPhO2026Problems/problem_IPhO_2026_3_A_2.lean

## Result

- Created a physics-specific formalization for IPhO 2026 Problem 3 A.2.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_2.lean` succeeds.
- The only diagnostics are the two expected `declaration uses sorry` warnings,
  for the intermediate bridge lemma and the main target theorem.
- The chapter contains `% archon:physics`, so the physics-formalize discipline
  was used.
- No `/- USER: ... -/` hint was present because the assigned file did not
  previously exist.

## Assumption/target split

### Governing laws

- The thin-torus scalar approximation is represented by dimension-tagged,
  spatially uniform magnitudes `fieldStrength`, `fluxDensity`, and
  `magnetization`.
- `UniformParamagneticState.homogeneousIsotropicParamagneticLaw` states
  `M = χ H`, with `χ > 0`; this carries homogeneity, isotropy, paramagnetism,
  and the source statement that `M` is parallel to `H`.
- `UniformParamagneticState.magneticConstitutiveLaw` states
  `B = μ₀ (H + M)`.
- `UniformParamagneticState.ampereCircuitLaw` states Ampère's law around the
  mean toroidal loop.
- `InfinitesimalMagneticChange.fluxPerTurnLaw` states
  `dΦ = A dB`.
- `InfinitesimalMagneticChange.denseWindingFluxLinkageLaw` states
  `dΛ = N dΦ`.
- `InfinitesimalMagneticChange.externalSourceFaradayLaw` states that the
  external-source voltage time-integral has the positive polarity
  `∫U_ext dt = dΛ`.
- `InfinitesimalMagneticChange.sourcePowerWorkLaw` states
  `dW_emf = I ∫U_ext dt`.
- `InfinitesimalMagneticChange.negligibleWireHeating` states that resistive
  wire heating is zero.

### Previous-part results

- `UniformParamagneticState.previousPartFieldMagnitude` records the allowed
  natural-language prerequisite from A.1:
  `H = N I A / V`.
- There is no import of, or Lean dependency on, the sibling A.1 file.

### Figure/data readouts

- `ThinToroidalGeometry` records Figure 3a's mean radius `R`, minor/cross-section
  radius `r`, labelled diameter `2r`, cross-section area `A`, and volume `V`.
- Its equations record `2r`, circular cross-section area, and
  `V = 2πRA`.
- The qualitative `r ≪ R` approximation is made explicit through a positive
  dimensionless `thinnessBound < 1` and `r ≤ thinnessBound * R`.
- `IdealToroidalWinding` records the insulated dense winding, turn count `N`,
  instantaneous current `I`, and chosen clockwise/counterclockwise positive
  orientation.

### Current target conclusions

- The intermediate lemma concludes `dW_emf = I N A dB`.
- `external_source_work_for_flux_density_change` concludes exactly the
  requested relation `dW_emf = V H dB`.

## Goal-faithfulness audit

The requested `dW_emf = V H dB` relation occurs only as the conclusion of
`external_source_work_for_flux_density_change`. It is not a structure field,
hypothesis, local definition, governing-law predicate, or previous-part
assumption.

The closest premise involving `dW_emf` is the independent electrical work law
`dW_emf = I ∫U_ext dt`. The remaining premises separately constrain flux per
turn, `N`-turn linkage, Faraday polarity, and the A.1 field result. Consequently
the target is obtained only after eliminating the intermediate quantities and
substituting A.1. No definition unfolds directly to the target.

## Derivability and bridge obligations

1. **Physical dimensions of all scalar magnitudes**
   - Source claim: `R`, `r`, `A`, `V`, `I`, `H`, `M`, `B`, `μ₀`, magnetic
     flux, and work have distinct dimensional roles.
   - Lean carrier: local `Dimension` expressions and `WithDim d ℝ` fields.
   - Evidence: Physlib's `Dimension` and `WithDim` declarations.
   - Status: **covered**.

2. **Figure 3a geometry and thin-torus approximation**
   - Source claim: diameter `2r`, circular toroidal geometry, and `r ≪ R`.
   - Lean carrier: `ThinToroidalGeometry.diameter_eq_two_minorRadii`,
     `.circularCrossSection`, `.torusVolume`, and
     `.minorRadius_le_thinness`.
   - Evidence: official source pages `T3_page-1.png` and `T3_page-2.png`.
   - Status: **covered**.

3. **Uniform homogeneous isotropic paramagnetic state**
   - Source claim: `M ∥ H` and `B = μ₀H + μ₀M`.
   - Lean carrier:
     `UniformParamagneticState.homogeneousIsotropicParamagneticLaw` and
     `.magneticConstitutiveLaw`.
   - Evidence: official source page 1 and the blueprint context.
   - Status: **covered**.

4. **Ampère/previous-part bridge**
   - Source claim: `∮ H·dl = I_C`, yielding A.1's `H = NIA/V`.
   - Lean carrier: `UniformParamagneticState.ampereCircuitLaw` and
     `.previousPartFieldMagnitude`.
   - Evidence: official A.1 text and the blueprint's reusable previous-part
     conclusion.
   - Status: **covered** as an explicit natural-language prerequisite.

5. **Uniform flux through one turn**
   - Source claim: under the uniform-field approximation, `dΦ = A dB`.
   - Lean carrier: `InfinitesimalMagneticChange.fluxPerTurnLaw`.
   - Evidence: dense toroidal winding and uniform `B` in the source setup.
   - Status: **covered**.

6. **Flux linkage of `N` dense turns**
   - Source claim: `dΛ = N dΦ`.
   - Lean carrier:
     `InfinitesimalMagneticChange.denseWindingFluxLinkageLaw`.
   - Evidence: the source states a dense winding with `N` turns.
   - Status: **covered**.

7. **Faraday-law polarity for the external source**
   - Source claim: the external source balances the induced emf, so in the
     selected positive current/flux orientation `∫U_ext dt = dΛ`.
   - Lean carrier:
     `InfinitesimalMagneticChange.externalSourceFaradayLaw` together with
     `.orientation_agrees_with_winding`.
   - Evidence: the external emf source and the signed work convention shown in
     Figure 3a/source page 1.
   - Status: **covered** by a local governing-law equation; no matching
     circuit-level Physlib declaration was found.

8. **Electrical power-to-work bridge**
   - Source claim: `dW_emf = I U_ext dt`.
   - Lean carrier: `InfinitesimalMagneticChange.sourcePowerWorkLaw`.
   - Evidence: standard source-power law under the source's negligible wire
     resistance approximation.
   - Status: **covered** by a local governing-law equation.

9. **Elimination to `dW_emf = I N A dB`**
   - Source claim: combine the preceding three electromagnetic equations.
   - Lean carrier: `source_work_eq_current_turns_area_dB`.
   - Evidence: its contract is exactly the algebraic elimination of the four
     constraining process fields.
   - Status: **covered**; proof intentionally deferred with `sorry` at the
     autoformalize stage.

10. **Substitution of A.1 into the requested formula**
    - Source claim: `INA = VH`, hence `dW_emf = VH dB`.
    - Lean carrier: `external_source_work_for_flux_density_change`, using
      `source_work_eq_current_turns_area_dB`,
      `previousPartFieldMagnitude`, and `volume_pos`.
    - Evidence: direct algebra from A.1 and the intermediate work expression.
    - Status: **covered**; proof intentionally deferred with `sorry`.

## Abstraction sufficiency and countermodel audit

- `ThinToroidalGeometry` is constrained by positivity inequalities, a strict
  thinness bound, the `2r` equation, the circular-area equation, and the torus
  volume equation. It is not an unconstrained geometry tag.
- `IdealToroidalWinding` is constrained by positive turn count and nonnegative
  current; its orientation is consumed by the process orientation equation.
- `UniformParamagneticState` is constrained by positivity, `M = χH`,
  `B = μ₀(H+M)`, the toroidal Ampère equation, and the explicit A.1 equation.
  Its descriptive material properties therefore expose usable equalities.
- `SignConsistentEnergyTransfer` is the only standalone local `Prop`-valued
  relation. It unfolds to `0 ≤ amount.val` for transfer into the torus and
  `amount.val ≤ 0` for transfer out, so it has direct inequality consequences.
- `SignedEnergyTransfer` packages the amount, direction, and the preceding
  sign inequality; it is not a scalar alias.
- `InfinitesimalMagneticChange` is constrained by an orientation equality,
  three flux/emf equations, the source work equation, and zero wire heat.

Countermodel sanity check: an arbitrary interpretation satisfying all process
equations necessarily forces `dW_emf = I N A dB`; the A.1 equation and
`V > 0` then force `I N A = VH`. Thus all assumptions cannot remain true while
the main conclusion is false in the real-number readout model.

## Uncertainty and branch coverage

- **Uncertainty: not applicable.** Neither the blueprint nor the official
  source reports a measured value with an uncertainty or error bar. The
  symbolic thin-torus approximation is represented by `thinnessBound`; it is
  not recast as measurement uncertainty.
- **Signed increment: covered.** `fluxDensityChange.val` is a signed real
  increment, so both increasing and decreasing `B` are represented.
- **Winding/flux orientation: covered.** Clockwise and counterclockwise
  orientations are explicit, and the process requires the positive flux
  orientation to agree with the winding convention.
- **Energy-transfer direction: covered.** `intoTorus` and `outOfTorus` are
  explicit branches, with inequalities implementing the stated convention for
  both work and heat.
- **External-source sign: covered.** The positive Faraday polarity is stated
  explicitly rather than selected only in the final conclusion.

## Declarations created and blueprint correspondence

- Dimension definitions:
  `areaDimension`, `volumeDimension`, `electricCurrentDimension`,
  `magneticFieldStrengthDimension`, `magneticFluxDensityDimension`,
  `permeabilityDimension`, `magneticFluxDimension`, and `energyDimension`.
- Physical interfaces:
  `ThinToroidalGeometry`, `ToroidalOrientation`, `IdealToroidalWinding`,
  `UniformParamagneticState`, `EnergyTransferDirection`,
  `SignConsistentEnergyTransfer`, `SignedEnergyTransfer`, and
  `InfinitesimalMagneticChange`.
- Bridge lemma: `source_work_eq_current_turns_area_dB`.
- Main declaration:
  `IPhO2026Problems.Problem3A2.external_source_work_for_flux_density_change`
  corresponds to
  `thm:physics:IPhO_2026_3_A_2:target`.
- The target environment is formalized with a `sorry` body and is ready for
  the automated marker sync. The blueprint was not edited because prover
  permissions make it read-only.

## LeanExplore queries/candidates actually used

1. Query: `physical quantity dimensions SI units energy work magnetic flux
   magnetic field strength current volume area`
   - Used candidate: `DimEnergy` as confirmation of Physlib's SI energy
     dimension convention.
   - Used candidates for API selection: `Dimension`, `WithDim`.

2. Query: `Dimensional scalar quantity with a physical dimension
   multiplication division PhysLean`
   - Used candidate: `WithDim`.
   - Inspected `WithDim.instHMulRealHMulDimension` to confirm dimension-tagged
     scalar multiplication support.

3. Query: `DimLength DimArea DimVolume DimCurrent DimMagneticField
   DimMagneticFlux DimEnergy WithDim`
   - Used candidates: `Dimension`, `WithDim`, `DimEnergy`, and `DimArea`.
   - `DimEnergy` is a `Dimensionful` subtype across unit choices, whereas this
     problem needs explicit coherent-unit scalar readouts at each equation;
     the lower-level `WithDim` carrier was therefore selected.

4. Query: `Dimension electric current I𝓭 magnetic flux density magnetic field
   strength SI base dimensions`
   - Used candidate: `Dimension.C𝓭`.
   - Physlib uses charge rather than current as a base dimension, so current is
     faithfully encoded as `C𝓭 * T𝓭⁻¹`.

5. Query: `Faraday law induced electromotive force magnetic flux voltage
   circuit current work`
   - Candidates such as `Electromagnetism.MagneticField` concerned continuum
     relativistic field objects, not the lumped `N`-turn circuit law required
     here; none was used.

6. Query: `Real.pi circle area circumference`
   - Used candidate: `Real.pi`.

## PhysLean/Mathlib names grounded

- Physlib: `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`,
  `Dimension.M𝓭`, `Dimension.C𝓭`, and `WithDim`.
- Mathlib: `Real.pi`, real inequalities/arithmetic, and natural-to-real casts.
- Imports used: `Physlib.Units.WithDim.Basic` and `Mathlib`.

## Local abstractions introduced

- Electromagnetic dimensions not already exposed as the needed scalar types
  were built compositionally from Physlib base dimensions.
- `ThinToroidalGeometry` preserves the labelled apparatus geometry and the
  small-radius approximation rather than replacing them with unrelated reals.
- `UniformParamagneticState` preserves the distinct physical roles of `H`,
  `B`, `M`, and `μ₀`, with dimension tags and explicit material/Ampère laws.
- `InfinitesimalMagneticChange` preserves the physical derivation by exposing
  flux, linkage, voltage-time, work, heat, and wire-loss quantities separately.
- The local Faraday and power laws are mathematical equations with reusable
  consequences, not opaque predicates.

## Grounding gaps

- LeanExplore found no lumped-circuit Physlib API for Faraday's law, flux
  linkage of a dense `N`-turn winding, or external-source electrical work.
  Faithful local equation fields were introduced instead.
- The `archon` DAG navigation executable advertised in the task prompt was not
  available on this runtime's `PATH`; this did not block the formalization
  because A.1's exact reusable conclusion was present in the blueprint/source
  report.

## Redraft requests

- None.

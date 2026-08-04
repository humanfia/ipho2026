# Autoformalization result: IPhO 2026 Problem 3 A.3

## Assumption/target split

### Governing laws

- `SatisfiesWorkModel.constitutiveLaw` states the supplied material relation
  `B = μ₀ H + μ₀ M` for the uniform toroidal scalar readouts.
- `SatisfiesWorkModel.incrementalConstitutiveLaw` states its infinitesimal
  consequence `dB = μ₀ dH + μ₀ dM`.
- `SatisfiesWorkModel.ampereLawForMeanToroidalLoop` states Ampère's law on the
  mean loop, `H (2πR) = N I`.
- `SatisfiesWorkModel.vacuumCoreIncrement` states the vacuum reference
  relation `dB_vac = μ₀ dH`.
- `SatisfiesWorkModel.vacuumCoreWork_from_A2` applies the general source-work
  law to that vacuum reference.
- `SatisfiesWorkModel.sourceWork_partition` records the problem's given
  division `dW_emf = dW_vac + dW`.
- Positivity and nonnegativity fields record the physical domains of lengths,
  volume, area, turn count, current magnitude, `H`, `B`, `M`, and `μ₀`.

### Previous-part results

- `SatisfiesWorkModel.sourceWork_previousPart_A2` restates the natural-language
  A.2 conclusion `dW_emf = V H dB`.
- `vacuumCoreWork_from_A2` is the same independently supplied A.2 law applied
  to the vacuum-core comparison.
- No previous Lean output is imported, in accordance with the chapter's
  `natural_language_prerequisite_only` policy.

### Figure/data readouts

- `ParamagneticToroid` retains Fig. 3a's `R`, `r`, `V`, and `A`, including the
  circular cross-section relation, the mean-path volume relation, and an
  explicit dimensionless small-parameter witness for `r ≪ R`.
- `DenseInsulatedWinding` retains the dense insulated winding's `N` turns and
  instantaneous current `I`.
- `UniformMagneticState` retains the approximately uniform scalar magnitudes
  `H`, `B`, and `M`; their common toroidal direction and nonnegativity encode
  the stated `M ∥ H` magnitude convention.
- `UniformMagneticIncrement` retains `dH`, `dB`, `dM`, and the vacuum-reference
  `dB_vac`.
- `WorkIncrementReadouts` retains `dW_emf`, `dW_vac`, and `dW` as signed joule
  readouts under the source's convention that work entering the torus is
  positive.
- The official source images were inspected: page 11 supplies Fig. 3a and the
  labels above; page 12 states the A.2/A.3 work decomposition.

### Current target conclusion

- `materialWork_eq_mu0_mul_volume_mul_H_mul_dM` concludes exactly
  `dW = μ₀ V H dM`.

## Goal-faithfulness audit

The requested formula occurs only in the conclusion of
`materialWork_eq_mu0_mul_volume_mul_H_mul_dM`. It does not occur in
`ParamagneticToroid`, `DenseInsulatedWinding`, either readout structure, or
`SatisfiesWorkModel`. In particular, `sourceWork_partition` is only the
problem-given decomposition into vacuum and material contributions, while the
vacuum and source works are constrained separately by A.2 and the vacuum
constitutive increment. A later proof must substitute those independent laws,
use `dB = μ₀(dH + dM)`, cancel the vacuum `dH` term, and normalize the resulting
ring expression. No helper definition unfolds to the requested result.

## Declarations created and blueprint correspondence

- `ScaleSeparation`
- `ParamagneticToroid`
- `DenseInsulatedWinding`
- `UniformMagneticState`
- `UniformMagneticIncrement`
- `WorkIncrementReadouts`
- `SatisfiesWorkModel`
- `IPhO2026Problems.IPhO2026_3_A_3.materialWork_eq_mu0_mul_volume_mul_H_mul_dM`,
  corresponding to blueprint label
  `thm:physics:IPhO_2026_3_A_3:target`.

The target statement compiles with its required `by sorry` body and is ready
for deterministic blueprint `\leanok` synchronization. The blueprint currently
has no `\lean{...}` declaration name; the plan/review layer should attach
`\lean{IPhO2026Problems.IPhO2026_3_A_3.materialWork_eq_mu0_mul_volume_mul_H_mul_dM}`.
The blueprint was not edited because the project-specific prover permissions
make it read-only and assign marker management to synchronization/review.

## LeanExplore queries/candidates actually used

Every query used package filters `["Mathlib", "Physlib"]`.

- `dimensionful physical quantity SI units energy volume magnetic field
  magnetization permeability` found `UnitChoices.SI`, `DimEnergy`,
  `Dimensionful`, and `Electromagnetism.MagneticField`.
- `electromagnetism magnetic field magnetization Ampere law toroid` found the
  PhysLean relativistic electromagnetic field API but no toroidal
  magnetization or material Ampère-law declaration.
- `Dimensionful Dimension physical units` and `PhysLean Units SI` found
  `Dimension`, `Dimensionful`, `WithDim`, and the SI unit-choice API.
- Targeted searches for `DimVolume`, `DimMagneticField`, `DimMagnetization`,
  `DimPermeability`, `DimCurrent`, and `DimWork` found `DimEnergy` and the
  generic dimensional framework, but no packaged types matching the scalar
  toroidal `H`, `B`, `M`, current, volume, or permeability roles needed here.
- Source/module/docstring data were fetched for `Dimension`, `WithDim`,
  `DimEnergy`, `UnitChoices.SI`, `Electromagnetism.MagneticField`, and
  `Electromagnetism.EMSystem`. Of these, `Electromagnetism.EMSystem` is used
  directly for the physical free-space permeability `μ₀`.

## PhysLean/Mathlib names grounded

- PhysLean/Physlib: `Electromagnetism.EMSystem` and its projection
  `Electromagnetism.EMSystem.μ₀` are used directly.
- Assessed but not used because of model mismatch:
  `Electromagnetism.MagneticField`, `Dimension`, `Dimensionful`, `WithDim`,
  `DimEnergy`, and `UnitChoices.SI`.
- Mathlib: `Real.pi`, real powers, casts, and ordered-real relations support
  the geometric and scalar-readout model; their availability was confirmed by
  the Lean compiler.
- Imports used: `Mathlib` and `Physlib.Electromagnetism.Basic`.

## Local abstractions introduced

- `ScaleSeparation` keeps the asymptotic role of `r ≪ R` through an explicit
  dimensionless ratio without inventing an unsupported numerical cutoff.
- `ParamagneticToroid` and `DenseInsulatedWinding` preserve the distinct
  apparatus roles and figure labels rather than replacing the apparatus by
  unrelated scalars.
- The magnetic, increment, and work structures group explicit SI scalar
  readouts. Reals are used only as measured magnitudes/components, geometric
  measurements, and signed joule readouts, as permitted by the physics
  modeling rules; no physical primitive is introduced as a transparent
  scalar alias or a one-field wrapper.
- `SatisfiesWorkModel` is a faithful local governing-law interface because
  PhysLean has no packaged macroscopic magnetization/toroid-work API. It states
  the supplied physics laws directly and omits the current answer.

## Grounding gaps

- `Electromagnetism.MagneticField` is a spacetime-dependent Euclidean vector
  field. It is not the approximately uniform toroidal scalar magnitude used by
  this problem.
- No matching PhysLean declaration was found for macroscopic magnetization,
  the constitutive law `B = μ₀(H + M)`, Ampère's law for a toroidal magnetic
  material, or the vacuum/material work decomposition.
- The read-only `archon dag-query` command advertised by the task was
  unavailable in the shell (`archon: command not found`). The chapter itself
  identifies A.2 as a natural-language-only prerequisite.
- No file-specific `/- USER: ... -/` hint was present because the assigned Lean
  file did not exist before this autoformalization.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages` reported no errors and
  exactly one expected `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_3.lean` exited
  successfully with exactly the expected `sorry` warning.

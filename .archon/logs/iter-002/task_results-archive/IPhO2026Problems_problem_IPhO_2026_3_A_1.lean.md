# Autoformalization result: IPhO 2026 T3-A1

## Assumption/target split

### Governing laws

- `ToroidalAmpereLaw` is the uniform-field reduction of Ampère's circuital
  law: `H (2πR) = N I`.
- `HomogeneousIsotropicParamagneticTorus.volume_eq_meanCircumference_mul_area`
  records the torus geometry relation `V = (2πR) A`.
- `ParamagneticConstitutiveLaw` records the contextual material law
  `B = μ₀ H + μ₀ M` along the common toroidal direction.
- Positivity of `R`, `r`, `A`, and `μ₀`, nonnegativity of the field
  magnitudes/current magnitude, and a dimensionless thinness bound encode the
  magnitude and thin-torus assumptions needed by the model.

### Previous-part results

- None. T3-A1 is the first subquestion, and the source report lists no previous
  parts.

### Figure/data readouts

- `apparatusFigureLabel` records the official label `Fig. 3a`.
- `meanRadius`, `minorRadius`, `crossSectionArea`, and `volume` represent
  `R`, the cross-sectional radius `r` marked by diameter `2r`, `A`, and `V`.
- `DenseInsulatedWinding.turnCount` and `.currentMagnitude` represent `N` and
  the instantaneous current magnitude `I`.
- `UniformToroidalMagneticState` records the approximately uniform magnitudes
  `H`, `B`, and `M`. Its scalar magnetization is along the field-strength
  direction, matching the isotropic paramagnetic setup.
- The official page image resolves the curated phrase “inner radius” as the
  cross-sectional/minor radius shown by the `2r` diameter in Fig. 3a.

### Current target conclusion

- `fieldStrength_eq_turns_current_area_div_volume` concludes exactly
  `H = N I A / V`, expressed using SI readouts of dimensionful quantities.

## Goal-faithfulness audit

- The target formula occurs only as the conclusion of
  `fieldStrength_eq_turns_current_area_div_volume`.
- No premise field, governing-law predicate, or helper definition contains
  `H = N I A / V`.
- `ToroidalAmpereLaw` contains the source law `H (2πR) = N I`; the separate
  geometry field contains `V = (2πR) A`. Neither assumption alone is the target.
- `siValue` only projects a Physlib dimensionful quantity to its SI scalar
  readout, and `meanLoopLengthSI` only names `2πR`; neither definition makes
  the target true by unfolding.
- The constitutive law is preserved as contextual physics but is not treated as
  a route to the A1 result.

## Derivability and bridge obligations

1. **Source claim:** Ampère's line integral around the torus equals the enclosed
   free current.
   **Lean carrier:** `ToroidalAmpereLaw`, whose exposed equation is
   `siValue H * meanLoopLengthSI torus = N * siValue I`.
   **Evidence:** the official T3-A page states
   `∮ H · dl = I_C`; approximate uniformity and the Fig. 3a mean loop give the
   reduced scalar equation.
   **Status:** covered.

2. **Source/geometry claim:** a torus with mean circumference `2πR` and
   cross-sectional area `A` has volume `V = (2πR) A`.
   **Lean carrier:**
   `HomogeneousIsotropicParamagneticTorus.volume_eq_meanCircumference_mul_area`.
   **Evidence:** exact equation exposed as a structure field, with `R > 0` and
   `A > 0`.
   **Status:** covered.

3. **Reasoning bridge:** eliminate `2πR` between the Ampère and volume
   equations and cancel nonzero `R` and `A`.
   **Lean carrier:** the main theorem contract together with
   `meanRadius_pos`, `crossSectionArea_pos`, and Mathlib's `Real.pi_pos`.
   **Evidence:** an Archon Lean LSP in-memory attempt using `field_simp` and
   `nlinarith` closed the theorem goal without extra hypotheses.
   **Status:** covered.

4. **Dimensional bridge:** `N I A / V` has dimension current/length, matching
   `H`.
   **Lean carrier:** Physlib `Dimension`, `WithDim`, and `Dimensionful`; the
   aliases use `C𝓭 / T𝓭` for current, `L𝓭 * L𝓭` for area,
   `L𝓭 * L𝓭 * L𝓭` for volume, and `(C𝓭 / T𝓭) / L𝓭` for `H`.
   **Evidence:** all declarations elaborate under the grounded Physlib units
   modules.
   **Status:** covered.

5. **Context bridge:** the vector relation `B = μ₀H + μ₀M` reduces to a scalar
   magnitude equation because `M` is parallel to `H` in the isotropic
   paramagnet.
   **Lean carrier:** `ParamagneticConstitutiveLaw` and the common-direction
   interpretation of `UniformToroidalMagneticState`.
   **Evidence:** the predicate exposes the full scalar equation and does not
   constrain `H` to the requested answer.
   **Status:** covered, though not needed in the A1 algebra.

## Abstraction sufficiency and countermodel audit

- `ParamagneticConstitutiveLaw` is not opaque: unfolding exposes
  `B = μ₀ H + μ₀ M` as a real equation.
- `ToroidalAmpereLaw` is not opaque: unfolding exposes
  `H (2πR) = N I` as a real equation.
- `HomogeneousIsotropicParamagneticTorus` exposes strict positivity, the
  quantitative thinness inequality `r ≤ εR` with `0 < ε < 1`, and the exact
  volume equation.
- `DenseInsulatedWinding` exposes a positive natural turn count and a
  nonnegative instantaneous current magnitude.
- `UniformToroidalMagneticState` exposes nonnegativity of all three uniform
  magnitudes.
- Countermodel sanity check: once `ToroidalAmpereLaw`, the volume equation,
  `R > 0`, and `A > 0` hold, arbitrary interpretations cannot make the target
  false. The successful in-memory algebraic proof attempt confirms this.
  The constitutive-law predicate alone is not claimed to imply A1.
- No opaque local `Prop`-valued interface was introduced.

## Uncertainty and branch coverage

- **Uncertainty:** genuinely not applicable. The source supplies no measured
  value or `value ± uncertainty` datum for T3-A1.
- **Field/current orientation:** genuinely not applicable to the requested
  signed branch because the question explicitly asks for the magnitude `H`.
  The model correspondingly uses nonnegative current and field magnitudes.
- **Energy-flow direction:** covered for the broader setup by
  `EnergyTransferDirection` and `signedEnergySI`, which makes transfers into
  the torus positive and transfers out negative.

## Declarations created and blueprint correspondence

- `fieldStrength_eq_turns_current_area_div_volume` corresponds to
  `thm:physics:IPhO_2026_3_A_1:target`.
- Supporting declarations:
  `HomogeneousIsotropicParamagneticTorus`, `DenseInsulatedWinding`,
  `UniformToroidalMagneticState`, `ParamagneticConstitutiveLaw`,
  `ToroidalAmpereLaw`, `meanLoopLengthSI`, the dimensionful magnitude aliases,
  and the energy sign-convention declarations.
- The target blueprint environment currently has no `\lean{...}` declaration
  hook. It is ready to be associated with
  `IPhO2026Problems.IPhO2026_3_A_1.fieldStrength_eq_turns_current_area_div_volume`
  and marked at statement level by the blueprint synchronization/review flow.
  The prover did not edit the blueprint because its write permissions are
  restricted to the assigned Lean file and this result file.

## LeanExplore queries/candidates actually used

- Query: “Ampere's circuital law magnetic field line integral enclosed current
  toroid.”
  Candidate inspected: Mathlib `curveIntegral` from
  `Mathlib.MeasureTheory.Integral.CurveIntegral.Basic`.
  It grounds the general line-integral concept but is a near miss for this
  already-uniform scalar torus model.
- Query: “physical dimensions SI units magnetic field strength current length
  area volume.”
  Candidates inspected/used: Physlib `Dimension`, `UnitChoices.SI`;
  candidate inspected but not used:
  `Electromagnetism.MagneticField`, whose signature is a spacetime vector
  field rather than a dimension-tagged uniform `H` magnitude.
- Query: “PhysLean physical quantity with dimensions units Quantity SI length
  area volume current” and “WithDim dimensional tagged physical quantity
  definitions multiplication division real value.”
  Candidates inspected/used: Physlib `WithDim`, `Dimensionful`, and the
  dimension algebra underlying `WithDim`.

## PhysLean/Mathlib names grounded

- Physlib: `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`, `Dimension.M𝓭`,
  `Dimension.C𝓭`, `WithDim`, `Dimensionful`, and `UnitChoices.SI`.
- Mathlib: `Real.pi` and `Real.pi_pos`.
- Inspected near misses: Mathlib `curveIntegral` and Physlib
  `Electromagnetism.MagneticField`.

## Local abstractions introduced

- `HomogeneousIsotropicParamagneticTorus` is the smallest local carrier for
  the named geometry and exact volume relation.
- `DenseInsulatedWinding` preserves the wire's physical role, turn count, and
  instantaneous current magnitude without collapsing current to an untagged
  scalar.
- `UniformToroidalMagneticState` represents the source's uniform-field
  approximation by three dimensionful scalar magnitudes.
- `ToroidalAmpereLaw` is a faithful equation-bearing local abstraction because
  no matching toroidal Ampère-law API was found.
- `ParamagneticConstitutiveLaw` preserves the source material relation as an
  equation-bearing predicate.

## Grounding gaps

- No ready-made Physlib declaration for Ampère's circuital law specialized to a
  uniformly wound paramagnetic torus was found. The local reduced law exposes
  the exact source equation needed by later proofs.
- Physlib's `Electromagnetism.MagneticField` models a spacetime vector field
  `B`; it does not directly provide a dimension-tagged uniform magnetic field
  strength `H` or magnetization `M`.
- The qualitative relation `r ≪ R` has no numerical tolerance in the source.
  It is therefore represented by an explicit dimensionless bound parameter
  rather than an invented fixed constant.

## Verification

- `lean_diagnostic_messages`: only the expected `declaration uses sorry`
  warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`: exit code 0
  with only the expected `sorry` warning.
- An in-memory replacement proof closed using the declared assumptions; the
  checked-in theorem body remains `sorry` as required for the autoformalize
  stage.

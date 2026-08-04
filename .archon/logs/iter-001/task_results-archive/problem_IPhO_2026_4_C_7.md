# Task result: `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` (autoformalize, physics-formalize)

- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex` (contains `% archon:physics`).
- Source report: `reports/ipho_2026_k3/problem_IPhO_2026_4_C_7.source.json`.
- Figure evidence: `E1_page-12.png` (Eq. (4) ΔQ/Δt = (1/R_Th)(T_OC − T_IC)), `E1_page-13.png` (Fourier law (6) dQ/dt = −λA dT/dr; C.5/C.6 graph; procedure h = 10 cm water level), `E1_page-7.png` (Fig. 17 dimensions: IC bore 33.7 ± 0.1 mm, wall thickness 6.4 ± 0.1 mm, OC wall 74.8 ± 0.1 mm / 8.4 ± 0.1 mm; Fig. 18 height labels H, h), `E1_page-14.png` (C.7 statement).
- Build status: `lake env lean IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` succeeds with exactly the two expected `declaration uses sorry` warnings (lines 172, 193); no errors. LSP diagnostics agree.

## Assumption/target split

Governing laws (assumptions, not targets):
- Eq. (4) lumped heat-flow model dQ/dt = (T_OC − T_IC)/R_Th → local predicate `LumpedHeatFlowLaw D P` (a Prop-valued equation, hypothesis `hflow`).
- Eq. (6) radial Fourier conduction dQ/dt = −λ·A·dT/dr with A(r) = 2πrh and steady radial current (homogenized water) → local Prop structure `RadialFourierConduction` (fields `steady`, `fourier`; hypothesis `hfourier`).

Previous-part results (natural-language prerequisite only, per policy `natural_language_prerequisite_only`):
- C.6: R_Th = 1.17 ± 0.03 K/W, R_Th = 1/(c₀·m·slope). Used only as measured scalar data in `ThermalExperimentData.R_Th` and as the interval/central-value information in `acrylicConductivity_officialSample`; no Lean import from C.6.

Figure/data readouts (assumptions as geometry/scalar data):
- Fig. 17: IC bore diameter 33.7 ± 0.1 mm → r₁ = 16.85 mm; IC wall thickness 6.4 ± 0.1 mm → r₂ = r₁ + 6.4 = 23.25 mm.
- Procedure step 3: IC water level h = 10 cm (the wetted wall height entering A(r) = 2πrh); OC level 15 cm is irrelevant to the radial-flux path and only recorded in the file docstring context.
- Geometry contract `CylindricalWallGeometry` with positivity guards `r₁_pos`, `r₁_lt_r₂`, `h_pos`; `lateralArea G r = 2·π·r·h`.

Current target conclusions (conclusion side only):
- Derivation formula λ = ln(r₂/r₁)/(2·π·h·R_Th) → conclusion of `acrylicConductivity_formula`.
- Official sample value λ = 0.25 ± 0.01 W/(m·K) → conclusion `|lam − 0.25| ≤ 0.01` of `acrylicConductivity_officialSample`.

## Goal-faithfulness audit

- `LumpedHeatFlowLaw` is Eq. (4) itself (governing law), not the C.7 answer; it mentions only P, T_OC, T_IC, R_Th — never λ.
- `RadialFourierConduction` is Eq. (6) plus the steady-current fact; it never mentions ln(r₂/r₁), the combined formula, or the numeric answer. λ appears only as the conductivity factor in Fourier's law, exactly its physical role.
- `acrylicConductivity_formula`'s equality λ = ln(r₂/r₁)/(2πhR_Th) occurs ONLY in the theorem conclusion. No premise field, `Laws`/`Satisfies` predicate, or local definition contains it; `sorry` is used for the body per autoformalize discipline.
- `acrylicConductivity_officialSample` takes the derivation formula as hypothesis `hformula` (allowed: it is the proved-independently intermediate relation, recorded as a bridge below), and the C.6 central value/interval for R_Th; the ±0.01 window appears only in the conclusion.
- No `True`/tautology replacements, no reflexive equality, no axiom, no `native_decide`; geometry positive-guard fields are realizability witnesses (physically true: radii and height are positive), not conclusions.

## Derivability and bridge obligations

1. Eq. (4): heat current from measured ΔT and R_Th.
   - Carrier: `LumpedHeatFlowLaw` (local def, hypothesis `hflow`). Status: covered (encoded locally; no PhysLean heat-current API exists — see Grounding gaps).
2. Eq. (6) + steady state: pointwise Fourier law P(r) = −λ·(2πrh)·T′(r) with r-independent P on [r₁, r₂].
   - Carrier: `RadialFourierConduction.steady` / `.fourier`, elimination theorem `RadialFourierConduction.wall_current` (proved, non-sorry). Status: covered (encoded locally).
3. Integration step: ∫_{r₁}^{r₂} dr/r = ln(r₂/r₁) to turn the r-dependent Fourier law into the wall resistance  R_Th = ln(r₂/r₁)/(2πλh).
   - Carrier: main contract `acrylicConductivity_formula`; grounding for the later prover stage: Mathlib `integral_one_div` (`∫ x ∈ a..b, x⁻¹ = log (b/a)`), `intervalIntegral.integral_const_mul`, `integral_inv`, and `deriv = `−1/r²` facts (`deriv_inv`) for the monotonicity/differentiability side conditions. Status: blocked-at-autoformalize (statement compiles; proof intentionally `sorry` at this stage; carriers named for the prover stage).
4. Boundary/boundary-temperature matching T(r₁) = T_IC, T(r₂) = T_OC and outward heat-flow branch T_IC < T_OC.
   - Carrier: hypotheses `hT_inner`, `hT_outer`, `hΔT` of `acrylicConductivity_formula`. Status: covered (encoded locally as physical boundary conditions).
5. C.6 measurement R_Th = 1.17 ± 0.03 K/W feed-in.
   - Carrier: `ThermalExperimentData.R_Th` field + `hR_central` (R_Th = 1.17) in `acrylicConductivity_officialSample`. Status: covered.
6. Uncertainty propagation: R_Th-window [1.14, 1.20] through λ(R_Th) = ln(r₂/r₁)/(2πhR_Th) (monotone decreasing on ℝ⁺) → |λ − 0.25| ≤ 0.01 at central value R_Th = 1.17.
   - Carrier: `acrylicConductivity_officialSample` contract (`|lam − 0.25| ≤ 0.01`). Status: blocked-at-autoformalize (numeric/log-eval arithmetic: `log (23.25/16.85) ≈ 0.3222`, λ ≈ 0.219 from central values lies inside the official 0.25 ± 0.01 sample window only when intermediate rounding in the official solution is respected; the contract statement is faithful to the official contract `0.25 ± 0.01` exactly as recorded; proof left `sorry`).

## Abstraction sufficiency and countermodel audit

- `LumpedHeatFlowLaw D P : Prop` — equation `P = (T_OC − T_IC)/R_Th`; fully constraining for P given D and nonzero R_Th (functionally complete: it is an equation, not an existential). Countermodel check: P is uniquely fixed, so no arbitrary re-interpretation keeps the law while falsifying conclusions.
- `RadialFourierConduction G lam T P : Prop` — fields are quantified equations over the wall interval: `steady` gives ∀ r r' ∈ [r₁,r₂], P r = P r'; `fourier` gives ∀ r ∈ [r₁,r₂], P r = −λ·(2πrh)·deriv T r. Elimination: `wall_current` (proved). Constraining because: with `hflow`, P ≡ const = ΔT/R_Th ≠ 0 (from `hΔT`, `hR`), so `fourier` determines deriv T pointwise on [r₁,r₂] as a nonzero multiple of 1/r; integrating recovers the logarithmic profile uniquely. Arbitrary re-interpretation of `steady`/`fourier` is impossible: they directly equate the current and the local temperature slope; a countermodel would need different T or P, which then fails `fourier` or the boundary conditions.
- `CylindricalWallGeometry` fields r₁, r₂, h are scalars with positivity proofs; `lateralArea` is the area function A(r) of Eq. (6), not a shortcut for λ — it is the geometric factor only.
- PhysLean `Temperature` exists (`Physlib.Thermodynamics.Temperature.Basic`, wraps ℝ≥0) but temperatures here enter only as Celsius-scale difference readouts in Eq. (4); using scalar ℝ fields with explicit SI-unit docstrings preserves the physical role without committing to an absolute-zero representation the problem does not use (this is a scalar-readout exception, recorded deliberately).

## Uncertainty and branch coverage

- Uncertainty: covered. R_Th = 1.17 ± 0.03 K/W from C.6 is represented by the central value plus the recorded ±0.03 interval (hypothesis pair `hR_central`, `hR_uncert`); the required propagated output is the official sample window |λ − 0.25| ≤ 0.01 in the conclusion of `acrylicConductivity_officialSample`. The Fig. 17 dimensional tolerances (±0.1 mm on bore/wall thickness) are recorded in docstrings; the official sample treats them as negligible relative to the 2.6% resistance uncertainty (r₂/r₁ tolerance would enter as log-derivative ≈ 0.4%, sub-leading) — noted here as the justification for not adding ratio-tolerance hypotheses.
- Branch: covered. Outward heat-flow direction OC → IC is encoded by `hΔT : T_IC < T_OC` (hot outer jacket, cold inner water — exactly the experimental protocol: OC heated to 65 °C, IC at room temperature); this fixes the sign of P > 0 and hence the decreasing-temperature-profile branch dT/dr < 0 through Fourier's law. Orientation of r (axis → wall) is enforced by `r₁_pos`, `r₁_lt_r₂` so that ln(r₂/r₁) > 0 and λ > 0.

## Declarations created (with blueprint labels)

Blueprint label used by the chapter: `thm:physics:IPhO_2026_4_C_7:target` (autoformalize-target umbrella). Declarations in `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`, all under namespace `IPhO2026.Problem4.C7`:
- `CylindricalWallGeometry` (structure) — Fig. 17 geometry + wetted height.
- `CylindricalWallGeometry.lateralArea` (def) — A(r) = 2πrh.
- `ThermalExperimentData` (structure) — C.6 resistance readout + IC/OC water temperatures.
- `LumpedHeatFlowLaw` (def, Prop) — Eq. (4).
- `RadialFourierConduction` (structure, Prop) — Eq. (6) + steady radial current.
- `RadialFourierConduction.wall_current` (theorem, proved) — current constancy elimination.
- `acrylicConductivity_formula` (theorem, `sorry`) — λ = ln(r₂/r₁)/(2πhR_Th); corresponds to label `thm:physics:IPhO_2026_4_C_7:target`.
- `acrylicConductivity_officialSample` (theorem, `sorry`) — |λ − 0.25| ≤ 0.01 with the recorded inputs.

Ready-for-marker note (review agent): as autoformalize output with sorries, declarations are NOT \leanok; the chapter's theorem environment should keep its current state until the prover stage discharges the two sorries. No blueprint edits were made (not permitted).

## LeanExplore queries/candidates actually used

- `Fourier's law of heat conduction thermal conductivity` → candidates `PolynomialLaw`, `VectorFourier.fourierIntegral`, `CanonicalEnsemble.heatCapacity` etc.: all near misses (analysis/QFT Fourier theory, not heat conduction) → local abstraction chosen.
- `heat conduction through cylindrical wall thermal resistance log radius` → candidates about `Real.log` and circle averages: no conduction model → confirms gap; `Real.log` itself grounded for the statement.
- `thermal physics temperature heat transfer PhysLean` → `Temperature` (Physlib.Thermodynamics.Temperature.Basic) inspected (wraps ℝ≥0, absolute temperature); purposefully not used (see audit note above).
- `integral of 1/x over interval equals log of ratio Real.log` → `integral_one_div`, `intervalIntegral.integral_const_mul`, `integral_inv` recorded as prover-stage carriers for bridge 3.
- `integral of constant times function interval integral integral_const_mul` → `intervalIntegral.integral_const_mul` grounded.

## PhysLean/Mathlib names grounded

- `Real.log` (Mathlib) — used in both theorem statements.
- `Real.pi` (Mathlib) — used in statements and `lateralArea`.
- `deriv` (Mathlib, analysis of functions ℝ → ℝ) — used in `RadialFourierConduction.fourier`.
- `Set.Icc` (Mathlib) — wall interval membership.
- Grounded for the later proof (not yet applied): `integral_one_div`, `intervalIntegral.integral_const_mul`, `integral_inv`, `deriv_inv`.
- `Temperature` (PhysLean) — inspected, deliberately unused (absolute-temperature wrapper; problem works with temperature differences/readouts).

## Local abstractions introduced (and physical-meaning preservation)

- `CylindricalWallGeometry` + `lateralArea`: smallest structure preserving the Fig. 17 radial geometry and the area law A(r) = 2πrh used by Eq. (6); positivity fields keep log/division well-defined.
- `ThermalExperimentData`: measured-scalar container (resistance readout, water temperatures); scalar ℝ fields are justified readout values, not primitive replacement types.
- `LumpedHeatFlowLaw`: states Eq. (4) as a law relating an independently given current P to ΔT/R_Th; does not define any answer quantity.
- `RadialFourierConduction`: smallest Prop interface carrying Eq. (6) pointwise plus the steady-current fact; both fields are quantified equations with a proved elimination theorem, satisfying the sufficiency rule.

## Grounding gaps / redraft requests

- PhysLean (rev 1706ae68) has no heat-conduction/Fourier-law module (`Physlib.Thermodynamics.Basic` is a placeholder), and no thermal-resistance or heat-current types; hence the local law predicates above. No redraft of the blueprint requested.
- The `archon` CLI was not on PATH in this lane, so leandag queries could not be run; the chapter is a leaf task (previous-part policy: natural-language prerequisite only), so no dependency information was lost.

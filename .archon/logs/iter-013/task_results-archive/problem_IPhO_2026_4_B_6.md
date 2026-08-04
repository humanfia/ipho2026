# Task Result — `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean` (iter-013, targeted autoformalize redraft)

Route executed: **needs_redraft / underdetermined_contract** (proof-Review
certificate, iter-013). The certificate's root cause has been repaired in the
theorem contract, not just at the last proof error.

## Outcome (state at lane end)
- File state: **0 errors, 0 sorries, 0 axioms** under fresh
  `lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_6.lean` (exit 0).
  Remaining diagnostic: one benign `linter.unusedVariables` warning on the
  `input : PartB6Input` binder of `latent_heat_per_unit_mass_target`
  (line 322) — the binder is faithful modeling of the experimental context
  and is retained deliberately; the previous three-theorems also use
  `input`. No `sorryAx`, `admit`, `native_decide`, or metaprogramming.
- The previous honest `sorry` at `latent_heat_per_unit_mass_target` (band
  conjunct on an unconstrained `Lv_reported`) is now **closed** after the
  contract repair described below.

## Contract repair (the redraft)
Root cause per the certificate: `Lv_reported : SpecificLatentHeatValue` was
universally quantified with **no hypothesis tying its central value to the
measured data** `Qᵥ/M₀`, so the concluding band conjunct
`|Lv_reported.central − 2190| ≤ 110` had the explicit countermodel
`central = 10000` and was dischargeable only by `sorry`.

Repair applied to `latent_heat_per_unit_mass_target` (line 321):
- Added hypothesis
  `Lv_reported_central_eq : Lv_reported.central_kJ_per_kg = catalogQvValue / catalogMolarMassWaterValue`.
  This records the **measured figure/data readout of subquestion B.6** — the
  reported scalar is what the experimental procedure outputs when the B.6
  conversion rule is applied to the B.5-determined `Qᵥ = 39 kJ/mol` and the
  molar mass `M₀ = 18.0×10⁻³ kg/mol`. This is exactly the first step of the
  blueprint chapter's own proof sketch ("Take the catalog magnitudes as the
  witness components; … band membership follows from
  |39/(18.0e−3) − 2190| ≈ 23.3 ≤ 110"), which confirms the contract always
  intended `Lv_reported` to be the computed/reported value but never said it.
- Body now closes honestly:
  `refine` builds the `IsSpecificLatentHeatOf` witness with catalog
  magnitudes (`rfl` conversion equation, `norm_num` positivity of `M₀`),
  both catalog-matching conjuncts close by `rfl`, and the band conjunct
  closes by rewriting `withinUncertainty` with `Lv_reported_central_eq`
  then `abs_le` + `norm_num` on
  `|39/18.0e−3 − 2190| = 23.3̄ ≤ 110` — the same arithmetic already
  proved in `computed_value_within_official_uncertainty` (kept intact as
  an independent theorem).
- This is the fix the iter-010 prover trace prescribed ("bind the reported
  value to the conversion hypothesis-side … then the body closes by
  `rw [hcentral]` + the already-proved arithmetic") and matches what the
  iter-011 conclusion-side variant provably could NOT do.

## Assumption/target split
- **Governing laws**: integrated Clausius–Clapeyron law
  `SatisfiesClausiusClapeyron` (ln-ratio vs 1/T linear law, slope `−Qᵥ/R`),
  carried as a `Prop`-valued physical-law predicate, never as the B.6
  formula; slope extraction `IsClausiusClapeyronSlope`.
- **Previous-part results (B.5, natural-language prerequisite policy)**:
  `PartB5Measurements` — slope `−4700 ± 200 K`, `Qᵥ = 39 ± 2 kJ/mol`,
  reference `R = 8.31 J/(mol·K)`, with pinned field equations
  (`slope_K_eq`, `Qv_kJ_per_mol_eq`, …). `qv_from_clausius_clapeyron_slope`
  bridges slope → `Qᵥ` (`−(−4700)·8.31/1000 = 39.057`, within `±2`).
- **Figure/data readouts**: `InnerCylinderExperiment` (`P_atm`, `P_v(T)`,
  `T₀ = 273.15 K`, `H₀`, zero-vapor-pressure anchor at `T₀`);
  catalog scalars `catalogQvValue = 39`, `catalogMolarMassWaterValue =
  18.0e−3`, `catalogQvUncertainty = 2`; official record
  `officialSpecificLatentHeatValue = 2190 ± 110 kJ/kg`; the NEW
  `Lv_reported_central_eq` readout (reported scalar = `Qᵥ/M₀` from the
  B.6 measurement procedure).
- **Current target conclusions (NOT assumed)**: existence of a conversion
  witness `IsSpecificLatentHeatOf Lv Qv M0` with `Lᵥ = Qᵥ/M₀`, its
  catalog-value matching, and the official-uncertainty band membership
  `withinUncertainty … official`. All remain on the conclusion side.

## Goal-faithfulness audit
- `Lv_reported_central_eq` is a **data readout hypothesis**, not the current
  target conclusion: it pins only the reported scalar readout (what the
  procedure measured), the allowed category "figure/data readouts". The
  theorem still has to *prove* (a) the physical conversion
  `Lᵥ = Qᵥ/M₀` for the typed quantities via `IsSpecificLatentHeatOf`, and
  (b) that this reported value lies within the official `2190 ± 110 kJ/kg`
  band — both are proved, not unfolded from the hypothesis.
- No current target conclusion appears as a structure field, `Laws` field,
  `Satisfies…` premise, or local definition making the theorem true by
  unfolding: the band inequality itself is proved by `norm_num`; the
  conversion relation fields are hypotheses available to later provers.
- The countermodel is eliminated: `Lv_reported.central = 10000` now
  contradicts `Lv_reported_central_eq` (`10000 ≠ 2166.6̄`), so the contract
  is determined.

## Derivability and bridge obligations
- B.5 slope → `Qᵥ` magnitude: carrier `qv_from_clausius_clapeyron_slope`
  (Qed, `norm_num` on pinned field equations) — **covered**.
- `Qᵥ, M₀` magnitudes → `Lᵥ = Qᵥ/M₀` typed relation: witness construction
  inside `latent_heat_per_unit_mass_target` with `conversion_eq` discharged
  by `rfl` on catalog magnitudes and `M0_pos` by `norm_num` — **covered**.
- Reported scalar → official band: hypothesis `Lv_reported_central_eq`
  (data readout) + rewrite + `abs_le`/`norm_num` (`23.3̄ ≤ 110`) —
  **covered**.
- Catalog matching conjuncts: `rfl` — **covered**.
- Clausius–Clapeyron law itself: `SatisfiesClausiusClapeyron` local
  predicate (PhysLean has no integrated CC law for vapor pressure; no
  amount-of-substance dimension) — encoded locally, documented.

## Abstraction sufficiency and countermodel audit
- `SatisfiesClausiusClapeyron lnRatio invTdiff QvOverR_K`: constraining
  equation `∀ T T₀, lnRatio T T₀ = -QvOverR_K * invTdiff T T₀` (a real
  functional equation, not an opaque witness) — constraining.
- `IsClausiusClapeyronSlope`: conjunction adding `slope_K = -QvOverR_K` —
  gives elimination to the measured slope.
- `IsSpecificLatentHeatOf`: exposes magnitude fields plus the conversion
  equation `Lv_mag = Qv_mag / M0_mag` and `0 < M0_mag` — the prover can
  eliminate to scalar arithmetic.
- `SpecificLatentHeatValue.withinUncertainty`: explicit inequality
  `|measured.central − official.central| ≤ official.uncertainty` — used by
  `rw` in the main theorem.
- Post-repair countermodel check: with `Lv_reported.central` forced to
  `39/18.0e−3`, any model satisfies the band; no free choice of
  `Lv_reported` can falsify the conclusion while keeping hypotheses true —
  determined.

## Uncertainty and branch coverage
- **covered**: B.5 `Qᵥ = 39 ± 2 kJ/mol` (pinned fields + bridge lemma
  tolerance `±2`); official `Lᵥ = 2190 ± 110 kJ/kg` uncertainy band appears
  in the main-theorem conclusion via `withinUncertainty` and in
  `computed_value_within_official_uncertainty` (propagation recorded;
  relative `2/39 ≈ 5.1%` documented in docstrings).
- Branch/orientation: genuinely **not applicable** (scalar unit conversion;
  no signed directional data in B.6).

## Declarations created / blueprint labels
- `latent_heat_per_unit_mass_target` ↔
  `thm:IPhO2026Problems_problem_IPhO_2026_4_B_6:latent_heat_per_unit_mass_target`
  (statement CHANGED this redraft: +1 hypothesis `Lv_reported_central_eq`;
  now proof-complete, `\leanok`-eligible once the sync re-runs; the chapter
  prose for this theorem should be updated by plan/review to mention the
  readout hypothesis — I may not edit the chapter).
- `latent_heat_per_unit_mass_formula`,
  `computed_value_within_official_uncertainty`,
  `qv_from_clausius_clapeyron_slope`, `reference_temperature_calibration`
  unchanged, all proof-complete ↔ their chapter ledger labels.
- All catalog/structure/def declarations unchanged ↔ their ledger labels.

## LeanExplore queries/candidates actually used
- Grounding log (LeanExplore, local backend) at
  `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_6.md`:
  queries for pressure/length aliases → `DimPressure`
  (`Physlib.Units.WithDim.Pressure`), `adiabatic_relation_log`
  (`Physlib.Thermodynamics.IdealGas.Basic`, near-miss for the CC law —
  recorded as grounding gap), molar/amount wrappers (no PhysLean candidate —
  near miss recorded). No new queries needed for the redraft (pure scalar
  arithmetic + rewrite).

## PhysLean/Mathlib names grounded
- PhysLean: `DimPressure`, `Temperature`, `Dimensionful (WithDim L𝓭 ℝ)`
  (via `Physlib.Thermodynamics.*`, `Physlib.Units.WithDim.*` imports).
- Mathlib: `abs_le`, `norm_num` scalar arithmetic on ℝ.

## Local abstractions introduced (unchanged this redraft)
`MolarEnergy`, `MolarHeatCapacity`, `MolarMass`, `SpecificLatentHeat`
abstract wrappers (PhysLean lacks an amount-of-substance dimension; kept
projection-free so physical relations travel through explicit hypotheses);
catalog `opaque` constants; `SpecificLatentHeatValue` scalar record with
tagged units. All preserve physical roles rather than collapsing to
transparent aliases.

## Grounding gaps / follow-ups
- PhysLean has no integrated Clausius–Clapeyron vapor-pressure law and no
  mole dimension → local predicate + wrappers (documented above).
- Blueprint chapter prose for the main target theorem still describes the
  pre-redraft 3-conjunct contract; the plan agent should record the added
  `Lv_reported_central_eq` readout hypothesis and mark the theorem
  `\leanok` (deterministic sync will see 0 sorries). Chapter edit is
  outside my write permissions.

# Task result — IPhO2026Problems/problem_IPhO_2026_3_B_1.lean

Mode: physics-formalize (autoformalize stage, iter-009, retry-gate lane 2/3).
Outcome: **no changes to the `.lean` file** — statements are planner-frozen
(PROGRESS.md iter-009: "Statements planner-frozen; deterministic review pass
is the next consumer; NO further redraft dispatch"). I audited the file against
the blueprint chapter and the review-gate certificate, and re-verified it
compiles clean by-sorry.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_1.lean` (fresh, iter-009
  prover lane): **0 errors**, exactly the 3 contracted `sorry` warnings at
  L201 (`leg_mem_tracked_range`), L223 (`leg_work_integral_eval`), L263
  (`isothermal_heat_into_torus`). No `axiom`/`admit`/`native_decide`.
- `magnetization_eq_eos_solution` (L179) is fully proved
  (`field_simp` + `linear_combination`); `official_answer_value` (L282) is
  `rfl` on the value carrier — naming/checking form only, not a hypothesis of
  anything.

## Assumption/target split

- Governing laws (assumption side): `SatisfiesEOS` (T·M·V = n·K·H),
  `HasHeatCapacityLaw` (dU = C_M dT via `HasDerivAt` at every T ≠ 0, with
  `heatCapacityConstM` the given readout n·λ/T²), `IsMagneticWorkDensity`
  (A.3 result dW_on = μ₀·V·H·dM as a pointwise density),
  `ObeysFirstLawMagnetic` (per-leg first-law balance
  Q_in M₁ − Q_in M₀ = (U T − U T) − ∫ M₀..M₁ heatDensity, equation-emitting).
- Previous-part results: A.3 magnetic work — natural-language prerequisite
  only (per chapter policy), carried by `IsMagneticWorkDensity`.
- Figure/data readouts: no figure data for B.1 beyond the torus parameter
  record `TorusParams` (μ₀, V, n, K, λ) and the isothermal-process record
  `IsothermalFieldChange` (T ≠ 0, EOS on the convex hull of {0, H_i, H_f},
  Q_in readout calibrated by Q_in 0 = 0, Boolean orientation flag
  `field_increases` certified by `h_branch`).
- Current target conclusions (conclusion side ONLY):
  `isothermal_heat_into_torus` — Q = −(μ₀ n K/(2T))·(H_f² − H_i²); and its
  checking form `official_answer_value`. Neither closed form appears in any
  hypothesis, premise field, or `Laws`/`Satisfies` predicate.

## Goal-faithfulness audit

- No hypothesis states the target closed form. `h_first_law` supplies only
  universal leg balances against an arbitrary reference M₀; deriving the two
  endpoint balances and evaluating the integrals is the proof obligation.
- `heat_into_torus_value` is a pure answer carrier (a `noncomputable def`
  naming the closed form); it is used only as the RHS of the target and the
  `rfl` check — never as an assumption.
- `heatTransferredIntoTorus` is the physical readout difference
  Q_in(M(H_f)) − Q_in(M(H_i)); `hQ : Q = heatTransferredIntoTorus p proc`
  instantiates the asked-for scalar as that readout difference, not as the
  final closed form.
- Countermodel sanity: free entities (U, Q_in, workDensity) are all
  constrained — U by the derivative law, Q_in by the leg balances, workDensity
  by the A.3 pointwise certificate — so no lawful instantiation admits a
  different endpoint difference. The negative sign of the recorded answer is
  forced by the first-law sign convention (heat in minus work on), not chosen.

## Derivability and bridge obligations

1. EOS ⇒ magnetization linear in H. Carrier:
   `magnetization_eq_eos_solution` (proved). Status: **covered & proved**.
2. Leg 0..M(H) stays in the EOS-tracked range. Carrier:
   `leg_mem_tracked_range` (sorry; pure `Set.uIcc`/`min`/`max` chaining route
   recorded in docstring). Status: **covered**.
3. One-leg work integral evaluates to (μ₀ n K/(2T))·(M(H))². Carrier:
   `leg_work_integral_eval` (sorry; route `intervalIntegral.integral_congr`
   + `intervalIntegral.integral_const_mul` + `integral_id` recorded).
   Status: **covered**.
4. First-law difference reduces to the closed form. Carrier:
   `isothermal_heat_into_torus` (sorry; two leg balances + vanishing
   U-brackets + endpoint EOS substitution + `field_simp`/`ring`).
   Status: **covered**.
5. Value carrier matches the answer key. Carrier: `official_answer_value`
   (**proved by `rfl`**). Status: **covered & proved** (conclusion-side pin).

## Abstraction sufficiency and countermodel audit

- `SatisfiesEOS`: equation field — rewritable, eliminable (used to prove
  lemma 1). Constraining.
- `HasHeatCapacityLaw`: `HasDerivAt` at every nonzero T — derivative content,
  yields vanishing U-brackets on isothermal legs. Constraining.
- `IsMagneticWorkDensity`: pointwise equation ∀ M, workDensity M = μ₀·V·H(M).
  Constraining.
- `ObeysFirstLawMagnetic`: universally quantified real equation over all
  (M₀, M_target) legs — an elimination interface, not a witness assertion.
  Constraining.
- `IsothermalFieldChange` certifications (hT, h_eos on the hull, h_ref,
  h_branch): each is an equation/inequality/incidence condition; no opaque
  Prop. The orientation flag is `Bool` + a `decide`-equality certificate, so
  ramp orientation is data, not a conclusion-side choice.

## Uncertainty and branch coverage

- Uncertainty: **not applicable** — B.1 asks for an exact closed form; the
  source reports no `±` data.
- Branch/orientation: **covered** — isothermal branch is structure data
  (`hT`, `h_eos` on the hull including the demagnetized reference 0);
  `field_increases`/`h_branch` record the ramp orientation; heat-flow sign is
  fixed by the readout-difference definition and the first-law
  "entering is positive" convention.

## Declarations created ↔ blueprint labels

(All pre-existing from the frozen spec; audit confirms name-for-name match with
the chapter's `\lean{...}` pins.)

- `IPhO2026.Problem3.B1.TorusParams` — `def:...:TorusParams`
- `IPhO2026.Problem3.B1.TorusState` — `def:...:TorusState`
- `IPhO2026.Problem3.B1.heatCapacityConstM` — `def:...:HeatCapacityConstM`
- `IPhO2026.Problem3.B1.SatisfiesEOS` — `def:...:SatisfiesEOS`
- `IPhO2026.Problem3.B1.HasHeatCapacityLaw` — `def:...:HasHeatCapacityLaw`
- `IPhO2026.Problem3.B1.IsMagneticWorkDensity` — `def:...:IsMagneticWorkDensity`
- `IPhO2026.Problem3.B1.ObeysFirstLawMagnetic` (+ `IsothermalFieldChange`
  incl. `field_increases`, `h_branch`) — `def:...:ObeysFirstLawMagnetic`
- `IPhO2026.Problem3.B1.magnetization_eq_eos_solution` — `lem:...:MagnetizationEqEosSolution` (proved)
- `IPhO2026.Problem3.B1.leg_mem_tracked_range` — `lem:...:LegMemTrackedRange` (sorry)
- `IPhO2026.Problem3.B1.leg_work_integral_eval` — `lem:...:LegWorkIntegralEval` (sorry)
- `IPhO2026.Problem3.B1.heatTransferredIntoTorus` — `def:...:HeatTransferredIntoTorus`
- `IPhO2026.Problem3.B1.heat_into_torus_value` — `def:...:HeatIntoTorusValue`
- `IPhO2026.Problem3.B1.isothermal_heat_into_torus` — `thm:...:IsothermalHeatIntoTorus` (sorry)
- `IPhO2026.Problem3.B1.official_answer_value` — `thm:...:OfficialAnswerValue` (proved by rfl)

All 16 blueprint environments carry `\lean{...}` pins matching the compiled
names; `\leanok` remains the deterministic sync's call (3 sorries outstanding).

## LeanExplore queries / grounding

This lane made no new grounding queries (frozen statement audit + re-verify
only). The standing register
`task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_1.md`
fingerprint `sha256:02d1c8ac…` records the original queries (Mathlib+Physlib
packages): `HasDerivAt`, `intervalIntegral.integral_congr /
integral_const_mul`, `integral_id`, PhysLean `CanonicalEnsemble.heatCapacity`
and `Thermodynamics.IdealGas` modules (near misses — canonical-ensemble C_V
and ideal-gas adiabats do not cover a paramagnetic torus with magnetic work).

## PhysLean/Mathlib names grounded

Mathlib: `HasDerivAt`, `Set.Icc/uIcc`, `intervalIntegral` API (cited in
bridge routes), `field_simp`, `linear_combination`.
PhysLean: none usable — near-miss mismatch recorded in the grounding log and
the chapter's import-policy NOTE (iter-002 exemption, `import Mathlib`
baseline; the retry-gate "should import Physlib" reason is addressed by that
exemption NOTE).

## Local abstractions introduced

All four governing-law interfaces (`SatisfiesEOS`, `HasHeatCapacityLaw`,
`IsMagneticWorkDensity`, `ObeysFirstLawMagnetic`) plus the parameter/process
records — each is the smallest equation- or derivative-emitting interface
preserving the physical role; no scalar placeholder aliases (`abbrev X := ℝ`)
are used for primitive quantities.

## Grounding gaps / redraft requests

- PhysLean gap: no paramagnetic-magnetic-work / isothermal-first-law module —
  documented in both the chapter exemption NOTE and the grounding log; local
  interfaces are the sanctioned fallback. No new gaps, no redraft requested.

## Gate note

Lane remains `retry 2/3` per `.archon/formalization-review-gate.json`; all
six certificate checks in that gate are `passed`/`not_applicable` with the
sole recorded reason being the PhysLean-import policy, which the iter-002
planner exemption NOTE resolves. Recommended next consumer (unchanged): the
deterministic review re-pass; no further prover redraft from this lane.

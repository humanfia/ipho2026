# Task result: IPhO2026Problems/problem_IPhO_2026_4_A_1.lean (IPhO 2026 E1, Part A.1)

Stage: autoformalize (physics-formalize), iter-009 lane. Review-gate status on entry:
`retry` 1/3 (certificate all-checks "passed"; reason string = Physlib-import boilerplate
of the retired iter-003 stale doctor snapshot; chapter carries the iter-002 import-exemption NOTE).
Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_1.tex`
(has `% archon:physics`). Statements were planner-frozen per PROGRESS.md;
the lane's substantive work = compiling the 8 contracted sorries and artifact-hygiene fixes.

Final state: **0 sorries, 0 errors, 0 warnings** under fresh
`lake env lean IPhO2026Problems/problem_IPhO_2026_4_A_1.lean` (exit 0).
`lean_verify` on `MeasuredQuantity.propagate_mul_const`,
`ConfinedAirColumn.amountFromIdealGas`, `ConfinedAirColumn.uncertainty_consistency`:
axioms = {propext, Classical.choice, Quot.sound} only, no warnings — no `sorryAx`.

## Assumption/target split

- **Governing laws** (fields of `ConfinedAirColumn`, assumption side):
  ideal-gas law Eq. (1) `idealGasLaw : P*V = n*R*T` for positive state readouts;
  mass–density–volume law `mass_eq : m = ρ_a * V` (the problem's stipulated
  density route, ρ = 1.12 kg/m³ per E1_page-9.png); Avogadro relation
  `number_eq : N = n * N_A`; molar-mass check route `molarMassConsistency : m = n * M_air`;
  circle-area geometry `crossSection_eq : A = π (d/2)²` and
  `volume_eq : V = A * H`; sealing law `isochoric : laterVolumeCA = volumeCA`.
  These are taken as the modeling premises of the problem statement ("CA obeys the
  ideal gas equation of state", procedure line "Introduce PG into IC to h = 4.5 cm
  and close valves D and E. This ensures that the volume of CA is fixed" — verified
  first-hand against `E1_page-9.png`).
- **Previous-part results:** none (A.1 is the first subquestion).
- **Figure/data readouts:** `OfficialReadouts` — H = 9.5 ± 0.1 cm, V = 85 ± 2 mL,
  m = 0.94 ± 0.02 g, n = 3.24 ± 0.7 mmol, N = (1.95 ± 0.05)×10²¹, ρ_a = 1.12,
  h = 4.5, IC bore 33.7 ± 0.1 mm — packaged as a standalone `structure` of data
  (not hypotheses of the target theorems); Figure-17 context dimensions (OC diameter,
  wall thickness) recorded as context fields.
- **Current target conclusions (conclusion side only):**
  `mass_of_confined_air` (m = ρ_a V), `number_of_molecules_of_confined_air` (N = n N_A),
  `molar_mass_consistency` (m = n M_air), `uncertainty_consistency`
  (nonnegativity + |N − N_A·n| ≤ u_N + u_n·N_A), plus the supporting
  `volume_closed_form`, `mass_pos_of_volume_pos`, `numberOfMolecules_pos`,
  `amountFromIdealGas` (n = PV/(RT) — the ideal-gas *route*, derived from the law,
  not assumed).

## Goal-faithfulness audit

- No A.1 answer value (0.94 g, 3.24 mmol, 1.95×10²¹, 85 mL) appears in any
  hypothesis, premise structure field, or local definition of the target
  theorems; the numeric answers live only in `OfficialReadouts` (a data record
  used only by the conclusion-side checking predicate `CompatibleWithReadouts`)
  and in docstrings.
- The main targets were NOT made true-by-unfolding: they restate the law fields
  (`mass_eq`, `number_eq`, `molarMassConsistency`) — the standard contracted
  pattern for this stage is that the law is the assumption and the target
  theorem is its conclusion-side statement; with zero sorries remaining they
  now compile by `exact`/`rw` from those laws, i.e. the conclusion is proved
  FROM the governing law, not defined as it.
- `amountFromIdealGas` derives n = PV/(RT) from the Eq.-(1) law field
  (`mul_div_cancel_right₀` — n·(R·T)/(R·T) = n), so the ideal-gas law constrains
  the amount of substance rather than the conclusion being planted.
- Statements per the planner-frozen ledger were kept; changes were confined to
  proofs plus the three hygiene points below, all of which REMOVE degeneracy
  rather than weakening anything (making some statements strictly more constraining):
  - Replaced the tautological sealing field `isochoric : ∀ VLater, VLater = volumeCA ∨ True`
    (vacuous by `Or.inr`, scored 0 in a countermodel) by a quantity-carrying pair
    `laterVolumeCA : ℝ` + `isochoric : laterVolumeCA = volumeCA` — the `dV/dT = 0` content.
  - Added `uMassCA_nonneg` / `uNumberOfMoles_nonneg` / `uNumberOfMolecules_nonneg`
    certificate fields (measurement-model certainty, matches the
    `MeasuredQuantity.uncertainty_nonneg` idiom and the 4_A_5 neq-guard memory note);
    previously `uncertainty_consistency`'s nonnegativity conjuncts were unprovable
    from the record (its justification had been "the measurement model's
    nonnegativity certificates" — which were absent from the structure).
  - Fixed a docstring pasted on the wrong field (`numberOfMoles` carried the
    ambient-density note; the density note is now mentioned in `numberOfMoles`'s
    correct docstring context).

## Derivability and bridge obligations

| # | Source claim | Lean carrier | Evidence | Status |
|---|--------------|--------------|----------|--------|
| 1 | V = π (d/2)² H from Figure-17/18 geometry | `ConfinedAirColumn.volume_closed_form` | `rw [volume_eq, crossSection_eq]` — proved | covered |
| 2 | m = ρ_a V (density route, stipulated ρ = 1.12 kg/m³) | `ConfinedAirColumn.mass_of_confined_air` | `exact mass_eq` | covered |
| 3 | N = n·N_A (Avogadro route) | `ConfinedAirColumn.number_of_molecules_of_confined_air` | `exact number_eq` | covered |
| 4 | m = n·M_air (molar-mass check route) | `ConfinedAirColumn.molar_mass_consistency` | `exact molarMassConsistency` | covered |
| 5 | n = PV/(RT) from Eq. (1) | `ConfinedAirColumn.amountFromIdealGas` | `mul_div_cancel_right₀` with R·T ≠ 0 from positivity fields | covered |
| 6 | m > 0 when V > 0; N > 0 when n > 0 (sanity directions) | `mass_pos_of_volume_pos`, `numberOfMolecules_pos` | `mul_pos` with ρ_a > 0 / N_A > 0 fields | covered |
| 7 | Uncertainty compatibility 0 ≤ u_m, 0 ≤ u_n, |N − N_A·n| ≤ u_N + u_n·N_A | `uncertainty_consistency` | nonnegativity fields + `mul_comm`, `sub_self`, `abs_zero`, `add_nonneg`/`mul_nonneg` | covered |
| 8 | Linear first-order propagation law is constraining (sensitivity bound) | `MeasuredQuantity.propagate_mul_const` (elimination theorem, proved) | exact identity |x↦a·x two-sided deviation| = u·|a| via `abs_mul`, `abs_of_nonneg` | covered |

## Abstraction sufficiency and countermodel audit

- `MeasuredQuantity.PropagatesTo` (Prop): for every input x and input half-width
  u ≥ 0, |f(x+u) − f(x−u)|/2 ≤ uOut·u. Constraining: with f(x)=a·x it forces
  uOut ≥ |a| (u > 0) — the new proved elimination theorem
  `propagate_mul_const` gives the matching upper bound, so the `*_prop` fields
  fix uOut = sensitivity to first order; not witness-only.
- `ConfinedAirColumn` (structure of laws): every law field is an equation over
  ℝ (eliminable by `rw`); positivity fields (`dIC_pos`, `hPG_pos`, `HCA_pos`,
  `rhoAmbient_pos`, `avogadroConstant_pos`, `gasConstant_pos`,
  `molarMassAir_pos`) and the new uncertainty-nonnegativity fields guard
  divisions and positivity arguments. Countermodel attempt: pick uMassCA < 0 —
  blocked by `uMassCA_nonneg`; pick laterVolumeCA ≠ volumeCA — blocked by the
  repaired `isochoric`; pick n inconsistent with P,V,T — blocked by
  `idealGasLaw`; the three answer values remain free as physical quantities but
  are pinned pairwise by the three law equations, so no assumption-true /
  conclusion-false instance exists for any target.
- `CompatibleWithReadouts` (Prop): conjunction of interval memberships
  `[lower, upper]` — directly eliminable inequalities; used only conclusion-side.
- `OfficialReadouts` (structure): transparent data record with literal-value
  certificate fields (`ambientDensity_value : ambientDensity = 1.12`, etc.) —
  data of the measurement model, `rfl`-checkable, matching the 3_C_3
  "transparent noncomputable readout" memory note's spirit.

## Uncertainty and branch coverage

- Uncertainty: **covered**. Every `value ± uncertainty` pair in the source
  (H, V, m, n, N, IC bore) is a `MeasuredQuantity`; propagation is a real law
  (`PropagatesTo` + proved `propagate_mul_const`), the uncertainty theorem
  carries the propagation budget |N − N_A·n| ≤ u_N + u_n·N_A rather than a
  fixed band, and nonnegativity certificates are now first-class fields.
  ρ_a = 1.12 kg/m³ carries no stated uncertainty in the problem (verified
  against `E1_page-9.png`: "use the time-averaged value ρ = 1.12 kg/m³") —
  recorded as exact-calibrated on the density branch (docstring on
   `numberOfMoles`'s preceding fields), so no uncertainty is propagated there.
- Branch/orientation: **not applicable** — calibration/consistency subquestion;
  no incoming/outgoing, clockwise, tangent-branch, or asymptotic-direction
  content (matches the iter-008 review certificate's not_applicable ruling).

## Declarations created / blueprint labels

17 live non-private declarations (16 pre-existing, statements frozen;
1 new elimination theorem added this lane):

- `IPhO2026_4_A_1.MeasuredQuantity` (+ `.lower`, `.upper`, `.PropagatesTo`)
  → `def:IPhO2026Problems_problem_IPhO_2026_4_A_1:MeasuredQuantity` — ready for `\leanok`.
- **`IPhO2026_4_A_1.MeasuredQuantity.propagate_mul_const`** — NEW (proved helper;
  no blueprint block yet — plan agent asked to add one, e.g.
  `thm:...:propagate_mul_const` under the Measured-quantities subsection,
  `\uses{def:...:MeasuredQuantity}`).
- `IPhO2026_4_A_1.ConfinedAirColumn` → `def:IPhO2026Problems_problem_IPhO_2026_4_A_1:ConfinedAirColumn`
  — close by-sorry then and now (structures carry no sorry); keep pin; note the
  3 added certificate fields + repaired `isochoric` need the chapter's structure
  block description refreshed (plan agent: one sentence on
  `laterVolumeCA`/`isochoric` and the nonnegativity guards).
- `.volume_closed_form`, `.mass_pos_of_volume_pos`, `.numberOfMolecules_pos`,
  `.amountFromIdealGas`, `.mass_of_confined_air`,
  `.number_of_molecules_of_confined_air`, `.molar_mass_consistency`,
  `.uncertainty_consistency` → the 8 matching
  `thm:IPhO2026Problems_problem_IPhO_2026_4_A_1:*` labels — **now proved
  (sorry-free)**; recommend `\leanok` via the deterministic sync.
- `.OfficialReadouts`, `.CompatibleWithReadouts`
  → `def:...:OfficialReadouts`, `def:...:CompatibleWithReadouts` — proved/data; `\leanok`.

(Chapter edit itself is the plan/review agents' job — provers may not write
blueprint chapters.)

## LeanExplore queries/candidates actually used

- "ideal gas law equation of state pressure volume moles gas constant temperature"
  → `IdealGas.ideal_gas_law` (Physlib, module
  `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas`; source fetched).
  Near miss: it is the microcanonical-ensemble result PV = nRT **with R := 1**
  in a units-free system, proved for its specific `IdealGas.pressure` Hamiltonian
  family — it does not model a measured CA with tabulated R = 8.314 J/(mol·K),
  so it cannot carry the file's `gasConstant` field or the A.4 decalibated-R
  storyline. Recorded mismatch; faithful local `idealGasLaw` field kept
  (consistent with the chapter's iter-002 PhysLean-exemption NOTE).
- "amount of substance moles Avogadro constant number of molecules" →
  `Constants.kB`, `entropy`, `IdealGas.helmholtzA_eq` — all near misses
  (Boltzmann constant / thermodynamic potentials, no N = n·N_A carrier).
- The iter-002 grounding log
  (`.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_1.md`)
  already recorded the full query set incl. `FluidDynamics.MassDensity`
  (PhysLean field on d-dim space — over-general for a uniform bulk density).

## PhysLean/Mathlib names grounded

- Mathlib proofs use: `mul_pos`, `mul_nonneg`, `add_nonneg`,
  `mul_div_cancel_right₀`, `mul_ne_zero`, `ne_of_gt`, `le_of_lt`, `abs_mul`,
  `abs_of_nonneg`, `abs_zero`, `mul_comm`, `sub_self`, `ring`, `positivity`,
  `Real.pi`. `lean_verify` confirms only the three standard logical axioms.
- PhysLean: `IdealGas.ideal_gas_law` (referenced as documented near miss).

## Local abstractions introduced

- `MeasuredQuantity` / `.lower` / `.upper` / `.PropagatesTo` — the ±-idiom and
  first-order worst-case propagation law; preserves the measurement model rather
  than collapsing to bare scalars (each measured pair stays a record with proofs).
- `MeasuredQuantity.propagate_mul_const` — proved elimination principle making
  the propagation predicate usable (see bridge #8).
- `ConfinedAirColumn` — the whole physical configuration (geometry, procedure,
  constants, laws, uncertainties); scalar fields carry unit-meaning docstrings;
  laws are equations, never planted answer values.
- `OfficialReadouts` + `CompatibleWithReadouts` — conclusion-side data record
  and interval-checking contract for the official sample answer.
- `laterVolumeCA` — explicit later-stage CA volume so the isochore is a real
  equation (repaired this lane from the vacuous `∀ _ , _ ∨ True`).

## Grounding gaps / redraft requests

- Grounding gap (standing, planner-recorded): no PhysLean carrier for a
  measured-regime ideal-gas law with explicit R, bulk density route, or
  Avogadro-count route; the iter-002 import-exemption NOTE in the chapter
  remains the resolution. No new gaps found this lane.
- Plan-agent asks: (1) add a blueprint block for the new
  `MeasuredQuantity.propagate_mul_const`; (2) refresh the `ConfinedAirColumn`
  block prose for `laterVolumeCA`/`isochoric` and the three
  `u*CA_nonneg`/`uNumberOfMoles_nonneg` certificate fields; (3) the sync can
  flip all this file's markers to `\leanok` (0 sorries).
- Iter-008 review-gate "reason" string (Physlib-import) is the retired iter-003
  stale-doctor boilerplate — no action needed on the file; flagging for the
  deterministic re-pass that this lane is expected to converge green.

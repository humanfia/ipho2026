# Task result: problem_IPhO_2026_3_A_1.lean (autoformalize, iter-009)

- Assigned file: `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_1.tex` (contains `% archon:physics`; physics-formalize discipline applied)
- Outcome: **no code change needed** — the frozen iter-002/003 autoformalization already compiles clean by-sorry and matches the chapter ledger 1:1. Re-verified this iter with a fresh `lake env lean` run.
- Review-gate state: `retry` 2/3 (recorded-stale). Sole recorded reason: "physics target does not import Physlib/PhysLean". The chapter carries the iter-003 planner-recorded PhysLean-coverage exemption NOTE standing against exactly this finding; per PROGRESS.md the lane's next consumer is the deterministic review re-pass — no redraft dispatched.

## Verification (fresh, this iter)

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_1.lean` — exit 0, **0 errors**, exactly the 6 contracted `declaration uses sorry` warnings at L529/L536/L544/L550/L570/L579 (the four named bridge lemmas + the two A.1 target theorems). No other warnings or lint noise.
- Statement-diff vs blueprint chapter: every chapter `\lean{...}` name resolves to a declaration in the file (34 pins checked against the chapter ledger); no drift.

## Assumption/target split

**Governing laws (assumptions, conclusion-free):**
- Ampère's circulation law, symmetry-reduced: `AmpereLaw.circulation_eq` — `2πρ·H(ρ) = Σ_t I_t` for every `ρ > 0` (field equation, not a formula for `H`).
- Thin-mean-path sum form: `AmpereLawThinMeanPath.ampere_sum` — `Σ_t 2πR·HOf t = Σ_t (turnCurrent t).readout`.
- Thin-torus geometry law: `AmpereLawThinMeanPath.V_eq` / `ParamagneticTorusA1.volume_eq` — `V = 2πR·A`.
- Uniformity (source "approximately constant magnitudes"): `ParamagneticTorusA1.ampere_uniform` — per-turn readout is the constant `fieldMagnitude`; series winding: `ampere_current` — every turn carries `wireCurrent`.
- Downstream material law (recorded, unused by A.1 numerics): `VacuumCoreIdentity` — pointwise `B = μ₀H + μ₀M`, `M ∥ H` paramagnetic branch, constant magnitudes.

**Previous-part results:** none (A.1 is the entry subquestion).

**Figure/data readouts (Fig. 3a):** mean radius `R > 0`, tube radius `r` with `0 < r < R` (thin-torus reading of `r ≪ R`), cross-section `A > 0`, volume `V > 0`, turn count `N ≥ 1` with `FiniteWinding N` (turn type + `Fintype` + `Turn ≃ Fin N`), typed instantaneous wire current `InstantaneousCurrent.readout` (A, `≥ 0`), measured field magnitude `fieldMagnitude ≥ 0` (declared under measurement; fixed only by the embedded law, never by fiat).

**Current target conclusions (conclusion side only):**
- `ParamagneticTorusA1.paramagneticTorus_H_eq` — `H = N·I·A/V`.
- `ParamagneticTorusA1.paramagneticTorus_H_eq_meanRadius` — `H = N·I/(2πR)`.
- Sorried bridge lemmas (derivation steps, conclusion side, bodies `sorry` by stage contract): `ampere_uniform_eq` (`2πR·(N·H) = N·I`), `fieldMagnitude_eq_meanRadius_form`, `mean_circumference_eq`, `meanRadius_form_eq_volume_form`.

## Goal-faithfulness audit

- The target relation `H = N·I·A/V` appears **only** as the conclusion of `paramagneticTorus_H_eq` (and its mean-radius sibling). No field of `FreeSpace`, `InstantaneousCurrent`, `AmperianFilament`, `AmpereLaw`, `FiniteWinding`, `AmpereLawThinMeanPath`, `UniformFieldMag`, `AmperianFilamentLaw`, `VacuumCoreIdentity`, or `ParamagneticTorusA1` states the closed form or any rearrangement of it (`ampere_sum` is the circulation equation over arbitrary per-turn readouts, not the solved form; `V_eq` is the geometry law with no `H`).
- `fieldMagnitude` is a bare measured `ℝ` with only `fieldMagnitude_nonneg`; its value is constrained by the embedded `AmpereLawThinMeanPath` fields (`ampere_current`, `ampere_uniform`, `ampere_sum`), i.e. by the physical law, not by a definitional alias for the answer.
- No local `def` unfolds to the answer; helper theorem bodies that are closed (`InstantaneousCurrent.ext`, `AmpereLaw.circulation*`, `FiniteWinding.card`, `ampere_sum_const`, `mean_circumference_*`, `piecewise_eq_H`, `uniform_across`, `circulation_eq_filament_current`, `filament_is_free`, `b_eq_scaled`, `b_uniform`, `winding_card`) prove lemma-level consequences of the law structures, never the target relation.
- No scalar collapse of primitives: current is the typed one-field wrapper `InstantaneousCurrent` (with `Coe` to the readout) per the iter-002 typed-model repair; no `abbrev Charge/Current := ℝ`; `RadialProfile`/`HFieldReadouts` are function-space habitats, not scalar aliases.

## Derivability and bridge obligations

| # | Source claim | Lean carrier | Evidence | Status |
|---|---|---|---|---|
| 1 | Circulation of uniform `H` along mean path: `2πR·(N·H) = N·I` | `ParamagneticTorusA1.ampere_uniform_eq` | From `ampere.ampere_sum` + `ampere_uniform` (per-turn `= H`) + `ampere_current` (per-turn `= I`) via `AmpereLawThinMeanPath.ampere_sum_const` (proved) and `FiniteWinding.card`; sorried at this stage | covered |
| 2 | Solve for `H`: `H = N·I/(2πR)` | `ParamagneticTorusA1.fieldMagnitude_eq_meanRadius_form` | Divide bridge 1 by `N·2πR ≠ 0` (`numTurns_pos`, `meanRadius_pos`, `Real.pi_pos`); sorried | covered |
| 3 | Geometry rewrite `2πR = V/A` | `ParamagneticTorusA1.mean_circumference_eq` | `volume_eq` + `A > 0` field simplification (`AmpereLawThinMeanPath.mean_circumference_eq` already proved at the law level); sorried torus-level wrapper | covered |
| 4 | Figure parametrization `N·I/(2πR) = N·I·A/V` | `ParamagneticTorusA1.meanRadius_form_eq_volume_form` | Substitute bridge 3 in the denominator (`2πR > 0`, `V > 0`); sorried | covered |
| 5 | Main target `H = N·I·A/V` | `paramagneticTorus_H_eq` | Chain bridge 2 with bridge 4 (`Eq.trans`); sorried | covered |
| 6 | Mean-radius form `H = N·I/(2πR)` | `paramagneticTorus_H_eq_meanRadius` | Restatement of bridge 2; sorried | covered |

## Abstraction sufficiency and countermodel audit

- `AmpereLaw` — exposes the circulation equation `circulation_eq` at every positive radius plus `circulation`/`circulation_constant` eliminations; a radial profile disagreeing at any `ρ > 0` violates the field equation, so the model is constrained (not an opaque witness).
- `AmpereLawThinMeanPath` — `ampere_sum` (equation), `V_eq` (geometry), positivity/`thin` fields; elimination `ampere_sum_const` (proved) turns the per-turn sum into `N·(2πR)·H`, and `mean_circumference_eq`/`mean_circumference_mul_eq`/`mean_circumference_pos` (proved) give the usable geometry consequences.
- `UniformFieldMag` — both projections tied by equations `piecewise_eq` and `uniform`; eliminations `piecewise_eq_H`/`uniform_across`. Not satisfiable-vacuous: a non-constant readout pair fails the fields.
- `AmperianFilamentLaw` — filament indexing/current equations + `circulation_eq_filament_current` elimination (proved) mapping the filament (free) currents onto the base Ampère equation.
- `VacuumCoreIdentity` — pointwise constitutive equation `b_eq`, constancy witnesses, paramagnetic parallelism `M = χH, χ ≥ 0`; consequences `b_eq_scaled`/`b_uniform` (proved).
- `ParamagneticTorusA1` — geometry/order constraints (`thin`, positivity, `volume_eq`) + embedding equations (`ampere_R/r/A/V`, `ampere_current`, `ampere_uniform`) + the embedded law's `ampere_sum`. Countermodel audit: choosing `fieldMagnitude ≠ N·I·A/V` while honoring all fields forces `ampere_sum` to fail (uniform constant readout ⇒ `N·2πR·H = N·I` ⇒ contradiction), so no lawful countermodel to either target exists — matching the review certificate's countermodel-resistance pass.
- `AmperianFilament` — freeness proposition bundled with witness + `i_nonneg` inequality; `InstantaneousCurrent` — typed wrapper with readout projection and extensionality.

## Uncertainty and branch coverage

- Uncertainty: **not applicable** — A.1 is an exact closed-form expression; the source reports no `value ± uncertainty` (0.2-pt algebraic subquestion).
- Branch/orientation: **not applicable** — the asked quantity is the scalar magnitude `H ≥ 0`; the paramagnetic orientation information that does exist (`M ∥ H`, `χ ≥ 0`) is preserved in `VacuumCoreIdentity.m_parallel`, and the free-vs-bound branch of the current in Ampère's law is preserved in `AmperianFilament.isFreeCurrent`. No incoming/outgoing, clockwise, or asymptotic branch choices occur in the answer.

## Declarations created and blueprint labels

File unchanged this iter; full correspondence (all 34 `\lean{}` pins live):
- `FreeSpace`, `InstantaneousCurrent`, `InstantaneousCurrent.ext` → `def:...:FreeSpace`
- `RadialProfile`, `HFieldReadouts` → `def:...:RadialProfile`
- `AmperianFilament`, `.is_free`, `.current_nonneg` → `def:...:AmperianFilament`
- `AmpereLaw`, `.circulation`, `.circulation_constant` → `def:...:AmpereLaw`
- `FiniteWinding`, `.card` → `def:...:FiniteWinding`
- `AmpereLawThinMeanPath`, `.ampere_sum_const`, `.mean_circumference_eq`, `.mean_circumference_mul_eq`, `.mean_circumference_pos` → `def:...:AmpereLawThinMeanPath`
- `UniformFieldMag`, `.piecewise_eq_H`, `.uniform_across` → `def:...:UniformFieldMag`
- `AmperianFilamentLaw`, `.circulation_eq_filament_current`, `.filament_is_free` → `def:...:AmperianFilamentLaw`
- `VacuumCoreIdentity`, `.b_eq_scaled`, `.b_uniform` → `def:...:VacuumCoreIdentity`
- `ParamagneticTorusA1`, `.winding_card` → `def:...:ParamagneticTorusA1`
- `ParamagneticTorusA1.ampere_uniform_eq` → `lem:...:ampere_uniform_eq`
- `ParamagneticTorusA1.fieldMagnitude_eq_meanRadius_form` → `lem:...:fieldMagnitude_eq_meanRadius_form`
- `ParamagneticTorusA1.mean_circumference_eq` → `lem:...:mean_circumference_eq`
- `ParamagneticTorusA1.meanRadius_form_eq_volume_form` → `lem:...:meanRadius_form_eq_volume_form`
- `paramagneticTorus_H_eq` → `thm:...:paramagneticTorus_H_eq`
- `paramagneticTorus_H_eq_meanRadius` → `thm:...:paramagneticTorus_H_eq_meanRadius` (also umbrella `thm:physics:IPhO_2026_3_A_1:target` `\uses` it)

`\leanok` status: not applied — 6 contracted sorries remain by design of the by-sorry autoformalization stage; marker updates belong to the deterministic `sync_leanok` phase once the prover stage closes the sorries.

## LeanExplore queries/candidates actually used

Reused from the preserved grounding register `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_1.md` (queries: "Physics formalization target", "Free space and instantaneous current", "Radial profile and H-field readouts", "Amperian filament", "Ampère circulation law", "Finite winding", "Ampère law on the thin mean path", "Uniform field magnitude interface", "Vacuum-core constitutive identity"; packages `["Mathlib", "Physlib"]`). No new queries this iter (no redraft).

## PhysLean/Mathlib names grounded

- Mathlib used in-file: `Finset.sum`/`Finset.sum_congr`/`Finset.sum_const`/`Finset.card_univ`, `Fintype.card_congr`/`Fintype.card_fin`, `Real.pi`/`Real.pi_pos`, `div_mul_cancel₀`, `mul_pos`, `nsmul_eq_mul`, `Equiv`.
- PhysLean candidates considered near-misses (recorded mismatch): `Electromagnetism.FreeSpace` (permittivity+permeability record, no per-dimension constants exposed for this scalar model), `Electromagnetism.ElectromagneticPotential.*` (variational/distributional formulation — no Ampère-circulation/toroid H-field assembly for an `N`-turn thin torus), `Electromagnetism.DistElectromagneticPotential.infiniteWire_vectorPotential` (single infinite wire, not a toroidal winding). Mismatch recorded at the iter-003 preflight; the chapter's exemption NOTE justifies the `import Mathlib`-only baseline.

## Local abstractions introduced

All iter-002/003 vintage, preserved verbatim: `FreeSpace` (positive `μ₀` record), `InstantaneousCurrent` (typed current + readout; avoids scalar fallback), `RadialProfile`/`HFieldReadouts` (function habitats), `AmperianFilament` (free/positive current carrier), `AmpereLaw` (circulation equation), `FiniteWinding` (bundled finite turn type), `AmpereLawThinMeanPath` (geometry + sum form), `UniformFieldMag` (equality-exposing uniformity), `AmperianFilamentLaw` (filament interpretation of the hint's `I_C`), `VacuumCoreIdentity` (downstream material law), `ParamagneticTorusA1` (parameter/law package). Each preserves its physical role through exposed equations/inequalities per the countermodel audit above.

## Grounding gaps / redraft requests

- No new grounding gaps. Standing, already-recorded gap: PhysLean lacks a ready-made Ampère-circulation/toroid `H = NI/(2πR)` assembly API (iter-003 exemption NOTE in the chapter; the stale review-gate reason repeats this finding and is expected to be cleared by the deterministic re-pass against the exemption).
- No redraft requested; statements remain planner-frozen.

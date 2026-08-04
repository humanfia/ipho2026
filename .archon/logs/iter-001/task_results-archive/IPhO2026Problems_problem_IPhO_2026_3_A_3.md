# Task Result: IPhO2026Problems/problem_IPhO_2026_3_A_3.lean

- Stage: autoformalize (prover mode: physics-formalize), iteration 001.
- Outcome: **compiling by-sorry formalization created**. No errors; only the
  five expected `declaration uses 'sorry'` warnings (lean4 checker run:
  `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_3.lean` — exit 0).
  Full `lake build` also succeeds (only builds `IPhO2026Run`; see note below).
- Blueprint: `% archon:physics` marker confirmed present in
  `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_3.tex`.
- Official source page image `T3_page-2.png` was read: part T3-A3 (0.2 pts)
  asks to split `dW_emf` into `dW_vac` + `dW` and write `dW` in terms of
  `μ₀, H, V, dM`; the T3-B preamble records the fallback form
  `dW = α·V·μ₀·H·dM` (α a number), confirming the target `dW = μ₀·V·H·dM`.

## Assumption/target split

**Governing laws (assumed):**
- Ampère's law for H (T3-A hint): `∮ H·dℓ = I_C = N·I` on the mean circle;
  encoded as `AmpereLawTorus` (`H = N·I·A/V`) + hypothesis
  `PmTVariation.H_ampere`. Geometric bridge `2πR = V/A` recorded as
  `meanCircumference_eq` (provable from `PmTTorus.V_eq`).
- Constitutive relation `B = μ₀·H + μ₀·M`: def `ConstitutiveBH`, hypotheses
  `PmTVariation.BH` (state) and `PmTVariation.dBH` (increment law
  `dB = μ₀·dH + μ₀·dM` — the linear differential of the governing law; it
  contains no `dW`, so it does not pre-assert the answer).
- `μ₀` from PhysLean `Electromagnetism.FreeSpace` (`𝓕.μ₀ : ℝ`, `0 < μ₀`) —
  grounded, no local reinvention.

**Figure/data readouts (setup parameters):** `PmTTorus` (R, r with `0 < r < R`
for `r ≪ R`, A, V with positivity and `V = 2πR·A`), `PmTWinding` (N turns,
signed instantaneous current I, `0 < N`). Read directly from the problem
text on the official page image.

**Previous-part results (assumed, natural-language prerequisite only):**
- A.2: `dW_emf = V·H·dB` → hypothesis `PmTWorkBudget.emf_source`.

**Current target conclusions (NOT assumed anywhere):**
- `dW = μ₀·V·H·dM` — only the conclusion of the main theorem
  `dW_eq_mu0_V_H_dM` (label `thm:physics:IPhO_2026_3_A_3:target`).

## Goal-faithfulness audit

- No hypothesis, structure field, `Laws`/`Satisfies` predicate, or local
  definition mentions `dW = μ₀*V*H*dM` (or any equation solving for `dW`).
  `dW` appears only in hypotheses `split : dW_emf = dW_vac + dW` (the
  *problem statement's own* decomposition, which defines what `dW` refers to,
  not its value) and `emf_source`/`vacuum_part` (previous-part inputs, no
  `dW`).
- The answer is not hidden in a definition: `AmpereLawTorus`,
  `ConstitutiveBH` are governing laws; no local def unfolds to the target.
- No statement weakened: main theorem states the exact recorded answer as an
  equality of reals; orientation (incoming work positive, signed current →
  signed H via the non-reordered `AmpereLawTorus`) preserved in the model.
- Not replaced by `True`/tautology/reflexivity; all four proof bodies are
  honest `by sorry`.

## Derivability and bridge obligations

Informal derivation (from `split`, `emf_source`, `vacuum_part`, `dBH`):
`dW = V·H·dB − μ₀·V·H·dH` → `dW = V·H·(dB − μ₀·dH)` = `V·H·(μ₀·dM)`.

1. Source claim: `dW_emf = V·H·dB` (part A.2).
   Carrier: `PmTWorkBudget.emf_source`. Status: **covered** (encoded locally
   as a previous-part hypothesis; policy forbids importing A.2 Lean output
   anyway).
2. Source claim: source work splits into vacuum-core part and material work.
   Carrier: `PmTWorkBudget.split`. Status: **covered** (direct from current
   problem statement; `dW_eq_sub_vac` derives the subtraction form —
   1-step `linarith`, left `sorry` per by-sorry discipline).
3. Source claim: substitute laws and collect `V·H`.
   Carrier: `dW_eq_VH_dB_sub_mu0_dH` (`dW = V·H·(dB − μ₀·dH)`).
   Status: **covered** (ring/linarith from 1+3-fields; lemma stated, sorry).
4. Source claim: vacuum-core work is `dW_vac = μ₀·V·H·dH` (A.2 law applied at
   `M = 0`, where `dB = μ₀·dH`). Carrier: `PmTWorkBudget.vacuum_part`, with
   the vacuum-increment specialization recorded as `dB_of_vacuum_core`
   (1-step via `mul_zero`/`add_zero`, sorry body). Status: **covered**
   (encoded as licensed assumption — the single largest logical leap;
   flagged here so a later prover pass can, if desired, discharge it by
   instantiating the A.2 law at `M = 0` in a richer model).
5. Source claim: final relation `dW = μ₀·V·H·dM`.
   Carrier: main theorem `dW_eq_mu0_V_H_dM` (the main contract itself).
   Proof route: lemma 3 + `PmTVariation.dBH` + ring. Status: **covered**
   (statement grounded; proof `sorry`).

No blocked bridges: every substantive step has a named Lean carrier.

## Abstraction sufficiency and countermodel audit

- `AmpereLawTorus` : Prop — exposes the equation `H = N·I·A/V` (projects to
  the A.1 result; usable rewrite). Constraining: fixing the geometry, N, I
  fixes H (and its sign follows sign(I), no abs()).
- `ConstitutiveBH` : Prop — exposes `B = μ₀·H + μ₀·M`; rewriting eliminates B.
- `PmTVariation` — packages state + increments with the increment law
  `dBH : dB = μ₀·dH + μ₀·dM`. This plus `vacuum_part` is exactly what makes
  the target derivable: without `dBH`, `dB − μ₀·dH` would be unconstrained
  and the conclusion falsifiable (countermodel: arbitrary `dB`); with it,
  `dB − μ₀·dH = μ₀·dM` is forced.
- `PmTWorkBudget` — exposes three usable equations (`emf_source`, `split`,
  `vacuum_part`), plus elimination lemmas `dW_eq_sub_vac`,
  `dW_eq_VH_dB_sub_mu0_dH`. Countermodel sanity: pretend the fields could be
  interpreted arbitrarily with all assumptions true but `dW ≠ μ₀·V·H·dM` —
  impossible, since `split`, `emf_source`, `vacuum_part`, `dBH` jointly
  determine `dW` up to a ring computation. The contract is fully
  determined.
- No bare existential-witness Props; every Prop interface carries an
  equational consequence.

## Uncertainty and branch coverage

- Uncertainty: **not applicable** — the source reports an exact symbolic
  relation; no `value ± uncertainty` data in this subquestion.
- Signed/orientation coverage: **covered** — sign convention (work entering
  the torus positive) documented on `PmTWorkBudget`; signed current I and
  non-abs `H` in `AmpereLawTorus` keep the signed-answer branch; the vacuum
  vs. total branch of work is represented by the split hypotheses, not by
  choosing signs only in the conclusion. CW/CCW tangency branches do not
  arise in this scalar 1-D scalar-field subquestion.

## Declarations created (blueprint label → Lean)

All under `namespace IPhO2026.T3A3` in
`IPhO2026Problems/problem_IPhO_2026_3_A_3.lean`:

- `PmTTorus` — torus geometry/parameters (R, r, A, V, thin-torus identity).
- `PmTWinding` — N turns, instantaneous current I.
- `AmpereLawTorus` — Ampère's-law relation for the wound torus.
- `meanCircumference_eq` — geometric lemma `2πR = V/A` (sorry).
- `PmTFieldState` — uniform (H, B, M) state.
- `ConstitutiveBH` — governing law `B = μ₀H + μ₀M`.
- `PmTVariation` — admissible infinitesimal process with `dBH`.
- `dB_of_vacuum_core` — vacuum-core increment lemma (sorry).
- `PmTWorkBudget` — work-budget hypotheses (A.2 law, A.3 split, vacuum part).
- `dW_eq_sub_vac` — subtraction lemma (sorry).
- `dW_eq_VH_dB_sub_mu0_dH` — substitution lemma (sorry).
- `dW_eq_mu0_V_H_dM` — **main target** for
  `thm:physics:IPhO_2026_3_A_3:target` (sorry).

The blueprint chapter has a single `theorem` environment carrying label
`thm:physics:IPhO_2026_3_A_3:target`; it covers the whole formalization
block above (the plan agent may split it into finer
`definition`/`lemma` environments if it wants per-declaration labels).

## \leanok status

- I did not edit the blueprint chapter (write-permission boundary). The
  chapter's single environment is ready for `\leanok` once the deterministic
  sync marks it: the file compiles with only expected sorry warnings.

## LeanExplore queries / candidates actually used

- Query "Ampere's law magnetic field magnetization torus electromagnetic
  work" → near misses (`Electromagnetism.MagneticField`,
  `ElectromagneticPotential.*`); none model H/magnetization/constitutive law.
- Query "vacuum permeability mu_0 physical constant" →
  `Electromagnetism.FreeSpace.μ₀_nonneg/μ₀_ne_zero`, `FreeSpace` (id 385663).
- `get_source_code`/`get_module` on `FreeSpace` → confirmed structure
  `{ε₀, μ₀ : ℝ, ε₀_pos, μ₀_pos}`, module
  `Physlib.Electromagnetism.Dynamics.Basic`; used directly in the file.

## PhysLean/Mathlib names grounded

- `Electromagnetism.FreeSpace` + projections `𝓕.μ₀`, `𝓕.μ₀_pos`
  (Physlib.Electromagnetism.Dynamics.Basic) — vacuum permeability.
- `Real.pi`, `ℝ` arithmetic (Mathlib).

## Local abstractions introduced (and why they preserve meaning)

- `PmTTorus`, `PmTWinding`, `PmTFieldState` — small structures that keep the
  dimensional roles (m, m², m³; turns/A; A/m, T, A/m) as named real fields
  with physical positivity hypotheses, rather than scalar aliases.
- `AmpereLawTorus`, `ConstitutiveBH`, `PmTVariation.dBH` — governing-law
  relations as equation-exposing Props (not final formulas of A.3).
- `PmTWorkBudget` — work quantities as joule-valued reals with explicit
  law/split hypotheses; captures the sign convention in docstrings and keeps
  `dW` defined by the split, never by the answer.

## Grounding gaps

- PhysLean has no magnetization `M`, no `H`-field/Ampère's-law-for-H API, and
  no magnetic-work `H dB`/`H dM` formalism (searched; only vacuum EM
  potentials/fields exist) → faithful local abstractions used instead, as
  permitted. Mismatch recorded for the near-miss list above.
- Infrastructure note (not a sorry justification): `lakefile.toml` and
  `IPhO2026Run.lean` do not yet enumerate `IPhO2026Problems/*.lean`, so
  `lake build` does not compile the new library file; I verified it with
  `lake env lean` (exit 0, five sorry warnings only). The plan agent
  (loop-infrastructure owner) may want similar coverage for all 28 files.

## Redraft requests

- None. A later prover pass could optionally strengthen the model by
  deriving `vacuum_part` from a standalone `VacuumSourceWork` law
  (`∀ H dH, dW_vac = μ₀·V·H·dH` justified as "A.2 instantiated at M = 0");
  the current hypothesis form is faithful and sufficient.

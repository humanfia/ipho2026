# Task result: IPhO2026Problems/problem_IPhO_2026_1_C_1.lean (iter-017 Review hand-off, autoformalize redraft lane)

## Verdict: no redraft — certificate is `solved` / `redraft_kind: not_applicable`; file re-verified clean

The Review certificate handed to this lane routes **solved** with
`redraft_kind: not_applicable`: the iter-017 contract redraft
(`IsScatteringAngle` admits the degenerate official critical configuration
`p = 0`; backward `hdisc` strengthened to the real-root condition
`0 ≤ 1 − 2ΔU/(mc²)`) was already executed under the validated
`needs_redraft`/`other_modeling_defect` certificate, and the iter-018 proof
lane closed the two remaining reachability `sorry`s editing proof bodies only.
There is no certificate-stated root cause left to repair. Per the hand-off
discipline ("keep the file compiling, make the redraft evidence durable"),
this lane re-ran the deterministic preflight and axiom audit and records the
required formalization audits below. **The `.lean` file was not modified.**

### Fresh verification evidence (this lane)

- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`: **EXIT=0,
  0 errors, 17.6 s**. Warnings: exactly the 4 cosmetic unused-binder linter
  notes at lines 320 (`hθ`, `hθpos`), 321 (`hfac`), 490 (`hrange` — a
  frozen-signature hypothesis used only via `hrange.1` inside `linarith`).
  No `declaration uses 'sorry'` warning ⇒ **sorry_count = 0**.
- `grep -n "sorry|admit|native_decide|^axiom"`: matches only inside doc
  comments (lines 51, 60 narrate the iter-017/018 history); none in proof
  bodies. No `/- USER: ... -/` hints present in the file.
- `lean_verify IPhO2026.Problem1.C1.minimum_angular_frequency_T1_C1`:
  axioms `[propext, Classical.choice, Quot.sound]`; warnings only the 6
  pre-existing intentional `opaque` constants (lines 81–97).
- `lean_verify IPhO2026.Problem1.C1.minimum_angular_frequency_backward_branch_T1_C1`:
  axioms `[propext, Classical.choice, Quot.sound]`; same opaque-constant
  warnings.
- `archon-protected.yaml`: contains only commented template text — nothing
  protected; no protected contract is involved in this target.

## Assumption/target split

- **Governing laws (assumption side):**
  - `IsTwoBodyDissociation` (structure): vector momentum conservation
    `q = (ℏω/c) • k̂ − p` (`q_unique`) with its proved cosine-law shadow
    `‖q‖² = (ℏω/c)² + ‖p‖² − 2(ℏω/c)‖p‖cosθ` (`momentum_q_sq`); Figure-1c
    angle readout (`angle_readout : IsScatteringAngle`); non-relativistic
    energy balance `ℏω = ΔU + ‖p‖²/(2·2m) + ‖q‖²/(2m)` with fragment masses
    `2m` (O₂) and `m` (O).
  - `ConstantRegime` (structure): `ℏ > 0`, `c > 0`, `m > 0`, `ΔU > 0`
    (endothermic dissociation) — inhabited, no vacuity.
  - Photon momentum law `p_γ = ℏω/c` appears as the literal coefficient
    `hbar * ω / speedOfLight` in the law fields.
- **Previous-part results:** none (C.1 is the first subquestion of Part C).
- **Figure/data readouts:** `PhotonLine` (unit incident direction k̂),
  `IsScatteringAngle` (cosine-law component readout `⟪k̂,p⟫ = ‖p‖cosθ`,
  vacuous at the degenerate `p = 0` per the official threshold
  configuration), `IsAngularRange` (`θ ∈ [0, π]`), `IsForwardBranch`
  (`θ ≤ π/2`); discriminant/real-root hypotheses `hdisc` on both main
  theorems (forward: at `θ`; backward: at `π/2`).
- **Current target conclusions (conclusion side only):**
  - `minimum_angular_frequency_T1_C1`:
    `IsDissociationThreshold m ΔU θ (hbarOmegaMin m c ΔU θ)` for
    `0 < θ ≤ π/2` — reachability **and** minimality of the recorded
    closed-form candidate.
  - `minimum_angular_frequency_backward_branch_T1_C1`:
    `IsDissociationThreshold m ΔU θ (hbarOmegaMin m c ΔU (π/2))` for
    `π/2 ≤ θ ≤ π` — the official freeze of the threshold at its `π/2` value.

## Goal-faithfulness audit

- The recorded answer `hbarOmegaMin` is a bare scalar `def` asserting nothing;
  it occurs only in conclusions (`IsDissociationThreshold … (hbarOmegaMin …)`),
  in the proved auxiliary `quadratic_characterization_of_threshold`, and in
  value/symmetry lemmas. It is never a hypothesis, `Laws` field, premise
  field, or `Satisfies…` predicate.
- `ReachableFrequency` is an existential over lawful configurations;
  `IsDissociationThreshold` is reachability + minimality over all smaller
  positive frequencies — both answer-free.
- `IsScatteringAngle` is the bare cosine law (no `p ≠ 0`, no threshold
  content); `IsTwoBodyDissociation` fields are the conservation laws
  themselves, none quantifies over configurations or mentions a minimum.
- `rfl`-provable items are only naming/helper expansions (e.g.
  `hΩ : hbarOmegaMin … = X / (hbar * S)`); no substantive answer is closed
  by unfolding.
- The degenerate `p = 0` admittance is a *governing-geometry* relaxation
  forced by the official solution's critical configuration (machine-refuted
  old contract), not a smuggling of the answer: the cosine law at `p = 0` is
  `0 = 0`, which constrains nothing by itself — the energy/momentum fields
  still do all the work.

## Derivability and bridge obligations

| # | Source claim | Lean carrier | Status |
|---|---|---|---|
| 1 | Vector momentum balance ⇒ cosine-law `‖q‖²` equation | `momentum_q_sq_of_vector_balance` (proved via `real_inner_sub_sub_self`, `inner_self_eq_norm_sq_to_K`, `k.direction_unit`) | **covered** (proved) |
| 2 | `2 sin²θ + 1 = 2 − cos 2θ` (official coefficient match) | `two_sin_sq_add_one_eq` (`Real.cos_two_mul`, `Real.sin_sq_add_cos_sq`) | **covered** (proved) |
| 3 | Candidate = smallest positive root of `(2−cos2θ)E² − 6mc²E + 6ΔUmc² = 0` | `quadratic_characterization_of_threshold` (root factorization `(SE−A₋)(SE+A₊)=0`, `linear_combination`) | **covered** (proved) |
| 4 | Fields of any lawful config ⇒ `P = ‖p‖` solves `3P² − 4a cosθ·P + (2a²+4mΔU−4mE) = 0` | `config_quadratic` (`field_simp` + `linear_combination -henb`) | **covered** (proved) |
| 5 | `cosθ ≤ 0` ⇒ `C(E) ≤ 0` on reachable `E` (backward recoil sign) | `reachable_C_nonpos_of_cos_nonpos` | **covered** (proved) |
| 6 | Candidate value at `π/2`: `ℏΩ(π/2) = mc²(1−√(1−2ΔU/(mc²)))` | `hbar_mul_hbarOmegaMin_pi_div_two` | **covered** (proved) |
| 7 | Forward reachability: official critical configuration `p = !₂[P₀cosθ, P₀sinθ]`, `P₀ = 2(E₀/c)cosθ/3` (degenerate `p=0` at `θ=π/2`) | reachability conjunct of `minimum_angular_frequency_T1_C1` (coordinate witness, `EuclideanSpace.norm_eq`, `PiLp.inner_apply`, `Fin.sum_univ_two`) | **covered** (proved, iter-018) |
| 8 | Forward minimality: discriminant `(6‖p‖−4a cosθ)² ≥ 0` ⇒ `Q(E) ≤ 0` ⇒ `E ≥ ℏΩ` | minimality conjunct of `minimum_angular_frequency_T1_C1` | **covered** (proved) |
| 9 | Backward reachability: degenerate official witness `p = 0`, `q = (ℏΩ(π/2)/c)•k̂`; energy balance is `C(E₀) = 0` | reachability conjunct of `minimum_angular_frequency_backward_branch_T1_C1` | **covered** (proved, iter-018) |
| 10 | Backward minimality: `E < ℏΩ(π/2)` ⇒ `C(E) > 0`, contradicting #5 | minimality conjunct of `minimum_angular_frequency_backward_branch_T1_C1` | **covered** (proved) |
| 11 | Reflection symmetry `Ω(π−θ) = Ω(θ)` (freeze justification) | `hbarOmegaMin_pi_sub` (`Real.sin_pi_sub`) | **covered** (proved) |

No bridge is blocked. Main contract carrier for the source-to-target map:
`minimum_angular_frequency_T1_C1` / `…_backward_branch_T1_C1`.

## Abstraction sufficiency and countermodel audit

- `IsTwoBodyDissociation` (Prop-structure): every field is an equation
  (`momentum_q_sq`, `q_unique`, `energy_balance`) or the cosine-law readout
  (`angle_readout`). `momentum_q_sq_of_vector_balance` proves the scalar
  field is the eliminated shadow of the vector equation — a countermodel must
  satisfy a genuine vector balance, not an arbitrary scalar identity.
  `config_quadratic` is the reusable elimination theorem exposing the
  `P`-quadratic consequence used by both minimality proofs.
- `IsScatteringAngle`: single equation `⟪k̂,p⟫ = ‖p‖cosθ`; at `p ≠ 0` it pins
  `θ` as the angle between the momenta; at `p = 0` it is vacuous by design
  (official degenerate threshold configuration). Constraining because the
  main theorems' witnesses and the `config_quadratic` elimination route all
  consume it.
- `ReachableFrequency` / `IsDissociationThreshold`: existential + universal
  minimality — not witness-assertions over an opaque relation; the proofs
  exhibit concrete witnesses and derive the universal bound.
- `ConstantRegime`: positivity fields only; inhabited (any physical
  `ℏ, c, m, ΔU > 0`); no degenerate countermodel since the theorems
  universally quantify over the regime.
- `opaque` constants (6): intentional — prevents closing contracts by
  unfolding; flagged by `lean_verify` as known patterns, not defects.

## Uncertainty and branch coverage

- **Uncertainty:** not applicable — the source reports no `value ± error`
  data; all quantities are exact symbolic parameters.
- **Branch coverage:** covered. `IsForwardBranch` (`θ ≤ π/2`) and the
  backward hypothesis `π/2 ≤ θ` are hypothesis-side; the forward theorem
  includes the boundary `θ = π/2` (degenerate witness), the backward theorem
  freezes at `Ω(π/2)` exactly as the official solution; `IsAngularRange`
  keeps `θ ∈ [0, π]`; `hθpos : 0 < θ` excludes the trivial `θ = 0` endpoint
  on the forward branch. Orientation/sign information (outgoing `O₂` angle
  measured from the incident photon direction) is carried by the cosine-law
  readout.

## Declarations and blueprint labels

All declarations already exist (created iters 001–017, proved through
iter-018); none added in this lane:

| Lean declaration | Blueprint label |
|---|---|
| `dissociationEnergyGap` | `def:…:dissociationEnergyGap` |
| `ConstantRegime` | `def:…:ConstantRegime` |
| `ReactionPlane` | `def:…:ReactionPlane` |
| `PhotonLine` | `def:…:PhotonLine` |
| `IsScatteringAngle` | `def:…:IsScatteringAngle` |
| `IsAngularRange` | `def:…:IsAngularRange` |
| `IsForwardBranch` | `def:…:IsForwardBranch` |
| `IsTwoBodyDissociation` | `def:…:IsTwoBodyDissociation` |
| `momentum_q_sq_of_vector_balance` | `lem:…:momentum_q_sq_of_vector_balance` |
| `ReachableFrequency` | `def:…:ReachableFrequency` |
| `IsDissociationThreshold` | `def:…:IsDissociationThreshold` |
| `hbarOmegaMin` | `def:…:hbarOmegaMin` |
| `two_sin_sq_add_one_eq` | `lem:…:two_sin_sq_add_one_eq` |
| `quadratic_characterization_of_threshold` | `lem:…:quadratic_characterization_of_threshold` |
| `minimum_angular_frequency_T1_C1` | `thm:…:minimum_angular_frequency_T1_C1` |
| `minimum_angular_frequency_backward_branch_T1_C1` | `thm:…:minimum_angular_frequency_backward_branch_T1_C1` |
| `hbarOmegaMin_pi_sub` | `thm:…:hbarOmegaMin_pi_sub` |
| `config_quadratic`, `reachable_C_nonpos_of_cos_nonpos`, `hbar_mul_hbarOmegaMin_pi_div_two` | **no blueprint entry yet** (coverage debt, see below) |

## Marker guidance (review agent; blueprint untouched by this lane)

- Both main theorems' proof blocks are sorry-free and compile ⇒ eligible for
  `\leanok` under the deterministic sync; all other declarations already
  proved.
- Standing blueprint drift to re-key (flagged since iter-017, **not editable
  by provers**):
  1. `def:…:IsScatteringAngle` prose still says "the fragment is strictly
     outgoing, $p \neq 0$" — pre-redraft; the Lean contract is the bare
     cosine law admitting `p = 0`.
  2. Recorded-answer display (.tex lines 26 and 254) is missing the factor
     `2` inside the square root (`(2ΔU/(3mc²))(2sin²θ+1)`); the Lean
     `hbarOmegaMin` is correct — blueprint-side transcription slip for the
     blueprint doctor.
  3. Coverage debt: `\lean{}` entries missing for `config_quadratic`,
     `reachable_C_nonpos_of_cos_nonpos`,
     `hbar_mul_hbarOmegaMin_pi_div_two` (proved helpers, scan-invisible
     `lean_aux` nodes).

## LeanExplore / search queries used

None in this lane (verification-only; no new API needed). Historical
grounding recorded in `physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_1.md`.

## PhysLean/Mathlib names grounded (file-wide)

Mathlib: `EuclideanSpace ℝ (Fin 2)`, `PiLp.inner_apply`,
`inner_self_eq_norm_sq_to_K`, `real_inner_sub_sub_self`,
`real_inner_smul_left/right`, `real_inner_self_eq_norm_sq`,
`EuclideanSpace.norm_eq`, `Fin.sum_univ_two`, `Real.cos_two_mul`,
`Real.sin_sq_add_cos_sq`, `Real.sq_sqrt`, `Real.sqrt_nonneg`,
`Real.sqrt_le_sqrt`, `Real.sqrt_sq`, `Real.cos_nonneg_of_mem_Icc`,
`Real.cos_nonpos_of_pi_div_two_le_of_le`, `Real.sin_pi_div_two`,
`Real.sin_pi_sub`, `abs_lt_of_sq_lt_sq`, `div_le_div_iff_of_pos_right`,
`mul_pos_of_neg_of_neg`, `mul_nonpos_of_nonneg_of_nonpos`.
PhysLean: standing iter-002 exemption — no photodissociation-kinematics
module exists; `import Mathlib` baseline only (chapter NOTE records this).

## Local abstractions introduced (historical, still current)

`ReactionPlane` (abstract Euclidean 2-space — keeps the angle intrinsic),
`PhotonLine` (unit-direction bundle), `IsScatteringAngle` / `IsAngularRange`
/ `IsForwardBranch` (geometry/branch readouts), `IsTwoBodyDissociation`
(conservation-law structure), `ReachableFrequency` /
`IsDissociationThreshold` (answer-free reachability/minimality), `opaque`
universal constants. Each preserves the physical role per the countermodel
audit above; no scalar placeholder aliases are used.

## Grounding gaps / redraft requests

- **Grounding gaps:** none outstanding (PhysLean exemption documented).
- **Redraft requests:** none. Contract and proofs are final per the Review
  certificate; the three blueprint-prose items above are for the
  plan/review/blueprint-doctor lanes, not the Lean file.

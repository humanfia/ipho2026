# Task result — IPhO2026Problems/problem_IPhO_2026_3_B_2.lean (iter-012, autoformalize)

**Status: COMPILING by-sorry formalization delivered.** Fresh
`lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` (this iter):
**0 errors, 3 `sorry` warnings** at L164 (`adiabatic_invariant_along_path`),
L178 (`endpoint_relation`), L212 (`adiabatic_temperature_change`). No other
diagnostics. No file edits were needed this iter — the iter-012 mandatory
redraft (path-differentiability fields) already landed; this lane re-ran the
full workflow (blueprint, official source, grounding search, countermodel
audit, fresh compile) and confirms the file faithfully meets the contract.

## Assumption/target split

- **Governing laws** (hypotheses, conclusion-free):
  - equation of state `T·M·V = n·K·H` — `ParamagneticTorusLaws.eq_of_state`
    (pointwise along the path);
  - heat capacity at constant magnetization `C_M = n·λ/T²` —
    `ParamagneticTorusLaws.heat_capacity` (defining equation + integrability);
  - `dU = C_M·dT` together with the magnetic work on the material
    `dW = μ₀·V·H·dM` — `ParamagneticTorusLaws.work_rate` (rate
    `μ₀·V·H·dM/dt` along the path, from part A.3);
  - adiabatic first law (`δQ = 0`, heat/work entering the torus positive):
    `C_M·dT/dt = −ẇ` — `IsAdiabaticPath`;
  - quasistatic regularity: positive temperature (`temp_pos`), pointwise
    differentiability of `T(t)` and `M(t)` (`temp_differentiable`,
    `mag_differentiable` — the iter-012 redraft addition).
- **Previous-part results**: A.3's `dW = μ₀·V·H·dM`
  (policy: natural-language prerequisite only; carried by the `work_rate`
  law field, not an imported Lean artifact).
- **Figure/data readouts**: scalar collinear `(H, M, T)` state components
  (`ParamagneticTorusState`); fixed positive parameters `V, n, K, λ, μ₀`
  (`TorusParameters`); initial endpoint `(H_i ≥ 0, T_i > 0)` on the path
  (`AdiabaticEndpoints`); witnessed final state `(H_f, T_f)` with
  `T_f > 0` (`hfinal`, `hTf_pos`). No numeric figure values occur in B.2.
- **Current target conclusions** (conclusion side only):
  `ΔT = T_f − T_i = T_i·(√((λ + μ₀·K·H_f²)/(λ + μ₀·K·H_i²)) − 1)`
  (`adiabatic_temperature_change`), via the intermediate invariant equality
  (`adiabatic_invariant_along_path`, `endpoint_relation`).

## Goal-faithfulness audit

- The closed-form square-root answer appears in **no** hypothesis, structure
  field, premise, or local definition: `ParamagneticTorusLaws` carries only
  the EOS, `C_M`, and work-rate laws; `IsAdiabaticPath` carries only the
  first-law balance `C_M·Ṫ = −ẇ`; `AdiabaticEndpoints` carries only
  endpoint incidence and sign data. The target expression occurs solely in
  the conclusions of `endpoint_relation` (the invariant equality) and
  `adiabatic_temperature_change` (the √ formula).
- `adiabaticInvariant` is a named helper (`T²·(λ + μ₀·K·H²)`), not the
  answer; the final theorem statement expands the quotient-of-brackets
  √-form explicitly and is not provable by `rfl`.
- Even the derived first integral `T_f²(λ+μ₀KH_f²) = T_i²(λ+μ₀KH_i²)`
  (B.2's own intermediate step) is kept conclusion-side in
  `endpoint_relation`; hypotheses stop at the *differential* law
  `C_M dT = −μ₀VH dM`. This matches the official T3 solution text
  (first-hand read at sibling
  `hf-IPHO2026-upload/ipho_2026_source/text/T3_solution.txt`, T3-B2 block):
  official route is the same first law + EOS, separating variables and
  integrating `(nλ/T³)dT = (μ₀V²/nK)M dM` toλ(1/T_i² − 1/T_f²)·(1/2) =
  (μ₀V²/2nK)(M_f² − M_i²), then substituting `M = nKH/(TV)` to get
  `T_f²/T_i² = (λ+μ₀KH_f²)/(λ+μ₀KH_i²)`. No premise asserts any integrated
  or ratio form.
- Sign convention (work/heat entering positive) is fixed by the balance
  `C_M·Ṫ = −ẇ` with `ẇ = μ₀VH Ṁ` — the minus sign is the first law, not a
  conclusion. Branch/orientation: the ramp direction is left free (`H_f`
  arbitrary sign, `H_i ≥ 0` initial datum); `lam_add_mu0_K_sq_pos` certifies
  both brackets strictly positive so the √ quotient is well-defined for
  either direction; `T_f > 0` selects the positive root (physical branch).

## Derivability and bridge obligations

1. **Source claim**: first law for adiabatic process gives
   `(nλ/T³)dT = (μ₀V²/nK)M dM` after substituting `H = TMV/(nK)`.
   - Carrier: `ParamagneticTorusLaws` (EOS + `heat_capacity` + `work_rate`)
     ∧ `IsAdiabaticPath` (balance) + `temp/mag_differentiable`.
   - Status: **covered** (encoded locally; pointwise `deriv` equations are
     informative thanks to the differentiability fields).
2. **Source claim**: integrating from `(T_i,M_i)` to `(T_f,M_f)`:
   `(nλ/2)(1/T_i² − 1/T_f²) = (μ₀V²/2nK)(M_f² − M_i²)`.
   - Carrier: `adiabatic_invariant_along_path` (constancy of
     `T²(λ+μ₀KH²)`, via MVT on the everywhere-differentiable,
     zero-derivative invariant — chapter proof route).
   - Status: **covered** as a contracted `sorry`; the differentiability
     fields make the MVT route derivable (this was the iter-011 blocker,
     fixed by the landed redraft).
3. **Source claim**: substitution `M = nKH/(TV)` yields
   `T_f²(λ+μ₀KH_f²) = T_i²(λ+μ₀KH_i²)`.
   - Carrier: `endpoint_relation` (uses `adiabatic_invariant_along_path` +
     endpoint incidence from `AdiabaticEndpoints`/`hfinal`).
   - Status: **covered** as a contracted `sorry`.
4. **Source claim**: taking positive square roots,
   `ΔT = T_i(√((λ+μ₀KH_f²)/(λ+μ₀KH_i²)) − 1)`.
   - Carrier: `adiabatic_temperature_change` (uses `endpoint_relation`,
     `lam_add_mu0_K_sq_pos`, `T_i > 0`, `T_f > 0`; `Real.sqrt` algebra).
   - Status: **covered** as a contracted `sorry`.
5. **Source claim**: `λ + μ₀KH² > 0` for either ramp direction.
   - Carrier: `lam_add_mu0_K_sq_pos` — **proved** (`positivity`), no sorry.

Direct source-to-contract mapping for the requested output: carrier of the
final relation is the main theorem `adiabatic_temperature_change`.

## Abstraction sufficiency and countermodel audit

Local `Prop`-valued interfaces and why they constrain:

- `ParamagneticTorusLaws` (structure of equations + regularity): exposes
  pointwise **equations** (`T·M·V = nKH`, `C_M = nλ/T²`,
  `ẇ = μ₀VH·dM/dt`), positivity (`0 < T`), differentiability fields, and
  `IntervalIntegrable` facts. Not witness-only.
- `IsAdiabaticPath` (def): exposes the pointwise **equation**
  `C_M(t)·dT/dt = −ẇ(t)` with `C_M, ẇ` pinned by defining equations — an
  ODE constraint, not an opaque relation.
- `AdiabaticEndpoints` (structure): sign inequalities `H_i ≥ 0`, `T_i > 0`
  plus an existential incidence on the path.

*Countermodel check* (iter-011 class): without the differentiability fields,
`deriv` of a non-differentiable path reads junk `0`, the first-law balance
degenerates to `0 = 0`, and the invariant claim is false in general — the
fields rule that class out. With all fields interpreted freely (choose
`C_M := fun t => nλ/T(t)²`, `ẇ := fun t => μ₀VH(t)Ṁ(t)` — forced by the
defining equations), the remaining freedom is exactly the path `p`; the
conclusion of the main theorem is a theorem of the ODE + endpoints, not a
tautology, and is false for arbitrary non-adiabatic paths (balance field
excluded), so the contract is not underdetermined. Endpoint signs
(`T_i,T_f > 0`) rule out the negative-root countermodel of the √ step.

## Uncertainty and branch coverage

- Uncertainty (`±`): **not applicable** — B.2 asks for an exact symbolic
  `ΔT`; the source reports no measured values or tolerances in this part.
- Branch/orientation: **covered** — `H_i ≥ 0`, `T_i > 0`, `T_f > 0`
  hypotheses + `lam_add_mu0_K_sq_pos` keep the signed-field ramp and the
  positive square-root branch explicit; ramp direction stays hypothesis-free
  (answer valid for `H_f` of either sign).

## Declarations and blueprint labels

- `IPhO2026_3_B_2.ParamagneticTorusState` —
  `def:...:ParamagneticTorusState`
- `IPhO2026_3_B_2.StatePath` (abbrev, helper) — chapter ledger
- `IPhO2026_3_B_2.TorusParameters` — `def:...:TorusParameters`
- `IPhO2026_3_B_2.ParamagneticTorusLaws` — `def:...:ParamagneticTorusLaws`
- `IPhO2026_3_B_2.IsAdiabaticPath` — `def:...:IsAdiabaticPath`
- `IPhO2026_3_B_2.adiabaticInvariant` (helper) — chapter ledger
- `IPhO2026_3_B_2.AdiabaticEndpoints` — `def:...:AdiabaticEndpoints`
- `IPhO2026_3_B_2.adiabatic_invariant_along_path` —
  `lem:...:adiabatic_invariant_along_path` (`sorry`, contracted)
- `IPhO2026_3_B_2.endpoint_relation` — `lem:...:endpoint_relation`
  (`sorry`, contracted)
- `IPhO2026_3_B_2.lam_add_mu0_K_sq_pos` —
  `lem:...:lam_add_mu0_K_sq_pos` (**proved**)
- `IPhO2026_3_B_2.adiabatic_temperature_change` —
  `thm:...:adiabatic_temperature_change` (`sorry`, contracted; covers
  `thm:physics:IPhO_2026_3_B_2:target`)
- File-level target theorem — `thm:physics:IPhO_2026_3_B_2:target`

`\leanok` markers: per standing infrastructure rules, `sync_leanok` owns all
`\leanok` markers deterministically (review agent guidance agrees); the file
currently still carries 3 sorries, so no marker flips are expected or
requested. All `\lean{}` names match the declarations first-hand.

## LeanExplore queries / grounding

- Queries run this iter (LeanExplore, packages `[Mathlib, Physlib]`):
  “magnetic work magnetization thermodynamics” (near misses:
  `Electromagnetism.MagneticField`, potential-based field APIs —
  vector-field formalism, no thermodynamic work identity) and
  “heat capacity paramagnetic Curie law adiabatic” (near misses:
  `CanonicalEnsemble.heatCapacity` — statistical-mechanics heat capacity,
  not a material law `C_M = nλ/T²`; no cyclic magnetization-work or
  Curie-paramagnet module).
- PhysLean/Mathlib names grounded in the file: imports
  `Physlib.Electromagnetism.Dynamics.Basic` (domain import per the iter-004
  reconciliation note; `μ₀` itself is carried as the parameter `mu0` since
  the problem uses only the bare dimensional constant),
  `Mathlib.Analysis.Calculus.Deriv.Basic` (`deriv`, `DifferentiableAt`),
  `Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic`
  (`IntervalIntegrable`); `Real.sqrt`, `positivity` from Mathlib.
- Local abstractions (why faithful): `ParamagneticTorusState` /
  `StatePath` / `TorusParameters` / the two law predicates keep `H, M, T`
  as a structured thermodynamic state with named SI roles (A/m, A/m, K)
  rather than bare real aliases; PhysLean has no paramagnetic-torus
  object, so this is the smallest meaning-preserving interface (matches
  the physics-modeling rules).

## Grounding gaps / redraft requests

- No redraft requested; contract frozen by the iter-012 gate.
- Standing gap (unchanged, recorded since iter-004): PhysLean lacks a
  magnetization-work/heat-budget library; the A.3 work identity and the
  thermodynamic laws are faithful local law fields by design.
- The 3 sorries are the contracted work queue for the prover stage
  (chapter-proof routes recorded in the blueprint: product rule + MVT for
  the invariant; endpoint specialization; `Real.sqrt` algebra for the
  target).

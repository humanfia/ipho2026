# Task result — `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`

- Stage: autoformalize (prover mode **physics-formalize**), Archon iter 001.
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_2.tex` (contains `% archon:physics`).
- Source report: `reports/ipho_2026_k3/problem_IPhO_2026_3_B_2.source.json`.
- Status: file **compiles** with `lake env lean` (and `lake build` of the default target is green); only the three expected `declaration uses sorry` warnings remain (`adiabatic_invariant_along_path`, `endpoint_relation`, `adiabatic_temperature_change`). The auxiliary lemma `lam_add_mu0_K_sq_pos` is fully proved (`positivity`).

## Physical model extracted

Quantities and roles (SI units named in docstrings): applied field `H` (signed scalar component along the torus axis), magnetization `M`, absolute temperature `T > 0`, fixed volume `V > 0`, amount of substance `n > 0`, Curie-type material constant `K > 0`, heat-capacity constant `λ > 0` (`C_M = nλ/T²`), permeability of free space `μ₀ > 0`. Laws: equation of state `T·M·V = n·K·H`; `dU = C_M dT` with `C_M = n·λ/T²`; magnetic work on the material `dW = μ₀·V·H·dM` (A.3 reusable conclusion); sign convention: heat/work entering the torus positive. Target: adiabatic change `H_i → H_f` from `T_i` gives `ΔT = T_i·(√((λ + μ₀K H_f²)/(λ + μ₀K H_i²)) − 1)`.

## Assumption/target split

- Governing laws (hypotheses): `ParamagneticTorusLaws` (equation of state at every path point; heat capacity law `C_M(t) = nλ/T(t)²` with integrability; work-rate law `μ₀·V·H·dM/dt` with integrability; `T(t) > 0` regularity) and `IsAdiabaticPath` (first law with zero heat input: `Cm·dT/dt = −w`).
- Previous-part results: A.3's `dW = μ₀·V·H·dM` enters as the `work_rate` field of `ParamagneticTorusLaws` (natural-language prerequisite only; no previous Lean output imported, per policy).
- Figure/data readouts: none beyond the textual constants — the official source page image `T3_page-3.png` carries the apparatus figure for the torus but no numeric data used in this subquestion; positivity of all material constants and the endpoint data (`Hi ≥ 0`, `Ti > 0`, `Tf > 0`, existence of initial/final path points) are recorded in `TorusParameters` / `AdiabaticEndpoints`.
- Current target conclusion (never used as a hypothesis): `Tf − Ti = Ti·(√((λ + μ₀K Hf²)/(λ + μ₀K Hi²)) − 1)`, the conclusion of `adiabatic_temperature_change`; the auxiliary invariant equality `Tf²·(λ + μ₀K Hf²) = Ti²·(λ + μ₀K Hi²)` appears only as the conclusion of `endpoint_relation`.

## Goal-faithfulness audit

- No hypothesis, structure field, `Laws`/`Satisfies`-style predicate, or local definition mentions the square-root answer, the ratio `(λ+μ₀K Hf²)/(λ+μ₀K Hi²)`, or any closed form for `Tf`. The final expression occurs exactly once in the file: the conclusion of `adiabatic_temperature_change`.
- `IsAdiabaticPath` states the first law as a pointwise differential balance `Cm(t)·dT/dt = −w(t)`, which is the physical δQ = 0 condition, not the integrated answer. In particular it does not assert conservation of `T²·(λ+μ₀K H²)` — that conservation is the *conclusion* of the sorried bridge lemma `adiabatic_invariant_along_path`.
- `ParamagneticTorusLaws` fields are exactly the problem's stated laws plus regularity/integrability; none of them is the target relation or an unfolding of it.
- `adiabaticInvariant` is a mathematically inert abbreviation (a real-valued expression); its conservation is proved-by-sorry, not postulated.

## Derivability and bridge obligations

1. Equation of state → `M(t) = nK H(t)/(V T(t))`, hence `dM/dt = (nK/V)·(H' T − H T')/T²`.
   Carrier: `ParamagneticTorusLaws.eq_of_state` + `TorusParameters.V_pos` + `temp_pos`; status **covered** (encoding grounded; the differentiation belongs to the sorried bridge lemma 2).
2. Magnetic work of A.3 along the path → work-rate function `w(t) = μ₀ V H dM/dt`, integrable.
   Carrier: `ParamagneticTorusLaws.work_rate`; status **covered** (previous-part result encoded as a law hypothesis, per natural-language prerequisite policy).
3. First law, adiabatic: `dU = δW` with `dU = C_M dT` → `Cm·dT/dt = −w`.
   Carrier: `IsAdiabaticPath`; status **covered** (governing physical law stated directly, not the final formula).
4. Substituting 1 into 3 and cancelling `n/V` → `λ·T'/T² = −μ₀K·H·H'/T`, i.e. `dT/T = −(μ₀K/λ)H dH`; integration gives `log(Tf/Ti) = −(μ₀K/2λ)(Hf² − Hi²)`.
   Carrier: `adiabatic_invariant_along_path` (sorry) — the differential-form integration using the `IntervalIntegrable` regularity from `ParamagneticTorusLaws`. Status: **covered as a statement; proof deferred (sorry)**.
5. Exponentiating / clearing: `Tf²·(λ + μ₀K Hf²) = Ti²·(λ + μ₀K Hi²)`.
   Carrier: `endpoint_relation` (sorry), specialization of the invariant to the endpoints via `AdiabaticEndpoints.initial` and the final-state witness. Status: **covered as a statement; proof deferred (sorry)**.
6. Solving for `Tf` via `Real.sqrt` (positive branch selected by `Tf > 0`, `Ti > 0`, and `lam_add_mu0_K_sq_pos`, giving `Tf = Ti·√(ratio)` with the *positive* root) → `ΔT` formula.
   Carrier: `adiabatic_temperature_change` (sorry) using `lam_add_mu0_K_sq_pos` (proved). Status: **covered as a statement; proof deferred (sorry)**.
7. Direct source-to-contract mapping: the recorded answer `ΔT = T_i·(√((λ+μ₀K Hf²)/(λ+μ₀K Hi²)) − 1)` maps to the main-theorem contract `adiabatic_temperature_change`. Status: **covered**.

## Abstraction sufficiency and countermodel audit

- `ParamagneticTorusState`: structure with three named real fields (`field`, `magnetization`, `temperature`) — preserves roles without collapsing them to scalar aliases at the type level. PhysLean has no magnetization object (search: “paramagnetism magnetization Curie law magnetic susceptibility” → only field/potential APIs), so this is the smallest faithful local abstraction.
- `TorusParameters`: constants plus positivity proofs — the positivity fields actively constrain the model (used by `lam_add_mu0_K_sq_pos`, and needed for division by `V`, `n`, `T`).
- `ParamagneticTorusLaws` (Prop-valued): constraining via *pointwise equations* (`eq_of_state`, and the equations inside `heat_capacity`/`work_rate` existentials) plus `IntervalIntegrable … volume a b` facts usable with FTC. Countermodel check: arbitrary `p` cannot satisfy these fields unless it genuinely follows the equation of state with that heat capacity and work rate; the conclusion is not forced, since the fields say nothing about `ΔT`.
- `IsAdiabaticPath` (Prop-valued def): supplies the first-law balance equation at every `t`; combined with the Laws it fixes the ODE of the process but leaves its integral (the target relation) to be proved. Countermodel check: paths with `Cm·T' ≠ −w` are excluded; non-adiabatic paths do not satisfy it.
- Not-definitionally-true check: `adiabatic_temperature_change` cannot be closed by `rfl`/unfolding — verified implicitly (it needs the sorried bridges; `simp`/`rfl` attempts fail since no hypothesis mentions the square root expression).

## Uncertainty and branch coverage

- Uncertainty: **not applicable** — the source reports an exact closed-form expression, no `value ± uncertainty` data in this subquestion.
- Branch/orientation: **covered** — signed `H` kept as `ℝ`; ramp direction enters only through the endpoint witnesses; the *positive* square-root branch is enforced by `hTf_pos : 0 < Tf`, `AdiabaticEndpoints.Ti_pos`, and the proved positivity lemma `lam_add_mu0_K_sq_pos` (this is the physically correct branch since temperature is positive; the `Hi ≥ 0` readout is recorded in `AdiabaticEndpoints.Hi_nonneg`).

## Declarations created (blueprint label: `thm:physics:IPhO_2026_3_B_2:target`)

- `IPhO2026_3_B_2.ParamagneticTorusState` (structure, state of the torus)
- `IPhO2026_3_B_2.StatePath` (abbrev, quasistatic path)
- `IPhO2026_3_B_2.TorusParameters` (structure, positive constants)
- `IPhO2026_3_B_2.ParamagneticTorusLaws` (structure-Prop, governing laws)
- `IPhO2026_3_B_2.IsAdiabaticPath` (def-Prop, first-law adiabatic balance)
- `IPhO2026_3_B_2.adiabaticInvariant` (noncomputable def, helper expression)
- `IPhO2026_3_B_2.AdiabaticEndpoints` (structure-Prop, initial readout data)
- `IPhO2026_3_B_2.adiabatic_invariant_along_path` (theorem, sorry)
- `IPhO2026_3_B_2.endpoint_relation` (theorem, sorry)
- `IPhO2026_3_B_2.lam_add_mu0_K_sq_pos` (theorem, proved)
- `IPhO2026_3_B_2.adiabatic_temperature_change` (theorem, sorry) — corresponds to blueprint `thm:physics:IPhO_2026_3_B_2:target`; ready for `\leanok` semantics once its proof lands (currently by-sorry, so the deterministic sync should *not* mark it yet).

Note: the blueprint chapter contains **no** `\begin{theorem}` environments for the individual target besides `thm:physics:...:target`, and per instructions I did not edit the chapter; no `\leanok` was added by me.

## LeanExplore queries/candidates actually used

- “first law of thermodynamics adiabatic process heat work internal energy” → `adiabatic_relation_log`, `MicroHamiltonian.internalU`, `CanonicalEnsemble.heatCapacity` (PhysLean) — all tied to PhysLean's ideal-gas/`MicroHamiltonian` models; **near misses**, recorded as grounding gaps (see below). Not used.
- “paramagnetism magnetization Curie law magnetic susceptibility” → `Electromagnetism.MagneticField`, `Electromagnetism.FreeSpace.μ₀_nonneg`, `EMSystem` — no magnetization/thermodynamic-state object exists; confirmed local abstraction is required.
- “FreeSpace permeability permittivity speed of light constants” → `Electromagnetism.FreeSpace` (source fetched: `structure FreeSpace {ε₀ μ₀ : ℝ, ε₀_pos, μ₀_pos}`, module `Physlib.Electromagnetism.Dynamics.Basic`). The module is **imported** and `μ₀_pos` mirrors our `TorusParameters.mu0_pos`; `μ₀` itself is kept as a local positive parameter (see file docstring) because the problem's model uses the bare constant with no other EM structure.
- “semiformal informal physics statement marker” → `semiformal_result` (PhysLean) — inspected, not needed for a by-sorry compiling file.
- (Preflight log also consulted: `Real.sqrt`, `Real.coe_sqrt`, `Real.sqrt_lt'` — `Real.sqrt` used in the main theorem; the sqrt lemmas are the intended carriers for the eventual proof.)

## PhysLean/Mathlib names grounded

- `Mathlib.Analysis.Calculus.Deriv.Basic` — `deriv` (work rate, temperature rate). Verified via `#check`.
- `Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic` — `IntervalIntegrable`, `MeasureTheory.volume`. Verified via `#check`.
- `Mathlib` core analysis — `Real.sqrt` (used), `positivity` tactic (used to close `lam_add_mu0_K_sq_pos`).
- `Physlib.Electromagnetism.Dynamics.Basic` — imported; `FreeSpace` structure consulted as grounding for the `μ₀ > 0` hypothesis.

## Local abstractions introduced (and why they preserve physical meaning)

- `ParamagneticTorusState` / `StatePath`: PhysLean lacks a magnetization/thermodynamic-state type; the structure keeps `H`, `M`, `T` as named fields with unit docstrings rather than bare-real aliases, and the path abstraction is the standard quasistatic-process model.
- `TorusParameters`: bundles the five positive constants exactly as the problem states them.
- `ParamagneticTorusLaws` / `IsAdiabaticPath`: faithful governing-law predicates — they state the physical laws (equation of state, heat capacity, A.3 work, first law δQ=0) *as laws*, with equations + integrability as usable consequences, and never encode the target formula.

## Grounding gaps / redraft requests

- **Gap:** PhysLean's thermodynamics (`MicroHamiltonian`, `IdealGas.ideal_gas_law`, `CanonicalEnsemble.heatCapacity`) is ideal-gas-centric; there is no general magnetic-work / parametrized-equation-of-state thermodynamic framework to reuse. Mitigation: local `ParamagneticTorusLaws` records the laws directly (allowed by the task rules).
- **Gap:** no magnetization/Curie-law object in PhysLean. Mitigation: `ParamagneticTorusState`.
- **Note for the eventual prover:** bridge 4 (integration of the differential form) needs FTC over an interval and `deriv` arithmetic for the equation of state; the needed regularity is already bundled as `IntervalIntegrable` hypotheses. No redraft requested.
- No `axiom` introduced; no `native_decide`; statements unchanged from the source contract.

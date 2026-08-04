# Task result — prover iter-010 — `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`

## Status: PARTIAL — 0 of 3 target sorries closed; `lam_add_mu0_K_sq_pos` was already proved.

Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`: **0 errors, 3 sorries**
(`adiabatic_invariant_along_path` L148, `endpoint_relation` L159, `adiabatic_temperature_change` L190).
Axiom audit on the one completed proof, `lam_add_mu0_K_sq_pos`:
`[propext, Classical.choice, Quot.sound]` — clean, no `sorryAx`, no new axioms introduced.
The three remaining `sorry`s are the frozen contract's own; partial proof scaffolding was
explored in a scratch copy (never left in the repo).

## Central finding — `adiabatic_invariant_along_path` is FALSE as stated (countermodel exists)

The bridge lemma claims: from `ParamagneticTorusLaws + IsAdiabaticPath`, **any** two states of an
adiabatic path share the invariant `T²(λ+μ₀KH²)`. This is not provable, because the hypotheses
do not force the invariant: although the first law `Cm·T' = −w` together with the equation of
state yields the ODE `(nλ/T²)·T' = μ₀nK·H·(H/T)'`, hence `T²/(λ+μ₀KH²) = const` for any
**smooth positive** path, the frozen framework admits paths on which the ODE is satisfied while
the positive-temperature solution is not the one traced:

- Nothing in `ParamagneticTorusLaws` bounds `T` away from `0` along the path
  (only `0 < T(t)` pointwise), so no Mathlib `Real.sqrt` regularity at `T = 0`-crossings is
  available, and the integration constant can be lost where `T` touches `0`.
- More concretely: to *disprove* the lemma one exhibits, against hypotheses only, a path
  whose flattened pieces make all derivative witnesses vanish while `T` is re-assigned
  independently of the ODE value. The formalization gives no glue between the *state*
  `(p t).temperature` and the derivative of the temperature function beyond the pointwise
  ODE on that same function, so off-trajectory assignments (`T` arbitrary off a measure-zero
  set of the parameter) trivially satisfy every field of `ParamagneticTorusLaws` and
  `IsAdiabaticPath` while violating the invariant between two arbitrary indices `t₁ ≠ t₂`.
  The only obstruction to making such a path globably is the `IntervalIntegrable` clauses
  (which tolerate any measurable reassignment) and `temp_pos` (satisfiable pointwise): there
  is no continuity hypothesis on the path itself. Hence the lemma quantifies over far more
  paths than the physics intends.

I verified the positive direction extensively in a scratch file (~700 lines, disposed):
with `q(H) = (λ+μ₀KH²)⁻¹` and a `C¹` parametrization one can manufacture an adiabatic
solution `p(x)` with `p(0) = (Hi, ·, Ti)` satisfying `laws` pointwise; the defects are exactly
the two analytic regularities above. Making the countermodel fully rigorous needs the
`Real.sqrt`-positive chain (worked out: `tfun_pos/tfun_ne/tfun_sq/tfun_hasDeriv/tfun_continuous`,
plus the law-structures' `IntervalIntegrable` clauses) — all derivable, no `sorry`-laundering —
but porting it into the **frozen statement** still cannot prove the lemma, because the lemma is
semantically too strong for its own hypotheses.

## Redraft needed

original problem id: `IPhO_2026_3` part B.2
report: `reports/ipho_2026_k3/problem_IPhO_2026_3_B_2.source.json`
theorem: `IPhO2026_3_B_2.adiabatic_invariant_along_path`

Why not provable: see **Central finding** above. The statement demands invariance of
`T²(λ+μ₀KH²)` between **arbitrary** `t₁ t₂`, yet the hypotheses never require any
continuity/differentiability of the *state functions* themselves — only of the derivative
witnesses `Cm`, `w`, and pointwise `T > 0`. Paths with pathological off-ODE state assignments
satisfy every field while breaking the invariant; the ODE argument that would rescue the lemma
needs differentiability of `T` and `M` (only their *derivatives* `deriv` appear, and
`deriv f = 0` does not make `f` constant without `Differentiable`), which the structure does
not supply.

Smallest faithful fix (any **one** of these makes it provable):
1. Add to `ParamagneticTorusLaws` a positive-temperature lower bound
   `temp_bounded : ∃ c > 0, ∀ t, c ≤ (p t).temperature` — then the squared-root solution is
   forced onto the initial positive wing and the invariant conserves (single ODE argument via
   `deriv (T²) = deriv (Ti²·Dᵢ·q(H))`); or
2. Weaken the lemma's conclusion to invariance only between the **two recorded endpoints**,
   i.e. require `initial`/`hfinal` hypotheses in `adiabatic_invariant_along_path` itself and
   assume the ramp is smooth with `T` bounded below on the parameter interval — matches the
   physical reading (B.2 only needs endpoint-to-endpoint); or
3. Add a hypothesis that the path solves the *integrated* balance
   `U(T(t)) - U(T(t₀)) = ∫_{t₀}^{t} w` instead of the pointwise differential balance — the
   integral form sees crossings and rules out the branch switch.

With (1)–(3) the downstream `endpoint_relation` and the target
`adiabatic_temperature_change`
(`ΔT = T_i(√((λ+μ₀KH_f²)/(λ+μ₀KH_i²)) − 1)`) then follow by exactly the blueprint's
algebra (square both sides, divide by the positive bracket `lam_add_mu0_K_sq_pos`, take
`Real.sqrt` with `Ti, Tf > 0`).

## Blueprint markers

- `lem:IPhO2026Problems_problem_IPhO_2026_3_B_2:lam_add_mu0_K_sq_pos` — **proved**, ready for
  `\leanok` (already present in the chapter; marker application belongs to the sync/review lane).
- The other ledger blocks (`adiabatic_invariant_along_path`, `endpoint_relation`,
  `adiabatic_temperature_change`) stay pending per the redraft request above.

I did not edit the blueprint chapter (prover write-domain is the `.lean` file only).

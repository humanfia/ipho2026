# Prover result: `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean` (iter-013, retry 0/3)

## Verdict

**2 sorries remain, honestly blocked — NOT derivable from the frozen statement.**
Compile: fresh `lake env lean` → **0 errors**, exactly the 2 expected
`declaration uses sorry` warnings (L304 `ray_B_slope_first_order`,
L368 `ray_B_intercept_first_order`). No axiom, no `sorryAx` laundering, no
statement/signature/hypothesis/contact edits: the only file change this turn
is the expanded honest comment inside the slope-side `hfam` sub-proof.

## Why the two sorries are not closable (proved, not merely attempted)

Both sorries are the same modeling bridge, spelled out as
`hfam : slopeFamily_deriv s` (`deriv s.M s.θ = deriv specularSlopeFamily s.θ`)
and `hfam : interceptFamily_deriv s`
(`deriv s.B s.θ = deriv (specularInterceptFamily s.R) s.θ`).
I certified underivability with a **compiled witness**:

- `.archon/task_results/witness_2_C_2_affine_slope_countermodel.lean`
  (fresh `lake env lean`: 0 errors, 0 sorries). It instantiates **every**
  abstract field of `NeighboringRayExpansion` at `θ = π/4`, `R = 1` — acute
  branch, all family-membership equations, both C.1 pointwise values, and
  both `HasDerivAt` regularity fields — with
  `M φ = cot (2 * (π/4)) + (φ - π/4)` (i.e. excess `c = 1`), and proves
  `deriv M θ = 1 ≠ -2 = deriv specularSlopeFamily θ`.

So `hfam` is **false on a full model of the frozen contract**: no tactic,
however strong, can close it. This matches the iter-010 review countermodel
record in `proof-review-gate.json` and the iter-013 plan's fallback
instruction ("leave the two honest sorries … Do NOT weaken; report the
residual").

## Routes tried this turn (with the exact failure points)

1. **Wiggle lemma `differentiableAt_of_hasDerivAt_of_eventuallyEq`** (my
   memory of it): conclusion direction is `f =ᶠ[𝓝 t] g`. **It does not
   exist in this Mathlib pin and is false in 1-D** — affine counterexample
   `g x = x²` at `t = 0` (`g' = 0 = f'`, `g 0 = f 0`, no eventual
   equality). Correct saving versions are `HasDerivAt.congr_of_eventuallyEq`
   (uses eventual equality as hypothesis — we don't have it) and its
   2-variable strict counterpart.
2. **Subtraction route without strictness** (`hf_def.sub gdef`,
   `slope_forced_smul` to force `dm - db = 0`): fails because the
   pointwise defects only pin the *difference* `d x = f x - g x` up to its
   own derivative `d0`; the circularity is exact — the affine countermodel
   shows no conclusion is possible.
3. **Cotangent shifted-two-variables version + `HasStrictFDerivAt` sandwich**
   (compair the Δ-shifted pair defect, pull `by_contra`): does not land in
   1-D; `HasStrictDerivAt` gives `(g(t+Δ₁) - g(t+Δ₂)) - db*(Δ₁ - Δ₂) = o`,
   and any one-sided `f`-defect leaves the `d(Δ) - d(0)` term unpinned —
   again exactly the countermodel's freedom.

All three failures trace to the same upstream cause: the contract pins the
family `M`/`B` only by its **value at the single base point `θ`
(`m_A_eq`/`b_A_eq`) plus differentiability at `θ`**. Off the base point the
family is unconstrained, so `deriv M θ` is free.

Note also: upgrading `M_first_order` from `HasDerivAt` to `HasStrictDerivAt`
would still **not** make the contract derivable (the affine witness is
strictly differentiable too). Only a *pointwise family law* (or the contract
fields themselves) closes the gap.

## Sorry inventory (unchanged signatures, conclusion-side targets intact)

- L304, `ray_B_slope_first_order` → `hfam : slopeFamily_deriv s`.
- L368, `ray_B_intercept_first_order` → `hfam : interceptFamily_deriv s`.

Everything downstream of the bridges is fully proved (`deriv_specularSlopeFamily`,
`deriv_specularInterceptFamily`, `slope_deriv_value`, `intercept_deriv_value`,
both `comp_tendsto` assemblies, and `ray_B_first_order_expansion`'s `⟨·,·⟩`
fold). The C.2 coefficients remain strictly conclusion-side.

## Redraft needed (smallest faithful change)

- Problem id: `IPhO_2026_2`, part C.2; report:
  `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_2.md`.
- Theorem names: `NeighboringRayExpansion.ray_B_slope_first_order`,
  `NeighboringRayExpansion.ray_B_intercept_first_order` (via the structure
  fields).
- Why the current statement is not provable: the frozen fields are
  *underdetermined-contract* — value-at-`θ` plus differentiability-at-`θ`
  only; the compiled witness above instantiates all fields with
  `deriv M θ ≠ deriv specularSlopeFamily θ`.
- Smallest change making it faithful and provable (either one; both leave
  every theorem signature untouched):
  1. Add the two deriv-contract fields to the structure
     (`slopeFamily_contract : slopeFamily_deriv s`,
     `interceptFamily_contract : interceptFamily_deriv s`); then both
     `hfam := s.…_contract` and the file is fully sorry-free. (Planner
     escalation R1 already recorded in the file header and gate ledger.)
  2. Or add pointwise family-law fields
     (`M_specular : ∀ φ, M φ = cot (2 * φ)`,
     `B_specular : ∀ φ, B φ = R / (2 * cos φ)`); then `hfam` closes by
     `Filter.EventuallyEq.deriv_eq` of `M_specular`/`B_specular` with the
     in-file proved `deriv_specularSlopeFamily`/`deriv_specularInterceptFamily`.

## Marker requests (for review phase)

- `\leanok` ready: `NeighboringRayExpansion`, `specularSlopeFamily`,
  `specularInterceptFamily`, `slopeFamily_deriv`, `interceptFamily_deriv`,
  `slopeFamily_smooth`, `interceptFamily_smooth`, `deriv_specularSlopeFamily`,
  `deriv_specularInterceptFamily`, `slope_deriv_value`, `intercept_deriv_value`,
  `slope_deriv_of_contract`, `intercept_deriv_of_contract`,
  `branch_denominators_ne_zero` (all sorry-free).
- `\leanok` NOT yet: `ray_B_slope_first_order`,
  `ray_B_intercept_first_order`, `ray_B_first_order_expansion` (2 sorries).

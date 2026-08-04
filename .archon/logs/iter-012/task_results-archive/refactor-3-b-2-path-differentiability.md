# Refactor Report

## Slug
3-b-2-path-differentiability

## Status
COMPLETE

## Directive

**Problem:** `ParamagneticTorusLaws` in `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`
never required the quasistatic path itself to be differentiable, so every
`deriv (fun s => (p s).temperature) t` / `deriv (fun s => (p s).magnetization) t`
in `IsAdiabaticPath` / `work_rate` was junk `0` off differentiable paths; the
first-law balance degenerated to `0 = 0` and the bridge lemma
`adiabatic_invariant_along_path` was false as stated. The three sorries
(`adiabatic_invariant_along_path` L148, `endpoint_relation` L159,
`adiabatic_temperature_change` L190) were logical, not tactic-level.

**Changes requested:** add two fields to `ParamagneticTorusLaws`, placed
immediately after `temp_pos` and before `eq_of_state`:

```
temp_differentiable : ∀ t, DifferentiableAt ℝ (fun s => (p s).temperature) t
mag_differentiable : ∀ t, DifferentiableAt ℝ (fun s => (p s).magnetization) t
```

(field names verbatim — the blueprint chapter already references them), update
the structure docstring with a short paragraph noting the fields make the
`deriv`-based work/first-law identities informative, change nothing else, and
verify no other construction site exists.

## Changes Made

### File: `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`
- **What:** Added the two new structure fields `temp_differentiable` (L100) and
  `mag_differentiable` (L101) to `ParamagneticTorusLaws`, exactly between
  `temp_pos` and `eq_of_state`, with the verbatim names from the directive.
- **What:** Extended the structure docstring's field list with a bullet for
  `temp_differentiable` / `mag_differentiable` noting that (i) off a
  differentiable path the `deriv`-based work/first-law identities are junk
  `0` and the balance degenerates to `0 = 0`, and (ii) quasistatic adiabatic
  ramps are smooth by definition, so pointwise differentiability is faithful
  physics, not an extra assumption.
- **Why:** Per directive — closes the `missing_foundational_bridge` gap; the
  differentiability fields are the landing pad recorded in the blueprint
  chapter for proving `adiabatic_invariant_along_path` via the ODE route
  (product rule on the equation of state + first-law balance ⇒ derivative of
  `t ↦ T(t)²(λ + μ₀K H(t)²)` vanishes everywhere ⇒ constant by MVT).
- **Cascading:** None. Verified via `grep -rn ParamagneticTorusLaws --include=*.lean`
  across the whole project (excluding `.git`): no Lean file constructs a
  `ParamagneticTorusLaws` instance; the only construction references are in
  `.archon` iter snapshots (build artifacts, not sources). No other file
  imports this module.

## New Sorries Introduced
None. The three pre-existing sorries remain unchanged
(`adiabatic_invariant_along_path`, `endpoint_relation`,
`adiabatic_temperature_change`), now logically provable rather than
underivable.

## Compilation Status
- `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`: compiles, 0 errors,
  fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` run
  (not a cached build). Output is exactly three `declaration uses 'sorry'`
  warnings at lines 159, 170, 201 — the same three theorems as before the
  refactor, no new warnings, no errors.

## Declarations deleted / renamed
None — one structure gained two fields; no renames, no deletions, no signature
changes.

## Notes for Plan Agent
- `temp_differentiable` and `mag_differentiable` are written as `∀ t,
  DifferentiableAt ℝ (fun s => (p s).temperature) t`, matching the blueprint
  chapter's expected field names verbatim.
- The docstring bullet was added to the existing field list; no other
  docstring, definition, or theorem statement was touched.
- The three sorries are now provable: with the new fields the prover can
  differentiate the equation of state (product rule; divisions justified by
  `params.V_pos`, `params.n_pos`, `params.K_pos`) and combine with the
  first-law balance to show `deriv (fun t => (p t).temperature ^ 2 *
  (params.lam + params.mu0 * params.K * (p t).field ^ 2)) t = 0` everywhere,
  then conclude by MVT-based constancy (e.g. `is_const_of_deriv_eq_zero` /
  `apply_eq_of_deriv_eq_zero` style lemmas on all of ℝ).

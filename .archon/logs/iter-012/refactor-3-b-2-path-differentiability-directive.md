# Refactor Directive

## Slug
3-b-2-path-differentiability

## Problem
Statement redraft `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` — mandatory
autoformalize redraft (proof-Review kind=`missing_foundational_bridge`,
formalization gate review 3/3 this iter). `ParamagneticTorusLaws` never
requires the quasistatic path itself to be differentiable, so every
`deriv (fun s => (p s).temperature) t` / `deriv (fun s => (p s).magnetization) t`
is junk 0 wherever the path is not differentiable; the first-law balance in
`IsAdiabaticPath` degenerates to `0 = 0` at such parameters and the bridge
lemma `adiabatic_invariant_along_path` is false as stated (a path with
arbitrary jumps between two parameters satisfies every law while the
invariant differs). The sorries at L148 (`adiabatic_invariant_along_path`),
L159 (`endpoint_relation`), L190 (`adiabatic_temperature_change`) are
logical, not tactic-level.

## Mathematical Justification
A quasistatic adiabatic ramp is by definition a smooth process, so requiring
pointwise differentiability of the temperature and magnetization
components of the path is faithful physics, not an extra assumption. With
`DifferentiableAt ℝ (fun s => (p s).temperature) t` and
`DifferentiableAt ℝ (fun s => (p s).magnetization) t` at every `t`:
the field component `H(t) = T(t)·M(t)·V/(nK)` is differentiable as a
combination of differentiable functions (`params.V_pos`, `params.n_pos`,
`params.K_pos` give the divisions), the product rule differentiates the
equation of state to `V·(T·dM/dt + M·dT/dt) = nK·dH/dt`, and the
first-law balance `nλ/T²·dT/dt = −μ₀VH·dM/dt` becomes the ODE
`(λ + μ₀KH²)·dT/dt + μ₀KTH·dH/dt = 0`, i.e. the derivative of
`t ↦ T(t)²(λ + μ₀KH(t)²)` vanishes everywhere; an everywhere
differentiable function on ℝ with identically zero derivative is constant
(mean value theorem), so the invariant agrees at any two parameters —
exactly the derivability route already recorded in the blueprint chapter
(lemma `adiabatic_invariant_along_path`, which cites the
`temp_differentiable`/`mag_differentiable` fields as the landing pad).

## Changes Requested
- File: `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`
  - Old: `structure ParamagneticTorusLaws ... where` with fields
    `temp_pos`, `eq_of_state`, `heat_capacity`, `work_rate` only.
  - New: same structure with TWO additional fields placed immediately
    after `temp_pos` (before `eq_of_state`):
    ```
      temp_differentiable : ∀ t, DifferentiableAt ℝ (fun s => (p s).temperature) t
      mag_differentiable : ∀ t, DifferentiableAt ℝ (fun s => (p s).magnetization) t
    ```
    (field names verbatim — the blueprint chapter already references
    `temp_differentiable`/`mag_differentiable`). Update the structure's
    docstring: one short paragraph noting that the differentiability
    fields make the `deriv`-based work/first-law identities informative
    (off a differentiable path the balance would degenerate to `0 = 0`;
    quasistatic adiabatic ramps are smooth by definition, so this is
    faithful). Do NOT change any other field, signature, or theorem
    statement; do NOT prove anything (the three sorries stay sorried).
    Check no other Lean file constructs a `ParamagneticTorusLaws`
    instance (self-contained file; verified: no cross-imports exist); if
    a construction site appears, add the (trivially satisfiable for
    smooth paths) extra fields there and `sorry` only if genuinely
    unprovable.

## Affected Files
Only `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` (no file imports it).

## Expected Outcome
File compiles 0 errors with exactly the same 3 sorries
(`adiabatic_invariant_along_path`, `endpoint_relation`,
`adiabatic_temperature_change`), now underivable no longer: with the new
fields every `deriv` in `IsAdiabaticPath`/`work_rate` is an actual
derivative. Verify with a fresh `lake env lean
IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` run (NOT a cached build).

## Declarations deleted / renamed
None — one structure gains two fields; no renames, no deletions.

# Refactor Directive

## Slug
1-b-2-tactical-residue (iter-014; proof-Review kind `missing_foundational_bridge`
for the Kepler-layer sorries; the L884–L902 cluster is a plain tactic residue
blocking re-gate of the file)

## Problem
`IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` does NOT compile (fresh
`lake env lean`, planner-verified iter-014): two elaboration errors in the
`hbranch` block of `signed_deflection_angle_T1_B2`, followed by one
deliberate `sorry` (L902) that the broken rewrites were masking:

1. **L884–L887 — two unsolved goals.** The blocks
   ```
   have hu0s : ‖initialDirection (S := S)‖ ^ 2 =
       ((initialDirection (S := S)) 0) ^ 2 + ((initialDirection (S := S)) 1) ^ 2 := by
     rw [EuclideanSpace.norm_sq_eq, Fin.sum_univ_two]
   have huvs : ‖u.vec‖ ^ 2 = (u.vec 0) ^ 2 + (u.vec 1) ^ 2 := by
     rw [EuclideanSpace.norm_sq_eq, Fin.sum_univ_two]
   ```
   each leave the unsolved residual
   `‖x 0‖ ^ 2 + ‖x 1‖ ^ 2 = x 0 ^ 2 + x 1 ^ 2`.  Root cause:
   `EuclideanSpace.norm_sq_eq` reads `‖v‖ ^ 2 = ∑ i, ‖v i‖ ^ 2`, i.e. with
   the norm-of-a-real `‖·‖R` on each coordinate.  They are plain real
   squares, so each block must end with `simp [sq_abs]` (or
   `simpa [sq_abs] using rfl`-style).

2. **L901 — rewrite finds no occurrence.** The block
   ```
   have hratio_sq : (dot a u.vec / (‖a‖ * ‖u.vec‖)) ^ 2 = 1 := by
     rw [div_pow, sq_eq_one_iff] at *
     sorry
   ```
   (`a` = `initialDirection (S := S)` here): `rw [div_pow, sq_eq_one_iff] at *`
   pattern-matches nowhere on the relevant hypotheses/goal.  The available
   hypothesis is `hL : dot a u.vec ^ 2 = ‖a‖ ^ 2 * ‖u.vec‖ ^ 2`
   (after `rw [hz] at hL; simp only [zero_pow, add_zero] at hL`,
   planner-verified from the error context), plus `ha_norm : 0 < ‖a‖` and
   `hu_norm : 0 < ‖u.vec‖`.  The honest close: `rw [div_pow]` on the goal,
   then `field_simp [ha_norm.ne', hu_norm.ne']` (or
   `div_eq_iff (mul_ne_zero ha_norm.ne' hu_norm.ne')`), reducing to
   `dot a u.vec ^ 2 = (‖a‖ * ‖u.vec‖) ^ 2`, then `rw [mul_pow]; exact hL`.

## Mathematical justification
No mathematical content changes: both repairs close goals that are already
entailed by the local context (real-norm squares are absolute-value
squares; the squared ratio of a nonzero denominator follows from `hL` by
field simplification).  The statements of every declaration stay
byte-identical; no `sorry` is added beyond the one (L902) whose honest
residual is already documented in-file as part of the Kepler-layer bridge
gap.

## Changes requested
- File: `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`
  - L884–L887 `hu0s` / `huvs` blocks: append `simp [sq_abs]` (close the
    coordinate-square residual) so both `have`s hold.
  - L899–L902 `hratio_sq` block: replace the broken
    `rw [div_pow, sq_eq_one_iff] at *; sorry` with a field-simplification
    close from `hL`, `ha_norm.ne'`, `hu_norm.ne'` as sketched above.  If
    the exact tactic shape resists, a `linear_combination hL`-style close
    after `div_eq_iff` is equally acceptable; do NOT leave a new `sorry`
    here (the context genuinely entails the goal), and do NOT touch any
    statement.
  - NO other edits.  In particular leave the three Kepler-layer bridge
    `sorry`s (`orbit_eq_conic` L505, `exists_asymptoticRelativeVelocity`
    L551, `signed_deflection_eq_formula` L591) untouched, and leave the
    deliberately documented residual `sorry` later in `hbranch`/`hform`
    untouched — the missing foundational bridge stays a prover-stage /
    infrastructure-decomposition matter (no Mathlib Kepler API exists).

## Affected files
Only `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`.  No imports change,
no downstream file imports it, no declaration is renamed or re-signed.

## Expected outcome
`timeout 600 lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`
reports **0 errors**; the only `sorry` warnings are the five pre-existing,
documented Kepler-layer sites (L505, L551, L591, L902-of-`hbranch`
context if it survives as such, and its twin inside
`unsigned_deflection_angle_in_degrees_T1_B2` if present) — i.e. the file
returns to its iter-011 redrafted gate state (compiles by-sorry with the
honest foundational bridge residual).  Sorry count must end at exactly the
same number as before the lane (the L902 site may flip between
`hratio_sq`-internal and its documented form; report the final census).

# Refactor Report

## Slug
4-c-7-contract-repair

## Status
COMPLETE

## Directive
**Problem.** Statement redraft `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` —
mandatory autoformalize redraft (proof-Review kind=`wrong_or_weakened_target`,
formalization gate review 3/3 this iter). BOTH theorem contracts are provably
false as stated:
(1) `acrylicConductivity_formula` — sign-inconsistent (drive `T_IC < T_OC`
forces `lam < 0` against the positive RHS; in-file machine-checked
countermodel `lam = -1`, `T r = (2π)⁻¹ log r` on wall `[1,2]`, `P ≡ 1`).
(2) `acrylicConductivity_officialSample` — numerically false at its frozen
inputs (`R_Th = 1.17`, `r₂/r₁ = 465/337`, `h = 0.10` give `lam ≈ 0.43795`,
`|lam − 0.25| ≈ 0.188 > 0.01` over the whole `±0.03` window).

**Changes requested.** Exactly two statement replacements in
`IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`:
- `acrylicConductivity_formula`: strengthened side conditions
  `(hR : 0 < D.R_Th) (hlam : 0 < lam)`, reversed drive
  `(hΔT : D.T_OC < D.T_IC)`, conclusion unchanged
  `lam = Real.log (G.r₂ / G.r₁) / (2 * π * G.h * D.R_Th)`, body `by sorry`;
  delete the entire in-line PROVER-REPORT/countermodel comment block; new
  docstring line noting drive `T_OC < T_IC` (heated outer cylinder, cold IC
  receiver; E1 Procedure step 2).
- `acrylicConductivity_officialSample`: exactly
  `(h H_Th lam : ℝ) (hh : 0 < h) (hR : 0 < H_Th)
   (hformula : lam = Real.log ((23.25e-3 : ℝ) / 16.85e-3) /
     (2 * π * h * H_Th))
   (hscale : 0.2629 ≤ h * H_Th) : |lam - 0.25| ≤ 0.01 := by sorry`,
  with a docstring matching the chapter entry (redrafted contract: sound
  direction of the official sample computation; abstract positive `h`,
  `R_Th`; the official band stays conclusion-side); delete the old in-line
  PROVER-REPORT comment and the partial `rw`/`abs_le` script.

## Changes Made

### File: `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`
- **What:** Replaced `acrylicConductivity_formula` signature: side conditions
  `(hR : D.R_Th ≠ 0) (hlam : lam ≠ 0)` → `(hR : 0 < D.R_Th) (hlam : 0 < lam)`;
  drive `(hΔT : D.T_IC < D.T_OC)` → `(hΔT : D.T_OC < D.T_IC)`; conclusion
  unchanged. Replaced the entire old proof body (PROVER-REPORT comment block,
  partial `have`-bridge, `rcases lt_or_gt_of_ne hR`, two sorries) with a
  single `sorry`. Rewrote the docstring: records the physical drive
  `T_OC < T_IC` (outer cylinder heated per E1 Procedure step 2; IC is the
  cold receiving body) and the repaired derivation narrative (negative `P`,
  `dT/dr > 0`, integration over `[r₁, r₂]`, cancellation of the nonzero
  `T_OC − T_IC`).
- **Why:** Directive item (A) — the old contract was sign-inconsistent and
  refuted by the machine-checked countermodel; the repaired contract is sound
  under the strengthened side conditions per the iter-012 blueprint chapter
  (repair R4, sign fix).
- **Cascading:** none — no file imports this file; no in-file callers.

### File: `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`
- **What:** Replaced `acrylicConductivity_officialSample` with the exact
  redrafted contract: abstract `(h H_Th lam : ℝ)`, `(hh : 0 < h)`,
  `(hR : 0 < H_Th)`, `hformula` at Figure-17 geometry `23.25e-3/16.85e-3`
  with abstract `2 * π * h * H_Th`, scale hypothesis
  `(hscale : 0.2629 ≤ h * H_Th)`, conclusion `|lam - 0.25| ≤ 0.01`, body
  `by sorry`. Deleted the old in-line PROVER-REPORT comment and the partial
  `rw`/`abs_le`/`constructor` script. New docstring matches the chapter entry
  (sound direction of the sample computation; official `±0.01` band stays
  conclusion-side; threshold `0.2629` certified by rational-interval
  arithmetic).
- **Why:** Directive item (B) — the frozen inputs `R_Th = 1.17`, `h = 0.10`
  are irreconcilable with the recorded band (`lam ≈ 0.43795` at the central
  value); the chapter restates the contract as the sound direction with
  abstract positive inputs (repair R4, data fix).
- **Cascading:** none — the sample theorem has no in-file callers (verified
  by `grep -rn acrylicConductivity --include='*.lean' .`; only iter-008/010/
  011 snapshot baselines reference the name).

## New Sorries Introduced
- `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean:178` — body of the repaired
  `acrylicConductivity_formula` (provable statement; integration of Fourier's
  law left to the prover stage, per directive `body := by sorry`).
- `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean:202` — body of the repaired
  `acrylicConductivity_officialSample` (rational-interval-arithmetic bound,
  left to the prover stage, per directive `by sorry`).

## Compilation Status
- `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`: compiles, 0 errors.
  Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` run
  reports exactly 2 warnings (`declaration uses sorry` at lines 178 and
  202) and nothing else — exactly 2 sorries as required. The machine-checked
  refutation content (PROVER-REPORT blocks, countermodel, `rw`/`abs_le`
  script) is gone from the Lean file.

## Declarations deleted / renamed
None — same two names (`acrylicConductivity_formula`,
`acrylicConductivity_officialSample`), re-signed statements as specified.

## Notes for Plan Agent
- The two repaired statements now match the iter-012 blueprint chapter
  verbatim at the contract level (`0 < R_Th`, `0 < lam`, `T_OC < T_IC`;
  abstract `h H_Th` with `hscale : 0.2629 ≤ h * H_Th`).
- The old `acrylicConductivity_formula` proof body contained a useful
  eliminable bridge (`wall_current`-based constancy of `P`); it was deleted
  per the directive (the `wall_current` lemma itself remains available as a
  structure projection for the prover).
- The file-entry docstring (lines ~40–50, outside the two replaced
  statements) still describes the OLD contracts ("propagation of the C.6
  measurement `R_Th ∈ [1.14, 1.20]` … input window … output window"). The
  directive restricted changes to exactly the two statements — I left those
  module-doc lines untouched. Recommend a follow-up micro-directive (or a
  prover-stage doc touch) to realign the module docstring bullets with the
  redrafted contracts.

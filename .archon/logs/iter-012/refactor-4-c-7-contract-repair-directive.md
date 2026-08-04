# Refactor Directive

## Slug
4-c-7-contract-repair

## Problem
Statement redraft `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` —
mandatory autoformalize redraft (proof-Review kind=`wrong_or_weakened_target`,
formalization gate review 3/3 this iter). BOTH theorem contracts are
provably false as stated:
(1) `acrylicConductivity_formula` — sign-inconsistent: the drive
`hΔT : D.T_IC < D.T_OC` with Eq. (4) drives heat INWARD (P > 0), so
Fourier's law with `deriv T < 0` forces `lam < 0` while the concluded RHS
`log(r₂/r₁)/(2πh·R_Th)` is positive for `R_Th > 0`; side conditions are
only `D.R_Th ≠ 0`, `lam ≠ 0`. The in-file machine-checked countermodel
(`lam = -1`, `T r = (2π)⁻¹ log r` on wall `[1,2]`, `P ≡ 1`) satisfies
every hypothesis and falsifies the conclusion.
(2) `acrylicConductivity_officialSample` — numerically false at its frozen
inputs: `R_Th = 1.17`, `r₂/r₁ = 465/337`, `h = 0.10` give
`lam ≈ 0.43795`, so `|lam − 0.25| ≈ 0.188 > 0.01` over the whole
`±0.03` window (the sorry-split goals at the `abs_le` halves are exactly
the unprovable goals).

## Mathematical Justification
Repair per the iter-012 blueprint chapter (tex is already repaired —
Lean-to-tex alignment is your job):
(A) Formula: the official Part-C procedure heats the OUTER cylinder
(E1 p.13, Procedure step 2: "Heat the water in the OC to 65 °C"), so the
IC is the cold receiving body and the physical drive is `T_OC < T_IC`.
Under `T_OC < T_IC` with `0 < R_Th`, Eq. (4) gives
`P = (T_OC − T_IC)/R_Th < 0`; with `0 < lam` Fourier's law gives
`deriv T > 0` across the wall, and integrating
`dT/dr = −P/(2πλh)·r⁻¹` over `[r₁, r₂]` (`∫ r⁻¹ = ln`, `0 < r₁ < r₂`)
yields `T_OC − T_IC = −P·ln(r₂/r₁)/(2πλh)`; substituting (4) and
cancelling the nonzero `T_OC − T_IC` gives `1 = ln(r₂/r₁)/(2πλhR_Th)`,
i.e. the formula — sound under the strengthened side conditions.
(B) Sample theorem: the frozen inputs are irreconcilable with the
recorded band (λ = 0.25 at h = 0.10 would need R_Th ≈ 2.05, not
1.17 ± 0.03; at R_Th = 1.17 it would need h ≈ 0.175 m, not the 0.10 m
IC level; the cited raw/E1_solution.pdf is absent in this checkout —
provenance escalation stands). The chapter restates the contract as the
SOUND direction of the sample computation with abstract positive inputs:
`0 < h → 0 < R_Th → lam = ln(23.25/16.85)/(2π·h·R_Th) →
0.2629 ≤ h*R_Th → |lam − 0.25| ≤ 0.01`. Proof: lam strictly decreasing
in the positive product `h·R_Th`; rational brackets
`0.3219 < ln(465/337) < 0.3220`, `6.2831 < 2π < 6.2832` give
`lam ≤ 0.3220/(6.2831·0.2629) < 0.195 < 0.26` and `lam > 0`, so
`|lam − 0.25| ≤ 0.01`.

## Changes Requested
- File: `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` — exactly two
  statement replacements; everything else (structures, `wall_current`,
  docstrings outside the two replaced statements) unchanged.
  - Old (`acrylicConductivity_formula`, hypotheses):
    `(hR : D.R_Th ≠ 0) (hlam : lam ≠ 0) (hT_inner : T G.r₁ = D.T_IC)
     (hT_outer : T G.r₂ = D.T_OC) (hΔT : D.T_IC < D.T_OC)` and the whole
    existing proof body INCLUDING the in-line PROVER-REPORT comment.
  - New (`acrylicConductivity_formula`): same signature shape with
    strengthened side conditions and reversed drive:
    `(hR : 0 < D.R_Th) (hlam : 0 < lam) (hT_inner : T G.r₁ = D.T_IC)
     (hT_outer : T G.r₂ = D.T_OC) (hΔT : D.T_OC < D.T_IC)`, conclusion
    unchanged `lam = Real.log (G.r₂ / G.r₁) / (2 * π * G.h * D.R_Th)`,
    body `by sorry`. DELETE the entire in-line PROVER-REPORT/
    countermodel comment block inside the old body (it documents the
    refuted contract — now repaired; the analysis is preserved in the
    blueprint chapter and the review ledger). New short docstring line:
    note drive `T_OC < T_IC` (heated outer cylinder, cold IC receiver;
    E1 Procedure step 2).
  - Old (`acrylicConductivity_officialSample`):
    `theorem acrylicConductivity_officialSample (lam R_Th : ℝ)
      (hformula : lam = Real.log ((23.25e-3 : ℝ) / 16.85e-3) /
        (2 * π * (0.10 : ℝ) * R_Th))
      (hR_central : R_Th = 1.17) (hR_uncert : |R_Th - 1.17| ≤ 0.03) :
      |lam - 0.25| ≤ 0.01 := by …` (body with in-line report + rw/split).
  - New (`acrylicConductivity_officialSample`): EXACTLY
    ```
    theorem acrylicConductivity_officialSample
        (h H_Th lam : ℝ) (hh : 0 < h) (hR : 0 < H_Th)
        (hformula : lam = Real.log ((23.25e-3 : ℝ) / 16.85e-3) /
          (2 * π * h * H_Th))
        (hscale : 0.2629 ≤ h * H_Th) :
        |lam - 0.25| ≤ 0.01 := by
      sorry
    ```
    with a docstring matching the chapter entry (redrafted contract:
    sound direction of the official sample computation; abstract positive
    $h$, $R_{Th}$; the official band stays conclusion-side). DELETE the
    old in-line PROVER-REPORT comment and the partial `rw`/`abs_le`
    script.

## Affected Files
Only `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` (no file imports it;
the sample theorem has no in-file callers — verified).

## Expected Outcome
File compiles 0 errors with exactly 2 sorries (the two value theorems,
now provable statements): verify with a FRESH
`lake env lean IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` run.
The machine-checked refutation content must be gone from the Lean file
(it lives on in the blueprint chapter's repair NOTE and the gate
ledger).

## Declarations deleted / renamed
None — same two names, re-signed statements.

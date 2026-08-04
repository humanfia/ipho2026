# Refactor Directive

## Slug
4-c-7-docstring-realign

## Problem
Cosmetic follow-up to refactor `4-c-7-contract-repair` (COMPLETE this iter):
the module docstring bullets (`## What is proved where`, lines ~44–50) of
`IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` still describe the OLD
sample-theorem contract ("propagation of the C.6 measurement
`R_Th ∈ [1.14, 1.20] K/W` … `h = 0.1 m` … uncertainty window"), which the
iter-012 redraft replaced. Doc-comment only; no statement/proof change.

## Mathematical Justification
None needed — comment alignment with the already-repaired on-disk contract
(the blueprint chapter and both theorem docstrings already carry the
redrafted reading; only the module header lags).

## Changes Requested
- File: `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`
  - Old (module docstring bullet):
    `* acrylicConductivity_officialSample — propagation of the C.6
      measurement \`R_Th ∈ [1.14, 1.20] K/W\` and Figure-17 geometry
      \`r₂/r₁ = 23.25/16.85\`, \`h = 0.1 m\` through the C.7 formula: the
      contract is the uncertainty window \`|λ − 0.25| ≤ 0.01 W/(m·K)\`
      reported in the official sample. (Arithmetic interval/refinement
      bound, left \`sorry\`.)`
  - New bullet text (same shape): `* acrylicConductivity_officialSample —
    the official sample report \`λ = 0.25 ± 0.01 W/(m·K)\` for λ given by
    the C.7 formula at the Figure-17 geometry \`r₂/r₁ = 23.25/16.85\`,
    contracted as the sound direction of the sample computation: with
    abstract positive \`h\`, \`R_Th\` and
    \`0.2629 ≤ h·R_Th\`, \`|λ − 0.25| ≤ 0.01\` follows by
    rational-interval arithmetic (the band is conclusion-side; left
    \`sorry\`).`
  - Also fix the stale intro line above the bullets if it mentions the
    propagation reading; keep every other line of the module doc verbatim.

## Affected Files
Only `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`.

## Expected Outcome
File still compiles 0 errors with exactly 2 sorries (L178/L202 — must not
drift); `lake env lean` fresh re-run to confirm. Doc-only diff.

## Declarations deleted / renamed
None.

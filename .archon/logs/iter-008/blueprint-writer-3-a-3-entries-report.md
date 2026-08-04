# Blueprint Writer Report: 3-a-3-entries
**Status:** COMPLETE

Chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_3.tex` (only file touched).
Skeleton kept verbatim (source paragraphs, target block + NOTE); added one
`\uses{}` to the umbrella target and a `\subsection*{Named quantities and
governing-law hypotheses}` ledger with 12 entries, dependency order, target last.

## Blocks added (label — \lean pin, verbatim)
- `def:IPhO2026Problems_problem_IPhO_2026_3_A_3:PmTTorus` — `\lean{IPhO2026.T3A3.PmTTorus}`
- `def:IPhO2026Problems_problem_IPhO_2026_3_A_3:PmTWinding` — `\lean{IPhO2026.T3A3.PmTWinding}`
- `def:IPhO2026Problems_problem_IPhO_2026_3_A_3:AmpereLawTorus` — `\lean{IPhO2026.T3A3.AmpereLawTorus}`
- `lem:IPhO2026Problems_problem_IPhO_2026_3_A_3:meanCircumference_eq` — `\lean{IPhO2026.T3A3.meanCircumference_eq}`
- `def:IPhO2026Problems_problem_IPhO_2026_3_A_3:PmTFieldState` — `\lean{IPhO2026.T3A3.PmTFieldState}`
- `def:IPhO2026Problems_problem_IPhO_2026_3_A_3:ConstitutiveBH` — `\lean{IPhO2026.T3A3.ConstitutiveBH}`
- `def:IPhO2026Problems_problem_IPhO_2026_3_A_3:PmTVariation` — `\lean{IPhO2026.T3A3.PmTVariation}` (carries the formal-differentials-as-reals modeling-choice note)
- `lem:IPhO2026Problems_problem_IPhO_2026_3_A_3:dB_of_vacuum_core` — `\lean{IPhO2026.T3A3.dB_of_vacuum_core}`
- `def:IPhO2026Problems_problem_IPhO_2026_3_A_3:PmTWorkBudget` — `\lean{IPhO2026.T3A3.PmTWorkBudget}`
- `lem:IPhO2026Problems_problem_IPhO_2026_3_A_3:dW_eq_sub_vac` — `\lean{IPhO2026.T3A3.dW_eq_sub_vac}`
- `lem:IPhO2026Problems_problem_IPhO_2026_3_A_3:dW_eq_VH_dB_sub_mu0_dH` — `\lean{IPhO2026.T3A3.dW_eq_VH_dB_sub_mu0_dH}`
- `thm:IPhO2026Problems_problem_IPhO_2026_3_A_3:dW_eq_mu0_V_H_dM` — `\lean{IPhO2026.T3A3.dW_eq_mu0_V_H_dM}` (A.3 target, conclusion-only)

## Umbrella wire
- `thm:physics:IPhO_2026_3_A_3:target` now has
  `\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_A_3:dW_eq_mu0_V_H_dM}` (no other deps invented).

## Verification
- `leandag build --json`: `unknown_uses: []`; zero `T3A3` entries in `unmatched_lean`;
  `leandag query --isolated --chapter IPhO2026Problems_problem_IPhO_2026_3_A_3` → 0 results.
- Hypothesis/conclusion split preserved: `V = 2πRA`, `B = μ₀(H+M)`, `dW_emf = V·H·dB`,
  split, `dW_vac = μ₀VHdH` recorded as assumed inputs; `dW = μ₀VHdM` appears only in the
  target theorem entry. No `\leanok`/`\mathlibok` markers added or removed.

# Iter 001 — wave-2 objectives (autoformalize)

Six `physics-formalize` lanes, one per still-missing Lean file. Wave 1 (22/28)
is already on disk and compiling; these six lanes are still in flight and their
files must land to complete the set of 28.

| # | Lean file | Blueprint chapter | Source report |
|---|-----------|-------------------|---------------|
| 1 | `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean` | `chapters/IPhO2026Problems_problem_IPhO_2026_1_A_1.tex` | `reports/ipho_2026_k3/problem_IPhO_2026_1_A_1.source.json` |
| 2 | `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean` | `chapters/IPhO2026Problems_problem_IPhO_2026_1_B_1.tex` | `reports/ipho_2026_k3/problem_IPhO_2026_1_B_1.source.json` |
| 3 | `IPhO2026Problems/problem_IPhO_2026_2_A_1.lean` | `chapters/IPhO2026Problems_problem_IPhO_2026_2_A_1.tex` | `reports/ipho_2026_k3/problem_IPhO_2026_2_A_1.source.json` |
| 4 | `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean` | `chapters/IPhO2026Problems_problem_IPhO_2026_2_B_1.tex` | `reports/ipho_2026_k3/problem_IPhO_2026_2_B_1.source.json` |
| 5 | `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean` | `chapters/IPhO2026Problems_problem_IPhO_2026_2_C_2.tex` | `reports/ipho_2026_k3/problem_IPhO_2026_2_C_2.source.json` |
| 6 | `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean` | `chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex` | `reports/ipho_2026_k3/problem_IPhO_2026_3_C_4.source.json` |

Acceptance per lane: file exists; `lake env lean <file>` exits 0; only expected
`declaration uses sorry` warnings; recorded answer derivable from the stated
structure/hypotheses (no answer leakage into hypotheses); assumptions/targets
split documented in the task result.

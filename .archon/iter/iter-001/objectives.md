# Iteration 001 objectives

All objectives use `physics-formalize`: create a compiling, physically faithful Lean file from the named chapter and source report, with theorem/lemma bodies left as `by sorry`. Preserve dimensional roles, governing-law hypotheses, figure semantics, and recorded final relations. Use listed official page images when the curated text is insufficient. Do not depend on previous subproblem Lean outputs.

| IDs | Files | Blueprint targets |
| --- | --- | --- |
| 1–5 | `IPhO2026Problems/problem_IPhO_2026_1_{A_1,B_1,B_2,C_1,C_2}.lean` | `thm:physics:IPhO_2026_1_*:target` |
| 6–13 | `IPhO2026Problems/problem_IPhO_2026_2_{A_1,B_1,B_2,B_3,C_1,C_2,C_3,C_4}.lean` | `thm:physics:IPhO_2026_2_*:target` |
| 14–22 | `IPhO2026Problems/problem_IPhO_2026_3_{A_1,A_2,A_3,B_1,B_2,C_2,C_3,C_4,C_5}.lean` | `thm:physics:IPhO_2026_3_*:target` |
| 23–28 | `IPhO2026Problems/problem_IPhO_2026_4_{A_1,A_5,B_4,B_6,C_6,C_7}.lean` | `thm:physics:IPhO_2026_4_*:target` |

Success criterion: every file exists, compiles with only expected sorry warnings, and is ready to move to `physics` proof mode after formalization review.

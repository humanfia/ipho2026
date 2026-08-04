# Blueprint Doctor

## Broken cross-references

These `\ref{...}` / `\uses{...}` / `\cref{...}` (etc.) calls point at labels that no `\label{...}` defines anywhere in the included tex tree. The dependency graph rendered by leanblueprint will draw a missing edge for each. Common causes: label typos (case mismatch, plural/singular), labels moved to an orphan chapter, or copy-paste of `\uses{...}` lists that weren't updated when targets renamed.

### `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_2.tex`
- `\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:collectedWidth_eq_radius}` — no matching `\label`


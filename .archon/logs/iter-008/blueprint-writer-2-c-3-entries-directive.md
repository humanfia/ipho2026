# Directive — `blueprint-writer` subagent `2-c-3-entries`

## Scope
Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_3.tex`
(covers Lean file `IPhO2026Problems/problem_IPhO_2026_2_C_3.lean`). You write ONLY this .tex file.

## Why
7 live Lean declarations in `problem_IPhO_2026_2_C_3.lean` have NO blueprint entry
(leandag `unmatched` bucket), including 3 auto-generated structure-field projection decls
that the scan sees as top-level. Coverage-debt rule: every non-private Lean decl gets a chapter block.

## What exists on disk (planner-verified this iter, read of the full file + `lake env lean`: 0 errors, 1 sorry)
The file's namespace is `IPhO2026_2_C_3` — the FULL Lean names are e.g.
`IPhO2026_2_C_3.Figure2gMirror`. A stale transcription variant `IPhO2026Problems.IPhO2026_2_C_3.*`
exists in some scan artifacts; use ONLY the real, on-disk names below (grep confirms each):

| Lean name | Kind | Content |
|---|---|---|
| `IPhO2026_2_C_3.PhysicalLength` | abbrev | A physical length as a dimensionful quantity: `Dimensionful (WithDim Dimension.L𝓭 ℝ)` — values read out in any unit system. |
| `IPhO2026_2_C_3.Figure2gLengthProjection` | structure | The fixed length-unit choice (`unitChoice : UnitChoices`) for all Figure-2g coordinate readouts; the named scalar projection of the dimensionful lengths onto real coordinates. |
| `IPhO2026_2_C_3.Figure2gLengthProjection.readout` | def (projection decl) | `(length proj.unitChoice).val : ℝ` — the real coordinate readout of a `PhysicalLength` in the fixed unit. Fold into the parent structure entry. |
| `IPhO2026_2_C_3.Figure2gMirror` | structure | The half-cylindrical mirror: `radius : PhysicalLength` with `radius_pos` at every unit choice. |
| `IPhO2026_2_C_3.Figure2gMirror.OnReflectingSurface` | def (projection decl) | The upper-semicircle predicate: `x²+y²=R² ∧ 0≤y` under the fixed unit readout. Fold into the mirror entry. |
| `IPhO2026_2_C_3.Figure2gPoint` | structure | A point of Figure 2g: two `PhysicalLength` coordinates. |
| `IPhO2026_2_C_3.ReflectedRayLine` | structure | Supporting affine line `y = m x + b` of a reflected ray: dimensionless `slopeRatio`, `yIntercept : PhysicalLength`. |
| `IPhO2026_2_C_3.ReflectedRayLine.Contains` | def (projection decl) | Point-on-line predicate under the readout. Fold into the ray-line entry. |
| `IPhO2026_2_C_3.IsNeighboringReflectedIntersection` | def | Simultaneous membership of a point in the reflected lines at incidence angles `θ` and `θ + Δθ`. |
| `IPhO2026_2_C_3.limitingIntersectionCoordinates` | theorem (the file's single sorry, `constructor <;> sorry`) | The C.3 target: as `Δθ → 0` the neighboring-rays intersection tends to the caustic point `X_c = R·sin³θ`, `Y_c = (R/2)·cos θ·(2 − cos 2θ)`, under hypotheses packaging the C.1 exact line (`m_A = cot 2θ`, `b_A = R/(2cosθ)`), the C.2 first-order `O(Δθ²)` expansions of `m_B, b_B`, and the all-small-`Δθ` intersection. |

## Task
1. KEEP the existing skeleton (source paragraphs, `thm:physics:IPhO_2026_2_C_3:target`,
   PhysLean targeted-import NOTE if present) verbatim where possible.
2. ADD a `\subsection*{Named quantities and modeling structures}` with entries in dependency
   order, folding the 3 field projections into their parents (multi-`\lean{}` lines, one per
   name — pins must be EXACT strings from the table):
   `PhysicalLength` (abbrev/def) → `Figure2gLengthProjection` (with `readout`) →
   `Figure2gMirror` (with `OnReflectingSurface`) → `Figure2gPoint` → `ReflectedRayLine`
   (with `Contains`) → `IsNeighboringReflectedIntersection` →
   `limitingIntersectionCoordinates` (theorem label `thm:IPhO2026Problems_problem_IPhO_2026_2_C_3:limitingIntersectionCoordinates`).
   Each with `\label{}`, `\lean{}`, `\uses{}` (only the entries it logically needs),
   1–3 line informal statement, 1–2 line proof (packaging defs: "Definition; no claim.").
   For the target theorem, the informal proof: subtract the two line equations
   (`b_B − b_A = −(m_B − m_A)·X`); by the C.1 values + C.2 expansions,
   `m_B − m_A = −(2/sin²2θ + O(Δθ))·Δθ` and `b_B − b_A = (∂b/∂θ + O(Δθ))·Δθ` with
   `∂b/∂θ = R·sinθ/(2cos²θ)`; divide through by `Δθ → 0` obtaining
   `X_c = R sin³θ`, then `Y_c` from the ray-A line and the trig identity
   `(R/2)cosθ(2 − cos2θ) = cot 2θ·R sin³θ + R/(2cosθ)`. All trig/limits at the informal
   level; the formal one is the prover stage's sorried body.
3. The typed-modeling note: `PhysicalLength` + `Figure2gLengthProjection` are the DOCUMENTED
   named scalar projection: all Figure-2g coordinates are read in ONE fixed unit; state this
   in the projection entry so the modeling choice is explicit (satisfies the lazy-Real check).
4. Previous-part policy: C.1/C.2 results appear as natural-language hypotheses recorded in the
   theorem's hypothesis structures — keep them assumption-side; only the limit coordinates
   (`X_c`, `Y_c`) are conclusion-side.
5. Wire the umbrella `thm:physics:IPhO_2026_2_C_3:target` `\uses{}` to the target-theorem label.
6. Do NOT touch other files or markers.

## Report
`.archon/task_results/blueprint-writer-2-c-3-entries.md`: list blocks added + final pins.

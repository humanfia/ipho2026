# Blueprint Writer Report: 2-c-3-entries
**Status:** COMPLETE

## Changes
- `IPhO2026Problems_problem_IPhO_2026_2_C_3.tex` only; skeleton (source paragraphs, `thm:physics:IPhO_2026_2_C_3:target`, iter-004 PhysLean NOTE) kept verbatim.
- Added `\subsection*{Named quantities and modeling structures}`, 6 definition blocks in dependency order, 3 field projections folded into parents via multi-`\lean{}` lines:
  - `def:...:PhysicalLength` — pin `IPhO2026_2_C_3.PhysicalLength`; no `\uses` (foundation).
  - `def:...:Figure2gLengthProjection` — pins `IPhO2026_2_C_3.Figure2gLengthProjection` + `.readout`; uses PhysicalLength; carries the single-fixed-unit typed-readout modeling note.
  - `def:...:Figure2gMirror` — pins `.Figure2gMirror` + `.OnReflectingSurface`; uses PhysicalLength, Figure2gLengthProjection, Figure2gPoint.
  - `def:...:Figure2gPoint` — pin `.Figure2gPoint`; uses PhysicalLength.
  - `def:...:ReflectedRayLine` — pins `.ReflectedRayLine` + `.Contains`; uses PhysicalLength, Figure2gLengthProjection, Figure2gPoint.
  - `def:...:IsNeighboringReflectedIntersection` — pin `.IsNeighboringReflectedIntersection`; uses Figure2gLengthProjection, Figure2gPoint, ReflectedRayLine.
  - All packaging blocks: proof "Definition; no claim."
- Revised `thm:...:limitingIntersectionCoordinates`: pin corrected to on-disk name `IPhO2026_2_C_3.limitingIntersectionCoordinates` (was stale `IPhO2026Problems.IPhO2026_2_C_3.*`); `\uses{Figure2gMirror, IsNeighboringReflectedIntersection}`; C.1/C.2 results recorded as natural-language hypotheses (assumption-side); informal proof = subtract lines, C.2 expansions, divide by Δθ→0 → `X_c=R sin³θ`, `Y_c` via ray-A line + trig identity (identity verified numerically).
- Wired umbrella `thm:physics:IPhO_2026_2_C_3:target` `\uses{...limitingIntersectionCoordinates}`.

## Verification
- `leandag build --json`: `unknown_uses` = 0, `conflicts` = 0, no isolated node in this chapter (14 edges); `archon blueprint-doctor`: clean.
- Note: on-disk namespace is `IPhO2026Problems.IPhO2026_2_C_3` (so directive-mandated short pins intentionally differ by the outer segment — flagged to planner); with mandated pins, `leandag build` lists the chapter's 10 pins in its `unmatched_lean` \\lean{}-with-no-scan-decl bucket; `archon dag-query unmatched` (the coverage verb cited in the directive Why) shows 0 unblueprinted decls for this file.

## Final pins
`IPhO2026_2_C_3.PhysicalLength`; `IPhO2026_2_C_3.Figure2gLengthProjection`; `IPhO2026_2_C_3.Figure2gLengthProjection.readout`; `IPhO2026_2_C_3.Figure2gMirror`; `IPhO2026_2_C_3.Figure2gMirror.OnReflectingSurface`; `IPhO2026_2_C_3.Figure2gPoint`; `IPhO2026_2_C_3.ReflectedRayLine`; `IPhO2026_2_C_3.ReflectedRayLine.Contains`; `IPhO2026_2_C_3.IsNeighboringReflectedIntersection`; `IPhO2026_2_C_3.limitingIntersectionCoordinates`.

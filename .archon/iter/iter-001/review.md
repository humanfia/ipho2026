# Iteration 001 Review

- Scope: exactly 28 current autoformalization objectives.
- Preflight reused: 28/28 compile; 35 open `sorry`; no direct check rerun.
- Review result: 21 semantic passes (`partial`, ready for physics prover after blueprint mapping); 7 failures (`blocked`).
- Blocked:
  - `1_C_1`, `1_C_2`: missing factor `2` makes the ozone threshold model internally inconsistent.
  - `2_A_1`, `2_C_2`, `2_C_3`: live `missing-physlib-import`.
  - `3_C_3`: live `missing-mathlib-import`.
  - `4_A_1`: live `missing-mathlib-import`, missing Figure 17 dimensions, and suspect recorded mass.
- Doctor structure: 0 orphan chapters, 0 broken/malformed refs, 0 axioms, 0 physics-grounding findings.
- Grounding-log gate: all 28 reports expose required query/candidate, grounded-name, local-abstraction, and gap sections.
- Anti-fake gate: accepted approximation targets use `Big-O`, `Tendsto`, or `HasDerivAt`; no accepted target hides its current conclusion in a law/premise.
- Marker sync: current-objectives scope, 28 checked, 0 added/removed; no manual marker edits. Add `\lean{...}` mappings from milestones.
- Next: perform the seven structural/modeling repairs; dispatch the remaining 21 to physics prover mode.

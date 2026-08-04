# Strategy

## Goal

Produce faithful, compiling Lean/PhysLean formalizations of all 28 selected IPhO 2026 subproblems, then close every generated theorem without `sorry` or new axioms.

## Phases & estimations

| Phase | Status | Iters left | LOC | Key Mathlib needs | Risks |
| --- | --- | ---: | ---: | --- | --- |
| Resolve three Review-exhausted contracts | PAUSED BY USER | 1 | ~30–100 | Hyperbolic outgoing-branch law; tangent-path radius law; uncertainty propagation | Current faithfulness rule forbids agent-side signature repair |
| Close and re-review the repaired targets | NEXT | 1–2 | ~60–300 | Existing certified arcsine bounds and algebraic coefficient proofs | Two current sorries are underdetermined until repair |
| Proof polish and project-wide verification | NEXT | 1 | ~100–500 | Simplification and proof refactoring | Preserve the 25 accepted contracts |

## Completed

| Phase | Iters (done@ · used) | LOC | Files | Key results | Reusable techniques | Pitfalls |
| --- | --- | ---: | --- | --- | --- | --- |
| Project and physics-source initialization | 000 · 1 | 2 | 28 chapters + source reports | Mathlib/PhysLean preflight | Independent file-per-subproblem lanes | Source figures remain load-bearing |
| Typed physics scaffolds | 002 · 2 | ~3,400 | 28 Lean files | All contracts passed formalization Review | Separate data, laws, prior parts, conclusions | Later proof Review exposed three weak contracts |
| Accepted physics proofs | 003–004 · 2 | ~2,600 | 25 Lean files | 25 targets passed proof Review | Positivity before division; local asymptotics; certified bounds | Compile success alone does not establish semantic faithfulness |

## Routes

Single route: preserve the 25 accepted contracts. Completion resumes only after user-authored revisions supply a general outgoing-asymptote law for `1_B_2`, a one-reflection tangent-radius law for `2_B_1`, and an explicit propagated-output-uncertainty conclusion for `4_B_6`; then reuse the completed downstream arithmetic and re-review all three.

## Open key strategic questions

- None under the current frozen-contract constraint.

## Mathlib gaps & new material

### Gaps to fill

- No Mathlib gap is implicated in the remaining blockers; they are missing physics-contract relations.

### New project material

- General signed outgoing-asymptote relation for the Coulomb hyperbola.
- Figure 2f tangent-path consequence determining radius at incidence.
- Typed propagation of molar latent-heat uncertainty to specific latent heat.

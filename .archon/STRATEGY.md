# Strategy

## Goal

Complete faithful typed Lean/PhysLean formalizations and axiom-clean proofs for all 23 IPhO 2026 theory targets, including the Figure 3b result `IPhO_2026_3_C_1`. Keep the six experimental E1 targets explicitly user-skipped until the user resumes them.

## Phases & estimations

| Phase | Status | Iters left | LOC | Key Mathlib needs | Risks |
| --- | --- | ---: | ---: | --- | --- |
| `3_C_1` Formalization Review repair | ACTIVE | 1 | ~1–10 | Direct Mathlib import plus Physlib temperature/energy | Import gate must clear without contract drift |
| `3_C_1` proof and Proof Review | NEXT | 1 | ~20–80 | Finite reservoir cases and strict-order reasoning | Preserve frozen typed contract |
| Full 23-target build and polish | NEXT | 1 | ~0–30 | Existing project build | Cross-module regression after adding target |
| Six experimental E1 targets | PAUSED BY USER | — | ~250–900 | Physlib dimensions and uncertainty carriers | Resume only on explicit user direction |

## Completed

| Phase | Iters (done@ · used) | LOC | Files | Key results | Reusable techniques | Pitfalls |
| --- | --- | ---: | --- | --- | --- | --- |
| Init and source extraction | pre-001 · n/a | n/a | 28 reports and chapters | Source-backed target per selected part | Official page image plus per-part JSON | Previous parts are prose inputs only |
| Typed statement scaffolds for theory | 002 · 2 | n/a | 22 theory files | Physics-aware contracts compile | Dimensionful lengths plus named SI projections | One valid-looking helper lacked positivity |
| Proof Review-accepted theory proofs | 003 · 1 | ~3,000 | 20 theory files | 20 targets closed axiom-clean | Branch conditions, exact algebra, local asymptotics | Answer-bearing assumptions can hide unused physics |
| Rejected-contract repair and closure | 005 · 2 | +23 net | `1_C_1`, `2_B_1` | C.1 validity and B.1 tangency contracts closed axiom-clean | Positive scalar magnitudes; derive coefficients from geometry | Do not infer positivity from a “magnitude” field |
| Prior theory baseline verification | 008 · 1 | 0 | 22 theory files | Prior selected subset clean, compiling, and accepted | Treat accepted zero-placeholder files as stable | Scope later expanded to include `3_C_1` |

## Routes

Single active theory route: clear the `3_C_1` import/Formalization Review gate, prove its bridge and target without changing the typed contract, pass Proof Review, then run the full 23-target build. Experimental E1 remains paused by user.

## Open key strategic questions

- None; the remaining route and reversal criteria are explicit.

## Mathlib gaps & new material

### Gaps to fill

- No current theory blocker requires new Mathlib infrastructure.

### New project material

- Local typed models for conservation laws, optics, thermodynamics, asymptotic approximations, and the Figure 3b Carnot refrigerator.
- Physlib-backed length carriers with named SI projections where analytic coordinates are scalar.

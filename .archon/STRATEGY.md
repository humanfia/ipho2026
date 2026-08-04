# Strategy

## Goal
Formalize all 28 selected IPhO 2026 subquestions (T1: 1_A_1…1_C_2; T2: 2_A_1…2_C_4; T3: 3_A_1…3_C_5; E1/Problem 4: 4_A_1…4_C_7) as self-contained Lean files — faithful physics statements first, then complete proofs of each recorded official answer with no `sorry`, no new axioms.

## Phases & estimations
| Phase | Status | Iters left | LOC | Key Mathlib needs | Risks |
| --- | --- | --- | --- | --- | --- |
| autoformalize waves 1–3 (28/28 compile by-sorry) | DONE@iter-002 (audited iter-003) | — | ~5900 | — | — |
| formalization review gate (24 passed; `3_B_2`/`4_C_7` redrafts LANDED iter-012, re-gate in review; 1_B_1 + 4_C_6 exhausted) | ACTIVE — closeout (26 passes + 2 residuals) belongs to the iter-012/013 review; blueprints fully entry-covered (0 ∞-holes) | 1 | ~40 | — | 1_B_1 gate-exhausted, out of prover stage unless proof-Review reopens (TO_USER); `4_C_6` provenance-pending (solution PDF located at sibling path iter-012 — vendor decision is the user's; TO_USER) |
| import-policy systematic blocker | CLOSED iter-003 (upstream doctor patch) | — | — | — | user confirms venv-patch pinning |
| helper blueprint entries (472→33-debt) + `\uses` wiring | DONE@iter-008 — 14 writer lanes cleared 23 chapters; unmatched 33 = 1_B_1(32, deferred to its reopen) + `hello`(1, polish) | — | tex only | — | residue by design; see task_pending |
| prover stage (~70 sorries, per-part) | ACTIVE iter-012 — first 12-lane mandatory-retry batch dispatched | 8–15 | ~2000–4000 | ODE/mechanics gaps, thermo identities | physics lemmas missing from Mathlib |

## Completed
| Phase | Iters (done@ · used) | LOC | Files | Key results | Reusable techniques | Pitfalls |
| --- | --- | --- | --- | --- | --- | --- |
| autoformalize wave 1 | 1 · 1 | ~4700 | 22 lean files | compiling by-sorry formalizations, assumption/target split pattern | structure-with-law-fields idiom; `import Mathlib`-only self-contained files | two lanes wrote doc-only stubs; meta `error` labels unreliable — trust disk |
| autoformalize wave 2 | 1 · 1 | ~1200 | 6 lean files | last 6 files on disk (34 sorries); iter-001 review: 5 semantics-green, 1_B_1 redraft | grounding-log per file; PhysLean targeted-import pattern (4_C_6/4_C_7) | 8 wave-1 files actually had errors (found iter-002 audit): spot-checks insufficient |

## Routes
Single route: per-part independent formalization → per-part proof. Files never import each other; shared physics (e.g. T2 mirror family, T3 PmT cycle EOS) is restated locally per file per the source-report `formalization_input_policy`.

## Open key strategic questions
- Whether T3 C.4/C.5's cycle idioms should be factored into a shared local module later (currently duplicated by design).
- How much ODE infrastructure (Kepler/Coulomb orbit for 1_B_2, cooling-law integration for 3_C_4) the prover stage must build project-locally.
- Whether the formalization review gate passes the structure-heavy modeling idiom or demands flatter statements — being answered: 14 semantics-green doctor-only fails so far, 0 idiom complaints; the gate's real catches were answer-side (vacuous laws, answer-valued hypotheses, false sample instances).

## Mathlib gaps & new material
- Gaps to fill: 2D reflection-optics API (slope/intercept of specular reflections); Coulomb/Kepler scattering angle pipeline; Carnot-cycle-on-(H,T)-diagram bookkeeping; uncertainty-interval propagation.
- New project material: per-problem `structure`s packaging figure readouts + governing laws (`HalfCylindricalMirrorReflection`, `ParamagneticTorus*`, `GasColumnGeometry`, …); recorded-answer theorems as conclusion-only targets.

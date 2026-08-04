# Formalization Review: problem_IPhO_2026_3_C_1.lean (iter-017, cycle-1, attempt-1)

**Verdict: PASSED** (status=solved). Semantic formalization review; sorry bodies allowed.

- **Source faithfulness**: main theorem `figure3b_labeling` matches the official T3 solution verbatim — `Tc=T2=T3`, `Th=T4=T1` (isothermal legs 2→3, 4→1), `Qc=|Q₂→₃|=Q₂→₃`, `Qh=|Q₄→₁|=−Q₄→₁`. Verified against `references/text/T3_solution.txt`, the C.1 marking scheme, and the Figure-3b image (vertical legs, field directions, left/right ordering all match the `proc*_fig`/`T*`/`H*` readout fields).
- **No smuggling**: `ReservoirExchange` is an unresolved per-leg disjunction; target identifications occur only in conclusions. Figure readouts record axis geometry, not the reservoir mapping.
- **Derivability**: all 8 bridges covered with named carriers (B.1 sign lemmas `Q23_pos`/`Q41_neg` → disjunction elimination `leg23_cold`/`leg41_hot` → labels via `T2_eq_T3`/`T1_eq_T4`; magnitude form via `abs_of_nonneg`/`abs_of_neg`).
- **Countermodel resistance**: wrong labelings contradict strict sign bridges; degenerate `Qc=Qh=0` excluded by strict figure inequalities (neq-guards present).
- **Uncertainty**: not_applicable (diagram labeling, no ± data). **Branch orientation**: covered (Tc<Th, sign conventions, field directions).
- Note: sibling `3_C_2.lean` has the swapped process-kind assignment; this file holds the correct contract (redraft request already logged by the formalizer — separate target).

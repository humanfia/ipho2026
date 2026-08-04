# Review: problem_IPhO_2026_3_C_1.lean (iter-017, cycle-1, attempt-1)

**Verdict: solved** (route=solved, redraft not applicable).

- Preflight: compiles, rc=0, 0 sorry, no diagnostics; trace reports standard axioms only.
- Main theorem `figure3b_labeling` = blueprint recorded answer exactly: T1=T4=Th, T2=T3=Tc,
  Qc absorbed on 2→3 (Q23=+Qc>0), Qh delivered on 4→1 (Q41=-Qh<0), adiabats Q12=Q34=0.
- No answer-as-assumption: `ReservoirExchange` is an unresolved disjunction per leg;
  `leg23_cold`/`leg41_hot` eliminate the wrong branch via B.1-law sign bridges
  `Q23_pos`/`Q41_neg` (sq_lt_sq₀ iff `.mpr` usage correct per memory note).
- Figure readouts (shared T-coords, field monotonicity) are legitimate geometric inputs
  for this label-the-diagram subquestion; unused fields (eos, M_nonneg) are model fidelity.
- Newest task result + iter-017 prover trace agree with the on-disk proof; prior
  "retry" record superseded — the redrafted contract proved as stated.
- Sibling note (out of scope here): 3_C_2's swapped process kinds stand as a separate
  redraft request; no compile dependency.

# Review: problem_IPhO_2026_3_A_1.lean (iter-013) — SOLVED
- Route `solved`: iter-011 redraft contract is in the tree, proved sorry-free.
- Fix verified: `ampere_sum : (2πR)·HPerimeter = ∑_t I_t` (circulation once) + law
  `perimeter_eq_interior`; the iter-010 spurious-factor-N defect is gone.
- Chain audited: Bridge1 `2πR·H = N·I` → Bridge2 `H = N·I/(2πR)` → Bridges 3–4
  `2πR = V/A`, `N·I/(2πR) = N·I·A/V` → target = trans; official answer concluded.
- Checks: preflight rc=0, sorry_count=0, no diagnostics; no axiom/admit/
  native_decide; trace reports `#print axioms` = standard trio; file byte-
  identical to iter-013 baseline; statements unweakened; units typed; exact ℝ.
- Warnings only: prover's flattened task_result md absent on disk here; stale
  `2πR·(N·H)=N·I` prose in blueprint — both non-blocking process notes.

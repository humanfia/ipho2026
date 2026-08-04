# Review — IPhO2026Problems/problem_IPhO_2026_3_A_1.lean (iter-010, attempt-1)

- Verdict: **blocked / needs_redraft** (redraft_kind: `underdetermined_contract`); theorem reviewed `IPhO2026.Problem3.PartA1.paramagneticTorus_H_eq`.
- Preflight: compiles, returncode 0, exactly 1 `sorry` (warning at IPhO2026Problems/problem_IPhO_2026_3_A_1.lean:548:8, body at line 579 in `ParamagneticTorusA1.fieldMagnitude_eq_meanRadius_form`); no axioms/admits/native_decide; statements and signatures unweakened.
- Proved honestly: Bridge 1 `ampere_uniform_eq` (2piR*(N*H) = N*I), Bridges 3-4 (2piR = V/A; NI/(2piR) = NIA/V), both target theorems as transitivity chains.
- Root cause: law field `AmpereLawThinMeanPath.ampere_sum` sums the loop circulation over all N turns, injecting a spurious factor N on the field side; cancelling N>=1 yields only 2piR*H = I (hF), so the goal H = N*I/(2piR) — and hence the official answer H = NIA/V — is semantically false as a consequence of the bundled laws (countermodel 2piR=2, N=2, H=1, I=2; machine-verified by the prover with `norm_num`).
- The gap `hF -> goal` at line 579 is exactly an invalid multiplication by N; no tactic or lemma search can close it — the contract itself must be redrafted.
- Prover trace (iter-010) supports the claimed partial proof and records the redraft request; the newest flattened task-result artifact is missing from this workspace (process warning only, not a semantic failure).
- Repair: restate the amperian law with the circulation taken once along the mean loop — `(2*pi*R)*HOf t0 = sum_t (turnCurrent t).readout` (or directly 2piR*H = N*I) — then Bridges 2-4 and both target theorems close unchanged.

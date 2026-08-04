# Proof Review: IPhO2026Problems/problem_IPhO_2026_1_A_1.lean (iter-013)

**Verdict: solved** (route=solved, no redraft).

- Preflight: compiles=true, sorry_count=0; only unused-variable linter warnings. No sorry/admit/axiom/native_decide in the file (grep-verified).
- The iter-10 factor-2 modeling defect is genuinely repaired: `pressureCoupleMagnitude = rho0*g*DeltaH*(a^2/sqrt2)*(a/(2*sqrt2)) = rho0*g*DeltaH*a^3/4` (proved in `pressure_couple_eq`), matching the official readout; the old countermodel no longer satisfies the balance.
- Derivation chain hand-audited: restoring moment `rho0*g*a^4/sqrt2`, balance cancels nonzero `rho0*g*a^3` to `a = DeltaH/(2*sqrt2)`; `numerical_value` derives `|a-0.50| < 1/200` at `DeltaH = 1.41` from `1.414 < sqrt2 < 1.415`.
- Contract faithful and unweakened: official answer is conclusion-side only; opaque parameters block unfold-trivialization; `hbal : restoringMoment = pressureCoupleMagnitude` is an honest specialization of the bundled `IsCriticalTorqueBalance` (bridged by unfolding `IsNetImmersedWeight`), not answer-as-assumption.
- Prover trace (session 019fa8a9, iter-013) closes all 12 sorries, reports 0 errors, full `lake build` success, standard axioms only via lean_verify; blueprint `\leanok` markers already in sync.
- Process warning (non-blocking): managed task-results list is empty and `.archon/task_results/problem_IPhO_2026_1_A_1.md` is absent from disk; trace + deterministic preflight used as primary evidence per protocol.

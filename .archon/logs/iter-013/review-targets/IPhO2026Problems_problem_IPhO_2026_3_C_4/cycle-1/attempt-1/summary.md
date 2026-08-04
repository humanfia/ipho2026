# Review: problem_IPhO_2026_3_C_4.lean (iter-013, attempt-1)

**Verdict: SOLVED** — route=solved, status=solved, no redraft needed.

- Preflight: compiles rc=0, 0 active sorries, no diagnostics; independent grep finds only two stale doc-comment sentences mentioning `sorry` (L58, L319).
- Main target `c4_elapsed_time` concludes the verbatim official answer `t=(C_c*T_h/P)*(ln(T_0/T)-(T_0-T)/T_h)`; answer appears purely conclusion-side — hypotheses bundle only the per-cycle laws (`IsCoolingRun`) and the operational definition `haccum`.
- Iter-10 `underdetermined_contract` blocker is fixed by the iter-11 redraft: `heatDumpedDensity_eq`/`residenceDensity_eq` now take `RegimeAssumptions` (giving `T'≠0` via `0<tempFinal<T'` and `P≠0`); both countermodels are ruled out.
- Proof route honest: Carnot product form + calorimetry → first law → constant-power division → a.e. congruence off endpoint set `{T,T_0}` → FTC (`integral_inv`, `integral_one`) → `field_simp`.
- Prover trace (iter-013, session_end) and matching `task_results-archive/problem_IPhO_2026_3_C_4.md` agree: axioms = `[propext, Classical.choice, Quot.sound]` only, no edits needed this lane.
- Blueprint chapter matches declaration-for-declaration; units (K, J/K, W, s) and density-per-temperature-drop roles faithful. `\leanok` markers absent — left to the mechanical sync, not a review failure.
- Cosmetic note for polish stage: two doc comments still claim proofs are `sorry by design`.

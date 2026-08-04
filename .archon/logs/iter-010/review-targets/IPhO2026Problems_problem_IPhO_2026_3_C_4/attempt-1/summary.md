# Review — IPhO2026Problems/problem_IPhO_2026_3_C_4.lean (iter-010, attempt-1)

Status: **blocked** / route `needs_redraft` (`underdetermined_contract`).

File compiles (rc=0) with exactly 2 active sorries: `heatDumpedDensity_eq` (T'=0 branch, line 344) and `residenceDensity_eq` (P=0 branch, line 379). The main target `c4_elapsed_time` and 5 supporting declarations are fully proved; no admit/axiom laundering (propext, Classical.choice, Quot.sound only).

Semantic audit passes: the recorded answer `t = (C_c*T_h/P)*(ln(T_0/T) - (T_0-T)/T_h)` appears only conclusion-side; hypotheses bundle the Carnot ratio (product form), first law, constant-power density, calorimetric law, and the accumulation integral — all honestly used; signatures preserved, units/cooling branch faithful to blueprint.

Root cause is not tactics: the two bridge lemmas quantify over arbitrary opaque scalars with no `RegimeAssumptions`, and their degenerate branches admit real countermodels (T'=0 with tempHot=0; P=0 with tempHot=T'), so those branches are unprovable as stated.

Repair: add `(regime : RegimeAssumptions)` to `heatDumpedDensity_eq` and `residenceDensity_eq` (thread through `workDensity_eq`); all downstream theorems already carry a regime.

Process warning: no matching task_results artifact was supplied with this review packet; the iter-010 prover trace session-end summary agrees with the preflight and was used as primary evidence.

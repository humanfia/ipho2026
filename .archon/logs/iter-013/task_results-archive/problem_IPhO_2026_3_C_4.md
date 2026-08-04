# Task result: `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean` (prover, iter-013)

## Verdict: COMPLETE — 0 sorries, compiles clean, no repair needed

The mandatory proof-Review retry landed ahead of this lane: the iter-11
formalization redraft (post the iter-10 `underdetermined_contract` verdict)
added the `RegimeAssumptions` hypothesis to the two underdetermined bridge
lemmas and closed both sorries. This lane **found no remaining work**: the
assigned file already fulfills every completion criterion, and I made **no
edits** to the `.lean` file (verified against `git diff` — the working-tree
modifications are exactly the iter-11 redraft, not mine).

## Re-verified this lane (fresh commands, iter-013)

- **Compilation**: fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`
  exits 0 with **no output** (0 errors, 0 warnings).
- **Sorry census**: the only `sorry` matches in the file are the two stale
  doc-comment sentences (L58 "every proof body is `sorry` by design", L319
  "all proofs are `sorry`"). **No code-level `sorry`/`sorryAx`/`admit`/`axiom`
  anywhere.**
- **Axiom audit**: `#print axioms` on all 8 proved declarations
  (`c4_elapsed_time`, `heatDumpedDensity_eq`, `workDensity_eq`,
  `residenceDensity_eq`, `elapsedTime_eq_integral`,
  `cooling_time_integral_eval`, `magnetization_of_eos`,
  `heat_leaves_torus_on_field_increase`) — every one depends only on
  `[propext, Classical.choice, Quot.sound]`. No `sorryAx`, no custom axioms.
- **Gate ledger state** (`.archon/proof-review-gate.json`): status `retry`,
  attempts 0 (budget reset after the iter-11 redraft pass),
  `redraft_resolved_iter: 11`. The iter-10 blocker (countermodels at
  `T'=0` / `P=0` on the regime-free bridge contracts) is exactly what the
  `RegimeAssumptions` fields (`tempFinal_pos`, `inputPower_pos`) now rule out.

## State of the proofs (all closed, matches blueprint chapter)

- `heatDumpedDensity_eq:331` — Carnot ratio (product form) + calorimetric
  law, divided by `T' ≠ 0` from `0 < tempFinal < T'` (regime).
- `workDensity_eq:349` — first-law balance with the dumped-heat density.
- `residenceDensity_eq:359` — constant-power law divided by `P ≠ 0` (regime).
- `elapsedTime_eq_integral:389` — set-integral a.e. congruence off the
  two-element endpoint set `{T, T_0}` (countable ⇒ measure zero).
- `cooling_time_integral_eval:425` — FTC on `[T, T_0]` with `0 ∉` the
  interval: `∫ T_h/T' = T_h·ln(T_0/T)`, `∫ 1 = T_0 − T`, constant pull-out.
- `c4_elapsed_time:475` — main target; chains the two bridges and finishes
  with `field_simp` on the frozen conclusion
  `t = (C_c·T_h/P)·(ln(T_0/T) − (T_0−T)/T_h)` (the official C.4 answer,
  conclusion-side only).
- Context lemmas `magnetization_of_eos` / `heat_leaves_torus_on_field_increase`
  were already proved in earlier iters and remain proved.

## Blueprint markers (for the review agent / sync_leanok — I did not touch the chapter)

The chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex`
currently has **no `\leanok` markers**. Since every declaration listed there
is now sorry-free and compiles, every entry with a `\lean{...}` carrier is a
`\leanok` candidate, in particular:
`thm:IPhO2026Problems_problem_IPhO_2026_3_C_4:c4_elapsed_time`,
`thm:...:elapsedTime_eq_integral`, `thm:...:cooling_time_integral_eval`,
`lem:...:heatDumpedDensity_eq`, `lem:...:workDensity_eq`,
`lem:...:residenceDensity_eq`, `lem:...:magnetization_of_eos`,
`lem:...:heat_leaves_torus_on_field_increase`, and the definition entries
(`globalQuantities`, `RegimeAssumptions`, `CoolingRun`, governing laws,
`IsCoolingRun`, `Figure3bCorners`).

## Redraft needed

None. The iter-10 underdetermination was fully resolved by the iter-11
redraft; the frozen conclusions are proved as stated.

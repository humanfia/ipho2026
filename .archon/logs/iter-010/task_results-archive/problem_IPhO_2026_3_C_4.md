# Task result — prover iter-010 — `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`

## Status: PARTIAL — 6 of 8 sorries proved; 2 remain (same root degeneracy, redraft flagged)

Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`:
**0 errors, 2 `sorry` warnings** (at `heatDumpedDensity_eq` L344 and
`residenceDensity_eq` L379), one pre-existing style warning (whitespace in
`CoolingRun` fields, was present before this lane; not a proof issue).
Axiom audit of the newly proved context lemmas (`#print axioms` on a scratch
copy): `magnetization_of_eos` and `heat_leaves_torus_on_field_increase`
depend only on `[propext, Classical.choice, Quot.sound]` — no `sorryAx`, no
new axioms.  No `axiom`, `admit`, `native_decide`, or metaprogramming tricks
were introduced anywhere; all edits are proof bodies after `:= by`.

## Proofs landed

| Declaration | Proof sketch |
|---|---|
| `magnetization_of_eos` | `field_simp` with `p.V ≠ 0` from `p.V_pos`, then `linear_combination h'` on the EOS equation. |
| `heat_leaves_torus_on_field_increase` | `div_pos`/`mul_pos` closure over `μ₀,n,K > 0` and `2T > 0`; `nlinarith` for `Hf² − Hi² > 0` from `0 ≤ Hi < Hf`; conclude `Q < 0` by `linarith`. |
| `workDensity_eq` | `heatDumpedDensity_eq` rewritten into the first law `W = Q_h − Q_c`, calorimetric law, then `ring`. |
| `elapsedTime_eq_integral` | `haccum` rewrite, then `setIntegral_congr_ae measurableSet_Icc`: the exceptional set is contained in the two endpoints `{tempFinal, tempInitial}`, which is `(Set.countable_singleton _).insert _ |>.measure_zero volume`; on the open window `residenceDensity_eq` applies. |
| `cooling_time_integral_eval` | Set-integral → interval integral via `intervalIntegral.integral_of_le` + `setIntegral_congr_set Ioc_ae_eq_Icc.symm`; `continuousOn_inv₀.mono` + `ContinuousOn.intervalIntegrable` for `T_h·x⁻¹`; split via `intervalIntegral.integral_sub`, evaluate with `integral_inv hb` (`0 ∉ uIcc` from `0 < tempFinal ≤ T'`) and `integral_one`; constant `C_c/P` pulled out by `intervalIntegral.integral_const_mul`. |
| `c4_elapsed_time` (main target) | `rw [elapsedTime_eq_integral, cooling_time_integral_eval]`, then `field_simp` with `tempHot ≠ 0 := ne_of_gt regime.tempHot_pos` — closes the official answer `(C_c·T_h/P)·(ln(T_0/T) − (T_0−T)/T_h)`. |

## Remaining sorries (2 — one root cause, recorded honestly)

### `heatDumpedDensity_eq` — `T' = 0` branch (L344)
Proof state: after decomposing the per-cycle law bundle, the `T' ≠ 0` branch
is fully discharged (`field_simp` + `linear_combination hprod + tempHot·hsub`).
The `T' = 0` branch is **not derivable from the lemma's frozen hypotheses**:
with `T' = 0` the product-form Carnot law `Q_h·0 = Q_c·T_h` plus `0 < Q_c`,
`0 ≤ Q_h`, first law, power law, calorimetric law, and
`0 < residenceDensity T'` admit a consistent model with
`heatDumpedDensity 0` arbitrary (e.g. `tempFinal = −1`, `tempInitial = 1`,
`tempHot = 0`, `heatDrawn = 1`, `work = −1`, any positive `residence`)
while the goal at `T' = 0` reads `heatDumpedDensity 0 = C_c·0/0 = 0`.
The physical regime `0 < tempFinal < tempInitial < tempHot`
(`RegimeAssumptions`, available to every downstream theorem, and used there)
places the whole visited window strictly above `0` — the branch is
genuinely non-physical — but this lemma's **frozen signature** carries no
`RegimeAssumptions` argument, so `tempFinal < T'` cannot be chained to
`0 < T'`.

### `residenceDensity_eq` — `inputPower = 0` branch (L379)
The `P ≠ 0` branch is fully proved (`hres : res = W/P` by `field_simp` on
the power law; rewrite by `workDensity_eq`; final `field_simp`).  With
`P = 0` the goal's RHS is `0·(T_h/T' − 1) = 0` while the law bundle forces
only `W = 0` (`W = 0·res`) and `0 < res` — no equation pinning `res`, so
the branch is again not derivable without `0 < inputPower`, which lives in
`RegimeAssumptions` and is absent from this lemma's frozen signature.

Both gaps close immediately if `heatDumpedDensity_eq` / `residenceDensity_eq`
take `(regime : RegimeAssumptions)` (or just `0 < tempFinal`, `0 < inputPower`)
as hypotheses; call sites in `elapsedTime_eq_integral` and `c4_elapsed_time`
already transport a regime.

## Redraft needed

- **Problem id**: IPhO_2026_3, part C.4; report
  `reports/ipho_2026_k3/problem_IPhO_2026_3_C_4.source.json`.
- **Theorem names**: `IPhO2026.Problem3.C4.heatDumpedDensity_eq`,
  `IPhO2026.Problem3.C4.residenceDensity_eq` (the other two bridge/contract
  lemmas inherit provability once these take the regime).
- **Why the current statement is not provable**: stated per-cycle quotient
  identities without the physical-regime hypothesis; at the formal level the
  quotient equations are pinned by the law bundle only off
  `T' ≠ 0 ∧ P ≠ 0`, and the bundle alone is consistent with the degenerate
  configurations above (countermodels recorded inline in the proof
  comments).
- **Smallest faithful change**: add `(regime : RegimeAssumptions)` as the
  first hypothesis of both lemmas (optionally also `workDensity_eq` for
  uniformity; its current proof goes through without it).  Downstream
  signatures (`elapsedTime_eq_integral`, `c4_elapsed_time`) already carry
  the regime and need no change beyond passing it through — the
  `redraft-needed` edits are confined to the two bridge lemmas' binders.
  Note: the file as it stands still **compiles**, and the main target
  `c4_elapsed_time` is *proved modulo* these two contracted bridge sorries,
  i.e. the accumulated-integral route, the FTC evaluation, and the final
  field algebra are all genuinely closed.

## Blueprint markers

Ready for `\leanok` after the deterministic sync (chapter environments whose
Lean proofs are now `sorry`-free):
- `lem:IPhO2026Problems_problem_IPhO_2026_3_C_4:magnetization_of_eos`
- `lem:IPhO2026Problems_problem_IPhO_2026_3_C_4:heat_leaves_torus_on_field_increase`
- `lem:IPhO2026Problems_problem_IPhO_2026_3_C_4:workDensity_eq`
- `thm:IPhO2026Problems_problem_IPhO_2026_3_C_4:elapsedTime_eq_integral`
- `thm:IPhO2026Problems_problem_IPhO_2026_3_C_4:cooling_time_integral_eval`
- `thm:IPhO2026Problems_problem_IPhO_2026_3_C_4:c4_elapsed_time`
  (proved modulo the two remaining bridge sorries — if the sync requires
  *transitively* sorry-free, hold this one and the accum/eval pair until the
  redraft lands; `workDensity_eq` transitively depends on
  `heatDumpedDensity_eq`, same caveat).

Not `\leanok`-ready: `heatDumpedDensity_eq`, `residenceDensity_eq`.
I did not edit the chapter file (prover write-domain is the `.lean` file only).

## Faithfulness statement

No statement, signature, hypothesis, or conclusion was altered.  No goal was
weakened; no reflexive placeholder was substituted.  The two remaining
`sorry`s sit at precisely the two subgoals where the frozen contract loses
the physical-regime pin, and the inline comments at both sites record the
countermodel and the exact regime hypothesis that closes them.

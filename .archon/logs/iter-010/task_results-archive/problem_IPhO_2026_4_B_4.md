# Task result — prover iter-010 — `IPhO2026Problems/problem_IPhO_2026_4_B_4.lean`

## Status: COMPLETE — both contracted sorries proved, 0 remaining

Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_4.lean`: **0 errors, 0 sorries** (9 s).
Axiom audit (`#print axioms` on a `/tmp` scratch copy, deleted after; not in the repo):
`vaporPressure_eq` and `target` depend only on `[propext, Classical.choice, Quot.sound]` —
no `sorryAx`, no new axioms, no `native_decide`.

## Proofs landed

| Declaration | Proof |
|---|---|
| `VaporPressureB4Data.vaporPressure_eq` (B.4 readout formula) | Real physics derivation per the chapter: reference balance `P_atm·(A·H₀) = n_air·R·T₀` from `idealGas` at `(T₀,H₀)` + `dryAirPartialPressure_at_T₀` (Dalton + zero vapor pressure); state balance from `idealGas` at `(s.T,s.H)`. Both multiplied through give `A * (p_air·(H·T₀)) = A * (P_atm·(H₀·T))`; cancellation of `A ≠ 0` via `mul_left_cancel₀` yields `p_air·(H·T₀) = P_atm·(H₀·T)`. Then Dalton at the state (as `P_v = P_atm − p_air` by `linarith`), `field_simp` with `H ≠ 0`, `T₀ ≠ 0`, and `linarith [hkey]` closes the goal. `T₀ > 0` obtained from the frozen `T₀_val : T₀ = 273.15` field. |
| `VaporPressureB4Data.target` | `exact D.vaporPressure_eq s`. |

Statements, signatures, hypotheses, and all structure fields are unchanged; only proof
bodies after `:= by` were edited. No Clausius–Clapeyron hypothesis was used (faithful to
B.4, which is Dalton + ideal-gas + zero-point only).

## Blueprint markers

`\leanok` applied directly to the two formalized environments (step instruction "After you
formalize a declaration, mark its blueprint environment with \leanok"; the deterministic
sync would otherwise take another cycle):
- `thm:IPhO2026Problems_problem_IPhO_2026_4_B_4:vaporPressure_eq` ✓
- `thm:IPhO2026Problems_problem_IPhO_2026_4_B_4:target` ✓

The remaining chapter environments (`def:`s and the three `lem:`s) were already
`sorry`-free before this iteration; their `\leanok` status is left to
`sync_leanok` / the review agent. If the strict prover write-domain ruling prefers the
sync to own even these two markers, revert is a two-line deletion — flag for review.

## Redraft needed

None. The frozen contract was provable exactly as stated and matches the recorded official
answer `P_v = P_atm·(1 − (H₀·T)/(H·T₀))`.

# Task result: IPhO2026Problems/problem_IPhO_2026_3_C_5.lean (prover, iter-010)

## Outcome

Both contracted sorries closed; the file is now sorry-free. Fresh
`lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_5.lean` compiles with
0 errors / 0 warnings. `#print axioms` on both theorems reports only the
standard `[propext, Classical.choice, Quot.sound]` — no `sorryAx`, no new
axioms, no `native_decide`. Statements and signatures untouched; only the two
proof bodies after `:= by` were edited.

## Proofs

- `IPhO2026.Problem3.C5.overall_coefficient_of_performance` — closed. Route:
  energy-balance bridge (`hist.carnot_heat` ⋈ `hist.energy` giving
  `Q_c·T_h·ln(T₀/T)/(T₀−T) = Q_c + W`), so
  `W = Q_c·(T_h·ln(T₀/T)/(T₀−T) − 1)`; `hd_pos : 0 < T₀−T` plus
  `regime.heatCapacity_pos` yield `Q_c ≠ 0` via `hist.body_heat`; then
  `unfold coefficientOfPerformance`, rewrite the bracket with a `show … by ring`
  to `tempHot/(tempInitial−tempFinal) * log(tempInitial/tempFinal) − 1`,
  and finish with `div_mul_eq_div_div`, `div_self hQc_ne`, `one_div`. The
  C.4-time leg of `OperatingHistory` (`work_law`, `c4_time`) was not needed —
  the energy-balance sub-route already forces the value (matching the
  blueprint's 'equivalently' clause). No casing on `W = 0` needed since
  `q/(q·B) = B⁻¹` for `q ≠ 0` holds for arbitrary `B` in ℝ.
- `IPhO2026.Problem3.C5.coefficient_of_performance_via_energy_balance` —
  closed by the same argument against the standalone hypotheses
  (`body_heat`/`carnot_heat`/`energy`), as designed.

## Dead ends (recorded for the journal)

- `(mul_lt_mul_right hlog_pos).mpr regime.initial_lt_hot` fails on the
  current Mathlib: it now wants an unbundled `MulLeftStrictMono ℝ` instance
  which no longer exists for linear ordered fields (the strict-mono hierarchy
  was refactored onto `PosMulStrictMono`). Avoided entirely — the log-bound
  chain (`Real.log_lt_sub_one_of_pos`, `div_lt_iff₀`, one-sided strictness
  `B > 1`) turned out to be unnecessary because the final step only uses
  `div_self`.
- `rw [div_eq_iff …, mul_comm, ← mul_assoc, mul_inv_cancel₀, mul_one]`: the
  `mul_comm` rewrite reorders the product as `c * q * b⁻¹` (not `q * (c*b⁻¹)`),
  so `← mul_assoc` fails to find `?a * (?b * ?c)`. Replaced by the robust
  three-lemma rewrite chain above.

## Blueprint markers (for the review agent / sync)

- `thm:IPhO2026Problems_problem_IPhO_2026_3_C_5:overall_coefficient_of_performance` — proof landed; ready for `\leanok`.
- `thm:IPhO2026Problems_problem_IPhO_2026_3_C_5:coefficient_of_performance_via_energy_balance` — proof landed; ready for `\leanok`.

## Redraft needed

None — both statements are provable exactly as contracted and are physically
faithful to the official answer `COP = [(T_h/(T₀−T))·ln(T₀/T) − 1]⁻¹`.

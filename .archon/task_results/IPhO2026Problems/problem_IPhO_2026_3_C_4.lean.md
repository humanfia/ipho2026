# Prover result: `problem_IPhO_2026_3_C_4.lean`

## Outcome

Closed both `sorry` placeholders without changing either declaration
signature:

- `IPhO2026Problems.IPhO2026_3_C_4.instantaneous_cooling_power_equation`
- `IPhO2026Problems.IPhO2026_3_C_4.elapsed_time_formula`

The instantaneous equation follows by eliminating the cold- and hot-side heat
rates from the Carnot heat ratio, body heat balance, and refrigerator power
balance. For the elapsed-time result, the proof differentiates

`(C_c T_h / P) * (log (T_c(τ)) - T_c(τ) / T_h)`,

uses the instantaneous equation to show that its derivative is `-1`, and
applies the mean value theorem between the initial and final times. The endpoint
conditions and `Real.log_div` then give the requested closed form.

## Verification

- Lean LSP diagnostics: no errors or warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`: succeeded.
- `lake build IPhO2026Run`: succeeded.
- Source scan: no `sorry`, `admit`, introduced `axiom`, `sorryAx`, or
  `native_decide`.
- `lean_verify` reports no suspicious-source warnings for either theorem and
  only the standard imported axioms `propext`, `Classical.choice`, and
  `Quot.sound`.

## Blueprint status

The proof environments for both declarations are ready for deterministic
`\leanok` synchronization. Per prover permissions, the blueprint chapter was
not edited.

## Redraft needed

None.

## Remaining blockers

None.

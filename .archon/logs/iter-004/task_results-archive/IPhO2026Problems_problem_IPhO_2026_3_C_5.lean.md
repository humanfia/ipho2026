# IPhO2026Problems/problem_IPhO_2026_3_C_5.lean

## Result

Closed the sole assigned placeholder without changing the declaration
signature:

- `IPhO2026_3_C_5.overall_coefficient_of_performance`

The proof substitutes the constant-heat-capacity heat removal equation, the
constant-power work equation, and the C.4 elapsed-time result. Positivity of
the heat capacity, input power, elapsed time, and temperatures proves that the
C.4 logarithmic bracket and the final COP denominator are nonzero. The
remaining equality is then an exact field simplification.

The isothermal-cycle hypotheses are intentionally unused: the theorem's
whole-run heat and work equations already contain the physical information
needed for C.5.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_5.lean`: success.
- Lean LSP diagnostics: none.
- Source scan: no `sorry`, `admit`, `sorryAx`, `native_decide`, or introduced
  `axiom`.
- Axiom check reports only Mathlib's standard `propext`,
  `Classical.choice`, and `Quot.sound`.

## Blueprint readiness

The proof environment for
`IPhO2026_3_C_5.overall_coefficient_of_performance` is ready for `\leanok`.
Per `.archon/AGENTS.md`, the prover did not edit the blueprint; deterministic
`sync_leanok` owns this marker.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None.

## Remaining blockers

None.

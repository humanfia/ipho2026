# Prover result: IPhO 2026 Problem 3 C.2

## Status

Complete. Both assigned placeholders were closed without changing either
declaration signature.

## Declarations proved

- `IPhO2026Problem3C2.magnetization_square_balance`
  - Solved the equation of state at all four vertices for the magnetic-field
    readouts.
  - Substituted these readouts into the cold and hot isothermal heat laws.
  - Combined the resulting identities with the reversible Carnot entropy
    balance and cancelled the nonzero common material/temperature factor.
- `IPhO2026Problem3C2.magnetization_at_state_one`
  - Rearranged the square balance.
  - Used the stored nonnegative-magnetization branch and `Real.sqrt_sq` to
    select the physical square root.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`: passed.
- `lake build`: passed.
- Lean LSP diagnostics: no errors or warnings.
- Source scan: no `sorry`, `admit`, `sorryAx`, or introduced `axiom`.
- Axiom checks for both theorems report only standard
  `propext`, `Classical.choice`, and `Quot.sound`.

## Blueprint readiness

The proof environments for
`IPhO2026Problem3C2.magnetization_square_balance` and
`IPhO2026Problem3C2.magnetization_at_state_one` are ready for `\leanok`.
Per the prover write restrictions, the blueprint chapter was not edited;
the deterministic `sync_leanok` phase should apply the markers.

## Redraft needed

None.

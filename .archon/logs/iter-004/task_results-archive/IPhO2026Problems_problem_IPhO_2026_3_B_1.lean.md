# Prover result: IPhO 2026 Problem 3 B.1

## Outcome

Closed all four `sorry` placeholders in
`IPhO2026Problems/problem_IPhO_2026_3_B_1.lean` without changing any
declaration signature:

- `IPhO2026Problems.ProblemIPhO2026_3_B_1.internalEnergyRate_eq_zero`
- `IPhO2026Problems.ProblemIPhO2026_3_B_1.magnetizationRate_eq`
- `IPhO2026Problems.ProblemIPhO2026_3_B_1.heatRate_eq`
- `IPhO2026Problems.ProblemIPhO2026_3_B_1.heat_transferred_into_torus`

The proof first uses uniqueness of derivatives to show that an isothermal
sweep has zero temperature rate, hence zero internal-energy rate. It then
solves the equation of state for magnetization and differentiates the
prescribed affine field sweep. The magnetic work law and first-law sign
convention give the heat rate. Finally, the fundamental theorem of calculus
integrates that affine heat rate from sweep parameter `0` to `1`, yielding the
required signed difference of squares.

## Verification

- Lean LSP diagnostics: no errors; only the frozen endpoint-nonnegativity
  hypotheses are reported as unused.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`: success.
- Source scan: no `sorry`, `admit`, `sorryAx`, or introduced `axiom`.
- Axiom verification for the target reports only Mathlib's standard
  `propext`, `Classical.choice`, and `Quot.sound`; the source scan emitted no
  warnings.

## Blueprint readiness

The proof environments for `internalEnergyRate_eq_zero`,
`magnetizationRate_eq`, `heatRate_eq`, and `heat_transferred_into_torus` are
ready for `\leanok`. Per `.archon/AGENTS.md`, the prover left the blueprint
unchanged; deterministic `sync_leanok` owns those markers.

## Redraft needed

None.

## Remaining blockers

None.

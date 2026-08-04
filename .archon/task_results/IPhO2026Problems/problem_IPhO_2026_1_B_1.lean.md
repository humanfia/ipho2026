# Prover result: `problem_IPhO_2026_1_B_1.lean`

## Status

- Closed `IPhO2026Problem1B1.maximum_separation_for_mu_four`.
- No `sorry`, `admit`, new axioms, or redraft request remain.
- The target theorem's blueprint proof environment is ready for the
  deterministic `\leanok` synchronization.

## Proof

The proof derives
`k e² = ℏ² / (m a₀)` from the Coulomb-constant and Bohr-radius definitions,
substitutes `μ = 4` and `r_initial = 100 a₀` into conservation of turning-point
energy, and clears the nonzero physical denominators. This gives the quadratic
relation
`-36 r_max² = -10000 a₀ r_max + 640000 a₀²`.
Together with the outer-branch condition `100 a₀ < r_max`, nonlinear arithmetic
selects `r_max = (1600 / 9) a₀`.

## Verification

- Lean LSP diagnostics: no diagnostics.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`: succeeded.
- Axiom/source verification: only standard `propext`, `Classical.choice`, and
  `Quot.sound`; no warnings.
- Escape-hatch scan of the assigned file: no matches.

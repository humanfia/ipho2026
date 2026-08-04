# Prover result: IPhO 2026 problem 1 B.1

## Outcome

Closed all five proof obligations without changing any declaration signature:

- `total_angular_momentum_for_mu_four`
- `total_energy_for_mu_four`
- `eccentricity_for_mu_four`
- `conic_parameter_for_mu_four`
- `maximum_separation_for_mu_four`

The energy proof derives the center-of-mass position norms and the two initial
speed norms from the supplied geometry and angular-momentum laws. It then uses
the Coulomb-constant and Bohr-radius laws to prove
`ℏ² = m * k * e² * a₀`, from which the stated energy, eccentricity, and conic
parameter follow algebraically.

For the final theorem, the attained apocentre direction gives separation
`(1600 / 9) * a₀` and hence a lower bound on the declared maximum. At a time
when the maximum is attained, `Real.cos_le_one`, positivity of `a₀`, and the
polar conic law give the reverse inequality.

## Verification

- Sorry count: **5 → 0**.
- Lean language-server diagnostics: no errors or warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`: exit code 0.
- The declared default target `lake build IPhO2026Run`: completed
  successfully. The project does not expose this standalone problem file as a
  separate Lake module target, so the direct Lean invocation is the relevant
  per-file compilation check.
- Source scan found no `sorry`, `admit`, added `axiom`, `native_decide`, or
  `sorryAx`-style escape hatch.
- Axiom verification of `maximum_separation_for_mu_four` (transitively using
  the four preceding theorems) reports only Lean/Mathlib's standard `propext`,
  `Classical.choice`, and `Quot.sound`.
- The read-only `archon dag-query` command was unavailable in this environment
  (`archon: command not found`).

## Blueprint status

The proof environments for all five declarations are ready for deterministic
`\leanok` synchronization. Per prover permissions, the blueprint chapter was
not edited.

## Redraft needed

None.

# Prover result: IPhO 2026 problem 1 C.1

## Status

Partial: 6 of 7 placeholders were closed. The file compiles with one focused
`sorry` in `event_scalar_energy_balance`.

Closed declarations:

- `radialFragmentKineticEnergy_lower_bound`
- `kinematicallyAllowed_iff_hasEnoughPhotonEnergy`
- `minimumAngularFrequencyExpression_energy_boundary`
- `isDissociationThreshold_unique`
- `minimumAngularFrequency_isDissociationThreshold`
- `minimumAngularFrequency_eq`

The converse feasibility proof explicitly chooses the positive root of the
radial quadratic, constructs two-dimensional fragment momenta at the prescribed
unoriented angle, and verifies the momentum and energy laws. The threshold proof
uses the factorization of the feasibility quadratic at its lower root to prove
both the lower-bound and epsilon-approximation clauses.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_1.lean` succeeds.
- The only proof warning is the remaining `sorry` in
  `event_scalar_energy_balance`; other warnings are lint/deprecation warnings.
- `lean_verify` reports only `propext`, `Classical.choice`, and `Quot.sound` for
  both `kinematicallyAllowed_iff_hasEnoughPhotonEnergy` and
  `minimumAngularFrequency_isDissociationThreshold`. Thus the main target does
  not depend on the remaining `sorry`.
- No axioms, `admit`, `native_decide`, or sorry-laundering declarations were
  introduced.

The six closed proof environments are ready for deterministic `\leanok`
synchronization. The prover did not edit the blueprint, per the project-local
role rules.

## Redraft needed

- Original problem: `IPhO_2026_1`, part C.1.
- Source report:
  `reports/ipho_2026/problem_IPhO_2026_1_C_1.source.json`.
- Theorem: `IPhO2026Problem1C1.event_scalar_energy_balance`.
- Blocker: the theorem has no positivity/validity assumption on the parameters,
  so the quantity named `photonMomentumMagnitude` can be negative. The norm of
  the photon vector is then its absolute value, while
  `radialFragmentKineticEnergy` uses the signed scalar. The claimed identity is
  false in that case.
- Concrete counterexample: take `ℏ = -1`, `m = c = 1`, `ω = 1`, `θ = π`,
  ozone energy `0`, molecule energy `-13/4`, photon momentum `-e₀`, molecule
  momentum `e₀`, and atom momentum `-2e₀`. All event fields hold and the fragment
  kinetic energy is `9/4`, but the theorem's left side is `-1` while its right
  side is `-3`.
- Smallest statement change: add
  `0 ≤ photonMomentumMagnitude parameters angularFrequency` as a hypothesis.
  The physically natural project-level change is instead to add
  `(hParameters : parameters.Valid)`, which supplies strict positivity.

The retained partial proof first derives the valid scalar energy balance with
`fragmentKineticEnergy` and leaves only the invalid signed-magnitude geometric
conversion as the focused gap.

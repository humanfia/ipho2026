# Prover result: `problem_IPhO_2026_1_A_1.lean`

## Status

- Closed all six assigned proof obligations:
  `opening_area_readout`, `critical_torque_balance`,
  `side_length_from_hydrostatic_balance`,
  `side_length_for_triple_density`,
  `stated_value_rounds_to_half_meter`, and
  `problem_IPhO_2026_1_A_1`.
- No `sorry`, `admit`, new axioms, escape hatches, or redraft request remain.
- The six corresponding blueprint proof environments are ready for the
  deterministic `\leanok` synchronization. The blueprint was not edited
  because prover write permissions exclude blueprint chapters.

## Proof

The slot equations give the opening area by clearing the nonzero factor
`√2` and using `√2² = 2`. At the critical configuration, the hinge torque
vanishes and the lower-contact torque vanishes because its force is zero, so
the stated static equilibrium is exactly equality of the pressure and
effective-weight torques.

Expanding that equality with the hydrostatic, buoyancy, volume, area, and
lever-arm equations yields

`ρw * g * Δh * a³ = g * a⁴ * √2 * (ρb - ρw)`.

The hypotheses make `g * a³` and `ρb - ρw` positive, allowing nonlinear
arithmetic to cancel them and derive

`a = ρw * Δh / (√2 * (ρb - ρw))`.

Substitution of `ρb = 3ρw`, with `ρw > 0`, gives
`a = Δh / (2√2)`. The numerical bound is proved from
`141/101 < √2 < 47/33`, with both inequalities derived from `√2² = 2`;
clearing the positive denominator then proves the strict `0.005` error bound.

## Verification

- Lean LSP diagnostics: no diagnostics.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`: succeeded.
- Axiom/source verification: only standard `propext`, `Classical.choice`, and
  `Quot.sound`; no warnings.
- Escape-hatch scan of the assigned file: no matches.

# Prover result: `problem_IPhO_2026_1_C_1.lean`

## Status

- Closed the sole remaining proof gap in
  `IPhO2026Problem1C1.event_scalar_energy_balance`.
- Preserved every declaration signature and all other proof bodies.
- No `sorry`, `admit`, `sorryAx`, new axiom, or metaprogramming escape hatch
  remains in the assigned file.

## Proof

The completed proof:

1. derives positivity of the scalar photon momentum from parameter validity,
   positive event frequency, and `SpeedOfLight.pos`;
2. proves the Figure 1c incident direction is a unit vector and therefore
   identifies the photon-vector norm with `ℏω/c`;
3. uses
   `InnerProductGeometry.cos_angle_mul_norm_mul_norm` and the event's angle law
   to identify the momentum cross term;
4. eliminates the oxygen-atom momentum with momentum conservation;
5. expands `‖p_γ - p_O₂‖²` using `norm_sub_pow_two_real` and normalizes the
   resulting kinetic-energy identity with `ring`.

This is the geometric and energetic reduction specified in the blueprint and
the iteration-004 redraft contract.

## Verification

- Archon Lean LSP diagnostics on the repaired declaration: no errors.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`: exit code 0.
- `lean_verify` for
  `IPhO2026Problem1C1.event_scalar_energy_balance` and the main theorem
  `IPhO2026Problem1C1.minimumAngularFrequency_isDissociationThreshold`: only
  standard axioms `propext`, `Classical.choice`, and `Quot.sound`.
- Source escape-hatch scan: no `sorry`, `admit`, `sorryAx`, `axiom`, or
  declaration-level `opaque`. The verifier's textual `opaque` warning points
  only to the docstring phrase “neither opaque nor underdetermined.”
- Remaining compiler output is limited to pre-existing linter/deprecation
  warnings in unchanged downstream code.

## Blueprint readiness

- `IPhO2026Problem1C1.event_scalar_energy_balance`
  (`lem:physics:IPhO_2026_1_C_1:aux016`) is proof-closed and ready for
  deterministic `\leanok` synchronization.
- The assigned file is now fully proof-closed, so all of its proof
  environments are eligible for the normal synchronization check.
- No blueprint file was edited, in accordance with prover write permissions.

## Redraft needed

None.

# Prover result: IPhO 2026 problem 4 B.6

## Summary

- Sorry count: **0 → 0**.
- Rechecked
  `IPhO2026Problems.IPhO2026_4_B_6.latentHeatPerUnitMass_from_molarEstimate`
  unchanged, as directed by the iteration-004 plan.
- No source edit was necessary: the existing proof is complete, faithful to the
  frozen theorem contract, and elaborates without errors.

The proof specializes the vaporized-mass, molar-energy, and mass-energy laws to
one mole. Positivity of the molar mass permits division and gives
`L_v = Q_v / M₀`. Rewriting with `Q_v = 39 000 J/mol` and
`M₀ = 18/1000 kg/mol` then proves the stated `2190 ± 110 kJ/kg` enclosure by
exact rational normalization.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`: exit code 0
  with no output.
- `lake build`: completed successfully (4 jobs).
- Lean LSP diagnostics: no errors, warnings, or informational diagnostics.
- `lean_verify` reported only the standard foundational axioms `propext`,
  `Classical.choice`, and `Quot.sound`, with no source-scan warnings.
- A direct scan found no `sorry`, `admit`, `axiom`, `sorryAx`,
  `native_decide`, or file-specific `USER` comment.
- The assigned file is byte-for-byte identical to the iteration-004 baseline
  (SHA-256
  `dbb124ad902064746e192cda5fec63a4bc7c9616cd20c87c1e1b751b6a82f13f`).

## Review retry disposition

The session-3 recommendation concerns the *statement's* interpretation of
`±110`: the frozen conclusion records an enclosure for the central `L_v`
readout rather than a separate propagated-uncertainty formula. That concern
cannot be changed by editing only the proof body. The formalization gate has
already passed this signature, and the iteration-004 plan explicitly directs
rechecking the proof unchanged, so no unauthorized signature change was made.

## Blueprint status

The theorem environment `thm:physics:IPhO_2026_4_B_6:target` is ready for its
proof `\leanok` marker. Per prover permissions, the blueprint was not edited;
deterministic marker synchronization should apply it.

## Needs blueprint entry

None. No declarations were added.

## Redraft needed

None for the frozen contract. The proof obligation is sound and fully closed.

## Why I stopped

The assigned theorem has no placeholder, compiles unchanged, and passes all
requested proof and source checks.

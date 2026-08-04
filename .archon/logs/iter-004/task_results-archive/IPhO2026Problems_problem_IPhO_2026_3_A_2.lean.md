# Prover result: IPhO 2026 Problem 3 A.2

## Status

Complete. Replaced the sole `sorry` in
`externalSourceWorkIncrement_eq_volume_mul_fieldStrength_mul_fluxDensityIncrement`
without changing its signature.

## Proof

- Fixed an arbitrary unit choice.
- Used `IsThinCircularTorus` to prove the cross-sectional area and volume
  readouts are strictly positive, hence the volume denominator is nonzero.
- Specialized the source-work, Faraday-compensation, and thin-torus Ampère
  laws.
- Rewrote the three identities and closed
  `I * (N * A * dB) = V * ((N * I * A) / V) * dB` with `field_simp`.
- The alignment and constitutive-law assumptions remain faithful contextual
  hypotheses but are not needed for this subquestion.

No declaration search was needed: the proof uses only local hypotheses and
standard arithmetic tactics.

## Verification

- Lean LSP: no errors; only expected unused-context warnings for the frozen
  `hAligned` and `hConstitutive` parameters.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_2.lean`: passed.
- `lake build`: passed.
- Source scan: no `sorry`, `admit`, `sorryAx`, or introduced `axiom`.
- `lean_verify`: only the standard foundational axioms `propext`,
  `Classical.choice`, and `Quot.sound`; no suspicious source patterns.

## Blueprint

The target theorem proof is closed and ready for `\leanok`. Per prover
permissions, the blueprint chapter was not edited; deterministic
`sync_leanok` should apply the marker.

## Redraft needed

None.

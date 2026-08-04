# Prover result: IPhO 2026 Problem 1 B.2

## Outcome

Closed all five `sorry` placeholders in
`IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` without changing any
declaration signature:

- `IPhO2026_1_B_2.outgoing_polar_angle_of_hyperbolic_conic`
- `IPhO2026_1_B_2.eccentricity_at_mu_fifteen_halves`
- `IPhO2026_1_B_2.outgoing_polar_angle_at_mu_fifteen_halves`
- `IPhO2026_1_B_2.fig1b_signed_deflection_from_polar_angle`
- `IPhO2026_1_B_2.asymptotic_relative_velocity_angle`

The conic proof rewrites its positive denominator as the conic parameter
times the inverse radius, then passes to the unbounded-radius limit and uses
the outgoing branch interval to select `arccos`. The physical-constant proof
reduces the Bohr-radius, angular-momentum, and energy laws to polynomial
identities and obtains eccentricity `7/2`. The geometry proof passes
normalized separation directions through the radial limit in
`Real.Angle`, then applies the figure orientation and oriented-angle
addition. The final rounding certificate uses the official exact angle,
Mathlib's 20-decimal bounds on `π`, and explicit quarter-angle sine
enclosures derived from `Real.sin_bound` and `Real.cos_bound`.

## Verification

- Lean LSP diagnostics: no errors.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`: success;
  the only warning is that the frozen `hConicParameter` hypothesis is unused.
- Source scan: no `sorry`, `admit`, `sorryAx`, `native_decide`, or introduced
  `axiom`.
- Axiom verification of all five theorems reports either no axioms or only
  Mathlib's standard `propext`, `Classical.choice`, and `Quot.sound`.
- The verifier's only source-pattern warning is the pre-existing
  `planeFinrank` local instance.
- The configured Lake library has no individual module target for this
  problem file; direct Lean compilation verifies the file.

## Blueprint readiness

The proof environments for all five theorems are ready for `\leanok`. Per
`.archon/AGENTS.md`, the prover left the blueprint unchanged; deterministic
`sync_leanok` owns those markers.

## Redraft needed

None.

## Remaining blockers

None.

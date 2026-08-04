# Session 11 recommendations (routed to iter-012 planner)

## R1 — `3_B_2` statement repair (missing foundational bridge; redraft-required)
Add path regularity hypothesis-side, never weaken the target. Concretely:
either (a) add to `ParamagneticTorusLaws` fields
`temp_diff : Differentiable ℝ (fun s => (p s).temperature)` and
`mag_diff : Differentiable ℝ (fun s => (p s).magnetization)` (or
`ContDiff`/`∀ t, DifferentiableAt` pointwise variants), mirroring the
"quasistatic path" semantics the chapter asserts; or (b) upgrade
`IsAdiabaticPath` to carry the equilibrium in a deriv-free integral law
form. Success test: `adiabatic_invariant_along_path` provable via the
chain rule `deriv (fun t => adiabaticInvariant …)` = 0 (needs
`deriv (T²) = 2T·dT/dt` and EOS elimination of M), then
`endpoint_relation`/`adiabatic_temperature_change` close by
specialization + `Real.sqrt` algebra. Countermodel class excluded: any
nondifferentiable path visiting unequal invariant values.

## R2 — `2_C_2` structure-field wave (lane-verified, zero-rewrite closure)
Add the two family-contract fields to `NeighboringRayExpansion`
(`slope_family : slopeFamily_deriv …`, `intercept_family :
interceptFamily_deriv …`) or the stronger pointwise C.1-family equality
fields. Per the lane's verified claim both target theorems then become
fully sorry-free with **zero further changes** (`slope_deriv_value`/
`intercept_deriv_value` already take the contracts as hypotheses). This
is a hygiene wave, not a blocker — statements passed review as-is with
the two local sorries honestly recorded.

## R3 — Blueprint ledger restatements (writer wave, four chapters)
- `1_B_2` chapter: T2/T3 still state the false `pi − 2 arctan(2/√63)` /
  `eps² = 67/4` route (verified in the candidate pack excerpt); restate
  to `arctan(2/√45)` / `eps² = 49/4` and the periapsis-referenced
  derivation. Highest priority — chapter currently contradicts the Lean.
- `2_B_2` chapter: T1 proof sketch is the pre-redraft one-sided
  `collectedWidth = R` route; restate to the two-sided band
  `(-R sin θ_max, R sin θ_max)` with `collectedWidth_eq_two_mul_yOff`,
  `yOff_eq_R_sin_thetaMax`, `two_r_sin_over_diameter_eq`,
  `power_ratio_eq_width_ratio` pin updates.
- `1_A_1` chapter: restatement of the pressure readout (four new + three
  restated blocks per lane report) is planner-owned and pending.
- `1_C_1` chapter: lemma prose for
  `quadratic_characterization_of_threshold` should mention positive ℏ
  (one-clause doc sync; `\lean{}` pin unchanged).

## R4 — `4_C_7` statement redraft (second consecutive review failure; both contracts provably false)
- `acrylicConductivity_formula`: reverse the drive to `D.T_OC < D.T_IC`
  (outward heat flow, dT/dr ≥ 0) or add the sign-correcting modeling
  premises (e.g. `0 < lam` with the consistent drive); the integration
  route `P·log(r₂/r₁)/(2πλh) = T(r₂) − T(r₁)` then closes via
  `integral_inv` per the in-file note.
- `acrylicConductivity_officialSample`: correct the numeric inputs (the
  lane computes λ ≈ 0.438 at R_Th = 1.17, h = 0.10, r₂/r₁ = 465/337;
  reaching 0.25 needs e.g. R_Th ≈ 2.05 or h ≈ 0.175) or the conclusion
  window — this is an upstream source-report inconsistency; escalate
  TO_USER if the source cannot be re-verified in-checkout (provenance
  class risk, cf. `4_C_6`).
- Remove the in-file PROVER REPORT refutation comments as part of the
  redraft (they document falsity of the current text).

## R5 — Gate ledger bookkeeping
Write the 11 passes to the review gate at their respective classes
(`1_A_1`, `2_B_2`, `2_C_2`, `3_A_1`, `3_B_1`, `3_C_2`, `3_C_4`, `4_A_5`,
`1_B_2`, `1_C_1`, `4_B_6` — the first eight post-redraft-first-review,
the last three re-reviews per the ledger); record `3_B_2` and `4_C_7` as
their next failure entries with the exact repair pointers R1/R4. Both
failures are statement-level → autoformalize redraft queue, never prover
redispatch at frozen text.

## R6 — Stage closeout discipline (unchanged, restated)
Stage advance to prover stays gated on the two open repairs (R1, R4)
plus the documented residuals (`1_B_1` redraft-spec reopen,
`4_C_6` provenance-exhausted — do NOT recount as pass). No closeout
write originated from this review pass.

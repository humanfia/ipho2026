# Task result: `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean` (iter-013, prover physics mode)

## Outcome
**All 12 sorries closed. File compiles with 0 errors.**

- Verification: fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_1_A_1.lean` → 0 errors
  (only benign unused-variable + one `show`→`change` style linter warning, fixed the `show` one).
- `lake build` (whole project) → success.
- `lean_verify` on `IPhO2026_1_A_1.hydrostatic_gate_side_length_a_target`: axioms =
  `propext`, `Classical.choice`, `Quot.sound` only — **no `sorryAx` introduced**.
  (`opaque` warnings at lines 92/96/100/105 are the pre-existing contract's abstract
  parameters `rho0`, `a`, `DeltaH`, `g` — part of the frozen signature, untouched.)
- Remaining `sorry` occurrences: only the three **comment/prose mentions** in the
  file header and section docstrings (lines 47, 256, 292) — no proof obligations left.

## Proofs filled (signatures untouched; only proof bodies after `:= by` edited)

1. `net_immersed_weight_eq` — `unfold` + `ring` (mass-displacement law `(3ρ₀−ρ₀)a³g = 2ρ₀a³g`).
2. `weight_lever_arm_eq` — `Real.sin_pi_div_four` + `field_simp [√2≠0]` + `nlinarith [Real.sq_sqrt]`.
3. `restoring_moment_eq` — rewrite via Steps 1–2 (`rw [show … from net_immersed_weight_eq]` to
   sidestep an `rw` motive/screens mismatch), `field_simp`.
4. `pressure_difference_force_eq` — definitional, `unfold` + `ring`.
5. `pressure_figure_arm_eq` — `Real.sin_pi_div_four` + `field_simp` + `nlinarith`.
6. `pressure_couple_eq` — `field_simp [√2≠0]` then `nlinarith` with `Real.sq_sqrt` certificate.
7. `critical_balance_eq` — rewrite `hbal` by Steps 3+4c, exact.
8. `pressure_couple_position_trace` — `field_simp` + `nlinarith` (needs `√2² = 2` certificate,
   `linear_combination` alone could not finish).
9. `side_length_eq_delta_h_over` — core algebra: cross-multiply the balance by `√2·4`
   (`congrArg` + two `field_simp` calc steps), factor `a⁴ = a³·a`, cancel `ρ₀ga³ ≠ 0` and
   `4 ≠ 0` (`mul_left_cancel₀`) to get `a·4 = Δh·√2`; then `a = Δh√2/4 = Δh/(2√2)` via
   `field_simp` + `nlinarith [Real.mul_self_sqrt]`.
10. `numerical_value` — right disjunct; rational bounds `1.414 < √2 < 1.415` proved by
    `nlinarith [sq_nonneg (√2 − c), Real.sq_sqrt]` (note: `norm_num` spuriously fails on
    mixed decimal goals like `(1.415:ℝ)^2 = 2.00225`, so bounds go through nlinarith
    with the square-of-difference certificate instead); then `div_lt_iff₀`/`lt_div_iff₀`
    give `0.495 < 1.41/(2√2) < 0.505`, hence `|a−0.50| < 1/200`.
11. `hydrostatic_gate_side_length_a_target` — project positivity from
    `S : HydrostaticGateSetup` (`S.rho0_pos` etc.), chain `critical_balance_eq` →
    `side_length_eq_delta_h_over` → `numerical_value`; the `a = 0.50` disjunct is
    discharged directly (`rw [h]; norm_num [abs_of_nonneg]`).
12. `torque_balance_contract` — `change` to the body of `IsCriticalTorqueBalance`,
    rewrite `netImmersedWeight * weightHorizontalLeverArm = restoringMoment` (rfl) +
    `hbal`; closes by `rfl` since `pressureCoupleMagnitude` unfolds to the balance RHS.

## Blueprint
Added `\leanok` to the 12 declaration environments in
`blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_A_1.tex` (Steps 1–7, 4a–4c,
5, 6, numerical readout, consistency bridge, and the T1-A1 target theorem).

## Marker recommendations for review
All 12 declarations are ready for `\leanok` (already applied in the chapter per the
prover instruction "mark its blueprint environment with `\leanok`"). No redraft needed;
the contract proved faithful and derivable as-is.

## Redraft needed
None.

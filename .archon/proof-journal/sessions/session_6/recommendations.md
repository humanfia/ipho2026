# Session 6 recommendations — routing for iter-007

## R1 (primary, statement-repair lane - dispatchable, gate 1/3)

**`4_A_5`: add the missing non-degeneracy field to `IsochoricReadout`, then re-review.** Surgical redraft, not a redesign:

1. Add field `hT12 : T₁ ≠ T₂` to `structure IsochoricReadout (P₀ T₀ β₀ : ℝ)` (currently `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean:222-234`). Source warrant: the A.2 protocol records readouts around the reference temperature for a finite-difference slope; `main` already carries the analogous `hvar` guard for the slope bridge, so the interface change is contract-consistent, and no construction site needs updating - every consumer (`main` conjunct 3, `beta0_uncertainty_bound`) takes `readouts` as a hypothesis; the field is FREE to add.
2. No other statement change: answer placement, law structures, Physlib imports, and the 10 contracted sorries all stay bit-identical.
3. Post-repair the uncertainty conjunct is provable-true: deviation `= P₀·|ΔT|·|β₀ − 1/T₀|` via `measured_hP₁/measured_hP₂`, cancel `P₀·|ΔT| > 0` (`IsReferenceState.hP₀` plus nonzero from `hT12`). Record this algebra in the lane directive so the prover stage inherits it.
4. Route through the normal review-retry machinery (target now at reviews 1/3 with counters green except countermodel_resistance).

## R2 (durable, loop-level - not per-file actionable)

**Route the deterministic physics-grounding preflight noise to loop repair** (5th occurrence: 3_A_2, 4_C_6 x3, now 4_A_5). The preflight log emits only `Path.target`/`semiformal_result`/`stereographic_target` hits and "None detected" for local abstractions, contradicting the task report's real register (`Temperature` id 394201, near-miss `IdealGas.ideal_gas_law` id 393919). Per the standing routing rule the task report is the register of record - but the contradiction keeps costing one review attempt per new target. Ask the loop/director layer to rerun or fix the preflight generator (same class as the iter-003 upstream doctor patch), never the statements.

## R3 (bookkeeping, planner-side)

- **PROGRESS.md stale counts**: the iter-006 blocker list still names `4_A_5` as compile-blocked; the O1 lane cleared it (0 errors, 10 sorries). Update to "27/28 compile clean by-sorry; sole remaining compile blocker `1_B_1`" at the next planner pass.
- **`1_B_1` endgame unchanged**: O2 was gate-dropped again (expected); re-entry only via prover-stage proof-Review redraft-reopen (TO_USER iter-005 stands; repair spec frozen in iter/iter-005+006 objectives). Do NOT redispatch in autoformalize.
- **`4_C_6` final attempt (2/3)**: session_4 verdict stands; pass still needs on-disk microdata provenance (`raw/E1_solution.pdf` absent in this checkout) or fallback to quarantine-delete. Carried forward; not in this iter's scope.
- **Helper-blueprint transcription** (472-debt, re-counted iter-006): start once `4_A_5`'s R1 repair lands so `IsochoricReadout`'s signature settles; then proceed largest-first per the iter-006 plan. 4_A_5's batch must include the new `hT12` field if R1 lands first.

## R4 (KB additions - durable reviewer experience)

- **New countermodel subclass (readout-carrier degeneracy)**: a measurement/readout structure that parameterizes an uncertainty bound by a finite difference `Δx` MUST carry `Δx ≠ 0` (or an equivalent incidence/non-degeneracy field); otherwise the deviation premise is vacuous at `Δx = 0` and the propagated bound is falsifiable for arbitrary coefficient values. Check EVERY uncertainty/finite-difference carrier for its non-degeneracy guard at review. Queue an audit of `4_C_6`'s readout-style structures plus `4_C_7`/`3_C_x` finite-difference carriers for the same missing-guard pattern before their gate passes fire.
- **Comment-lexing traps for prover prompts**: the ASCII substring `+/-` inside a Lean block/doc comment reopens nesting (each `/-` starts a nested comment) - use `±` in prose; and `/-!` is illegal before `import` on this toolchain (module system treats it as a doc comment on the next declaration) - file headers must open with plain `/-`. Both are cheap pre-edit greps.

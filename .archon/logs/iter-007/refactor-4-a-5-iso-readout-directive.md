# Refactor directive — `4_A_5` IsochoricReadout non-degeneracy field (iter-007 session-6-R1)

Target: `/root/proposal_for_physic/science-mango-ipho-2026-k3-run/IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`
Mode context: autoformalize statement repair (review-gate session_6 verdict, gate 1/3). Mode: `physics-formalize`-class write domain exactly one file above.

## Defect (session_6 review verdict, primary blocker)
`structure IsochoricReadout (P₀ T₀ β₀ : ℝ)` (currently ~L221–L229) lacks a non-degeneracy guard `T₁ ≠ T₂`. At `T₁ = T₂` the consistency fields `measured_hP₁/measured_hP₂` force both measured pressures to `P₀`, so the deviation premise of `beta0_uncertainty_bound` (and `main` conjunct 3) reads `0 ≤ 0` for EVERY `β₀`, while the conclusion `|β₀ − 1/T₀| ≤ σ` fails for `β₀ = 2/T₀ + σ` — the conjunct is mathematically FALSE as stated under the file's own contracts. `countermodel_resistance` FAIL; uncertainty bridge obligation BLOCKED (the cancellation of `P₀·|T₂ − T₁|` in the propagation algebra needs `T₁ ≠ T₂`).

## Action (only this, exactly this)
1. Add ONE field to `IsochoricReadout` (order: immediately after the `T₂` field, before `measuredPressure`):
   `hT12 : T₁ ≠ T₂`
2. Extend the structure's doc comment (the `/-- … -/` block directly above `structure IsochoricReadout`) with one sentence of the same style as the existing prose: the readouts are recorded at two distinct temperatures, `T₁ ≠ T₂`, so the finite-difference slope carrier is non-degenerate. Do NOT use the ASCII substring `+/-` anywhere in comments (comment-lexing trap; use `±` in prose if needed).
3. Nothing else. Every consumer (`main` conjunct 3, `beta0_uncertainty_bound`) takes `readouts` as a hypothesis, so NO construction site exists to update; answer placement, governing-law structures, Physlib imports, and the 10 contracted `by sorry` bodies stay bit-identical. Do not re-prove anything; do not touch any other structure/theorem/doc block; do not reorder fields beyond the one insertion.

## Post-condition (recorded for the prover stage, do not implement now)
With `hT12` + `IsReferenceState.hP₀` the uncertainty conjunct is provable: deviation `= P₀·|T₂ − T₁|·|β₀ − 1/T₀|` via `measured_hP₁/measured_hP₂`, cancel `P₀·|T₂ − T₁| > 0` (`hT12` gives `|T₂ − T₁| ≠ 0`). All six session_6 structured checks then stand green (the other five already PASS).

## Gate
`lake env lean IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` → EXIT 0, 0 errors, sorry warnings = exactly the 10 contracted sites (currently L122/L127/L131/L136/L150/L174/L259/L289/L306/L326; line drift from the +2 lines is fine, count is the invariant). Report the clean compile + the exact inserted text in the task result, and state explicitly that nothing else changed (diff summary).

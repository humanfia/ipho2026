# Task result — prover iter-010 — `IPhO2026Problems/problem_IPhO_2026_3_A_3.lean`

## Status: COMPLETE — all 5 sorries proved, 0 remaining

Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_3.lean`: **0 errors, 0 sorries** (9 s).
Axiom audit (`#print axioms` on a concatenated scratch copy, not in the repo):
`dW_eq_mu0_V_H_dM`, `meanCircumference_eq`, `dW_eq_VH_dB_sub_mu0_dH` (and by construction also `dB_of_vacuum_core`, `dW_eq_sub_vac`) depend only on `[propext, Classical.choice, Quot.sound]` — no `sorryAx`, no new axioms.

## Proofs landed (all algebraic, per the blueprint chapter's informal proofs)

| Declaration | Proof |
|---|---|
| `meanCircumference_eq` | `rw [t.V_eq, mul_div_cancel_right₀ _ (ne_of_gt t.A_pos)]` — from the assumed volume identity `V = 2πR·A`, cancel `A > 0`. |
| `dB_of_vacuum_core` | `rwa [mul_zero, add_zero] at h` — vacuum core `dM = 0` collapses `dB = μ₀·dH + μ₀·0` to `dB = μ₀·dH`. |
| `dW_eq_sub_vac` | `linarith [b.split]` — subtract `dW_vac` from the split `dW_emf = dW_vac + dW`. |
| `dW_eq_VH_dB_sub_mu0_dH` | substitute A.2 law + vacuum-part into the difference, then `ring`. |
| `dW_eq_mu0_V_H_dM` (A.3 target) | `rw [dW_eq_VH_dB_sub_mu0_dH t w 𝓕 v b, v.dBH]; ring` — linearized constitutive law `dB = μ₀dH + μ₀dM` cancels the `V·H·μ₀·dH` terms, leaving `dW = μ₀·V·H·dM`. |

Statements, signatures, and hypotheses are unchanged; only proof bodies after `:= by` were edited.

## Blueprint markers

Ready for `\leanok` (review agent / deterministic sync to apply):
- `def:IPhO2026Problems_problem_IPhO_2026_3_A_3:PmTTorus` … all defs were already `sorry`-free; the lemma/theorem environments newly backed by real proofs:
- `lem:IPhO2026Problems_problem_IPhO_2026_3_A_3:dB_of_vacuum_core`
- `lem:IPhO2026Problems_problem_IPhO_2026_3_A_3:dW_eq_sub_vac`
- `lem:IPhO2026Problems_problem_IPhO_2026_3_A_3:dW_eq_VH_dB_sub_mu0_dH`
- `thm:IPhO2026Problems_problem_IPhO_2026_3_A_3:dW_eq_mu0_V_H_dM`

I did not edit the chapter file (prover write-domain is the `.lean` file only).

## Redraft needed

None. The frozen contract was provable exactly as stated; the recorded answer `dW = μ₀·V·H·dM` follows from the licensed inputs in one ring step.

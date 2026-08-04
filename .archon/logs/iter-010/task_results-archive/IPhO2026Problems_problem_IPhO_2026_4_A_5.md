# Task result — `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` (prover, iter-010)

## Outcome

- `lake env lean IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`: **0 errors**
  (warnings only: benign unused-variable / style linters, and the single
  `declaration uses 'sorry'` warning at line 399 = `beta0_close_to_ideal`).
- Sorry count: **exactly 1** (was 1 at hand-off; the inherited working tree
  had 3 additional hard ERRORS in `beta0_close_to_ideal` — see below).
- `#print axioms IPhO2026_4_A_5.main` = `[propext, Classical.choice,
  Quot.sound]` — no `sorryAx`, no new axioms.

## What was done

1. **Repaired the inherited broken proof body of `beta0_close_to_ideal`.**
   The working tree at hand-off (not the committed `admit`-free skeleton)
   contained a proof attempt whose elaboration FAILED with 3 hard errors
   (an `∧`/`∨` mismatch on `sq_eq_sq_iff_eq_or_eq_neg.mp`, a failing
   `linear_combination` in the negative-case branch, and a dependent-
   elimination failure from `rcases` over the conjunction). Fixed to a
   type-correct disjunction split (`sq_eq_sq_iff_eq_or_eq_neg.mp hPs`
   applied to `hPs : (o*V + s*T0*V)^2 = (P0*V)^2`).
2. **Proved the negative branch honestly** (`o*V + s*T0*V = -(P0*V)`)
   by contradiction with positivity (`mul_pos hP₀pos law.hV` +
   `neg_neg_of_pos`/`not_lt_of_gt`).
3. **Diagnosed the positive branch** (`o*V + s*T0*V = P0*V`, the
   constant-temperature instance of the `by_cases` on the inhabited
   second instant): the offset is genuinely NOT determined. Explicit
   countermodel to the theorem as stated: constant orbit
   `T ≡ 1, P ≡ 1`, ideal-gas law with `n = R = V = 1`, affine line with
   `slope = offset = 1/2` (satisfies `slope_pos`, all `state_eq`,
   `hP₀`, `hT₀`, `hT₀pos`, `hβ₀`) yet conclusion fails:
   `β₀ = slope/P₀ = 1/2 ≠ 1 = 1/T₀`. Hence the stand-alone theorem is
   **false without a non-degeneracy premise**; I left the frozen
   signature untouched and kept exactly one focused `sorry` at that
   algebraic gap (now at `problem_IPhO_2026_4_A_5.lean:443`), with a
   comment marking the gap and the reason.
4. Every other declaration in the file was already proved and is
   unchanged: `absTemp_eq_toReal`, `absTemp_nonneg`,
   `idealThermalPressureCoefficient_value`,
   `IsIdealGasLaw.pressure_pos_of_temp_pos`,
   `IsIdealGasLaw.pressure_ratio_eq_temp_ratio`,
   `IsIsochoricLinear.slope_eq_div`, **`main` (fully proved; 
   uses only standard axioms)**, `beta0_eq_ideal_of_linear`,
   `beta0_uncertainty_bound`.

## Redraft needed

- **Problem id / report**: IPhO_2026_4 part A.5;
  `reports/ipho_2026_k3/problem_IPhO_2026_4_A_5.source.json`.
- **Theorem**: `IPhO2026_4_A_5.beta0_close_to_ideal` (Lean line 399).
- **Why unprovable as stated**: missing non-degeneracy premise. In the
  constant-temperature orbit the affine offset/slope pair has a free
  direction `(offset, slope) ↦ (offset + c·T₀, slope − c)` consistent
  with every hypothesis, so `β₀ = slope/P₀` need not equal `1/T₀`
  (countermodel above). `main` already carries the needed premise as
  `hvar : ∃ t₁ t₂, absTemp (proc.T t₁) ≠ absTemp (proc.T t₂)` — which
  is why `main` (conjunct 1) is fully proved while the standalone
  lemma is not.
- **Smallest statement change**: add to `beta0_close_to_ideal` the same
  hypothesis
  `(hvar : ∃ t₁ t₂ : proc.ProcessTime,
    absTemp (proc.T t₁) ≠ absTemp (proc.T t₂))`.
  Then the existing non-degenerate branch of the proof body (the
  `by_cases` `h12 : … ≠ …` case, fully proved) closes the goal; the
  degenerate branch and its `sorry` disappear.

## Blueprint chapter

`blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex`:
- `\leanok` added to the 22 proved/pinned declarations (all defs; the 8
  proved lemmas/theorems incl. `main`, `beta0_eq_ideal_of_linear`,
  `beta0_uncertainty_bound`; and `IsReferenceState.referenceTemperature`
  / `referencePressure` folded lines).
- `beta0_close_to_ideal` block intentionally LEFT WITHOUT `\leanok` and
  annotated with a `% NOTE:` recording the countermodel and the
  `hvar` repair (mirror of the redraft above), so the review agent /
  deterministic sync does not mark it erroneously.

## Notes for the next iteration

- File-specific instruction says do not edit other `.lean` files: none
  touched.
- The remaining `sorry` is soundness-blocking only for the standalone
  lemma; the A.5 headline statement `main` is sorry-free.
- No missing PhysLean/Mathlib infrastructure was needed — all blocks
  closed with `linear_combination`, `ring`/`ring_nf`, `field_simp`,
  `mul_left_inj'`, `sq_eq_sq_iff_eq_or_eq_neg`, `mul_pos`,
  `neg_neg_of_pos`, `not_lt_of_gt`, `le_of_mul_le_mul_left`.

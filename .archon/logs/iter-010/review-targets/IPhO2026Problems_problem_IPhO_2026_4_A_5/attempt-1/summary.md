# Review — IPhO2026Problems/problem_IPhO_2026_4_A_5.lean (target: IPhO2026_4_A_5.main)

Status: **blocked** — route `needs_redraft` (`underdetermined_contract`).

- Compiles (preflight rc=0) with exactly 1 sorry, in `beta0_close_to_ideal` (file line 446); no axiom laundering — trace shows axioms of `main` = `[propext, Classical.choice, Quot.sound]`.
- Signatures and answer values (beta0 = 1/T0, 0.0037, 0.0034 ± 0.0007 K⁻¹) are faithful and conclusion-side; `IsochoricReadout.hT12` non-degeneracy guard is present; `main`, `beta0_eq_ideal_of_linear`, `beta0_uncertainty_bound` are fully proved.
- Blocker: `beta0_close_to_ideal` lacks the `hvar` non-degeneracy premise `main` carries. In the constant-temperature orbit the affine (offset, slope) pair is underdetermined: countermodel T≡1, P≡1, n=R=V=1, slope=offset=1/2 satisfies all hypotheses but β₀=1/2 ≠ 1/T₀, so the branch is unprovable as stated.
- Repair: add `hvar : ∃ t₁ t₂, absTemp (proc.T t₁) ≠ absTemp (proc.T t₂)` to `beta0_close_to_ideal`; the already-proved non-degenerate branch then closes the goal; delete the `sq_eq_sq` detour and its sorry; restore withheld `\leanok`.
- Process warning: no matching task-results artifact on disk (prompt list empty; trace's write missing) — iter-010 prover trace used as primary evidence per policy.

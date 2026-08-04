# Iter-012 objectives (as dispatched this phase)

## Landed in-phase (refactor subagent lanes, COMPLETE)
- `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` — mandatory statement redraft (missing foundational bridge): added `temp_differentiable`/`mag_differentiable` path-regularity fields to `ParamagneticTorusLaws`; fresh `lake env lean` 0 errors, 3 sorries (L159/170/201).
- `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` — mandatory statement redraft (wrong target): formula re-signed (`0 < R_Th`, `0 < lam`, drive `T_OC < T_IC`); sample theorem restated to the `0.2629 ≤ h·R_Th → |λ−0.25| ≤ 0.01` realizability contract over abstract positive inputs; fresh `lake env lean` 0 errors, 2 sorries (L179/203 after docstring realign).

- Follow-up cosmetic lane `4-c-7-docstring-realign` (86 s, COMPLETE): module-doc bullet re-aligned to the redrafted sample contract; doc-only diff, sorry count unchanged.

## Next prover round (written to PROGRESS.md)
1-12. Mandatory proof-Review retries `[prover-mode: physics]`: `1_A_1` (12 sorries), `1_B_2` (5), `1_C_1` (3), `2_B_2` (6), `2_C_2` (2), `2_C_4` (1), `3_A_1` (0 — verify), `3_B_1` (7), `3_C_2` (1), `3_C_4` (0 — verify), `4_A_5` (0 — verify), `4_B_6` (2).
13-14. Post-redraft re-gate + proof `[prover-mode: physics]`: `3_B_2` (3 sorries), `4_C_7` (2 sorries) — repaired contracts frozen; fill the contracted sorries per chapter routes; formalization gate re-reviews this round.

## Explicitly not dispatched
- `1_B_1` — broken build (3 linarith errors), formalization gate exhausted; prover-stage reopen via its frozen iter-005/006 spec only.
- `4_C_6` — provenance-blocked (raw/E1_solution.pdf absent in-checkout; TO_USER stands).

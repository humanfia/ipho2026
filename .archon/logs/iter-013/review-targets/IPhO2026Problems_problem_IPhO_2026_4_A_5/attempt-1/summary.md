# Review: IPhO2026Problems/problem_IPhO_2026_4_A_5.lean (iter-013, attempt 1)

**Verdict: solved.** `IPhO2026_4_A_5.main` and all components fully proved; route=solved.

- Compile/sorry: preflight rc=0, sorry_count=0, 11.19s; `rg 'sorry|admit|native_decide|axiom'` finds nothing; diagnostics are 8 benign unusedVariables warnings on frozen binders only.
- Contract: statements match the iter-007-frozen blueprint ledger; `IsochoricReadout.hT12` and `main`'s `hvar` non-degeneracy premises intact; no weakening, no answer-as-assumption (1/T0, 0.0037 K^-1, 0.0034+/-0.0007 band all conclusion-side).
- Iter-010 blocker repaired: `beta0_close_to_ideal` (L407) now carries `hvar`, picks a distinct-temperature witness via `by_cases`, derives `slope*V = nR` then `offset = 0`; the old constant-temperature countermodel (T==1, slope=offset=1/2) is excluded.
- Physics semantics: Eq. (1) `P V = n R T` at fixed n,V plus the A.3 linear isochore yield `beta0 = slope/P0 = 1/T0`; uncertainty conjunct factors the deviation as `P0*|T2-T1|*|beta0 - 1/T0|` and cancels the positive factor via `hP0` + `hT12`.
- Evidence: iter-013 prover trace (session 019fa8a9, biui-0724) confirms fresh `lake env lean` 0 errors / 0 sorries on the byte-identical file; no matching task-result artifact supplied -- process warning only, trace used as primary evidence.
- Note: a prior in-path review record (12:21Z) reached the same solved verdict; this line re-issues it under the required timestamp with identical classification.

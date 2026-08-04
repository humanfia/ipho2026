# Review — IPhO2026Problems/problem_IPhO_2026_3_B_2.lean (iter 13, attempt 1)

Verdict: **blocked / needs_redraft** (missing foundational bridge), matching the iter-013 prover trace and task result.

- Compilation fails: 1 error (L363 `rewrite`: pattern `Tf^2` absent in goal) + 1 sorry (L163 `adiabatic_invariant_along_path`); target conclusion itself is the faithful official B.2 answer, conclusion-side, no axioms/admits, positivity lemma proved.
- Root cause is semantic, not tactic-level: `IsAdiabaticPath` states `Cm*T' = -w`, the negation of the official first law `dU = dW` (`nλ/T² dT = +μ₀VH dM`, verified first-hand in T3_solution.txt T3-B2).
- Consequences: `T²(λ+μ₀KH²)` is not conserved — residual `deriv = 4μ₀KH²T·T'`; true invariant is `(λ+μ₀KH²)/T²`; `endpoint_relation` brackets are swapped vs the official `Tf²/Ti² = (λ+μ₀KHf²)/(λ+μ₀KHi²)`, which is exactly what the L363 error exposes.
- Iter-12 differentiability fields patched the iter-10 jump countermodel, but the iter-13 prover re-refuted bridge lemma 1 with a fully smooth countermodel `p(t)=(-tanh t,-sinh t,sech t)` satisfying every premise (EOS, balance-as-stated, integrability).
- Exact repair (names and target conclusion preserved): flip balance sign in `IsAdiabaticPath`, redefine `adiabaticInvariant` as `(λ+μ₀KH²)/T²`, swap `endpoint_relation` brackets, then `deriv_div`/`is_const_of_deriv_eq_zero` and `div_pow`+`div_eq_div_iff`+`linear_combination hrel` close both proofs (contours machine-tested); blueprint lemma blocks must be co-redrafted (same three defects).

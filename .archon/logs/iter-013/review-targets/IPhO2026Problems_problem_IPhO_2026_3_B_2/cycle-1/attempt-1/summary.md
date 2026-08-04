# Review — IPhO2026Problems/problem_IPhO_2026_3_B_2.lean (iter 13, attempt 1)

- **Verdict: blocked / needs_redraft** (redraft_kind: missing_foundational_bridge), status=blocked.
- Preflight: compiles=false, 1 error (L363 `rw` — pattern `Tf^2` not found), 1 sorry (`adiabatic_invariant_along_path` L163/286).
- Main contract `adiabatic_temperature_change` is faithful to the blueprint/official answer (conclusion-side sqrt formula, honest hypotheses, no axioms/admit/native_decide) — it must stay.
- Root cause is semantic, not tactical: `IsAdiabaticPath` flips the first-law sign (states `Cm·Ṫ = −w`; official T3-B2 uses `dU = dW`, i.e. `+w`).
- Consequence: `T²(λ+μ₀KH²)` is not conserved — deriving gives `F′ = 4μ₀KH²T·Ṫ`; the true invariant is `(λ+μ₀KH²)/T²` (T3_solution.txt ll.23–60).
- Bridge lemma 1 is false as stated: iter-13 prover trace (session 019fa8a9) + task_results/problem_IPhO_2026_3_B_2.md record a sympy-verified smooth countermodel `p(t)=(−tanh t, −sinh t, sech t)` satisfying every premise while F(0)≠F(1).
- Third defect: `endpoint_relation` brackets swapped — from `Tf²·B = Ti²·A` only `(Tf/Ti)² = A/B` follows, but the target needs `B/A`: exactly the L363 compile error.
- The three defects do not cancel; no honest proof exists under the frozen contract. The remaining sorry is logical, not tactic-level.
- Trace is current (iter-013, ends 14:22Z) and consistent with the matching task result; prior record's redraft (iter-010 gap) was addressed, this is a new, deeper defect class.
- Repair (machine-tested by prover): flip balance sign, invariant → `(λ+μ₀KH²)/T²`, swap endpoint brackets, keep names and target conclusion; blueprint chapter lemma sketches need the same fix.

# Formalization review: problem_IPhO_2026_1_C_1.lean (iter-017, cycle-2 attempt-1)

**Verdict: PASSED (status=solved).** All six checks pass; every bridge has a covered named carrier.

- The iter-017 redraft repaired both certificate defects in the contract: `IsScatteringAngle` dropped `p ≠ 0` (now the bare cosine law, vacuous at `p = 0`), admitting the official degenerate critical configuration that `T1_solution.txt` counts as attaining the threshold for every θ ≥ π/2; backward `hdisc` strengthened to the π/2 reality condition `0 ≤ 1 − 2ΔU/(mc²)`.
- Both main theorems are now TRUE as stated: backward reachability was machine-checked in scratch (EXIT=0, axioms `[propext, Classical.choice, Quot.sound]`); forward reachability has an explicit double-root coordinate witness route (`P₀ = 2(E₀/c)cosθ/3 ≥ 0`); both minimality halves and all helpers are proved in-file.
- Lean `hbarOmegaMin` carries the correct official factor `2ΔU/(3mc²)`; the answer appears only on conclusion sides — no smuggling into hypotheses, fields, or predicates.
- Countermodel audit: regime excludes degenerate constants and the vacuous `ΔU ∈ (mc²/2, 3mc²/2]`; `p = 0` configurations force the root `ℏΩ(π/2) ≥ ℏΩ(θ)` (forward), so the relaxation cannot undercut either threshold.
- Residual debt is blueprint-side only (stale `p ≠ 0` prose; missing factor 2 in the chapter's recorded-answer paragraph) — routed to plan/blueprint-doctor; not a Lean infidelity.
- Remaining sorries (lines 481, 608) are the two reachability conjuncts, true with a compiled/witnessed route — proof-lane scope, allowed at formalization review.

# Review: problem_IPhO_2026_1_C_1.lean — SOLVED

- Preflight: compiles=true, rc=0, sorry_count=0; only 4 cosmetic unused-binder linter warnings (hθ/hθpos/hfac in `quadratic_characterization_of_threshold`, hrange in the forward theorem). No sorry/admit/native_decide/axiom in proof bodies.
- Axiom audit (trace session d683cdaf, iter-018 proof lane): both main theorems depend only on [propext, Classical.choice, Quot.sound]; `opaque` notes are the design-approved abstract constants.
- Contract: the only changes vs the iter-11 redraft are the certificate-approved iter-017 redraft (`IsScatteringAngle` admits the degenerate official `p = 0` critical configuration — the old `p ≠ 0` version was machine-refuted at θ = π/2; backward `hdisc` strengthened to `0 ≤ 1 − 2ΔU/(mc²)`). Conclusions and the `hbarOmegaMin` answer formula are unchanged; the final lane edited proof bodies only.
- Answer correctness: `hbarOmegaMin` is exactly the smaller root of the official quadratic `(2−cos2θ)E² − 6mc²E + 6ΔUmc² = 0` (factor 2 inside the sqrt present; the blueprint .tex display missing that 2 is a blueprint-doctor item, not a Lean defect).
- Both reachability conjuncts (forward coordinate double-root witness `P₀ = 2(E₀/c)cosθ/3`, backward degenerate witness `p = 0`) and both minimality conjuncts (discriminant ⇒ `Q(E) ≤ 0` ⇒ root-factorization bound) are proved and mathematically sound.
- Trace and newest task result (iter-018 proof lane) agree with the on-disk file in every particular.
- Route: solved. No blocker; blueprint re-keying debts (factor-2 display slip, stale `p ≠ 0` prose, missing `\lean{}` entries for the 3 helpers) flagged for the blueprint doctor.

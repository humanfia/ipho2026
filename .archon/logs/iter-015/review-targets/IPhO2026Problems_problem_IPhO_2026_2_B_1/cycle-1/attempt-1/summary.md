# Review: IPhO2026Problems/problem_IPhO_2026_2_B_1.lean (iter 15)

Verdict: **solved** (route=solved). Target theorem `IPhO2026_2_B_1.alpha_beta_in_terms_of_R`.

- Compilation: deterministic preflight passed — rc=0, sorry_count=0, 29.9 s; all 15 declarations depend only on [propext, Classical.choice, Quot.sound]. No axiom laundering, no native_decide.
- Contract: signature unchanged; the official answer `α = R, β = -R/2` appears strictly conclusion-side (verified no hypothesis or structure field pre-states it). Matches blueprint `thm:physics:IPhO_2026_2_B_1:target`.
- Semantics: Figure-2f cooker model (mirror radius R, container centre (0,−R/2), radius a) faithful; specular law, contiguous symmetric fan, extremal-ray tangency, and a second extremal configuration are stated as hypotheses and used honestly.
- Proof audit: `container_radius_at_extremal_angle` is fully proved (2×2 linear solve for (m,b), b < −R/2 resolves the |dist| sign branch, double-angle step); `alpha_beta_in_terms_of_R` combines the identity at two distinct extremal angles with the ansatz, nonzero determinant via cos injectivity on (0,π/2). Consistent with the blueprint proof sketch.
- Process warning (non-blocking): iter-015 prover trace `.archon/logs/iter-015/provers/IPhO2026Problems_problem_IPhO_2026_2_B_1.jsonl` and matching task results are absent; review based on Lean source + preflight.

Key lemmas: impactParam_eq_sin, sin_two_pos, container_radius_at_extremal_angle, Real.injOn_cos, Real.sin_two_mul.

# Review: problem_IPhO_2026_2_B_2 (iter-010) — blocked / needs_redraft

- **Theorem reviewed**: `IPhO2026_2_B_2.power_ratio_in_terms_of_theta_max` (`IPhO2026Problems/problem_IPhO_2026_2_B_2.lean:262`).
- **Preflight**: compiles=false, sorry_count=0; sole error at 262:40, unsolved goal `p.R - p.R*cos θ = -(p.R*cos θ*sin θ*2) + p.R*sin θ*2` — the ring_nf form of `1 = 2 sin θ`.
- **Root cause (semantic, not tactical)**: lemma `radius_over_diameter_eq` claims `R/(2a) = 1/(1-cos θ)` from the B.1 calibration `2a = 2R sin θ(1-cos θ)`; cancelling nonzero factors reduces it to `2 sin θ = 1`, which the hypotheses do not imply. Countermodel inside the formal hypotheses: R=1, θ=π/4, a = sin θ − ½ sin 2θ ≈ 0.207 > 0 gives R/(2a) ≈ 2.414 ≠ 1/(1-cos θ) ≈ 3.414. The theorem is unprovable as stated.
- **Correct algebra**: the derivable identity is `R/(2a) = 1/(2 sin θ (1-cos θ))` (checked numerically, e.g. θ≈0.126 for a=0.001R gives ≈502 vs exact R/(2a)=500); the recorded answer `1/(1-cos θ_max)` needs an extra constraint fixing θ_max that the B.1 calibration does not provide.
- **Faithfulness audit**: structures (CookerParams/Geometry, AbsorbedRays, PowerBudget, B1Calibration, ThetaMaxSpec) match the blueprint 1:1; proved lemmas (`impactParam_le_aperture`, `collectedWidth_eq_radius`, `power_ratio_eq_width_ratio`) are honest; no sorry/axiom laundering.
- **Evidence**: iter-010 prover trace (218 events) ends stuck on the same false equation; no matching task-results artifact exists (process warning only).
- **Route**: needs_redraft / underdetermined_contract — reconcile recorded answer with B.1 calibration (fix identity or add tangent-ray constraint forcing 2 sin θ_max = 1), then regenerate the two affected declarations.

# Proof Review: IPhO2026Problems/problem_IPhO_2026_4_A_1.lean (A.1)

Verdict: solved (route=solved, redraft_kind=not_applicable).

Evidence: deterministic preflight passed — compiles=true, returncode=0, sorry_count=0, no diagnostics (9.763 s); rg scan finds no sorry/admit/axiom/native_decide.

Statement audit: the four A.1 target theorems are unweakened restatements of the ConfinedAirColumn governing-law fields — mass_of_confined_air (m = rho_a*V := c.mass_eq), number_of_molecules_of_confined_air (N = n*N_A := c.number_eq), molar_mass_consistency (m = n*M_air := c.molarMassConsistency), uncertainty_consistency (0 <= u_m, 0 <= u_n, |N - N_A*n| <= u_N + u_n*N_A via number_eq + nonnegativity certificates). No hypotheses added, dropped, or generalized; equalities not weakened to bounds except the uncertainty target, whose inequality is the faithful propagation band of the declared measurement model.

Physical faithfulness: Figure-17/18 geometry (V = pi*(d/2)^2*H), sealed-CA isochore, stipulated rho_a = 1.12 kg/m^3 density route, Eq. (1) ideal-gas law over arbitrary positive state readouts, Avogadro and molar-mass routes all match the blueprint; official answer values (m = 0.94±0.02 g, n = 3.24±0.7 mmol, N = (1.95±0.05)e21) appear only in OfficialReadouts/comments, never as theorem assumptions — no answer-as-assumption, no unit or tolerance abuse, uncertainties handled by the constraining PropagatesTo law with eliminator propagate_mul_const.

Process warning: this is a review-only target in iter-015 — no matching prover jsonl or task-result artifact exists, so the deterministic preflight plus first-hand source audit serve as primary evidence (not a semantic failure).

Blueprint \leanok marker sync may proceed; no Lean/blueprint files were edited.

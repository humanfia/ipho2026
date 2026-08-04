# Formalization review — IPhO2026Problems/problem_IPhO_2026_3_B_2.lean (iter-012, attempt-1)

**Verdict: PASSED.** The iter-012 redraft resolves the iter-011 reopen (`missing_foundational_bridge`).

- `ParamagneticTorusLaws` now requires `temp_differentiable`/`mag_differentiable` (`DifferentiableAt` on `T(t)`, `M(t)`), so every `deriv` in the first-law balance is genuine; the junk-`0` countermodel class (jump paths satisfying `0=0` while the invariant differs) is excluded.
- Source laws sit hypothesis-side (EOS `T·M·V=n·K·H`, `C_M=n·λ/T²`, work rate `μ₀·V·H·dM/dt` from A.3, adiabatic balance `C_M·Ṫ=−ẇ`); the √-form `ΔT` and even the integrated endpoint relation appear conclusion-side only — no answer smuggling.
- Six checks: faithfulness / derivability / abstraction / countermodel all passed; branch passed (`T_i,T_f>0` fix the positive root, `H_i≥0` orientation datum, proved `lam_add_mu0_K_sq_pos` for either ramp direction); uncertainty not_applicable (exact symbolic answer).
- Five bridge obligations inventoried, all `covered`: ODE from laws+balance, invariant constancy (`adiabatic_invariant_along_path`), endpoint relation, proved positivity cert, final root form.
- Preflight: 0 errors, 3 contracted sorries (L164/L178/L212) matching the declaration layout; no rebuild run per review protocol.

# Review: problem_IPhO_2026_3_B_1 — SOLVED

- **Route**: solved (schema v1). All five checks pass.
- **Compile**: preflight rc=0, sorry_count=0, no diagnostics; source audit finds no sorry/admit/axiom/native_decide/macro tricks.
- **Contract**: iter-011 field-parametrized redraft is faithful — `IsMagneticWorkDensity` keeps the `deriv M_of_H` Jacobian (repairing the iter-010 `underdetermined_contract` defect); EOS enforced at every applied field with `hV`/`hT`; first law supplies universally quantified per-leg balances; the iter-010 countermodel `M(H)=-2H` is excluded.
- **Proof**: bridge chain (EOS solution → derivative → linear density → FTC leg eval → first-law readout) is fully proved; target `isothermal_heat_into_torus` rewrites both endpoints and closes by `ring`, deriving Q = -(μ₀nK/2T)(H_f²-H_i²) with no answer-as-assumption. `official_answer_value` is conclusion-side `rfl`.
- **Signature**: statements/hypotheses unchanged; edits strictly after `:= by`; units and quantity roles preserved; answer recorded conclusion-side only.
- **Evidence**: iter-013 prover trace (biui-0724, 70 turns) documents closing all 7 sorries, `#print axioms` = [propext, Classical.choice, Quot.sound] on all 8 declarations, final `lake env lean` exit=0; no matching task-result artifact (empty list) — process warning only, trace used as primary evidence per instructions.
- **Minor cosmetic notes** (non-blocking): module docstring still claims bodies are `by sorry`; blueprint `ObeysFirstLawMagnetic` entry retains a stale M-parametrized display formula (doc-only).

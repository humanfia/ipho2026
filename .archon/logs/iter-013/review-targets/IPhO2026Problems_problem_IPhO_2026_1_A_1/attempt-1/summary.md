# Proof Review — IPhO2026Problems/problem_IPhO_2026_1_A_1.lean (iter 13)

- Verdict: **solved** (route=solved); target `IPhO2026_1_A_1.hydrostatic_gate_side_length_a_target`.
- Preflight: compiles, returncode 0, `sorry_count=0`; only unused-variable linter warnings.
- Trace `lean_verify`: axioms = propext, Classical.choice, Quot.sound only; no `sorryAx`; no macros/elaborators/`native_decide`.
- Signature preserved: hypotheses are only `S : HydrostaticGateSetup`, `hΔ : DeltaH = 1.41`, `hbal : restoringMoment = pressureCoupleMagnitude`; answer `a = Δh/(2√2)` and `|a−0.50| < 1/200` appear conclusion-side only; parameters opaque.
- Physics faithful: couple readout `ρ₀gΔh·(a²/√2)·(a/(2√2)) = ρ₀gΔh·a³/4` vs restoring `ρ₀ga⁴/√2` — the iter-010 factor-2 defect (a³/8) was redrafted at iter 11 and the countermodel no longer exists.
- Proof chain: 11 lemmas fully proved; `side_length_eq_delta_h_over` cancels `ρ₀ga³ ≠ 0` (`mul_left_cancel₀`); numerics via `1.414 < √2 < 1.415` with nlinarith.
- Prover trace (session 019fa8a9, 107 turns): all 12 obligations closed, 0 errors, whole-project `lake build` succeeded.
- Process warning: no matching iter-13 task_results artifact (list empty) — trace used as primary evidence per instructions; not a semantic failure.
- Blockers: none. Next steps: none.

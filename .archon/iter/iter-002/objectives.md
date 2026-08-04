# Objectives — iter 002 (autoformalize repair wave, 11 lanes)

All lanes: prover-mode `physics-formalize`; output must compile under `lake env lean` with ONLY `sorry` warnings; self-contained files (`import Mathlib` baseline; targeted `Physlib.<Domain>` import only where genuinely used); recorded official answers conclusion-side ONLY; no new axioms; no cross-imports between problem files.

1. `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean` — Redraft (compiles): remove vacuous `radial_energy`; demote answer-valued `ha_max_attained`/`hfact` from target hypotheses; keep honest algebra certificates.
2. `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` — Redraft from stub: doc-only stub → real declarations (unbound Coulomb scattering, `u_inf`, deflection `-16.60°` conclusion-side).
3. `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean` — Repair parse: `where`-in-field L~79, placeholder identifiers, L~156; keep photodissociation momentum law.
4. `IPhO2026Problems/problem_IPhO_2026_1_C_2.lean` — Repair 1 error: unsolved-goals bridge L~249 (field/ring-level; NO sorry in the bridge).
5. `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean` — Repair 1 error: dot-notation-on-function in `CausticPowerLawForm` L~94.
6. `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean` — Repair 47 errors + typed model: typed `Current` (amount+dim, documented scalar projection; clears doctor `scalar-fallback`); synthInstance/unsolved/invalidField cascade.
7. `IPhO2026Problems/problem_IPhO_2026_3_A_2.lean` — Repair 3 errors: add Mathlib baseline import (`Real.pi`), rewrite stray `where`.
8. `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean` — Repair 3 errors: `ObeysFirstLawMagnetic` bound-var application redesign (L~90–92).
9. `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean` — Repair 1 error: `$$`-in-doc-comment parse error L~15 → `$$`-free math.
10. `IPhO2026Problems/problem_IPhO_2026_3_C_3.lean` — Redraft from scratch: delete garbaged `#eval` scratch; formalize C.3 from chapter + source report.
11. `IPhO2026Problems/problem_IPhO_2026_4_C_6.lean` — Repair parse cascade: Physlib-units syntax/arity at L~114; keep the targeted Physlib imports (positive pattern).

No-dispatch (deliberate): review-retry 5 (`1_A_1, 2_A_1, 2_B_1, 2_C_2, 3_C_4` — chapter exemptions landed, await review gate); clean 15; `4_A_5` tail-comment (known-minor, fixed with next touch).

Planner-side debt queued for iter-003+: ~359 helper blueprint entries (batch per problem part, starting from the stable clean-15), umbrella-node `\lean{}` pins, `4_A_5` terminator.

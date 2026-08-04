# Recommendations

- Return only `IPhO2026Problems/problem_IPhO_2026_3_C_1.lean` to autoformalization repair. Add a direct `import Mathlib` alongside the existing Physlib imports, without changing any declaration, theorem signature, physical hypothesis, or conclusion.
- Rerun the blueprint doctor after that import repair. The target must not enter prover dispatch until the `missing-mathlib-import` entry is absent and Formalization Review passes.
- Reuse the orchestrator’s current successful direct-check result only for this Review. After the file changes, run one fresh target-level Lean check and confirm exactly the two intended autoformalization `sorry` warnings remain.
- Add `\lean{IPhO2026Problems.ProblemIPhO2026_3_C_1.identify_temperature_labels_and_heat_processes}` to the blueprint target, then let deterministic marker synchronization decide any `\leanok`; do not add a proof-complete marker while the two proof bodies remain open.
- Preserve the existing derivability chain for the later prover: case-split the two reservoir witnesses, use endpoint equilibrium with `T₂ < T₁` and `T_c < T_h` to obtain cold on `2 → 3` and hot on `4 → 1`, then instantiate endpoint, heat-routing, and adiabatic-isolation laws.

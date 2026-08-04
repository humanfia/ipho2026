# Session 1 Review Summary

- Stage/iteration: `autoformalize`, iter `001`.
- Bounded objectives: 28/28 reviewed; no targets outside the candidate pack audited.
- Direct Lean preflight reused: 28 passed, 0 failed; no compile reruns.
- Open `sorry`: 35 before review, 35 after review. No proof edits were authorized.
- Semantic gate: 21 passed; 7 failed/blocked. Milestone state: 21 `partial`, 7 `blocked`, 0 `solved`, 0 `not_started`.
- Dedicated `physics-reviewer`: not enabled; the required physics checklist was applied directly.
- Grounding logs: all 28 listed `physics-grounding-*` reports contain queries/candidates, grounded names, local abstractions, and grounding-gap sections.
- Attempt capture caveat: `attempts_raw.jsonl` records 84 `code_change` events, but its normalized `file`, `old_text`, and `new_text` fields are empty. Milestones therefore record only the directly evidenced scaffold/check attempt from the bounded candidate and target reports; no tactic attempts are invented.

## Per-target verdicts

| Target | Preflight / sorries | Milestone | Formalization review | Specific finding |
| --- | --- | --- | --- | --- |
| `1_A_1` | passed / 1 | partial | passed | Dimensioned hydrostatics, Figure 1a lever arms, torque balance, datum and rounding are separated from the answer. |
| `1_B_1` | passed / 5 | partial | passed | Coulomb energy/angular-momentum/conic chain is physical and answer-free. |
| `1_B_2` | passed / 1 | partial | passed | Actual velocity fields, orientation, `Tendsto` asymptote and signed degree readout are connected. |
| `1_C_1` | passed / 1 | blocked | failed | Recorded radicand misses factor `2`; encoded conservation laws give small-`ΔU` threshold `ΔU/ℏ`, not `ΔU/(2ℏ)`. |
| `1_C_2` | passed / 1 | blocked | failed | Erroneous C.1 premise predicts about `-0.55 eV`, incompatible with `2.03e-11 eV`; corrected factor gives about `2.0296693e-11 eV`. |
| `2_A_1` | passed / 1 | blocked | failed | Live doctor blocker: missing Physlib/PhysLean import. |
| `2_B_1` | passed / 2 | partial | passed | Figure response and coefficient identity are independent; requested coefficients are conclusions. |
| `2_B_2` | passed / 1 | partial | passed | Typed projected-area power laws plus licensed B.1 relation ground the ratio. |
| `2_B_3` | passed / 1 | partial | passed | Fivefold power is independent of licensed B.1/B.2 equations; metre/cm roles retained. |
| `2_C_1` | passed / 1 | partial | passed | Strike point, tangent, specular law, slope and intercept are physically connected. |
| `2_C_2` | passed / 3 | blocked | failed | Big-O contract is correct, but live doctor blocker reports missing Physlib/PhysLean import. |
| `2_C_3` | passed / 1 | blocked | failed | Ray intersection and `Tendsto` structure are correct, but live doctor blocker reports missing Physlib/PhysLean import. |
| `2_C_4` | passed / 1 | partial | passed | Small-angle cusp uses a punctured-neighborhood limit and correctly dimensioned coefficient. |
| `3_A_1` | passed / 1 | partial | passed | Actual Ampère circuital readouts, torus geometry and uniform-field approximation support `H`. |
| `3_A_2` | passed / 1 | partial | passed | Ampère, Faraday and source-work laws are dimensioned and independent. |
| `3_A_3` | passed / 1 | partial | passed | Fixed-SI roles are explicit; source/vacuum partition plus constitutive increment derives material work. |
| `3_B_1` | passed / 1 | partial | passed | Equation of state, derivative, work integral and first law ground isothermal heat. |
| `3_B_2` | passed / 1 | partial | passed | Process derivatives, first law and zero-heat premise ground the endpoint square-root relation. |
| `3_C_2` | passed / 1 | partial | passed | Four state readouts, equation of state, isothermal heats and Carnot balance ground `M₁`. |
| `3_C_3` | passed / 1 | blocked | failed | Live doctor blocker: missing Mathlib import. |
| `3_C_4` | passed / 1 | partial | passed | `HasDerivAt` cooling law, heat-rate balance and endpoint/operating range ground elapsed time. |
| `3_C_5` | passed / 1 | partial | passed | COP is tied to labeled heat/work/power/time quantities and licensed C.4 only. |
| `4_A_1` | passed / 1 | blocked | failed | Live missing-Mathlib blocker; Figure 17 dimensions are absent and the recorded `0.94 g` conflicts with the mole/count data, so only symbolic formulas are grounded. |
| `4_A_5` | passed / 1 | partial | passed | Three ideal-gas states and A.3 linearity derive the coefficient; reported interval is conclusion-only. |
| `4_B_4` | passed / 1 | partial | passed | Partial-pressure decomposition and two-state dry-air invariant ground the formula. |
| `4_B_6` | passed / 1 | partial | passed | Molar estimate and mass/energy laws ground `L_v = Q_v/M₀` and uncertainty. |
| `4_C_6` | passed / 1 | partial | passed | Licensed C.5 slope and dimensioned heat/conduction roles ground resistance inversion. |
| `4_C_7` | passed / 1 | partial | passed | `HasDerivAt`, radial Fourier law, boundary temperatures and cylindrical area ground the logarithmic formula; unavailable numeric radii are not invented. |

## Blueprint doctor

- No orphan chapters, broken refs, malformed refs, or axiom declarations.
- `physics_grounding_problems`: empty.
- Live `physics_modeling_problems` (verbatim reasons):
  - `problem_IPhO_2026_2_A_1.lean`: “physics target does not import Physlib/PhysLean; attempted grounding should use the available formal physics library before introducing local abstractions”.
  - `problem_IPhO_2026_2_C_2.lean`: same missing-Physlib/PhysLean reason.
  - `problem_IPhO_2026_2_C_3.lean`: same missing-Physlib/PhysLean reason.
  - `problem_IPhO_2026_3_C_3.lean`: “physics target does not import Mathlib; autoformalization must be checked in a real Lake/Mathlib environment, not as a standalone Lean smoke file”.
  - `problem_IPhO_2026_4_A_1.lean`: same missing-Mathlib reason.

## Marker state

- `sync_leanok-state.json` is current for iter 001 and exactly the 28 objectives; it added 0 and removed 0 markers.
- No manual blueprint marker changes were made in review.
- Target reports consistently request `\lean{...}` associations. Add them from `milestones.jsonl` before expecting deterministic `\leanok` synchronization.

## Reusable findings

- Local approximations passed only when represented by `=O[𝓝 0]`, `Tendsto` on `𝓝[≠] 0`, or `HasDerivAt`; no globalized approximation was accepted.
- Fixed-SI scalar readouts are acceptable only when the structures and field names retain explicit physical roles/units and the governing laws connect them.
- Natural-language previous-part results may be premises, but a physically inconsistent prerequisite blocks descendants even when reuse policy permits it.

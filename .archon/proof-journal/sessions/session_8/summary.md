# Deterministic bounded Review — session 8

- Scope: exactly the one deterministic candidate, `IPhO2026Problems/problem_IPhO_2026_3_C_1.lean`; no other target received a verdict.
- Direct preflight: passed in 4.626 seconds with exactly two intended `sorry` warnings. Per bounded-review policy, no Lean check was rerun.
- Formalization Review: failed on the mandatory doctor gate. The statement-level semantic audit otherwise passes all six structured checks.
- Route: blocked on import/modeling compliance; return to autoformalization repair before prover dispatch.

## Target verdict

`identify_temperature_labels_and_heat_processes` faithfully concludes the source answer: states 1 and 4 are at `T_h`, states 2 and 3 are at `T_c`, `Q_c` is absorbed on `2 → 3`, and `Q_h` is delivered on `4 → 1`. It also correctly derives no heat on the two adiabatic legs.

The result is not assumed. `Figure3bGeometry` provides the two isothermal legs, the two adiabatic legs, and only the raw inequality `T₂ < T₁`. The Carnot interface provides general reservoir-contact existence, endpoint equilibrium, `T_c < T_h`, contact-dependent transfer direction, and isolation laws. Finite case analysis rules out both isotherms contacting the same reservoir and rules out the hot/cold swapped assignment. Endpoint and transfer eliminators then force all target conjuncts.

The local physics abstractions are mathematically usable rather than opaque: they expose process equalities, temperature inequalities, reservoir-contact equations, endpoint equations, heat-routing/sign equations, the statewise equation of state, and the legwise isothermal heat equation. The countermodel audit found no answer-as-assumption, ghost proposition, globalized approximation, missing uncertainty carrier, or free orientation branch.

## Hard blocker

The authoritative doctor reports:

> `IPhO2026Problems/problem_IPhO_2026_3_C_1.lean` :: `missing-mathlib-import` — physics target does not import Mathlib; autoformalization must be checked in a real Lake/Mathlib environment, not as a standalone Lean smoke file

The file directly imports two Physlib modules but does not directly import Mathlib. The review instructions require every live `physics_modeling_problems` entry to block acceptance, so the formalization verdict is `failed` regardless of the passing direct check and sound statement design.

The doctor JSON reports no grounding problem, orphan chapter, broken/malformed reference, or axiom declaration. The target report supplies actual LeanExplore queries/candidates, grounded `Temperature`, `Temperature.toReal`, `DimEnergy`, dimension and SI names, justified local abstractions, and the domain-API gaps. No dedicated `physics-reviewer` report exists because that subagent is disabled; this Review applied the required checklist directly.

## Blueprint and marker state

Iteration-008 marker synchronization ran in `current-objectives` scope for this exact target and made no additions or removals. First-hand inspection finds no `\leanok`, so there is no proof-marker laundering. The chapter still lacks the fully qualified `\lean{...}` link to the main theorem and should be wired during the repair route.

# Deterministic bounded Review — session 9

- Scope: exactly `IPhO2026Problems/problem_IPhO_2026_3_C_1.lean`; no other target received a verdict.
- Direct preflight: passed in 8.611 seconds with exactly the two intended `sorry` warnings. Review did not rerun Lean or rebuild the DAG.
- Formalization Review: passed. Proof completion is still pending, so this is ready for prover dispatch rather than proof-complete.
- Prior blocker: cleared. The target now directly imports `Mathlib`, and the current doctor has no modeling or grounding finding for this candidate.

## Semantic verdict

The main theorem faithfully states the source answer: states 1 and 4 are at
`T_h`, states 2 and 3 are at `T_c`, `Q_c` is absorbed on `2 → 3`, and `Q_h`
is delivered on `4 → 1`. The added conclusions that the two adiabatic legs
carry no heat agree with the displayed Carnot cycle.

The answer is not assumed. `Figure3bGeometry` identifies the two isothermal
and two adiabatic legs and supplies only the raw ordering `T₂ < T₁`.
`SatisfiesCarnotRefrigeratorLaws` supplies finite reservoir-contact witnesses,
endpoint equilibrium, `T_c < T_h`, general contact-indexed heat routing, and
the no-contact/no-transfer laws. Same-reservoir assignments contradict
`T₂ < T₁`; the swapped assignment contradicts `T_c < T_h`. Endpoint,
heat-routing, and isolation eliminators then force all target conjuncts.

The physics interfaces are equation-bearing rather than opaque. Temperatures
and heats retain Physlib carriers; volume, magnetic intensity, and
permeability retain dimensions; scalar laws pass through named SI
projections. There is no answer-as-assumption, ghost proposition, globalized
approximation, disconnected derivative/field claim, unresolved orientation,
or applicable uncertainty obligation. The adversarial countermodel check
passes.

## Grounding, structure, and markers

The grounding report records actual Mathlib/Physlib searches and candidates,
grounded Physlib names, the retained local abstractions, and no unresolved
grounding gap. The current doctor reports no orphan chapter, broken or
malformed reference, axiom declaration, or physics-grounding problem. The
candidate's iteration-008 `missing-mathlib-import` finding is absent.

The doctor still contains this project-wide finding outside the bounded
candidate:

> `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean` ::
> `missing-physlib-import` — physics target does not import Physlib/PhysLean;
> grounding should use the configured domain library before introducing local
> abstractions

That target remains user-skipped by standing directive and was not audited or
given a verdict here. Consequently, this candidate passes its target-specific
gate, but the project-wide physics-doctor state is not globally clear.

Iteration-009 marker synchronization ran in `current-objectives` scope for the
reviewed target and made no additions or removals. The blueprint contains the
fully qualified `\lean{...}` links and no `\leanok` proof-complete marker, so
there is no marker laundering. No dedicated `physics-reviewer` report exists
because that subagent is disabled; this Review applied the physics checklist
directly.

# Iteration 006 bounded plan

## Results merged

- Proof Review now records 25/28 targets solved.
- `1_B_2`, `2_B_1`, and `4_B_6` exhausted all three reviewed attempts; they are removed from dispatch eligibility and retained as current structural blockers.

## Graph repair

- Added blueprint blocks and direct `\uses{}` edges for all seven unmatched Physlib length/projection helpers in `2_A_1`, `2_C_2`, and `2_C_3`.
- Exact `\lean{}` pins occur once each; all `\uses{}` targets resolve. The documented `archon` executable was unavailable on PATH.
- Retained `def:project:hello`: it maps a live, genuinely dependency-free bootstrap declaration. Removing the isolated node requires deleting that Lean declaration in a structural lane.

## Decision made

- Dispatch no prover: the only unresolved files are Review-exhausted, while the other 25 already passed. Re-dispatch would violate the retry gate.
- The faithfulness rule forbids agent-side strengthening of signatures or hypotheses. Completion therefore requires user-authored contract revisions adding general outgoing-asymptote and tangent-radius laws and explicit `4_B_6` uncertainty propagation.
- After such revisions, estimated cost is ~30–100 structural LOC plus ~60–300 proof LOC; a countermodel to a revised general law would reverse that route.

# Iteration 008 plan

## Decision made

- Close the selected 22-target theory route. Session 5 accepted the final two repairs; all 22 now compile axiom-clean with zero placeholders. The validator classifies further polish redispatches as no-ops. Reverse only if a later build/review exposes a concrete regression.
- Do not scaffold `3_C_1`: it would create a 23rd theory target, contrary to the standing “22 theory targets only” scope. Removed its dead isolated blueprint target node while retaining the source record.
- Keep all six E1 targets user-skipped, not failed; resume only on explicit user direction.

## Doctor deferrals

- `def:project:hello` remains an intentional dependency-free bootstrap node.
- E1 `4_B_6` import repair remains deferred under the standing pause.

## Subagent skips

- None enabled; classic single-agent loop required.

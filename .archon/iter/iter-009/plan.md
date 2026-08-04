# Iteration 009 plan

## Decision made

- Expand the active theory route from the prior 22-target subset to all 23 theory targets, as required by the standing directive. Keep `3_C_1` in autoformalize and dispatch only its import-gate repair: add direct Mathlib grounding while freezing the semantically accepted typed contract. The official Figure 3b source image confirms the state ordering and isothermal legs. Reverse only if the import exposes a compile conflict or Formalization Review finds a new semantic defect.
- After Formalization Review accepts, route the two existing obligations to physics proof mode, then require Proof Review and the full 23-target build before completion.

## Graph and doctor actions

- Added blueprint blocks for all 22 public helpers plus the target, with declaration-level dependencies, a finite bridge proof, and the fully qualified target pin; the target is no longer isolated.
- `4_B_6`’s Physlib-import finding remains deferred solely under the six-target E1 pause.
- `def:project:hello` remains intentionally isolated as a dependency-free bootstrap definition.

## Tool substitutions

- `archon dag-query` is unavailable on `PATH`; used the injected leandag findings plus direct Lean/declaration-pin checks.

## Subagent skips

- None enabled; classic single-agent loop required.

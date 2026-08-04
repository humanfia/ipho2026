# Iteration 001 plan

## Decision made

- Dispatch all 28 independent physics scaffold files in one batch. The project override is `max_objectives = 28`, preflight passed, every target is a finite-effort frontier node, and no target has local dependencies.
- Treat each missing `\lean{}` pin as the intended scaffold signal: create typed declarations with `sorry` bodies in `physics-formalize` mode; do not attempt proofs or weaken the physical model.
- Keep targets file-local this round. Reverse only if formalization review identifies repeated abstractions whose duplication harms semantic consistency; then introduce shared infrastructure before proof work.

## Evidence

- Read the 28 prepared source-report entries through the batch manifest; all 16 distinct official page images exist.
- No prover results or prior sidecars exist. Mathlib/PhysLean preflight passed and starting sorry count is zero.
- Cleared coverage debt for `hello` with `IPhO2026Run_Basic.tex`; it has no dependencies.
- The 28 scaffold targets are intentionally isolated: their source policy forbids dependencies on earlier subproblem Lean outputs. Generated declarations must receive accurate blueprint edges after formalization.

## Subagent skips

- None enabled; the user selected the classic single-agent loop.

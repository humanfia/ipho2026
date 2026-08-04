---
name: physics
description: "Prove frozen Lean statements produced from natural-language quantum algorithms/information tasks."
compatible_stages:
  - prover
read_blueprint: true
dispatcher_notes: |
  Project-local quantum profile for the physics proof routing mode. Signatures
  are frozen; semantic defects are routed back to formalization.
---

## Goal

Replace the assigned `sorry` bodies with kernel-checked proofs while preserving
the formalized theorem signatures.

## Workflow

1. Read the blueprint, source report, formalization audit, and assigned Lean
   file.
2. Treat declaration headers as frozen. Do not rename binders, add assumptions,
   weaken conclusions, replace a claim with `True`, or encode the answer in a
   definition.
3. Work in the exact Lake environment and use the configured benchmark Base
   library. Search local declarations first, then LeanExplore with the package
   list from `loop.domain_profile`, and verify candidate types with Lean LSP.
4. Use appropriate Mathlib tactics and lemmas only after exposing the relevant
   algebraic, matrix, finite-sum, probabilistic, analytic, or asymptotic
   structure.
5. Compile the file after each material proof change.
6. If the target is unprovable because the natural-language statement was
   mistranslated, is underdetermined, assumes its answer, or omits a required
   bridge, keep the smallest focused `sorry` and record a `needs_redraft`
   request with concrete evidence. Such a failure must return to
   formalization, not be hidden by changing the signature.

## Blind-input boundary

Do not inspect official task `Definitions.lean`, `Statement.lean`,
`Hints.lean`, solutions, or sibling baseline checkouts. The configured Base
library is allowed; per-task official Lean is evaluation-only.

## Completion

A target is solved only when the exact project compiler accepts it, no new
axioms or `sorryAx` laundering were introduced, and every remaining `sorry`
has a specific proof or formalization blocker in the task-result report.

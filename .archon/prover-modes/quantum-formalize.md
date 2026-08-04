---
name: physics-formalize
description: "Formalize a natural-language quantum algorithms/information task into faithful Lean declarations with sorry bodies."
compatible_stages:
  - autoformalize
read_blueprint: true
dispatcher_notes: |
  Project-local quantum profile for the physics-formalize routing mode.
  It creates compiling statements only. The natural-language benchmark source
  and configured Base library are the permitted task inputs.
---

## Goal

Translate the assigned natural-language quantum algorithms or quantum
information problem into a compiling Lean file with `by sorry` proof bodies.
The statement must preserve the source semantics and be proof-ready; this stage
does not attempt the proof.

## Blind-input boundary

- Read the assigned blueprint chapter, its source report, `.archon/config.json`,
  and the configured benchmark `Base` library.
- Do not inspect, search for, or copy any official per-task `Definitions.lean`,
  `Statement.lean`, `Hints.lean`, solution, answer key, or sibling baseline
  checkout. Those files are evaluation material, not formalization input.
- The natural-language statement is the source of truth. A recorded answer may
  guide semantic checking but must never be assumed as a premise.

## Required workflow

1. Inventory every mathematical object, binder, quantifier, hypothesis,
   side-condition, convention, and requested conclusion.
2. Separate reusable definitions and governing assumptions from the current
   theorem target. Never place the target itself in a hypothesis, structure
   field, predicate, or transparent definition.
3. Read `loop.domain_profile` and import the configured benchmark Base module.
   Use the exact project toolchain; do not add Physlib unless the project
   explicitly declares it.
4. Search before inventing APIs:
   - use LeanExplore `search_summary` with the package list recorded in the
     source report/config,
   - inspect the source/module of candidates you intend to use,
   - confirm names and types with the project Lean LSP.
5. Prefer existing Mathlib, cslib, and benchmark-Base definitions. Add the
   smallest faithful local definition only when the configured environment
   lacks the object required by the natural-language statement.
6. Preserve mathematically load-bearing details, including finite-dimensional
   assumptions, index types, normalization, positivity, unitarity/isometry,
   trace/channel conditions, oracle/query access, probability/error bounds,
   asymptotic direction, and existential versus constructive claims.
7. Do not strengthen an informal approximation or asymptotic statement into a
   global exact equality. Do not weaken a substantive theorem to `True`,
   reflexivity, an unused premise, or unrelated algebra.
8. Compile the assigned file with the exact Lake environment. Stop only when
   the declarations compile with expected `sorry` warnings.

## Write permissions

Edit only the assigned `.lean` file and its task-result report. Do not edit the
natural-language source, blueprint, progress state, benchmark Base library, or
protected signatures.

## Task-result report

Record:

- source-to-Lean binder and conclusion mapping,
- assumption/target split,
- definitions reused from the configured Base library,
- LeanExplore queries and accepted/rejected candidates,
- local definitions introduced and why they are faithful,
- semantic ambiguities and the chosen interpretation,
- proof-readiness/derivability audit,
- any reason the statement needs reviewer redrafting.

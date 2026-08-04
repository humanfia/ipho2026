# Session 6 review summary — autoformalize repair wave (1 lane of 2 dispatched)

## Scope

Reviewed exactly the 1 deterministic candidate of iter-006:
`IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` (O1 comment-syntax repair
lane; first formalization review of this target, gate 0/3 → 1/3). The iter's
other dispatched lane (O2, `1_B_1` sign-chain repair) was gate-dropped before
dispatch (`review_exhausted` 3/3 — expected per the iter-005/006 plans) and is
NOT in the candidate pack; not re-audited. Compile result taken from the
orchestrator parallel preflight (9.163 s, passed; no rerun per the determinism
rule). `blueprint-doctor.json` consumed as the injected structural/physics
verdict; leandag not rebuilt. Semantic audit from the bounded candidate pack
plus first-hand reads of the full 350-line statement file, the blueprint
chapter, the source report, and the task report. No subagents enabled; physics
checklist applied directly (no dedicated `physics-reviewer` report exists).

## Metrics

- Compile: **PASSED** — 0 errors; exactly 10 `declaration uses sorry`
  warnings = the 10 on-disk contracted by-sorry bodies
  (L122/L127/L131/L136/L150/L174/L259/L289/L306/L326).
- Review verdicts: **1 failed / 0 passed** under the mandatory
  `formalization_review` gate; `status=partial`. Per-check:
  source_faithfulness PASS · derivability PASS (for conjuncts 1–2; the
  conjunct-3 derivability hole is carried under the countermodel check and
  the blocked bridge) · abstraction_sufficiency PASS ·
  uncertainty_propagation PASS (framing; carrier defect scored elsewhere) ·
  branch_orientation N/A (scalar isochoric process) ·
  **countermodel_resistance FAIL**. Bridge obligations: **5 covered / 1
  blocked** (`beta0_uncertainty_bound` + `main` conjunct 3).
- Doctor: injected 19 `missing-physlib-import` findings = same stale iter-003
  pre-NOTE snapshot (5th consecutive iter). **4_A_5 is NOT flagged** — it
  appears only in the chapter inventories; positive targeted-import case (3
  Physlib thermodynamics imports) with the chapter's `% NOTE: PhysLean
  grounding reconciliation`. 0 grounding problems, 0 orphans, 0 broken refs,
  0 axioms, 0 covers problems. No live doctor blocker on this file per the
  iter-003 upstream patch and iters-004/005 live reruns.
- sync_leanok: iter=6, current-objectives scope, targets_checked=[4_A_5],
  added=0/removed=0 — deterministic non-action; no `\leanok` laundering.

## What happened on the target

- The lane fixed BOTH compile blockers with comment-token-only edits, exactly
  the dispatched change surface: (1) three doc comments contained literal
  ASCII `+/-`; each `+/-` line reopens a nested block comment that consumes
  the enclosing doc comment's `-/` → `351:0 unterminated comment`
  (character-level delimiter scan by the lane); fixed with Unicode `±`.
  (2) Latent pre-existing defect exposed after fix 1: the header opened with
  `/-!`, which this Lean4+module toolchain treats as a doc comment attached
  to the next declaration → `47:0 invalid 'import' command` (lane reproduced
  with a minimal 4-line file); fixed to plain `/-` on line 1 only.
  **Archon-memory rule confirmed: "Fresh `lake env lean` only" — the iter-002
  'benign unterminated comment tail' note hid a real error for 4 iters.**
- The tail reconstruction restored `beta0_close_to_ideal`,
  `beta0_eq_ideal_of_linear`, `beta0_uncertainty_bound` + both `end` lines as
  an honest, source-anchored rebuild matching the iter-006 O1 recorded
  theorem text. Sorry count 10 (not the 11 projected pre-repair, which had
  counted the swallowed theorem as present).
- Answer discipline is clean: `1/T₀`, `0.0037`, `0.0034 ± 0.0007` are strictly
  conclusion-side; no structure field, law premise, hypothesis, or local def
  mentions them. Governing-law LHS complete (Eq. (1) statewise with free
  decalibrated `R`; A.3 affine law; reference-state positivity). Units/dim
  preserved via PhysLean typed `Temperature` + `absTemp`.

## Why the gate fails (primary blocker — statement-level, new detector this iter)

`IsochoricReadout` has **no non-degeneracy field** `T₁ ≠ T₂`. With
`T₁ = T₂`, the consistency fields force both measured pressures to `P₀`; the
deviation premise then reads `|P₀ − P₀ − 0| = 0 ≤ P₀·0·σ` and holds for
**every** `β₀`, while the conclusion `|β₀ − 1/T₀| ≤ σ` fails for e.g.
`β₀ = 2/T₀ + σ`. All hypotheses of `beta0_uncertainty_bound` — and of `main`
conjunct 3 — are simultaneously satisfiable on this instance, so the
uncertainty conjunct is **mathematically false as stated** under the file's
own contracts. This is exactly the adversarial-underdetermination class the
gate exists to catch; the lane could not have seen it because its directive
was comment-syntax-only and the swallowed text predates the iter-001 review.
Root cause is one missing structure field squarely analogous to the `hvar`
guard `main` already carries for the slope bridge (and to the source physics:
A.2 reads temperatures AROUND the reference state). After adding
`hT12 : T₁ ≠ T₂` to `IsochoricReadout`, the propagation algebra (deviation
= `P₀·|ΔT|·|β₀ − 1/T₀|`, cancel `P₀·|ΔT| > 0`) closes in a few lines and the
conjunct is provable-true. Full instance and repair spec: milestones.jsonl
`countermodel_resistance` evidence + recommendations.md R2.

## Secondary durable blocker (non-statement)

The deterministic physics-grounding preflight for 4_A_5 is the generic-noise
log (`Path.target`/`semiformal_result`/`stereographic_target` only, "None
detected" for local abstractions), contradicted by the task report's real
grounded-name register (`Temperature` id 394201; documented near-miss
`IdealGas.ideal_gas_law` id 393919 with the R≡1 dimensional-analysis reason
the local `IsIdealGasLaw` exists). Per iters 002–004 the task report is the
register of record; the preflight-vs-report contradiction routes to
loop-level repair, never to statement redraft.

## Secondary observations for the prover stage (not gate defects)

- The standalone `beta0_*` components omit `main`'s `hvar` hypothesis; the
  components stay true (proofs via the ratio bridge / reference-state algebra
  need no distinct-temperature times), but they are not a sufficient proof
  outline for `main`'s conjuncts — prover should discharge `main` directly
  with `hvar`.
- `offset = 0` derivation needs the absolute-zero anchoring argument
  (`state_eq` at `Ta = 0` gives `P = 0`, hence `affine` forces `offset = 0`)
  only if `ProcessTime` contains a zero-temperature instant; otherwise the
  ratio-bridge/index-free route (`P0 = (nR/V)·T0` at the reference state,
  `slope = nR/V` from two state instances via `pressure_ratio_eq_temp_ratio`
  — which only needs positivity hypotheses it already has) is the honest
  path. Recorded for the prover; statements stay as-is.

## Marker actions

None; sync verified as deterministic non-action. No `\mathlibok`/rename/
`\notready` work outstanding on this chapter.

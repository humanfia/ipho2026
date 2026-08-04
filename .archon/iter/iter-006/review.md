# Iter-006 review (session_6) — autoformalize repair wave (1 lane of 2 dispatched)

## Scope & method

1 deterministic candidate: `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` (O1 comment-syntax repair lane; this file's FIRST formalization review — never lane-written into a milestones file before, so the gate's deterministic semantic audit had not fired on it since iter-001). The iter's second lane (O2, `1_B_1`) was gate-dropped (`review_exhausted` 3/3, expected); not in the candidate pack; not audited. Compile taken from the orchestrator preflight (9.163 s, passed — no-rerun rule). `blueprint-doctor.json` consumed as injected structural/physics verdict; no leandag rebuild. Semantic audit from the bounded candidate pack plus first-hand reads of the full 350-line file, the blueprint chapter, `reports/.../4_A_5.source.json`, the task report, and the attempts log. No subagents enabled; physics checklist applied directly.

## Metrics

- Compile: PASSED — 0 errors; exactly 10 sorry warnings = the 10 contracted by-sorry bodies (L122/L127/L131/L136/L150/L174/L259/L289/L306/L326).
- Verdicts: **1 failed / 0 passed** (structured `formalization_review` in milestones.jsonl; gate 0/3 to 1/3). Checks: source_faithfulness PASS, derivability PASS (conjuncts 1-2), abstraction_sufficiency PASS, uncertainty_propagation PASS (framing), branch_orientation N/A, **countermodel_resistance FAIL**. Bridges: 5 covered / 1 blocked (uncertainty carrier).
- Doctor: injected 19 `missing-physlib-import` = stale iter-003 snapshot (5th iter); **4_A_5 NOT flagged** (positive targeted-import case: 3 Physlib thermodynamics imports plus reconciliation NOTE). 0 grounding/orphan/ref/axiom/covers problems. No live doctor blocker.
- sync_leanok: iter=6, current-objectives, targets_checked=[4_A_5], added=0/removed=0 — deterministic non-action; no laundering.

## What happened on the target

- Lane fixed BOTH compile blockers, comment-token-only, exactly the dispatched surface: (1) three doc comments held literal ASCII `+/-` (`beta0 = 0.0034 +/- 0.0007 K^-1`) — each `+/-` line reopens a nested block comment that eats the enclosing doc comment's terminator, yielding `351:0 unterminated comment`; fixed with `±`. (2) Latent: header `/-!` before `import` is illegal on this Lean4+module toolchain (doc comment on next declaration, `47:0 invalid 'import' command`; minimal reproduction by the lane); fixed to a plain block-comment opener on line 1 only. **The Archon-memory rule 'Fresh `lake env lean` only' confirmed again — the iter-002 'benign tail' note hid this for 4 iters.**
- Tail restored as an honest, source-anchored rebuild matching the iter-006 O1 recorded theorem text: `beta0_close_to_ideal`, `beta0_eq_ideal_of_linear`, `beta0_uncertainty_bound`, both `end`s. Sorry count 10 (pre-repair audit had projected 11 by counting the swallowed theorem as present).
- Answer discipline clean: `1/T₀`, `0.0037`, `0.0034 ± 0.0007` strictly conclusion-side; no field/law/hypothesis/local-def mentions them. Governing-law LHS complete (Eq. (1) statewise with free decalibrated `R`; A.3 affine law; reference-state positivity). Units preserved via typed PhysLean `Temperature` + `absTemp`.

## Key adjudications

1. **New live countermodel on the uncertainty conjunct (primary fail).** `IsochoricReadout` has no `T₁ ≠ T₂` field. At `T₁ = T₂` the consistency fields force both measured pressures to `P₀`, so the deviation premise is `0 ≤ 0` for EVERY `β₀` while `|β₀ − 1/T₀| ≤ σ` fails for `β₀ = 2/T₀ + σ`. All hypotheses of `beta0_uncertainty_bound` and of `main` conjunct 3 hold simultaneously — the conjunct is FALSE as stated under the file's own contracts. One-field repair: add `hT12 : T₁ ≠ T₂` to `IsochoricReadout` (source-warranted: A.2 reads around the reference state; `main` already carries the analogous `hvar` for the slope bridge; zero construction sites to update because all consumers take `readouts` as a hypothesis). After repair the propagation algebra (deviation `= P₀·|ΔT|·|β₀ − 1/T₀|`, cancel `P₀·|ΔT| > 0`) closes in a few lines. Full spec: recommendations.md R1.
2. **Durable non-statement blocker re-scored**: deterministic grounding preflight = generic noise (`Path.target`/`semiformal_result`/`stereographic_target`), contradicted by the task report's real register (`Temperature` id 394201; near-miss `IdealGas.ideal_gas_law` id 393919). Task report = register of record; preflight defect routes to loop repair (5th occurrence; recommendations.md R2).
3. **Prover-stage notes recorded (not defects)**: standalone `beta0_*` components omit `main`'s `hvar` (still true via ratio-bridge/reference routes; not a proof outline for `main`); `offset = 0` needs the absolute-zero anchoring argument or the index-free ratio route.

## Marker actions

None; sync verified as deterministic non-action.

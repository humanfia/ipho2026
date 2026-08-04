# Index
<!-- One line per file. Update line numbers when the file changes. -->

## Iter-014 ground truth (planner audit this iter — fresh `lake env lean` per affected file)
- `3_B_2`: 0 errors / 0 sorries (repairs landed iter-012 differentiability fields + iter-014 sign/invariant/endpoint fixes; PROVED end-to-end). Re-gate passed this iter (gate write 3/3).
- `1_B_2`: 0 errors / 3 sorries (Kepler bridge L505/551/591, documented) — recovered from a refactor-lane `git apply -R` destruction via `/tmp/b2.diff` + the lane's four verified tactic fixes (incl. L929).
- `4_C_7`: 0 errors / 2 sorries (L179 formula, L203 sample) — contract frozen iter-012; re-gate retry 3/3 = objective lane 5 in PROGRESS.md.
- Compile breakers needing tactic repair before their proof lanes: `2_C_2` (1 parse error), `2_C_4` (2 namespace errors), `1_C_1` (2 tactic errors + 2 sorries), `2_B_2` (4 tactic errors + 5 sorries).
- Formalization gate ledger: 25 passed after the `3_B_2` re-gate; `4_C_7` 3/3 pending review write; `1_B_1` exhausted (frozen iter-005/006 reopen spec; TO_USER stands); `4_C_6` exhausted provenance-pending (`raw/E1_solution.pdf` absent in-checkout; full set at sibling `hf-IPHO2026-upload/ipho_2026_source/`; vendor-or-not is a user decision, TO_USER).
- Blueprint: `3_B_2` + `1_B_2` chapters re-keyed to the official chains this iter; `2_B_2` broken `collectedWidth_eq_radius` cref pair repointed; `unmatched` floor 42 live (39 `1_B_1` + `hello` + `2_C_2` 2 + `PartA1.circulation` 1) by design, cleared at each file's reopen.
- Hazard logged (ARCHON_MEMORY): refactor/subagent lanes can destroy uncommitted working-tree state (`git apply -R` accident, iter-014): directives must forbid `git apply`/`checkout`/`reset`/`sed -i`, and `git diff` snapshots should be taken before each subagent dispatch.

## Known-minor (scheduled with next touch, not worth a lane)
- 2 unused-variable linter warnings on `1_C_2`; 2 deprecated `push_neg` warnings on `1_B_1` (fix inside its prover-stage reopen lane, optional).
- Stale `\leanok` on `thm:physics:IPhO_2026_1_B_1:target` (annotated `% STALE-LEANOK iter-001`): deterministic sync owns removal.

## Planner debt (post-iter-012)
- NONE open on blueprint coverage. Remaining scheduled items: (a) `1_B_1` 32-helper batch at its reopen; (b) `hello` entry-or-private at polish; (c) 26 scan-invisible-pin warnings stay documented in-chapter (no action); (d) optional cosmetic wiring of the 7 benign isolated nodes at prover stage.
- Escalations pending (unchanged since iter-003): user to confirm upstream Archon doctor-patch pinning (venv editable install; TO_USER iters 003/005/007/008). Loop-side: session_7 R5 (grounding preflight generic noise log) + R6 (stale finding re-injection).
- NEW iter-012: full official solution set located at `/root/proposal_for_physic/hf-IPHO2026-upload/ipho_2026_source/` (raw PDFs + txt, used read-only this iter to settle C.7 arithmetic); the project checkout still lacks `raw/E1_solution.pdf` — user decision whether to vendor it in (unblocks `4_C_6`; `4_C_7` no longer depends on it).
- **Standing rule (iter-008 incident)**: `task_results/physics-grounding-*.md` are loop-consumed registers — NEVER batch-delete on collect; witness probes (`witness_*.lean`) also preserved.

## Resolved this iter (iter-014)
- `3_B_2` mandatory redraft (iter-013 proof-Review `missing_foundational_bridge`): sign fix `Cm·Ṫ = +w` (official `dU=dW`), quotient invariant `(λ+μ₀KH²)/T²`, endpoint brackets un-swapped; all 3 sorries closed — refactor lane `3-b-2-redraft-invariant-fix` (2642 s, COMPLETE). Blueprint chapter re-keyed same iter.
- `1_B_2` iter-011 elaborated tree restored after refactor-lane destruction (`git apply -R` accident in lane `1-b-2-tactical-residue`): planner re-applied the lane-captured `/tmp/b2.diff`, landed the four verified tactic fixes; file at 0 errors / 3 documented Kepler-bridge sorries. Blueprint chapter statements re-keyed to the official `49/4`-chain + 3 helper lemmas transcribed.
- `2_B_2` blueprint broken-cref pair repaired (doctor iter-013 finding).
- Collected `refactor-3-b-2-redraft-invariant-fix.md` + `refactor-1-b-2-tactical-residue.md` from `task_results/` (archived `logs/iter-014/`); grounding registers + witness probes untouched per standing rule.

# Plan — iter-014 (3_B_2 landed + proved; 1_B_2 destroyed and recovered; endgame objectives written)

## User-silent fallback executed
No prior-iter `## Fallback if no user response` section exists anywhere in the
iter sidecars; no user hints this iteration. Proceeded normally.

## State found (planner re-audit; nothing taken on trust)
- The `3_B_2` refactor lane directive + an in-flight lane already existed in
  `logs/iter-014/` when my session began (started 17:09Z by the loop-side
  earlier plan worker). I monitored rather than re-dispatching; it completed
  17:53Z COMPLETE (2642 s).
- Fresh `lake env lean` audit per affected file this iter (no trust in cached
  verdict strings): `3_B_2` 0/0; `1_A_1` 0/0; `3_A_1`/`3_B_1`/`3_C_4`/`4_A_5`/
  `4_B_6` 0/0; `3_C_2` 0/1; `4_C_7` 0/2; `1_C_1` 2 errors + 2 sorries;
  `2_B_2` 4 errors + 5 sorries; `2_C_2` 1 parse error; `2_C_4` 2 namespace
  errors; `1_B_2` HEAD snapshot 0 errors/6 sorries (wrong variant — see
  incident below).
- Official T1 solution verified first-hand
  (`hf-IPHO2026-upload/.../text/T1_solution.txt` + `T1_problem.txt`): B.2
  computes `E = +ke²/(80a0)`, `eps = sqrt(1 + 4ke²(15 hbar²)/(80a0 m(ke²)²))
  = sqrt(45/4 + 1) = 7/2`, `th' = arccos(-1/eps) = arccos(-2/7) = 106.60 deg`,
  final `th = 90 deg - th' = -16.60 deg`. The algebraic identity
  `arctan(2/sqrt 45)` = that complement checks out (periapsis-referenced acute
  angle = official complement). `eps² = 49/4` is therefore the official value;
  the `67/4` chain was a derivation error in the project's own iter-005 lineage.

## Incident + recovery (the important iter-014 event)
The iter-011 redrafted `1_B_2` elaborated working tree (the gate state:
0 errors / 5 sorries, `49/4` proved, `signed_deflection_certificate`) had
NEVER been committed; it lived only as uncommitted changes on top of HEAD
031fd35 (whose snapshot carries the false `67/4`/`sqrt 63` chain). During my
dispatched refactor lane `1-b-2-tactical-residue`, the lane agent captured
the working diff to `/tmp/b2.diff`, applied its three verified fixes, hit two
further residues, and then ran `git apply -R /tmp/b2.diff`, reverting the
workspace file to HEAD — destroying the elaborated tree and reporting
INCOMPLETE with the recovery recommendation to re-materialize the gate
candidate. The lane's report also validated all four fixes standalone and
named a fourth (L929 `.trans ?_` bullet).
Recovery (planner-direct, this iter): `/tmp/b2.diff` still on disk (36 045
bytes, 670 lines, exactly the 454+/129- elaborated diff including the lane's
own three fixes). Re-applied with `git apply` byte-verbatim, applied the
fourth fix (mechanical one-bullet edit mirroring the adjacent bullet), re-ran:
**0 errors, 3 documented Kepler-bridge sorries** — strictly better than the
iter-013 gate state (the L902 residual sorry cleared by the lane's
`hratio_sq` fix). Two proofs in the patch were already the lane's verified
closes; my sole manual edit was mechanical and tactic-only.

## Decisions made
1. **Re-apply `/tmp/b2.diff` rather than re-dispatch a redraft lane.**
   Chosen over: (a) re-running the refactor lane (its verified fixes were
   already inside the captured diff; a second lane risked another working-tree
   accident); (b) planner reconstruction from the iter-013 713-line baseline
   (would lose the unlogged later steps). Reversal signal: had `git apply`
   conflicted or the re-run shown errors beyond the L929 bullet, dispatch a
   fresh lane with the four verified fixes as the whole directive.
2. **Re-key both blueprint chapters planner-directly** (`3_B_2` official
   derivation; `1_B_2` `49/4` chain + 3 proved-helper entries) rather than
   spinning writer lanes: content is fully determined by the landed Lean and
   the official sources; two chapters, scoped edits. Reversal signal: review
   phase flags a statement mismatch → writer lane next iter.
3. **Seven-lane prover batch ordered compile-broken-first** (`2_C_2`,
   `2_C_4`, `1_C_1`, `2_B_2`, then `4_C_7` re-gate+proof, `3_C_2` single
   sorry, `1_B_2` fine-grained Kepler bridge), all `[prover-mode: physics]`:
   contracts are frozen/faithful; only tactic + genuine proof work remains.
   Reversal signal: any lane reports a false-as-stated goal → immediate
   redraft routing next iter (the `1_B_2` Kepler bridge is explicitly
   graded; stalled steps become their own private-lemma sorries with a
   reported decomposition).
4. **Hand the stage closeout recommendation to the review phase** (close
   autoformalize at 26 passes + residuals `1_B_1`/`4_C_6` after the `4_C_7`
   re-gate verdict) rather than flipping the stage myself: stage transitions
   are review-gated in this loop.

## Graph / coverage actions
- `2_B_2` broken `\cref` pair repaired (only doctor finding this iter).
- `1_B_2` three scan-invisible proved helpers
  (`arctan_poly_squeeze`, `arctan_deg_band`, `signed_deflection_certificate`)
  transcribed with `\label`/`\lean`/`\uses`/proofs — they would have surfaced
  as fresh coverage debt at the next leandag sync; writer lane
  `1-b-2-helper-entries` (215 s, COMPLETE) then normalized the three blocks
  into their natural positions and added the `\uses` edges on both main
  theorems (fidelity spot-check passed).
- `unmatched` live at 42 (39 `1_B_1` + `hello` + 2 `2_C_2` + `PartA1.
  circulation`): unchanged-in-kind deferral per the standing rules recorded
  in task_pending (`1_B_1` tex must never pin `quadratic_pos_of_large`).

## Hazard mitigations recorded
- New ARCHON_MEMORY bullet: refactor/subagent lanes can destroy uncommitted
  working-tree state (`git apply -R`, iter-014); future refactor directives
  must forbid git working-tree mutations outside the two listed one-liners,
  and the loop should snapshot `git diff` before each dispatch.

## Files written this phase
- `.archon/PROGRESS.md` (new objectives + gate ledgers),
  `.archon/task_pending.md`, `.archon/task_done.md` (ledger refresh).
- `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_2.tex` (official derivation),
  `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex` (official chain + helper entries),
  `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_2.tex` (cref repair).
- `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`: `/tmp/b2.diff` re-applied
  (recovery) + one mechanical `.trans (by rw [hangle])` bullet (the lane's
  fourth verified fix). No statement was authored or altered by me.
- `iter/iter-014/objectives.md`, this sidecar; `task_results/` refactor
  reports merged + cleared (archives in `logs/iter-014/`).

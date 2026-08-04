# Iter-014 objectives (as dispatched this phase)

## Landed in-phase

1. **`3_B_2` mandatory redraft** (proof-Review `missing_foundational_bridge`, formalization-gate retry 3/3) — refactor lane `3-b-2-redraft-invariant-fix` (2642 s, COMPLETE): official `dU = dW` sign, quotient invariant `(λ+μ₀KH²)/T²`, endpoint brackets un-swapped; all 3 sorries closed in-lane. Planner re-verified fresh `lake env lean`: 0 errors, 0 warnings, 0 sorries.
2. **Planner-direct blueprint re-key of `3_B_2` chapter** per the refactor report's transcription note (official separated form, integration route, derivative-vanishes-by-substitution bridge, EOS-value sufficiency remark).
3. **`1_B_2` tactical repair** — refactor lane `1-b-2-tactical-residue` (575 s): lane validated all four fixes standalone (`hu0s`/`huvs` `simp [sq_abs]`; `hratio_sq` `rw [div_pow]; field_simp [ha_norm.ne', hu_norm.ne']; exact hL`; L929 `(…).trans (by rw [hangle])`) but destroyed the uncommitted elaborated working tree via `git apply -R` mid-lane (INCOMPLETE). Planner recovered the tree from the lane-captured `/tmp/b2.diff` (byte-verbatim re-apply; contained fixes 1–3) and landed fix 4; fresh `lake env lean`: 0 errors, 3 documented Kepler-bridge sorries.
4. **Planner-direct blueprint re-key of `1_B_2` chapter** (official `49/4` chain; `arctan_poly_squeeze`/`arctan_deg_band`/`signed_deflection_certificate` entries with `\label`/`\lean`/`\uses`), normalized by writer lane `1-b-2-helper-entries` (215 s, COMPLETE): blocks moved into the natural positions, `\uses` edges added to both main theorems, fidelity spot-check passed.
5. **`2_B_2` chapter broken-cref pair** (iter-013 doctor finding) repointed; no remaining `collectedWidth_eq_radius`.

## Written to PROGRESS.md for the next prover round (7 lanes, all `[prover-mode: physics]`, conscious mode check per file)

1. `2_C_2` — parse repair (dangling docstring L182–L188); 0 deliberate sorries to preserve verbatim. First because compile-broken.
2. `2_C_4` — namespace repair (`open Topology Filter`), then 2 asymptotic sorries (`hstep` remainder + `IsEquivalent` assembly).
3. `1_C_1` — 2 tactic errors (L330 stray `ring`, L337 rw-chain) then 2 main-theorem sorries (reachability + `Q(E) ≤ 0` → quadratic minimality).
4. `2_B_2` — 4 tactic errors (Parseval normal-form `have`, abs/sqrt via `sq_abs`, field normalization) then 5 chain sorries; frozen iter-011 two-sided contract.
5. `4_C_7` — re-gate retry 3/3 on the iter-012 frozen contract + fill 2 sorries (Fourier integral → log form; numeric band by rational brackets).
6. `3_C_2` — sole documented `q_relation` sorry (not needed by the target; honest close or bounded residual + golf route).
7. `1_B_2` — fine-grained Kepler-layer bridge, 3 sorries, in-file atomic lemmas, no statement edits; graded progress (isolate any stalled step as its own private lemma-sorry and report the decomposition).

## Explicitly not dispatched
- `1_B_1` — broken build, gate exhausted; frozen iter-005 O1 + iter-006 O2 reopen spec only (TO_USER stands).
- `4_C_6` — provenance-blocked (`raw/E1_solution.pdf` absent in-checkout; TO_USER vendor decision).

## Handed to the review phase
- Re-gate table: `3_B_2` passed (this iter), `4_C_7` pending on its frozen contract (objective lane 5); recommendation: close autoformalize at 26 passes + the two documented residuals and advance to prover.
- `2_B_2` chapter narration drift (one-sided vs two-sided AbsorbedRays prose) recorded for the next writer pass.
- Refactor-lane hazard mitigation logged (`git apply -R` destruction, iter-014): future directives forbid working-tree git mutations; loop should snapshot `git diff` pre-dispatch.
